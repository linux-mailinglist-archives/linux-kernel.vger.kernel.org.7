Return-Path: <linux-kernel+bounces-877094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F397C1D2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2DB134CF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBE235A93E;
	Wed, 29 Oct 2025 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gxy4Iskh"
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C231314B85
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768752; cv=none; b=FKiktdDW8BMRS0Q9YT8sPK+Ijojt9ek7cIJRZmjuRYVOiBfadGeC7ZPV/OlTzD7vkzF6l23EFn1wG7PnOIIRiy6jlHi4gX5YYmbiWC/4QtMmWxiG15FIv7Nwdywa8vmLrIXQ2mRFJJ3jFTRuvhRRYsJxKexZkzQR3hcCszpQ9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768752; c=relaxed/simple;
	bh=iR5HlGQtmcmSHHCwOzTzIF4RYlsm+yyeAoY4efZXbdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQ7EuwYZU5or6Bmui2ggBNcVbKTorBPVD2xm404PlElnMRRg00RzES6mYsQjji6GLWUnuHdCNWwGLVMnBGaBnrpI9JukF2odkuBq4oaPmaB+IJ6MO8aSKkjeOZVmvAbCDafV/v7gL4aFOg+HnN+UsF1KtABlAsDxWmFHnnktG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gxy4Iskh; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-7a2738daea2so319040b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761768750; x=1762373550;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1OxuFPXRzNkf/jjOfMwnR5HsdSbozk+lpDYi7pEr48=;
        b=DpEoAf5dhoBkjafoFKKNUZqgx9+IrWSvtcwQzQJEDc8yPUnf/QQRFpoCHUsh6lfep4
         HvC/18v70vApWoOneFt1namSg/LKk5XD9Cq40ymeDBGNxltAONnxW1wBBuSoDOe1zKJe
         kKzU2Nq61tp30JSCBt1xWV1gjaPsw1kO8YHeNgAw6lgWEI7dZFNnzvO1QgkzqDoXvvjy
         eB/6fK3di1VZjIczXZuasdJb4PQrI6FD30K7qR7en6TjfVbI7UidGizo5FmfBToqMoxR
         HPn05Tjj3TjupUn7DogOv1lRKxdph4J7svnz2OJ55jVC90F+Pddvzmnsf33RufGA0xCv
         dFpA==
X-Forwarded-Encrypted: i=1; AJvYcCUy7u8P0PWCNoCHmLnImoL2L7am/5fRVN2eJ4aQVwv0iea5f6m+zD2iI17HeL5AYFidLq4594YI3957MGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4mlErNRSP1H3ej4RmrOq83SCK7AqpFrh+ICDESeNaxJUKeAtY
	duXUrREYxLAPA9SDPDoyfrn7O9HlFw7jK2S1gckMk0jVI+zoYQawa83fP7r36vsaJ9JBLE42fYJ
	VAEk6XEKMtUFs7zuPbRQL+Aek/XT3rQUgtA2yJT1qIkE3j6sp+/BTC02i4uDnRjt60dp9eVWmQ4
	ANRd5zUoBbDuCN17+8Tt2E/OEL2hByu5aN4yI9MDqN4fT/LvKiUicC0bIvmYoBt4UlWCcE/NABw
	817Pgiq6LbwtwNxcA2qoFWU
X-Gm-Gg: ASbGncsdoMMWi/LFAFY5TH+O27c0IvDPbMUREgnCTbru2LWTj/P6nfDkAKQOQrkFc1h
	jfrftCJF6MB7+WA3xzseXzI2kVstipXIqleqEqNHssJR6fqzSk/C+1WHXlfdJSn4DJo+NzaC/02
	gMlfBPEjcpDwyvVBgi/8u4oq1b1XNsK0VBNUgeA6/D2bR5fx1CiZzaXSmxnTUuRqI3l1454QSt8
	QpBsvJg7WXtqx+zuOpR/mGIwQ213tlxYGMUqpU4Xl1mIkXgA0fp6bGwIbVopXU30HhmC7tJFBAT
	B+SHGKCGQXZ2tT4MI1DYwu4npQtuQTaHgUxQRXs8OlONLGUyFiimH57ouuQUYFQUtljGgkMwCs5
	KvNga6Juk/CMiAMo+5Eon3LvX9mkZUCkAy+2svi28Km3R8tX6CR6hAOfx3sbQCOBrqp5CkZMqA3
	ZhAdV2B4f8crNwNMdR8yzVdMcrcCM1PccMOzGHInErMg==
X-Google-Smtp-Source: AGHT+IESIngUABpsBtmwGQ7/1iNcr3IqurLjPvzWfIeunJUHcn7gHQWbTLxrMk4XLVCK7rHrejN4A8dyOg9Y
X-Received: by 2002:a17:902:b10b:b0:282:2c52:5094 with SMTP id d9443c01a7336-294deeb5a9amr32591045ad.37.1761768750261;
        Wed, 29 Oct 2025 13:12:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29498cf41cfsm13410735ad.7.2025.10.29.13.12.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2025 13:12:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-892637a3736so87744785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761768749; x=1762373549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v1OxuFPXRzNkf/jjOfMwnR5HsdSbozk+lpDYi7pEr48=;
        b=Gxy4IskhNmDgIj0uYMc6sGDQSkagyCqwrQP/MGgn9GeLnTCjSuNqQlC4SOZ5RmEMRA
         6Pc6Sjbn7vPu8APNKj6YFxn8qpa9uH7VvNwftUCjM+qarpK45Id6HA9afaA/RYsLwpPy
         OPM+bJ9R2yg4zncxLgb2+qexnND2bMZfqfyWQ=
X-Forwarded-Encrypted: i=1; AJvYcCWjGdIgDos2NDI3enxhYiGq5bsg18DeAbDqLoO4fSx+7OrNLtHVLynaDelLxjb9/BkxUD6j7nBNSp9HBAk=@vger.kernel.org
X-Received: by 2002:a05:620a:44c5:b0:8a3:c4fa:9b75 with SMTP id af79cd13be357-8a8e30e42afmr645985585a.16.1761768749054;
        Wed, 29 Oct 2025 13:12:29 -0700 (PDT)
X-Received: by 2002:a05:620a:44c5:b0:8a3:c4fa:9b75 with SMTP id af79cd13be357-8a8e30e42afmr645981185a.16.1761768748624;
        Wed, 29 Oct 2025 13:12:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f261747efsm1093976585a.55.2025.10.29.13.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 13:12:27 -0700 (PDT)
Message-ID: <a2ff8f41-816e-4f87-867e-cbb39e513473@broadcom.com>
Date: Wed, 29 Oct 2025 13:12:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: brcmstb: Add panic/die handler to driver
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com,
 jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251029193616.3670003-1-james.quinlan@broadcom.com>
 <20251029193616.3670003-3-james.quinlan@broadcom.com>
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
In-Reply-To: <20251029193616.3670003-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/29/25 12:36, Jim Quinlan wrote:
> Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
> by default Broadcom's STB PCIe controller effects an abort.  Some SoCs --
> 7216 and its descendants -- have new HW that identifies error details.
> 
> This simple handler determines if the PCIe controller was the cause of the
> abort and if so, prints out diagnostic info.  Unfortunately, an abort still
> occurs.
> 
> Care is taken to read the error registers only when the PCIe bridge is
> active and the PCIe registers are acceptable.  Otherwise, a "die" event
> caused by something other than the PCIe could cause an abort if the PCIe
> "die" handler tried to access registers when the bridge is off.
> 
> Example error output:
>    brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, read, @0x38000000
>    brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

