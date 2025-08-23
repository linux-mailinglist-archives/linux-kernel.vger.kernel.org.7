Return-Path: <linux-kernel+bounces-782866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AC7B32629
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C5CA0536B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A1B19CCEC;
	Sat, 23 Aug 2025 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beGOdJ79"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B118FDDB
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911646; cv=none; b=sD+yqbpBFj32+vcN5Zely5SsjMmMY42xMqH07EU+zizku9wx+r0Azva/0GYedWCMEcoFcTKzt6iIGCpMvE3segW+k/ZDIERgDW15QvzacUA9ZoPh8ejQC8CciJGcSNyr8VgDcTz1dndZYwsddv45K9NLnjYhXOI0mSFoJ8q/t20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911646; c=relaxed/simple;
	bh=YfOjR7UvaZ9De8gsdS8Su04B4dDcI7rLzFDfiwGqOhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOYg/UmkgUiKj74FRBDaV2gd92yUYdPjEvZCBO/RWETVjQWr3LDmpdRCxT849KhuiUDOF4rfJLNx4SH1p9pry3M24Rra3hTNcfN7vPN7TKltjkZsbbYfpvg3kzo2fvZfYsrxUuMJzKyu+xRvosKxmO829VPU2yRvKE8kUjYVymE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beGOdJ79; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea79219so3271108b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755911644; x=1756516444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fy9Bs8rrSIcWnwkTqkxwoQvPQ5jLwYik1L1rP59aq20=;
        b=beGOdJ79isfLmDblCPiXvBBsws4FjT8IjztWZRV25weCNQiyAjfmcHnC5iieZYXA3/
         h81sL78Em2RgISTpkEo1KtC6/+fU2q1oH/QY0o8baFz8M4eEIhlO/dF+uI87H3nFB2oZ
         emZnbD8f9WgslPV2uji9sa3a6nU3VkjWvR8uDp+qEsUHfP/7Uym80SBJKLUv2QbS7Mql
         Ucy5yL4d83v+T6Sn1NZWpz6v5uWzHdYuYtcR8q+edAEkQsVbWTbU1Ibd1zaW14/uS2tu
         wBtIiRY3jJlgQ/g8v8nDPK4nE+JJtLP2fq0UbkctH0PopodUagfJub6AmLEjDK22di1J
         CG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755911644; x=1756516444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fy9Bs8rrSIcWnwkTqkxwoQvPQ5jLwYik1L1rP59aq20=;
        b=O6lTPZ7u9Vo7InLuX0CfwypNaj9ZvIl4oyV1/oIxKyjdLZaGgVDnQp4FPzikFloIoF
         uTXWlwxTQJZ9Kf+4xmhtyig43lVxZ3NdFNJLHWZWlvOSSmkGO2k5MsXwzy/hsUZ2oc/j
         1IGQAHe3/mYjuJ4rGSvED9GSJlh5TWWO5tCslI5PdowUNkFLk7PH0fIo3foAxaFSXaOT
         qHHmHGjYZJKShd7qbD26TWI33QC/8TY9fNsDZ2qTXCdJC0VVXC0hZ91CxN1J3OSMBjvm
         x6oTwgNBT2B9OcpF70UDgx+/0ePR5eG/7ZJESFHvIn1V0mJpjnr4BfW16mzWuSFZs934
         FhTA==
X-Forwarded-Encrypted: i=1; AJvYcCUWbqGXar6JZOSx3BwhBPSQKt8U7acBnF+ciwSJx0++Uw0bdTEjOs7GN+8RvqJbOUrrwuV93WSl3LXSSvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9mzEek36amfO9W8PP53gUJyNLU10JRtc8xtk62/Rp0f0aKLc9
	a5qHCG9DdsMmB/LmHdkw3iD0mHM0x89EI9bPAgCY96A/bvXYnFD5eBrf
X-Gm-Gg: ASbGncspmASDbDMbza1QxixwEKy0zMYHvHSiag1IZkJmhQZKJuVskmtLHCHMJCbp40g
	WeQhgEz5/JVdLvX3t++B9YffiR7LMnpV7UagmhyklJcdcvB+Drq7U+JMQezdMzWwXW6EdVZ5zU8
	4HGe1KkKNt2f1CnZHp7EqN7MbnigMP8WVvBhsp0F4tu7MRoa83NBzrbTEpV2ofLeadnw2/uVScU
	+bBwdjJe7FsUazRFm11yMyiM6ut3aTX9DrzWfl/nrZIBWMYK6NEi9kDT+fBEarDdAk1+r9x9am3
	NvelgnJZdKgWZwTTWpsj8wKlUGfdZTDK/X6K9pIB3In/IlQBUxur2w+fPQ+UfW5pxVvEyAzyVh4
	yXLblFLp+JdkhFUzI8mHyRHPGOHNcQ2g+508=
X-Google-Smtp-Source: AGHT+IHwHjpPW2GRNHjnVhT4leoWNTk7qTMOx4cXEo4m4PS0FFzjuPxRd6J5vLIlDaLEXv5QV2eQYw==
X-Received: by 2002:a05:6a21:328a:b0:243:257b:e9f9 with SMTP id adf61e73a8af0-24340c225c6mr7651960637.10.1755911644177;
        Fri, 22 Aug 2025 18:14:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbbaca53sm914979a12.48.2025.08.22.18.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 18:14:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Aug 2025 18:14:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 6/6] genirq/test: Ensure CPU 1 is online for hotplug
 test
Message-ID: <480daaea-a5e5-4e93-bab2-91ac6edc0213@roeck-us.net>
References: <20250822190140.2154646-1-briannorris@chromium.org>
 <20250822190140.2154646-7-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822190140.2154646-7-briannorris@chromium.org>

On Fri, Aug 22, 2025 at 11:59:07AM -0700, Brian Norris wrote:
> It's possible to run these tests on platforms that think they have a
> hotpluggable CPU1, but for whatever reason, CPU1 is not online and can't
> be brought online:
> 
>     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:210
>     Expected remove_cpu(1) == 0, but
>         remove_cpu(1) == 1 (0x1)
> CPU1: failed to boot: -38
>     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:214
>     Expected add_cpu(1) == 0, but
>         add_cpu(1) == -38 (0xffffffffffffffda)
> 
> Check that CPU1 is actually online before trying to run the test.
> 
> Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> (no changes since v1)
> 
>  kernel/irq/irq_test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
> index bbb89a3e1153..e2d31914b3c4 100644
> --- a/kernel/irq/irq_test.c
> +++ b/kernel/irq/irq_test.c
> @@ -179,6 +179,8 @@ static void irq_cpuhotplug_test(struct kunit *test)
>  		kunit_skip(test, "requires more than 1 CPU for CPU hotplug");
>  	if (!cpu_is_hotpluggable(1))
>  		kunit_skip(test, "CPU 1 must be hotpluggable");
> +	if (!cpu_online(1))
> +		kunit_skip(test, "CPU 1 must be online");
>  
>  	cpumask_copy(&affinity.mask, cpumask_of(1));
>  
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
> 

