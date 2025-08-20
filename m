Return-Path: <linux-kernel+bounces-778080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F41CFB2E116
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630331CC0CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DAE326D65;
	Wed, 20 Aug 2025 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0ZT3Kg/"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3122E8B81
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703103; cv=none; b=L/qCuJ/CqUrYie2KdMUQZ+tMADzNDrrXreiaTEygVnNqsA9V7xUwTYuneSI3xcR5MvmcydTgqQbzSiSzLDtX1mRquCio8+ODblVI9/26XuAW9XC4j81epAkgX/mUy+QKdLdA/s2Pd7PEZZz9EI+PA7Gi7wiulI96vy/qfe5wrTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703103; c=relaxed/simple;
	bh=qwPsPTM8WlwGFiDbctFXgyFHEGMT8plEXNlTvpFmReU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZzsxLB5/lRVeIul8VDvE5hhnpYbyj98TjkN0blEXL77apFYTRQkTe6YSfVA0GlaY/ZoGRqHYPEI6sinacNkrQ4gjlonm+ke3z1NDKOtSQrXeIxpjr/Hjq/wIrPHGr23C/AzSsMvbypQtZAdKeLvXTFZ5FHRBomScUU7MuLQ0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0ZT3Kg/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso62933b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755703101; x=1756307901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ty3H5LpYYQe55Omh3bc9eQO+HNHqwIPoC9AB7VslUMs=;
        b=G0ZT3Kg/fVVmuPKDub/AuVVoZ4d2ag5ieRdzY7T4sGOHygZQQoVM9IirGjjNCbfCjH
         jDuwytznsgR/CmNIj0eWMVzmrfhn67qtBmu1lwFkyl+PUHmM4eoUAsWIIaLdg5KR2CzM
         qXP8l/C97xaxDQhqXozgiooLEkTwLW7zSwW/RwttsbIodDbCgPH9yv6eNd1hBF1JY09O
         QxX1il8n813NcuQNiSb7c+895oKoazI5kWZ5aKnQnFlxDhrq7by8gQEcdZ00Rwu3qHc7
         wWk6Ow1q/Vzs7c6gU+4+kkdIs2PhlVWqJRv8DWmdNZT43B1dm7JbpbtPITzHwvkeoyVy
         GCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703101; x=1756307901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ty3H5LpYYQe55Omh3bc9eQO+HNHqwIPoC9AB7VslUMs=;
        b=mos2ZcPduCSGBNzpHxx6TSmQDgIAC8BgH/yJIKVkRfLPUG/baMLd7kT8QaVoLh/lTZ
         g9uAY8b6DrFQbY801WkeJy5ZrQqjDp/ym4OS+otHGSSWeP+xFRSV06797Ch/sXTYWrLA
         kvPBEifg0tOFeLKPioW5CAGdpb4anY0p+O0ZiacRyc1cR/QOjG5t9d/OYDJPJCWbhZs7
         tNCYXOFItVk9mTemJxisk063zzNFn43HXz+kmA+kyGZQxUMPg8fuoZt3JPUHB0IQYnpM
         q5PnQMRm3kRFkBIusOkRs33GWF0Sf6Rya7osrpTgH2CvjsYQ+sEiBFKMxAYdKA7G8s9G
         3Fgw==
X-Forwarded-Encrypted: i=1; AJvYcCW86V1ssTtnoNpfqZICKLqV82Yyng/OuLtX1rKJUnefR++6TIOCw3Y2vqacMPUUP+Il7WfvGmznSAJZfCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZMh8+wppzM0IF8LPMXYKZDr85mce+XmTbfBwOs8c3DaCU7AII
	Bn2pM+QmDMJwjLNIIQN0tqIkdtuBkZCYjrF8y8NM6ThXN1DjaU3DoizRFKgV4Q==
X-Gm-Gg: ASbGncuFmIVBBUB1By/oL3qW1XB3k4YeInQoESQ8ZpvgIfiZwdamsolUtHjWjh9FrBT
	qRD6WLG1UE5RyoYc5QEm6g+IfWfeiQ2KteJs2HDALzQqpcIs2R4lBThMkAfVm2MMQ/MpNjVVNmy
	TvXFuJTSWld7CoPfUe+fLoqdMLFW1s/OtqH6ln7gwX7Z8YcnjP/NDT1T6zM3JH7TSfrk0/D+FBq
	dRS26aPqpN+ey3mcqW5Febr7S2OZi8lhXYyew4v32WoCLbNY5/xvQ63s9bqbnlusI5UAh3wC91y
	j8rGfbUrfgfG58gix28FRHptVp1t0xircUus93xZtUN7BfpebWdO3E/FkH6vf7nrGL6hx3vYufs
	sdWOC0/rofkVzRSBOhc1onA==
X-Google-Smtp-Source: AGHT+IH76XkNiVLaLEgv5FvV1Eh1Z7rH7YQS+AyP44/drZrdGquJfdOLJa2l0oZsGG4SxPENIZj9Lw==
X-Received: by 2002:a05:6a00:3a1d:b0:76c:1c69:111c with SMTP id d2e1a72fcca58-76e8dc86466mr3961320b3a.9.1755703100811;
        Wed, 20 Aug 2025 08:18:20 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0df00dsm5623648b3a.13.2025.08.20.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:18:19 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:18:17 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: pmladek@suse.com, akpm@linux-foundation.org,
	Douglas Anderson <dianders@chromium.org>,
	Ingo Molnar <mingo@kernel.org>, Li Huafei <lihuafei1@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com,
	joel.granados@kernel.org, john.ogness@linutronix.de,
	namcao@linutronix.de, sravankumarlpu@gmail.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 9/9] watchdog: skip checks when panic is in progress
Message-ID: <aKXnOTq9ZYeVYqH5@yury>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <20250820091702.512524-5-wangjinchao600@gmail.com>
 <20250820091702.512524-6-wangjinchao600@gmail.com>
 <20250820091702.512524-7-wangjinchao600@gmail.com>
 <20250820091702.512524-8-wangjinchao600@gmail.com>
 <20250820091702.512524-9-wangjinchao600@gmail.com>
 <20250820091702.512524-10-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820091702.512524-10-wangjinchao600@gmail.com>

On Wed, Aug 20, 2025 at 05:14:54PM +0800, Jinchao Wang wrote:
> Both watchdog_buddy_check_hardlockup() and
> watchdog_overflow_callback() may trigger
> during a panic. This can lead to recursive
> panic handling.
> 
> Add panic_in_progress() checks so watchdog
> activity is skipped once a panic has begun.
> 
> This prevents recursive panic and keeps the
> panic path more reliable.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  kernel/watchdog_buddy.c | 5 +++++
>  kernel/watchdog_perf.c  | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/kernel/watchdog_buddy.c b/kernel/watchdog_buddy.c
> index ee754d767c21..79a85623028c 100644
> --- a/kernel/watchdog_buddy.c
> +++ b/kernel/watchdog_buddy.c
> @@ -93,6 +93,11 @@ void watchdog_buddy_check_hardlockup(int hrtimer_interrupts)
>  	 */
>  	if (hrtimer_interrupts % 3 != 0)
>  		return;
> +	/*
> +	 * pass the buddy check if a panic is in process
> +	 */
> +	if (panic_in_progress())
> +		return;
>  
>  	/* check for a hardlockup on the next CPU */
>  	next_cpu = watchdog_next_cpu(smp_processor_id());
> diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
> index 9c58f5b4381d..7641de750ca5 100644
> --- a/kernel/watchdog_perf.c
> +++ b/kernel/watchdog_perf.c
> @@ -12,6 +12,7 @@
>  
>  #define pr_fmt(fmt) "NMI watchdog: " fmt
>  
> +#include <linux/panic.h>
>  #include <linux/nmi.h>
>  #include <linux/atomic.h>
>  #include <linux/module.h>
> @@ -110,6 +111,8 @@ static void watchdog_overflow_callback(struct perf_event *event,
>  
>  	if (!watchdog_check_timestamp())
>  		return;
> +	if (panic_in_progress())
> +		return;

It looks like watchdog_check_timestamp() does some real work, like
updates last_timestamp and so on. Under the panic condition all this
may be unreliable, right?

Maybe it's worth to make panic_in_progress() the first check in the
chain?

With that,

Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

>  
>  	watchdog_hardlockup_check(smp_processor_id(), regs);
>  }
> -- 
> 2.43.0

