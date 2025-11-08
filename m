Return-Path: <linux-kernel+bounces-891238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 153E2C4233C
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 02:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C6C13449B3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 01:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEBE2D594F;
	Sat,  8 Nov 2025 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JOueGdU+"
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61629A33E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762563966; cv=none; b=D6++ugSsR5zMHEGyTpN84xanqV2qZf1hwuBOYKIb5gnPaXgu3PG4mtA4DpdvY8R4nRPsR3vh0NtMdymapE2WxlxpkXtez+HJh8XiBbAV7x8sTVDliPlfK4AlmEFOOT3KYsrfENuu1CbS8aoLqXB8HDlk96qdtTuDrSs3G503a1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762563966; c=relaxed/simple;
	bh=KWpNQi/bHHa6DffH2BEbO/AqVofAjoVXDyGXXyiGsJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kv2fZcXQblj4jv+gzi+f5glXNXkjiw5GmySIhUj2Ap27kdGx7WNnjdA81VxCosuiafX/maaTKT678k+IBh8XrmJlf3aAlDqMKiqlXN0wQB3WVd6F52pHh4xWM7xDzFTW8mFZhY3fappbor1I5C7+/UsgjjKD56EYrOpN0YBgM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JOueGdU+; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-882379c0b14so3789986d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 17:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762563963; x=1763168763;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3lhMCLmx715s5gpkIWtPdjgc5yLnvCm4NO5ZRwIFijA=;
        b=ioNPGhgVi/DbPtqcAt4LO9Baoy7Z6COhpew2BJKLUrow8piP+w0tHDWOzGrm6ynjy4
         8QlDapx4RPeT60hF968BjlAzL05TI9LCx4k8F7qqoha1AL2Yn66CTyIYcUWG6ZAudmRk
         C+iX8JLuCZ2jaQeUf28gVhDkCO1+qUYwh4JNM4P3xQBAO/Ga9MwHrA6SSQkfYF/KVGja
         spYAFM8lLLWCoiFkK/KgQdn+xM/vd8qDXhWZ1arkLMFR6KyZZ5W9r0zo28Hg82t1eBbr
         cBJugn1uexKWk6hPBPTWAD80fKRmEnafaL0A2sh3I/3mSS0/W0QRo/JHqhf9yWMUNSWp
         QJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCWqsb8OJukfYLeENoDhduhQgiV+2Q1Wgyonblt43WsUY75J8wPmTTmrHpyVieYR3m1yuSAyOVzcfnH//5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6dvkU99EKDWc5OrWUM5bp0NBPJMVOMgIaQYIhUCbNR+3JsCNy
	/tbj3AkaydGuN70jbC9I/Sstv2vusciNnKx7ebXt3mzVw/nWsHbE8A/jxHf+CdDgkvWeLHBfZV7
	69oD+pmEIwCNJjDrvcWdGHgADzTVFWsQ1UppSp96CLjYcEonK2rXZqejLdV0q8WIDn0Zts342u6
	QogPuWO6KTsnJY1knLm2lEg6kaKNfYYHNU5icRdiwoGN6ZokMJi0v2EkPD+Lmq+PdUUDMX86Xvc
	bKhc5V95wlT/QxOJZtyxKp3
X-Gm-Gg: ASbGncs+0I8sS4YSsi8N+er2vEcbrwdvdMxSqrSzOoXLY2wPrv9o/bacEBC2g5e6V2V
	BjARYCxZLaT5RkLV98OqFcFX8OZ23kimUq9tasmBY1M9d3nWn0SEXugwEU4n6aOenU7I4j5uRmb
	aFklP9sJkJWkllgdffFoNr/QBTIRHqS6tOqIdsemTfRclo6jmvdu0T8GMc5uGH4sNqX3yEWjy+N
	G3nai+sZVMYso6/T99KaRs2cbXNM1usvBRGpcdggGZRSBCpIc1PZ5SgIP7QBFg86KPSsODMgpjb
	nb76xRVK9+4mgYmUvrOtCKctNYLR9F97enc/VD0Mef3FLb6eLycbGj925Y5Jr4FwRtkkZGQwQ1E
	0ZcPrt+nZsNbKJajJGDY1G9KV9AcVCJEAMeg8k6I8hGRqMV+dY4bEUzBi0AMnY+Ku54iJU5b+yg
	M/Uxy9F9/3St8LwI6aSKYRire8wJmKO/dQVWFq8gE=
X-Google-Smtp-Source: AGHT+IHTqAmmBIFiZeSzieGVuv7LVdibzRibyqOJ1ckOzotdbZiUZ9lMUGgtrFETxUm49HwXYngpmzXpqvO/
X-Received: by 2002:a05:6214:62e:b0:880:460a:96d0 with SMTP id 6a1803df08f44-882386ecaedmr16596406d6.54.1762563962953;
        Fri, 07 Nov 2025 17:06:02 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8823885afeasm823816d6.0.2025.11.07.17.06.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2025 17:06:02 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7c276fac573so840885a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 17:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762563962; x=1763168762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3lhMCLmx715s5gpkIWtPdjgc5yLnvCm4NO5ZRwIFijA=;
        b=JOueGdU+ofpzceW3ZQuGeZ0LAEDoMl9hubK62+hd0tjCgW81rsQWZ59l/UTcLvZwjf
         yDgyq83ES8ldM4mg+VpC+vnI24vgxWFUAMGDHj/4jcM0oJBKKAhaakBtJBqMlspCQJfI
         d1eSVR+3BmlAyJkJ4N16p3OuQHm/osaK7Mfgk=
X-Forwarded-Encrypted: i=1; AJvYcCW/O95FL/vhW3gG5YT7m+Iyb+ohpBXKFqhPY+fR0ASjSmCjPOBOQBWhsOSt7lkCDD5ia1ebsMrK83klQ1o=@vger.kernel.org
X-Received: by 2002:a05:6808:1801:b0:44f:e850:18ac with SMTP id 5614622812f47-4502a3db3abmr719185b6e.57.1762563962080;
        Fri, 07 Nov 2025 17:06:02 -0800 (PST)
X-Received: by 2002:a05:6808:1801:b0:44f:e850:18ac with SMTP id 5614622812f47-4502a3db3abmr719178b6e.57.1762563961737;
        Fri, 07 Nov 2025 17:06:01 -0800 (PST)
Received: from [172.16.2.19] (syn-076-080-012-046.biz.spectrum.com. [76.80.12.46])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57ef2e7sm3137695eaf.18.2025.11.07.17.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 17:06:00 -0800 (PST)
Message-ID: <f0fbb7fc-d776-4507-b686-4cfe280099d9@broadcom.com>
Date: Fri, 7 Nov 2025 17:05:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net: dsa: b53: add support for BCM5389/97/98
 and BCM63XX ARL formats
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20251107080749.26936-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/7/2025 12:07 AM, Jonas Gorski wrote:
> Currently b53 assumes that all switches apart from BCM5325/5365 use the
> same ARL formats, but there are actually multiple formats in use.
> 
> Older switches use a format apparently introduced with BCM5387/BCM5389,
> while newer chips use a format apparently introduced with BCM5395.
> 
> Note that these numbers are not linear, BCM5397/BCM5398 use the older
> format.
> 
> In addition to that the switches integrated into BCM63XX SoCs use their
> own format. While accessing these normal read/write ARL entries are the
> same format as BCM5389 one, the search format is different.
> 
> So in order to support all these different format, split all code
> accessing these entries into chip-family specific functions, and collect
> them in appropriate arl ops structs to keep the code cleaner.
> 
> Sent as net-next since the ARL accesses have never worked before, and
> the extensive refactoring might be too much to warrant a fix.

That seems entirely appropriate, thanks, I checked the 54389 and 63XX 
datasheets and your patches match, thank you!
-- 
Florian


