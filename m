Return-Path: <linux-kernel+bounces-735990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB11B09654
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC21217A3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E361422E3E9;
	Thu, 17 Jul 2025 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iG26+vhj"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2391DE4E1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752787406; cv=none; b=E2g2f7nHamZg0VegmsrhmcGsWK2t3P0SGUMMfA4JKs6Q5C2zFccRWKjaK/gpdq3YxVBlqm2Tby+xfItBSAPFIhJ6cbHqoaKtg9lalu0weyQo+FFoauu4Z93ue77G7e8UBpxg3y0Dj2zqtqkHl+svfM1qx/EKVJmF8BoXYpMs8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752787406; c=relaxed/simple;
	bh=rc6PAuHQvJRFKaxFATDkXRfyzmIeWZefCqcguJXqm3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8No/pzyzTgzcJVIsLBX+yvaOnBC906K2opkozTNmmMdsqw2w7eRa8DKjjBijDDfChAFkIC0FIebqFXyoLIxsKNg/m27BNmYID7T6fPFmWW4C+flDbd69TOaDPSGsQZ81r2/ydrHJ54MiD4ZbmAHD2q8rPcA8OafZ+v7/8QJ53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iG26+vhj; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fd1b2a57a0so14685086d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752787404; x=1753392204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WGQo42bPBIeGM7xGkyPrzTeu28HqdSS9vy6iWRQ9EnU=;
        b=iG26+vhjKQcvC0edLyUQZYUfrpAQbOV9ZFwhh+62fOBQRsCY06a4XOFKwFHeWsNZF3
         qy06/Lx0nv3Ex3655wmzBWPcc5v+QyeiWiAe2xrhmKn1pjDYuJEjzNYaWatcaph47p1x
         253ACe6L8gE4dd8K9E0tnuUDGjjKnocfgXZCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752787404; x=1753392204;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGQo42bPBIeGM7xGkyPrzTeu28HqdSS9vy6iWRQ9EnU=;
        b=mdGZAPA0E7g/TxIE8tfKG3SXi4BmMCERksgz9SvQXq6rrvpa977QXm3nfTx7UTEdl2
         ODn00VVBz7+XgQL9//Y1RW2/NiFWOvntZqQlkQSPGvpyHFx9gZMOLcg8gPXEjYGMusfj
         mVoh156XGFFifxjEC/KNe6cpmy5/8TP+ZPL3JwxvT4lfLwMuA/nV63PX+IVnIN0ERmm/
         h0Wfcy9ocSnOHmxdLSv3R9MsDjEN6d7FgS3Nthg85AxAy5oLpn++I0j4cl6+YG78dKzB
         3b6udcG5qy67EXKk9J4VHgpjWalECKo4l3jxG0ge1uaxlFrq5DCytuYEt8i+irJ3Jl7X
         pZ9A==
X-Gm-Message-State: AOJu0YwLtpwykkZivCfSghB6l06wqeQEZ16WhVBJlauTCd1dgnAu7m+Z
	WDKhi7ZfQ/kvjqrukxUE9J2/VCaziMDqT6RhhIbYMmzYsMW1yXefXdOWR591+LeFPA==
X-Gm-Gg: ASbGncsQBoU0ui7qqWxWNyET333Hrm9F24JaY8wX2v1cH/ePdq1PjXej36jmFEP2Nj0
	e4l8X/bLJsJFiUvCELW/6TfYsBI9rSyyL29h/XLZnZYJRvP4WpL14zlKBOLIuk8ukkWKG4Ywz56
	carhO4DN+xFmWRs6U/WOXScRAB2ZdeCOY4wdpz7gNjG25YaVcaDwtXVoMh2bExEjAe3S3gPIIHD
	ZwVc3BEv7D0zSRoPb/n2pjtvdMHam0dNrhQDT8IQtbLhgxaftj5M2MxMpeUPiJmKYKVQKBz3FlJ
	XEyyLHps6UpE2eKUdebpBaS5yRbPB8z6xtJPnWN+775EaiGGGfUhVMr1KsP9LkgxkrJIAyPqA7D
	+2UmY4iM3PsMTZ5WpZaJKfwUYFv2I3cvz6RLsz3ipVZSRyoju6ogQlAFNwWM4YHDb5OGsqSdF
X-Google-Smtp-Source: AGHT+IHpve3fVu0HltyKOyRRlJFRsFzdsU/suMNJJM0ivrDzSlO2Vn2cDGZWsdanj6d2xCh0gpH/GA==
X-Received: by 2002:ad4:5be2:0:b0:6fa:fdb3:587b with SMTP id 6a1803df08f44-704f47f0c31mr117322876d6.1.1752787403711;
        Thu, 17 Jul 2025 14:23:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8c04fdsm533226d6.15.2025.07.17.14.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 14:23:22 -0700 (PDT)
Message-ID: <923a455e-b1d2-4ea7-a620-74aa040facbb@broadcom.com>
Date: Thu, 17 Jul 2025 14:23:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PCI: brcmstb: Trivial changes
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <20250717210043.GA2654580@bhelgaas>
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
In-Reply-To: <20250717210043.GA2654580@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/25 14:00, Bjorn Helgaas wrote:
> On Thu, Jul 17, 2025 at 06:17:28PM +0530, Manivannan Sadhasivam wrote:
>>
>> On Tue, 24 Jun 2025 16:19:21 -0700, Florian Fainelli wrote:
>>> The first patch removes Nicolas from the maintainers list since he has
>>> not been active and the second patch uses an existing constant rather
>>> than open code the value.
>>>
>>> Florian Fainelli (2):
>>>    MAINTAINERS: Drop Nicolas from maintaining pcie-brcmstb
>>>    PCI: brcmstb: Replace open coded value with PCIE_T_RRS_READY_MS
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/2] MAINTAINERS: Drop Nicolas from maintaining pcie-brcmstb
>>        commit: fde41f282590b46e96864ae88da2e2c20a967b3a
>> [2/2] PCI: brcmstb: Replace open coded value with PCIE_T_RRS_READY_MS
>>        commit: e8e7c1e95d6d4ccdc53654a5966d2183532ab115
> 
> Thanks, I updated s/PCIE_T_RRS_READY_MS/PCIE_RESET_CONFIG_WAIT_MS/
> when merging this branch to account for the removal of
> PCIE_T_RRS_READY_MS by
> https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=bbc6a829ad3f
> ("PCI: rockchip-host: Use macro PCIE_RESET_CONFIG_WAIT_MS")
> 

OK, thank you both!
-- 
Florian


