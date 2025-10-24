Return-Path: <linux-kernel+bounces-867917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F6C03ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96ABA1AA25EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06259A48;
	Fri, 24 Oct 2025 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="wJmPVWx6"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870EB4A32
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264247; cv=none; b=WzdxHIF3Rs6OAsQIMpp+LMtVqAWP6vY1JhUYFiHDtDk/Ed46YIAF1t/bsGDBm8VaSRKexnzrtkOMmvej9ElpdFntvGfdbwyruoqJH1Fa+1PXstgUTsvP3CI9qJmYs/k9NqBlQhMjTrqSM0ZbvyuhX4FAtVFY65/77WjcSmT7z08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264247; c=relaxed/simple;
	bh=C1jkv51ztRxfrNfz0d7YqP/iXJQqsBRzL9QozwFBY9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCfjCdCZWM1npVHAAmyq9h+ysee2+9nA151gD20RRGM3K++HCw7OA+6QEoMsFS1DZ/96RU+9Ffr9megEasgYzq4ak/DtL5kxlfwyTg5o6Pn55oq7NQbl/vZGAiD4jmgIYyzhugWyhw5xV9kId0AzRGWKKjyFBR5pwInzS78MPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=wJmPVWx6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33c4252c3c5so1421443a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761264245; x=1761869045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDIR1c+Ak+2fqutJiwvCBnlZ0v5UftOa0ifZP/2OQnc=;
        b=wJmPVWx62tCC5wRokHJeKJtjKXrd3lBjhygVoiCLYc/GfseIDsdhfzQraXKO2eVj/7
         HoiBhb0QXjEqycCGZ52aqOMjQ5ZSw1BGb4JTGsWQ5qQvCDS+nwENGa2EBgtI1ibcJDyz
         fH5wOXhB2cx/Sx2OrNUjRB0Nv1d3bCx0O6+WNyhbzt94K38vu+D7xFTbIKpOHBPDliG7
         z4ZYDPV/CTCbHN3ACxEDiT8yvQBpvMK1EZkguEr/IipFCv3z+9s0zw7EXkvRsIZyReso
         4Lukyw9D1ywKzv60umIi2t4Jn40fkqC0dVhKgsP5by5TNKH3a2G5tmfdKRXgwpYnPROv
         xPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761264245; x=1761869045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDIR1c+Ak+2fqutJiwvCBnlZ0v5UftOa0ifZP/2OQnc=;
        b=ZGBoKVNXKcdUweHVyuTYGCSPWjBifF7sTet6VlbHFUUPXNC442a12bEsxBmq8QxfHJ
         arb8lgN8gk5DPy3bfRLgbYDP0BmQxOsjKfB1QXzS5tJ5lue9luh/YDPBFSr992edzZnL
         iIuRghEXqbehp/EwW5a+Ah1lu6Fcfw3cB4euDZDrArYyrof16HJECM5bLRVuInzBZgCP
         2BCGP1aW+am7clyr9bBCeSm/lhqPwHF8mFf/oQfB0UNUpNQYNo/vwzap70/SJzIPNcBY
         BLCW+w7nGFekokLhqjwH8NPy67yM1p344sw0NjAUSTWqxbI5mU4B9XilGVxiIfbkLtoY
         XTdA==
X-Forwarded-Encrypted: i=1; AJvYcCVsvaOrbiQpspjBJsmJ9vzhPiYNuq6PbAE7w4SeRh/dW/SNixxjfHC0MiC3s/bVPjugvTzyQrd/doHKWnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/f5eq/BddbApHzdy83AnBy5Vgdoo4YgkBSm8gSTrhX3l8zAAS
	WoQDshWtlYdrSbd6MLNE+JGZj373bhf4qAKs9qK7mztNBkG62JTlLwtjKT4QRB5FZpY=
X-Gm-Gg: ASbGnctVPnEaVaGmnVptTr4SPoXFDxCYYZAIxSVbaUf60wpr8YNZLLxdjLiX39BD9/m
	O5qvWy4KsK/XEuj3Jz0CcE1M8L29YjiAr+IWBYKy9xF1SqRaemsLVfQ0WnSnnS0dT1syVwDkGkP
	fKANl8s1H7TS7Nix93uQbqabYYy3suW32e28q1+TMjqO1dKzsbNkPnZdR2+saC5XUuGveiXY+Lu
	51/MB5mfHwS1E1+l+qkb1irjwYrZv3DJddmEvS2I3dpgiV/nQ41h0MgfUEzsE+tsdhoakqMtrru
	wRjhusM/983YmCpwI3tOjO4r/poWEEhr+GgrEP7ypsrtpKoZtlWhqi+zZeMC7eoZUUQgmXbR/P9
	QDNFTW4Mu/o5fEtJbrdSNUx4StVZwhif8yqQxMBRd+GZEw2ttsc17/7UZ68mXSQNj5LEwEfuU7S
	eGRM7oHuM7u5A0U6so
X-Google-Smtp-Source: AGHT+IH/sqOkgJHPoJp0C3PRAnpePjJuvBDUdrVuB7xX2bh8XQc9etMQIVsugloCyKqrfw/GQPbVxw==
X-Received: by 2002:a17:903:38c8:b0:276:76e1:2e87 with SMTP id d9443c01a7336-2946e22bbcfmr48197185ad.44.1761264244857;
        Thu, 23 Oct 2025 17:04:04 -0700 (PDT)
Received: from [10.211.55.5] ([208.115.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff373easm3702460a91.5.2025.10.23.17.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 17:04:04 -0700 (PDT)
Message-ID: <c4da7114-09c2-4c66-bdec-ee80cd7c5f5d@riscstar.com>
Date: Thu, 23 Oct 2025 19:04:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] dt-bindings: spi: fsl-qspi: add optional resets
To: Frank Li <Frank.li@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, han.xu@nxp.com,
 broonie@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-3-elder@riscstar.com>
 <aPq6+4RwGeru9Txw@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPq6+4RwGeru9Txw@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 6:32 PM, Frank Li wrote:
> On Thu, Oct 23, 2025 at 12:59:14PM -0500, Alex Elder wrote:
>> Allow two resets to be defined to support the SpacemiT K1 SoC QSPI IP.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - The "reset" property now only applies to spacemit,k1-qspi compatible
>>
>>   .../devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
>> index 5e6aff1bc2ed3..edd3158a6f2e8 100644
>> --- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
>> @@ -55,6 +55,21 @@ properties:
>>         - const: qspi_en
>>         - const: qspi
>>
>> +  resets:
>> +    items:
>> +      - description: SoC QSPI reset
>> +      - description: SoC QSPI bus reset
>> +
>> +if:
>> +  properties:
>> +    compatible:
>> +      not:
>> +        contains:
>> +          const: spacemit,k1-qspi
>> +then:
>> +  properties:
>> +    resets: false
>> +
> 
> strange, if-then should be under allOf, I have not seen you add allOf. And
> original file have not allOf.

The file currently has allOf at the top, to reference
spi-controller.yaml.  I'll include this next time within
that allOf.

					-Alex

> 
> Frank
> 
>>   required:
>>     - compatible
>>     - reg
>> --
>> 2.43.0
>>


