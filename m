Return-Path: <linux-kernel+bounces-872651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D1FC11AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC213B9596
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5619A32ABEC;
	Mon, 27 Oct 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZjepjOpg"
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98925329C64
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603879; cv=none; b=ppNSYb7wUe70R79fnfwIKJV+WbLZ49XoQnGsghbMD2/24I69hyn02iZYCmGobKBl0uN9imRf5phdrXDKRtEjx4Mjin4pjHByPamf5ELE6n6xZthWiJh9SKfJu/gUEysJNjZfY2qs8cF+2brycSTcLRNZHSxnkxEZGbY5MJH3W+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603879; c=relaxed/simple;
	bh=iuxmZjW37Mn2BUZtgE3HSKiakJo/wcKrte0uvUxagiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RX//UZ/iwb6E8DQ4K+5zlei0VRGe5MeYXapE5LnOm216WokcOhIu2uXCtH2z+egpeFt6nnzwrOfnT8YssdxfId1y2GVOynonWiNJufv5GHrr7Yd2xPG1KvV6UFtPkX9h1Fo1S6Vn1VYGRlX8WTucB/KWWkBlUewrnudt8TJ0cxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZjepjOpg; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-945a5731dd3so79399039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761603877; x=1762208677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wM5uwMP02IQy2fgQls6S0qQat4rqlu7HXn5+aaktR2Y=;
        b=ZjepjOpgc9CuwWiJxr7I3EX6++2/oY7Jg/sa43KdJMu1Sh4kRPF9yIHSfAgMdpQani
         75YRyLK4Jr+LcGPLuK/u/1rzjtwsQNQc+zxvgAse318//0201d7sy085YhN6u77H7fFC
         raRGzhXSKSFpQDK8frlFc8rq5hw3/8uNgtbRfA2WfnbPyyw103qzwPAOCt58UX9bZr9Z
         XqyJPLUiOspVJ3WsuRenUUzI/aO8GdFfs6Wufboahmma4gPKXVD8dBMrowB47aUkDbLN
         oqdJCd+99HDvQ4F8FzNDYYm5idFIKHjB32mgd/fluaGAl4Z6p3FFX8P01cdBRrGgtpq/
         ywDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603877; x=1762208677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wM5uwMP02IQy2fgQls6S0qQat4rqlu7HXn5+aaktR2Y=;
        b=PyaI4j3JzFivoYzq0iSUayaTN8NPi3THISOzoyaXCYAKLsey5lx1Wy3wHK4nf++Suy
         vVeYE+I+rfJY7Jq8VWE+IwDC3nDZ/g3GgSUv0QDAM7bZkn/eQQVLQp9uvnm2/h7VSWqt
         KMiXoDqE7c8l/+SuAw9rJggzuF5py/43FSP7tcF1f3TOdKyuk/NlPP46GWGX15TJQ1MY
         6KbX0KED6w/0wio+PfL2tceO6idqJj7XCbU1zfBVJ3h1mAu8YfFpctsqYAcPJ6SQKCBx
         dtQLkwUnUfRgStyI+s1fqSmUKE2ATGRxFyTSvWO/BjH9Du946ASneUgG1jqrdmpRrIrg
         cvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9HOrdX30Ws8KekbYbnAIoDBohzEBL2Wf5/xWUSE5d1Jqpwcb9OGLQa76hNxab+PDXN7ex563AIj2sld0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHuosa6MT0oQkVi/3Vj1iylNsPeYChB6t1s4TSHX0BVOvyIyX
	Oamw24rx7MOtQrFQVuDWYuR0O27SEimhnicyyemu3LfYkCCaslcskMRlzn5bdM05+Mg=
X-Gm-Gg: ASbGncuQNXog+f15enfmfGPg9Eo1zfIuOUt/ToscXGrH2W7AFxoUzWyDswLbi+2YAvM
	53fk6iglT2XJC6cZbw9rmlnmTt8rthsl0G8MbJWgLk24rUsHLI09VCVWlS59WSShchwMzU7caGk
	LlpRvoO1I4jV+5EhICUaCXTucn9POz/k4/giZxgx3dRmjqNmmEBstK1BKzPoC7cNcCXRPM/Tpob
	AW5tFo3J2d9f86K4lAo8lx8NclNjMYYaLe8xraZPhqA3spSZPdhjROwbffdCdlhcfCHJURfa3At
	K2GB8RafSGxD58iMHNo0AEc+8eyHkCfEA20Q8hdjgE09sIOY3S1XNOyXPftjdEyvuSnV4FvZCGz
	m8EwhvQuuZme7Bm4FMVCjzqDKLynQHm++Qe4G91CET5V/9R8cf42PzTVk/3+SqFbKXgtbGQZ7vb
	0JAT24NYVJwvOnl9bEwZeWthrKItt10lgP65/LIJKzboPpr96GXcw=
X-Google-Smtp-Source: AGHT+IEJrN3+Xz84SulzDfIciOJjJZgogpTlOlzimDxgN5DQZNhrRyWMLSpNLPzrSBpfR6FKNexDlA==
X-Received: by 2002:a05:6e02:348f:b0:430:9bc3:e1d3 with SMTP id e9e14a558f8ab-4320f7be914mr26591695ab.12.1761603876603;
        Mon, 27 Oct 2025 15:24:36 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f67dcb0csm35005605ab.5.2025.10.27.15.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 15:24:36 -0700 (PDT)
Message-ID: <ae92d3f4-5131-46be-b9b1-e8ec437c9ae9@riscstar.com>
Date: Mon, 27 Oct 2025 17:24:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: pci: spacemit: introduce PCIe host
 controller
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com, shradha.t@samsung.com,
 krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 namcao@linutronix.de, thippeswamy.havalige@amd.com, inochiama@gmail.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-4-elder@riscstar.com>
 <u53qfrubgrcamiz35ox6lcdpp5bbzfwcsic466z5r6yyx6xz3n@c64nw2pegtfe>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <u53qfrubgrcamiz35ox6lcdpp5bbzfwcsic466z5r6yyx6xz3n@c64nw2pegtfe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/25 11:38 AM, Manivannan Sadhasivam wrote:
> On Mon, Oct 13, 2025 at 10:35:20AM -0500, Alex Elder wrote:
>> Add the Device Tree binding for the PCIe root complex found on the
>> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
>> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
>> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
>> typically used to support a USB 3 port.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - Renamed the binding, using "host controller"
>>      - Added '>' to the description, and reworded it a bit
>>      - Added reference to /schemas/pci/snps,dw-pcie.yaml
>>      - Fixed and renamed the compatible string
>>      - Renamed the PMU property, and fixed its description
>>      - Consistently omit the period at the end of descriptions
>>      - Renamed the "global" clock to be "phy"
>>      - Use interrupts rather than interrupts-extended, and name the
>>        one interrupt "msi" to make clear its purpose
>>      - Added a vpcie3v3-supply property
>>      - Dropped the max-link-speed property
>>      - Changed additionalProperties to unevaluatedProperties
>>      - Dropped the label and status property from the example
>>
>>   .../bindings/pci/spacemit,k1-pcie-host.yaml   | 156 ++++++++++++++++++
>>   1 file changed, 156 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>> new file mode 100644
>> index 0000000000000..87745d49c53a1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>> @@ -0,0 +1,156 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-host.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SpacemiT K1 PCI Express Host Controller
>> +
>> +maintainers:
>> +  - Alex Elder <elder@riscstar.com>
>> +
>> +description: >
>> +  The SpacemiT K1 SoC PCIe host controller is based on the Synopsys
>> +  DesignWare PCIe IP.  The controller uses the DesignWare built-in
>> +  MSI interrupt controller, and supports 256 MSIs.
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: spacemit,k1-pcie
>> +
>> +  reg:
>> +    items:
>> +      - description: DesignWare PCIe registers
>> +      - description: ATU address space
>> +      - description: PCIe configuration space
>> +      - description: Link control registers
>> +
>> +  reg-names:
>> +    items:
>> +      - const: dbi
>> +      - const: atu
>> +      - const: config
>> +      - const: link
>> +
>> +  spacemit,apmu:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      A phandle that refers to the APMU system controller, whose
>> +      regmap is used in managing resets and link state, along with
>> +      and offset of its reset control register.
>> +    items:
>> +      - items:
>> +          - description: phandle to APMU system controller
>> +          - description: register offset
>> +
>> +  clocks:
>> +    items:
>> +      - description: DWC PCIe Data Bus Interface (DBI) clock
>> +      - description: DWC PCIe application AXI-bus master interface clock
>> +      - description: DWC PCIe application AXI-bus slave interface clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: dbi
>> +      - const: mstr
>> +      - const: slv
>> +
>> +  resets:
>> +    items:
>> +      - description: DWC PCIe Data Bus Interface (DBI) reset
>> +      - description: DWC PCIe application AXI-bus master interface reset
>> +      - description: DWC PCIe application AXI-bus slave interface reset
>> +      - description: Global reset; must be deasserted for PHY to function
>> +
>> +  reset-names:
>> +    items:
>> +      - const: dbi
>> +      - const: mstr
>> +      - const: slv
>> +      - const: phy
>> +
>> +  interrupts:
>> +    items:
>> +      - description: Interrupt used for MSIs
>> +
>> +  interrupt-names:
>> +    const: msi
>> +
>> +  phys:
>> +    maxItems: 1
>> +
>> +  vpcie3v3-supply:
>> +    description:
>> +      A phandle for 3.3v regulator to use for PCIe
> 
> Could you please move these Root Port specific properties (phy, vpcie3v3-supply)
> to the Root Port node?
> 
> Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml

OK, I'll try to follow what that ST binding does (and the
matching driver).

> For handling the 'vpcie3v3-supply', you can rely on PCI_PWRCTRL_SLOT driver.
I looked at the code under pci/pwrctrl.  But is there some other
documentation I should be looking at for this?

It looks like it involves creating a new node compatible with
"pciclass,0604".  And that the purpose of that driver was to
ensure certain resources are enabled before the "real" PCI
device gets probed.

I see two arm64 DTS files using it:  x1e80100.dtsi and r8a779g0.dtsi.
Both define this node inside the main PCIe controller node.

Will this model (with the parent pwrctrl node and child PCI
controller node) be used for all PCI controllers from here on?

Or are you saying this properly represents the relationship of
the supply with the PCIe port in this SpacemiT case?

>> +
>> +  device_type:
>> +    const: pci
>> +
> 
> This is part of the PCI bus schema itself.

That means I don't have to specify it here.  I'll remove it.
I will also remove it from the list of required properties.

>> +  num-viewport:
>> +    const: 8
>> +
> 
> This property has been deprecated in favor of driver auto-detecting the iATU
> regions.

Yes, that got removed in v3 of the series.

Thanks.

					-Alex

> 
> - Mani
> 


