Return-Path: <linux-kernel+bounces-808662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E988DB502FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683D517C53A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE2235337F;
	Tue,  9 Sep 2025 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q3v0XNK9"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F83568E0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436290; cv=none; b=VGP+wu5RvZxO/9LG/1VU0+IUA+70Lg5LBU1KBnijzSGEVSuY94+rKCo8SQwtyKpNkOR/RLSc6FBHLK2LstbhasOQom82js27qRxF2zL1QG0Gaq4wLLFrCOrfh5iJd2KppQsGv6TpF8LeKB0I/e5yowO52YJEJGO2GECZ3Wfcx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436290; c=relaxed/simple;
	bh=crjz8IuTMvnuAst3XpK5ykzknRWc+hiwRiocj24vF8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQYR9g+H5D2nHuB3ssBVvV/jO1Qws3LluttSsPvqBJiBvjzrjH4cDLwegepfSSvM+/hm/MsdKnq6DqCzN9hhwzppr1PLr+wJ1IBXKBZ0pym8EwJW6w/FQ/rcdbsLBRKwu8X0x0x5cRreK38M6APTzODuV7oGMzbUd2iiJRj/UnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q3v0XNK9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ace3baso1009759766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757436286; x=1758041086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wCW/MpT2vQ9C50MIPfrp6np6huywdbRHgHAuQqK4bT4=;
        b=Q3v0XNK9v/FOuMPLyhTJq0ey0j0J14GzUcwdF171u9blvRG7KDdv69DB9AuzK6AR04
         a2916dzhZoe+oN5zdEiVkRN1R2MTTTGCKcF/53aettVHZGzpRIQxB7pK+jZTfLlDAMEg
         H0Xf08LtrK4Lv4RoJvVHoPspEXvTHzWnqNb5QKsUOsaRx3rKcSa/fiqFWrh1BVIBWrtW
         1JP3sMDKLgNQbZRuSwfwNp9uq4TqDcV+0lXNLQ1fg2zpWYszzS306r+U1aaCR7mvM0Tu
         92J5h9XlO2GFNDZN7W9kHf0UGRm6QOgMN50YXp5W9TM+r4PyskeSUwGcqtcWYxXKVOHn
         72NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436287; x=1758041087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCW/MpT2vQ9C50MIPfrp6np6huywdbRHgHAuQqK4bT4=;
        b=OirZBHGAql8hXKYtuur1choq/XoKMh/y6hbYQg+PLMX8oJIvQcbx5zx3KbksG7Hvms
         7TzCMufOFqNtOo2EH2CuvztiotjA/kzZ6jq9+kbzT70U5ivWv4J4KM6fH40XWvja0QVX
         mLWkwrcYi4l2b8NGjnpWvmzjgqUgeTlThesFvwK0XsusGvmRyARr5r17e6y1O4lAqKi3
         yMGOWHRwbtez9bbn8dVBp3RME5jMzyHzlIOxwc293o5f8GtYFg+HsMdFwy1fDE5wv55g
         vS6o0idymjf/pFQNtUbFseQKHJaXkondKZ+x0rs7mlXiy7ZXJ5IEEdmbtnpiEaNjhPVh
         D3gw==
X-Forwarded-Encrypted: i=1; AJvYcCV2YyUcb2nNpm89YvsX+LWLL0+umjKjIFCRTfSI11ay1zUKEqS7rN722j3ubRWpjUTKyGCUTJA05FW/gYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVGq/tdxZcHQjW0XfO7dugFIXZmA5iqwxAwH7Zz2NF2Dae5ig2
	LIVCnZ0KsE14ZnXC/5feewp4WO6GQVEAYSxgsBdP4+lj0DutxwNJK1tCQ0Yw2iQpx3k=
X-Gm-Gg: ASbGncueDcgtBiQJw/ioz4xaLIYUzf36wxKwO+aXv5qXKGPBUyvZggM3oKxxKccgp4N
	+YD6OTb8j/AnWLRtLvCQLlMmhTZ54948YRDxB8aCgNayMUfrZdxxTdbbsLiua75dMXG9I8/cQkg
	aRIkUI8z9thys8f/bocyRw/PiamvEcF4xikJcDKFLEZHoAOsTQdw2JzXTo3M0Y2k4U5NH5Z46pc
	CcgYqu1dq/5WCCbwjalNuMM25ocDe+oB7l6GS2EgW06a8chtN0YkSkg/ogqtuXrjV8L58n5/YO7
	jW57B3QcnbEU5325aU97uMXnzmzmUoNK/f7vMlw1OUtr6A3yF7R3AkN243Q4NggHlcrCm921e5y
	roloUV0l63QF7yjaihhZebPJ1B81EgdDjiE2qgm63UuHs
X-Google-Smtp-Source: AGHT+IHEqPGu01fBLkHalrq5g2/LgoDfcb+GW1hxVNwE/Xt1vQY2NUkE1HZsTFp64+X7RC6+sFL+Pw==
X-Received: by 2002:a17:907:3f9d:b0:aff:16eb:8b09 with SMTP id a640c23a62f3a-b04b13cf9c8mr1203677366b.5.1757436286539;
        Tue, 09 Sep 2025 09:44:46 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07830ac12asm18292866b.38.2025.09.09.09.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:44:46 -0700 (PDT)
Date: Tue, 9 Sep 2025 18:44:45 +0200
From: Michal Hocko <mhocko@suse.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: zhongjinji <zhongjinji@honor.com>, rientjes@google.com,
	shakeel.butt@linux.dev, akpm@linux-foundation.org,
	tglx@linutronix.de, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, lenb@kernel.org, rafael@kernel.org,
	pavel@kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, liulu.liu@honor.com,
	feng.han@honor.com
Subject: Re: [PATCH v8 1/3] mm/oom_kill: Introduce thaw_oom_process() for
 thawing OOM victims
Message-ID: <aMBZfYUN9qtcXXtL@tiehlicka>
References: <20250909090659.26400-1-zhongjinji@honor.com>
 <20250909090659.26400-2-zhongjinji@honor.com>
 <aL_wLqsy7nzP_bRF@tiehlicka>
 <CAJuCfpFCARoMJ8eniYdZ3hSaM_E3GvfRBV1VD1OohOfJpP87Hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFCARoMJ8eniYdZ3hSaM_E3GvfRBV1VD1OohOfJpP87Hg@mail.gmail.com>

On Tue 09-09-25 09:27:54, Suren Baghdasaryan wrote:
> On Tue, Sep 9, 2025 at 2:15 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 09-09-25 17:06:57, zhongjinji wrote:
> > > OOM killer is a mechanism that selects and kills processes when the system
> > > runs out of memory to reclaim resources and keep the system stable.
> > > However, the oom victim cannot terminate on its own when it is frozen,
> > > because __thaw_task() only thaws one thread of the victim, while
> > > the other threads remain in the frozen state.
> > >
> > > Since __thaw_task did not fully thaw the OOM victim for self-termination,
> > > introduce thaw_oom_process() to properly thaw OOM victims.
> >
> > You will need s@thaw_oom_process@thaw_processes@
> 
> Do you suggest renaming thaw_oom_process() into thaw_processes()
> (s/thaw_oom_process/thaw_processes)? If so, I don't think that's a
> better name considering the function sets TIF_MEMDIE flag. From that
> perspective less generic thaw_oom_process() seems appropriate, no?

Please see the discussion for the patch 2.
TL;DR yes rename and drop TIF_MEMDIE part and update freezer to check
tsk_is_oom_victim rather than TIF_MEMDIE.

-- 
Michal Hocko
SUSE Labs

