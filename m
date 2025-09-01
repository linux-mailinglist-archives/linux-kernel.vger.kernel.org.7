Return-Path: <linux-kernel+bounces-794106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B46EB3DCF4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0837216CF9C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D9D2FE58D;
	Mon,  1 Sep 2025 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gOXNZahq"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB9C2FE06D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716495; cv=none; b=LEOnTEI0PS1+H5ONIA5sW4lRmdYCoZ09Jf2Lt0+5zML76raQO74qub6+Xvai5Dcing97T1Tw1lcUA2OSOhBGXB5wKAa3Zz4IgzlGakOF0foEwV5BlKg0l+W0ZE5YLoviFDdFu7YQjzhHn8eOL4pleV/B0r3J6CJadWauz+tJTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716495; c=relaxed/simple;
	bh=neeT00/mxDswioH9iJwGYH9YEmmlx3hZdCS21iYzw3g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR3lErqOP4vrt1ua/YfqzqwcsRD3IhrzOCBxKuP9uc9Ebcf9ibjDi+OuZ6Rh6Lvi99mS0Uh0xoAW3aR46b9W4mOhh74DRo7RUQXCL2cerOMuTLtjRkM42ddwK69PYgvYLidQI55tfQZZcZGmIZLKL671FZ1JCoBGgBrwusgvXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gOXNZahq; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-61caf8fc422so7271381a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756716490; x=1757321290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPLbjAvQn0E2rMIx0xgjNyYjUFJLwi35g9A0s0bGBYk=;
        b=gOXNZahqc4/88gy+ti8ZsBT/gDP8IScW79A02vQySTEvTkgkWhboJ0UZhgwtGhkHCS
         +WXyPOxgv629OG/nV4FVSm2s1exIb85VgKs8eVp2mFOyLlVKjSJAu0LAv/7fzRP6IP8b
         GNN0CGGM1n+gwaBUfsVoCXszehz8TgkwXUnBe0AtjCwq+yflBoI1Y6LryduMoyv3Tw6U
         lGa1JusV4S+vJOdNl43twFNhlysjC91np9qSQiMgNYBE+L2D0rM1W7okfwjpnZvDFdiK
         1BuImbzS1qJY5A3TIpRGmXtYMnebz0ZGrDzDeBOMFyO/U8S9zCol584WWBEMvVNtEhMt
         TqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756716490; x=1757321290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPLbjAvQn0E2rMIx0xgjNyYjUFJLwi35g9A0s0bGBYk=;
        b=T8l2h8QTDK9NBHxE0An+lIuaFFoYyngGuEjjjeZiAan20nbOCK7Ecyt765lw4m2CIL
         aYWx25u71mSUleie6ST4Hn24w11e98vI1VSNyLhUe2krfIElgBVfYC1qLstlFIXiPZha
         aJIFvrwOt1yPvtAS8my/zcwkRIgfBsC6qS0S3r7kwk83ARVwyyCWtmo8MSB/d2OJB8gd
         YRDakkm0r5hop4osmQgESlnn6dvrl67r6DdmOp7z193F+iTIRYyUL5UMweDEa3xJJu6J
         lzQFkiVTW9jxEGvwZeWExT5dspVwugNgy0pTFb/m1k78iASw8EqTX6tHT45k+Q45wmWe
         3tNA==
X-Forwarded-Encrypted: i=1; AJvYcCV/UBqtO258MDNMfcNcU3aM76y0+nrb3KrjtLLjylUQZvC6xKo3mxricX1SBcdxRcYfC9kSiiASsXe9iAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEzjZKOB0tKdZW4mjqba9QuzNczWW4mg7kgHLmJq/M1HenFg/
	EEx6aYFE78atnHHRjHIEkxKHul57CTOXRdcbJOcVIEM973BToLes8SHQlzWwjqlLrFs=
X-Gm-Gg: ASbGnctLmE89tKIargCVgYCtqDgtm74YZNwXukS9Fyu9T29oz4E7Q7YpE4k9lnw09yD
	JAuISyGUQu6ftA4rVg7T05euMiZ6zUI1AdHTGo+dB70dlkazEYNjQHqv3+3ajTcDZPJQYb0aDIv
	0XCwsjCDpemV8vDJMJVDTkU8RKDlqgNru2m2EjB794NhjHQio7mfKRlepCOXjGoDBgkTqvB/jgH
	DV7w9HCWBF02C98ZK7sOrDOXYWPyofg8KIOnLlDwCwlxPRyCYv5r3iFe0ldPjiHsxqNMb7DUJ3m
	BeudDt3IMicR1EpLarp3wR3z5O3nl5Bn6sr+gK1leoj/m9RMjlLJPKNBvNrVrHsi7IWe1NiViL4
	i8etN2+t4SRt87ScjUudW+E5sUzo8GGu6mh680FDg6dpSGLDZ8mBEy8oGiL14TM7BJRyfIVvUWQ
	UVuS8kF/l09oTic3YSHRUvIAtZUQw=
X-Google-Smtp-Source: AGHT+IEQBUXzLByR1LDYkZW1JXKHq8+bGwyDWqHROpCdMH+jh7ytpsNxmNwRf7WbZfZJa0YLFDJJBA==
X-Received: by 2002:a17:906:7d9:b0:b04:1b84:923c with SMTP id a640c23a62f3a-b041b85025emr362763666b.51.1756716490047;
        Mon, 01 Sep 2025 01:48:10 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04189de5b5sm345647166b.10.2025.09.01.01.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 01:48:09 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 1 Sep 2025 10:50:05 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kwilczynski@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iivanov@suse.de, svarbanov@suse.de,
	mbrugger@suse.com, Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dt-bindings: pci: brcmstb: Add rp1-nexus node to fix DTC
 warning
Message-ID: <aLVePQRfU4IB1zK8@apocalypse>
References: <20250812085037.13517-1-andrea.porta@suse.com>
 <4fee3870-f9d5-48e3-a5be-6df581d3e296@kernel.org>
 <aKc5nMT1xXpY03ip@apocalypse>
 <e7875f70-2b79-48e0-a63b-caf6f1fd287b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7875f70-2b79-48e0-a63b-caf6f1fd287b@kernel.org>

Hi Krzysztof,

On 08:50 Fri 22 Aug     , Krzysztof Kozlowski wrote:
> On 21/08/2025 17:22, Andrea della Porta wrote:
> > Hi Krzysztof,
> > 
> > On 10:55 Tue 12 Aug     , Krzysztof Kozlowski wrote:
> >> On 12/08/2025 10:50, Andrea della Porta wrote:
> >>> The devicetree compiler is complaining as follows:
> >>>
> >>> arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi:3.11-14.3: Warning (unit_address_vs_reg): /axi/pcie@1000120000/rp1_nexus: node has a reg or ranges property, but no unit name
> >>> /home/andrea/linux-torvalds/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@1000120000: Unevaluated properties are not allowed ('rp1_nexus' was unexpected)
> >>
> >> Please trim the paths.
> > 
> > Ack.
> > 
> >>
> >>>
> >>> Add the optional node that fix this to the DT binding.
> >>>
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>> Closes: https://lore.kernel.org/oe-kbuild-all/202506041952.baJDYBT4-lkp@intel.com/
> >>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
> >>>  1 file changed, 9 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>> index 812ef5957cfc..7d8ba920b652 100644
> >>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>> @@ -126,6 +126,15 @@ required:
> >>>  allOf:
> >>>    - $ref: /schemas/pci/pci-host-bridge.yaml#
> >>>    - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            const: brcm,bcm2712-pcie
> >>> +    then:
> >>> +      properties:
> >>> +        rp1_nexus:
> >>
> >> No, you cannot document post-factum... This does not follow DTS coding
> >> style.
> > 
> > I think I didn't catch what you mean here: would that mean that
> > we cannot resolve that warning since we cannot add anything to the
> > binding?
> 
> I meant, you cannot use a warning from the code you recently introduced
> as a reason to use incorrect style.
> 
> Fixing warning is of course fine and correct, but for the code recently
> introduced and which bypassed ABI review it is basically like new review
> of new ABI.
> 
> This needs standard review practice, so you need to document WHY you
> need such node. Warning is not the reason here why you are doing. If
> this was part of original patchset, like it should have been, you would
> not use some imaginary warning as reason, right?
> 
> So provide reason why you need here this dedicated child, what is that
> child representing.

Ack.

> 
> Otherwise I can suggest: drop the child and DTSO, this also solves the
> warning...

This would not fix the issue: it's the non overlay that needs the specific
node. But I got the point, and we have a solution for that (see below).

> 
> > 
> > Regarding rp1_nexus, you're right I guess it should be
> > rp1-nexus as per DTS coding style.
> > 
> >>
> >> Also:
> >>
> >> Node names should be generic. See also an explanation and list of
> >> examples (not exhaustive) in DT specification:
> >> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> > 
> > In this case it could be difficult: we need to search for a DT node
> 
> Search like in driver? That's wrong, you should be searching by compatible.

Thanks for the hint. Searching by compatble is the solution.

> 
> > starting from the DT root and using generic names like pci@0,0 or
> > dev@0,0 could possibly led to conflicts with other peripherals.
> > That's why I chose a specific name.
> 
> Dunno, depends what can be there, but you do not get a specific
> (non-generic) device node name for a generic PCI device or endpoint.

I would use 'port' instead of rp1-nexus. Would it work for you?

Many thanks,
Andrea

> 
> 
> 
> Best regards,
> Krzysztof

