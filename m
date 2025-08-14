Return-Path: <linux-kernel+bounces-769558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A00B27050
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F6C3A9AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3E2273803;
	Thu, 14 Aug 2025 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FBdbwL/S"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B27202990
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204334; cv=none; b=HIIFd570d5At96e4vOT5REmd02Joi94+MomJZ3RbTQF+HW8J3/M4qq3VPnbG3y22r7geqAsNVkWuyCjHeg0UwtDAc0oz1TE8rRA0rWxKGCulsgnekCeoOkvhzVTuKQfI8McV+HpaDHvKrSX0YobWh78BYSsw6oVqILreeBs2XHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204334; c=relaxed/simple;
	bh=/MaLFBFI538hzE4KmmitfXqcXLYUqUkIXHttwqDFRRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDXZprF4E7zYXrunRzGPmhcThE0PjlSrRjH+ukNdSIsoFsL5AG7ROfehjZXpbRv0qRZ0I5fhhdyf6kkhg1pB7ZVaZFCj7cDOsVBefTAloH6Hknth01lho5yVG5yGA2TCDz3wWSKM5agKId5VFG8UEcuPIyJ0ND4JGY38Lvq5gFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FBdbwL/S; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e8706856e0so124398685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755204331; x=1755809131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mDEUbBFLcZjVHFb1cWuVCMEgiJ+lJVbmbyWgG3QXWzQ=;
        b=FBdbwL/SDOMSfl3LuuNdS7CD2BGoBYcPyiz+X51uTzoa9bDX8WnUn4oFmXS8ComLsl
         C+RQVR8gcanBfCGYx1D7HsnISH/BdxHMo8JNXNbv4Mm9m4/fr5fx6w7QttsNpJ8HR78a
         F1HYad2WZzVnR5Tr5BNFrcpk5iLDZPokxYIkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755204331; x=1755809131;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDEUbBFLcZjVHFb1cWuVCMEgiJ+lJVbmbyWgG3QXWzQ=;
        b=qFNVVEGIgNuVeWyWITaIsN12WWXLlHdNnp5Hb9c3ptcQZ+nww7II+1W4xq9YrC549a
         /VYCJsktX88m3MQl4byfdqLVyY2DMd+uDhlADw7isJWl8aFJuWLPWsM1tLB2a5R9mlsq
         JVQLPRlIuGM6tHqxwov+BI+/2t8kQLXZN9gjuv8xYhoeblELPlHipT7wz+1Sa95qPkIp
         AR4deX6kGGKEzqgLzduktyx062Yk6wbNVnbgavBkJ//E1+01eXduMOB9H+UZrQ4q8f/t
         qKauBKH/lAyCFfehCBTIuUSusfi1Z0QgvASZANZF0Atcs7EceC/UEjLR8kxHVJBq7MeC
         c2rA==
X-Forwarded-Encrypted: i=1; AJvYcCUM6tfoFIVBzc1AoQFI2qbI3ziA316s8rSvd/nJpccVciNanpAA+Yzu2m8UaEOdg0Gy2CD5uQOjOcxT6R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF00ED7UypeND3Oim8yElnznyXwcc+I+e+LGxq3Az2ajkTZ7Dl
	O/ILNk5+P371WFettykzsZZ1lWieGETsHxtNyHB2sRLJw3cAzF/79gwvH09WAiJZrw==
X-Gm-Gg: ASbGncv2P8dt23rLzlXyhXEpORXlT1k8mU2FIE1iHbcRgZgyhmIQd9uTtVz1nH2LkhK
	LQu6FV/Jc/aaUYJ6uD64VvSb6LA5fswa0LiGf3+E2GcML5bZvpCZgipaalCzM5Bi9OLMUiy+3Yl
	JqtLOd0MtVoUzU3symQVBctGsMnG6H1qCG8tK0jg3hVvqmjRRqpHr2JedS6XnUqaZmB6EYmV4C8
	nPT6/r6T9MyLIFr8nmD6w4Ab1qq+KfypjG+jrJPP6dPUqOrZmsUC5cPohWtuIY/0K5vGCjaFD00
	v2RSEGOlsqaJHUiaBx7n3JB2NPwdbQIUVwEDxZGQ7EnJ8txRcF4D8bnysjjCG01alHq0HX6KpvO
	CMUhUUn+JAKgiAXGnLIpjF8MkV9tqDKl3YzHRGL3PxMRI+HO/Ly9F5Ods6KeXXKMTNw0AtZk/Lr
	Iq
X-Google-Smtp-Source: AGHT+IHUF7VkyuGmIFpPBRJj1cuoHurt5Q5H3HC4Qg/MAGfKXFqWs7Gnq0x67TaT1BE3O/5essSKVg==
X-Received: by 2002:a05:620a:d85:b0:7e8:4586:3d51 with SMTP id af79cd13be357-7e871a2fd1bmr546184585a.25.1755204330974;
        Thu, 14 Aug 2025 13:45:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87b4f3617sm27442885a.70.2025.08.14.13.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 13:45:30 -0700 (PDT)
Message-ID: <e942f689-1c59-4ddb-af98-5390ceb6ff7c@broadcom.com>
Date: Thu, 14 Aug 2025 13:45:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: gro: remove is_ipv6 from napi_gro_cb
To: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250814114030.7683-1-richardbgobert@gmail.com>
 <20250814114030.7683-2-richardbgobert@gmail.com>
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
In-Reply-To: <20250814114030.7683-2-richardbgobert@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 04:40, Richard Gobert wrote:
> Remove is_ipv6 from napi_gro_cb and use sk->sk_family instead.
> This frees up space for another ip_fixedid bit that will be added
> in the next commit.
> 
> udp_sock_create always creates either a AP_INET or a AF_INET6 socket,
> so using sk->sk_family is reliable.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Complete drive by review here.

> ---
>   include/net/gro.h      | 3 ---
>   net/ipv4/fou_core.c    | 8 ++++----
>   net/ipv4/udp_offload.c | 2 --
>   net/ipv6/udp_offload.c | 2 --
>   4 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/gro.h b/include/net/gro.h
> index a0fca7ac6e7e..87c68007f949 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -71,9 +71,6 @@ struct napi_gro_cb {
>   		/* Free the skb? */
>   		u8	free:2;
>   
> -		/* Used in foo-over-udp, set in udp[46]_gro_receive */
> -		u8	is_ipv6:1;
> -
>   		/* Used in GRE, set in fou/gue_gro_receive */
>   		u8	is_fou:1;
>   
> diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
> index 3e30745e2c09..efd3bf6ec3ae 100644
> --- a/net/ipv4/fou_core.c
> +++ b/net/ipv4/fou_core.c
> @@ -254,7 +254,7 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
>   	/* Flag this frame as already having an outer encap header */
>   	NAPI_GRO_CB(skb)->is_fou = 1;
>   
> -	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
> +	offloads = sk->sk_family == AF_INET6 ? inet6_offloads : inet_offloads;

Since this pattern repeats, you could create a static inline helper that 
returns the adequate offloads reference depending upon being passed a 
socket reference?
-- 
Florian


