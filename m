Return-Path: <linux-kernel+bounces-670899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7EEACBAA6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 20:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033A41627B0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 18:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CA822D792;
	Mon,  2 Jun 2025 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TvPYh9f9"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C3A227E89
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887305; cv=none; b=qjAXbs++4b+X61raKZ0tzelLXyC1PT9ZRZYk1AfwW8bpcbqdQUA0NzdFp943ez8FFpuVCGPE8n1lZPDGGj+NaTOpJP0YuE8y5Qdm7sShpQc4QHf0y5iG+nZbwvKGsGkgqJwN23rdi9U9C2DvR2L+lRP9yKGMOd6MS+8c53u1ASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887305; c=relaxed/simple;
	bh=K4Nc6RZ/h3orK+8vOxhk2fgNidmN+v+7WUg1VDUUolM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfNbbNjDr/NPeTv66Nc3LijgzcSZRUjRsuYdW0B6W8O50Czu68xTtyp01feVJByxY3qbuI3vAy24ddP47qkmzzrH95gkIPE2wWa2zXu+M4c0WR8oS+foZp5Y1aK+iyJZJ+7WZTnGcZVP0btERGgnhvr3JGwep4Jl3bQSGZfHglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TvPYh9f9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22e09f57ed4so47992615ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748887303; x=1749492103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kAayzdupmKfNjecbKeUzPQmblce5U+/YjTB8qk0Cwss=;
        b=TvPYh9f9BHwiA3mb2YeBk00By4C0aIHlzgcPFXJdicJ8s7Ty/z6PP5fo6LFEkxkNMo
         OyKHuOnqqykpp2sDUxsTmmJURCX1CHiMtbkleH0c0VLO7KqoSMUgy3gWo4yagn1QAoHI
         JZwi1G+0JomfMPZffF3hcWNmdUNnKb2ZQrNMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748887303; x=1749492103;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAayzdupmKfNjecbKeUzPQmblce5U+/YjTB8qk0Cwss=;
        b=eaF9UrdTvZXHzxwdO5GHAdF3KtY87eV1iI5+uBUfx0J2q1xY2jro5Y7a0934v5PVGo
         pNQJnuQmJhDOZkWYs1bOj7kqpgrwjKt0vsMrq1zvFi6sPP2bqqx8kRqHw7L3BxfDEi2P
         XWwNAJIzOGslYZ5fVdh3yBQjKGJqc5eajgFsseD8eAnBCetPofvp7L9yfakGJ6hlwehm
         2SADQqGseWmLkUGvfOZHzNsBVaq+KSOxmwaXLeGsr5RNE3c6BPeYE9TqP8EnhYT1HqsZ
         ejvXTQwc5JGoCTgW2qBEbT6xwA/n4OcqGFyQUdqFUiwr6TpEhZxHVQXbCx59Abs6PbkY
         SowA==
X-Forwarded-Encrypted: i=1; AJvYcCUIeoMsdT+zkyoJLHgNWV9/Xfpou2NKAvmaBk5WPiVl3dgpXc/nOYi9cpFHoH2/J2Q0oooE5EMDv5oYje0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwe5LnmPNc30MhCT620mrHfVFHxyDkyETNzOMn6yG/lHQAmg9o
	gd6ZxHpuQ8ifgziyeRhSPnnHegTVUK1emfSO9TFBz9fgdMb1hVl/DJFomqIgW6wJAw==
X-Gm-Gg: ASbGncvW/ZuNUsUQOHglDan2QS5qqDjEnGA5n9Ig+Ark01b//9uBecJBB9gptc6Vxgb
	QrwysyF9IgZSVzfOkbZpxD8UuT/KR0Ic9YmcZid63VzRUtuRZTGjtCwXBH88xp3N9KRqp9S/HF7
	IJfPu8QpBMueCmpgy2PS5UTrYPJIeH2mat5Ihjng9NHNn9xRVs+ayYSg5CqHBLDWk1TPqJhmkSf
	WabafFazAhxg2QNkUrZ7G0P0jQJgV00FBAbMezFsNeq9mnT+lJFKkxC5HX1/bjQ1QoR6FiAYbHQ
	3pmxccC9lK0NBWmocsCAhfmg0gr7Ey2cq7KfZOV6cDlmvnkaBz4HHdS3PiAptaEh40i898RCu0C
	OOMT3CfqjROdioro=
X-Google-Smtp-Source: AGHT+IHLk1uVgC/gcj6H7l7evhz4miSWTp5JqQ/KozWCD+7frDjN1cpL0YvV2VA2gNasn+V+f/Tw6A==
X-Received: by 2002:a17:903:2452:b0:234:5ea1:6041 with SMTP id d9443c01a7336-235c787f1efmr5063245ad.10.1748887303379;
        Mon, 02 Jun 2025 11:01:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-235069fa2c7sm73265655ad.0.2025.06.02.11.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 11:01:42 -0700 (PDT)
Message-ID: <03565c9a-9345-4c1e-9c00-b16ed8acbcf5@broadcom.com>
Date: Mon, 2 Jun 2025 11:01:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/10] net: dsa: b53: prevent FAST_AGE access on
 BCM5325
To: Vladimir Oltean <olteanv@gmail.com>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Cc: jonas.gorski@gmail.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vivien.didelot@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250531101308.155757-1-noltari@gmail.com>
 <20250531101308.155757-3-noltari@gmail.com>
 <20250602093728.qp7gczoykrown34k@skbuf>
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
In-Reply-To: <20250602093728.qp7gczoykrown34k@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/2/25 02:37, Vladimir Oltean wrote:
> Hello,
> 
> On Sat, May 31, 2025 at 12:13:00PM +0200, Álvaro Fernández Rojas wrote:
>> BCM5325 doesn't implement FAST_AGE registers so we should avoid reading or
>> writing them.
>>
>> Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
>> ---
> 
> How about implementing a "slow age" procedure instead? Walk through the
> FDB, and delete the dynamically learned entries for the port?
> 
> Address aging is important for STP state transitions.

That's a good suggestion, I suppose for now this can be b53 specific 
until we encounter another 20 year old switch and then we move that 
logic within the DSA framework?
-- 
Florian

