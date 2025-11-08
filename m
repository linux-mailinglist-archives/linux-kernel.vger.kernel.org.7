Return-Path: <linux-kernel+bounces-891198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54110C42226
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E632F4E429D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16527E04C;
	Sat,  8 Nov 2025 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HRB7D0Ub"
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D12275860
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562339; cv=none; b=HRofqzOi3hWA3Oltlab5MM46ipo0YYQxyKeHmvpqyyMZXIfYyriP7tyZJkkiQ7JFCca8kpLULBhlRNQPvfQYJTJSDH6Fopq2Uj5uNm7cZt1y2wlHa+doxRFryvnq3bCGt2ZXYElKbkkhvwyUdEOSknwrN6U1zhhdeTeL7h1AUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562339; c=relaxed/simple;
	bh=YrpLL7os0zfubETkyUUJJ6jGZrJcICmSHwXo+0a03Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twAFzqEzbKcA24UFJUxqKQSapI1omRzXRLiOZTaHJx++Gav2owEazD5gt+R6/O03RXAaUosqh0P1sb/2qyN3lpNySy60VJKl7t6LmAnEC+T2b7/nSCVpYGmLzEjKnLCKEtTqZl2D4z+im0Tvql/mssn2692eI/uVGmeF5rlS4Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HRB7D0Ub; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8b1b8264c86so129135585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 16:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762562335; x=1763167135;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWGeea713G9U0pEv1nyCaRDYj15IgFZ+zJHuxzQWr9s=;
        b=r09MhSJq0y9iFrASpnoSJ/DXiXM1TUTl/eEAYDwaxMYpnh9yypkEHR5zJISwuPVYeP
         TK1yTssPW9d4r6h1gs9yG1koeR3LEgYpK3Ja7n+8KQW8WW+/tnEa5zin8yswMCzbURXr
         Zo4ildSflqSmTYFIKLSrbpDMIwiQQPu7gyLdwQGvMCd0JjiepY0HqJnSZgEeDI6GsdZw
         0T5UpMpzE+twTYi0v3I9CC+mZoB1Kqhj3q0KTuJgC7J/h/SgEgFXg6CnDPZG9OhEjVqW
         d4O+rZ3dpvJU/NK1BmsucZnzJY9sax//Do5A8C8YhFary4IyMTCLFeqPHwr4QjgJ/dGv
         O9SA==
X-Forwarded-Encrypted: i=1; AJvYcCXXivvqJMK01AnQ2SyAlYLuQnvVHQzKXWSlvtnD1V+1raNsQheE7147o1DJje8kSfr4wfvpO2K5KxBDWDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMktwfZ1y8NR09/IMyXMQfH4dHFrFbpqvi2zAbgEijwWUxg6OX
	emjK9sbcHKdAWOzlAtSYd0KuleNWqH0Fhk+I5zw41d79sLfGDZXCBNy4dDZls1YC05Wts/HjPA7
	jfjfso9WD2ungBBikAicdPONojlrxYjfWXELMuxt4YrQfKVxAfcg/2tEy6Ppt8yvd1eplTGcKZn
	4V0bkc39Hnqf8LU9JgggiQOax9f9LSb3s2HdXnsJOoVHnTz4nLvkamobkLqEqdjBujQSmdUfz2A
	RTwRtsW+24s1R1ZPNgRK63u
X-Gm-Gg: ASbGncvGs3F7NG4Obx2igEekx1PVY/zipAIoya7ZZNy0Vx7B1nhMYYveuxCVijDdv+T
	JSMTkyPwCfjWvjQ09kEEzhxskU+si4y1AZqdatwULjki+hXBdFOiRqy/lcFKU2nhuSiDyWR11Cu
	hf7CslPBLBlLUpEEhdQ9XGI+NJaZPXTuKWhpB+o58LG8VP8PaD4Ho6lIO+3XJCH1RLgEWhyaFz9
	yJloyQbmBW2RVVYRXzK+kXTrkqKD7pMgWdy3uYXizeJt+p69Yb9p5XMWC/+y1fnUIgVNN9kLrXu
	RNxkLuvktZ94Pt5F2BvUO+/TGn6rI/ysQgzb060NRb8kxJE9f5QAbhGkWFfymq/X9DWX6XqtF8y
	XG3fpGzkiIEOt9jng8tZ5dbyIIXjKNLxsqYQHM5mGm9MkL+5CIx08XTitssRX3a8jDhc42lbASn
	jQfMyB6Hp6A48/xgFEL6M7ivms3nQnLNw1dFf0Coc=
X-Google-Smtp-Source: AGHT+IGpizdLsZhUTJsyT2CMWeh/vXedIUhhOxWc+wyxIkCHZPHsFBhOpFq5cNnNsGj2IcAl/g6t6sb73QlD
X-Received: by 2002:a05:6214:1c43:b0:880:545b:ab6c with SMTP id 6a1803df08f44-882387274femr15562196d6.47.1762562335142;
        Fri, 07 Nov 2025 16:38:55 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88238b81d74sm698896d6.29.2025.11.07.16.38.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:38:55 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-44fe73611fdso2252806b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 16:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762562334; x=1763167134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PWGeea713G9U0pEv1nyCaRDYj15IgFZ+zJHuxzQWr9s=;
        b=HRB7D0UbzNtWHHuB0th6IQ2OQokMUpU0KPh2n+HDji+xCyUKu1fHUb+/Qgzme2QLau
         sjRijTwT8L3Srw0Sn6m9RghOvNad/bSSmkmmSWEVMgxnJ1bRdmVYPCifim4zVnPRO7kx
         KvyHhxjQYnHrz2cBLCbQ5FLWFOOeDSfdSLPmA=
X-Forwarded-Encrypted: i=1; AJvYcCVn5mvZi/RLlRbZcwoi07LfybPt1qPCz7nCiElf+n4ZRQVJfnGrih+iq/A2TLOXhVf9Wng+qWV7UQEANtY=@vger.kernel.org
X-Received: by 2002:a05:6808:4f4f:b0:44f:773c:33cc with SMTP id 5614622812f47-4502a48ca29mr713976b6e.35.1762562334370;
        Fri, 07 Nov 2025 16:38:54 -0800 (PST)
X-Received: by 2002:a05:6808:4f4f:b0:44f:773c:33cc with SMTP id 5614622812f47-4502a48ca29mr713961b6e.35.1762562333975;
        Fri, 07 Nov 2025 16:38:53 -0800 (PST)
Received: from [172.16.2.19] (syn-076-080-012-046.biz.spectrum.com. [76.80.12.46])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57d6767sm2981861eaf.15.2025.11.07.16.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:38:52 -0800 (PST)
Message-ID: <044303c3-03fa-4eea-8b63-f804171a4f93@broadcom.com>
Date: Fri, 7 Nov 2025 16:38:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: b53: bcm531x5: fix cpu rgmii mode
 interpretation
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?=
 <noltari@gmail.com>
References: <20251107083006.44604-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20251107083006.44604-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/7/2025 12:30 AM, Jonas Gorski wrote:
> b53_adjust_531x5_rgmii() incorrectly enable delays in rgmii mode, but
> disables them in rgmii-id mode. Only rgmii-txid is correctly handled.
> 
> Fix this by correctly enabling rx delay in rgmii-rxid and rgmii-id
> modes, and tx delay in rgmii-txid and rgmii-id modes.
> 
> Since b53_adjust_531x5_rgmii() is only called for fixed-link ports,
> these are usually used as the CPU port, connected to a MAC. This means
> the chip is assuming the role of the PHY and enabling delays is
> expected.
> 
> Since this has the potential to break existing setups, treat rgmii
> as rgmii-id to keep the old broken behavior.
> 
> Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
> Reported-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


