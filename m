Return-Path: <linux-kernel+bounces-881903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3682EC292F5
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFAD33477FC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC2D2D8DDF;
	Sun,  2 Nov 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gKS6lXTu"
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550723236D
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762102403; cv=none; b=Al6Vlfif6ybOkuHZ88gfFnGTsDAizKsy/Bviybnhe78YIVVJYMLPkyU3wowNoTY7YCynAU+2kkPnw3bALNAGnxPkxiWDp7DEIGQvnywBy9STpQmk/TyJ3Y+3KdaTn8+I0wlWxLBfYUwf23A9Ofos9y/m2WBiacBycWxXCF6Y47I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762102403; c=relaxed/simple;
	bh=mRXANmPOG8bA/wfDCFGlxXRgxZ1C+X+IZI7c7ISNalA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8S8zaxHbM3UYZJpXJqaaj6WvcHBNHf44XROZXeo4pESheWyG2NTku6ZdFodF2olMi7P8lY7iFwUEvGmZdQlUUs9SIOncsxu1+NA212OuFVGWP8ALzunDyswdBJXErVilzGKAEAmbTpRMvsub++dNLZtRI7NCu6iHswyPV3MzgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gKS6lXTu; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-33ff5149ae8so2943950a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762102401; x=1762707201;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBtN1pt/YQjJPuR7zRZUpiRiq+EJT5WGL3bugHwhNTI=;
        b=tgvMbziWFqcdgMS5x+GsBh5hn0/mV1bKhv9ENAXNAZFfmnNIRrxVc4JY+5sAf9Oeut
         AIGmPMiddH71AwE2xm4kcCwqaY/bhhY0uIn0SLTqVzlsDAaeK5wIWyXaCwSVRJy69jj9
         6Jp7uhCQiYS+rKNFIWiVJXe/flU6vfpCsPc5Xo9UYUcz5w8J8K4auJqKY6YNYdMuGVpi
         Nh2SLzGiFYESh051RhClq9TweBptzHdg5C/DyqVgWuvq0UZtYQqDedCToMWNPhXHtzJB
         +ikPqcgjudWdcWeHjXaicNoUolejmDZ0IEePgRnHFqTPhqZ7kf/KOV+tj9M2FdSXYOp2
         87Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUrFrEJiCi0lxtVut7dqzYisyPjXLKcBjzgOxle3l3ODNf3ZbrDuPE7v3tWe9sQtGikclNEi5rxIJhlOcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOWdxi12E0tAqIAO/8Ac4Lz8tSW13egIv2NcgVm1GttvXNH3h
	iepQyrM8m80zkI5hoepX2k89I/StYOsFn6NbwgLPvR/952rsuyorI72pHlAiDBlyg7vtQymQtVh
	cBwnORPbFrcV+L8wPiWC9Ogrguz+JoSJ/0VjvoFiCVigPrzduazweNp5j5fJLfYo85tmyi5HIy3
	WjmwTDRX9OARHQQxLC2Tpb+RvUoQA4Xiwqa1x+4jwzHQ+Fe8c+WZovzXJhdxAXRvXaq0jPfHjmg
	vyOq5fs0tF+JOe/dlgw8I3d
X-Gm-Gg: ASbGncv1wvjDwFKGnL314xiM10a27yIcFKJryZcJJ5hrwr0Ur8flmdhfF4EbOhbR+nx
	9/MttsuKtr4nF5OBzKqfn8mkwWe+0QO8u5Y2rDh6CdylBgsRKpIqsAsLbwd6gAjSekBGwe7QAis
	3L4AxhAPitVnxhgPL1ODjU2GoX51BVvwxHOxuhHhFcPNextaUyunCmBz8BYDEjSetYyyuWrI66e
	ahhssRyjkq6jxXzR7RIeNQoW69CuXpp93UJiBqmTAKx+8Lx3H057h4H357bqNjRV/hh1180PtYy
	o/EA7QSrv2PX1hfeSSabSKxfMJ3+/+tivhMlMzZLWhv309L9uIlO90jx9X3ZOCmSGo6jjBg5QpL
	AAloBfSu1Q4PlQW6AZVRQycl3G1AMkB39rn/tlp+oBdvzJHLw08IcpygXFdYzd3VJESF6J4GY91
	jSbNeq96+r7zu6V+afXLqwBcakiV5aAqxvrBqz7Ts=
X-Google-Smtp-Source: AGHT+IEd+id1Gd06yAlo8ZmaikhLvr2kG3rOO+Tc3XotfwcC/RjPnYG085ITJXX1kStMJq6nrU094JOK0ktF
X-Received: by 2002:a17:90a:dfcc:b0:340:2a18:1536 with SMTP id 98e67ed59e1d1-34083088c8fmr13042886a91.25.1762102401281;
        Sun, 02 Nov 2025 08:53:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-340ca5b4064sm408834a91.0.2025.11.02.08.53.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Nov 2025 08:53:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b9939dc50e7so497553a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762102398; x=1762707198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wBtN1pt/YQjJPuR7zRZUpiRiq+EJT5WGL3bugHwhNTI=;
        b=gKS6lXTuZVGSldReo4SFtUrfMAEA3GoqXua7i9YbbQiE60aE4/rrtj3Ji4+XRuTG0i
         5jNWkjewGN6/X1sIOP8lUu36ZBz0b1b/0jCMDl8u3o24BaXnVuhmD8390+4p3/igness
         8uE4G0MHIMISL1dkCr996OeyhOzQ9j6Ps8+14=
X-Forwarded-Encrypted: i=1; AJvYcCW3YELVZFCl1BIHNX/05JcmAdUDzaRl0d+kGQb+zQGNybOS66hqYnYZfEEst+SThzHhgjabQM1KTl+2+cw=@vger.kernel.org
X-Received: by 2002:a17:903:944:b0:28e:80d7:663e with SMTP id d9443c01a7336-2951a475160mr132249595ad.40.1762102398366;
        Sun, 02 Nov 2025 08:53:18 -0800 (PST)
X-Received: by 2002:a17:903:944:b0:28e:80d7:663e with SMTP id d9443c01a7336-2951a475160mr132249375ad.40.1762102397970;
        Sun, 02 Nov 2025 08:53:17 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268d10e9sm89388535ad.50.2025.11.02.08.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 08:53:16 -0800 (PST)
Message-ID: <bde27b59-1169-4364-bc5e-a2a29d842d08@broadcom.com>
Date: Sun, 2 Nov 2025 08:53:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net: dsa: b53: fix enabling ip multicast
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251102100758.28352-1-jonas.gorski@gmail.com>
 <20251102100758.28352-2-jonas.gorski@gmail.com>
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
In-Reply-To: <20251102100758.28352-2-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/2/2025 2:07 AM, Jonas Gorski wrote:
> In the New Control register bit 1 is either reserved, or has a different
> function:
> 
>      Out of Range Error Discard
> 
>      When enabled, the ingress port discards any frames
>      if the Length field is between 1500 and 1536
>      (excluding 1500 and 1536) and with good CRC.
> 
> The actual bit for enabling IP multicast is bit 0, which was only
> explicitly enabled for BCM5325 so far.
> 
> For older switch chips, this bit defaults to 0, so we want to enable it
> as well, while newer switch chips default to 1, and their documentation
> says "It is illegal to set this bit to zero."

The IP_MC bit is definitively a better name and matches what exists in 
the newer switching IP, it does default to 1 there as well, and it has 
the mention that it is illegal to set to zero (makes you wonder why it 
is exposed then).

> 
> So drop the wrong B53_IPMC_FWD_EN define, enable the IP multicast bit
> also for other switch chips. While at it, rename it to (B53_)IP_MC as
> that is how it is called in Broadcom code.
> 
> Fixes: 63cc54a6f073 ("net: dsa: b53: Fix egress flooding settings")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


