Return-Path: <linux-kernel+bounces-727149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B00BB015BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C7A160BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990772248B5;
	Fri, 11 Jul 2025 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM0sSnFU"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC7A223DC1;
	Fri, 11 Jul 2025 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221693; cv=none; b=a2bO0c3MTuKr1jGxJlNrbxagTMuZ/Ca0aHChG5hNbxmDwGeQI/70+DzXIldLcWKNZ4as0s33xSExf847WstsB2SvLnuRphFcnbPYp3/9N3xBWt0zQ7kOWH8wOm6sCQmalNqVnDMwqKhX0ud7mACJ2E9NWWgfL7Hqn2pmnM/sH5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221693; c=relaxed/simple;
	bh=Y0oDuPLEvWHeScaE10zj5AemVy9H1VdzF/iQh/xEHWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugGsXBB/99iU5igpz8mNG/RZyTPjVBTpsu7SX9gu2fEhSAengUv9KqM6+6SSwEPINJqxHX2I2chSXptdpxaAv0mf+90wLC0K7ahYGAp0uh0hfUatqIYMYHckdFR5g25WA1tnJen2p/6Hi7rspV2q01QkpkPQVMnTGbH0tZJDVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM0sSnFU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so2984958a12.3;
        Fri, 11 Jul 2025 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752221690; x=1752826490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3aTSZfQu30nYtUNf/QLsa8512IXt+B0u0txxktETggs=;
        b=lM0sSnFU4sJo3DkwP96+dWDWiM61oERMDL9jPqmnwrTyN6OoUedYsTOoWI/1n0bWta
         IBwoc/Nj4LMOHpXCdekbYOat/VNnz0vePK6vHf8ldShm/pfVMPkBSz1Q2axS6Fj5q2AG
         gR25F0BW0wne6qoNUaIVE9GBTKoadOXNCP0zCF4+7Apz7H3660SQv2vt0aVxzBBLkQR1
         BMpmG9kzHaJoGfF+gZ+EDkGFRDvPiF3McbqQB0eE8PZj21j4dz+gTY0R0uVFPCDIMOiT
         L0Glo76g5qBrBxnxqr9+w3sqGJRjiCpNQ7ecEXGNm/yldtGxkBM1nUz+Rr9L3s4fV66u
         I2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752221690; x=1752826490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aTSZfQu30nYtUNf/QLsa8512IXt+B0u0txxktETggs=;
        b=hxSwb296o2XWVCjKtO8EHJEldFoK+B6oYrDEQDfVmSeWXpMEZ8gX+49RvoSDvfC/7q
         5ZyYnQAmx4G3dZq/lXQhJSp2dYEk07ySWvnUzQFK5ycohMniAvgB0bQcH2rhJMitQhUU
         9JnkmsPrOJX0JGKVApvjlti3n4WXGyEIEJM8+xjHZJ2MlhhkmLzcK7Jc3j/aachNapHi
         pzba53W9TYqw99fkK1D/C9exid0SuvuRDzHBAByMAb/PEA6JgvYo9QlbV6oad2SFFSrw
         sOf/8L8OSIyvdcyZG4VAjhITidr39FIaS4x0nE1BTquRaaik9VYA4IzP7Pp0HinQrS/b
         2T3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/R1ImI8WfpizhKRkFzYWxgaWgUDK1urkPqhUosvT1d9I1lV+A+0xpYMmIVU/mIgIQOg/GsYRFP1RL@vger.kernel.org, AJvYcCV7tpPdLu6H7/Eo/y8Rkre0byo+4ZmqugrI/Rg6VFzMNoiQOE/cTsMeYDsiTyiMe1scrSEl/KJ1q7vjZSt4@vger.kernel.org
X-Gm-Message-State: AOJu0YzqG7TsOfmSEtP2TVi2X81b1u1jFtO8IAjjMyKyF3k9dF3mbLF4
	uBOHnmDbjarnRybhfUcjXrh7Ta16eD4+DHODYS1MdZHDp/hIPkaTekLe
X-Gm-Gg: ASbGncs2/68Q4OAGsKbyCImcYiw4ChHlTUrlxx+8Pl/BewJC7p88qEXiMFp/vGEDVz2
	VPMSjKvFDVIAkdgowrHf0Klya9m7/eiSuiOOZXnGDwaNzl/YyI+uUIlH6CYNxGHNkTkC5qa6nuZ
	sIUjCeZOGo4Gv8QvO2TihaJOcTZbFNWnQQWlDoj4RnIJkGSOxwdLO0DtUmvNQXO42oAe7E/WHZP
	9kXTsM6cdF/Tdx1peWQ7Zm5ckhLrCIqSb5hEMQ6WGEmNEGNNtIMVrL8KEphtp8Ridyrg6esfJMK
	KnSNRaNR9weo6WwvFjdq1INZc2c3S+WMzebzC/YP28mmQKw4wzfwpO0iUb7VsG+3ZlG1QdpZf3Y
	dIaUQ5fWmzw9IwTYgtVVQbEw+96fiyk4P9ymkrKF7WBE=
X-Google-Smtp-Source: AGHT+IE7tGsdW3nPobnCtRjN6yH4ugFfWzOhdS2yH9B0+mLBkpnzOK2yGgLvm6mdMcFYbZvxYHDxPQ==
X-Received: by 2002:aa7:c3d1:0:b0:604:e33f:e5c0 with SMTP id 4fb4d7f45d1cf-611e84e6128mr1445622a12.30.1752221689856;
        Fri, 11 Jul 2025 01:14:49 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9528b05sm1875104a12.30.2025.07.11.01.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 01:14:49 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:14:45 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Devid Lechner <dlechner@baylibre.com>, Adrian Costina <adrian.costina@analog.com>, 
	Jorge Marques <jorge.marques@analog.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: i3c: Add adi-i3c-master
Message-ID: <pbaxwzj3gmjwkqbh32wfcac4zqjyg4sfkgit3hs6v372cxf3wa@kp5qg6m2tqlm>
References: <20250626-adi-i3c-master-v4-0-3846a1f66d5e@analog.com>
 <20250626-adi-i3c-master-v4-1-3846a1f66d5e@analog.com>
 <20250627-steadfast-ferret-of-expertise-5c8ff2@krzk-bin>
 <tl5fckhrivaqfyzwyb2o2a7gykpigwend7z2nduqgbbej3hqbs@vxxtsadhtdmt>
 <41782ded-908b-46ef-8f75-4d2565476b7c@kernel.org>
 <cfi6rzhco2ba6pcbk57l7tblimuks5jnpgaly7nbedbrpyhtma@u46if22kurwk>
 <v2ybju75bpjdqxfkell47nlkeyal36ylmnqt2yvpncxnmp2irb@pygx56jsyxkr>
 <20250702-armchair-favorite-c734b53444e2@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-armchair-favorite-c734b53444e2@spud>

On Wed, Jul 02, 2025 at 12:38:41PM +0100, Conor Dooley wrote:
> On Wed, Jul 02, 2025 at 12:58:00PM +0200, Jorge Marques wrote:
> > On Fri, Jun 27, 2025 at 06:02:26PM +0200, Jorge Marques wrote:
> > > On Fri, Jun 27, 2025 at 04:49:19PM +0200, Krzysztof Kozlowski wrote:
> > > > On 27/06/2025 16:38, Jorge Marques wrote:
> > > > > On Fri, Jun 27, 2025 at 08:56:55AM +0200, Krzysztof Kozlowski wrote:
> > > > >> On Thu, Jun 26, 2025 at 12:07:36PM +0200, Jorge Marques wrote:
> > > > >>> Add bindings doc for ADI I3C Controller IP core, a FPGA synthesizable IP
> > > > >>> core that implements the MIPI I3C Basic controller specification.
> > > > >>
> > > > >> How did you resolve my last comment? I don't see any explanation -
> > > > >> neither here nor in the binding description. Binding description is
> > > > >> actually better place, I think now.
> > > > >>
> > > > >> Best regards,
> > > > >> Krzysztof
> > > > >>
> > > > > 
> > > > > Hi Krzysztof,
> > > > > 
> > > > > I forgot to condense out discussion on v4.
> > > > > What about this binding description:
> > > > > 
> > > > >   description: |
> > > > >     FPGA-based I3C controller designed to interface with I3C and I2C
> > > > >     peripherals, implementing a subset of the I3C-basic specification.
> > > > >     The IP core is tested on arm, microblaze, and arm64 architectures.
> > > > >     It takes one or two clocks, axi and i3c. If only axi is provided,
> > > > >     then there is no clock signal to the i3c input clock pin and axi
> > > > 
> > > > This is obvious from the schema, drop.
> > > Ack.
> > > 
> > > > 
> > > > >     clock drives the whole IP. The compatible is suffixed by 1.00.a
> > > > >     foreseeing future controllers by Analog Devices Inc. and breaking
> > > > >     changes.
> > > > 
> > > > I don't understand that. How are you breaking any changes? And how
> > > > 1.00.a predicts future? I don't think this reflects previous discussion.
> > > > Why you were asked to go with v1.00.a?
> > > The -1.00.a suffix came from this discussion:
> > >   
> > >   https://lore.kernel.org/linux-i3c/ildi2pup2zkyv4stuknkrjysex3yzsbrrsrwbgcc4xgvdhwrdd@7qh4y6mutgy2/
> > > 
> > > Other adi bindings use this suffix. I personally wouldn't add any suffix
> > > unless told otherwise, as I expressed on the thread. Should I drop it?
> > > or suffix it with something else?
> 
> > 
> > I went after the reason of the historically -1.00.a suffix and
> > discovered that they came into existence due to AMD Xilinx auto
> > generation devicetree tool SDTGen
> > https://github.com/Xilinx/system-device-tree-xlnx
> > that would automatically suffix with the IP version, defaulting to 1.00.a,
> > and for a seamless experience, the were copied over to the dt-bindings.
> > 
> > The adi,axi-pwmgen dt-binding went more creative and suffixed with
> > -2.00.a, while never enforcing Vivado to yield the devicetree with such
> > value (Major version is asserted in the driver through reg access, the
> > current core version is v2.1.1)
> > 
> > Testing on my side (AMD Xilinx Vivado 2024.2), it seems Vivado now
> > defaults to 1.0, so the previous bindings from the other IPs are not
> > accurate anymore, either, (axi-pwmgen auto gens
> > `compatible = "xlnx,axi-pwm-gen-1.0";` (`xlnx` instead of `adi`, also)).
> > 
> > For fun, the current Vivado version thinks the devicetree node for the
> > i3c master should be as follows:
> > 
> >   i3c_host_interface: i3c_controller_host_interface@44a00000 {
> >           compatible = "xlnx,i3c-controller-host-interface-1.0";
> >           reg = <0x44a00000 0x10000>;
> >           clocks = <&clkc 15>;
> >           clock-names = "s_axi_aclk";
> >   };
> > 
> > Let me know if we can drop the suffix, or replace with something else.
> > The current register defined core version is v0.1.0.
> 
> Please, as I requested in the original thread, add versioning
> information. I'm clearly not asking you to make up some garbage version
> number, or to add "1.00a" if that's not an accurate version (and never
> did AFAICT). If 0.1.0 is the version of the IP core, I'd like you to use
> that.
> 
> If other ADI IP cores are using crap version numbers that came from
> some Xilinx tooling that don't represent the actual versions of the IPs,
> that's probably something you should mention to your colleagues that
> maintain those bindings.


Hi Conor,

My proposal (1) for the Analog Devices Inc. open source IP Cores is to
migrate to semantic versioning.
(1) https://github.com/analogdevicesinc/hdl/pull/1831

The dt-binding must end with the major value, with the first supported
version starting at 1. Therefore, the binding will be:

* adi,i3c-master-1

At driver level, the debug version value is `v%u.%u.%u`, and the driver
shall check the minor version value for handling feature changes. While
the major bump is restricted for breaking changes, which, in some cases,
also generates a new dt-binding.

For backwards compatibility, existing ADI IP Cores that prints `v%u.%u.%c`
should print `v%u.%u.%u` instead, but keep their current value (e.g.,
`a`->`97`), until the minor is bumped, when the patch version resets to 0.

Rework across register accessed IPs is being handled here:
https://github.com/analogdevicesinc/hdl/pull/1829
There are more than 50 IPs with register access, so I need to be cautious.

What is your take on this? Does it resolve the bindings concern?

Adding David to the thread, since the axi-spi-engine already moved to
`v%u.%u.%u` format.

Best regards,
Jorge


