Return-Path: <linux-kernel+bounces-878975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE944C21E45
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE15426BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372436E35B;
	Thu, 30 Oct 2025 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnZw6Uc4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF063168E0;
	Thu, 30 Oct 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851668; cv=none; b=QkZd4VjbEEMH3kU+UBXdhPXFqv556xlxLZrs98j0mTKFvpDhjhnu1SidrPBXMMINbLeEc+hfCShMOs8BVUGh2gmAYkqovtD8D6HpVPjFsLZycWhl9jEYKCNGzD+NmSOSwDfjgsfySnvGKx9I8cjz/r6WgGep28N8zwrnFJT+34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851668; c=relaxed/simple;
	bh=o2SN2zjrswOtJi3dLC6TZZ6AulJzzG+lj6v/WztOym4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9Z8xI73y2FXeMuuXW1e780asOvuKs3OHYIir603IIvNyaELNU1XDR1SiUldbiwk0WrUjGqr2CWRSMhUPHia9TJ1/7M+QHl1BYFaGtP8TANdIUjodzmUnk9iy8dGCYxoVJKML9eUvDNnHiq/AskdnCcuhtErjJ9cVcLvTk4zGC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnZw6Uc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E70FC4CEF1;
	Thu, 30 Oct 2025 19:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761851668;
	bh=o2SN2zjrswOtJi3dLC6TZZ6AulJzzG+lj6v/WztOym4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnZw6Uc4QrAv4IZFXnvNcgUX5U1R++tDJSyUVpzl8NPX/Lfc92gK8ylGeXEncdlvk
	 CUp8UkIZI9fHLuceSmkYlYjT9JOQwvXEP+S7a7jXZBwVVhuAuvADxArQoZdyE1nHyd
	 mtlTs7w7gD1GMJlEZpF2QsTHuRiGXAg8zDAOa3Y8suvoEObg4OvnY7q/p+y0j9taEM
	 bj3CMQbgLSIV6MwwrHrRXJUFMMi9aJlqAKygdQwZBJMYH+pF953apxxkm4GcxungAW
	 mMJ1fOEpFQHUL4sq30O8/a4bs5EEyYDpo0fO8toWq492nvYGBxhwS2TxWg9SZLR5so
	 XklBRPsLFR9CQ==
Date: Thu, 30 Oct 2025 14:14:23 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Peter Rosin <peda@axentia.se>,
	in file <patches@opensource.cirrus.com>,
	"open list:ANALOG DEVICES INC ASOC CODEC DRIVERS" <linux-sound@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ARM/APPLE MACHINE SOUND DRIVERS" <asahi@lists.linux.dev>,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: consolidate simple audio codec to
 trivial-codec.yaml
Message-ID: <20251030191423.GA270802-robh@kernel.org>
References: <20251029214018.3969034-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029214018.3969034-1-Frank.Li@nxp.com>

On Wed, Oct 29, 2025 at 05:40:15PM -0400, Frank Li wrote:
> Consolidate simple audio codec (one compatible string, one reg and
> '#sound-dai-cells' 0) to a trivial-codec.yaml.

I feel like we're going to be moving things back out when/if supplies 
are added. I imagine there's not much alignment there. OTOH, if this is 
all older stuff, then that may never happen.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/sound/adi,max98363.yaml          | 60 -----------------
>  .../bindings/sound/adi,ssm3515.yaml           | 49 --------------
>  .../devicetree/bindings/sound/da9055.txt      | 22 -------
>  .../bindings/sound/nuvoton,nau8540.yaml       | 40 ------------
>  .../bindings/sound/nuvoton,nau8810.yaml       | 45 -------------
>  .../bindings/sound/nxp,tfa9879.yaml           | 44 -------------
>  .../bindings/sound/nxp,uda1342.yaml           | 42 ------------
>  .../bindings/sound/trivial-codec.yaml         | 65 +++++++++++++++++++
>  .../devicetree/bindings/sound/wlf,wm8510.yaml | 41 ------------
>  .../devicetree/bindings/sound/wlf,wm8523.yaml | 40 ------------
>  .../devicetree/bindings/sound/wlf,wm8580.yaml | 42 ------------
>  .../devicetree/bindings/sound/wlf,wm8711.yaml | 40 ------------
>  .../devicetree/bindings/sound/wlf,wm8728.yaml | 40 ------------
>  .../devicetree/bindings/sound/wlf,wm8737.yaml | 40 ------------
>  .../devicetree/bindings/sound/wlf,wm8750.yaml | 42 ------------
>  .../devicetree/bindings/sound/wlf,wm8753.yaml | 62 ------------------
>  .../devicetree/bindings/sound/wlf,wm8776.yaml | 41 ------------
>  .../devicetree/bindings/sound/wlf,wm8961.yaml | 43 ------------
>  .../devicetree/bindings/sound/wlf,wm8974.yaml | 41 ------------
>  .../devicetree/bindings/sound/wm8770.txt      | 16 -----

Also, these can be added I think:

cirrus,cs4349
cirrus,cs4341a
cirrus,cs4265
"adi,ssm2602", "adi,ssm2603", "adi,ssm2604"
ti,pcm1792a
ti,pcm1789 (Add reset-gpios)
ti,pcm5102a
dlg,da9055-codec

>  20 files changed, 65 insertions(+), 790 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/adi,max98363.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/da9055.txt
>  delete mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8810.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/nxp,uda1342.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/trivial-codec.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8523.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8580.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8711.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8728.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8737.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8750.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8753.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8776.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8961.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8974.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8770.txt

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/trivial-codec.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/trivial-codec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: collect trivial audio codec

Just 'Trivial Audio Codecs'

> +
> +maintainers:
> +  - patches@opensource.cirrus.com

You can put me.

> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ssm3515
> +      - dlg,da9055-codec
> +      # Nuvoton Technology Corporation NAU85L40 Audio CODEC
> +      - nuvoton,nau8540
> +      - nuvoton,nau8810
> +      - nuvoton,nau8812
> +      - nuvoton,nau8814
> +      # NXP TFA9879 class-D audio amplifier
> +      - nxp,tfa9879
> +      - nxp,uda1342
> +      - sdw3019f836300
> +      - wlf,wm8510
> +      - wlf,wm8523
> +      - wlf,wm8580
> +      - wlf,wm8581
> +      - wlf,wm8711
> +      - wlf,wm8728
> +      - wlf,wm8737
> +      - wlf,wm8750
> +      - wlf,wm8753
> +      - wlf,wm8770
> +      - wlf,wm8776
> +      - wlf,wm8961
> +      - wlf,wm8974
> +      - wlf,wm8987
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        codec@1a {
> +            compatible = "wlf,wm8523";
> +            reg = <0x1a>;
> +        };
> +    };

