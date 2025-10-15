Return-Path: <linux-kernel+bounces-854703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC20BDF2AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E84EE4EFFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13832D5950;
	Wed, 15 Oct 2025 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8u2RfSE"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E472D24A9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539907; cv=none; b=oFdL7UMlMUDDG8carZJF1zgOQPZ+c1KHDDKNTT7ZWJvO2zNJ2JYLO9kXQc9Xkme2RZQ88a/cRiyBMVlh3K0ct05j9x4wQvTpXYjupvyqcnMpgV493DiNmEEntqzofmaU4kq0F1PlQTDY13CDosaQ+h1LWzL5eCN+wF16Y035M48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539907; c=relaxed/simple;
	bh=sInZE0DYoIggQMIMtdFf4wFHGPW53+nzyYune9eDHHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rT+nQ8ncuhnT78wa5QMhNDukDUV5hLWBCwl/2q42SSxl2l/JbvtsC+Vac54DswAyz39k1Txb1cC4DFXvAH9TKXWcnh3OLWtWIKeZvV+M3ra06B5dx5YgQ2nxg0uzC4UZqtQCx+x/hASco55E4ZK8nnBeTOpG8nYfq422+zjPD2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8u2RfSE; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7501c24a731so80029707b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539905; x=1761144705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyLoltljIFIHQvuHJEe7loF3nTJT00G7D3T168aMfDU=;
        b=k8u2RfSEaNr8RoGeo9HYEPQpIJFBnMpG3kqp3wbpoF1ou6XOSagtAWS3iST/x8pM9u
         6XJO9ck/ahDaagGlvhfHocSTIxsePCjX8thg4dqV4MMphvmeCGsDD1bGrKiNRTRadz8F
         Q875/eDcIjROAqJY121ywPGLDmvmneyyleiGJHttyRDJZo8CK4p/DmufJWMcXX3cj/V2
         W8nwN8CjLjv8dnwst01+cOtKv5hoQzOhBw852lDjmt5TjQKAGv2vy5MXT+8Bu1Z4uK6I
         U/ytaJfc7zNg5cMjr6EXkzlvCIr7FYM0BFxkNTMNa4dRC7TioI1dnBeNE5rjgoF/Uo3r
         OD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539905; x=1761144705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyLoltljIFIHQvuHJEe7loF3nTJT00G7D3T168aMfDU=;
        b=fNsbCVtg/G4u/Lz5HERwfFEmJl29EXgqpg+I3gJs0M7lVTJocbIa3/5vjJinCmAWzJ
         W+17V3atjA/xy5c3awHKFV3Bn+0WAn/Aq1cgTljgTgOSpEQN+2tMFyOKrY0JvN80BjfQ
         MPmF2ZKJuBpgTAl/+3f0t78eYEl0H0v1oOU5mXunhtqAWuaoQYbfWM5ow2HGeFL5v0VK
         pWf0lg32UV0cnLOqWbAnY6J6UN81qzEtRy8Hp2HOBT3CohkfbIlDNC8ma5I/GIx6J9D4
         9IuW9YdoK6EIt/iTgZHtieWGiHmQcOkoG16IHOsk5dF9q5WAuaJ1gWPDd2Cc9hZUQF8c
         LuMg==
X-Forwarded-Encrypted: i=1; AJvYcCVbmdU24e+HfkUIGGy4ITdUwheTnjQCwubanfEWkzcn+vaNOS17XD7kMZbd0odpmB2IX0ehZIcG6FeggUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzib05vQICNgJCEWHdSMLhxxUNQOEEZd2q3T4q71zFqtE1fJRuQ
	8tWDySU7Coo/SRV7FsRGAq/mKRs1pQeUpWH+9quEzsSCpWgjAIM7pd3m
X-Gm-Gg: ASbGnctT1Yts10qsU3S5p6SkmeS6/Us9vuB4/6EXVj67qZUUArbLlYM0jLZi7vrxj8j
	+fc+plCiDBb8i3N7hvgNzxYCjmGHjUbh1RPwMkWKf6AtCUjeKe+6X/+YX2lgVa7mv/W3krG7/yz
	TpQTvqPH/pG+IVhnPpg8Ml+qs7ugs34mKRxmzeYSzRk+OTe3upTwf3Rl6JmfOcb4bdNzD+bPu5+
	2gSA82Uq9mnpOPZxp9G9RgX++PSU8DtEd1tQOxIrR1irSLWGfbvZHU7erps3LVeApHmOTFZCvau
	PYMhnArl8AUbhrpun2UVYOyV9RF3npHDS42pfvsBiSmi5Wlk8QCrDQem5OeCW+EEjkrMW37cJKp
	O1WJ2HNRDziuzEkL9zzJsNHqge3JTO/BCRrukHLMxc7OS+MrvweXRJpQNfSNFTjfztaL/2hKQka
	iAGyotbnAP
X-Google-Smtp-Source: AGHT+IFdqdeTyqiUO3M8Jt3admfj16X+6I9SKPrlqNLZA1JhYvTo5CcWbZOMzfxfyhV/tM6hbT9L/A==
X-Received: by 2002:a05:690c:360b:b0:735:4c38:34 with SMTP id 00721157ae682-780e153baabmr270617987b3.27.1760539905211;
        Wed, 15 Oct 2025 07:51:45 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78106dbbac6sm42931667b3.3.2025.10.15.07.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:51:44 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: simplify and cleanup pcp locking
Date: Wed, 15 Oct 2025 07:51:42 -0700
Message-ID: <20251015145143.3001503-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015-b4-pcp-lock-cleanup-v1-1-878e0e7dcfb2@suse.cz>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Oct 2025 11:36:09 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> The pcp locking relies on pcp_spin_trylock() which has to be used
> together with pcp_trylock_prepare()/pcp_trylock_finish() to work
> properly on !SMP !RT configs. This is tedious and error-prone.
> 
> We can remove pcp_spin_lock() and underlying pcpu_spin_lock() because we
> don't use it. Afterwards pcpu_spin_unlock() is only used together with
> pcp_spin_trylock(). Therefore we can add the UP_flags parameter to them
> and handle pcp_trylock_prepare()/finish() within them.
> 
> Additionally for the configs where pcp_trylock_prepare() is a no-op (SMP
> || RT) make it pass &UP_flags to a no-op inline function. This ensures
> typechecking and makes the local variable "used" so we can remove the
> __maybe_unused attributes.
> 
> In my compile testing, bloat-o-meter reported no change on SMP config,
> so the compiler is capable of optimizing away the no-ops same as before,
> and we have simplified the code using pcp_spin_trylock().
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Hello Vlastimil, I hope you are doing well!

Thank you for this patch. This is a pattern that I found quite cumbersome,
so this patch really makes the code so much easier to understand and read.

> ---
> based on mm-new
> ---
>  mm/page_alloc.c | 99 +++++++++++++++++++++++----------------------------------
>  1 file changed, 40 insertions(+), 59 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0155a66d7367..2bf707f92d83 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -99,9 +99,12 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
>  /*
>   * On SMP, spin_trylock is sufficient protection.
>   * On PREEMPT_RT, spin_trylock is equivalent on both SMP and UP.
> + * Pass flags to a no-op inline function to typecheck and silence the unused
> + * variable warning.
>   */
> -#define pcp_trylock_prepare(flags)	do { } while (0)
> -#define pcp_trylock_finish(flag)	do { } while (0)
> +static inline void __pcp_trylock_prepare(unsigned long *flags) { }
> +#define pcp_trylock_prepare(flags) __pcp_trylock_prepare(&(flags))
> +#define pcp_trylock_finish(flags)	do { } while (0)
>  #else

I have one question here. I was a bit unsure why we do the typechecking and
silencing for the unused variable warning for only pcp_trylock_prepare, but
not for pcp_trylock_finish. Is it because pcp_trylock_finish will always
be called after pcp_trylock_prepare, so the flag will have been used at
that point? 

I was concerned that there would have been some area where only
pcp_trylock_finish would have been used, but compiling with W=1 seems to show
no errors on my end : -) So it looks good to me! Feel free to add:

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Thank you! I hope you have a great day!
Joshua

