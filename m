Return-Path: <linux-kernel+bounces-756835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FEBB1BA03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C0362791D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F7D29826A;
	Tue,  5 Aug 2025 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iNbwEVK8"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511A200127
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418386; cv=none; b=Hy/lT9q9mTbR8b42veboKsKrZSlNR2VWNmlI3IINuVsvHvQxqJU/XqutVVYS32RAYrc/j44/iiVOzAVLjggFwZfGwQLvAGMpHAqwDjR7jKyMSwKabrX5NbvvKVUwrQM8OHLwuOVlfDbEpb16Ntzz6NhyKY5yhZZkS9HWyNptR10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418386; c=relaxed/simple;
	bh=1jg+S6aV0kuwXWyD3U458zgmPhN9KD+y3MUFOq+T34w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhw2KnMz26JgRdr4hOHdCtZrCgvuP9bLi3pOrVuJAP6voxdkV3UGnhH2OdnkxX9nSDy8Usaj38THmPBVEZj35uJtlEME+fFZ0Pzx+KU744mtzqU876W12a6gewKPaJ3OhUD/2MvDFtbEEWrsWlVjJzA4WoyDtNRkIPHVah8MVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iNbwEVK8; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e29616cc4fso542537785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754418384; x=1755023184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tnmuyuxk+O1TcGABMCHRRdtn9QLWjgYIfvOzquu+uds=;
        b=iNbwEVK8zhYUzFWcnHyG9ABlG9LlTzDeJP2YI1RA50834IkqHWqA8+5QKRZGgyaq1s
         xDeD7D6DMcSbKTeQSy0+HMkn9Dy3Irkjj90AwckKBAqfyFh4j6eqHZHsigHkMnxVIHdb
         f/MEn5aMr6u+053pmw+eV6VWW6EmN6h1F879g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418384; x=1755023184;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnmuyuxk+O1TcGABMCHRRdtn9QLWjgYIfvOzquu+uds=;
        b=NV+LwTUWhWjYfNtpS/DsvGAk30C6x8feuD200Yd+NsKlrT4V9fPI0od3Iy2X5oSJZc
         qYStX4rFXlvRur6tO2vv3aTn0w5wBozXfPxuRc/Ggt3f2NNYNM/Qj7MnIlBXOF6REHeM
         MG3ESHy6mE9tyrnviTd7YmKen4w1ptDI1N3+op6AdlSWQc3bNysEkhtlouvQCBJEIX4B
         9N2pHLZeJlYknFwa+JAM7G82opv1/SkkCGPFm0L3SExY6PDV+J8/x7yzOP4yW4yJlZRJ
         RaL3bW6BykNotb9T4dSt8qAkseJA2znObA/6JiGxE6R0FVLMvtJ3T+Pks5lBiFyNb3B+
         A3PQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9cpNpvv7laSbYXuct5p5ZnrIERYlr2kWHw+0eJ2CX0Bfpcu6GtlG7k6eTXy5eHeiSgIEZCOh6AmQUXQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/R5Crcp4nP0UU9qAyUTpVfaV2wiJctJklEJ38VvPvnwTUrujs
	SaLIpnGRqUkAX49BmSH0hvEo9ebfnvo0pQlJEEeTPH24ewMLR0UfaiCm+uIy4oft4gWQW8JJZke
	GPQRG4Q==
X-Gm-Gg: ASbGncuDDEriWQSyNTmn4lsgbnwB9NjO2fuXMbrim5tNvo8qG1XFGpUZSb3GmL5fd8Q
	T7XD4lrqbePcbgSdM6M2x2NJdfw5Y5VSrgCnaSpnmQpptFkB0wmDKaFEw6sKAMXkvT72ihqrZmA
	HNuGi30nxHX2jIeCE+Mwg77lZkCfa4uMMdJ2YWpX7D018osHQ3bMyzoUUSmuCDc4RkEtxI5pu5b
	siUeI7yx2BFOz+lpig1KL5OoqUXLAGzNPd7t/q8BwIevmc6z11jpUv99k09MwM/DExs5p+WsQBI
	f1wEsi0z3EDqd4/jN/BnfMmkW31TgLsuoWWYrWsbGgp2k4WLzJ+bv8WHf5nD2DM/zP78yEuGP3n
	vcseU4FGAciqSnal+UJTNtvIpr2qn27A004F69xI9DLVC4jvjzhpWk8lQQ/Uy5w==
X-Google-Smtp-Source: AGHT+IGJSwdaUI+pBTzam+Q9RiQny+PO7AYfRoYAnaaR5x8kJBTeoDxrMuHIu9qWvwhJ4WoZ2om6mw==
X-Received: by 2002:a05:620a:1a28:b0:7e3:30ac:8cb3 with SMTP id af79cd13be357-7e814d06a25mr44984985a.12.1754418383658;
        Tue, 05 Aug 2025 11:26:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f7061c1sm711780385a.51.2025.08.05.11.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 11:26:22 -0700 (PDT)
Message-ID: <da6a2585-daa3-4dd7-bc42-5a78a24b29c2@broadcom.com>
Date: Tue, 5 Aug 2025 11:26:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.17
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, John Ernberg <john.ernberg@actia.se>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
References: <20250727013451.2436467-1-kuba@kernel.org>
 <CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com>
 <CAHk-=wiQ0p09UvRVZ3tGqmRgstgZ75o7ppcaPfCa6oVJOEEzeQ@mail.gmail.com>
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
In-Reply-To: <CAHk-=wiQ0p09UvRVZ3tGqmRgstgZ75o7ppcaPfCa6oVJOEEzeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/25 11:22, Linus Torvalds wrote:
> On Tue, 5 Aug 2025 at 19:22, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Sun, 27 Jul 2025 at 04:35, Jakub Kicinski <kuba@kernel.org> wrote:
>>>
>>> Networking changes for 6.17.
>>
>> So I found out the hard way while traveling that this networking pull
>> seems to have broken USB tethering for me. Which I only use when
>> traveling, but then I do often end up relying on my phone as the
>> source of internet (the phone being on the single-device flight wifi,
>> and tethering to the laptop which is why hotspot doesn't necessarily
>> work).
>>
>> It *might* be something else, and I'm bisecting it right now, but the
>> networking pull is the obvious first suspect, and my first three
>> bisection steps have taken me into that pull.
> 
> To absolutely zero surprise, it continued to bisect into the
> networking pull, and this is the end result:
> 
>    0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f is the first bad commit
>    commit 0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f
>    Author: John Ernberg <john.ernberg@actia.se>
>    Date:   Wed Jul 23 10:25
> 
>        net: usbnet: Avoid potential RCU stall on LINK_CHANGE event
> 
> and I'll test with that just reverted on top of current -tip. But it
> bisected right to that commit, and the commit certainly makes sense as
> a "that could break usbnet" commit, so I expect that the revert will
> indeed fix it.
> 
> Considering that I will need usb tethering while traveling during the
> rest of the merge window, I almost certainly will just revert it for
> good tomorrow, but if somebody comes up with a fix for this that
> doesn't involve a revert, I'm all ears.

Looks like someone posted a fix a few days ago:

https://lore.kernel.org/all/20250801190310.58443-1-ammarfaizi2@gnuweeb.org/

though it does not appear to be in this pull request. Can you test it?
-- 
Florian


