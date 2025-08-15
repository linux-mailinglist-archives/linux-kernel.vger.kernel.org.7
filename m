Return-Path: <linux-kernel+bounces-771453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFE0B2877C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951F51B614F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F7244673;
	Fri, 15 Aug 2025 21:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Tz/PnYTA"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939771E86E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755291730; cv=none; b=DO9C3/6HdeV+p6TXdvrC4YP7KLFnpuR2KDhA7p6/TlubJBVVLwgCMDyJcqn7lRWV+nMbcEVlCONS3jAyZ0F/gdkNcO8eMAvep/mGWAAbm8cNTZHKIfArlEe84NGui6sNpgH1OcrE77mDtVOWf0VY1cEXnxpGCKNxJOFm1sAFqlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755291730; c=relaxed/simple;
	bh=giPDUXfHHqZCDN6Fz+z402ABDUE7plVedgLMxqaITiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wh3xe8oIejMSU7dI9BuGlSp6TPLhiyS77HAPtQU86VAl+BEmYaeNGrT72gmwn+Ns2nPzChA7yEayes0rvO+8HtJ/OD98AG0vPjWZfuSqudjEvcNtcwhAdxs6a5qXwKOA9zFYK+AQfm2jAx1J5+fp9lJNJv+332yhlkvn0ILcpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Tz/PnYTA; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70a9f5625b7so22672516d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755291726; x=1755896526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dMhDRBL/5riPg9Uyt/2X+hKhIOy5Eo35Nl2v075UMPg=;
        b=Tz/PnYTAT11ev9MlOrBnk+Nx5f58Gopgo59mqsU1EgbFuqmPAQbNo/qQhC7o5lCgHG
         g3Vn9Df01PLy5SNLqOjzKz2S8z2LezUjSq3SoHxMSiQ9u2mrXPL47e2M54xe1i9XlelM
         8wU7iNp+G51q5q2RAAxjSX4oHAyNkl+Wpp1wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755291726; x=1755896526;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMhDRBL/5riPg9Uyt/2X+hKhIOy5Eo35Nl2v075UMPg=;
        b=E+OcRWfJHiyUOpKXV2VfKVJoAQxQippSISKJGi8UX0glYD2yUzyj+Dp9Hbzm4lYTCK
         xo8BimG0h2Vjza9rOcHhRyzT61YMZPAIAhWwXb9IQ5mEvKILXmpPq0qbIBBPVyi3nZAC
         Z+i4fYBatdebRxKDfnECHBVEwaCJbC9vsbz1fNMLpNXYR8JjAMvN5/dBke24b9H45qVf
         E6VjtBkW55PrZwFczvF94TEgfGiFQLBPGzAszbF8yDGiIQP+0hCVGTs0blo3qP7zyDcB
         Q+iA6iolFMW9jgmZje2TDAlZYNu5vZrEGUZ1jBcoqbgTdf6S1WxwjOx9T8NC4JbOCdG6
         9Bjw==
X-Forwarded-Encrypted: i=1; AJvYcCWc9c6FQXM8NyZAvLwa+xm8/5QJpJ93jzHB2NcYnFxuDrPXj/RL5BGF+WRVtHoVE64ASkuF9DREahK45so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5W37kWTm0/Kh+6ZGCGDxX2CsruR51NCq8rdmdRGGSS5twsFK
	O2L7cKGHoN5ZJpBAPXb7ZUOo7vH24XZEyfw3Yj/cO/rozMHDhD6A0ONII02u5HUK1w==
X-Gm-Gg: ASbGnct6OC2ru4nPq9r6dDWjUTaWQlxolbdOYNA9PeblfKC1WBHwQbFlPF1wDkK+tfD
	ogx3vR3ihnzJCjutmNJRC48VbWHtOftE+5jX8Z8y1afnSCTCXjdi8sZOzwW1MfP5dqjIJcB+fj5
	R3ycSTo8C/LmsnpXlOrul9ZB9jyzFwa7eH+mB2Sw8damKC7cOqZOO/UUpbnY0pRL0dJmDBAQxht
	p1bWTFO38joZy1fvJOQgWTaBLsjh0he3PLc/ZH14MWTos9YmdC4oIvPNEyzihDVgsNABcZPNy8B
	8p3IFaWnR27EKUgeuRE8MdO+Cl8aGYZlaxChCYI/IbfsPVBj8nL+QQgX7u83TN4rACDNwleC6aM
	ApCUN6iD4NFJQJc2z/Rp7A8Sad7eLcOx+dXYksr7IlAYcrNIq6lBKrjXvVRiD7SEJ237nteQt
X-Google-Smtp-Source: AGHT+IHlJZQbxYEAo/CAcaaStWoVMEKDMkHzQBnIwjrztCqua02+qfJ5G0YsBwDeunCxC568YPq9aw==
X-Received: by 2002:a05:6214:2601:b0:707:228e:40b9 with SMTP id 6a1803df08f44-70ba7bf75fcmr50225356d6.23.1755291724423;
        Fri, 15 Aug 2025 14:02:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba934cf82sm13838996d6.51.2025.08.15.14.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 14:02:03 -0700 (PDT)
Message-ID: <388c5bc9-751d-4080-8d53-a70cdbb7d544@broadcom.com>
Date: Fri, 15 Aug 2025 14:02:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: b53: fix reserved register access in
 b53_fdb_dump()
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815201809.549195-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20250815201809.549195-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/25 13:18, Jonas Gorski wrote:
> When BCM5325 support was added in c45655386e53 ("net: dsa: b53: add
> support for FDB operations on 5325/5365"), the register used for ARL access
> was made conditional on the chip.
> 
> But in b53_fdb_dump(), instead of the register argument the page
> argument was replaced, causing it to write to a reserved page 0x50 on
> !BCM5325*. Writing to this page seems to completely lock the switch up:
> 
> [   89.680000] b53-switch spi0.1 lan2: Link is Down
> [   89.680000] WARNING: CPU: 1 PID: 26 at drivers/net/phy/phy.c:1350 _phy_state_machine+0x1bc/0x454
> [   89.720000] phy_check_link_status+0x0/0x114: returned: -5
> [   89.730000] Modules linked in: nft_fib_inet nf_flow_table_inet nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir nft_quota nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 cls_flower sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_route cls_matchall cls_fw cls_flow cls_basic act_skbedit act_mirred act_gact vrf md5 crc32c_cryptoapi
> [   89.780000] CPU: 1 UID: 0 PID: 26 Comm: kworker/u10:0 Tainted: G        W           6.16.0-rc1+ #0 NONE
> [   89.780000] Tainted: [W]=WARN
> [   89.780000] Hardware name: Netgear DGND3700 v1
> [   89.780000] Workqueue: events_power_efficient phy_state_machine
> [   89.780000] Stack : 809c762c 8006b050 00000001 820a9ce3 0000114c 000affff 805d22d0 8200ba00
> [   89.780000]         82005000 6576656e 74735f70 6f776572 5f656666 10008b00 820a9cb8 82088700
> [   89.780000]         00000000 00000000 809c762c 820a9a98 00000000 00000000 ffffefff 80a7a76c
> [   89.780000]         80a70000 820a9af8 80a70000 80a70000 80a70000 00000000 809c762c 820a9dd4
> [   89.780000]         00000000 805d1494 80a029e4 80a70000 00000003 00000000 00000004 81a60004
> [   89.780000]         ...
> [   89.780000] Call Trace:
> [   89.780000] [<800228b8>] show_stack+0x38/0x118
> [   89.780000] [<8001afc4>] dump_stack_lvl+0x6c/0xac
> [   89.780000] [<80046b90>] __warn+0x9c/0x114
> [   89.780000] [<80046da8>] warn_slowpath_fmt+0x1a0/0x1b0
> [   89.780000] [<805d1494>] _phy_state_machine+0x1bc/0x454
> [   89.780000] [<805d22fc>] phy_state_machine+0x2c/0x70
> [   89.780000] [<80066b08>] process_one_work+0x1e8/0x3e0
> [   89.780000] [<80067a1c>] worker_thread+0x354/0x4e4
> [   89.780000] [<800706cc>] kthread+0x130/0x274
> [   89.780000] [<8001d808>] ret_from_kernel_thread+0x14/0x1c
> 
> And any further accesses fail:
> 
> [  120.790000] b53-switch spi0.1: timeout waiting for ARL to finish: 0x81
> [  120.800000] b53-switch spi0.1: port 2 failed to add 2c:b0:5d:27:9a:bd vid 3 to fdb: -145
> [  121.010000] b53-switch spi0.1: timeout waiting for ARL to finish: 0xbf
> [  121.020000] b53-switch spi0.1: port 3 failed to add 2c:b0:5d:27:9a:bd vid 3 to fdb: -145
> 
> Restore the correct page B53_ARLIO_PAGE again, and move the offset
> argument to the correct place.
> 
> *On BCM5325, this became a write to the MIB page of Port 1. Still
> a reserved offset, but likely less brokenness from that write.
> 
> Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>   drivers/net/dsa/b53/b53_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 9942fb6f7f4b..829b1f087e9e 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -2078,7 +2078,7 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
>   
>   	/* Start search operation */
>   	reg = ARL_SRCH_STDN;
> -	b53_write8(priv, offset, B53_ARL_SRCH_CTL, reg);
> +	b53_write8(priv, B53_ARLIO_PAGE, offset, reg);

Yes that appears to have been the original intent:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
--
Florian


