Return-Path: <linux-kernel+bounces-644389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A1CAB3B68
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 16:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6BF1895106
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB5022A7F2;
	Mon, 12 May 2025 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TkQi7MMm"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938DF1AA1E0
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061704; cv=none; b=P06BYeiWguyc4OU2yXHTL033zyQzYcyI7yrIB8dDInnGAIpT3i2Y23lo6wZEvygKML8GN+hCbtcqpNsgYdh5q9hR8JoGGGmNUeZyaztTp5dNOFdNLEFNN57HJothsabJJb9pQ06eI0Mljf4PRjejtwSQGZ8AC/hkHsml91NwYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061704; c=relaxed/simple;
	bh=TfizoN1PNxcvVqOJuMUUMdGEwZIx1hKgrz4wCFMOkOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aapymrWI0StSqTLJNSTWBDJjUf1iYiUc9OCEaM0RH9KDeV5bHsy4BGXv9Ex4BiscTGNqh0mXI0KjghhbtNiH16j4RdGcDx4PtomdH4cOjp9UMtkq3V2xRQxhDH5/w9UlyaiKeY3xyiQF+sHzU2LmoJ//eiL3zKqIiwiDHaG4iXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TkQi7MMm; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so3857304a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747061702; x=1747666502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LXdFLk6nepNHBrwLcBaN4w/pS5VkviFYE67anrdFimA=;
        b=TkQi7MMm39wAdd/5PZF4lXT1T0QTHJkej7pfD9WGD79jz3+MW5/InJzVi9o9DcHjKL
         cvnznMB+2v4iBtJFoQ8cxnOoHVdli42v7isnOH6qH75Qh/w/lAxeOodEVIIj8jgLlRTW
         t7tb0ACjRatrxJVZbPwGaSy6PoyRGwGgmeZIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747061702; x=1747666502;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXdFLk6nepNHBrwLcBaN4w/pS5VkviFYE67anrdFimA=;
        b=qymQQG4+G9AuaLPcfcXuHOpyNZloM1+3wTYNXKrmTzsxKI5oD3+ElvNvnAXmd+O7TX
         oAH9NkDyCYBm58LtsycQKmTA1a3HBtHULsh59cxkzuQ7x9nMa5yu6idbdjTfU88gNGZB
         zz71Box5BZZ3l1dYwT9WOwOl1dWIWnJeXn7ft11Xfwlv7A52H7xgMb3e5TMgSPTuldTe
         vdVfUV1S7J5Pg4G+GhyyC1EKQ8AXBh1QzxoJahD5kwHBiB0AlxmCS2byAIs7F9OEwE3B
         PP2XLmzrTYmAyd++0mpq26RLZ6OVYhi1mvYASV+R+m5+pNGkK/xZY/10rRYpP2sEFzaf
         lGDw==
X-Forwarded-Encrypted: i=1; AJvYcCVNzrHzxzuRDqm6wlXfxI5V3PLPgtscugF/7cx/ZhSI7iT4/QnKoToH7TCIY/TjPBWygOUhEVc/gVfkXWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL5L5lc0SkuboX/q43zL+KIxhOhIa1sD5p2+1sR3aRbC2Gx8MI
	B7HVDu9S/B1CIXgoM9u3Cb4cbM2OaqE4jOdBBXAc5t2EH+WG8FWHPvzHorJb5Q==
X-Gm-Gg: ASbGncuGZVZ6bTBsHSZJBdQyusn3tlNhCZKesi+X8J5x2UMf5TXc3Gp2rIKpL8915sZ
	tGg1kZVsPAtrV92/r8E4/CxuvG9Q3vYunLyb4n46zB5YjDikaJEjr2f+1p6ClQbZSuLTaQ+vrwT
	GcT9Qs5YmoinGb0LzhoSkrxsm0R2zVPqgmPvZpiSNIIgfhMz9NbbZcsXC3l4ELFvm0sUk5EZ/71
	PskL+fz3RcWwdqRvVcku2sKusZNFcTqnTCiMpXRQhAeM7cWRsV2DwnrXFa5cECgftdkmgNqyAXw
	R4uld9uDeLofe8XfOxbwBgAPAor6YD8dPRj+dKNAUVdfwOpRM9x7GSxKG1wypVfsUt7jBuP1B07
	qFd1oGBh7sqbyu6wZAqWPdKpw8XHiYVpfQza+qMjtpCZNykQ2zoLSkU+uUPI4
X-Google-Smtp-Source: AGHT+IF2eeSkct7kmHVNH+zwvxbIVsOk3mVXIlF7fNDcpleXoS5FPH8wXIk+h8uVG94zBR2yl4YGbQ==
X-Received: by 2002:a17:902:e5cf:b0:223:5e54:c521 with SMTP id d9443c01a7336-22fc894f1f8mr189215195ad.0.1747061701820;
        Mon, 12 May 2025 07:55:01 -0700 (PDT)
Received: from [192.168.1.24] (90-47-60-187.ftth.fr.orangecustomers.net. [90.47.60.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82c175asm63172555ad.247.2025.05.12.07.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 07:55:01 -0700 (PDT)
Message-ID: <ab042f6e-4b2c-48e2-be35-22070273ddcc@broadcom.com>
Date: Mon, 12 May 2025 16:54:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: PCI: brcm,stb-pcie: Add num-lanes
 property
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250509222815.7082-1-james.quinlan@broadcom.com>
 <20250509222815.7082-2-james.quinlan@broadcom.com>
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
In-Reply-To: <20250509222815.7082-2-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/10/2025 12:28 AM, Jim Quinlan wrote:
> Add optional num-lanes property Broadcom STB PCIe host controllers.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


