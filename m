Return-Path: <linux-kernel+bounces-855769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5884ABE2412
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD1A3AF0A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F351C30DEA4;
	Thu, 16 Oct 2025 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="febUcP1Y"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4B30CD81
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605144; cv=none; b=kM+Cb1/Is+lIIdfqWRKCptBBd9ovAAvF9yJIVAUs9syR347MMgEk5ZGacpXmUSol28dTHUjCfGziqQXuy++3iti/1mT7G41v9R1+vtepeS8r/wkUySczSZcmwe0upX3Y5kIHX+msp/t7p+WJRvb2zcoP0Q2TrPfzSyhq7OQODb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605144; c=relaxed/simple;
	bh=I+cdi9WS/MhoICe/pzQWKuIcK23mXlzVly0ZHU2RQTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgBMvG+XBAipeir2OfHEbj0e37bvIkfoMvoQpTXoo5veVPYnzw8IGFHlE5QR3dcFpIlD2xCr3J/c0CBMEzbHE4nIVNLd8jbcwq48BQMGuKXyYRTgVn9qZCnudAkk4AbN1ijUTfEfx38v1w37dlm/B5OQt2mq4VVbn3ZQwi9rmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=febUcP1Y; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E36AE3F596
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760605126;
	bh=9ahU9OdbDocKDvc07Qj5/lY6cHzOHOb3fbgPU7Jnmq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=febUcP1YtbE/FliJYNn+pgjtxqqqxCBj5pcmTO2URK6onpA19cV904f/RFBe/b4vr
	 XJ/kqpfC+Ndn+3T7rvHMxgv2guIaUEMIlAHGNYHiWhXCgLVOWP0x01zYBfWV92faWn
	 95oED+OYc5qDD/YkCg32ggqbMsZ3SqupZ8yr/LojeLHad05yDRgD95zxOBl8r42Bu2
	 S/6HKHX+h8A51VDrgW0MjqgFg50TTSO+RekajptjJXMWC/UswPYkX85ZHyftlQPyc8
	 wAuNGsfPfFFgZZTIi2wHr/iM80uzmQY9GT/PjVH9K+cuOWq1HjAuXC9AzyS7rZxysR
	 TGrd+RWBisypsFncONgatora9uDQ0yIXWl4cxe23Y+wSBIgnNc3nouyd/6JqStcnCd
	 tsDJUfy95XdgDaQRb7b03zka5+0Nnsxp0MjswLHzdavvepeyGUmLMpZXjw1uPFAnt6
	 HClpy0yNWRTIAu80ATGIf70zz0KhMqxKYQ1d5lsCqoz2pdcWWtdLnemsRRdPFEOb6g
	 PQro+iu+8W42LmoMzpE62jk5M/P/xjq9u3VG/7Fgdi4O2bC0skxH9RhWxPv47tBEMl
	 eqcJth08bEdck94X67GzChIuTxxbCwTg2SGMw1Md+xpl0XZqCJ3zjJ7BUOB2YKy+72
	 rDlBnH7qTl/XZY1LSQJN4jfk=
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so772325f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605124; x=1761209924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ahU9OdbDocKDvc07Qj5/lY6cHzOHOb3fbgPU7Jnmq4=;
        b=hsz6AeD4rC8Cg5fpCIAfRGC2yu5gO6E75fDXz9+/ec/IBtL2a8S9My8WReeK5RXI/Y
         QSGDC2nm67gM1xtii/sg0hRs7bvphwXNBl2AOm1rOoplfALNl2MM23wtxUeFTlUwcBdW
         VrAguRZQzBMLWwWFgBscxm66PvA8S0qADKzm7hxndld4MVsnw0ULW1H0D0dtN+sOh6gL
         C7c8IC7WOEdbzVdiHxTbws4ZPoobcaAaNr8+aBVQyp5CNNb6nZdOZKk0yb7O/k+TbI/N
         w3ImQjF/qkujcO9iNXFIriNVNG+NvWm7u06HuHoiD/EqI4m6D0deTIbTFJIPvNpc2U8Z
         dpew==
X-Forwarded-Encrypted: i=1; AJvYcCVRLA3YZ3LlKTAiuqQgBHjJhxD1YYy1KGCgyySH/e+ik+RCx0yxNXpNW45aG0byuXtw79qqUq/UTJLLEyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaoDo30heHFWW6R2+CIuaHrav9cl51BwpdTDgdpiFYwdOd2MWL
	fzOKwZhhb84OTnMaOxs1ViwEmyMxklUTARRzNc/+b4MfGcL8VdyzR58ipC5Pl7cgZ2tLkdwW1vR
	R9i6CkVgIN4OopLNJbS7oCu8eoqNn8vAGNELmbtJi2/21OZLLElMGcYSaTEb9tokPTA1xAX9i22
	ZU2ltRmA==
X-Gm-Gg: ASbGncsff8+P62roBkNiPRLdDDJKogFdJY1kgK1BQxLzi572FvDGooP5kpzhjuLzKMg
	/0ZOC0gZxHbepSGUQ8I4s+VBMc3nXVmWAdEEqG26Gc+pHCAgtxE+/KNO8gHBD9/HDf0CX6vvy8L
	2icbOU9i9oKGM4iGbRbtIvO4zjcy6tOVFovzcKNYvWLsHXNa1a2zn26tG6qAlaKr3HC381wb+r9
	X+ls8P99Y09StykQGA9sEcQ8rf26DK+1+C2gwdK5cy6Xd7YAHKEdsJToHgpRw/3/8sniaak7uF3
	DrDvoYGv81CiCSgpn3jn03hLXBdA3zX5gZAVQKQ59cOLvZBbk+CTl9rheb6vUGSg+Opncb2J9/8
	KWNFyja1brO7mKoTXndZVTqo7W9Xe92JyvRR3BaPzIQy3l5ihfj4C9S33CXOEAiO04e45q5qJ
X-Received: by 2002:a05:600c:548d:b0:46e:49fd:5e30 with SMTP id 5b1f17b1804b1-46fa9a8f4e3mr242027435e9.6.1760605123680;
        Thu, 16 Oct 2025 01:58:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFascJJzEL6t6HgTISBwE+c0s63Iq7ev5oNUTb431XUwDd7m3F5ONlxv+Pvfs4GHfcbeXxcPg==
X-Received: by 2002:a05:600c:548d:b0:46e:49fd:5e30 with SMTP id 5b1f17b1804b1-46fa9a8f4e3mr242027245e9.6.1760605123256;
        Thu, 16 Oct 2025 01:58:43 -0700 (PDT)
Received: from [192.168.103.116] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144d1765sm18286875e9.17.2025.10.16.01.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 01:58:42 -0700 (PDT)
Message-ID: <a4c5e7fd-a37d-4729-ad58-81523f813fb3@canonical.com>
Date: Thu, 16 Oct 2025 10:58:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] dt-bindings: PCI: starfive,jh7110-pcie: Add
 enable-gpios property
To: Hal Feng <hal.feng@starfivetech.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 E Shattow <e@freeshell.de>, Paul Walmsley <pjw@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>
References: <20251016080054.12484-1-hal.feng@starfivetech.com>
 <20251016080054.12484-3-hal.feng@starfivetech.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251016080054.12484-3-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/25 10:00, Hal Feng wrote:
> Add enable-gpios property for controlling the PCI bus device power.
> This property had been supported in the driver but not added in the
> dt-bindings.
> 
> Fixes: 22fe32239770 ("dt-bindings: PCI: Add StarFive JH7110 PCIe controller")
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>   .../devicetree/bindings/pci/starfive,jh7110-pcie.yaml         | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> index 5f432452c815..f254c7111837 100644
> --- a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> @@ -60,6 +60,10 @@ properties:
>       description:
>         The phandle to System Register Controller syscon node.
>   
> +  enable-gpios:
> +    description: GPIO used to enable the PCI bus device power
> +    maxItems: 1
> +

Shouldn't we try to keep the entries alphabetically ordered?

Otherwise looks good.

Best regards

Heinrich

>     perst-gpios:
>       description: GPIO controlled connection to PERST# signal
>       maxItems: 1


