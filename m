Return-Path: <linux-kernel+bounces-759974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61878B1E523
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E71516C6DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B04B26B2AC;
	Fri,  8 Aug 2025 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M8iPgaqk"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2826A0A8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643513; cv=none; b=CNSKkTetpv7PSSzNilpCgD7Y2r45l0lp4xxAz8FkCYtISQUb6dpqzlqjdlGPjzOpTMiYN7cA2vfs5nPihHOC6R6cTaBitmSN/kt9+lI4XZM9pfCvTIChmOpZPxVHsBOOksjGBYLH7DR66t5/8mLjHOBjL7lOgBzTU90VFDZkoZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643513; c=relaxed/simple;
	bh=2Cd3py93CGXf5mOUzpOs5vVjwes2SdDigwaiSPyUqF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFc4Ye8PGOibvbpzAMGgC9iNkuikNGwwJO4pwFMXEnv0IoTHFBhaGNjwKDpe+ouKpiWWNyAuU/LlZTO6SAbQY0npWULGANhZ0j46cO5bHrJ0HuGVt4fBYFAmXtH3UVRphMe6VDnulPlRoRcu62AGmipG/iXqvNiGb0ukrzltqIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M8iPgaqk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459e20ec1d9so18153295e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754643510; x=1755248310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lOQVbhQSKupTIDYGcHNIv/5EXRTeGhpJxZzqsjXmSWw=;
        b=M8iPgaqkss+DKH2EQUlU/8ytVM/eCBYItZh2N8kCndZUrKryObgYTLTi0i0Qk6EdBe
         h6Zo4XQ8XBNxAeDTG+GYYOan6VGcnoY7C3p6sDLgiBkImDNJmqY0fcsqFJ1ma7trxMfM
         itf9dcU2rWBcQGTXsFj36ukdfeooZe105uPKYb4Jh1NizP2s0xTX3Rx/CYwOgg/obSeZ
         wEsqDo5Kt/6MzONNlhYxzU3EVZmsFR0BwOzJ8947OH/lHCccLf2N2mu80FaHUjPxNR15
         QfdW1WFtfLhDsxY9Qw6agRDuhW0+Hbm7CPl7pJhy1SYOQ1lEL0U2LZ06A04+LAhtZraC
         VjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643510; x=1755248310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOQVbhQSKupTIDYGcHNIv/5EXRTeGhpJxZzqsjXmSWw=;
        b=HUYyJkF1mX+K26SU6htXzDQwP3xVirU+b8BIWmf8v8+EZiyuERzalW9mmH6SqqzQhj
         p1U7g5TvETUKk6f2T/y6fywWhWz1EzL7Y+ATnLXDmI038xK8eaA0d8UnqPAdDKIwu9xX
         t2BlhBfnPIIxaqnPywFIWt5SpgYy1H/OGfZyyuAbmxfj9QTNZ17PDuSHctz1fd6lx/h7
         aoDMihPUjfYv38Rgh8g4u3VcJkJo1cpLs9ZrMhStW7oN+F6vz4q5gnyE64VGZZK5wW5S
         sDTS7aoU4PSCh3dflO5VBhj9n9rUuFMWLkLm6X6g07z1b88wwnc8R975w6EaCzb7sLzv
         Totg==
X-Forwarded-Encrypted: i=1; AJvYcCUfSLK1afXEYUUexrYGR4eUSFDiF4KUXQT8rBM9Qlfg/FlYaOm3K4acKJhYVxDbfzDZcktIIOaFmtJpF7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRBCT2mDcv0nVZfiTdQFMzxBAqTZlJYzrSoph49beTQaLflrcM
	6fNcIcn/Ktft01Fx6pCQEB+acIT48wjpGR4fLnvPoY9RI/7D016h/bY4l2jiuOYrCOI=
X-Gm-Gg: ASbGncsPoxvPTSdhBue0/J53hj4q6pGczlyXLo0nhzzMekAhMioGqaCVMIBapwn6wTX
	PryNnxyTgGcVO0U4gC9ZOtgaVf2rS1acTXEeHBC2Y4Mz0L1nHGYjnpkrbnMKsxsAAv7UCfuFAIX
	GvRyO/se4pO7Ywarm1jAmwNsN0yqu9z76MkZG7sTxWQ5F9F0erO7NU8wz1bALc6ckNFpAo1NHR+
	gXxngw8SflgblQfzD204Cy5BdzWaG842jdHruV/jbnb4rwhVm6UhbenWkBysIuvExxVKYFlF5aN
	otnUT9CLaQ7Jxy1+zZZqVGyL5jX/7iOMh6xfyHsCkKm3xARCS2aNMLcTFKTZCk5jIiNAfV6B2gE
	r+coJctughD4Aauv8tSKmL0T5ZQbHQ4f1HLY=
X-Google-Smtp-Source: AGHT+IFzVmndy14yZFXdn3AITFDDpuqCDmasSizVoBUj53EPQz0livj4I20cGXLIqIwR20S7zVle5Q==
X-Received: by 2002:a05:600c:190b:b0:459:e048:af42 with SMTP id 5b1f17b1804b1-459f4fac94amr17073275e9.24.1754643509756;
        Fri, 08 Aug 2025 01:58:29 -0700 (PDT)
Received: from localhost (109-81-80-221.rct.o2.cz. [109.81.80.221])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c47ae8esm29556901f8f.61.2025.08.08.01.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:58:29 -0700 (PDT)
Date: Fri, 8 Aug 2025 10:58:28 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>, xu xin <xu.xin16@zte.com.cn>,
	wangfushuai <wangfushuai@baidu.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Adrian Ratiu <adrian.ratiu@collabora.com>, linux-pm@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] freezer: Introduce freeze priority model to
 address process dependency issues
Message-ID: <aJW8NLPxGOOkyCfB@tiehlicka>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
 <aJSpTpB9_jijiO6m@tiehlicka>
 <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>
 <aJWglTo1xpXXEqEM@tiehlicka>
 <ba9c23c4-cd95-4dba-9359-61565195d7be@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba9c23c4-cd95-4dba-9359-61565195d7be@kylinos.cn>

On Fri 08-08-25 15:52:31, Zihuan Zhang wrote:
> 
> 在 2025/8/8 15:00, Michal Hocko 写道:
> > On Fri 08-08-25 09:13:30, Zihuan Zhang wrote:
> > [...]
> > > However, in practice, we’ve observed cases where tasks appear stuck in
> > > uninterruptible sleep (D state) during the freeze phase  — and thus cannot
> > > respond to signals or enter the refrigerator. These tasks are technically
> > > TASK_FREEZABLE, but due to the nature of their sleep state, they don’t
> > > freeze promptly, and may require multiple retry rounds, or cause the entire
> > > suspend to fail.
> > Right, but that is an inherent problem of the freezer implemenatation.
> > It is not really clear to me how priorities or layers improve on that.
> > Could you please elaborate on that?
> 
> Thanks for the follow-up.
> 
> From our observations, we’ve seen processes like Xorg that are in a normal
> state before freezing begins, but enter D state during the freeze window.
> Upon investigation,
> 
> we found that these processes often depend on other user processes (e.g.,
> I/O helpers or system services), and when those dependencies are frozen
> first, the dependent process (like Xorg) gets stuck and can’t be frozen
> itself.

OK, I see.

> This led us to treat such processes as “hard to freeze” tasks — not because
> they’re inherently unfreezable, but because they are more likely to become
> problematic if not frozen early enough.
> 
> So our model works as follows:
>     •    By default, freezer tries to freeze all freezable tasks in each
> round.
>     •    With our approach, we only attempt to freeze tasks whose
> freeze_priority is less than or equal to the current round number.
>     •    This ensures that higher-priority (i.e., harder-to-freeze) tasks
> are attempted earlier, increasing the chance that they freeze before being
> blocked by others.
> 
> Since we cannot know in advance which tasks will be difficult to freeze, we
> use heuristics:
>     •    Any task that causes freeze failure or is found in D state during
> the freeze window is treated as hard-to-freeze in the next attempt and its
> priority is increased.
>     •    Additionally, users can manually raise/reduce the freeze priority
> of known problematic tasks via an exposed sysfs interface, giving them
> fine-grained control.

This would have been a very useful information for the changelog so that
we can understand what you are trying to achieve.

> This doesn’t change the fundamental logic of the freezer — it still retries
> until all tasks are frozen — but by adjusting the traversal order,
> 
>  we’ve observed significantly fewer retries and more reliable success in
> scenarios where these D state transitions occur.
 
OK, I believe I do understand what you are trying to achieve but I am
not conviced this is a robust way to deal with the problem. This all
seems highly timing specific that might work in very specific usecase
but you are essentially trying to fight tiny race windows with a very
probabilitistic interface.

Also the interface seems to be really coarse grained and it can easily
turn out insufficient for other usecases while it is not entirely clear
to me how this could be extended for those.

I believe it would be more useful to find sources of those freezer
blockers and try to address those. Making more blocked tasks
__set_task_frozen compatible sounds like a general improvement in
itself.

Thanks
-- 
Michal Hocko
SUSE Labs

