Return-Path: <linux-kernel+bounces-891236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E886C42359
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 02:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15B064EB19F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 01:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF42C0F91;
	Sat,  8 Nov 2025 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b1iHUz4D"
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7732C08BA
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762563929; cv=none; b=LVjZouieUphc9F/+I2ycnbAK7bJvuoAHh/gt+tzWHZJ1SbvZek/BGWOnAbaB/PtdwaGmwQIS7baeEllHcp5k/Ex/8RAnLw6uLLztfE1ifCDAbjmNbxDyswGoT9kccEyuPRk/78FMTKrn/n5L6gzTY84hKEq0QKKySGHQOXYhg64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762563929; c=relaxed/simple;
	bh=EVtyStdJeHsUQkSW3bDldlDW+71GusX7cbaC+xrI14c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnCmkHJqtUZhiuNzuIZz5DNMUy1TqLN5+hEFMZ9NQd4rO8pRQzeunm8om++VXHz2OfLQ5aNgt0L95XcgzBreDWK+Ty/0Sg+NjQC2PNfiC8KpySSGGBoyrGNB55zufVV1JuJ59nyqL/DdkuVcXc7xgu/4+oGeydgUgL2vv0X3GCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b1iHUz4D; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-935241a7a0eso713141241.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 17:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762563926; x=1763168726;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2jxJHW70gjo0FCXT3ldAFSxb0wxigs02yuRr707fffE=;
        b=QCZexYLDy4vK3AZKjUBr/lV5WXWGgYrYp0heoRUTutujm5i20xoIV1sAgGl1bYIvId
         navaAXxxm0LSUz/Pf2ApuATklN1MP3duD7tiVYgG6ladSeMNcm6cEUYsQnGyIaWZRsSg
         oJ3iY6uPUKzew0V+4lX34LyVBwgwl2NrNJFPKJ03HjDyfbnoL0QW1HiX01aOmBiMDVgH
         UdcKO/94cEJU5nQhKQ9rZ9NCc2PeHlfKgzn489l6BqsWFPBS+M0MivrBaN2YgQHCeeI1
         fA8//KtuIp7Yrcy1rjCDu7aQVDikxQ2ptmqi5rbVAgepaheT39yKelePqx7Vz0DGYlpp
         ZMSA==
X-Forwarded-Encrypted: i=1; AJvYcCWjHLSgMyDHUeksAetWY4tGZexDA3UPabH3TcJrVoULu/iFdnIlQVHTuy0i5mJnK/1vnTRglEMH80MPp8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgL32ybEDDJN9yPMpIzXgsL5n6lkALcOA+5yLuIkKBd9PEjqSA
	eipWZ5uE3Ed7roYsi+uiWpc0vvYHY5QWiQ/HSy4j/BngeY0WkqRQsZ+9ZGeIOC1y2z/dmQhhy4Y
	GEc2Xj5RRXWcqHTwGQ4dt7Nwp0r/W8sqlIUvJpHIU4S8u8bD/u7yYse9Vs6v79oPQPM/cyRX87I
	mhckKzCcqFTueLRTbOfx170V1XVEfDciBR7N8F5DJOMhfKNbI97smemLNsrbTB7kEPUlGDol2RJ
	mZwUH92TapdKNCxyP0YI+UU
X-Gm-Gg: ASbGnct+voSBqVq8W5CM9RgPBtSzf7GbNMNYEnbGGKFxGM0iBwcLMzEqOd2u74hOt1N
	ys3G9aECWZF9vximAPhOQSh04GBZfyLhEcljQamZ0QhSK0K9OAGrNCl6v1fcyTu70SvbjZKKkwS
	lMvgWTgBp6aWYmdGG99JVxOu3Z2j2sCt1Th5eepyEOCdi3dvjjotvV5zFFKmTlhtfNRBq/kqvnK
	y4S6zjtJ3ul+ga6ZM4fih8K4k41Vq+qhlox1R4zvCn0ZsNTtHXE2Na62s/BtCsQ9ThU+nPEMuZ6
	n5aF2ZypmOjYjwWejtXjgFMZUN68qbsU4xFNSazHiwxPHa28A40FHy4+QaSCV72eieuQ41qkb+F
	O7p7xeDzAMgmkzSXTIJpUAWizADtWzucRfTJlGACv5zTVPQNUhrn46qahPQKiDol3myXBLnUXGI
	CSFsOqoC/sJTji5ZpBLsSwIT8asxPC0dKOs8Tbsiw=
X-Google-Smtp-Source: AGHT+IGVRrHVouN9nzu7SR29qBoepc/RLn+JxQGECXGBvylU4PxBK5Amnl98xFCkM2TWTxUsnAlmfuScFEhb
X-Received: by 2002:a05:6102:26cc:b0:5db:e373:f0a2 with SMTP id ada2fe7eead31-5ddc48420efmr634511137.44.1762563926397;
        Fri, 07 Nov 2025 17:05:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-559957c042fsm641918e0c.5.2025.11.07.17.05.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2025 17:05:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7c6d3685fadso628460a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 17:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762563925; x=1763168725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2jxJHW70gjo0FCXT3ldAFSxb0wxigs02yuRr707fffE=;
        b=b1iHUz4DFmg3HIUd1Zxy1rJCJ5fvLrj/vPEOV+TO5sVFakRlXNrFYiTNFexXpnu/+f
         Yx3ufjYIgbbO5QfdyyLNXFlqwwgWorlJcSXdKMkBzjWQXsn1HCQtO4FHrHhGxWwZQGkc
         gHdwxhvp4wLIDHOTjTy+CmlYTdUHvK78+lb0k=
X-Forwarded-Encrypted: i=1; AJvYcCUqTuRsMbCJrmkJzfCneo1hpkOTET4RUL2aljzzcvx3w42UHplIkR0ioeJoraG2+FBB7YImsW+6rqIAyYo=@vger.kernel.org
X-Received: by 2002:a05:6830:a8f:b0:7c5:3f91:6c94 with SMTP id 46e09a7af769-7c6fd84604bmr694608a34.36.1762563924998;
        Fri, 07 Nov 2025 17:05:24 -0800 (PST)
X-Received: by 2002:a05:6830:a8f:b0:7c5:3f91:6c94 with SMTP id 46e09a7af769-7c6fd84604bmr694597a34.36.1762563924702;
        Fri, 07 Nov 2025 17:05:24 -0800 (PST)
Received: from [172.16.2.19] (syn-076-080-012-046.biz.spectrum.com. [76.80.12.46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f0f5ea9bsm2303706a34.10.2025.11.07.17.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 17:05:24 -0800 (PST)
Message-ID: <f32775db-f9d8-4e4a-957d-30836e3d4eef@broadcom.com>
Date: Fri, 7 Nov 2025 17:05:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/8] net: dsa: b53: add support for bcm63xx ARL
 entry format
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
 <20251107080749.26936-9-jonas.gorski@gmail.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20251107080749.26936-9-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/7/2025 12:07 AM, Jonas Gorski wrote:
> The ARL registers of BCM63XX embedded switches are somewhat unique. The
> normal ARL table access registers have the same format as BCM5389, but
> the ARL search registers differ:
> 
> * SRCH_CTL is at the same offset of BCM5389, but 16 bits wide. It does
>    not have more fields, just needs to be accessed by a 16 bit read.
> * SRCH_RSLT_MACVID and SRCH_RSLT are aligned to 32 bit, and have shifted
>    offsets.
> * SRCH_RSLT has a different format than the normal ARL data entry
>    register.
> * There is only one set of ENTRY_N registers, implying a 1 bin layout.
> 
> So add appropriate ops for bcm63xx and let it use it.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


