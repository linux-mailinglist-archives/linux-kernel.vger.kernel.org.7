Return-Path: <linux-kernel+bounces-745238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38304B1170D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B5217C945
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D41C239E61;
	Fri, 25 Jul 2025 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f61OXOAU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32886329;
	Fri, 25 Jul 2025 03:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753413949; cv=none; b=kcyz5jMOUP7ARtH8CgPcYX1wk7nDUQQISV9Zlg0izCQGCIRVmg/uv+BK8oJ7FnDT4GlFojg7s7VBNbgsJuowcK9tGZZpyUD6Kf3XyfLI84mmgA2Y8UI7QqF0EieI9pF1oYpWSW2WDCkG71bs2lMXq7rXo6rx3GTr+wCAwo8AyYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753413949; c=relaxed/simple;
	bh=ru9P5gglzGYtzMPAbAWQEENrZ3jfJKcYTMOz5gRV4B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Juine4t37NzlxbHUkQDHene6CnEN870LT5bV0YO7kUe6bCfZhqc1iF8jcD+b/K77okhKCvO+0zLz3+iPvY4MekrU0oTwjCRxbPIWZH1W0JwZTfxlhagqGsDLhQqdTARDHX8E8VGTnblXIF8HdG6HSUQ9K4XnxzUbS+1MCb+0ixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f61OXOAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA87C4AF09;
	Fri, 25 Jul 2025 03:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753413948;
	bh=ru9P5gglzGYtzMPAbAWQEENrZ3jfJKcYTMOz5gRV4B8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f61OXOAUm4yu2i5SKlz1YbYUB/BJzT9xGyvRxuVAGpzMT2tDvuopfOeA2lt2AJq6H
	 GO4hFY30r+74hR2G6F1XglBB81gpeoJv2ezLyr3gHTupBauZk+ZMyCnNK3VDLhnmgY
	 iqSA96N4PdCN4z5WsILRSnOIUkBfXE9inizK0EMdnUUJJVzQn31X/Z0jEEZ0GqXylq
	 hpTa7KIZx40iC5g/mqrezzq6hIPhAPalha6Qwd/GSO48LT6tOEssoSgsOGgqQEgqn2
	 IcjNnUWy7jdVo9bZy9l0hAH9cGAGoxbgroTuketDtkWr3xHc6pI7jl1FFrnXOqp5Gw
	 1kRRq6HqJAjdw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so250037266b.2;
        Thu, 24 Jul 2025 20:25:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkyPy741j0w6vkWFJIZsKJUNbRhrdbdkoVDriJZFzIGe9QRDVbxVmEjOUQUqANVxLaaTd3DZDoQPbgOWPl@vger.kernel.org, AJvYcCX8ivvavbwYGagMYryqyBBwrW8OzL0BD4GzYkGgnNqBXrsK9u0A+zj7K8lfJuK8exINpNxBul9XsnsT@vger.kernel.org
X-Gm-Message-State: AOJu0YxSP2NCENDzbNloDF5LgTRmW2ld7+SWCsi4aswfj85gHbdYKnqL
	5IjJ64dqkGR3oTkfldpjnPCS8SSGN6Q+1bh5FezqU8D13YD4GlfVKYwXk8XW+25LXVkJXsa8f1v
	kLlEGGtauG3WJ14ar9ErUfH7lVGWulw==
X-Google-Smtp-Source: AGHT+IF+agF7WZFSJUlrP9ySUL34Tt9kNJbk0LHlMHXBUQFUAyaxgmcWaEQcfUno6qyj6AQ9mOBZFrHznA/URFmzSWo=
X-Received: by 2002:a17:907:8691:b0:ae3:7113:d6f1 with SMTP id
 a640c23a62f3a-af61cf9830fmr42823366b.25.1753413947121; Thu, 24 Jul 2025
 20:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723222350.200094-1-donalds@nvidia.com> <175341328135.3754696.5873094296930738476.robh@kernel.org>
In-Reply-To: <175341328135.3754696.5873094296930738476.robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 24 Jul 2025 22:25:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJwgbWa0sPVgdxMchPfa1hR8o-=wRh4UgoK3QfDdW+S+g@mail.gmail.com>
X-Gm-Features: Ac12FXzNXNpCRi5fyD7BKC9WuufjuvbhZvOU4OiUZdjanN-WVw0Xe6BrUFww0vw
Message-ID: <CAL_JsqJwgbWa0sPVgdxMchPfa1hR8o-=wRh4UgoK3QfDdW+S+g@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Adding device tree and binding for NVIDIA GB200-UT3.0b
To: Donald Shannon <donalds@nvidia.com>
Cc: conor+dt@kernel.org, openbmc@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	krzk+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 10:19=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:
>
>
> On Wed, 23 Jul 2025 15:23:48 -0700, Donald Shannon wrote:
> > Patch 1 adds the binding for the NVIDIA GB200-UT3.0b platform.
> > Patch 2 adds the device tree for the NVIDIA GB200-UT3.0b platform.
> >
> > This is an Aspeed AST2600 based unit testing platform for GB200.
> > UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
> > differences, additional gpio expanders, and voltage regulator gating
> > some devices.
> >
> > Reference to Ast2600 SOC [1].
> > Reference to Blackwell GB200NVL Platform [2].
> >
> > Link: https://www.aspeedtech.com/server_ast2600/ [1]
> > Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 =
[2]
> > Signed-off-by: Donald Shannon <donalds@nvidia.com>
> > ---
> > Changes v1 -> v2:
> >   - Changed phy-mode to rgmii-id [Lunn]
> >   - Removed redundant max-speed for mac0 [Lunn]
> >   - Fixed typo from gb200nvl to gb200 in Makefile
> > Changes v2 -> v3:
> >  - Fixed whitespace issues [Krzysztof]
> >  - Fixed schema validation issues from my end ( there are still issues
> >  with the aspeed dtsi file that are not related to this new dts)
> >  [Herring]
> >  - Reordered to follow style guide [Krzysztof]
> >  - Removed redundant status okays
> >  - Changed vcc to vdd for the power gating on the gpio expanders
> > Changes v3 -> v4:
> >   - Added changelog [Krzysztof]
> >   - Added nvidia,gb200-ut30b board binding [Krzysztof]
> >   - Removed unused imports
> >   - Reordered a couple other style guide violations
> >   - Added back in a couple needed "status okay"s
> > Changes v4 -> v5:
> >  - Resumed my patch after a pause
> >  - Don't plan to make this include of nvidia-gb200nvl-bmc due to some
> >  platform differences
> >  - Fixed io expanders that weren't gated by the 3.3V standby regulator
> >  - Fixed incorrect interrupt pin for one IO expander
> >  - Removed some IO expanders and I2C busses
> > Changes v5 -> v6:
> >  - Fixed subject line
> >  - Added missing gpio-key compatible type to buttons
> > Changes v6 -> v7:
> >   - Removed Acked-by Krzysztof
> > ---
> >
> > Donald Shannon (2):
> >   dt-bindings: arm: aspeed: Add NVIDIA GB200-UT3.0b  board
> >   ARM: dts: aspeed: Add NVIDIA GB200 UT3.0b board
> >
> >  .../bindings/arm/aspeed/aspeed.yaml           |    1 +
> >  arch/arm/boot/dts/aspeed/Makefile             |    1 +
> >  .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts  | 1028 +++++++++++++++++
> >  3 files changed, 1030 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut=
30b.dts
> >
> >
> > base-commit: 05adbee3ad528100ab0285c15c91100e19e10138
> > --
> > 2.43.0
> >
> >
> >
>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>   pip3 install dtschema --upgrade
>
>
> This patch series was applied (using b4) to base:
>  Base: using specified base-commit 05adbee3ad528100ab0285c15c91100e19e101=
38
>
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
>
> New warnings running 'make CHECK_DTBS=3Dy for arch/arm/boot/dts/aspeed/' =
for 20250723222350.200094-1-donalds@nvidia.com:
>
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: timer (arm,ar=
mv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/timer/arm,arch_tim=
er.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /sdram@1e6e00=
00: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac=
', 'syscon']
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: bus@1e600000 =
(aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too=
 long
>         from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600=
-ahbc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: syscon@1e6e20=
00 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes=
: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(=
@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
>         from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00=
-scu.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/sysc=
on@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['a=
speed,ast2600-smpmem']
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/disp=
lay@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-=
gfx', 'syscon']
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: adc@1e6e9000 =
(aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pi=
nctrl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast=
2600-adc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: adc@1e6e9100 =
(aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pi=
nctrl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast=
2600-adc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: crypto@1e6fa0=
00 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: =
'^pinctrl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2=
600-acry.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: lpc@1e789000 =
(aspeed,ast2600-lpc-v2): reg-io-width: 4 is not of type 'object'
>         from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yam=
l#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: lpc@1e789000 =
(aspeed,ast2600-lpc-v2): lpc-snoop@80: 'clocks' does not match any of the r=
egexes: '^pinctrl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yam=
l#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: kcs@24 (aspee=
d,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctr=
l-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast240=
0-kcs-bmc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: kcs@28 (aspee=
d,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctr=
l-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast240=
0-kcs-bmc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: kcs@2c (aspee=
d,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctr=
l-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast240=
0-kcs-bmc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: kcs@114 (aspe=
ed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinct=
rl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast240=
0-kcs-bmc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/lpc@=
1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast26=
00-lhc']
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/lpc@=
1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2=
600-ibt-bmc']
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: sdc@1e740000 =
(aspeed,ast2600-sd-controller): sdhci@1e740100:compatible: ['aspeed,ast2600=
-sdhci', 'sdhci'] is too long
>         from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.y=
aml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: sdc@1e740000 =
(aspeed,ast2600-sd-controller): sdhci@1e740200:compatible: ['aspeed,ast2600=
-sdhci', 'sdhci'] is too long
>         from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.y=
aml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/sdc@=
1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspe=
ed,ast2600-sdhci', 'sdhci']
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/sdc@=
1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspe=
ed,ast2600-sdhci', 'sdhci']
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: fsi@1e79b000 =
(aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi=
-master'] is too long
>         from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600=
-fsi-master.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/fsi@=
1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-=
master', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: fsi@1e79b100 =
(aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi=
-master'] is too long
>         from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600=
-fsi-master.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/fsi@=
1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-=
master', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/dma-=
controller@1e79e000: failed to match any schema with compatible: ['aspeed,a=
st2600-udma']

All of the below warnings you are introducing...

And yeah, all the ones above are existing, but I don't see a lot of
progress fixing them. It seems no one adding their board cares about
the SoC warnings given the lack of progress on aspeed stuff. Maybe new
boards need to be rejected without some improvements...

> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio=
-keys): button-power: 'anyOf' conditional failed, one must be fixed:
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio=
-keys): button-power: 'oneOf' conditional failed, one must be fixed:
>                 'interrupts' is a required property
>                 'interrupts-extended' is a required property
>         'gpios' is a required property
>         from schema $id: http://devicetree.org/schemas/input/gpio-keys.ya=
ml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio=
-keys): button-power: 'linux,code' is a required property
>         from schema $id: http://devicetree.org/schemas/input/gpio-keys.ya=
ml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio=
-keys): button-power: Unevaluated properties are not allowed ('gpio' was un=
expected)
>         from schema $id: http://devicetree.org/schemas/input/gpio-keys.ya=
ml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio=
-keys): button-uid: 'anyOf' conditional failed, one must be fixed:
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio=
-keys): button-uid: 'oneOf' conditional failed, one must be fixed:
>                 'interrupts' is a required property
>                 'interrupts-extended' is a required property
>         'gpios' is a required property
>         from schema $id: http://devicetree.org/schemas/input/gpio-keys.ya=
ml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio=
-keys): button-uid: 'linux,code' is a required property
>         from schema $id: http://devicetree.org/schemas/input/gpio-keys.ya=
ml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio=
-keys): button-uid: Unevaluated properties are not allowed ('gpio' was unex=
pected)
>         from schema $id: http://devicetree.org/schemas/input/gpio-keys.ya=
ml#

'gpio' has been deprecated for only about 10 years. Maybe 15...

Rob

