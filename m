Return-Path: <linux-kernel+bounces-893656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC538C47F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10B1F347ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1EF28468C;
	Mon, 10 Nov 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODpHXld4"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EAA273D8D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792574; cv=none; b=Y+LNh9SyuQkRxG5bkIeyB9+OrWOSk0q1/N6k2t1fNt5H08+dUv2a+Q/937vvv1U7OKTgBkFeJaq35zq8+i8vHCrSA0hQxjGiHkjMTbLaE+1ycrHALSLoHWuPRyijHfs8iRS7CMw5ZtMScwTOYTXI2DbUOEMJ88TsDRfhpvHZzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792574; c=relaxed/simple;
	bh=yNST3azyTjbEzIfSXsR4ftDpA3b1K/IxtYd636Ors3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sj2cu+fnGLyW2sETQ6rkwMoXgkggfNHN1Uc1MpVDX0hQYvbV/aHX8XgLEd0vfcUib0z3pTLW/9dKDT788PmMip9X4Ji+oYcFyBe9H+5CkSGujZpSEz0JYCu4UtaZ9WiKePAtc+rRNUB2nRcbmssNlycRrUDWRBJC3eth9nZud0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODpHXld4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so22724905e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792570; x=1763397370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhAB4koRV8OuSw3ZkNH4jbevIDkGt3mgNcrifk4gAgI=;
        b=ODpHXld4lc46GHDiy6xfLCTyRQdy6+PFZCBgyLe04sSo1Iw5/MYyYwH+Kz1FFiQS9y
         WK5s8fOmzLAcTELmELc3SxARKxaoam519UkWodjCaQgaAiM31RYzyPi6u8riWeC+Z6i6
         KRJEspwxE3JDcodZLnmaiGpuS99ETEB7dcL/IUk1p2VFuGiolAJFaYcwt6Lj73vqkpQf
         b57GU+9mWrD0eDmiDKHAQgTt81zYXiOoYZfOKWCfXPFIxJnpqHxwkSo0sXnGxIAejNYI
         2MtCn5lKs0bEUBK7tLCcgL87oi7t6MTFKr0u6nlW/ZzeFyhh/0akpYKyBS5S+bEjb4+m
         u5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792570; x=1763397370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhAB4koRV8OuSw3ZkNH4jbevIDkGt3mgNcrifk4gAgI=;
        b=NBfpB7DPLIp/m71LWEkKD+Zk13G4bqdlCtu+Mn43pg3cpos25+QmqWJ4/9tyTRVZrI
         9Ri5CaaR8MdO7xt7lBE7UzM7kjBKzorwq500FhFmRkdEP2LMXTs8QIzD1iqJAphliarq
         8eBaXX67aRhLNMg8MzwJwQHn/gEzYOhzulixgviiFf7/eYu7xaHQCuP2TBU/FYvWQcGn
         w7cjcz+5HEh803Ju2feESXE9zq8/U4D5O0EwS0Gmcu7n3P2hk3/SVUBQV1YUGThK7AlI
         Kc2/rphBZpmg/cnwcJ/nqSR0Wr/IqEBAxWN8WNA9ZsUlQ7fQ1Q/8do2P+3Y125iqQCxR
         wWHw==
X-Forwarded-Encrypted: i=1; AJvYcCU0dGZd55QQuJMcyeywq8U6IHYUmNXwsvbgTf6geijxcYrpJzAojSb8iVO9Bthj41ivR1nVi3ga8oR5BH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpgtOyGH7Td2qs+EjveHncuWyG1PjJtBpwOA9asI+3sRVtUpb8
	WG4MjgD6XACnQkpvnmFnspEwY9TLWSvpGr3Y8j5ccKneIbOo2nmUitOI
X-Gm-Gg: ASbGncv65r08JF6v91aPScQQoHSMI4zZBhOOnj+IHVWYeUCpxz2bq1hgYdxA5cOtEZl
	yjRAu4lNwKvTqkxELh7HwrH5ry+9wbPnGkR5px8X+5Wogk3XtwxpA/ZqPxmL+fdfE4eJHd0C/hh
	exftXyMunc18oJHiGUrFUFN3J/8l4RTI8tb6IOPqj/okd3CgRhvRGJ/lPONzoWsUOkW3Vnql5jD
	WjVVKgcIcERb/Ird1eBNQQzhkbcKBwVXwVba1g4rlyj3T3Oc+Jv8nA18iUrSOw8/SKvnOlom85c
	zuIr0mN+N3YOmG4OJaV0SyBuWXSWggL+wa4we2E8RSj3D2aAhT+KYRdJAKZ1Vkp049+Dmsscfjp
	cMB+uIubSlwCrTYFxW6T+M/PqypyONVdGNfLwdpUpi8qhdV0Wei9B1mConjb5kz/e9cocp4WPqN
	c7KBoarywOgIKEcOY5CmHk2CakkLZYWaQJRA8fd0WaVyBw0IErAnLALKDortDAWgsJGDGjcImIt
	RHm7s3qTQqGtFdjmk9uf/B+CllU+1E+BbJQ+P/UnrwAjCvLW8vX/A==
X-Google-Smtp-Source: AGHT+IGs5J1xMt/Q53jRJfEgjoMy3/YUcsKcG5K93obiroIZyFWnVkswPcCfCztZiqkkrd0lEC/Ppg==
X-Received: by 2002:a05:600c:3b11:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-4777323ec9amr65987355e9.17.1762792569980;
        Mon, 10 Nov 2025 08:36:09 -0800 (PST)
Received: from ?IPV6:2003:ea:8f33:1e00:300e:33dd:b203:22f9? (p200300ea8f331e00300e33ddb20322f9.dip0.t-ipconnect.de. [2003:ea:8f33:1e00:300e:33dd:b203:22f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777f1b61acsm32277365e9.3.2025.11.10.08.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:36:09 -0800 (PST)
Message-ID: <f341419d-d565-446e-8030-bd2e7ee5d764@gmail.com>
Date: Mon, 10 Nov 2025 17:36:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: add support for RTL8125K
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251110093558.3180-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251110093558.3180-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2025 10:35 AM, javen wrote:
> This adds support for chip RTL8125K. Its XID is 0x68a. It is basically
> based on the one with XID 0x688, but with different firmware file.
> 
If the only difference is the firmware, then you don't need to add a new
chip version number. You can reuse RTL_GIGA_MAC_VER_64.

{ 0x7cf, 0x68a, RTL_GIGA_MAC_VER_64, "RTL8125K", FIRMWARE_8125K_1 }

> Signed-off-by: javen <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169.h            | 1 +
>  drivers/net/ethernet/realtek/r8169_main.c       | 5 +++++
>  drivers/net/ethernet/realtek/r8169_phy_config.c | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
> index 2c1a0c21af8d..050ba3f4f874 100644
> --- a/drivers/net/ethernet/realtek/r8169.h
> +++ b/drivers/net/ethernet/realtek/r8169.h
> @@ -68,6 +68,7 @@ enum mac_version {
>  	RTL_GIGA_MAC_VER_61,
>  	RTL_GIGA_MAC_VER_63,
>  	RTL_GIGA_MAC_VER_64,
> +	RTL_GIGA_MAC_VER_65,
>  	RTL_GIGA_MAC_VER_66,
>  	RTL_GIGA_MAC_VER_70,
>  	RTL_GIGA_MAC_VER_80,
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index d18734fe12e4..2adffbc691b3 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -57,6 +57,7 @@
>  #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
>  #define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
>  #define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
> +#define FIRMWARE_8125K_1	"rtl_nic/rtl8125k-1.fw"
>  #define FIRMWARE_8125BP_2	"rtl_nic/rtl8125bp-2.fw"
>  #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
>  #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
> @@ -110,6 +111,7 @@ static const struct rtl_chip_info {
>  	{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66, "RTL8125BP", FIRMWARE_8125BP_2 },
>  
>  	/* 8125D family. */
> +	{ 0x7cf, 0x68a, RTL_GIGA_MAC_VER_65, "RTL8125K", FIRMWARE_8125K_1 },
>  	{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_2 },
>  	{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_1 },
>  
> @@ -770,6 +772,7 @@ MODULE_FIRMWARE(FIRMWARE_8125A_3);
>  MODULE_FIRMWARE(FIRMWARE_8125B_2);
>  MODULE_FIRMWARE(FIRMWARE_8125D_1);
>  MODULE_FIRMWARE(FIRMWARE_8125D_2);
> +MODULE_FIRMWARE(FIRMWARE_8125K_1);
>  MODULE_FIRMWARE(FIRMWARE_8125BP_2);
>  MODULE_FIRMWARE(FIRMWARE_8126A_2);
>  MODULE_FIRMWARE(FIRMWARE_8126A_3);
> @@ -3844,6 +3847,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
>  		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
>  		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
>  		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
> +		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8125d,
>  		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8125d,
>  		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
>  		[RTL_GIGA_MAC_VER_80] = rtl_hw_start_8127a,
> @@ -3863,6 +3867,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_61:
>  	case RTL_GIGA_MAC_VER_64:
> +	case RTL_GIGA_MAC_VER_65:
>  	case RTL_GIGA_MAC_VER_66:
>  	case RTL_GIGA_MAC_VER_80:
>  		for (i = 0xa00; i < 0xb00; i += 4)
> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
> index 032d9d2cfa2a..dff1daafc8a7 100644
> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
> @@ -1344,6 +1344,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
>  		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
> +		[RTL_GIGA_MAC_VER_65] = rtl8125d_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_66] = rtl8125bp_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_70] = rtl8126a_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_80] = rtl8127a_1_hw_phy_config,


