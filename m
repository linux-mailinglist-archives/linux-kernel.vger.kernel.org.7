Return-Path: <linux-kernel+bounces-739741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26226B0CA52
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151A21660B5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E592E2F14;
	Mon, 21 Jul 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WKFj66y7"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A632C15B2
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753121304; cv=none; b=bVpNiie1D8hKleVMv0thKZ08h7tVvfipfy81BT0im7t1sPLguce2FsHm4JlMVf4m9jM1HE5LyV7A32zd0Nk9KTFQYgYjFQvlV17VmZ5Dh4xL6gQlmcEF4hbYgB82zc/6o74JaHHbSdNMEJG0w3bmd4NP41JCzIZ1wHP0jwqc5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753121304; c=relaxed/simple;
	bh=92+Q39EW0fbLTpEgLkOhiI/YwGHlNATxM4RpKtbF9Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLwvj3y4RjtTOuKtFkiEB8eqsJmWYzEV1Z9yyulFih35CHxBBYqwZlvt11O8kjydo8m0D7ikA/9GqM76MTYHa5pxt0SC7kzN9v848WM+EeZO4KPyonxU1ihRQA27jSRWAQS0aTa5rAdvcC5TaZ85JS3pepYzoPbvRZq7LVWujWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WKFj66y7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748feca4a61so2566083b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753121303; x=1753726103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OQau27tiFbgxeFSGF9XUGR95YzgyQaSOU0OlzzUWZMQ=;
        b=WKFj66y7fg08NTjqsExRyN4/HYJvmzOjn1pjVz2G4vIdrbJ3yYAoN+PG7BBbighft7
         C/gcsYy118Qz6nafIvPSWZ7u+W3Lft1TtzM/qQfhlnkHyXC+WqgKW8wZy08EBjxta/dA
         1dm03V9nqZbU6XK0Ei6e40HVKqer0G4YrQMx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753121303; x=1753726103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQau27tiFbgxeFSGF9XUGR95YzgyQaSOU0OlzzUWZMQ=;
        b=QK/POFFTafijmb1u9JItylImMITZ8bwLVXU0ZhrkucUm/FGNAFeAg719P5Ye7Ktejo
         YutUO66nDvHRkDLEnqqAXMZB2Zdv9ToCOipc5sKqSmyywYPByRHNUxVUHJP0Cyli+q9S
         TIX5Sd8ZKvmmKcyB14p+6/dAi3d9TEFLw0h7wXJNVb+i91vTRr89zaOgz2oQqELir2cY
         TcRQt7T/qjIq6Rzee+OTiuHhAd0c3tOGDAnnZPuGb1c4XyHN/yIsHhsCXLgUQL+2Bcbs
         OAe6rHkXBOiBATnY8PkrzsUTC7A0XRrJ8d6wXyBN423vu/6zTjTOJGYPqmmNCkPHCO6R
         vWIg==
X-Forwarded-Encrypted: i=1; AJvYcCV/PsXSLLxqughZY2fxkO0DWr7PRmaoVzner0NgnON0QoBErQbSfSHkP59wsJWtERaO1HFTGC5cMMF/cPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEmdQxVfzFrFttgZ7nWWQK1/qj6TCqHq5JWXuI0AMpVixeva72
	oAc17q3ejGbIWudblI2uSFBdaON7VMz9bjOb4e8WhuSRZJaT1cwRebAv24fKBzAyHg==
X-Gm-Gg: ASbGncs/C3QCbr1f4mHGbnFNMO/GNF3USheALGuRQMI8MMKBGBok70pnRpdGv40Nrlz
	8JQ5ZjqInczm00MXokw7nKz2VQc9s6KdZeRTLKoC1hSwU2Y9DrdekmB389vA51QR8jQifhAzP9X
	QnJswEM31s8YuBPcG/8agrPonZyIyus5g2BrLrZMzytIGOCbvIdrSKydPQQBU2sr0K6RWWq0Qta
	AVH9i8nTXVA6c3niHJm0ekZhl5zUpM7mHZFk8Mpr2vRKKB3YIiUW4zucmGA26MrT3Q9KAK/nSF8
	tyNsWoTAL5bMtayp0oTRc1WxclLkEMBIhl04Nm0nl632JTPQDqvVXdJxkv7XRbZHDm1aw5FnpAM
	GgD5DerYYBjD3QDffD+cCXUIB9sAmJJ7n/rybLmaNcUkb+foP6sDVUbudkWhwtqCEiyPagIqKPO
	lO
X-Google-Smtp-Source: AGHT+IH3Pl8hly1TQfln2anufJFdUC5B1Ir4HZCUoycIdoSWzeF9avLSYC/Imq9DCATPu80vE9gR5A==
X-Received: by 2002:a05:6a00:4b43:b0:749:8c3:873e with SMTP id d2e1a72fcca58-75724876b0bmr33128549b3a.24.1753121302713;
        Mon, 21 Jul 2025 11:08:22 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e24c8sm5845796b3a.15.2025.07.21.11.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 11:08:21 -0700 (PDT)
Message-ID: <7bebb6b5-d527-4621-9438-8a8d0ab9d970@broadcom.com>
Date: Mon, 21 Jul 2025 11:08:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
To: Andrew Lunn <andrew@lunn.ch>,
 Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 Tristram Ha <Tristram.Ha@microchip.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-1-89d262812dba@foss.st.com>
 <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/21/2025 10:07 AM, Andrew Lunn wrote:
>> Regarding this property, somewhat similar to "mediatek,mac-wol",
>> I need to position a flag at the mac driver level. I thought I'd go
>> using the same approach.
> 
> Ideally, you don't need such a flag. WoL should be done as low as
> possible. If the PHY can do the WoL, the PHY should be used. If not,
> fall back to MAC.
> 
> Many MAC drivers don't support this, or they get the implementation
> wrong. So it could be you need to fix the MAC driver.
> 
> MAC get_wol() should ask the PHY what it supports, and then OR in what
> the MAC supports.
> 
> When set_wol() is called, the MAC driver should ask the PHY driver to
> do it. If it return 0, all is good, and the MAC driver can be
> suspended when times comes. If the PHY driver returns EOPNOTSUPP, it
> means it cannot support all the enabled WoL operations, so the MAC
> driver needs to do some of them. The MAC driver then needs to ensure
> it is not suspended.
> 
> If the PHY driver is missing the interrupt used to wake the system,
> the get_wol() call should not return any supported WoL modes. The MAC
> will then do WoL. Your "vendor,mac-wol" property is then pointless.
> 
> Correctly describe the PHY in DT, list the interrupt it uses for
> waking the system.

+1
-- 
Florian


