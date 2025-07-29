Return-Path: <linux-kernel+bounces-749903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FA1B15486
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFA816CE03
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AA5279915;
	Tue, 29 Jul 2025 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Fbng30ms"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C242405E7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753823050; cv=none; b=sibhChkXlpVph1bFxLETVQkqnwPC2aOR7/TszIEbdrRoS4ZnoZcK4dm5yar7oSqSdzs6bUgtigzFWG4UYo1ASV9POYfmxr3W/Z/0D8Zs4cuZ9brH4p5KXDNSMcD02Yd6Ug7LvnBUpEdHCr8lmyWRFVy1xXsISxWK/JIAgbt6qj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753823050; c=relaxed/simple;
	bh=7thQFiHMskvQ9aFUSWH6/ir2YyqLwdvvFhctZkjF81M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIkf9Haq0LUIlJF8ELbQKG6WRR9soOy9H8yogpPx9pXQ4DGlZmWkEF98L1zcGXkXAo2TB4xKajBlqwciKgO7q9BPpN2tPu7WqP3ElX/z37beIuh/DYoI31P06Smd4xZUjbcnzDUdMQ5/sKanpsCA7H9tvrTF65UhUJJVEmvOnq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Fbng30ms; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-87c0166df31so416918439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753823047; x=1754427847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dm0B5M26cYOXX5KrUOLsQ5vTboaxWnLdzB6XMUX6uWQ=;
        b=Fbng30msi2RM9dGyyAbbGtkKGS6ZUE3VVxeL0oUhcO48WUwn4VzKxEZZ3/a5Q40Sy2
         9r5PQ+hV0FJOIBLrkHRBik4bpGwaKN2hzsN+FRQOmRBB/u14jxBmo3aXXO7bcCsXHVjb
         Xe6Uk9L8YU/NYD/PnEOcLi/YkdKR755Sr/GhLjmog+Z2Bmh7McbWEFdWdgrTA2d9wjXq
         i+gz05Uoy/kxDpggEuccseKyr3n0Sy049LNyTUPzyDQ2MxMDcJiqb6mXPJGtMyjy3cI/
         F9WqObhIqVRIRO1LpBTbNU02UE1cOfzznpOlkGn3Xb0vOXb7J70rkRbux4cFCE5Z99i7
         Az8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753823047; x=1754427847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm0B5M26cYOXX5KrUOLsQ5vTboaxWnLdzB6XMUX6uWQ=;
        b=OySEOirT9K4BejEQMz8Pv9aSWsumpXpMsxWMhW2VTnky+2OKUK5b8vCwb+Vcqt5KdT
         IGOV198lp1hGSSEjLx34PwJQWTjX2/u+KK6XZTjzdIMohGik/0/iwr1wwIVUTS1+hVIO
         z1OzML2HUMugvInx/eWTfeAzuWL3ib/OtqulaV8L31coiDNuEY/SUlOFiIjUolmNFs56
         sZhGDubX44m2fuq6/G38PU7R6eN8ihe2GECzlfEfN7btO8IXYE7ctOSSwRPnvjCOfSjI
         MNkcEqem5gNDiCNcpmEkNLlD1xcUtMs++MMvn4yhGcZMmXhi3XitP939NZdOqxZUOjCW
         6QVA==
X-Forwarded-Encrypted: i=1; AJvYcCXTJ3KXe/uA9UCY2XjUT5qFICrvTrZzzjclC0xg2X8aypDYnXXa7yWc8iwQbqYINhcMizoi8LijzTwx5Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHsAIr9goq8X87fcXrxVchb6uB2YGz99f0hgoF3Sc4aaLmCVOD
	UN3O78pFZh1VHiu/aVL81UlNfvQNRaTD08XnTwdTCXjeo2ix9htuZQqMhtya/jkwOc4=
X-Gm-Gg: ASbGnctnYDL0phg+k+1de0pbcjDsOQjZ5xHSnB6RBYifNQqtncjcvTq7VsEjoJEFjxK
	HeWbpVLu4pNASg3weyn1WiYEQNwgRXFEbD6KsuLR8g70OrfPF1Yu048EHI4Z+Sv/FnjOvt+yBtw
	PM2UAUaLY9LWDqjsHavJgeke+pN67jCAtUsiONhDjJuvFa3/7hsl4A2NGawKWsgk266l7/lRWDj
	OZy8GRwApJjx0Qxd8sy3L9D/oTiZKQaVNhO2kI91tDBZppv239EByLB54LK+vzobDlhXF3f1Py1
	dKC9UHMyb7fG1tmxGPbXTVLeagZ99qc70CCAf+NNErvjYPOYzznMTsTzIsKYTrGfvVhDBr6nLjF
	UOU/Vdp47jajPd+FvBq7IMcf+hsH5WcVYU+/LG22iq7g7GY4peh4QpFQK6YJbCw==
X-Google-Smtp-Source: AGHT+IEYsNZGToVFKqEpDm8h8KviUj+EbfOPDQ9fzvNi2gdCmg29FQdC20eQLL41P+j0nBILREZn0w==
X-Received: by 2002:a05:6602:7501:b0:879:c9db:cbf0 with SMTP id ca18e2360f4ac-881374c295emr155676739f.2.1753823047163;
        Tue, 29 Jul 2025 14:04:07 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c91f1dcfsm2827976173.47.2025.07.29.14.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 14:04:06 -0700 (PDT)
Message-ID: <5c3f9f10-6a9d-45b4-80c0-09402b35bf47@riscstar.com>
Date: Tue, 29 Jul 2025 16:04:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: 8250: allow "main" and "uart" as
 clock names
To: Conor Dooley <conor@kernel.org>, Yixun Lan <dlan@gentoo.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, lkundrak@v3.sk,
 devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
 spacemit@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250728220002.599554-1-elder@riscstar.com>
 <20250728225319-GYA900803@gentoo>
 <20250729-reshuffle-contented-e6def76b540b@spud>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250729-reshuffle-contented-e6def76b540b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/25 12:54 PM, Conor Dooley wrote:
> On Tue, Jul 29, 2025 at 06:53:19AM +0800, Yixun Lan wrote:
>> Hi Alex,
>>
>> On 17:00 Mon 28 Jul     , Alex Elder wrote:
>>> There are two compatible strings defined in "8250.yaml" that require
>>> two clocks to be specified, along with their names:
>>>    - "spacemit,k1-uart", used in "spacemit/k1.dtsi"
>>>    - "nxp,lpc1850-uart", used in "lpc/lpc18xx.dtsi"
>>>
>>> When only one clock is used, the name is not required.  However there
>>> are two places that do specify a name:
>>>    - In "mediatek/mt7623.dtsi", the clock for the "mediatek,mtk-btif"
>>>      compatible serial device is named "main"
>>>    - In "qca/ar9132.dtsi", the clock for the "ns8250" compatible
>>>      serial device is named "uart"
>>>
>>> In commit d2db0d7815444 ("dt-bindings: serial: 8250: allow clock 'uartclk'
>>> and 'reg' for nxp,lpc1850-uart"), Frank Li added the restriction that two
>>> named clocks be used for the NXP platform mentioned above.  Extend that
>>> so that the two named clocks used by the SpacemiT platform are similarly
>>> restricted.
>>>
>>> Add "main" and "uart" as allowed names when a single clock is specified.
>>>
>>> Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional second clock")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202507160314.wrC51lXX-lkp@intel.com/
>>> Signed-off-by: Alex Elder <elder@riscstar.com>
>>> ---
>>>   .../devicetree/bindings/serial/8250.yaml      | 19 ++++++++++++++-----
>>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
>>> index e46bee8d25bf0..cef52ebd8f7da 100644
>>> --- a/Documentation/devicetree/bindings/serial/8250.yaml
>>> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
>>> @@ -61,11 +61,17 @@ allOf:
>>>               - const: uartclk
>>>               - const: reg
>> ..
>>>       else:
>> would it be better to drop this 'else', and moving following 'if' block
>> to the same level with "nxp,lpc1850-uart"?
>>
>> the reason here would avoid too many indentions if add more constraint in
>> the future if other SoC uart need different clock-names..
> 
> I agree, it's more typical to do it that way I think to boot.
> 
> Also, why is there a k1/lpc conditional bit that is not part of the
> allOf in addition to the bits in the allOf? Can that get merged with the
> allOf please?

Are you talking about the blank line here?

     then:
       oneOf:
         - required: [ clock-frequency ]
         - required: [ clocks ]
                            <------ this blank line
   - if:
       properties:
         compatible:
           contains:
             const: nxp,lpc1850-uart
     then:

I didn't notice that before.  It got inserted with commit
d2db0d7815444 ("dt-bindings: serial: 8250: allow clock
'uartclk' and 'reg' for nxp,lpc1850-uart").

If so, yes I'll remove that as well when I update the patch to
get rid of the else as Yixun suggests.

Greg won't take this for a couple weeks so I'll hold off sending
v2 for a while.

					-Alex


