Return-Path: <linux-kernel+bounces-850981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B95BD54E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 773A15832BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18AE3128D8;
	Mon, 13 Oct 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kre7dE1R"
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0DF30C60B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371000; cv=none; b=TZL0wwbmaHmErDX3vA/ERiAwbqE/mRvI7mT47ar89dHcUrOFSjv64sxuXrcWhzi3yD3pVJsrmSTSZiPSXjPylSHqSZSEyej2bR+iJM4/gq9CiiF9o1pVPBp499CRoEwN1Mp+T7OdcrNXDtH3mNJ+6ZhZGBCnnlI+ZaRSwplkpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371000; c=relaxed/simple;
	bh=5l2IO6rlWMrM/eSJDopEXZatNgquKvMA+A2Det19oAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlhhKLGhnuNZBLMaIWC4E9ewtQLUYCLgZtz+Iq1ifpFQ8tzMq/sZ8TLS/RvebbvGrEJQirzitz56RmB4PJjDvTkAhKhiIVVgVKmTuERAciPKyrzgQFZZvnY+HX0iwVPY8BElm5Hfldac5LRQNjsF6hcyXxRlL2klGiIUjQsfCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kre7dE1R; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-793021f348fso3935844b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370998; x=1760975798;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbq36YOBHD5qN6j5t7C56ycvnSIgHVVfgOJRpob4jC0=;
        b=YZyLOdblQcQzCX2XB+gjqnxdOdHQaPT0T98yJ4GpFPqpChOLH13B1hU/dkVSidu3f1
         44WPGxGejf8FihCi1+udd136+uX1wCzNVJY2qUOY5lkhw6aXldjSfJOQK2MVQjsaHNLO
         MkJxwp9Sb1rVW5zfkyNy4Tzy3gWAK1XZvZts5YaPUt9sveiB4ZgmaP1KNQz9h2cIXAbX
         Al3ixfGLT4NTY977qh/25bqLtBEkxbXA0UuWSNgKMIVSzWm7QvRJorl4rObEjqcPYkTA
         yBfR9rp1aWequBIThbuvX9VFppaGYKecmAj8wf3LADFIq6xMVojdS5NuQfXH4u7cl77S
         yN2g==
X-Forwarded-Encrypted: i=1; AJvYcCUG4hkaNx8yNaDBpaTJXdUaFBgs3SlIg2csbaicz7D4JjcKBUrnfEyg2pFJEEuZGnKs8AhGYIZgq1uzUu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHGW5mPIUTAyxhv+aYl0CfpDMACpAezoAnTiAljViQrGEoxelD
	X6OWi1z+SnDvsDMzx7OB3epxLcEb5cfoiOs5zXqLWrIMQNCRGyp/Mi1KFrndfSyOe6pwlL76Lc9
	AMsaElh9TuA4xOnefkFFEZnOMQCK3czFKtcddVlYhxMesULBzP+BwLkRgu0dXrJldvWVSnCwO+z
	FAS2tRd5mX4m+gV1ZNK8PIbDh5XCONKqRoZz8Bx42qQSJ7EsdCedOc6buARRseiXEmCMzZukHIh
	XqA9REXJDxlTJTLI1axUSKu
X-Gm-Gg: ASbGncuQ/dE9pzjk1spp+9sI6vldw5IzkWcqz596AurR2Fa1p3fEYiXZddhCh+cOtjE
	oo86rB980sMEhp/JzXGYz+ljZW0dUkQJUMV0j7oh4/CPYPC3R10STcxqKvfAgtbe4PkXtLeJ4Gq
	aCAT1aqZk1wABdFWwxl+B6zSVIE30KtP9CKEwEHSQQRbEwdZ6AmRqUud6RFELGAj/06LOwDKrk2
	7UnRq/8mvY8hJpq7afVLXfqaPj5gff/PGWnOqKarEu5Fz7TmCRDPBm+7gVeRAmyEc+sWslTEFaB
	QJITEYyUufRepw8BvHDDM+6NkoSr4lJ8uB3S08pdASwIGjhmUx8eSP+yx2vmjHWn9+qiwvhX0VI
	TfozkIgltnwXP7oimydn8kvKslGqQai7wMCSPRZ0ph8cdMY2rBzOd+CSobII116w0f5Hh5pSu7r
	3hKOSS
X-Google-Smtp-Source: AGHT+IFk8G7kt8DRo5O9lSKOD/Ye977hI3EUZQR0QzxSdj3UO8Po13vgT8fS7OhO+hnWxrfOKbtqoS/DzV7X
X-Received: by 2002:a05:6a20:7287:b0:2d6:9a15:137a with SMTP id adf61e73a8af0-32da84ffe6bmr26608329637.53.1760370997998;
        Mon, 13 Oct 2025 08:56:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b678df59072sm563838a12.14.2025.10.13.08.56.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:56:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27ee41e062cso110933595ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760370996; x=1760975796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gbq36YOBHD5qN6j5t7C56ycvnSIgHVVfgOJRpob4jC0=;
        b=Kre7dE1RzCXkJK42/9730IbSWWdnqcpEqxtODx8GBUIwC2VXUegKPcKnfMv/VYDRUz
         Wag5FViddiL90mt6ERmu5fvOmzipGv75BPs7ZbH+totIfgKq52K/2Y+fdtBXNR3WVrL7
         HNS38+k6hgDCQ5HNz9ZHz5e4AZ4Rj8p6xDdco=
X-Forwarded-Encrypted: i=1; AJvYcCV+pqfn2mbCiJIQ6jKBZBd+qkF6gP2QYBAEwYhHrf4JMKjgh6wq5b+LTlV38WHUfVOv/oxWS/a5+20YCVw=@vger.kernel.org
X-Received: by 2002:a17:903:2c0d:b0:24b:164d:4e61 with SMTP id d9443c01a7336-290272b27b2mr270728435ad.13.1760370996196;
        Mon, 13 Oct 2025 08:56:36 -0700 (PDT)
X-Received: by 2002:a17:903:2c0d:b0:24b:164d:4e61 with SMTP id d9443c01a7336-290272b27b2mr270727945ad.13.1760370995676;
        Mon, 13 Oct 2025 08:56:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f0713bsm136797625ad.67.2025.10.13.08.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:56:34 -0700 (PDT)
Message-ID: <9d8a9d07-ada0-4d02-a0f0-76fda0a070b4@broadcom.com>
Date: Mon, 13 Oct 2025 08:56:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] irqchip/bcm2712-mip: Fix section mismatch
To: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Changhuang Liang <changhuang.liang@starfivetech.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@suse.de>
References: <20251013094611.11745-1-johan@kernel.org>
 <20251013094611.11745-3-johan@kernel.org>
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
In-Reply-To: <20251013094611.11745-3-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/25 02:46, Johan Hovold wrote:
> Platform drivers can be probed after their init sections have been
> discarded so the irqchip init callback must not live in init.
> 
> Fixes: 32c6c054661a ("irqchip: Add Broadcom BCM2712 MSI-X interrupt controller")
> Cc: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

