Return-Path: <linux-kernel+bounces-881872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8DDC291C7
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46517188C7F6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3DD23D7F4;
	Sun,  2 Nov 2025 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GwPJGHjm"
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657A238C3A
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100299; cv=none; b=MLRm8zN4weVA30QulGq94jW/bbOOl4k+u2D9HkB4KTx6Ze6Fm07SohdG7z13m+tTohRh8dmw/RNK75HsD5jqTzUmh4kAL/eiFVleht4u+rFRdJhgWUmR/yeF/mACl4yPgex3CfHRn20uAAvuR/R+IyVOR6O7UhkxPG82gNCS134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100299; c=relaxed/simple;
	bh=mop2BC+wrHVPArDalW2M4eYt5/DRCdy/JgA4ZHJjVq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgyB5XJDHLibQStTH1Xg/PNWZzpYUW5KJHDA/NDEXGHvLriEIg7kpeuz9RytkAdhb+HQ4BgsEOvzpAhC+NcbWXwMLEpO4vF9wFKJX8jbzTOzLCZjEs1tN5pWGw+PqZoyy5k2jerosdw2c54csm1JQ9HPEHZy6nztpnHHFgg4PKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GwPJGHjm; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-4331d3eea61so16068935ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762100297; x=1762705097;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ho65E2n5x3XgaKJCvo6/fje/UMhphKqUxyW0xTuWSls=;
        b=bYiGMmLvMVssh7u/I1ERPji1UtPswxscs8iLvnIs9Us6jI8cVQYJY02fiRaIxnWT7N
         +4h8vzDpJR5W/r4LlFfh0RgKzHYWWqqXLiadeO4YVFeockM8XdF6f2Cu2TQnr3fkJESW
         pFRaPLPUnTiNTFE3GlMSvXgzf5oPxbgwkTG+NCQj22nF6WlMZ1YGunF29b0cqE2Gpxeh
         8isBbkmciSn2xvqtTJIPrX+q+WlaW1ScVDzIl37xlhqUW38XWoezwefsQyq8L8n1sQMq
         hcnLsBGP/kmcGDAEEaFwRkrE8PWgMpvslHElQI6bJxI6aHM+8Wq9DQEYmGPMLra5i4ny
         UhiA==
X-Forwarded-Encrypted: i=1; AJvYcCWOfIIFKAN3Ku5oNzZMJb5hcMK/4aS/S+nP8RVTW3Ux9vfEGEIum8pw45Yin31PPIxFemE/P3KgZldOgPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGy3iRZbhlF1l8mKHu9YZI7hap/nCI2DHKb4mFixnKFEOuSNva
	LqB8xC2jMRtaoKPKWjO/fheQXIph/GxXnPNMwbobDPlKOcfJkCE4zO3j96TM4sb3U+o67NRCBxj
	Hqevq1EJXmRYtJrycZIQGQgnt+8XZ64uo/BKiOG1eieFO4m8XsJQY47E40JsWKVGYTptEr/fMtU
	oWrzhV1t7K2PdtjgLsCAEiGjfyghcMP+tP+TmaV+WK6DikjENWsxrOQw4IytqlTdEI2xUrWtF+X
	YnEHyBfnleBU4XbxqzuTRX5
X-Gm-Gg: ASbGnctGjd80+4w8E+ymF8wrDxruHerl2pCXViWHzeL/tIuZMfaUMhmYs70EdWpLKa3
	0bcwG7ugCkGTQzTYnWVPFgIBEIxTQjeTTgaQrEhdCzqi+5Q15fi9QvTUdHg2FwZk+T4/cU2aPew
	1FpH3xD2820C9itekZvVxs7ixrwEdUfAOw3jjPFqs07EPJ1UGUGxvCIjAxH7iMus5rcpIWCF8HE
	tJ5d643NVruNaA709Lw5NSRHdIbwj6iteEWcpV022kIWUp43fRaZcf6zhSfr56gGw9JuwMrl5qc
	SOnr7pSLLcFvCO/RRr4U96wjrWxLCuTUeTPnjQXy+p9dezHxQS8+9cBQCws3/t798s6qGAM556j
	9I/8BNa5G+btlkCZWWoh0Scis5x8hEWdDwY/IRtbLS60imK9RMMU2PGlSVesDZrTS2VzH89O+9Z
	DayxFVpczdN9q3gqOmpK3MpgeGi/jDveGk04fyotL2gw==
X-Google-Smtp-Source: AGHT+IFf42smZSBchGB/dsqy4ei0vvvGKCNw489zcD68QW5kNV/zOo3iW9E/kvulb08U0T9P3ekag34FNgqY
X-Received: by 2002:a05:6e02:164c:b0:433:27c1:75cd with SMTP id e9e14a558f8ab-43327c1772fmr46349575ab.17.1762100296835;
        Sun, 02 Nov 2025 08:18:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-43310339e83sm6250605ab.23.2025.11.02.08.18.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Nov 2025 08:18:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2698b5fbe5bso57479985ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762100294; x=1762705094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ho65E2n5x3XgaKJCvo6/fje/UMhphKqUxyW0xTuWSls=;
        b=GwPJGHjmyfAChAeow/Bk8zlbTPhEI6Qmwt+gYIC4VZKDlCSIXx0mmu9KbQwPOf7qXt
         87MXEpcsPQtrCguqDi+381rBusCMvspLSV0l+7Ry/+jQ5Xo4eoS0XwIKuYs8l8F2ssur
         4fIPkiy5QeBittbkVhSQtc4RHQ8GhiAo3yWpk=
X-Forwarded-Encrypted: i=1; AJvYcCUcu3NTOxzgD6HRNWZpFt9N9vV6g+kAaDDQnAjUkemAyGBqEshp1gGYj+Iqpx+bb8N3U/P7Bzos/anhSls=@vger.kernel.org
X-Received: by 2002:a17:903:2447:b0:295:7806:1d7b with SMTP id d9443c01a7336-29578062657mr40932695ad.45.1762100294692;
        Sun, 02 Nov 2025 08:18:14 -0800 (PST)
X-Received: by 2002:a17:903:2447:b0:295:7806:1d7b with SMTP id d9443c01a7336-29578062657mr40932525ad.45.1762100294348;
        Sun, 02 Nov 2025 08:18:14 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:a836:3070:f827:ce5b? ([2600:8802:b00:ba1:a836:3070:f827:ce5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295688c68f0sm44959255ad.41.2025.11.02.08.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 08:18:13 -0800 (PST)
Message-ID: <dacb3ce4-7a54-4b4d-9385-0d466d159c77@broadcom.com>
Date: Sun, 2 Nov 2025 08:18:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: dsa: b53: properly bound ARL searches for <
 4 ARL bin chips
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251102100758.28352-1-jonas.gorski@gmail.com>
 <20251102100758.28352-4-jonas.gorski@gmail.com>
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
In-Reply-To: <20251102100758.28352-4-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/2/2025 2:07 AM, Jonas Gorski wrote:
> When iterating over the ARL table we stop at max ARL entries / 2, but
> this is only valid if the chip actually returns 2 results at once. For
> chips with only one result register we will stop before reaching the end
> of the table if it is more than half full.
> 
> Fix this by only dividing the maximum results by two if we have a chip
> with more than one result register (i.e. those with 4 ARL bins).
> 
> Fixes: cd169d799bee ("net: dsa: b53: Bound check ARL searches")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


