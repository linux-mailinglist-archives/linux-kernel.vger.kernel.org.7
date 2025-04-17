Return-Path: <linux-kernel+bounces-609630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4DBA924F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 19:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A631B61611
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9731D25FA07;
	Thu, 17 Apr 2025 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nl8OV9Rt"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E62256C92
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912611; cv=none; b=XcckHTuq7EVFRYWO506PbCFwG56l+no3xvT0RSy0ZVz+vJW16eOdCHPJ+9Xih8OdTSllZKJBlBqwz604V9TcL1k7loP1t6iGx5JiJU8EiA39x48z/IP7/oqT4y6uS2u16WF8NXvkvJymPFMXjjshpjPjFoFWk2GJLM2DKRM1j0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912611; c=relaxed/simple;
	bh=HFDjxAa3bGkrA+MCKxtUHwtw/L15m55cXlBT8SmDkZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aM6D3As9f9I6D4J/Eg6f2eWQAFin/c5Jbi1X+5jyXKr7yRp6gRjjMkJ4kAqszOKMfk/Z0DZbU2K/h8cmTsj2ImDzdje0WX5Fy8uhkZ9HKd0PzePsAjppHNhLPBUBAH7bLUicdnwleyIeOaPWNnUrDNMk/MnG1jiGIxyf8pGjx5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nl8OV9Rt; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-601fcbff303so519283eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744912608; x=1745517408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IbsMu0aBr/i6j1IitEROGEDVxfzbbm1plyUyzpvhlRo=;
        b=Nl8OV9Rt4KYlwOwn8SKxYx8ZezllBOZ3gf8epgXhImFKGCPMhZ2ZwU7OfNYdGxa3m0
         /ZWG0e8x7I8lsPz3BGZldTx+ymY+MQ3shCSSvFIm2qugu7F1dPsFn4Eu5BHaa4cNYbkh
         eXEzCnBUY3YrKN2TQXQLf2QG0jhRT5qDiFBCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744912608; x=1745517408;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbsMu0aBr/i6j1IitEROGEDVxfzbbm1plyUyzpvhlRo=;
        b=MIwayyr0PxsrU5U0VtpooArwzA4xmGkNbIoJ0EZMKbg5n74+F/B5EfNfoKBwI62F3F
         3iz7S29lL+uNYLKTsR2vQAX/+DdwfDFSiTumjNlh2kpZmKshtKYc3VkHwjIAGGbeqBn/
         tqXuMVdNxcUfOR7ZOwplb9BfA9KwbKMfRRzWc7mjpqjKxx+5eYss5IEijkPmMX+lofDI
         D88BzE9hT6PsThD/1Bb6CI5E3VsHd6LGQ0NDhTK+E9xT8emTYVPhXeam5rgvrGxtdjrB
         /W5eNkD58W4LrzTYhuH0Rj4ShWOOVgbVBO89Y+pP6A/+xNQgpVv78T+OUg41DrZldukV
         loFA==
X-Forwarded-Encrypted: i=1; AJvYcCUA1zkczTIMk/+cMOJY3J04xGpX76hAGPfFsczrDZmUyxQUZXSIgstml2lz61ZXSiKQd3blp7FtCVjPFDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0geJywrcEQnkSeCSNnpkHsUkSHjNNz411G1eep9XQCVF/Mbr
	2HwS4eAZVYmOugbZzPaH7FgsQfx4kOkxHe2Dc0JIjFu8CoKVq7W4TgzMEjIgPw==
X-Gm-Gg: ASbGncuNRpFKNz8EnU2ESxeAP3MOYgOeE8QOLGBiE0yoNEa99+ifoapUFADXsYm6zlF
	BFEYQFeKBaHx5jJPwl10wXhqS5WHDBnb+a8S+qhNQ2p4RdShfaKLpdKR85v3lbQJbZuavrKSssc
	5tX3lV8THJd0j4VKJzjOKxXBrQJfQx+XvlaM8nAXT8ePCJR39phhCBOe1JY/V60z7IjlKWfj6Lq
	QXSuYvjpfcJ4zI4jPwgESegBUzlEFe5lYrUqgSy9eW3KujdfDJgADfvF+9zBSLoVYC4NiMKiTL0
	b8hhpoujES3l1giulRZgjVpN8f3EVcLcm2KelXObFzrW5+7HBOHHWzmnAb/LiFQwk/jTjgIFlPc
	YhKZvcm7mAXomgGw=
X-Google-Smtp-Source: AGHT+IFedkd78SDrsxjahnEbM2pzg/zyHlHKbslNiqwrGHxrAvh6pS7r2bvmEgEhjZGtcvK72ai09Q==
X-Received: by 2002:a4a:e913:0:b0:603:f973:1b6 with SMTP id 006d021491bc7-604a92b330bmr3384645eaf.5.1744912608302;
        Thu, 17 Apr 2025 10:56:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-605ff5f778bsm47206eaf.17.2025.04.17.10.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 10:56:47 -0700 (PDT)
Message-ID: <94abe22f-ae52-4bc6-aef1-4378db38f494@broadcom.com>
Date: Thu, 17 Apr 2025 10:56:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ethernet/broadcom/bgmac]: Implement software multicast filter
 clear
To: Ujwal Kundur <ujwal.kundur@gmail.com>, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org
References: <CALkFLL+LxVk+M--+qHiP6g31rcvXxBGRJpKvp=CCFekL9OyUww@mail.gmail.com>
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
In-Reply-To: <CALkFLL+LxVk+M--+qHiP6g31rcvXxBGRJpKvp=CCFekL9OyUww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Howdy,

On 4/13/25 00:25, Ujwal Kundur wrote:
> Hi,
>     I'm trying to work on a few TODOs in the
> drivers/net/ethernet/broadcom/bgmac.c driver code and came across the
> "Clear software multicast filter list" item.
>     I tried comparing the multicast filter implementation of the
> sb1250-mac.c driver for inspiration but realized that most of the code
> for bgmac has been written by reverse-engineering the specs:
>     hhttps://bcm-v4.sipsolutions.net/Specification/
> 
>     I'd like to try my hand at this if there are documents/guides
> around this topic or if there's a canonical source for the binary that
> I can try reverse engineering. Please let me know if you have any
> leads/advice.

Given that these controllers are always interfaced with either an 
integrated or an external Ethernet switch chip, the design was done 
assuming that the switch will be operated in managed mode and multicast 
filtering will be done on the switch side.

It's been a while since I looked at that part of the DSA and bridge 
stack, but we should be pretty close to having that capability nowadays.
-- 
Florian

