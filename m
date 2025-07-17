Return-Path: <linux-kernel+bounces-735850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA548B0946B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF2A172FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D5B302CA7;
	Thu, 17 Jul 2025 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NzUrke6Q"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2811F0E53
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752778071; cv=none; b=jEguQ/ficBy654aKvKDFhGyXkAp/jAVZ0PEgV59tfVeLpFrwEyKTT+9Dg4qYvw316U4/NmEKo6iV7c2HnfpZJ3JAVuWlcwtOlZYs0MXZ/FHCkUPqB32OqUTrQSFsM0DkPM3IFuRizsGdz7SmMpx3fj+JQCRk3rr98/mFHBbPiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752778071; c=relaxed/simple;
	bh=LdBhSp51sgIxbWO70ik51gWkwXQAZkXdQ9kZ0tOT0fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksata6Mvlxp4V+qzOTGLlt7YmrRtpUcDiWpo2sZ+LPFaSBEyMhyTGPmITX0a/A0ex/VHu7j0NQrCLJrhRpUwiKIlQmfu1o7VsZhqnSYxN3lxi5nwIDBWhz3k5XMBKs5emGbZYG8/AJoGjSHkE7tBkJXfI/0UETKhO3t+PsW4k0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NzUrke6Q; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70478ba562aso24938236d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752778069; x=1753382869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JknLTMIxalS8m7aHFC3+s6nvFC/sGZyolLVvw55splI=;
        b=NzUrke6Q2i7Kz9RJmPyUQqfzbDBjhODTPk4w1gauD+c/kAxCmQE/fNnXNv4KoyEN0N
         Us+XP4iW9/qSFvP5zOqURbvYSPKFWS34t5GU96xWzCrm6mdu4OVyHLAWX1dbHfAshe7F
         Km2volV8bc5AqCMcNqfaI/75DNPcVAigJArpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752778069; x=1753382869;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JknLTMIxalS8m7aHFC3+s6nvFC/sGZyolLVvw55splI=;
        b=nmFOCaLGmgHViCWSOef6DD7Hwu1tgfm2YSjRnjmQ+sXd1YjllsF+bAmXO8lzBgAvXx
         mku67Yixo7D+j+iGZj89y7+Yyb/DbCBRSNn8D3EOVFxX6GbolbnakMJDdvs3ya8lC1DN
         FjLnKnEEfPG95iZoXcpRh+kVomTjdFFjIsw4n4ATM9UCMtoVfqvklYETjeR+uOMMiICj
         ZuVjkz+2agBbRoFfrg2YTLz/DWK2FFe3g6qSlYawfm/t5b7STjgf2shoqsknaoxK1lhA
         qCgMOgt0ZHf6aWFeyaJeJZKlypor6q1LpOTfFklOSXglu3JBzse8+hJBYFZSgjRZpluE
         c3Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVuXL7c2ZSZRRb7mLRhjR5pxuF9HKpYmj4CzPyeta66LHunBGTXCVo4+POvQYHrwvURWp33b6+Fs5GZaf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87+hgf9x8hBAlGBIKC8yUEXYfJdfXRL5AkpJk6gZpVMmbrmJV
	n85lnNjbegwfdF5xluOMPeEdheh1w2/IlIyQnNo+0tfWU0hkhAqTfSJEYaxWOgR+RQ==
X-Gm-Gg: ASbGncueJ1O4o2L6+TfH0SCTO24KN1fekIQHiLgi/U/Nr9oGVQO4uXzBXyfMJ9s+TE5
	uGd0MkKIoCoyPKPP2ZQZIHMYqY0g1mR3lH0Chh3a364lbZawVibiHoNqOeEECxd3QSiUjEvi+Eh
	zJudeN+lJPk1hLlCz/m4SZk3ACvu0Os39Qfet4YV/y+6W/V6fpWcAvw/M9BPyOxqmbQkScxZc0Y
	2wzglZaV3h0UDI2b9L78GWrmOWItm+T+t8E8DmwhGKWvFtwCbLqPf6PEM7fRqODjMHh9SOqGLox
	UU7ZX7OwQpIu3N6IEM5lNvWKjejjRPzhIgib41WZoV2WnfAn4nnRy/yCO7ICNHeHa+O5kVmuGHg
	7YQ4a52q1Le6qWt8zRJ23e+JssdDMi7snEuLrPmK+0m9d8PJ2GiAud4zdh1D52Q==
X-Google-Smtp-Source: AGHT+IFDwAq1THb3IWIpQF0E9OZ0Tl++RLOgxwEZiStS6SKC57nMiie5HsehYdbEwen2VMn2oam5hw==
X-Received: by 2002:a05:6214:5098:b0:704:9584:c370 with SMTP id 6a1803df08f44-7050551d1f1mr61874956d6.7.1752778068551;
        Thu, 17 Jul 2025 11:47:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497db12ecsm87656826d6.102.2025.07.17.11.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 11:47:46 -0700 (PDT)
Message-ID: <af7e4420-b773-48dd-aaf4-269f63c624e1@broadcom.com>
Date: Thu, 17 Jul 2025 11:47:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] net: dsa: b53: mmap: Add register layout for
 bcm63268
To: Kyle Hendry <kylehendrydev@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com, jonas.gorski@gmail.com,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716002922.230807-1-kylehendrydev@gmail.com>
 <20250716002922.230807-6-kylehendrydev@gmail.com>
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
In-Reply-To: <20250716002922.230807-6-kylehendrydev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 17:29, Kyle Hendry wrote:
> Add a structure to describe the ephy control register
> and add register info for bcm63268.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> ---
>   drivers/net/dsa/b53/b53_mmap.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
> index 09631792049c..35bf39ab2771 100644
> --- a/drivers/net/dsa/b53/b53_mmap.c
> +++ b/drivers/net/dsa/b53/b53_mmap.c
> @@ -27,9 +27,26 @@
>   
>   #include "b53_priv.h"
>   
> +struct b53_phy_info {
> +	u32 ephy_enable_mask;
> +	u32 ephy_port_mask;
> +	u32 ephy_bias_bit;
> +	const u32 *ephy_offset;
> +};
> +
>   struct b53_mmap_priv {
>   	void __iomem *regs;
>   	struct regmap *gpio_ctrl;
> +	const struct b53_phy_info *phy_info;
> +};
> +
> +static const u32 bcm63268_ephy_offsets[] = {4, 9, 14};
> +
> +static const struct b53_phy_info bcm63268_ephy_info = {
> +	.ephy_enable_mask = GENMASK(4, 0),
> +	.ephy_port_mask = GENMASK((ARRAY_SIZE(bcm63268_ephy_offsets) - 1), 0),
> +	.ephy_bias_bit = 24,
> +	.ephy_offset = bcm63268_ephy_offsets,
>   };
>   
>   static int b53_mmap_read8(struct b53_device *dev, u8 page, u8 reg, u8 *val)
> @@ -316,6 +333,10 @@ static int b53_mmap_probe(struct platform_device *pdev)
>   	priv->regs = pdata->regs;
>   
>   	priv->gpio_ctrl = syscon_regmap_lookup_by_phandle(np, "brcm,gpio-ctrl");
> +	if (!IS_ERR(priv->gpio_ctrl)) {

This check IMHO belongs in patch #2, even though it only starts being 
useful now. Up to you, and depending upon other comments.
-- 
Florian

