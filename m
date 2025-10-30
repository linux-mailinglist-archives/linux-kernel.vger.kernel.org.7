Return-Path: <linux-kernel+bounces-877580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 079D3C1E7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CE7188B437
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947DC246333;
	Thu, 30 Oct 2025 06:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ep6ayQcU"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE578238171
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804120; cv=none; b=JPH+Q/vPZ5FKvHbmnIEIgXpdoQvfiWuznrM4y+0UaBIuhHs4qnF87Z9D20GgLLsuT4ITpHNVb9uVXPlFVtF9HgfstXGkSUyQP8ssCMeekXdN7ItbcDrev+kpXP7J2xbHhP4jobHRe1/wz57zex7mYkK81OtjKPgYWmTXHhXbKdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804120; c=relaxed/simple;
	bh=hc1OGBwNV4Ft53Jf3/gg3JnA7QiBQaIQ45+ftqLnC7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV/cNuJbKvLPAB4KLTUCLjA1oFv5Uw3OE/8WMuqq5VibdIXx1E//c+73FiOghK97Zp5iHuR4x8rqMuIjmMpXt9DMFlCCWjJ9IjLEEix2mmUm0voBsKZMPvOra9YwWGip3Qlya6r9seoOXaM4+7qz3In+YWn/tptkCowHT/GvYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ep6ayQcU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32ec291a325so562229a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761804116; x=1762408916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4XUKBnuuklOpRTnbxfs9mYcU8lU6fPC2Q6jqLbhND4=;
        b=Ep6ayQcU6lTPwBS4BDoovUrmr1CetzQMyGsM/fP+xwwk7FObt0lfnM5g5Tvs60RUVC
         /DaccKZJd83IzGPJJJHVAw1YzKBqlmLgjFM4bYNZYQut5YmVRhfdTBDJhuTqhpIXWlKS
         9iLAkrGu/GcBpkiUEOrmFOr7a7IFaeXImxTDS9fG4UJ7dZVQTknZhRPkzTzNGdUVga8I
         TQW5HaXuhYEaxWsPAksD8EbBCyNmI113JFLHIQ8HKx/W9Rx5EBAEdqdZUXb5EpIrIFgV
         a8030tJR3cNNuB5ywWWqFDd7ETXHHgxGZqGGeqoADG+jMDbcdYY32tYNWzjElXPG2ACM
         8NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761804116; x=1762408916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4XUKBnuuklOpRTnbxfs9mYcU8lU6fPC2Q6jqLbhND4=;
        b=gW9bX/v4WY4Edxg4klKPQxd4TNeDXIXaYGcbSucDZrSX1hnxnhdzwuWBEgtlAVOai0
         p1pBUVDWq3YFMVbnOyGmzWpddZ0Hfz5InIU6jNP994hhKxTiM/sEfOOIxSi1IboJ1kxY
         aFKwnONPnQD/MtR3OY6KDo69qISfJIlIl52FeyK6td0GVWabpbpW04gIBpjtJZceH5Wb
         6NVWBGVlrs5ySp7b2idkSY5URthq2cz5E8AE+q4I8yfwkgYLNSaFTxw95ZGxLIoxxPnO
         Nb1X2zEM2dIb62g+cT2JBR5+k/s7fkwY4LJtMum824rNjzc+LP74djNvMzHTe6tPvDuY
         hG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqZ/5czv9MERLG9b1HflFLB/wBYQib3Ge3Yn1f0DyY6ji02QlFabGYcKrRGyGl/ABXtitDpGukbbaAuH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmnMcmyKT+wDMzaFaOzf+5RR80JrN6CceLP+N2B2+p8sSs6zPX
	dvwz7TnUCj4SpnZoRinmHXWkJ7aDe5WDPdaCxKaSPox+ytzjxli3SwyFoHT5J3LeVQ==
X-Gm-Gg: ASbGncvnG/XDE/ZFTyelM/FTYUadfXFbQlqbgoCMl/3oWEZczfQ6+PBHHIiR8B9sqtW
	IQS8aZNyElBxLPJzsptqP/qMSpHTSXiEodfU1PUaBwvIOs2iVp8vW3oN9x0LNEK6tHM0GdMFm1Q
	IxvGtRqIMqHHKGQSFMPDGefX4wgY4iBiaDVjvG+ogruetac1/8OTIgJ9XpdKyVRcj2Bi78TB8lH
	7nOXPcPlFSeBJU8zjECYuebIj2Cr5qVaAa7XEGx0FpKh4F/ZcpFmttRBqOoCobIoWf20kneTty1
	G4JO/7kdWJoi974ndnyEnzCID6BQtRgeGdRjUw6ZP1Ule8aZeJ+l/lc3PizSh+NX/JDRqlglAIF
	KxhzNZtw/KrzqKOdCs6gSmR6kY6dpLvYAPRj7nMkp1NrI/sydrdYiMcSfrPSx5bro9gm8J6gFb2
	3WHgzcm6W2ik2IXlJRL+QT
X-Google-Smtp-Source: AGHT+IE1R4BXGYn58X58hiqCF8GP/tUK18GAi+iSq1oPeClcmGt3oVBtyRj+qAxLDXqjCr8e9RFNnQ==
X-Received: by 2002:a17:90b:55c3:b0:327:f216:4360 with SMTP id 98e67ed59e1d1-3403a25a8d7mr6973088a91.8.1761804115723;
        Wed, 29 Oct 2025 23:01:55 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712ce3a6efsm15420474a12.24.2025.10.29.23.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 23:01:55 -0700 (PDT)
Date: Thu, 30 Oct 2025 14:01:43 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ben Segall <bsegall@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Hao Jia <jiahao.kernel@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
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
Subject: Re: [PATCH v3] sched/fair: Prevent cfs_rq from being unthrottled
 with zero runtime_remaining
Message-ID: <20251030060143.GE33@bytedance>
References: <20251030032755.560-1-ziqianlu@bytedance.com>
 <0d1f5a59-82b5-494f-b3d3-6332027d0350@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d1f5a59-82b5-494f-b3d3-6332027d0350@amd.com>

On Thu, Oct 30, 2025 at 11:16:36AM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 10/30/2025 8:57 AM, Aaron Lu wrote:
> > I think it's a chaos to trigger throttle on unthrottle path, the status
> > of a being unthrottled cfs_rq can be in a mixed state in the end, so fix
> > this by granting 1ns to cfs_rq in tg_set_cfs_bandwidth(). This ensures
> > cfs_rq_c has a positive runtime_remaining when initialized as unthrottled
> > and cannot enter tg_unthrottle_up() with zero runtime_remaining.
> > 
> > Also, update outdated comments in tg_throttle_down() since
> > unthrottle_cfs_rq() is no longer called with zero runtime_remaining.
> > While at it, remove a redundant assignment to se in tg_throttle_down().
> > 
> > Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
> > Suggested-by: Benjamin Segall <bsegall@google.com>
> > Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> 
> Have been stress testing this on my system and I haven't seen
> any splats yet. Feel free to include:
> 
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thank you Prateek!

