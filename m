Return-Path: <linux-kernel+bounces-889402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7F2C3D787
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0463AD3C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF32305E2E;
	Thu,  6 Nov 2025 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b5JzrfDd"
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE82D5C91
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463876; cv=none; b=nif+F6tAGQ0p01A72CpPDELPLMpJPq8HNEDBlSl2/l9gcwu5M2i13YVKhWTFBhSo7n+z6wJ5kUHRqzLu7zyoyzj3UfGfUX+BrO8d2B9DSCGrPFC6rZwyXrQu6xGd1oPnYEIV5gl7GtpfVw5P0rsvirai+D8+trfh0keyXrXesds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463876; c=relaxed/simple;
	bh=zeV5pygef1wyF/lJ9ko9Ct1bLGUnJuj9ngVBugT6rW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVgIhfeb8GRdGum+5KI26OGhZ+kWjJuzbthpB4FWSXHG2ZZJIvge9w8c0UEGW4WMm23t763TU2Ckt5R0J4rQn3d03KI9A/mW+iyr6Xs7xZ0Al1dz5Uc3n6LWgmow9hZ6dRfxQljOPWFOO1LVNhvBoUU5633PrRbRngfrUhTPNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b5JzrfDd; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-94884c52a03so3808639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762463873; x=1763068673;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9qh6M2+2slNp/Eaqs7CKpAs0otSPjZ5PWWWvvqphD0E=;
        b=WpBTXem1BcdIn8OVugiEabFQfQJh08+p1lB4xfnkCRbwbYDq3BmgTwaMFDFZhQcg73
         P2enEMizEPPb3VWzo/5T+xZ6Icm7wrYLeELGme7TlD41uc6KTW+xQR7Q1r92EWk4o2ic
         B6TsR/UzAoQmRxumWtrD4bvyyTNEZdPog/JXVRtqoOIvdci+JUnY+qpHbiXs7y1gLRaG
         Om1ceA9eFJEXDbxUV/x3MK+xDzUXxD8iCkphu7etpX4B0+IhtLMYrcm5pw7JThUcanTQ
         9MC01P3WFVE3dxyjnj6glAm/zJpXrsa+sIfoPCVIM8vfzS7To04+7sUZuvMaLVVOgYI4
         1W6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXv3PYGddDcSNmHW0zeg7hXzLPfdWl5WxfwY8vZZaJfP7eCTTWOnSTU22NqYjZgiBCa/FA3pdiS3QpZJjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHh5ck/UGPHC60FJ56L5NKYggatK9hTk/WgaEyfEBxaB5YkUBL
	cJx+xDI9uVNHjHkutlMcfjcOfWrvN+MwtdKZh8JQ2BzvzQsw0zcreIdzq3J3gsrraFz1HMQ24pR
	IgFvrbJ0v1yxeM7NSqw6Y/5kYbb6ZoevoMTknSbSzH/MQ6j6Fej2/eeVLGNMjG2dgnHQboDLG+Z
	0SGCNZMfHZJD7JczNOkoFe2QxPrQ6P4oh+mLyHjfoyZnPPeL9zx9Ji/M4QmNmr3N3zeEL+bNA66
	hCFJ9Ay014kqom7Q6AvrTob
X-Gm-Gg: ASbGncsxveA7BcZdD6+qkznUvAmUN37gfWZX0lQXDG65YeowbVCZSEJHV956nAC2Tn7
	X1U5lztwO9ORxgzLeotFeA41ovwnMKFtoQXRuAae6pHzyWzS8WPXCgrWIyOr5H8wOJMkYO236ve
	az9exN1SIDN0dFu8zZ7f3lRvmH1HhDAHb9TMtniw/kIZ1F2rdVsGOk0BxkWwubukcfUGnVfPnXi
	D5kvGroMxp+JaVoDfphMZ5p/otT/zEwNBnOASZ7GSWAEkC1GY2aHrkcNqukWWaE3/34Qsr6CaOu
	HFwUbuDj5KFUmzvwBkQjISh8u1Wtlg/P33i4e4vycGLdBPhUwRuTAYnJ6T+4v2223n9PdcNxqxk
	XgOSg0c4W5ik8ndTIIc+MrGFzIK2PNGmdNQ7nHraScYJz2iwlNbsxyAeK/oQWWux5sl6vHyxK56
	Zbaa7NwJEkOnZRTkzTmT/OA6VF0dMA9kUUfx/aGZI=
X-Google-Smtp-Source: AGHT+IEUSDgt4G4oyj4wLOLpQEOaN/zCVGuZA593+mfvDqBYmam5iKnfuaQfUM3erouY5qi/SOVZfVLIDXvU
X-Received: by 2002:a05:6e02:370c:b0:431:d726:9efd with SMTP id e9e14a558f8ab-4335f3cfb5dmr13686665ab.12.1762463873613;
        Thu, 06 Nov 2025 13:17:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b74677112esm359107173.14.2025.11.06.13.17.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Nov 2025 13:17:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b1d8f56e24so17282885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762463873; x=1763068673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9qh6M2+2slNp/Eaqs7CKpAs0otSPjZ5PWWWvvqphD0E=;
        b=b5JzrfDdLeLAvFNJwlJ7KBXF32doILcZrZqRa463Mj4Ani4PEYFUe3Xf6QZ/sLe5YK
         x6iyI2MYDdpf8osrkAF5L08o4Sei1Ve3kmtgWHzqCYIgWbrm6EY0GCmZvL6ULyzVp8Xw
         N6qfQ0RDA/bQ8xHpS56j3NdZdkCy5B1Q9/CB8=
X-Forwarded-Encrypted: i=1; AJvYcCXn9h2B622btTziqLXH4QOXD9GucSGJNurBmOc/EMlyXsIJuUkHvd6lyGEp+hsdHelB0pOAKQOfvAfYhfo=@vger.kernel.org
X-Received: by 2002:a05:620a:294a:b0:8a0:8627:30b0 with SMTP id af79cd13be357-8b245339b21mr164834285a.49.1762463872805;
        Thu, 06 Nov 2025 13:17:52 -0800 (PST)
X-Received: by 2002:a05:620a:294a:b0:8a0:8627:30b0 with SMTP id af79cd13be357-8b245339b21mr164830985a.49.1762463872373;
        Thu, 06 Nov 2025 13:17:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2358287eesm270270585a.54.2025.11.06.13.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 13:17:51 -0800 (PST)
Message-ID: <f0eae1d1-f845-479a-8388-a9351e9467b0@broadcom.com>
Date: Thu, 6 Nov 2025 13:17:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] Allow disabling pause frames on panic
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Antoine Tenart <atenart@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Yajun Deng <yajun.deng@linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20251104221348.4163417-1-florian.fainelli@broadcom.com>
 <20251104155702.0b2aadb3@kernel.org>
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
In-Reply-To: <20251104155702.0b2aadb3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/4/25 15:57, Jakub Kicinski wrote:
> On Tue,  4 Nov 2025 14:13:46 -0800 Florian Fainelli wrote:
>> This patch set allows disabling pause frame generation upon encountering
>> a kernel panic. This has proven to be helpful in lab environments where
>> devices are still being worked on, will panic for various reasons, and
>> will occasionally take down the entire Ethernet switch they are attached to.
> 
> FWIW this still feels like a hack to work around having broken switches
> to me :( Not sure how to stomach having a sysfs knob for every netdev on
> the planet for one lab with cheap switches..

That's understandable, we have seen it with any sort of Ethernet 
adapter, GENET is the one that we have the most deployed, but we have 
seen that with Asix USB Ethernet dongles happen, which is why this made 
me look for a common solution, rather than a driver specific solution.

> 
> If anyone else has similar problems please speak up?


-- 
Florian

