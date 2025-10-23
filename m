Return-Path: <linux-kernel+bounces-867451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD4C02B03
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852B31A6012D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D392272E61;
	Thu, 23 Oct 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VMNfS4Ld"
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBC02EA15B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239703; cv=none; b=E6xLoWOYhPBEV+/726yOM/OB90O8/4+/zNuwGvEHkg2Rm7l/ZTF8F5MvuTaIHUgR2kWvZxtqDCCabiDorkuvdjFj8QjlGd2xShX9+/vZaok93cE6USSSd+pAaNpYfZYJ4s6skSyqDJk6GSBmHyh8MEW9guSZmz7mU3IhaCa/zvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239703; c=relaxed/simple;
	bh=xpyqE4urcjM8D5/gcCoUVHV0uooFCUzjPUtot4aamHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1lJNaOT5/956wt4oJSfzD60vX2ro+eDsAXV9GDOFkUHihX7qdkYeATTLEulV8yfVVr1d1sg6tfp0qWXeZ/nikigCLlm9RrcnPS6XrzeeuDZgvIuqeSyHQkw0bmvbRPXg4EtOANTEOO8VJzC2VVd2NlXOYwqdWJ9adUme4fzlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VMNfS4Ld; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-87a092251eeso27837996d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761239700; x=1761844500;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPxNaEMIYukDTxjz6Ki04wfL1rNKy8pXkq3mZiePbWY=;
        b=P3VNe2m3rA5i+5raOnSm3KQAfWCWrXcuOBFuvUD20BgpQjqBSTDjfCQILKokba7wGi
         /Uaux1abwJ+CZL5tKasUFco31wGidxtmtBhx7zCmA/kaN9+G2S/bBG6VHihRZcF85h6K
         t1kV+YqL40CBLjNlSOzRmVJ8Rankt4Q452MZ2ggED+oDpn4f+oboYKknwiPnWYpO5njn
         7BInqBvllIW7sREPWGJ5gbNvFnm3LSww/bnAwreqt3vEP4rW0WetUKgQ6PVgS1UODNiL
         zixqs/GlUVS6LRybqVlEC3HtKKjZfiWyl8cRsMjZXnutY6tKZ5PMezp5y5H+q55GHDSO
         5G1A==
X-Forwarded-Encrypted: i=1; AJvYcCU4HKBrVTGlwyTeSexnOy9MKZ9QLTq9D4520PMjc2hvOq0l4YUmasDSmFsGPfegjbNJha/W9MGY0YBf78E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyrdtlsmLWG16Rn4W2ifByTOVbuAKJojdkgURBsxZ/3Sd21JPn
	wWMqmOw6kWFbu118NQfhVesZL3fcVSY5Asre7FV9s0Sta8RsbZUbSVPrrAz3A/cvfzQJpCm3ClK
	bBQkPHUsGkX8nXlX349TzTHrifBZc3aYSwPU38kgDtFGuWNV7M3PzgwZ51ksn86jzAdTuSfnNfZ
	sLFbuvfUf3xy0C68zXO9qNfJuSTdAK2qWF3YshklP9tvZU5+ZzPAE2yM47b1TukVWz675g1QxdB
	ZwmD5Bl5QXxiDQ8hin8Cq2y
X-Gm-Gg: ASbGncsVSFTdEqNulnbeDu42HcpVKV15GMPJ0IzWuhlzxQ9amQgcMFeWGSfMxD1xW9v
	LJ90beBeyyhs9hPD05FVbo16fy1uday305KI8CwLa+o3wvrokibHfR0aXeOUkHuvKM2vjIObwPr
	76FD2VK2DlauvMdxy5KocP8ClmS3K65r0MkgcJ75vG28XTveM5kVqNI3Y0aDTZ2ZbRLPUs7EXNP
	1OWdMx71SCfeKU3N/Hc/A6bCsE7TKgK4lEkKG5OCMe7BZijThXPmoul3GJwEBhmfKWammHbaMnJ
	fIN+VJ3zbrFiCAmnniCx7j+RrBmvqnQqzdY+JREiBKsPMe1ZCzw4MDB5oAbJNqiOXvOZox1ciN5
	goODq+hOOm0Ipb/J4YtnPOoFWz7/X9tQk9OvSSEXeYIiJOKHEjRM4e/oCNlBNB0F4qhMGL7Zkt8
	TTdkFnbCJhIzVlmUsvg6zozi7NyCDp09KEx/t6k+brKg==
X-Google-Smtp-Source: AGHT+IFSHAVbpBnLBiT+RvG3vCjUEZWbvKPIzGCxKa5GcVz8o7xQ85gyp8NPrAmCt5ZIQD7cR9DTi+UfABqu
X-Received: by 2002:a05:6214:e8e:b0:87a:97f:de8c with SMTP id 6a1803df08f44-87df6760e0dmr97936676d6.28.1761239700205;
        Thu, 23 Oct 2025 10:15:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87f9de81d7bsm2118026d6.10.2025.10.23.10.14.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Oct 2025 10:15:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2909a67aed4so9297435ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761239699; x=1761844499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MPxNaEMIYukDTxjz6Ki04wfL1rNKy8pXkq3mZiePbWY=;
        b=VMNfS4Ld27o0H8H5ZwjXaNkCF/q6+VaTpZlc3lm+t7aU8hkCyn+pxv6ulUiN1EFr6p
         9CtAxDvqYkfy4SewazHUYNgfwOl1uU433MLWfrps/BSuZk68mZLHmf2B8fxFGs06xKYp
         jFM0RtOBd+o41i7BCGz8CvQmJBSIlolo4SiQc=
X-Forwarded-Encrypted: i=1; AJvYcCV7bYgF/NGsJiXVfn+jENHP/taoQGf8tq50hYv/pRu8tC1HIQAFCKvb86HbKnkHAeBIr82GD6+zR+3wlSo=@vger.kernel.org
X-Received: by 2002:a17:902:f54c:b0:269:b2e5:900d with SMTP id d9443c01a7336-292ffba2f54mr98563605ad.5.1761239698888;
        Thu, 23 Oct 2025 10:14:58 -0700 (PDT)
X-Received: by 2002:a17:902:f54c:b0:269:b2e5:900d with SMTP id d9443c01a7336-292ffba2f54mr98563335ad.5.1761239698532;
        Thu, 23 Oct 2025 10:14:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddeb47asm28968535ad.25.2025.10.23.10.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 10:14:57 -0700 (PDT)
Message-ID: <1bbaa5ff-0819-41f0-9ca5-73de287c9d08@broadcom.com>
Date: Thu, 23 Oct 2025 10:14:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tg3: replace placeholder MAC address with device property
To: Paul SAGE <paul.sage@42.fr>, vinc@42.fr
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251023160946.380127-1-paul.sage@42.fr>
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
In-Reply-To: <20251023160946.380127-1-paul.sage@42.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/23/25 09:08, Paul SAGE wrote:
> On some systems (e.g. iMac 20,1 with BCM57766), the tg3 driver reads a default placeholder mac address (00:10:18:00:00:00) from the mailbox.
> The correct value on those systems are stored in the 'local-mac-address' property.
> 
> This patch, detect the default value and tries to retrieve the correct address from the device_get_mac_address function instead.
> 
> The patch has been tested on two different systems:
> - iMac 20,1 (BCM57766) model which use the local-mac-address property
> - iMac 13,2 (BCM57766) model which can use the mailbox, NVRAM or MAC control registers
> 
> Co-developed-by: Vincent MORVAN <vinc@42.fr>
> Signed-off-by: Vincent MORVAN <vinc@42.fr>
> Signed-off-by: Paul SAGE <paul.sage@42.fr>
> ---
>   drivers/net/ethernet/broadcom/tg3.c | 12 ++++++++++++
>   drivers/net/ethernet/broadcom/tg3.h |  2 ++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index d78cafdb2094..55c2f2804df5 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -17042,6 +17042,14 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
>   	return err;
>   }
>   
> +static int tg3_is_default_mac_address(u8 *addr)
> +{
> +	u32 addr_high = (addr[0] << 16) | (addr[1] << 8) | addr[2];
> +	u32 addr_low = (addr[3] << 16) | (addr[4] <<  8) | addr[5];
> +
> +	return addr_high == BROADCOM_OUI && addr_low == 0;
> +}
> +
>   static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
>   {
>   	u32 hi, lo, mac_offset;
> @@ -17115,6 +17123,10 @@ static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
>   
>   	if (!is_valid_ether_addr(addr))
>   		return -EINVAL;
> +
> +	if (tg3_is_default_mac_address(addr))
> +		device_get_mac_address(&tp->pdev->dev, addr);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
> index a9e7f88fa26d..9fb226772e79 100644
> --- a/drivers/net/ethernet/broadcom/tg3.h
> +++ b/drivers/net/ethernet/broadcom/tg3.h
> @@ -14,6 +14,8 @@
>   #ifndef _T3_H
>   #define _T3_H
>   
> +#define BROADCOM_OUI			0x00001018

There are multiple OUIs that Broadcom has used throughout the years, 
they are documented under include/linux/brcmphy.h, to avoid any 
confusion for people looking only at that driver, I would rather we find 
a different constant name, or we just don't use a constant.
-- 
Florian


