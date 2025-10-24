Return-Path: <linux-kernel+bounces-868490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D65FC0556F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6363A8FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387D4307AD9;
	Fri, 24 Oct 2025 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsmJtpGZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7030217C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297690; cv=none; b=D1Uv9L3srXsIoUfOW1gBhp0Myvc0FDrIPkVaJhSe7zchfVdJHsrABXXLBxcnaGzm/G050e6rB/JaMCWWT6fuOzKdcU0TlHFEIyIWsIKzAK+LHstAq1RqH51WA9/vRe+WMsyCN+bUDz4oBFGjbVnBzNzgJlwzJy5ao80EM1/fii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297690; c=relaxed/simple;
	bh=cgYBzSPBAN/hnDGuQioL8lgzcDFfoDLXW1qeVfhBWBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgDd1lAUcd5z60UArPPpe45mBb6+TszyNL34QrhS1lhj+VBba9StCu18+EHdzp1vehrzhlQg5WY99F5pveghVOXCCxpE5NU5eHIO2Fji0SwLJSCOsmhat8F2+AhHHhsoJKPEvfSseBswkcVna7BGGUKdHP+6c/3Qoeovjer26lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsmJtpGZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so10479055e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761297687; x=1761902487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NY5PIARKbpIdf6CoFhX2UEn3hHI/O9Hdjy4EAS5mHE4=;
        b=jsmJtpGZ9NrNjzfN0R7DqE1WJoC0OCtiAddoq0FLmAXnNG7WBGyvuFUbWBBaqUoyI8
         McNgdYSv+xeIl1hErbxI9dOqIQnRwubOQ7wyJa6RHRNr8DdRNW8GxjuLRI5rzQkDMVNn
         bXToADcc5ry80sORGqQzQ9kPjV3WOP1Q8b/qsVew5Fln065CFGfsYyaAb4Hl21phzuw2
         8oBJA9Mj31pugdjfyk7yp62PvyRqG6zfm3Ck8NSIRr/AmCQ8UhaVlw8BUK7DWPnv0qtU
         wAW855TmyO2TWYjxF1iLovwgBgEJVDF6anw61HQSYWu/i+gObG22bG45MuS3+dOd1Ssq
         GMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297687; x=1761902487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NY5PIARKbpIdf6CoFhX2UEn3hHI/O9Hdjy4EAS5mHE4=;
        b=ackLG4SRcT2ZCgZblv60+rYaBzeOjVUsSXdsREtBE4+JfBtzXQzYmtBQz+U2+BxF2Q
         rBs7b91x7uNDgtV7Z1njMEsTSKHHugfeUyb3ftPrt09OyGH79hvXio2HcPhLGrU8EmCM
         QxpvkOWw68R67YOr58o8Nq2SIfpXDypdnDVB3EcFzEOjG6z2lMO7ReSCIrK0G13E1424
         Ce2GqaaVHsqrxoZIaWvtiD11VFKoPa373F9/7UPZISGEH66SryImbZ5bXS/2YG/iZS8r
         TTwT+Y9qVJqY0OVKJLuxDWP4vhWGVw48H3esccynQV36MY44U/ahtdmNq7tbNAUBS+kA
         jC7Q==
X-Gm-Message-State: AOJu0YzHDVJHWFL2XWu9l6I89CQennqLhC+pS2iIFT0mEY91jxaCYI2P
	BVWODKRs+2pLysRj2dXoeffysRm79c8ijLvCb/ylL0AgFR6rUEdnDms3
X-Gm-Gg: ASbGncvug0IjAXt6yZe37C7tL5Ie9eGEmebWLHWtP5U5vpt5NyRdg4LImhGsAo33eoK
	seVx1Qyf9YKJtEPR9MJIpgndgWA6fHtZz6Gq7oGt3IdvGt9TzMG3Av6MS84z5r3XFTKu6GpZA6s
	LiaZJ40VY59QHE3I8ugLHhOI4lYdHJFczsy7c3VNqKxYtYAbMPe1wL+NIgORculuKA/kqYJ8CSc
	DLPpdHZnACuEs3uUKCkFbQERK4azq7ve+sVl2j3VmlSFigKH6ukiJSLaivrODVuK0RXyP2if30Q
	Nxk2zp7dWhzstiqUs8mJTot+WXs81hWjsfJovKp++C1YLxHUZ0izouw2Mbw9s9Zjd4gL659zlGC
	/FE+zU+rV7+jOAzmj1/kO1+eD+ptc73vlMfNkeAUurMUQtcQt+Nvds0ooFIBz5yo9SyduSWIU32
	FjVrbOTwMHOhwnznlyBpAgXFpVhyUXiS/suOAQV2JNzhr1wtD6eqAvwM8x5iMNsoTMf/eZy6NrB
	c99jeBF2mMYCLwb0qqee8IZCjO2mshybZS4qYrSo52c
X-Google-Smtp-Source: AGHT+IFN2t4M6Qoj3pIFSsEj3r77vKyY565/HfDPakReHx4yAtJAuSEBAgmRyjYHNwXMg0iJVqrMIw==
X-Received: by 2002:a05:600c:4f08:b0:46c:e3df:529e with SMTP id 5b1f17b1804b1-475cb03021dmr42329985e9.19.1761297687076;
        Fri, 24 Oct 2025 02:21:27 -0700 (PDT)
Received: from ?IPV6:2a02:8440:7132:30ef:ba02:7a36:289:dc72? (2a02-8440-7132-30ef-ba02-7a36-0289-dc72.rev.sfr.net. [2a02:8440:7132:30ef:ba02:7a36:289:dc72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494b02475sm81213955e9.4.2025.10.24.02.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 02:21:26 -0700 (PDT)
Message-ID: <b3accac0-d02a-4b92-848c-ada62377e440@gmail.com>
Date: Fri, 24 Oct 2025 11:21:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] dt-bindings: memory: introduce DDR4
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Julius Werner <jwerner@chromium.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
 <20250930-b4-ddr-bindings-v8-2-fe4d8c015a50@gmail.com>
 <1877f731-1599-414d-a40e-38aec05a33c0@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <1877f731-1599-414d-a40e-38aec05a33c0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/25 15:21, Krzysztof Kozlowski wrote:
> On 30/09/2025 10:46, Clément Le Goffic wrote:
>> From: Clément Le Goffic <clement.legoffic@foss.st.com>
>>
>> Introduce JEDEC compliant DDR bindings, that use new memory-props binding.
> 
> 
> If there is going to be resend, then please repeat here applicable part
> of compatible format, e.g. why it's like that.

Hi Krzysztof, ok

> 
>>
>> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
>> Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
>> ---
>>   .../memory-controllers/ddr/jedec,ddr4.yaml         | 34 ++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
>> new file mode 100644
>> index 000000000000..a2eb6f63c0ce
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
>> @@ -0,0 +1,34 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,ddr4.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: DDR4 SDRAM compliant to JEDEC JESD79-4D
>> +
>> +maintainers:
>> +  - Krzysztof Kozlowski <krzk@kernel.org>
>> +
>> +allOf:
>> +  - $ref: jedec,sdram-props.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - pattern: "^ddr4-[0-9a-f]{4},[a-z]{1,20},[0-9a-f]{2}$"
> 
> Why double ','? I would imagine last ',' to be '-':
> ddrX-YYYY,AAAA...-ZZ
> 
> Sorry if we discuss that already, but then please remind me and this
> would need addressing in commit msg.

I do not see anything against that.
I'll wait Julius's review, if any, and I will send the next version with 
this changes.

> 
>> +      - const: jedec,ddr4
> 
> 
> Best regards,
> Krzysztof


