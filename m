Return-Path: <linux-kernel+bounces-731714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95830B05889
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72A84A6493
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB752D8788;
	Tue, 15 Jul 2025 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evCpKkFR"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51841FC0ED
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577980; cv=none; b=D7e06bSJp93kcNjGtBM2wstmtwQK7vG38EP4N2cT9L5y9CXChO4igEy56wpXycFL4Kxq1ts9GSFcZmJAjesRlngcoBL+ENAJih3XTRJnht3wHaejAhnG74HxkgnYeoaYpeuHEer1LKXsl89CajcWQCBmwY6N5cslGYl47BMv2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577980; c=relaxed/simple;
	bh=QjlB3EVJG4noJpnYxkPnqJdza5KENH0qTqOv1DlQwsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzTZfT8jAZRAtG3lvCDUMKJP12UdkEmQjQzMaBWq/NKOlXsII6qIJr0iFUVF/mkQLWIzw7WXSeBCkXR6gkx0maTe4TSlYWXzvTREyye40doycgjkGQd8e+so7zwSP7A0bAzAfNizOt/1Ozk49OvaWWu+SuI/R7W+IegdnDxt4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=evCpKkFR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-454ac069223so32018815e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752577977; x=1753182777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJh+7q1eOpzJ42XzUVjV8JoewjGDoVDjvqBvv7u2oiU=;
        b=evCpKkFR1Qj5ekP65cTIsLtM2ewO5dhQZnH9Rp2jD80pO8RfEyotqwe1PkWwJsGd7t
         veKkPAXzboPDC+YpSzA0+pFj3y2yFO+f/TbPnIOVn0Hutc0/P1/L9ts+6IMi9cKJJMtc
         4WMrI70CHOYnSla5yWipDcmAiKa1bh37B81k3ug0qJ4tzWeHEbf70aNnveY/3sSk2XRs
         KsbmMcxouIYGi68qeRAJNIfDvt0kT4ul6+YZfq3S37JTbK1PuJZ528cqOiRF0P4uXjIb
         +oT7i8w7UyqZCdYbWZjeFwaK5ahp5TX5YgENPDlxz1QT7Svcv5VAwk1gJW0RxMJsoyji
         cuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577977; x=1753182777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJh+7q1eOpzJ42XzUVjV8JoewjGDoVDjvqBvv7u2oiU=;
        b=rQoleUpGoAh6bJetnKr4zsNiQyh+R1fQfC1ET+QV4rFrsyazM2BfAIdyuuwV1jR9PS
         wYm7+ac+NoNob99Eh6+OwxxobsdLXGRU3yVrUURc4RqTfnhUgG9cPsRYz8d3deZUlCU4
         dNYlPKy1ISCqgHorYk++rr9uOEYDOZHM4Pjizb2xnRNB8G8Y6qQrfTR7bI8xgCbm5pfU
         Q0B3HqANy2RMw4hjtC7/jTneTyq076NOdZEiOLzxt25fWfz50Vq305hCV1vwo68dYoDS
         uTDzu444QDSLTgTPiQVMZSeGjD3oM6229exeOnD2TTK1TxYEvg4c3Gwp2zOnbiOLeCR3
         20gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvZm2MGuBLKPs44rN8sQzmO+f4516CN1JH2U6BblqMyXzbSyYBQKYnbcjWe4v0NjvU3lvfYZcdcxcm3SY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo3/yBlV/ipWwbc7f1IelrxkhqZ0+imYeXtRTN3nLuPz5ELZo/
	b6P5YxZE88WNH97LDvFfu4g7DLH03ISxXP8OBW95S3K1Oc0G4PFi53ydiSmMgAC4rko=
X-Gm-Gg: ASbGncvNTF/YBZ5jKTIh0NoQULZy2rtOUUUDfEqPdaNpbbygNPv9srP1wb8GuOKZZ4B
	jsVA7uK+HDbxEn4oZOE6Qj16sn/ZyQj9yCNVkTz5lXJg2nCWRtMCRpAYYrxJaLzxEqt3pTVUOes
	tttGGIKcZH48/oMRiV4eqWZvtyIPARu9OMCiH78zhG4R6hwCuuAac/TAPtXeNaMWUOEQbUJCXKU
	BgZ7yI7FoZvO+pu3viFo/MUweLHsG9Lq1LkHfnV8t7aZbsy0BaxFLlbldmsQIk5QhtWQ9a6FLBn
	QS0FpiUkIMSTu8eJd2QnFyfZLblPWku+yXEWE7EnAekXefo9eZ3SD+/OMpQTnnyxK2LpkPoJNoc
	Vt+r5NUcLirRkjInlnNbMcneggD1xHZQCKSZ4XtSN2lfyB+P7NBngUtfAx6Pr1sq+q04oMIY68w
	ZpGnaxxQ==
X-Google-Smtp-Source: AGHT+IGMVUMJguL2cflxNK43dXfTYFLsqWOHbh7yPT6QOS16E5yWVhsLbsn3U12gvujAWUSQV92MFw==
X-Received: by 2002:a05:6000:2c0c:b0:3a4:f70e:bc25 with SMTP id ffacd0b85a97d-3b609537356mr2403931f8f.27.1752577977077;
        Tue, 15 Jul 2025 04:12:57 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:152f:ac33:4edd:64d2:2be5:6ffb? ([2a0d:e487:152f:ac33:4edd:64d2:2be5:6ffb])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1833sm14462172f8f.8.2025.07.15.04.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 04:12:56 -0700 (PDT)
Message-ID: <0e4bf420-2d4d-4040-9996-d6f439fa0763@linaro.org>
Date: Tue, 15 Jul 2025 13:12:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: tegra186: avoid 64-bit division
To: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Pohsun Su <pohsuns@nvidia.com>,
 Robert Lin <robelin@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20250620111939.3395525-1-arnd@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250620111939.3395525-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/20/25 13:19, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added function causes a build failure on 32-bit targets with
> older compiler version such as gcc-10:
> 
> arm-linux-gnueabi-ld: drivers/clocksource/timer-tegra186.o: in function `tegra186_wdt_get_timeleft':
> timer-tegra186.c:(.text+0x3c2): undefined reference to `__aeabi_uldivmod'
> 
> The calculation can trivially be changed to avoid the division entirely,
> as USEC_PER_SEC is a multiple of 5. Change both such calculation for
> consistency, even though gcc apparently managed to optimize the other one
> properly already.
> 
> Fixes: 28c842c8b0f5 ("clocksource/drivers/timer-tegra186: Add WDIOC_GETTIMELEFT support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied, thanks

Fixed conflict with 
https://lore.kernel.org/r/20250614175556.922159-2-linux@roeck-us.net



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

