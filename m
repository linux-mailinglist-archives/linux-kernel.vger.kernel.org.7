Return-Path: <linux-kernel+bounces-864113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C40ABF9F13
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3833AAC8B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBBE2C21D8;
	Wed, 22 Oct 2025 04:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="lcY2ZKZY"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005CD26561E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107443; cv=none; b=a240HvXWtc8OPO5OCsbAI9aOYY3Rp7wQ7AMEtcNPWhohX6U57CyG2J68RNo2cfpTSWdnWGh3zy/iJ+wYbjfwTr3RrPJIRjLdH6dUi7ksCF01HcjKM/Sin0VDlSutg2r3qCyw1GM3dt3PYhbEKMBZKezb57wkd74E56hWvbSlttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107443; c=relaxed/simple;
	bh=c3lovmv+mOVMEJUmhqHzv3/fwYfbe0mJdOLie9Y75RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmvzuw6t3WpBFQg9aAtqqVTZzxoKKqFum1DqFRztArIhAr0n5AV541gBRQDnnmxFjcEhyJFh+OkDkP5jYUzRej12gMMsvpHcQkVe+JLZXawvst8EwtqHQvf4EEDjX5hbFdKNTYvQNM8USFHKlPDk83Fwrgi161vdXc84cG5bqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=lcY2ZKZY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32ec291a325so4602466a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761107440; x=1761712240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTcnGjhUhb8jKzTF6L7XczC6QFzv26Nhm3lCxckjhLU=;
        b=lcY2ZKZYN4j/EJysODpllk71q4UmmdMO6IMQZefHOnIUxt0rEWAntmkPsPmuUCMUei
         bPq321mpEnZKuqL7CrjqjAGkZN0OTsCjxVXmM8P9zCxVfjxTmay9hSjOGBZsDk6EirWw
         iXETPY53s5o9Wutbl8i6osTl+TGXumXGQbVPgjq9GbGKJlQ0m5qV2pE0D+hzk+msSjh9
         J5zu6xAjM/NCBVsVFgAx/7nM1IVWaaKkZAeNX1aeegpvjbOV0t8LSE9/PXgzfG/0lNHV
         yGuz+CZYzLQdklTHql4M7lreKJJlIJpEtfCHIy2ECyowCSzNc7hfFlMlASOzUHGzKRK6
         Nmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107440; x=1761712240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTcnGjhUhb8jKzTF6L7XczC6QFzv26Nhm3lCxckjhLU=;
        b=R31zl9HWanc/k/nciPMZ9Ubsn97mNkWV61nGBMRwSdmqpRiksYqpO8cllAXzQXnat2
         qTkZ0OKf431fG43LiRdcUzyTwp4VxcbhzNnKc3rdspdDHLTloUbpgNEjJJes8px6UPiE
         /x1mICRh9NKV6sRhkSzDuHQd6mwDWFoBtK9PuDfQQuqVwfAurgE65LbSUNxHPiUW1DJM
         X26yMHiQiHZRHg1Ld5bPu4/AK6u1ZZNeWdZ8U3AUyn3uwcBU77LqebI9JbppiNTzwE2O
         90lc0NOdC26e4swmTZmZUM37Tztteh8YVFUrOS6gs2lnPB5njvPspKZCl7CYsHcnIYH2
         th1g==
X-Gm-Message-State: AOJu0YzLvkgpjXBU5dIs4ClmE4W4F7nD3tOleN01BpaPME+SoDyco/Ns
	DaA/hCmXRislMlZVhScqh/rtW9RDX25pG2pKtgIoDU70eoxeq4sqDl9KVKNVW1eS2y4=
X-Gm-Gg: ASbGncumsh1hOerYRvJEqu+j259osrdohlaRGpTwy0ra4Vt1h023sHyYBVskRtJd40h
	4jXbQcvl0myWcOJPxDiRBw47Wq8GTDc+7ZDcBbc4480Haa7ftVR1NfoNC8Nm+7o2ClQx+t26J6J
	1OhDvHKATamnezC4ny7OPjnIY2xrJNhb4+qrgwpKThe2M/FsvBv/JkHiFw7JC0VabiUodxGQBRR
	z42P+6J74QSlXQeDiOxnuYLOPUoUhpMV2oAHjq1oyKd8Ogek/1Ty0ww09g4+j5nI+3R7IZ0Rb1o
	Od1rHrR2g56SBDaq8/ZTeWyL+e6DoPNusRVoJkGZ7+VJSKpnZ8WA0BTPXcm1dH+qe/jW+kUOuZw
	8wHQHWW8ZbNBXdiYsxQjQHxupD6QpBFNUJ9kpnxKqqoRJlq0vn2NjZevNmYMM5O4I0DeL3eUHJG
	g4bBrX0TDwQqZstEHrX99TGgU=
X-Google-Smtp-Source: AGHT+IHCvLgZS4hGuZBkDCjjiv46qhxkjKqpH5V3aq6Xzke+jWUJSrYYnDrBe5cM1LQ8ndK7Tc07Cg==
X-Received: by 2002:a17:90b:3fc4:b0:33b:b453:c8f0 with SMTP id 98e67ed59e1d1-33bcf8f9008mr23774051a91.25.1761107439935;
        Tue, 21 Oct 2025 21:30:39 -0700 (PDT)
Received: from [10.211.55.5] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223f11e1sm1236623a91.12.2025.10.21.21.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:30:39 -0700 (PDT)
Message-ID: <965a6f1f-37de-4029-ba16-cfd2de7895ed@riscstar.com>
Date: Tue, 21 Oct 2025 23:30:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: simple-mfd-i2c: remove select I2C_K1
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Lee Jones <lee@kernel.org>, Yixun Lan <dlan@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, kernel test robot <lkp@intel.com>
References: <20251022-p1-kconfig-fix-v1-1-c142d51e1b08@linux.spacemit.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251022-p1-kconfig-fix-v1-1-c142d51e1b08@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 8:58 PM, Troy Mitchell wrote:
> select will force a symbol to a specific value without considering
> its dependencies. As a result, the i2c-k1 driver will fail to build
> when OF or COMMON_CLK are disabled.

Should config I2C_K1 depend on COMMON_CLK then?

But you're right, the selecting config should ensure the
dependencies of the selected one are satisfied.

> The reason for removing I2C_K1 instead of adding a depends on condition
> is to keep the possibility for other SoCs to use this PMIC.

Acked-by: Alex Elder <elder@riscstar.com>

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510211523.sSEVqPUQ-lkp@intel.com/
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>   drivers/mfd/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6cec1858947bf7ab5ee78beb730c95dabcb43a98..ea367c7e97f116d7585411fff5ba6bcd36882524 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1258,7 +1258,6 @@ config MFD_SPACEMIT_P1
>   	tristate "SpacemiT P1 PMIC"
>   	depends on ARCH_SPACEMIT || COMPILE_TEST
>   	depends on I2C
> -	select I2C_K1
>   	select MFD_SIMPLE_MFD_I2C
>   	help
>   	  This option supports the I2C-based SpacemiT P1 PMIC, which
> 
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251021-p1-kconfig-fix-6d2b59d03b8f
> 
> Best regards,


