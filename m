Return-Path: <linux-kernel+bounces-845767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C1ABC60D0
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D8B74EAC6F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71022EBBA8;
	Wed,  8 Oct 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eLvRbq+V"
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B712BE642
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941607; cv=none; b=UcPVMYzZ8meEeGyHYj6y6PExWBFI4xZs8DEHk+bBuV50wasZiJwumOF6gdZbFR5vv6z71TmouGBo40Qwfg0ev4im4T5lmPaRGB2BACSvLefQGSs9OynDZgY131YIbrN2wT4b30boEQl6YzVuUQKbDD2xXdRTWyPvp4LoZwXLNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941607; c=relaxed/simple;
	bh=+PfLy+PaRN1TJ1rm8PW6ichyFtD1//8glxnN3oAJ2ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2T+Y2u+cveOHrPhZFE4mvxCnuMGqws4RvVgNm27VtJ9e6YuMf3gK4w0GFhMqHEPD38YYuFEX7U6i3glZLVRWCDzLZesO8iUiOMQtQ2Fxs1PLrjIkyxHGnoU7UCQs7ppzqEYay/sNjyjomCuD7SeJ1TfjxV8b0Htd8N67aVFEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eLvRbq+V; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so125528a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759941605; x=1760546405;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xx31lKioNXTd656SFk60BU+Dyp2fe1w4rAJW/22lkGo=;
        b=emeo5un1H5JNObmOcJHS8fiLltvZsaSTx030xhlohXv+lavbT7SmxYA8ZdLIlS7nUP
         JmergqDBI4V8OazMZagR9xmCT101c11iv6u4sRz8ZBbXFNLY7GeZrJHAYsyEsEUbft4M
         fmlK8ZSM5eKJ+q+yZWXVn81avtxyP9o12hpouivfknFTpTRtARTOumGvMuNnKhHqLNh4
         ijVT0XDKfNceOMKipFGe1zyihOkmz79dtHQl+RG0MLwrYova4TEsW2q9eoVJiP9uIg3j
         faA2/IIvN5Co8Vx7azDoL8Oel55aG6b4Q1Zhdwxxd7HvicOvL1HpcBSDYMoaNCjenDCd
         ywOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFdB3jx6n2zhmvBBCw9qX6hF40KalepBJsPtEkpjFDicvCC4dSvtGNCHR/+efyswdyIHxcoIfJ3YHDOvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVRscjhs9VKBio2JZKZaepFh1GHkDjKyAwA1j0NBN/wm6kYjSh
	2fB0hu/IJ08M0la4ITXkISyDf2Q/GXawuMmDB3JD5ZZDdHjqn7DqrnNwQFKmlYkl+E8eMMDLNbb
	VdAroQewZfmsz1z6H/AhlgH596m7FXVDWfrhnP5j1/fSl74fnBaFPPBbMobk2USXX9zN4lXg6NU
	1w+FZfMzXdoLiPCsdh/SfaPciWJNRml+EUcnsScXlTMkgGiigiH5WENBztObbQ1NZsChMZcKUqG
	rGwqmKrT1QZ8CZG4fQj7j38
X-Gm-Gg: ASbGncsuon94WbXGsCSTKMhCBY/1OnsNDvlyA4LfoWFwPJhPhkcRGME221NlPmha1ZD
	FP2QgIUSRZhVEYOj/kmr1wLPeq0nh79BPmDw/IUZN/bvAJ6BwjkeOxT2xkHPt86m4ewBk1tDgXK
	RSwTWHc3kjEJEJDcgWPD6DACl6NpipFRbGsvsdLlzptpkJ8UjhsAb35AKeAoca81rkeKnP/OqPI
	1Ymh6Yf6iLvhI+ZaO5tBBV0riN91vFRqegmKgl5lSzpiFQmLEIbT1jpTP/RQ2jWLTJKJZnvn5Vs
	uVrT4STJNS/grdlQus6nOVjJj38k0Vbf44T53rjD0pbnHRaK0fyDrKvQlwB8qy4Wc3wKzudlRqE
	F8E4TQaohJI+Oep3vsBBGwtMTq3Fo6C42ZZLoQg/gqdiH6zF7OjQ27v8HNkoF1XqC4V+2l+99qM
	6UG3oA81zueCrr
X-Google-Smtp-Source: AGHT+IFqWeqJAWYXZPRBgvKz3TDQZZzV5x+yt/IROqoTJoS4ExlFBplKhL/QWGQ2aISpKrSw8/dSATXj/UtQ
X-Received: by 2002:a17:90b:33d1:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-33b51149957mr6014986a91.12.1759941604570;
        Wed, 08 Oct 2025 09:40:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-33b5295aaf8sm120603a91.1.2025.10.08.09.40.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2025 09:40:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-780d26fb6b4so24996b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759941602; x=1760546402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx31lKioNXTd656SFk60BU+Dyp2fe1w4rAJW/22lkGo=;
        b=eLvRbq+VW1mZ8slZLLM71PWz8kghOff/tGaCHfv5kdYQQu+Y96vt9tWj83XvZ6Pa2Y
         Ko6Vf5sBFrmrPJX8cMSVCyblsywOA17mquyb8QA/NhgWgitvEMTJKGuodRNHhS8yQ770
         lsFyYb+8TWCbma0jjcwQZ+LMJxXkSuGd7pkVQ=
X-Forwarded-Encrypted: i=1; AJvYcCVnd2EbVRDf4cvI0F/wWVgid+30w+A/T9PTxSZ8eGxOhj79Mx/XT/RQYbRdKM2o82+NNSXEKD9gWa62WVo=@vger.kernel.org
X-Received: by 2002:a05:6a00:92a2:b0:781:1784:6dad with SMTP id d2e1a72fcca58-79387c19ba5mr4718157b3a.24.1759941602376;
        Wed, 08 Oct 2025 09:40:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:92a2:b0:781:1784:6dad with SMTP id d2e1a72fcca58-79387c19ba5mr4718107b3a.24.1759941601632;
        Wed, 08 Oct 2025 09:40:01 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e33f0495sm186997b3a.76.2025.10.08.09.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 09:40:00 -0700 (PDT)
Message-ID: <7d96e604-e485-47c8-a0fe-64201f30eaa1@broadcom.com>
Date: Wed, 8 Oct 2025 09:39:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: hwlock: Adding brcmstb-hwspinlock
 support
To: Rob Herring <robh@kernel.org>, Kamal Dasu <kamal.dasu@broadcom.com>
Cc: peng.fan@oss.nxp.com, andersson@kernel.org,
 baolin.wang@linux.alibaba.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251001181641.1561472-1-kamal.dasu@broadcom.com>
 <20251001181641.1561472-2-kamal.dasu@broadcom.com>
 <20251008155639.GA3512742-robh@kernel.org>
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
In-Reply-To: <20251008155639.GA3512742-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/8/2025 8:56 AM, Rob Herring wrote:
> On Wed, Oct 01, 2025 at 02:16:39PM -0400, Kamal Dasu wrote:
>> Adding brcmstb-hwspinlock bindings.
> 
> That's obvious from the diff. Tell us something about the h/w and
> convince me we don't need per SoC compatible which is standard practice.
> 
>>
>> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
>> ---
>>   .../hwlock/brcm,brcmstb-hwspinlock.yaml       | 36 +++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
>> new file mode 100644
>> index 000000000000..f45399b4fe0b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
>> @@ -0,0 +1,36 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwlock/brcm,brcmstb-hwspinlock.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Broadcom settop Hardware Spinlock
>> +
>> +maintainers:
>> +  - Kamal Dasu <kamal.dasu@broadcom.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: brcm,brcmstb-hwspinlock
> 
> hwspinlock is the name of the h/w block? Use the name of the h/w, not
> linux subsystem names.
> 
>> +
>> +  "#hwlock-cells":
>> +    const: 1
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#hwlock-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    hwlock@8404038 {
>> +        compatible = "brcm,brcmstb-hwspinlock";
>> +        reg = <0x8404038 0x40>;
> 
> h/w blocks rarely start at an offset like that. Is this part of some
> other h/w block? If so, then just add '#hwlock-cells' to *that* node.

We've answered that in the previous review:

The block is part of a "sundry" IP which has lots of controls that did 
not belong anywhere else, for better or for worse (pin/mux controls, SoC 
identification, drive strength, reset controls, and other misc bits).
-- 
Florian


