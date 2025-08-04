Return-Path: <linux-kernel+bounces-755056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884B6B1A0B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A8816B23D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C29323D294;
	Mon,  4 Aug 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O8Gq7wYQ"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A576134BD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754308114; cv=none; b=T14ZpwDpp2sZ4iihkenn07wTbx3Mp+IN4FeLG0tCaK92xDhZ4LAwTftVtYCCX7ISHiTUX1Mq/gfRdI/XvZO4njySvh2knZdQxOvYFc2IKBqWFkfc1qWq1vc4l4ZY8PcATvamkn6QHPBDWmXyygPLemAGZKw3wlQKtyVgKEO8Jkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754308114; c=relaxed/simple;
	bh=mn9qqMH3yuVxWK3x3VoIY4UpC0USKN8oCdlDmVNPI5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUpTNmnPoa+tFCGrSKDXVRTxPJgqs+Ai5oqPJ3UHhRUQhtX6G9INZi3wFfcMJohND0bsr7hzPXx/NnahVwgtFl39GqOsk1D8ugJ5e8IM5b/7QabLP3LPHwfqoGsDO5w7bxG/QjYfhKFm6JilsHg0paVG/WrzMu9dFl0Sl+HspXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O8Gq7wYQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so2728145a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754308112; x=1754912912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bElhVu0hWu9rampyiG6tEtA2n7EnfvEonOtGBZq5JTU=;
        b=O8Gq7wYQ8uCnGpBcTDfono1LE3sJ5EVA5Kl/oogqlI+9QmnBj/9D/NPvKu+o4vMFHy
         vwdX++fxxQC5HsAPO8jgrn6sgY6juiKAxy1PHpH7qss+c9WMFXNRs6P609/sZBDmsRcI
         YzegIlYWNzawGe4yWX9e12cYqzZ6Qdp3hMc5HUAET4yVZ9a8x+Xepv89SMC9Vx5BZFED
         lhRCBcugPcsnJFLKD+V5uyMH3eOTj8WOey92fUhOCZcVyaHmcR9DM5SD2v36B9p7HfBG
         YyvYl2gWl9OxxSeRjVtMQdjd8+5yI6cggCi/jNyaC8ET0s3jjOEcDvERPEUIi63Stqcj
         /Vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754308112; x=1754912912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bElhVu0hWu9rampyiG6tEtA2n7EnfvEonOtGBZq5JTU=;
        b=KDuDQ97FrPQfO0Ii7oFOz9BAUWvcLHJ9CPE9VLmYuIRoZpC+1LckJKj4ojcBzkXHEx
         QoJmu/SnOY4AzQci4Cr0O62Wy1nycDJ9cqRfFZp+rKWDYuFSrQvX9B7F2TPYaFu9xyIw
         +tZwbQhWWx+wL9Lg0Hy8IS+pdVPp79IRK2RyDNDG12fZ3DV7khzw9834f9IRfOom8dDq
         o3EzAnZ1Qe18CTtjnq5i+Sq/lUUJDVX4p6zaC5CieniEaBjaCBisKdyPiXM0cEBq3i6N
         ixev139X0Kdckz7oPNua2WNR/8xbCF7wgB2wyf7xFJrY7Wfctqg0LZ4NEoQcUYfI38gp
         hfpw==
X-Forwarded-Encrypted: i=1; AJvYcCVloCYlY3dzGQF3tOC2IyCoMJaL6BJAFv2WaubiElErSIJ5/orKVXaX7h1trVFOoxR/EvTHp+Ofg2Upwtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTj/FDw6lL4ZIgjVnJNHvOudd/bfqEmw9gtgN2xYV0rVGcWQWk
	UHzZg9zBX5auvHAzcNH98Xnq+tFsKPrERk0K/RplxruHQemKsjCSGvDcfKonZuwh8w==
X-Gm-Gg: ASbGnctxRjQyJ9epnMJWy3Tqnar5Y+5Fk5MoAbxpJMphH9zZlnR8Sckp2pSt3b6+Xs3
	IhfzhK+LYojSk36k8BYdVYQWevEPovgEGugStjdTBeU5Umrj6GXvaRAjfX71zVBh50xkZ4yTMKA
	QcDddpPk1FnbEoiqpuoQduMjWIu/q3kkTo6j6Bu78LusmybyZzY4k5Pe16eXS7R1vDjN7Nu7Sqj
	uTGw8by9oaR64AXASpD0TsTMHwTO8yksf3xiPXrEwSTlHwxfSVzCXW8lWcWgKt8QgSSUYEzbl0q
	9gyWnMSpsV0zTWVm8FH9+hyVFJnxcDQAzLBr7+UPj2WqBRLWWSV1C2Lw/OOh9GLDXhwY0PzUk3q
	GbVg6JNpmOYnNvMinE9ch9neXQgsyQss/OwVGktGQcas=
X-Google-Smtp-Source: AGHT+IHZJCQbPYeqjIDeyPaVPidpYImKffGcpJCtQnulawaZU37F9o1L/44ACBbpVU8WWoc6lEPkoA==
X-Received: by 2002:a17:90b:3e8a:b0:321:3715:993 with SMTP id 98e67ed59e1d1-32137150ad5mr5453988a91.14.1754308111804;
        Mon, 04 Aug 2025 04:48:31 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bae8c52sm8915897a12.48.2025.08.04.04.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:48:31 -0700 (PDT)
Date: Mon, 4 Aug 2025 19:48:22 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 0/5] Defer throttle when task exits to user
Message-ID: <20250804114822.GB496@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <5c79fc39-2a68-4b6b-ba4b-73f6a0f4a30d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c79fc39-2a68-4b6b-ba4b-73f6a0f4a30d@amd.com>

On Mon, Aug 04, 2025 at 02:21:30PM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 7/15/2025 12:46 PM, Aaron Lu wrote:
> > v3:
> > - Keep throttled cfs_rq's PELT clock running as long as it still has
> >   entity queued, suggested by Benjamin Segall. I've folded this change
> >   into patch3;
> > - Rebased on top of tip/sched/core, commit 2885daf47081
> >   ("lib/smp_processor_id: Make migration check unconditional of SMP").
> > 
> > Hi Prateek,
> > I've kept your tested-by tag(Thanks!) for v2 since I believe this pelt
> > clock change should not affect things much, but let me know if you don't
> > think that is appropriate.
> 
> I've officially tested this series so it should be fine :)

Good to hear this :)

> 
> In addition to Jan's test, I also did some sanity test looking at PELT
> and everything looks good for the simplest case - once busy loop inside
> a cgroup that gets throttled. The per-task throttling behavior is
> identical to the current behavior for this simplest case.
> 
> If I find time, I'll look into nested hierarchies with wakeups to see
> if I can spot anything odd there. I don't really have a good control
> setup to compare against here but so far I haven't found anything odd
> and it works as intended.
> 

Thanks for all these tests.

Best regards,
Aaron

> > 
> > Tests I've done:
> > - Jan's rt deadlock reproducer[1]. Without this series, I saw rcu-stalls
> >   within 2 minutes and with this series, I do not see rcu-stalls after
> >   10 minutes.
> > - A stress test that creates a lot of pressure on fork/exit path and
> >   cgroup_threadgroup_rwsem. Without this series, the test will cause
> >   task hung in about 5 minutes and with this series, no problem found
> >   after several hours. Songtang wrote this test script and I've used it
> >   to verify the patches, thanks Songtang.
> 
> I just noticed this script. I'll give this a spin too when I test
> nested hierarchies.
> 
> -- 
> Thanks and Regards,
> Prateek

