Return-Path: <linux-kernel+bounces-891204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEDDC4224D
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A68794EF57D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1154427FB25;
	Sat,  8 Nov 2025 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vp717TLJ"
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCD628641D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562589; cv=none; b=hzgv3qqut8fLLx6msGQIQjzJIlMbtj6VoJflMBsCQHEsKvF3Fjmk0mEIdsaQRg1Tk7z/606wIQNKb/utryDadaspOxPiGUJmxE6OKNZ2hj6bBRB4qY2us1MNy2+Wns5CIfKPZcVOKpqDKhA//HmQfn6buuKN3gFq+TQdGqAbF/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562589; c=relaxed/simple;
	bh=fO/ifcZ8YnY/H6x+bJGY0rfhBdRRNGrC70M25TOOFug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LinY9BdgDusYFt5SgGhs9so6DsMvr5iGLPtB7OtP2UGLapfB8qcNjNGDnuwZwh2P3G2TfY6lMkZlHHIdGIAgLo9wNkofi/kwNUr+M/bctcK5coiZnGcAxIZ7XmU9VpPT6otf8NtB0YWHk9V6P41I50WQd7mc6DCKdZT2DH/2e1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Vp717TLJ; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-93e2c9821fcso119031239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 16:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762562587; x=1763167387;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wfc9eBIdG6EpBk2naWqUKw0abfgjnbqn4nQuM7NwcuI=;
        b=TyzGUW0Df9wePWDXkreFuLgj7R9LUycFJYZfUyfAPPrwl0m0d9GRn8QAaRIoe8PHbJ
         b75c1yBf/O1wffwS0AoKVJkKP27O32NyxQrqbSnwloArdNsrJL64WauNnVSd7tYpaL6c
         t8HoI0SFRkOeyt43KbCTt3W2pUCsX4AqZpPrXvsXQKsCZ2DGRm4hfsCukiH6k7IJYBnm
         q2JQ0M73q67HaGZ4Rx44nFTOHnh85pQPe7NVyMcxY+XkzoDIOkys1vFnzOizqbOaZoTr
         D8Ujs4EdERxgMpz/XGe0HcoRJcSyPn+EEg6BzDZBlMO6WJMuIgBNzJ8xvofH2xq2lRQy
         ry7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1K/j6uqQfjvwGjA4zQ18izwWGQa3qqs2MdC0KdHHWtz0Jlk/bIpBTJKyeiiPXpYZQXrngo8cLhhxHWUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf2qv3r5DiuTRwCxInYF62USZN/PuoY2UfNGq9UTYxIRjqfSXl
	9oa5gOsdvD9yrOcnmzXUAnIYyKgnAquMeZ/fN9RDj1X8RXUs+whTXiQXx+GznCJKvB5HdDyY4/E
	TqXeaqr70Lb/u+rrK2ke0AN8YJXnIM66EXYgxiyykG6zj8biU9zhyQWSaKGIjOmP3ugIlXh7kga
	hSDi0pDWp1+mFdjGLERYU992zUw1C0ejX6SOwndgzAzGVskN5BhrWcXwh/pZRGegPV906b4F6K7
	CqQfwHpA6bJgTojSHWTLlK6
X-Gm-Gg: ASbGncsdVJJ6SlodfiUvBrVrxV6X7ffLwDbbgaDNVKqn7T8pPTSqMUGpLR0Y1a1Tx+j
	M5JmfTgzkdRJWHntIv/zuRgf71LX9oHKC6LItcwrfdE2BowMsShRTrD6nZXt6WY5dKRK5uS24xY
	tXbZnjO8Pj7rEhysaXvz/1htRvwIeo4DxwHT2kehmpoDfXP1PMViYZm7i2//Cx3QKOWcgh7y0g8
	dk7je0K8L9EqvLc2m8bECeYU8a5FpaoIvtvU4pA4r3eS3bbeYZU/yE4uWjwXkjgoPbtwNTm5xRA
	JRCbkslEiTIezfHkk5j+JWUniq4pBPiBUzXzGH7D0E+PjcI1ZZLShhk3CBn152f+6zJKCST6Ko0
	kUpAme/luUqGB4SYYjjwkG1hhtBKymzT/KO7Q8Z8icieVw5N5fsSnJjdS/+xOz4Lbp/N9XsoN9s
	v9QlCjU+4ilG+zMkmYQ8wxIl63ljJTHHCjtubLIRDB2Q==
X-Google-Smtp-Source: AGHT+IHcRjW2QPcsbYnenc17cFiDR0wniMTvBlDcOI8utcSXT3RuAViGghSibc/CLG6caPDROJHKpwlQbB9N
X-Received: by 2002:a05:6602:8312:b0:948:7ea7:925d with SMTP id ca18e2360f4ac-9489602f23dmr138475939f.18.1762562586947;
        Fri, 07 Nov 2025 16:43:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-94888c1e70csm23150839f.10.2025.11.07.16.43.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:43:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7c673f5f4b6so2895858a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 16:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762562583; x=1763167383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wfc9eBIdG6EpBk2naWqUKw0abfgjnbqn4nQuM7NwcuI=;
        b=Vp717TLJeEn7HYyNwlBTuL+rxzLd4KIOWp+/OabrxVGkK/sc3bnRV++c9kDcgkPceh
         /m/3SLwRn42E3v/wE+te8WjXWEK//QKRevtgtRFFfjGOAYGyHfTisdh4kFzeyPt3pUJV
         eZz0Ndf5xBKD9X3xNRDd3lmQRjAsTg/QKDcXI=
X-Forwarded-Encrypted: i=1; AJvYcCVInDCZh4F+Yr/Mftie4y0ly6ukmHYkw9WzEMiYiGkKsyqUUoSME1svQVO0IC3CqJ2bgiXDFwn/ZryzFHE=@vger.kernel.org
X-Received: by 2002:a05:6830:6e97:b0:758:6251:2e5c with SMTP id 46e09a7af769-7c6fd7e229emr865285a34.31.1762562583331;
        Fri, 07 Nov 2025 16:43:03 -0800 (PST)
X-Received: by 2002:a05:6830:6e97:b0:758:6251:2e5c with SMTP id 46e09a7af769-7c6fd7e229emr865274a34.31.1762562583018;
        Fri, 07 Nov 2025 16:43:03 -0800 (PST)
Received: from [172.16.2.19] (syn-076-080-012-046.biz.spectrum.com. [76.80.12.46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f11323a0sm2285377a34.27.2025.11.07.16.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:43:02 -0800 (PST)
Message-ID: <0b3eaaae-31e6-4b18-82d6-2637997fd793@broadcom.com>
Date: Fri, 7 Nov 2025 16:43:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] net: dsa: b53: split reading search entry
 into their own functions
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
 <20251107080749.26936-6-jonas.gorski@gmail.com>
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
In-Reply-To: <20251107080749.26936-6-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/7/2025 12:07 AM, Jonas Gorski wrote:
> Split reading search entries into a function for each format.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


