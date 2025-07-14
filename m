Return-Path: <linux-kernel+bounces-729778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF18B03B69
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56FA4A00A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0F824337C;
	Mon, 14 Jul 2025 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UesJCFPR"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31224337B;
	Mon, 14 Jul 2025 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486795; cv=none; b=YLj4YyCoHMv9yyYiYUk7ph5pOCO2FpTF+F32su3ODtEHu8xorZhPfZpZMwy/V0pYCfGlFSTtgwxtGqLnM09y9ZaLkSpmzd8SOdguFLVBcejaXv1YCgcgs62RCBGbkHq1rkVtS0qxDqgctX/h0pKWb8Sz+uoza1Dqw6GCAcdsaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486795; c=relaxed/simple;
	bh=PHdSvfKIUGLUDdpokIaCFwY+t/iIxORZ+HDFbW5ngmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXvugd9UGpkvjhUwIhBaYfu0ve2aX83NYXZOYzzlqiLSR3ieCshF+DUxcMvQxSSToq3MMSIw4/kGJ81dmyNJb2ZlyX0fmyiJOWUAXmDNeJy3sGbJ6ZolcNV6g3t6VFmPfILpTnALLxRRUHZqpgVSb2JPTfsgZzWoigisFUyjh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UesJCFPR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso7818279a12.2;
        Mon, 14 Jul 2025 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752486792; x=1753091592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RNGssqJWYojAWdADXLp90CGwUVtfIpXi8sIRAMW1UaI=;
        b=UesJCFPRV2fPKb1Z8g4ldw38OQW9S9zHaIlfDY78NImji50+a7Dtq4QT7Nx5bWqx6z
         8g2oAtcsTMTVuxJT50gKyXjmRs5sQU2Be1bDZgZaBT0YiWhoLHFuay/ovIyUhWg3CX9C
         sNCdy0TzQzokbBJlRvRBpHL4Q+eqOnlL4poQT2ZshabapQR6PQ8b40kBNCnVKM6ngd5d
         cJgNAFUzpq+T4XJ0RpfyDz6mjbPIMLSuanKKBI9zxPC/zT+UbOGsLJGlIBDnymCTPmTR
         x6IW8imWFdW5M2rqk41GJmdOIOmN+h36k78Y7b8fdBDUSHWWi1i29cAGzrGWYYJKaV18
         F7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486792; x=1753091592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNGssqJWYojAWdADXLp90CGwUVtfIpXi8sIRAMW1UaI=;
        b=VbQFls59/6KVnxvWRWCXKFnlWOYBswfmBRj/qmHpqU5KGOyobvcYqh2N/mlZBcFP/9
         2ZzYeY1CdAFJ2GhWtU6RuF5HfJVHjniayqHVH1qjtAoBYasjOcRJu9euoS54Ze1P5SaO
         vnD9OHwrxr2KP7tGarVxYPcc7R1ImwxK5/mjGJ3ZGv/qNja1YiZC3GE6bJ9pOS1vemBd
         Jm0lF1UFD69j9EnKhCo3gFeY9GKklCsKfYlLYaVtQgXb6/cZfSvhrcT93SVzTOACGWzy
         p6NLfpyT0zZFkDi1+LILrvkdtErzNBa0PCVpmF3Q26PEN0odEQHMaqtib55Nk7/shdK8
         ohuw==
X-Forwarded-Encrypted: i=1; AJvYcCUA10BhXCbZztXZIp164IbMSDacuecZk+tocAf4iqb0Vqfxah5bU9bjssQpd7fHXADP3udx3uYAL97N@vger.kernel.org, AJvYcCVlZfVy9r3rcG604HcqWnw7rR4w7mL2oIjcJyrZ8HM/dCq00k/05De8SC3tUrrCYkGqY+DiU8C7odtH214P@vger.kernel.org
X-Gm-Message-State: AOJu0YxhH5Q47rpD7lojnmAesjBbr9gj+jeMPSwFHy2UnVwXM1sirZH8
	8u2ESZ6yCL1OVuddj6ouWP/m6MyS8kiZ+gjClrRofRbjZ3GhgebkZXB9
X-Gm-Gg: ASbGnctRbF5tqvwTBLs+wQ/AH7jjxIL/acMLQY5u9LUhdEmeF628FXdibbmNOaBOpbf
	vSJDJ2fbk4MVsQUNILwMTIi9p5+uoZvksSsIR05ovkpEVBvEsUR4LfrIPuaIUw0d59DGJ7BTb9n
	cixNz8F1dJ+OQr+uDhZx9/iHrFRESE1UbTBbg7TQLiY7JkPjCfZstU9ylUOr+V9AJ+3gOa3Vg1O
	XEPhDiG2n3zKjdH9WOlv3vDixXy7Qd0woSCYA4zk+lPxttbAbtJJ4YrdUReaVtWQrvAwPaaXFee
	qIYB5VErwqqh0bXgszzB86w/Ji+K/s5VNITe3fXRcS+oAEU0+QrPU8p0zVvL4I+Lqq8iZBUAU4K
	aqJwKiuYm0Rt7ARxyGzx2OnCLZkBRqiaRN70WZIprvw==
X-Google-Smtp-Source: AGHT+IFEDpClpXlaWllZOCERoY3lhQ4yIfuXZ4g3QSxGrrVJ8qXDMwIx0cCzdpXoL8/NvPGkH2XWPg==
X-Received: by 2002:a05:6402:210f:b0:607:f431:33fb with SMTP id 4fb4d7f45d1cf-611e761054cmr10942567a12.3.1752486791373;
        Mon, 14 Jul 2025 02:53:11 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c95232d8sm5823042a12.18.2025.07.14.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:53:10 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:53:07 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Devid Lechner <dlechner@baylibre.com>, Adrian Costina <adrian.costina@analog.com>, 
	Jorge Marques <jorge.marques@analog.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: i3c: Add adi-i3c-master
Message-ID: <tttx7nc4ribxmt73gu6n4r5rr2velypsublc2dlhdn6ltarthb@mllvjkkr5zn5>
References: <20250626-adi-i3c-master-v4-0-3846a1f66d5e@analog.com>
 <20250626-adi-i3c-master-v4-1-3846a1f66d5e@analog.com>
 <20250627-steadfast-ferret-of-expertise-5c8ff2@krzk-bin>
 <tl5fckhrivaqfyzwyb2o2a7gykpigwend7z2nduqgbbej3hqbs@vxxtsadhtdmt>
 <41782ded-908b-46ef-8f75-4d2565476b7c@kernel.org>
 <cfi6rzhco2ba6pcbk57l7tblimuks5jnpgaly7nbedbrpyhtma@u46if22kurwk>
 <v2ybju75bpjdqxfkell47nlkeyal36ylmnqt2yvpncxnmp2irb@pygx56jsyxkr>
 <20250702-armchair-favorite-c734b53444e2@spud>
 <pbaxwzj3gmjwkqbh32wfcac4zqjyg4sfkgit3hs6v372cxf3wa@kp5qg6m2tqlm>
 <20250711-eradicate-vendetta-ea6d44737e0c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-eradicate-vendetta-ea6d44737e0c@spud>

On Fri, Jul 11, 2025 at 05:28:57PM +0100, Conor Dooley wrote:
> On Fri, Jul 11, 2025 at 10:14:45AM +0200, Jorge Marques wrote:
> > On Wed, Jul 02, 2025 at 12:38:41PM +0100, Conor Dooley wrote:
> > > On Wed, Jul 02, 2025 at 12:58:00PM +0200, Jorge Marques wrote:
> > > > On Fri, Jun 27, 2025 at 06:02:26PM +0200, Jorge Marques wrote:
> > > > > On Fri, Jun 27, 2025 at 04:49:19PM +0200, Krzysztof Kozlowski wrote:
> > > > > > On 27/06/2025 16:38, Jorge Marques wrote:
> > > > > > > On Fri, Jun 27, 2025 at 08:56:55AM +0200, Krzysztof Kozlowski wrote:
> > > > > > >> On Thu, Jun 26, 2025 at 12:07:36PM +0200, Jorge Marques wrote:
> > > > > > >>> Add bindings doc for ADI I3C Controller IP core, a FPGA synthesizable IP
> > > > > > >>> core that implements the MIPI I3C Basic controller specification.
> > > > > > >>
> > > > > > >> How did you resolve my last comment? I don't see any explanation -
> > > > > > >> neither here nor in the binding description. Binding description is
> > > > > > >> actually better place, I think now.
> > > > > > >>
> > > > > > >> Best regards,
> > > > > > >> Krzysztof
> > > > > > >>
> > > > > > > 
> > > > > > > Hi Krzysztof,
> > > > > > > 
> > > > > > > I forgot to condense out discussion on v4.
> > > > > > > What about this binding description:
> > > > > > > 
> > > > > > >   description: |
> > > > > > >     FPGA-based I3C controller designed to interface with I3C and I2C
> > > > > > >     peripherals, implementing a subset of the I3C-basic specification.
> > > > > > >     The IP core is tested on arm, microblaze, and arm64 architectures.
> > > > > > >     It takes one or two clocks, axi and i3c. If only axi is provided,
> > > > > > >     then there is no clock signal to the i3c input clock pin and axi
> > > > > > 
> > > > > > This is obvious from the schema, drop.
> > > > > Ack.
> > > > > 
> > > > > > 
> > > > > > >     clock drives the whole IP. The compatible is suffixed by 1.00.a
> > > > > > >     foreseeing future controllers by Analog Devices Inc. and breaking
> > > > > > >     changes.
> > > > > > 
> > > > > > I don't understand that. How are you breaking any changes? And how
> > > > > > 1.00.a predicts future? I don't think this reflects previous discussion.
> > > > > > Why you were asked to go with v1.00.a?
> > > > > The -1.00.a suffix came from this discussion:
> > > > >   
> > > > >   https://lore.kernel.org/linux-i3c/ildi2pup2zkyv4stuknkrjysex3yzsbrrsrwbgcc4xgvdhwrdd@7qh4y6mutgy2/
> > > > > 
> > > > > Other adi bindings use this suffix. I personally wouldn't add any suffix
> > > > > unless told otherwise, as I expressed on the thread. Should I drop it?
> > > > > or suffix it with something else?
> > > 
> > > > 
> > > > I went after the reason of the historically -1.00.a suffix and
> > > > discovered that they came into existence due to AMD Xilinx auto
> > > > generation devicetree tool SDTGen
> > > > https://github.com/Xilinx/system-device-tree-xlnx
> > > > that would automatically suffix with the IP version, defaulting to 1.00.a,
> > > > and for a seamless experience, the were copied over to the dt-bindings.
> > > > 
> > > > The adi,axi-pwmgen dt-binding went more creative and suffixed with
> > > > -2.00.a, while never enforcing Vivado to yield the devicetree with such
> > > > value (Major version is asserted in the driver through reg access, the
> > > > current core version is v2.1.1)
> > > > 
> > > > Testing on my side (AMD Xilinx Vivado 2024.2), it seems Vivado now
> > > > defaults to 1.0, so the previous bindings from the other IPs are not
> > > > accurate anymore, either, (axi-pwmgen auto gens
> > > > `compatible = "xlnx,axi-pwm-gen-1.0";` (`xlnx` instead of `adi`, also)).
> > > > 
> > > > For fun, the current Vivado version thinks the devicetree node for the
> > > > i3c master should be as follows:
> > > > 
> > > >   i3c_host_interface: i3c_controller_host_interface@44a00000 {
> > > >           compatible = "xlnx,i3c-controller-host-interface-1.0";
> > > >           reg = <0x44a00000 0x10000>;
> > > >           clocks = <&clkc 15>;
> > > >           clock-names = "s_axi_aclk";
> > > >   };
> > > > 
> > > > Let me know if we can drop the suffix, or replace with something else.
> > > > The current register defined core version is v0.1.0.
> > > 
> > > Please, as I requested in the original thread, add versioning
> > > information. I'm clearly not asking you to make up some garbage version
> > > number, or to add "1.00a" if that's not an accurate version (and never
> > > did AFAICT). If 0.1.0 is the version of the IP core, I'd like you to use
> > > that.
> > > 
> > > If other ADI IP cores are using crap version numbers that came from
> > > some Xilinx tooling that don't represent the actual versions of the IPs,
> > > that's probably something you should mention to your colleagues that
> > > maintain those bindings.
> > 
> > 
> > My proposal (1) for the Analog Devices Inc. open source IP Cores is to
> > migrate to semantic versioning.
> > (1) https://github.com/analogdevicesinc/hdl/pull/1831
> > 
> > The dt-binding must end with the major value, with the first supported
> > version starting at 1. Therefore, the binding will be:
> > 
> > * adi,i3c-master-1
> > 
> > At driver level, the debug version value is `v%u.%u.%u`, and the driver
> > shall check the minor version value for handling feature changes. While
> > the major bump is restricted for breaking changes, which, in some cases,
> > also generates a new dt-binding.
> > 
> > For backwards compatibility, existing ADI IP Cores that prints `v%u.%u.%c`
> > should print `v%u.%u.%u` instead, but keep their current value (e.g.,
> > `a`->`97`), until the minor is bumped, when the patch version resets to 0.
> > 
> > Rework across register accessed IPs is being handled here:
> > https://github.com/analogdevicesinc/hdl/pull/1829
> > There are more than 50 IPs with register access, so I need to be cautious.
> > 
> > What is your take on this? Does it resolve the bindings concern?
> 
> I think it is a good idea to establish version numbers that actually
> have a meaning, rather than using something garbage. I think you should
> probably put the "v" into the number in the compatible - 1.00 or 1.00.a
> is fairly clearly a version number but "-1" is less clear.
>
Hi Conor,

The format that is currently winning my internal discussion is
`adi,<ip-name>-v<major>`.
And the next patch will be submitted as `adi,i3c-master-v1`.

> Also "the binding must end with the major value" is a bit of an odd
> requirement I think. The sort of situations that may cause different
> compatibles to be introduced are not likely to be restricted to majors.

sifive-blocks-ip-versioning.txt uses
"sifive,<ip-name><integer-version-number>", While the xilinx.txt uses
the last version that uses the same interface. Both implicitly hide away
features (minor) and fixes (patches). What I am enforcing is that, if
the interface changes, the major field must be bumped. In most cases,
everything else is minor matching at the driver level, and if exceptions
occur, add to the commit message the justification and that's it.

> That may be something like properties only valid for some versions, or
> at worst a bug that requires checking the compatible (even if these
> are much rarer when there's a version register, they're still possible).
>
> IDM what number you opt for in the end either, it could well just be the
> lowest number where the current register offset/format for the version
> number register exists.
>
> It's a bit hypocritical of me to ask this, since I have not yet written
> one for the Microchip stuff - but I think you should document whatever
> numbering you end up on, like in xilinx.txt and
> sifive-blocks-ip-versioning.txt, so that we can point people at it.

Best regards,
Jorge
> >
> > Adding David to the thread, since the axi-spi-engine already moved to
> > `v%u.%u.%u` format.
> >
> > Best regards,
> > Jorge
> >

