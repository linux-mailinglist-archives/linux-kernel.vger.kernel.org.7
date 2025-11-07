Return-Path: <linux-kernel+bounces-890012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99956C3F105
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A73104EC2BF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B267A31690A;
	Fri,  7 Nov 2025 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANRzHrK6"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DD3164CB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506235; cv=none; b=DTEovwnFDYkXqql24J3Dn7PFaYsnNwvUxxzWpv2OMB42HrGUUiPjbav/Rm7U7ghB15CSlTrwCe5JHrBsjgLDTR7DIhhCq0+9AQ1wIDewoTmBXdt3ZFBEo+SN7M8PO3anXA8h6v3hQP90z9wz76vFb9+8/jf8HUV26886EQCZNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506235; c=relaxed/simple;
	bh=psFl+xnMnk37GhV4MnsouvK6LqIcE2gebJugzRUMVnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9AP6S+Y1DPbw5QAo4wPr5H0FKk3Ja7549ez4/vVIMGk3a9nDHzjKQvHLtphdedzfF+kHnVlWXb+YuNdR6XGo9pgx7eKVXkpc6ypDg3JwzpJ1nfxHxCCUpbJ9QujF8usEISEz6Fz10dVc1fbq5rqs/LCYrLo7F52q0sbn2I6REU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANRzHrK6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f67ba775aso686249b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762506233; x=1763111033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tT7fj5k07gPftTXVwZkpdl1GWYGdXE6T7v4vJvy2kDw=;
        b=ANRzHrK6x/mzdXoxlquIh4qO1v8hERckYZIvT6LHfL0GBSZBi67yGwOPaduYwQFUYs
         qQP82OzJtzQXLC/0A83FNlB+IMUlwhqgkIij+F7rAwIVIMSHe/vVj5UKPtqAxbSWIjf3
         Sp6dlRAgVrdxYMSznsVcJp2jcitBSYHyOfZuP1dWdif/cZKCMwWRL2hbqdMHirF1IhK6
         2gRh/lOAcVk5LL5VW6j4uP0WMiA35W53O8gwLsVR6ZMBDJ6WQrNZLOg5bC8PqZOHnvX/
         gA2p/BGvwYi77/dqsgv8yl9nzad/VSc3nb0LaZf1RPlXJYwwnNjIbVtclsuwFQJu/tJY
         UCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762506233; x=1763111033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tT7fj5k07gPftTXVwZkpdl1GWYGdXE6T7v4vJvy2kDw=;
        b=eQaGNGWoZzh4yDEP82psJoBM/+CyFdEs2TTO3Ifseg65tPLQF3ZiBphE0ea/DhtwSF
         Afto9hdb1TaXqsKT6rQuCI9gFIWcVLt27XKBU429DOMzvRlGPDTO2w0ILmRFXc3QVm9U
         EeVbC6E3bBTn0bzHX/56AVQQuChwlUR0at4rDm+6rlG0EOplvp0CNeXlk+t43hOA/+SZ
         g7NVV6o1L7uSdufAu7mCKnYUltiQXD46QowknjGbeIpdNDRnVOE/s8O6h0cPI18KjTHA
         96f5Wi2RtHAgcBiEphy692Mf/Hv/tlkOZysq7/rc0eulWfqhS33ao6OklS1u2xMLaPnn
         YcsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmnMd2Vp4i8mzVCWoj658q3L7/iNcVjBzwV6BlN1LJALmhd5gNFqYPllQ7vP9kLPZ+FSmDLjqvtVSyK4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8gM1wMS5s7sA+e1EW0ZOlAmjzk+55moeCZTACazRLE261gczh
	ewfre5xB31Hes6Sxx6x3s1TYlyuhuf9coaveIr6vzBgS8qYTsR6X0b9S
X-Gm-Gg: ASbGncv++0rv0biN1Nk0gQzuUsWAYumyoyQUHwezKYt0XkEjQEAehFm+5Lu7bUzxkPh
	rhtBuZNK4BETUsvAfSfKLwDc/L/Q/JEPfn8X29PA/jD8UgYiyMibyq1730ApBWJCqvu3e3FQa5n
	1j8fzUq1GETJwPyiFN3UWwL0w+PE2XYKlx07m7jAR1xxZGTSTR14lx9fJIq4Y1CCxnrINaxQaAz
	KILD2t6dSpE4tYctLB6EnC9RMpQ8WU/yd5L735F5ZdS8t1OI2QVpyah2azRZpgdQToVwCLQok2f
	3rICso+lNwZfgPakeanh82km68wATJ77n3ZX2RMZv8L8yjYA+fUe70UKxKS9U+FBNYU0+E3AGCY
	7L+98E8DnIsXifCacB+NYDveufM7PshrY0K3Moenlm5x1pxpfPw8cBiGaH7qqG6zN8ctJQ3Xg2M
	HZ4Skciu98zKfUaUgh5EIdTevyR8nu
X-Google-Smtp-Source: AGHT+IG5vR1egSvLYlpyAuLiB18qRbW6MOxx72JsnThhxgsoP3bPI7UP6infgwdQBZnUmskzoPWvRQ==
X-Received: by 2002:a05:6a00:94f5:b0:7ab:fc99:d856 with SMTP id d2e1a72fcca58-7b0bd5a20f5mr3697022b3a.18.1762506233233;
        Fri, 07 Nov 2025 01:03:53 -0800 (PST)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm2181954b3a.34.2025.11.07.01.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:03:52 -0800 (PST)
Date: Fri, 7 Nov 2025 18:03:46 +0900
From: Joan Na <joan.na.devcode@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: regulator: Add MAX77675 regulator
 binding
Message-ID: <aQ218nXK0tMEsinu@HYB-iPCgmhaB8Cy.ad.analog.com>
References: <20251014053142.15835-1-joan.na@analog.com>
 <20251014053142.15835-4-joan.na@analog.com>
 <512ffe3d-5ab3-4e87-afd2-46f0005a8d17@kernel.org>
 <aQwyH4rYlcWNxGxI@HYB-iPCgmhaB8Cy.ad.analog.com>
 <d700c50a-272d-4b6b-8c39-615d096ffed4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d700c50a-272d-4b6b-8c39-615d096ffed4@kernel.org>

On Thu, Nov 06, 2025 at 08:08:36AM +0100, Krzysztof Kozlowski wrote:
> On 06/11/2025 06:29, Joan Na wrote:
> >>> +  maxim,bias-low-power-request:
> >>> +    type: boolean
> >>> +    description: |
> >>> +      Request low-power bias mode.
> >>> +      When set, the device enters low-power bias mode.
> >>> +      Defaults to normal bias mode if this property is not specified.
> >>> +    default: false
> >>> +
> >>> +  maxim,simo-int-ldo-always-on:
> >>> +    type: boolean
> >>> +    description: |
> >>> +      Set internal LDO to always supply 1.8V
> >>> +      When set, the internal LDO always supplies 1.8V.
> >>> +      By default, the SIMO internal channel supplies 1.8V during low-power mode
> >>> +    default: false
> >>> +
> >>> +  regulators:
> >>> +    type: object
> >>> +    description: Regulator child nodes
> >>> +    patternProperties:
> >>> +      "^sbb[0-3]$":
> >>> +        type: object
> >>> +        $ref: regulator.yaml#
> >>> +    properties:
> >>> +      maxim,fps-slot:
> >>
> >> That's not property of regulators. Totally messed indentation.
> >>
> >>
> > 
> > The maxim,fps-slot property is specific to the MAX77675 regulators 
> > and is used to configure FPS slots individually for each regulator (e.g., sbb0–sbb3). 
> > As this represents a device-specific extension rather than a generic regulator property, 
> > it is defined under each regulator node.
> 
> But you did not define it under each regulator node. That would be fine.
> You defined it under regulators. So again that is not a property of
> regulators. That's a property of each regulator.
> 
> If you bothered to test it, you would see warnings.
>

I am sorry if it seemed like I was suggesting no testing was done.
I have now updated it under the regulator node as shown below.

  regulators:
    type: object
    description: Regulator child nodes
    patternProperties:
      "^sbb[0-3]$":
        type: object
        $ref: regulator.yaml#
        properties:
          adi,fps-slot:
            description: |
              FPS (Flexible Power Sequencer) slot selection.
              The Flexible Power Sequencer allows resources to power up under
              hardware or software control. Additionally, each resource can
              power up independently or among a group of other regulators with
              adjustable power-up and power-down slots.
              "slot0"   - Assign to FPS Slot 0
              "slot1"   - Assign to FPS Slot 1
              "slot2"   - Assign to FPS Slot 2
              "slot3"   - Assign to FPS Slot 3
              "default" - Use the default FPS slot value stored in OTP and read from the register
            $ref: /schemas/types.yaml#/definitions/string
            enum: [slot0, slot1, slot2, slot3, default]
            default: default

          adi,fixed-slew-rate:
            type: boolean
            description:
              When this property is present, the device uses a constant 2 mV/μs
              slew rate and ignores any dynamic slew rate configuration.
              When absent, the device uses the dynamic slew rate specified
              by 'adi,dvs-slew-rate-mv-per-us'
            default: true

> > 
> >>> +        description: |
> >>> +          FPS (Flexible Power Sequencer) slot selection.
> >>> +          The Flexible Power Sequencer allows resources to power up under hardware or software control.
> >>> +          Additionally, each resource can power up independently or among a group of other regulators
> >>> +          with adjustable power-up and power-down slots.
> >>> +          This device's regulators provide an additional property to configure the FPS parameters,
> >>> +          allowing each regulator to be assigned to an FPS slot for proper power management control.
> >>> +          "slot0"   - Assign to FPS Slot 0
> >>> +          "slot1"   - Assign to FPS Slot 1
> >>> +          "slot2"   - Assign to FPS Slot 2
> >>> +          "slot3"   - Assign to FPS Slot 3
> >>> +          "default" - Use the default FPS slot value stored in OTP and read from the register
> >>> +        $ref: /schemas/types.yaml#/definitions/string
> >>> +        enum: ["slot0", "slot1", "slot2", "slot3", "default"]
> >>> +        default: default
> >>> +
> >>> +      maxim,fixed-slew-rate:
> >>> +        type: boolean
> >>> +        description: |
> >>> +          Use fixed slew rate of 2 mV/μs for output voltage transitions.
> >>> +          When this property is present, the device uses a constant 2 mV/μs slew rate
> >>> +          and ignores any dynamic slew rate configuration.
> >>> +          When absent, the device uses the dynamic slew rate specified
> >>> +          by 'maxim,dvs-slew-rate-mv-per-us'
> >>> +        default: true
> >>> +
> >>> +    additionalProperties: false
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - regulators
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    #include <dt-bindings/regulator/maxim,max77675-regulator.h>
> >>> +
> >>> +    i2c {
> >>> +      #address-cells = <1>;
> >>> +      #size-cells = <0>;
> >>> +
> >>> +      max77675: pmic@44 {
> >>> +        compatible = "maxim,max77675";
> >>> +        reg = <0x44>;
> >>> +
> >>> +        maxim,en-mode = "slide-switch";
> >>> +        maxim,latency-mode = "high";
> >>> +        maxim,drv-sbb-strength = "max";
> >>> +        maxim,dvs-slew-rate-mv-per-us = <5>;
> >>> +        maxim,manual-reset-time-sec = <4>;
> >>> +        maxim,en-debounce-time-us = <100>;
> >>> +
> >>> +        regulators {
> >>> +          sbb0: sbb0 {
> >>> +            regulator-name = "sbb0";
> >>> +            regulator-min-microvolt = <500000>;
> >>> +            regulator-max-microvolt = <5500000>;
> >>> +            maxim,fps-slot = "default";
> >>
> >> I don't think this was tested.
> >>
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > Testing on the actual EVKit has been conducted since PATCH V4
> 
> I have proofs this was not tested - see email from Rob.
> 
> But if you claim it was tested, then please explain me how can you
> possible test a binding on EVKit (it is impossible) and how could your
> testing miss such obvious errors?
> 
> 
> > 
> 
> 
> Best regards,
> Krzysztof

I will do my best to prepare everything properly for the next version.
In the meantime, I’d like to share the following test results that demonstrate the current behavior.
Please let me know if you need any additional information or clarification.

[    3.527749] max77675 1-0044: max77675_parse_config : MAX77675 PMIC configuration:
[    3.527753] max77675 1-0044:   en_mode                = 0
[    3.527758] max77675 1-0044:   voltage_change_latency = 1
[    3.527762] max77675 1-0044:   drv_sbb_strength     = 3
[    3.527766] max77675 1-0044:   dvs_slew_rate        = 1
[    3.527769] max77675 1-0044:   debounce_time        = 1 us
[    3.527773] max77675 1-0044:   manual_reset_time    = 1 sec
[    3.527776] max77675 1-0044:   en_pullup_disable    = true
[    3.527779] max77675 1-0044:   bias_low_power_req   = true
[    3.527782] max77675 1-0044:   simo_ldo_always  = true
[    3.531250] max77675 1-0044: max77675_of_parse_cb() called for regulator: sbb0 (id=0)
[    3.531265] max77675 1-0044:   DT node: /soc/i2c@7e804000/pmic@44/regulators/sbb0
[    3.531281] max77675 1-0044:   Init data: (none)
[    3.531286] max77675 1-0044:   Parsed 'adi,fps-slot' = 'slot0' (slot=0)
[    3.531291] max77675 1-0044:   'adi,fixed-slew-rate' = 1
[    3.531294] max77675 1-0044:   Applying parsed config for regulator id=0 (fps_slot=0, fixed_slew_rate=1)
[    3.532553] sbb0: 500 <--> 4700 mV at 1800 mV, disabled
[    3.545628] max77675 1-0044: max77675_of_parse_cb() called for regulator: sbb1 (id=1)
[    3.545647] max77675 1-0044:   DT node: /soc/i2c@7e804000/pmic@44/regulators/sbb1
[    3.545661] max77675 1-0044:   Init data: (none)
[    3.545666] max77675 1-0044:   Parsed 'adi,fps-slot' = 'slot1' (slot=1)
[    3.545670] max77675 1-0044:   'adi,fixed-slew-rate' = 0
[    3.545674] max77675 1-0044:   Applying parsed config for regulator id=1 (fps_slot=1, fixed_slew_rate=0)
[    3.546991] sbb1: 600 <--> 4800 mV at 1100 mV, disabled
[    3.547235] max77675 1-0044: max77675_of_parse_cb() called for regulator: sbb2 (id=2)
[    3.547245] max77675 1-0044:   DT node: /soc/i2c@7e804000/pmic@44/regulators/sbb2
[    3.547258] max77675 1-0044:   Init data: (none)
[    3.547263] max77675 1-0044:   Parsed 'adi,fps-slot' = 'slot2' (slot=2)
[    3.547267] max77675 1-0044:   'adi,fixed-slew-rate' = 1
[    3.547271] max77675 1-0044:   Applying parsed config for regulator id=2 (fps_slot=2, fixed_slew_rate=1)
[    3.553864] sbb2: 700 <--> 4900 mV at 700 mV, disabled
[    3.562943] max77675 1-0044: max77675_of_parse_cb() called for regulator: sbb3 (id=3)
[    3.562965] max77675 1-0044:   DT node: /soc/i2c@7e804000/pmic@44/regulators/sbb3
[    3.562979] max77675 1-0044:   Init data: (none)
[    3.562984] max77675 1-0044:   Parsed 'adi,fps-slot' = 'slot3' (slot=3)
[    3.562988] max77675 1-0044:   'adi,fixed-slew-rate' = 0
[    3.562991] max77675 1-0044:   Applying parsed config for regulator id=3 (fps_slot=3, fixed_slew_rate=0)
[    3.565702] sbb3: 800 <--> 5000 mV at 3300 mV, disabled

Thank you again for taking the time to review this.

-- 
Best regards,
Joan Na


