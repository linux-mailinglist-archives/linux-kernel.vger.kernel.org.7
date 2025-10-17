Return-Path: <linux-kernel+bounces-857738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D38C8BE7D48
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EE819A2E37
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADA72E540B;
	Fri, 17 Oct 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLdYpYAG"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08392DFA28
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693706; cv=none; b=WFPQ4017bDqYQQQhjxPYdSvne7LfQmXVKpHsuhP4QSA0O7gY6Z7Si+h27AoZ5a6Y9WyN3O96R3zNZKScCoLxq/RsP/9tcXPtGSSC7J3TsANN9ruN9H+x2k8i8wsdeeVQc4ept+GdEUugtE5OoUT4NxhXlhdS558IZUN0OQZAXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693706; c=relaxed/simple;
	bh=xlVdMJZGBR8dYzgKO/sqP1AR71zVHST1qP49gR6hPGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6HzAbVhmXTBvhqFEpJpn+VGUlMHl0i5hOgcNen1P6CfK6JfsVkIUUmmJF8623gu9U9lDJ14ymR1Qcfh+EyUuLhJ9UU2Wg4Fo87J5XbBlzHH2CgzoIOygu15LQUyvgljTCp6QHWy+SBL2UiibQ8M9xbxnct1mDRist6/aGZkfc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLdYpYAG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so1403374a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760693704; x=1761298504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6sefhtiMhuuPq8nFOLwvYqf8fe7o6Hmrgpdt61rNn/I=;
        b=PLdYpYAGee76YNXTPXZxX46HxWhPj3fnKPlhf0zBvEPnLQ7+KQXXK42+YX0xiJ3WiO
         AsOb0eCM9Jmoy9vCxMy4RyThVjB3gIqgTwI0of0sQ+aVCmk5GL75MGmhkUHh6FMzKaX5
         GJQwPTku1Wjwv9KJaZy0w/y7Zd+6pp3/DiklJYpORlSch6ivOhz26zBZlBTsr8u1sntv
         Ay6tEpdfnoXF62c/E+d6I9RkpmnpurQ+57N1GqK31d183brPcC5HdXa/8e2dB+UbHFSr
         xYkXMyYHtxW7JYgtzHSvKxxoFGTwb0aK1dL2yZld47pDN8l/njllZDFgbuM/oJnBIVVq
         /8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760693704; x=1761298504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sefhtiMhuuPq8nFOLwvYqf8fe7o6Hmrgpdt61rNn/I=;
        b=dPJ7TBPwElyD8nbNjCfUfBmU11/CeN559o5jbbD7gf1X588RMFw75GbOh+eepLcgPu
         SsQWZEwl3NFAG0xpSt8YVTzQgghts8sfBXEAXeGiDiYUJgns+VScXlHkXIPgIYiVd03k
         7we+Gj7Y01Z9+3HpMqA8a2aIUDBj2C6oawkGd4YbuBDy16tPl37IQM1wfSdarT94HiWA
         yF75ndqedHCSAlgKNXbw4dLhR1ZbiUTrcas9Gl5EKjKtdpIIFddWujhyyK4EfBJpuw9h
         md7YqYdz02y/sJ5sIcwC709uSpIYWNC+PaER51+fvQ/MVka3+NPXGnBrZbAPE/pql3ub
         VE8w==
X-Forwarded-Encrypted: i=1; AJvYcCWsnFLDHSIy9yt2jAjZEgrh4+CAQISZ1E2cihOYwEnw6tsHNfCkhxO+Fy9/hR1fukajp1GkfymEhAaLzuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsxy+gUO0CQyyae7izw7oBZ6DjQqiO2E5Y/sdZv8XOvyO1NZa
	BPUYXDS+m/8iCKLGye/mbizWR8UxrubSJB6SzE3q635RGRcU8JTzyMsI
X-Gm-Gg: ASbGncuIkSeXCUvjxues0Ztez1g8AFel+U+J0YIvIBe9e1fGjZCmIS+JS9AixYRR+vm
	wvDNjQ6i5Yyfav7/8U/XVGMFzdyri3rHZroFSt/Fk3/2K+QHOJgpxG7NIe55mbvTXT0HfJIQX9N
	Fz66qVnM+TtEZt2zoW8GEIhV8ytZ/Q2CYCAdlFPPj9sR7gBEWk24DlICQqqUg+gUPol2dO1ylXX
	vQg0N4DMY1NEDHmEsB36lgD8xtX7bPBxlzPtjyDBAFk4eEh1nGmShj0dcu00K8+1yPaRzuqZ7Kr
	f0uuj06p0oF6v2HFtvwEvr0et+y9WrM7Il71YCCuqHF/qm3WZZNFWY13j/IWW8XPQepezEjVb/W
	RTs5DNmeLYStEXvRh+nr+lfSYJpXx0onpNPgVw2awI3Qs1rTfq1FouZzSQINg4M7C/LO0uD2q2H
	OF
X-Google-Smtp-Source: AGHT+IFZ4r5YhjGJi2lIzlRtB+okPhBm2JAHvMOho4Si8E/kA0x/N3K19f//5A+MqBicWT22P9DP/g==
X-Received: by 2002:a17:903:244b:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-290c9cb77d1mr36187715ad.18.1760693704058;
        Fri, 17 Oct 2025 02:35:04 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab4668sm57316645ad.90.2025.10.17.02.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:35:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:35:00 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Yixun Lan <dlan@gentoo.org>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Ze Huang <huangze@whut.edu.cn>, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 1/3] dt-bindings: soc: sophgo: add TOP syscon for
 CV18XX/SG200X series SoC
Message-ID: <ief5lt3mxa4epnlhwgsx7kvi556f3fo3gqff36hmzvitexlphx@ztpueijr5nb6>
References: <20251012022555.6240-1-looong.bin@gmail.com>
 <20251012022555.6240-2-looong.bin@gmail.com>
 <20251015134144.GA3265377-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015134144.GA3265377-robh@kernel.org>

On Wed, Oct 15, 2025 at 08:41:44AM -0500, Rob Herring wrote:
> On Sun, Oct 12, 2025 at 10:25:52AM +0800, Longbin Li wrote:
> > The Sophgo CV1800/SG2000 SoC top misc system controller provides register
> > access to configure related modules. It includes a usb2 phy and a dma
> > multiplexer.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Signed-off-by: Longbin Li <looong.bin@gmail.com>
> > ---
> >  .../soc/sophgo/sophgo,cv1800b-top-syscon.yaml | 59 +++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml
> > new file mode 100644
> > index 000000000000..d1993f2156b4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800b-top-syscon.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV18XX/SG200X SoC top system controller
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@outlook.com>
> > +
> > +description:
> > +  The Sophgo CV18XX/SG200X SoC top misc system controller provides
> > +  register access to configure related modules.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: sophgo,cv1800b-top-syscon
> > +          - const: syscon
> > +          - const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> 
> Also need 'ranges'
> 
> > +
> > +patternProperties:
> > +  "dma-router@154":
> 
> This allows 'foodma-router@154bar'. It's not a pattern as-is, but 
> generally we don't put fixed unit-addresses into the schema. So instead, 
> should be "^dma-router@[0-9a-f]+$".
> 
> > +    $ref: /schemas/dma/sophgo,cv1800b-dmamux.yaml#
> > +    unevaluatedProperties: false
> > +
> > +  "phy@48":
> 
> And similar here.
> 
> > +    $ref: /schemas/phy/sophgo,cv1800b-usb2-phy.yaml#
> > +    unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    syscon@3000000 {
> > +      compatible = "sophgo,cv1800b-top-syscon", "syscon", "simple-mfd";
> > +      reg = <0x03000000 0x1000>;
> > +      #address-cells = <1>;
> > +      #size-cells = <1>;
> 
> Please make the example complete with child nodes.
> 
> > +    };
> > +
> > +...
> > --
> > 2.51.0

Thanks, I will fix it.

longbin li

