Return-Path: <linux-kernel+bounces-853649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3906FBDC351
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0CE7353A00
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24D1253B58;
	Wed, 15 Oct 2025 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZSmI4oub"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F564A08
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496746; cv=none; b=aJQnVcE7Yh8S8L+clxqqsS9QxnY+wZLPyVTUFyVBC5/9mzrkYmS68wrAFP5zm62v7NYUBaFgGCsCkTWA+vdo3jK8aoGOuzfGHE+gZFbweWV07MgYr1VrOBebm6NaPao1cu8GQDSsGDVGimjlb70eAjexVDIIczIjQIPszNCbq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496746; c=relaxed/simple;
	bh=K+/ZPOBKwjdTE05QHvUsWefozr6Vz5hTwO5+KCvxvDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agpg0DG3zsGVzr3mxPkuAmPWBghajh7QCkoBg1d7aRNlCdmc20FPoJT1ExZZpzfkTHLJlz9O0J40SsDKgUbjjNHlE0F9mYIU3/ShHSgLswUOSTbdLir7jV/SIHCMquUBCZnwfbqjC2Wbz1U03YYp2H3X4az3NZkZh+ZklJcGEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZSmI4oub; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-28e8c5d64d8so56029585ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760496743; x=1761101543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fUiAUARadlxFsHZeOkiKHSqteinQqVu/aka0/V5Wwxc=;
        b=ZSmI4oubFuOgI0x02Hh+dJ7oxAJac5mZeZWIyVdQgFScCMuvTNCMZyhal9UNI0Zz3Y
         DO90ejhEsrYcUB4So7LyhfZzLP65lparFADFbIydTUc/eI6tf/vyBNsT9ij1hBUoP8NW
         BIYKD82MZ2yKuOpmkxhMsEOhllE8y+rZrr/D4HZNEFm2QsV/EQxuDgkUsPef9PHaXOto
         5KLljfVWtTZfjgHam/XFT7E2uS+TbqfNM701W9FShddqKLvE+Ennj+Nl4wz5idvlRgdn
         U4J5O9YIf35A7dDSqMFX5LqPrXC6xBdwPxqisBJGFL9Lk/NB6jmB6G0l5FduTBL1mNXE
         AoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760496743; x=1761101543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUiAUARadlxFsHZeOkiKHSqteinQqVu/aka0/V5Wwxc=;
        b=ISAzT9bjtPgE8b86hHfh1dCLt23gJhHZGMIPXhRqQ8NX0TkgYva2CVCvYd5FHuFN3n
         HTHOOm84FqY4l2UfadaZQ5h7dx5Rf/m8U8NYxC4Zbi1ihq5MJWt+LOeatVpM7SW2L81c
         rA4EnnbA3z3gME8IYA/gM89iy3ubkAZuwGLhvM8tdO8XLO7ZYIJIuyUKtEdwRheIZ7TU
         iFOyLtHNSSod7Bn/Frw4zbSe5LEblGr9TTALIh+61gXzTETvrxIs7xyPe78IrJoWdT94
         99LDN49Ii02kAZK9pk5+VzbtkGVfb23zH3EUrd8cI8elZd7+XZdT7EvPViK+rhCQAfMr
         p9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5ADhnFDeazI7k7g1Abv0MGfBM4LxNJBPwJd503vv6Ixzdb75y2ARV2jNGm3YQexjCiNKK5OyceXrnf4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yKxxHJ0psvVsragEEaDdg2Y+lyVEEbQNebxNZREvouQ370zg
	gSrscCtfcTx47zUOw0XG/RVm5VY/iAENbiDcyPufV3wwRg7w27HGU9wmQJpkfaLfcQ==
X-Gm-Gg: ASbGncv4RQwuH9e6RCVQB7JM56LRiUeMqbBOBSpUsyv8hf5yHt+dU4VF+vySFf33sVw
	1ryqSoiSDL6N05kYpD1SEiAtGt9CeOTdTEHJ4n0wFlgtwr16fFdcm2whwgGIENPOrAkPrxkUNlZ
	oKpE8a+lWkpgYB6mcEOob54v6mREEkQWfdUpw5zmXpD2YJPKQr6i2DKS86aSg9GzhU0hM2vzm27
	1a7E4niefzZ6fWt3vx4J1h+gQfIPJ95fupvNCn6Zn9pNZ5DHCsp4GY7KKqa33h+mnVUuYZPXdWB
	/HZ2EWhlA57eEOpTL6U4qDPnYJDOJyktGMzXYnFs12BGNeY68Q4beM5XBsqdOWvZ5u/0YvZ8KsX
	mkir2RTQbG9lN25r4AOkQm/2s3lH2RuDYOUtTadDFpxNjj3AUH61r1wnR1rzruCUlc/YH
X-Google-Smtp-Source: AGHT+IHyVZ2Oi6ntjnAH7EmJhN3Xx3S5J5hrdtatwJYvHWvnC8v0UiWLLgCU7ggc67doJ4z9H0vFrw==
X-Received: by 2002:a17:903:37d0:b0:28d:1936:ee9a with SMTP id d9443c01a7336-290273ed7c7mr352383745ad.29.1760496743463;
        Tue, 14 Oct 2025 19:52:23 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29084078e2bsm15882565ad.64.2025.10.14.19.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 19:52:22 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:51:54 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
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
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
Message-ID: <20251015025154.GA35@bytedance>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <c4a1bcea-fb00-6f3f-6bf6-d876393190e4@gmail.com>
 <20251014090728.GA41@bytedance>
 <84382429-02c1-12d5-bdf4-23e880246cf3@gmail.com>
 <20251014115018.GC41@bytedance>
 <ded8b9bf-c9bb-8a41-541d-1bef354e4296@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ded8b9bf-c9bb-8a41-541d-1bef354e4296@gmail.com>

On Wed, Oct 15, 2025 at 09:43:20AM +0800, Hao Jia wrote:
... ...
> Yes, I've already hit the cfs_rq->runtime_remaining < 0 condition in
> tg_unthrottle_up().
> 
> This morning, after applying your patch, I still get the same issue.
> However, As before, because cfs_rq->curr isn't NULL,
> check_enqueue_throttle() returns prematurely, preventing the triggering of
> throttle_cfs_rq().
> 
> 
> Some information to share with you.

Can you also share your cgroup setup and related quota setting etc. and
how to trigger it? Thanks.

