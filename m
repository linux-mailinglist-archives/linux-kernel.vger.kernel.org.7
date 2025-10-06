Return-Path: <linux-kernel+bounces-843399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50835BBF1BA
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058373A79C8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED582AF1B;
	Mon,  6 Oct 2025 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CRdj2owh"
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC051A5B9E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779329; cv=none; b=fLtbEGdPLrzovJa+XuRkDbY6K/DUu3O94p9xtPfpiSsZCZya0Rh1E/p1htiZ2YOGtqrZBqFEMcN3VFgu/YQLmOg+3ZxbftKKW1u08oJW2sNLT17oiVv2Aap7R613hngi7ZurtBgpAlgLoHH6M0yAQjTGIMYm/MszQb5aApMRKn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779329; c=relaxed/simple;
	bh=UUrlo6eNKtzgr0l8FTV3bJGJ+IUdWejRxpJ905/N5Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJV+purF0M+VIF7Y0FP6kf1T75M7CYGMkN+g4TKfNhqBUupr0xH5hJyzrWRdScwUI0FS4zkpfZWXnKZDOL91ao67PS3TSPf7UKDFttqvwVX+37+c2aAoEJyX8N4lnOAh6DhFyChQfSDuC6FPfuX3Goyk303v2T4pKhGNvEM9E8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CRdj2owh; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so1665077b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759779327; x=1760384127;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g33QJENoKMBd4tbu8sSihTDRSw0h67rGYA9n8lHSYDU=;
        b=FAqoWFqT58OxXJlK59A2wWTm7oas1tIUs67dJBqDFeCfk3tW7ourtxAOKdNpZX0vI5
         TeZFhQfCmWWTjGE3eBoTgP1auBwCHSMPAKVxdXniaYNG62gsGu/6O736YE0bdX8oaL8M
         m172XGw4/wDM+fVcvPLqB8NxB3/DPiBkOPwE8yFOrhZYs1/A+rdw7ezd+0+3k7F3q669
         f9KSDRAMcoKJUqetCL2NLjT63Ca6FB/AJmQjpv5BhtY25VplGuQJadNyikN+42PdoZbD
         woGHn8MfNGSKj84+sl7NOR3a4qQDD5u0M7d0yQXotY6/a8BjNcNWukFgu10gCohbaIQJ
         e+pA==
X-Forwarded-Encrypted: i=1; AJvYcCViksSjpe9I8GiZvq3UXOOqQwbBxM8kZEMxbfAUSD+Zin/cQQ8M3yXbmgK+RHa5U7/ZF7C3Hz/H8jdKeHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjywjt9mQMGJAWID1wjBWGu2dODBGqoVDs7sjHqMC8Tkje0MIk
	dJkr1lBO+XZ4VGAFm60menPOqpXRpD/HCvDgdU6huj0c7YtQQYcfEoxNVRODXODKyQJoxWNXtHs
	2AKSziZKYOIYoUjBL19BM2UaW5BzjPzH5J5LZayNx/K9N9gU4tccLvJTEAUXDEeNKErd7Jg+HGC
	vd4YSE2E+ERHj/jL/y7GluQeez7bnO3CjHcmiVJUTVEUcz3d0IiE1Dp5Qh6Yl7jFiybM+aXhH/S
	cxJz1/hoOrTAlRW95XzCYEe
X-Gm-Gg: ASbGnctKVKuNpi3fF8sUuKB+bgucACx20S7IviSLi/PFGlnLaSlElh53ouc62dAgOlG
	CbT0JplsQWYSOTYIdkn82moogbh85UyOp/GRxOB2+SyzqdkZh1KiK5vpcS3EQhXHnZV2NpQgCQ1
	d0I98TmEGrQ7f7VbAEAHauul5tPKD8HMg0WY59brsz7A3EiT5o6hkOR8awgVSdwEyEFa9O+2q3m
	FdvnzPpYaIfyZjU8CYZsLXifDoBoAdANKPxvuEnVExP/Jn/KnyjHCIxK1wcFNlK9Df3pBwS3K6I
	VgKjZ9+if4Sg65x/bskm3OzrXqXX0AfS6IrNxQ7FTG3Qmk9nFU8vU9lkC0rlSEEiupms+8mi04e
	P4dNbgrvUtTJvN46MhT4I5YCpgE0B/rGb0Q==
X-Google-Smtp-Source: AGHT+IEpP6lcyCLTdDcGmxns7O8DhcXpcWDdgZUn/jtPCf8CKjNqPUB/BKsu4Ra1Rq0pu16m8s41WJd4+EHX
X-Received: by 2002:a17:90b:17c3:b0:32e:9a24:2dd9 with SMTP id 98e67ed59e1d1-339c27164bcmr13445555a91.1.1759779326754;
        Mon, 06 Oct 2025 12:35:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-339b4f08372sm1180894a91.3.2025.10.06.12.35.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Oct 2025 12:35:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5529da7771so3388888a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759779325; x=1760384125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g33QJENoKMBd4tbu8sSihTDRSw0h67rGYA9n8lHSYDU=;
        b=CRdj2owhQmz2ewAra3x/4GIvkAzXBMD50Gtqn7yuee/kzVb8T0UMSB0hqgPo6qgQLO
         FHNQWlAtyag26CtZvuvvuzGkldOdfjhKtvrTx5vC44Xq5O7O0tz7y1A8So8zCD+fWVuc
         YVn8KBAYPO+7Zq8A/HeZ7EEdH0DzPlBPitvyg=
X-Forwarded-Encrypted: i=1; AJvYcCVVSetgr4E/Y/W2AVS13PGtXjDLrjlvcxMh27RapgLcsSEtCBpLAWcwyL2aqRU+YmNhkgzO3ddEY0eCOHg=@vger.kernel.org
X-Received: by 2002:a17:902:f78d:b0:28e:a70f:e882 with SMTP id d9443c01a7336-28ea70feae1mr113856335ad.11.1759779325006;
        Mon, 06 Oct 2025 12:35:25 -0700 (PDT)
X-Received: by 2002:a17:902:f78d:b0:28e:a70f:e882 with SMTP id d9443c01a7336-28ea70feae1mr113856075ad.11.1759779324589;
        Mon, 06 Oct 2025 12:35:24 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1f19ddsm141472345ad.127.2025.10.06.12.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 12:35:22 -0700 (PDT)
Message-ID: <23cc004b-f3e9-4685-880d-362619c180e6@broadcom.com>
Date: Mon, 6 Oct 2025 12:35:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: Fix use of incorrect constant
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251003170436.1446030-1-james.quinlan@broadcom.com>
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
In-Reply-To: <20251003170436.1446030-1-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/3/2025 10:04 AM, Jim Quinlan wrote:
> The driver was using the PCIE_LINK_STATE_L1 constant as a field mask for
> setting the private PCI_EXP_LNKCAP register, but this constant is
> Linux-created and has nothing to do with the PCIe spec.  Serendipitously,
> the value of this constant was correct for its usage until after 6.1, when
> its value changed from BIT(1) to BIT(2);
> 
> In addition, the driver was assuming that the HW is ASPM L1 capable when it
> should not be telling the HW what it is capable of.
> 
> Fixes: caab002d5069 ("PCI: brcmstb: Disable L0s component of ASPM if requested")
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


