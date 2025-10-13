Return-Path: <linux-kernel+bounces-851153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC006BD5A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60D39350E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C72D2496;
	Mon, 13 Oct 2025 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XWwNwslb"
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771102D238A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379219; cv=none; b=TO2X0grlaAlEgLbFFxgqfAZhcylUtnev7S32roDsU6DqWkvMAU3UPDYIrwvSgqlY/zWtD7j3aR/hGIx/pbuyO9v3Xgjd4x3XLuPOsWT8JbB+18/LmxQ99Ix+xS6u10riWkO1yyY4lJ79ighJ0YJLshFG672brJX3ezzfsXOlXZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379219; c=relaxed/simple;
	bh=5+xDnb2xb53HUrmtr4FSq+vsKUioXbGIG9Lyf50qLks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLi+0Z5jeXcMAG1l5mGHRih2iYESDf2J2TSREClCo5yMOe5eIidCHltcg/mAtZuINzPwYpt6EhweV8AIIY+LmMXjjcl81LQuMtKqp6H7cE3ErNIiFgUa7pT9rFCKB6KTmHtF1sIqE78q02S8ciCoI+WgA2g/m0hXdhr53cEy7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XWwNwslb; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-54aa0792200so3246620e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379216; x=1760984016;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnWgWJ64u/8WCAJXjGDR4Iw3Y3OHER/u6FLE1jKF00M=;
        b=ObLyyBDebUzpm3Bs5J7MSobnBPAAH/lBBfusAA9JcT4lyeLRbQhHA0r3ziz/yuKaal
         p2Vt6f8M4tD0Dp+Y249A7a8RvdIUEveznfOOj74n/OnQO7HrngqCuzOONrflAlkjiPI3
         1Jg9BSPSB5Ev0q52N90pE4QGhM4GkCExjKjmp1bPZflzpm9U6YSiWB0wmn+kPcK2Jw72
         gFN1SjHKrRlZ+Pm3ZCpAZ1Kj3HYiX03ARryXG21kMmDDFzbHfegp+B054oyV1gzL68In
         kpdBVh1KeWjoLA3+TS7ApgKsLl21JPeRB2fUImPf0WcETKETpA/SxNs5l/EeQUfMNTgk
         OhYw==
X-Gm-Message-State: AOJu0YyoBtD34zxwkl8TIyt484v6PMOtQ7kS0vqZLgqyjCZn/TR4NQyy
	ZFQ65SSrDiDjvRSFgy5dJwTIFE9ej8h4fHH2LhKqokQwP1qwh+zC0xlazwCpUBkQs5wUVuXjA9k
	TjnhRtPfbWMjCKZiWk3UFXqBxckQojrwrUj7c6Uq6fea/TMECa4R82NakL8epbY0olclXQBWV3B
	Kt06W8dapr+iPPWRCVaSNDeZmIax2mEi4ma/byU4mvlequQq3bLrgC20+l6vbuQj5XZpYJHcpSP
	3ROi1CkkSw7XSpv6sW2J5EH
X-Gm-Gg: ASbGncuzNqOi5LsX61AsoJoMuAXrqXhDILbsue/MT9HmUnSL6Ks1/5UAZ/byw2riFjy
	lCSf1vISd4rFK0QWDZF1RHmXJS7LLtNQgroB/jLKiCq/Zbn08j10JfWA+IIT2YyqSCFH+03hvc5
	zbaEoC0futOGNRx3TTzUqs+r/XbZRIw7SaXLT9zpXXqfum5mT8btCWjevCcO3vnyZmBlZsHhWP5
	+AQ2vPHKj5xABqGqfQCCRgpo9LygDoF5j0O9JUF/wawgIZ+W6xWKgNBSzHQ+LEdTtXlVLmuhr92
	MfoHU1Tyh46OHaEeAhOgBFnmgTGToP6Qs+U9kSw+lhOoBkDLNJjN2Qi45LjtifMHJoMyep/xcAY
	YSLCUSFr7+c3fQSsL5km077ZEGlzqum8xdm6EMUCRULDrFvZBfB+/u8S6PouK96CWQ9KYYi0cGf
	D/RVEN
X-Google-Smtp-Source: AGHT+IGClcZt2V9XKLUjRSnItJynXfcYZmNqK/YvR4LFbBfNAQW7xfOUU44cQctrS+/iN3/Jv4PKXt2GgMUG
X-Received: by 2002:a05:6122:2a53:b0:537:b2b6:e387 with SMTP id 71dfb90a1353d-554b8aaa099mr8213106e0c.6.1760379216335;
        Mon, 13 Oct 2025 11:13:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-554d7ef9daasm1224672e0c.2.2025.10.13.11.13.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 11:13:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87a0e9be970so304909446d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760379216; x=1760984016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vnWgWJ64u/8WCAJXjGDR4Iw3Y3OHER/u6FLE1jKF00M=;
        b=XWwNwslbNXadUvQ3w5ywKLUtt4scXmUKDsaDs1sB7zBGGngvEE437rSaK3/5gIoWGj
         4MvWMWhC9XrXn4Ovk7EzpxdWJ8Z3brvouvrg/ZCdmEZupHpUigvYuAibam6I6fSlWPYN
         6NqpmuQzv8oYHNe2I6LcZJ1ehu0kD7KCA6WTw=
X-Received: by 2002:a05:622a:590b:b0:4df:bba:5acc with SMTP id d75a77b69052e-4e6ead7788emr317622051cf.79.1760379215770;
        Mon, 13 Oct 2025 11:13:35 -0700 (PDT)
X-Received: by 2002:a05:622a:590b:b0:4df:bba:5acc with SMTP id d75a77b69052e-4e6ead7788emr317621631cf.79.1760379215334;
        Mon, 13 Oct 2025 11:13:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e706d670e7sm78544281cf.23.2025.10.13.11.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 11:13:34 -0700 (PDT)
Message-ID: <1859972b-baca-48c0-a62f-f2b1eaafd89f@broadcom.com>
Date: Mon, 13 Oct 2025 11:13:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] MAINTAINERS: add myself as maintainer for b53
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20251013180347.133246-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20251013180347.133246-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/25 11:03, Jonas Gorski wrote:
> I wrote the original OpenWrt driver that Florian used as the base for
> the dsa driver, I might as well take responsibility for it.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks a lot!
-- 
Florian


