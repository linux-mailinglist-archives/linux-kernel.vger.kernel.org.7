Return-Path: <linux-kernel+bounces-751206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3329FB1666D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5BC3B94A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4022DFF19;
	Wed, 30 Jul 2025 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C+LRz/Fs"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806EC1DDC00
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900840; cv=none; b=iWAAIti2lCnoIwUr4esqbmoeQQCNV9HvlKoLssqGS9ON4qqxpIla/u7aKKQW3M7MQUtlX/sMmRJ0Ohf55eWk69a18TbGTTaqe2v+/IP0wCIaC+hnReb7Jj4lJGSkSlbGQh0LQO9b7ZDutNOQK7T91MHDBQD3L9PvWrUoh4D0BLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900840; c=relaxed/simple;
	bh=IVM70qYvN/XOAguGi/kqskNt7LzvrV9LGIbn7aH+V8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEy3HSnWSoTE2MRmg4VGGOmU6EWWqBqfdJLrpduZ04mt83lzdfB7jZ6benmA0hPrHTmD984t/eqUJnDDViM/km7xdUlbo7LkfQGHGv6Ah9hNGqJGYhe+YqDp5hulARDQoaYGcAPT6cA5tdxcyhaNpgbtT2k8fYjUViQxQqCMG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C+LRz/Fs; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e346ab53d8so19031285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753900837; x=1754505637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IonUsexfFJI2Qe7J6Ag5z9tijA0TPXif9Ty5AL7Fkk8=;
        b=C+LRz/FssFd95e6X9dQ9qW7kSlA1OIAg6zHdRnjn4ghMWqt6jfqROQxsDZ5Lzwh2J2
         p+vsJg1ZhK92WljZZSQvHjKDIrGPu4jRz8iytBaDtYVrcQ1tGf+em2tYT4qmHMIJixV1
         banbenB8KXjhlMt3SmBQkAH6PJhRi/ZoQpkXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900837; x=1754505637;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IonUsexfFJI2Qe7J6Ag5z9tijA0TPXif9Ty5AL7Fkk8=;
        b=Q4wLKSQS0gGGcUFxceRi0/mNj9iJO5xwvXihwjO65lbWC64TLTymPbRvA2uNKQtlax
         oA5VgaArL7icrqg0QBx34cyZ4F4AUqv7keUn9nHq7vVW5ajvLagJgbGwzc/bu8yGsXZ4
         sgyf/VrAhwRB3bvUUGfCdHxph+juvivYm1hIj8J5ET1h2DHhbEXkyzfHJ4R+GElMkBio
         HVSmkQ4i3ogbCNjTkF4DgDBUrO0KYARUdVLuKFzmn2wfn5mEIdtAHmrCL22qU/mMml/5
         nKe8QhWTAuzn/sfR7Zlsne/Czm/+faJKkpB0OHmZFapltSvGDGa7Tmy9UWcU5y7Uhr82
         EnSw==
X-Forwarded-Encrypted: i=1; AJvYcCW2z9sv2qYdtInkKZwDpfbMjv+TVUBEihZnBY7EOjQFaqpMCG0Tj4tRskBzQ9FGaYYKjJe0iDA9raz6c4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHh14j7U1OYjkRvsQBZGzmWvn8JDzHsYkWwRsb9piQne90K89
	Lunc2681i92XqKp7EjLaeRmHcD7loTuWKPjD3AmUZ/J6n8TGSP11EobGi8gjcKCHtQ==
X-Gm-Gg: ASbGncsU1HJrXcrojMT6hmCtzGvIue3unC1WSir0av54wNJY1UhgvrxGFA+7P2OQULh
	lzwU/EJ0TEeFKxhmja1pBhYKpmnLVSNzZvE1g9iClNArt36DgPYFJ59qr7MwchQUziPShoeijEC
	9aJPS28S5w0AY53Rffg19KBUHoQAXqrVdzT/5HaL9P/7j4MTEHE+sqZqsppInhTX91gsQKu0a9F
	SanXBw28YLUvloavAov0WtVjsd97jTAKJ+TLLJM7PNpFz23v5p5QcGVaef8cBYifMZQ+uDKdjji
	yPOFULP7dmOLOSvO596brWxQC/y1gnAM0oHKMhNBh+gZ1fsbOyLkhmU8USjw/uMit8dxZfP9kI6
	KNEj47g+cAcVVTWAaA9N8oEDhWgoi7q4eljqXanuRf5jH3+f4jWlT15NH3ZZNIphE1ARO6AeJ
X-Google-Smtp-Source: AGHT+IE3inDhWohOYETkhYbohWJXCAMzVVHXaHtt0AxBFNb4I9F3zUPQuGJUH+H69GHCagCIYEv1cg==
X-Received: by 2002:a05:620a:a20d:b0:7d5:e4a2:2374 with SMTP id af79cd13be357-7e66ef7f88dmr578892785a.8.1753900836997;
        Wed, 30 Jul 2025 11:40:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432928fasm604278385a.21.2025.07.30.11.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 11:40:36 -0700 (PDT)
Message-ID: <1d12c152-d248-499f-a3e0-53d02b7c873f@broadcom.com>
Date: Wed, 30 Jul 2025 11:40:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: dsa: b53: mmap: Add gphy port to phy
 info for bcm63268
To: Kyle Hendry <kylehendrydev@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: noltari@gmail.com, jonas.gorski@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250730020338.15569-1-kylehendrydev@gmail.com>
 <20250730020338.15569-2-kylehendrydev@gmail.com>
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
In-Reply-To: <20250730020338.15569-2-kylehendrydev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/25 19:03, Kyle Hendry wrote:
> Add gphy mask to bcm63xx phy info struct and add data for bcm63268
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

