Return-Path: <linux-kernel+bounces-885522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C2C33332
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3CE18C56B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD1A2F99A5;
	Tue,  4 Nov 2025 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yv54InIM"
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551022D3226
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294831; cv=none; b=iYHRuuj3OwUC2TjPobHsqtUUo6/UXMeuiBn+TyehzZ/QTOjrXtiW+kxKaXs8fr+vCA4V9s0moVvn488RHbplnT/BcUk+U0CoFByrswZSSLXsSEeuSasbcG9V8uNRRbyUgsF+3cvQ6kQwFsnUDQs+ELm9KLNrPa3dYMc37lWE9sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294831; c=relaxed/simple;
	bh=fvmFMRdBfy+IhGl7269KYXfkQHpYiKUD6HeURMEOop4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9F3crjT1h1w8Vi3eYmcwQmtr6W+eTKTdRGClL0IxUpvLLxKiQBrrIsyVcITsj5oFttzhV8B13Bm7Om+s1Q9zMNFeamNyboOdHGgeUr/w2CvFwS+E0P73S5pqrrOBXy41n1vodPqKUbbV4eaLo3p/Mwl46EzyKdSZ1g2ntHCPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Yv54InIM; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-29586626fbeso30055505ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762294829; x=1762899629;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tN8WzZ9GEpKaJgdfC1znVVrhhkhAJwlw/zZ1qhYY7To=;
        b=eMeExMYGBLAHIt3Km32plrDVtZSITsnItvENt7FLEgaQxucpVH5rYPhcfZB3eibBnM
         WddB1GFVgUF5eo4ytZ31EnbIZ0fJIqta8bYwhM8Rco+8/E+bsac34r5ENmRXybWkyawn
         vj3S5FDtIojMQKOBlIPm+c/JoiE1z3Wy5dJCHQ67/458h4m2pZAPNTrqnw8gR5qi0Cl8
         92RwixGaMFrx0Bf6XuIET4un8v2tAg33ajWMfb0wU/TYmfG33PWQ6ge3ZiicXiFYdBVj
         0NEeegA7fCLkbkEMCuh4yzOAZ4YdhBmwYCKVlSb4JlO8XShPjYttvwB91henmSanYVLe
         g4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVcojdE8Dkpyg9xRhpyYznFiMspcrC5x+fZv4B8S4033LfFXfrUNvffmWgp9G3qbneqsB0vzCPk5yzZ/ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEqSNjcc77ejYT5mKWpI2rfNUx+QzaJ6M3JG7c+7gV5HYujSY1
	UkHtW2t/wyDyGqVUTTyXwQpm41+jTKi5LGslXSwm8EcbqJLF4cCstdRnfFkzEcKjcH8QhqeTor9
	iSjYhpOtntt+Tw0jkr0VxZ0RtGFqMda3muVOYJQNctkYtUoiWkgWw3SXQNFOixZqAS1QCkvU/yP
	dB188gEYl0XoNEOzzJsPIU7MYKdx7FpDvlMqPRbDNq9WB8EZ0+g756NBF7y7yZPlOz8lnk4xa5k
	XK2K9EvDyO7cCFly6Bjmejz
X-Gm-Gg: ASbGncv1IsUzmEgsyoGGk3/bRfQ9WgMuHOg8zC1Lrgh79r23/4s2Tw7UcAhsWyygr/d
	B7IE72RmeGB7ROFGEDZ6IaeLoeKFe2/iU5FNPazQ9Gv0c1qBnhp3gcxaluXWUcD3vd0eeW99SA9
	rkX8g6KxGcv/QDDCo6T1Dn0XEjA7XaPSPVz4zvHz1esvIGgZV8Rdi3ZiCoE8VElee4SPUvTofjf
	uujM3V6eLOqPkIa5JIqChK7vGbAP4KIBVGrcRqMXkxztnBp5HD9fplpOICdaehOcI5nF1UV/ii0
	qxscYoK6eK70jpYraRXPwJOnwSACyzTEtKZjTB64CHkTNiaUuaSiLH6m4cOYMYVi9o8QgvPx0AT
	U+sW3zdyxEEg1DzCCPfxgN5+uEh0wSqSX9PlBWec9NhNRaxilw9anUUmYgJ0JlVH66xk5sPbL7M
	vtiMLPup5u/P034oy86jWCv5NaUDxW40MO3irRyKs=
X-Google-Smtp-Source: AGHT+IG/V4w1xJtT5YvJyFdhBOFq78Bc06OFVKOwHaG56EKnpgMQKTkD0uq6hLqGEuzWuWR61v6eTE/AMKJe
X-Received: by 2002:a17:902:cece:b0:295:73f:90d0 with SMTP id d9443c01a7336-2962adb837amr12963245ad.50.1762294829369;
        Tue, 04 Nov 2025 14:20:29 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29601a6a38dsm3236455ad.62.2025.11.04.14.20.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Nov 2025 14:20:29 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed6ceab125so18676201cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762294828; x=1762899628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tN8WzZ9GEpKaJgdfC1znVVrhhkhAJwlw/zZ1qhYY7To=;
        b=Yv54InIMjRYfwrV8P9dhrZK22M1HXm3VBtN8HhvrxKS2+/1UHZo6NVLFnaoxwM6Bpi
         K9BR3iI7e86JBNABl3lAHdDblZpK53Vnc6W3LX4IZwDaOfEtOd14GZKaBQevnUUZet7Q
         zbtj2KiNp6ec4NTLSMSM9aWuwcklQzdAfVN9c=
X-Forwarded-Encrypted: i=1; AJvYcCVRsn+cy2/+fGHcbgUOeQCdQ5GijB3DmsQmVcvmvnyogAP/1FoaaI8WGwdjlHw7ArSba0N+A76iKB11T3U=@vger.kernel.org
X-Received: by 2002:a05:622a:47:b0:4e8:ae94:7560 with SMTP id d75a77b69052e-4ed7264c433mr13277421cf.83.1762294828047;
        Tue, 04 Nov 2025 14:20:28 -0800 (PST)
X-Received: by 2002:a05:622a:47:b0:4e8:ae94:7560 with SMTP id d75a77b69052e-4ed7264c433mr13277101cf.83.1762294827619;
        Tue, 04 Nov 2025 14:20:27 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fc3c8dbsm24129701cf.36.2025.11.04.14.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 14:20:26 -0800 (PST)
Message-ID: <3e538ec1-37f6-416c-bc04-6f21a4d31748@broadcom.com>
Date: Tue, 4 Nov 2025 14:20:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: bcm: rpi: Mark ISP clock as critical
To: Jai Luthra <jai.luthra@ideasonboard.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251028-rpi-isp-clk-v1-1-2a54fecb495c@ideasonboard.com>
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
In-Reply-To: <20251028-rpi-isp-clk-v1-1-2a54fecb495c@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/28/25 04:46, Jai Luthra wrote:
> The ISP clock should also be marked critical to prevent the clock
> framework from disabling it on boot, which can lead to bus lockups when
> the kernel tries to submit buffers to the VC4 ISP firmware.

The commit message suggests that the driver that interfaces with the VC4 
ISP firmware is not ensuring that the clock remains enabled for the 
duration of the transactions. That would be a driver bug, would not it?

> 
> Link: https://github.com/raspberrypi/linux/issues/7100
> Fixes: 919d6924ae9b ("clk: bcm: rpi: Turn firmware clock on/off when preparing/unpreparing")
> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> ---
>   drivers/clk/bcm/clk-raspberrypi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
> index 1a9162f0ae31e330c46f6eafdd00350599b0eede..dcc3ae5fb91650b042d52f02499922786b43afde 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -151,6 +151,7 @@ raspberrypi_clk_variants[RPI_FIRMWARE_NUM_CLK_ID] = {
>   	[RPI_FIRMWARE_ISP_CLK_ID] = {
>   		.export = true,
>   		.minimize = true,
> +		.flags = CLK_IS_CRITICAL,
>   	},
>   	[RPI_FIRMWARE_PIXEL_BVB_CLK_ID] = {
>   		.export = true,
> 
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251028-rpi-isp-clk-eb5c48346e51
> 
> Best regards,


-- 
Florian

