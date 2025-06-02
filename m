Return-Path: <linux-kernel+bounces-670913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449E1ACBAC3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 20:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849227AD744
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A7022A4EB;
	Mon,  2 Jun 2025 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WuUAPqPT"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A6229B0D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887572; cv=none; b=JRk0NNPJLCn12pYWO1a/oVJ48xM9/0mA6jxmUjNOY1d9S4pYVIwPH3PfQthIV/pC3DpFOHHWrEWUvFcf8NPhpzsEDnlibwkIRyHgmOGQXssOK4z0ZnRQ5OY8ezEkX4jTOZC0hYn4y0FBdsq80oAqhun8A2ttl4G3xVBOqmT0ofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887572; c=relaxed/simple;
	bh=XwmDGXznqEWTw2nfNirknvPgvCboCtPXEHBULgARSC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m46Dgqrr6jZr7qxJMpiE3Jv7Z7nES/wqPAla5Dk7G5JT0KTPdU0AaeCT/2kRvQZ74uBI8xeVP7zm0iaJv6OPMMkpLm3/FzzFTaFRMVBVBS5SL+eVxcSMRD0LUS9ulE1ztdmBLjmJiQHQcsqDipNNLk7SROvK+/EOaYnYxVTj3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WuUAPqPT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7426c44e014so3785819b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748887570; x=1749492370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vWvKiH2Mm8EbNJ5RtFQE6GZhlIE3IosIvfbUm9RBQRk=;
        b=WuUAPqPTfr/LgjUcYl/ZD51PpQuRIGYDMKvOrF88wJk6Cnz7G/WL/6VHLLid9Ck/Tw
         e6NP8FoFKdjvtNmc1cmyaR4YN1qhjqJ9FuIjqcDPuQio/aMONP0nUjANaYyTswPdmqlo
         RMA8LjalP/rdz7bokemTddrlLe8Bbrzw7rjwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748887570; x=1749492370;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWvKiH2Mm8EbNJ5RtFQE6GZhlIE3IosIvfbUm9RBQRk=;
        b=AdkzAOYPqIgnzRcGWrpSAowisL5wQ6Wn7REVe44adZDI4h1RSirJ1SNXdaFM4wHADL
         L8KhQXJo0VnbRLLX5JKDjdwFXOw0ZhggXMST5N3IdOhRdoARfr/d1pAhOvAt4URpOZLa
         K6tvQ7oFD+6nPxUL6w553VyVw+DbdygpPFYNaXgK49IUi0+EwJz90Qs0m7HmsbUt5QGJ
         ubuPGJCURDHhehYW+RBytJ2Q888p9M4xXCHxKRyntlb56HpkV+ErRowjMIskr3EfSnlL
         9Nq3kqtBcA2t5ENsHma8UIjlvshyQfJmR1FmeZhL6EKodg08xBD532nq4Jb9YRO5Mboe
         of2A==
X-Forwarded-Encrypted: i=1; AJvYcCVATnU5O2ykUOSH0OOZR14s7vGVO5y6rTEWT7isXkjlFVU8wH2Lmf3zBqbuHarAG0SnZHeFGdH9grBNPg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0QuEJLsFXdoeqM21DSTzO8Uqef1ODnBFR92MTKjnW6zG8WLI4
	1BPF8Dl1qSfKehdW1tuTme2a8NdtGmD4ZfHgDxTDbD20YfP/ZRidjNTRRMmml/dNLw==
X-Gm-Gg: ASbGncvkpLUct9YcvgBBpww7I6p2NymKKsYP9J3YwUa65W2ZHTeoIxBfU8yiwtUWuUD
	fQOAwCMNg0cvnfmdPk90w/0KE3Iyfy9qeLca0bDs/yvjgUOe2MJJ25KU/sF4tt9pCiHO9m4IP/Y
	oPcJlIbNfpRORvCLn7yaYhqzTkiHum86OY+UUklnYeTwoJRIGg13ur/xYFr2KwYGQivWN8kAT4D
	XGG+0Gr8P8bXfb9tKFEF0FPrrHRSlM+mtp8fJrdThAU5XPxKJZLu6zMLti45kMd45VW60MngnEZ
	aQros5P2Ix0V9Ts91XzHpqzrDAX+zbfiQaJBUpbbf97OQqDGnSbAVk5aCVj1D+4Mrw9BPxrd2y2
	kA5uq/ebEIXS4rek=
X-Google-Smtp-Source: AGHT+IF4+zdbKfHJ4X+31cSpPgVaRuv+nJ8qz+s+PnOZiduTX+UreaCQFduqwwpQTiszKthZ/dcIHw==
X-Received: by 2002:a05:6a00:a13:b0:742:a23e:2a67 with SMTP id d2e1a72fcca58-747bd9e6da6mr18299998b3a.16.1748887569926;
        Mon, 02 Jun 2025 11:06:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff7459sm7900776b3a.169.2025.06.02.11.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 11:06:09 -0700 (PDT)
Message-ID: <5d3d04c0-d9e4-4f80-8ab3-7bedb81505b3@broadcom.com>
Date: Mon, 2 Jun 2025 11:06:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/10] net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vivien.didelot@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250531101308.155757-1-noltari@gmail.com>
 <20250531101308.155757-5-noltari@gmail.com>
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
In-Reply-To: <20250531101308.155757-5-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/31/25 03:13, Álvaro Fernández Rojas wrote:
> BCM5325 doesn't implement B53_UC_FWD_EN, B53_MC_FWD_EN or B53_IPMC_FWD_EN.
> 
> Fixes: 53568438e381 ("net: dsa: b53: Add support for port_egress_floods callback")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>   drivers/net/dsa/b53/b53_common.c | 13 +++++++++----
>   drivers/net/dsa/b53/b53_regs.h   |  1 +
>   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index f314aeb81643..6b2ad82aa95f 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -367,11 +367,16 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
>   		b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
>   	}
>   
> -	/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
> -	 * frames should be flooded or not.
> -	 */
>   	b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
> -	mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
> +	if (is5325(dev)) {
> +		/* Enable IP multicast address scheme. */
> +		mgmt |= B53_IP_MCAST_25;
> +	} else {
> +		/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
> +		 * frames should be flooded or not.
> +		 */
> +		mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
> +	}
>   	b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);

I don't think B53_IPM_MULTICAST_CTRL is a valid register offset within 
B53_CTRL_PAGE, or elsewhere for that matter, do you have a datasheet 
that says this exists?
-- 
Florian

