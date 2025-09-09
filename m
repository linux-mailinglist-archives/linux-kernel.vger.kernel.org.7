Return-Path: <linux-kernel+bounces-809067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BECB50820
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73F616B584
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECD025F784;
	Tue,  9 Sep 2025 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iNPWWGqn"
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0436E25784B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453165; cv=none; b=fUsIS83kfoEUoNb7BDim3z5wu9q7qOPdUzu9zMGP/6zrR0mn+xmIZh3mIcy846kOidKdTsAqSe2tDl2UeTRGxHk+mKbUTratIDMUWhF2Fhh73IYy+SE+2wuozX8wsyzYivSHeTc3E9/7F23lPnTmK2WL9EBkybo1dT/Z8zu+oz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453165; c=relaxed/simple;
	bh=Ch+WWkLXleWL5addBiUiXk58BipmrswuiXTk/DPEo+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VEj2DzrTT1wOQricGE5pG/FpkXtD9I0ydHWRdtTjaGvkZ3eb15nEHXgAW2LDsaomJqCgXJJHoPmMvV5PM73zuMfE7n7ZGAz6lawSsG9X6q80smlgL8veB6u6v1lfVd/GmzpHuEsAi4Qprjy7JbHo0aGu7GdWjboJuICOXC3kHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iNPWWGqn; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-71b9d805f2fso54297686d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453162; x=1758057962;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wEBL3qJvgSuPYBB2IE0AOyRPFYQUDIJrLl+44PVzXH8=;
        b=l32BAUhq5lgPBjHAuLQTc1HxyScXtWeqfGBm+1oLUZbYmmyLZhJh+yVdfvJYOPXS/4
         634zlRdjSklgqQZRWzGs8opSsTuWL/nf+DNbAfBdHh6LyEIDuHKpsMjYmBsE6ibeM8ZU
         Rtxy5VGuM4pGwrAQkoMHkYhGFf6BFz9cqP0IK8Hd5vFVLICLOvJy9gWD5v7CsD3NB0YZ
         bVsc6QWzjRzdxMHMVBcZJieL6vfsoHxvNXi2nvz1hY3wlkD8LScma2v1w5niNwwiwBfH
         SLf+ccYBmY9ZfBJZEKi7nj9F2C92rt+OD0V4ml7n8Mw9gGoe0j2zzP02E93ikOcrIDVV
         Vrsg==
X-Forwarded-Encrypted: i=1; AJvYcCW6TEDjZJdzHQabg7wiWZlqUvLy0ywwsIQxO8zmUROF1QraAzMWIz9qGHqL/fqXWsB50gnvcC3tp++snFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJDqGXWPnVUxGt3wGMviBb4SpOpJWIbyaXt6+6nuhm2tNBi6m
	0NbdwFLNMInrcxt1Sga1gg4GGmab+flvywhYNvHMbrf1u4TCGCRpxDHhzltYLHCsFxP/h0tjGJC
	1T7XGZ1wKQwGgI3GmNS/KDcTMXvaIiXcVGMq/Rst6gUyXPLmR+AUtdn6rMEtiVh/NzoyHPT94Ji
	bXj8XN8l+hAHDQDSaXkuAoLz9Alpn9THnVh4RZXmcHEatXB85HoU8fmASfoUl4Mz4A/ID0qGTyy
	lBt/0brkSpkLIWMHaIk822v
X-Gm-Gg: ASbGnctlr/ZB/Dq2BlVul4v6QkD89+Lf8+7PAXCSqZhhDfOrc39r9nqTe40nI47yPLN
	mFo0+6ljEpcY+1G3ateCP7GTra9Z9VXFMZWjgssBt1UqF3ssNV11uaPQJfE7Xe62CRO2jwqXcmE
	KvrjpGrOQgYo31s0PCJJksgK3IWPWnbEatIRbJ75IQx3KDQXoHaoE/BgwtHBY2Fcq6eQmrXyhsJ
	MSl9YGgd7EHgS8VltfKdB2gli3BcpPZNSKDr60WQq3RMWsd/V9gjdI+bF+0zGGOjIp8VI8FjZTp
	r3qFgzNcM3F1ulXiXY7DjsN9j7Eu6okpvrjDj07oUaEuqpazV+99n34ncZ1c4CFNiCawIlq2htY
	0bPIAXcyDidIsl5QBj+4ta5GNUYI16W/IwHkD7CGlsOBg8Pv6X6VhEytXdjxpuETZ7yAOYIKNsD
	nEMN7j
X-Google-Smtp-Source: AGHT+IFtsfezQ5V32UfYl4PS+p6NFrZRz/oMYAzRGEaamQjMthZ2EgFNEJTTAJMsvOcY1W8WAWaxsyNh4icB
X-Received: by 2002:a05:6214:3008:b0:70f:a780:4f0c with SMTP id 6a1803df08f44-7391f303fc2mr149113066d6.5.1757453162538;
        Tue, 09 Sep 2025 14:26:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-720a30b943fsm15795066d6.0.2025.09.09.14.26.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:26:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b52047b3f1dso8128770a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757453161; x=1758057961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wEBL3qJvgSuPYBB2IE0AOyRPFYQUDIJrLl+44PVzXH8=;
        b=iNPWWGqnlfQ/ox/cMpD/b+8JwzUq36qrkZKr8iOqCODdIbTyZHsC4D0ie6R8FyJpNl
         wTf6S9YOuQ3GfekaM1rw6mR3cLi6rAADwzI5NJdXrlOWwoPEnSEZvBESLIGznOYg0Y/s
         6exjJin/E2p4CzhUvnwFcwCXKxnYcub2EWf1A=
X-Forwarded-Encrypted: i=1; AJvYcCVPX2COejcSpoCGOzUCVbkY9bMjoIb1YT8inHM8BLKsjPvhk2tBQ/L9Tr5q1kwgqPE2ti/wp7cH3I/yHow=@vger.kernel.org
X-Received: by 2002:a17:902:f549:b0:24e:e5c9:ecfd with SMTP id d9443c01a7336-251728629c4mr169828385ad.42.1757453161388;
        Tue, 09 Sep 2025 14:26:01 -0700 (PDT)
X-Received: by 2002:a17:902:f549:b0:24e:e5c9:ecfd with SMTP id d9443c01a7336-251728629c4mr169828075ad.42.1757453161006;
        Tue, 09 Sep 2025 14:26:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb5efe61sm108217a91.18.2025.09.09.14.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:25:59 -0700 (PDT)
Message-ID: <f8e28893-2401-460d-8511-9b390e091b4c@broadcom.com>
Date: Tue, 9 Sep 2025 14:25:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 2/2] arm64: dts: broadcom: Enable USB devicetree
 entries for Rpi5
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iivanov@suse.de, svarbanov@suse.de,
 mbrugger@suse.com, Jonathan Bell <jonathan@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <16d753cb4bf37beb5e9c6f0e03576cf13708f27d.1757065053.git.andrea.porta@suse.com>
 <c6b17f0f896b5cdd790fc10aeb2b76b71df9b58d.1757065053.git.andrea.porta@suse.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <c6b17f0f896b5cdd790fc10aeb2b76b71df9b58d.1757065053.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/5/25 02:42, Andrea della Porta wrote:
> RaspberryPi 5 presents two USB 2.0 and two USB 3.0 ports.
> 
> Configure and enable the USB nodes in the devicetree.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Applied to devicetree-arm64/next, thanks!
-- 
Florian

