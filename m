Return-Path: <linux-kernel+bounces-780149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F179B2FE25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B62E7B8A58
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB9027587C;
	Thu, 21 Aug 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dDcO1J2S"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278792701C3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789617; cv=none; b=MCpIudgf+FalxLzXaeYqU/5ipJpe2IQhgGsD++6iLrf6vkM3/+NqMy9CAmkEBNWLyteLaG/7S6wXFmr8yAcfMxFNPrlH5K3QJBabVV0cMlnyMZQ6N0qAQ0+TsjX0nf+nVWuAlLGif1Mm/rzQrZMKJQZVD1c5pPBxuGTn81ZvJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789617; c=relaxed/simple;
	bh=F/EjgN8PLsBzT6JEQmm+8aj3BN2j2mJJkwSmhkAXh0I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meXSISGT++Ih18/BtifnZ7Ji9EyAQFg1AQFUf3WHJ7VPQIXuVl/uQZe4g9dYaSFGgjSxLkUyKgv+Ka4gKAFMR5i0Suoa+3L0t24t1tlAm+AcfGAlSyyb2Wr6naQVto38h9u63RmqfG+IJBRujdWrWuMgTDDJOa6HYt6RgZsSqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dDcO1J2S; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3bb30c72433so400978f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755789613; x=1756394413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNeH8jwIaMIahWPVnKl5loQQejVbwxs7rBb60S32DBI=;
        b=dDcO1J2Sw9jvCB6JCNEkNmbqBmhGzvnkmZi2po8Yyp7odu3Wvb39Oh7V5Q9nVPVBa8
         OMDf21pkw+c6hIBWwnzgAubteTV8449tt+wSXY84hzK57qhMz5aWDuURuJfdCOODKbmr
         jB/wtQltgD4pWle0zAf+fXQQM5SmHyCckKFLeQJmHhLoi6F90wdiM0cQqczQww1TrL6n
         HRogoYhTXEs3jWXMJH10dL4xikiGzOBTbLF+bdaaUWdi3lGQqtZSOpvNTRx/dkfEQOno
         SmsykhptCJrk7813Ygs57sbu+ef+DXlTEeb5hDPTUAUwFher+CwM2l/mWiP2cpHg8jxQ
         U+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755789613; x=1756394413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNeH8jwIaMIahWPVnKl5loQQejVbwxs7rBb60S32DBI=;
        b=pXmCche86P4S8h6aC7WPO9nhFOJ/vkb5x6/sHB52WmW4LK/bzOjA4932fH8YePrH3g
         iIjoqNtyDvoHIN9qVRYgAuRWeQrWn5l9ocA6rJSdMZR6qxEQKOrWWLHnNR5N5iQpk8b3
         WtZKXkBsCvY4PDQwKOmIDlS3m3sXPamJ9n4cdQQfI3x2G1uG8vVKgIxAtegfjqVY2eBV
         EMBB3SivYs2qJSVIsBemB/V49+KQU/EiTVbAApMWf+krTHW2Rp2xR7figwTCA+m2ZaoR
         cNkLmdk0q++SGXTAYvIJ3g1xxgEB6oq89aF/eIGs35QQVgqLa2uDhtJa0DUM+M2ig+cT
         pe0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEq+x3L21vlG+vQHWtlEI2wVHBjyKjdlCA36eigN3ItI3L7ASWFKYMIQFzTxlWtdYs9h7RCRwFK3mpkaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytYNInR9oBHvZCdcOqVZ6BwlC2ZxAosHS4teQ3xE2pdxDIo00v
	VpYeCjN8GDLCPBS19yjvdP4ND2FP0fZ8oTTh1vanpY9+ZKWUsh33naC11mIOPWOUbuI=
X-Gm-Gg: ASbGncv5aSkWbXXKzcdDhzpgcS/is5OL291cXzitzvM1gGLlGkzoYXKTAiWEyx+m0sS
	gJwqehdfBc2p/SreHHPSeLzNCPzTe9ME0u6lv0qTmMaP9pkE4QXtK8E8nnwDJrL47Em2r8ij7Fk
	aP17Y2SlUE1nPD5kDKDD4B/HkqLm9Se/3N98EijcH+/Z2b05QZ3/Ky2PCkueBC3VpxqvFrNoCPv
	u1PcwmlkLTex9/y/bU7PlAjS9SGijrQ8F+/yntns77UbHEhcD0miSHWe/xuZmfCmlh1Hyu4rXkT
	H13VESGEzY4sbq6AlLNPuntdYmkk1XR6MjItFsmysEIDOwCz339azzvXfifFcycvMrtOHIaYCK1
	cmkLPNCKllMsI0daIijxqzwGBXlelNi3+Vw+dJdq1wjJ4DiVa8v69dD6OVwsD9GdU/Y3PCu4=
X-Google-Smtp-Source: AGHT+IHDN8OczdJt+JNi7lF2guoFhCWb2f4SvtjNNXIrg4sA//TwST6NTNw7zh3uRT3ZYvRmUOk3qA==
X-Received: by 2002:a05:6000:288b:b0:3b8:893f:a17d with SMTP id ffacd0b85a97d-3c497274347mr2450727f8f.49.1755789613394;
        Thu, 21 Aug 2025 08:20:13 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9077520sm105918256d6.21.2025.08.21.08.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:20:12 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 21 Aug 2025 17:22:04 +0200
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
Message-ID: <aKc5nMT1xXpY03ip@apocalypse>
References: <20250812085037.13517-1-andrea.porta@suse.com>
 <4fee3870-f9d5-48e3-a5be-6df581d3e296@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fee3870-f9d5-48e3-a5be-6df581d3e296@kernel.org>

Hi Krzysztof,

On 10:55 Tue 12 Aug     , Krzysztof Kozlowski wrote:
> On 12/08/2025 10:50, Andrea della Porta wrote:
> > The devicetree compiler is complaining as follows:
> > 
> > arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi:3.11-14.3: Warning (unit_address_vs_reg): /axi/pcie@1000120000/rp1_nexus: node has a reg or ranges property, but no unit name
> > /home/andrea/linux-torvalds/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@1000120000: Unevaluated properties are not allowed ('rp1_nexus' was unexpected)
> 
> Please trim the paths.

Ack.

> 
> > 
> > Add the optional node that fix this to the DT binding.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202506041952.baJDYBT4-lkp@intel.com/
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index 812ef5957cfc..7d8ba920b652 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -126,6 +126,15 @@ required:
> >  allOf:
> >    - $ref: /schemas/pci/pci-host-bridge.yaml#
> >    - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: brcm,bcm2712-pcie
> > +    then:
> > +      properties:
> > +        rp1_nexus:
> 
> No, you cannot document post-factum... This does not follow DTS coding
> style.

I think I didn't catch what you mean here: would that mean that
we cannot resolve that warning since we cannot add anything to the
binding?

Regarding rp1_nexus, you're right I guess it should be
rp1-nexus as per DTS coding style.

> 
> Also:
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

In this case it could be difficult: we need to search for a DT node
starting from the DT root and using generic names like pci@0,0 or
dev@0,0 could possibly led to conflicts with other peripherals.
That's why I chose a specific name.

Many thanks,
Andrea

> 
> ... and nodes should be anyway defined in top-level and only customized
> per variant. I am surprised that DTS patch carries a reviewed tag,
> because it was never checked/tested :/
> 
> > +          $ref: /schemas/misc/pci1de4,1.yaml
> >    - if:
> >        properties:
> >          compatible:
> 
> 
> Best regards,
> Krzysztof

