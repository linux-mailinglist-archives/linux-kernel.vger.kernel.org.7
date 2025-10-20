Return-Path: <linux-kernel+bounces-860095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE07BEF4E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704301893171
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873BD2BEC3D;
	Mon, 20 Oct 2025 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIcV/bJf"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576F8635D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760935454; cv=none; b=aqybX4GGrC0xpsi6lY/cx68Kb0VsUfYuAb9crq7mOJ2BZjCR/crkf39NJEKzH2CF11wYTORIyvrqFc1RS1a9Gs7Tn+w481rhYsaN2bl5UzoCEdHckltxD4sQl/bYRKB6uuV5YOclJ6iOq/i0BR60BkwAx/SykdA0XgDjKb3TQo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760935454; c=relaxed/simple;
	bh=Sir+KVSVuMLYiFjlTfRR7MJreJK6t1DKB3Oo82ZAx1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dn/usnUy4xz9wL7tDt6f0L71Zim0QCFabg+HPFbzaNh9zTkX5t0jkAX1MA3rxenbgSwEbo9lL9UwWv8aDBnETjVpOHz6lTdCZrlDTt8zgn9ZxIlVXg1hti9g5WZCEjUMYusd78/YOB4PNyRPv4a4vOhOjcL2jlJ4zOhAEVKDHWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIcV/bJf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7811fa91774so3382763b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760935453; x=1761540253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spA7o91KDi70Ll6ROh4SAqPxwOp0/KEcn9hPwha/0d0=;
        b=hIcV/bJfasqPs7rbtw+HnFzvKoMT5ZwnOFsQ+xOj2FGxY3nqD5H8ib/+FKMra3+Gpu
         98rlH8KxQ3rlUSycjhVPk/+JHhjZgYnFHIpa/PfF3+dovUsTsMAMa19I9pCubhc7bTV4
         SAygLokh6oeTMiEKxnQXAdReaNLKLIqhBFDlZXsxSxhcC/lxOTLLVbtav5QNls6YDryU
         zXO+4vGUm0QjO5YjnLBkbHND09i+8ya1D5CtqoRwsqru4Sge1yBg6pnOp0i/RcteyHrF
         pntWW9e3CTaMKfG4nH9P+EwHtw760UjNAF3tL5dE9icNH6O2L3VpGi6TzwI0ro/11oP2
         5eJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760935453; x=1761540253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=spA7o91KDi70Ll6ROh4SAqPxwOp0/KEcn9hPwha/0d0=;
        b=jfnyQoqoc021bQZU6kH/7clzEoqvt7TK0aJH4pBWP6LbyV/V7PWrO5H9MLIuCQH4mT
         fxV+EZOwy4Mq8hzH0RdbzwE9TwDeLa96ZWAOwA0lrbhAHYU9JQ+7S9Fz+cxeNOxOaTRc
         JEZRb943RV2a/Yxb6HUZLlWF9Yke2SCka1vrxXEFic8lqImRPWdZ/NQ8CefWz1AM/8PU
         +4B9cks7b1Ft1EFT0KBiVdV2bDlIj/LoIStVJHOZV23b8rZ/MJ8CqT1yDcHahm7qN+c0
         s6U3mPFhKl3y9OVOz8ye9ljWGTPVDG99EveauQKOk9cxTwMBqQ7707J8Oq1eHOZupCct
         zGVg==
X-Forwarded-Encrypted: i=1; AJvYcCXB7FRK00dMTFi+rrWNsNuYiwu/4gFVCSXqxWwzDU4glXAPgbmy1RMKzjFRd3RkVb9oRQDROB3ECvD21Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOj4WYN71n6qN0HppBoq/HlvQ3QAnIVhG8H+JRqmLzkchgqIJ
	g10UbAyg35Ai8t54MHFQ65nKlC71M+0fQeGTc7Vn19vmAHQcJ9FUiFxK
X-Gm-Gg: ASbGnctdlK1qYqTHlOsXrbhCBSLRvuvZDsmxD1Mqi7Nnv91IaGcj/iZQqJPyQ0K6ydx
	vAq+xP/xZcKAVlf/k0eZReCJlmIXgcDSM+HVdUF4V1cPmBNSPs/eDWwFIyxR2wYlX4ry/8EdJ5I
	sacRqQMhGHc0fe2VN0nnFSbMpmlhLA7nRPtU2lxyvk999ypT2GvtNYfQTTBJ/O7U2dfIkAZP+/f
	7ORPB3M1nTHgY8HojH+XU4HWIMIxzECSw2w8AH27zCwKhJ2WZYnqJaX2MxdX26Er2Ewj0MWnjIg
	gKp+2+PRMrPm+xLIbSwqPknsEiAKyw3eW/dtBawP9nZSNVOWZCLObgx7pATPLOxmK1lmiECRb+F
	VRW5lMKI3bjL1FqaM4qRtzEzgPnL1WBwnmeTpwbSRrI5czI/Xl9s=
X-Google-Smtp-Source: AGHT+IHWbr3T6FVN2FnRLa94Qqq1QareIcDELv0GtDJz5J4Z5xhqWfcvLugBUZ8lTWu9Dmv4dv3pCg==
X-Received: by 2002:a05:6a21:328a:b0:334:97a1:36af with SMTP id adf61e73a8af0-334a8523ebbmr15097184637.13.1760935452280;
        Sun, 19 Oct 2025 21:44:12 -0700 (PDT)
Received: from CNSZTL-PC.lan ([2401:b60:5:2::a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f2598sm7217538b3a.40.2025.10.19.21.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 21:44:11 -0700 (PDT)
Message-ID: <08911ae2-fef3-432d-a236-d820c9cb67ac@gmail.com>
Date: Mon, 20 Oct 2025 12:44:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6
 with A3A444 chips
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Grzegorz Sterniczuk <grzegorz@sternicz.uk>, Dragan Simic
 <dsimic@manjaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20251017073954.130710-1-cnsztl@gmail.com>
 <d70c0eb5-9aa2-47b1-8205-81b724180319@rock-chips.com>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <d70c0eb5-9aa2-47b1-8205-81b724180319@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Shawn,

On 2025/10/20 9:53, Shawn Lin wrote:
> Hi Tianling
> 
> On 2025/10/17 Friday 15:39, Tianling Shen wrote:
>> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
>>
>> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O errors and
>> corruption when using HS400 mode. Downgrade to HS200 mode to ensure
>> stable operation.
> 
> May I ask you to test another patch I just posted to see if it fixes
> your issue?
> 
> https://patchwork.kernel.org/project/linux-mmc/patch/1760924981-52339-1- 
> git-send-email-shawn.lin@rock-chips.com/

Thank you for the patch! I will ask my friend to test it but he uses 
this board as a home router, so it may take a few days or weeks to 
report the result.

Thanks,
Tianling.

> 
> 
>>
>> Signed-off-by: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/ 
>> arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>> index fafeabe9adf9..5f63f38f7326 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>> @@ -717,8 +717,7 @@ &sdhci {
>>       no-sd;
>>       non-removable;
>>       max-frequency = <200000000>;
>> -    mmc-hs400-1_8v;
>> -    mmc-hs400-enhanced-strobe;
>> +    mmc-hs200-1_8v;
>>       status = "okay";
>>   };
> 


