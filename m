Return-Path: <linux-kernel+bounces-853488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 098C0BDBC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4DE54E75AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978902E6CA1;
	Tue, 14 Oct 2025 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="Kjqrto23"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DC24A046
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760484260; cv=none; b=ZVfqKJJaUbf/71ZWEoeWZPaF0ngIjcI5vNLLDqEZ7xS5pBkkKgEXwmbngQSS8aDjjpsbjE4D97BoNO+S2dbr7b6xzYaBNtpSoBAS3zhDEMzItHMw00rhgdTdcwmykjyIZvpyf2ae2TQQkKf9SMcpkpdrgnzpJFwvhyXk40w28uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760484260; c=relaxed/simple;
	bh=nykKmIGlqeNKSHIOK9cArsnp9F/dsxRBsg7SOi+yUbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id1vzNvoeMi7NtHhNgTdS5beT0XlFxoGBOW2wLnTrYoYsgyAIDw1Zf/Nbo4pRwYQcxkiGMwJWw1JgO297W40/Aqh0RdNAL8M2OV4Vz40qhqMPXxuGi+eJ0eY0RD7dtmKnYzhLm/bLjBMv+ZWou7XxtSq02aAe9U7lFzTOIC/rd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=Kjqrto23; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7827025e548so2453466a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1760484258; x=1761089058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzbA3h2diXeHnSi6hUxLmW4I+M7NlNe4WP1JAxxHucA=;
        b=Kjqrto23zqmr3P2FoZz2EC9uq3n7JEDSkPAHVD2D1wGiJN7/w6hxngwkml4pgpsu5E
         ZmD3EMyt86+4w8vtqAFnLY4uyDLxdh2bAa+Rn6MPluYrHRwHYIAqNNHQrHVD31UPzICt
         cvMMDg/8mUiG41hOSoL+wYtFyYkpV1D7GtV8SXQczW3XJuYObA0YZDmyT4+6pW/6aV0i
         NwYPhukIaqGhnLBsmKQnqrl/ItMmlJXBDTX6SdxwB7Wq1OMCKKK6Oz6hTadbIMZypXvc
         hdOV7WbjpBwOse7JldMIg/SvllLxKHWj+J18h0o/eXdTbOpi+LsF3S1FWuEJYnVW84WH
         WyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760484258; x=1761089058;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzbA3h2diXeHnSi6hUxLmW4I+M7NlNe4WP1JAxxHucA=;
        b=HquO3xaF72foBIg6NWVfrpX9U0nhJOojEJLB93BcaY1p7mfDaP9elWJe/XIKLjh9kx
         VnEmeF/ss+L+7Lbptcf1SaFUCaOSOl3bXk3HulrEVTmRUP56Ckw5tpTnhRYzUkBNBjRT
         A3ViSCLRgF9EzKhfsYDenkXrixX7QtCxv3YcaTE5PMCRICQtUwi7048KNxT9r7TKhoZ6
         y2rcry/nSoWolMNQswyOA5+R5jtFpi3DvNdcSRdG9go4CGMUbRdJD8yupfFblA9Ul6xz
         fJgqfuYl8bC3BapM5ScP4bU3glKqcr4/vJ/eIiZ2BSaUWXev2vAtsp81drPERQjQCk2l
         Pc5w==
X-Forwarded-Encrypted: i=1; AJvYcCUG3F4IUe0zY+IsNCSBxmOefzyfI7RoFAmnLd8G6INaZhqpg1JoBsfaKZWMhiDx82xxtMvmdSD4t5lvX+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywot/xJi6ylSPvfhBItg6oCeMqM53ycfQefFo71IXG3A7htIPtW
	FpUZN3khszy/ATX4cGF6+V5y8AS57tCpPeJSSnZTexRuNRpzDKHOrY0mE46XYhWzU5M=
X-Gm-Gg: ASbGncsH2VwnRwSXSrr6Zi2PLYZD2ox0qQXq5UaC/YWWON8049wIdi2zmdracviTHl9
	nxgqpXP1xd6XTgslAWmczarGUOtQvNmOShf3hGEdaWsSl5zmIBScUL4LYkq+zoJ7b6t3jP1ugsN
	CjK5/JgxYuFXImH9gZNtD3ulSRTMuD0OPd686dp8+/0Jj/bkHzi4GcPomlZTSIzwbe8nCBwzE1R
	xazlvhaNYFA+uHrEs1EHhJum/IXhiGsyUMor+IrrH5oc5b6YcS2vDhaHychIuzEqwDq1btBwX+d
	DOQLTtHMz6XBzHAFqPIt1GuJEJ9AyZGiblhVeQ1+S/W3gT+VtvIEPZdfI6KbQ94rrZyfhuDB8EO
	GdjFA3AV74LhxO1Bp4K/4owNwkSRHoXb9GPk/4IQfKgmUVsbeifV3wXg=
X-Google-Smtp-Source: AGHT+IFQc/e1ZbUnpoFVWuijFM2zvD8w2iyi9D7yf/z3QjAKE+FCW90DUZ0U3/TgiDPhnHf198NIsA==
X-Received: by 2002:a05:6830:641b:b0:74a:1f03:db5a with SMTP id 46e09a7af769-7c0df71bb2cmr14506181a34.3.1760484258480;
        Tue, 14 Oct 2025 16:24:18 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:ad63:63fb:ee1c:2ee9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f9067d80sm4859579a34.11.2025.10.14.16.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:24:17 -0700 (PDT)
Date: Tue, 14 Oct 2025 18:24:12 -0500
From: Corey Minyard <corey@minyard.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, openbmc@lists.ozlabs.org,
	openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ipmi: Convert nuvoton,npcm750-kcs-bmc to DT
 schema
Message-ID: <aO7bnNtjU4G0_c1c@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20251014152935.3782463-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014152935.3782463-1-robh@kernel.org>

On Tue, Oct 14, 2025 at 10:29:34AM -0500, Rob Herring (Arm) wrote:
> Convert the nuvoton,npcm750-kcs-bmc binding to DT schema format. It's a
> straight-forward conversion.

I have queued this for 6.19, but I would like a review from the people
that worked on this file previously.

Thanks,

-corey

> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/ipmi/npcm7xx-kcs-bmc.txt         | 40 --------------
>  .../ipmi/nuvoton,npcm750-kcs-bmc.yaml         | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 40 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
>  create mode 100644 Documentation/devicetree/bindings/ipmi/nuvoton,npcm750-kcs-bmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> deleted file mode 100644
> index 4fda76e63396..000000000000
> --- a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -* Nuvoton NPCM KCS (Keyboard Controller Style) IPMI interface
> -
> -The Nuvoton SOCs (NPCM) are commonly used as BMCs
> -(Baseboard Management Controllers) and the KCS interface can be
> -used to perform in-band IPMI communication with their host.
> -
> -Required properties:
> -- compatible : should be one of
> -    "nuvoton,npcm750-kcs-bmc"
> -    "nuvoton,npcm845-kcs-bmc", "nuvoton,npcm750-kcs-bmc"
> -- interrupts : interrupt generated by the controller
> -- kcs_chan : The KCS channel number in the controller
> -
> -Example:
> -
> -    lpc_kcs: lpc_kcs@f0007000 {
> -        compatible = "nuvoton,npcm750-lpc-kcs", "simple-mfd", "syscon";
> -        reg = <0xf0007000 0x40>;
> -        reg-io-width = <1>;
> -
> -        #address-cells = <1>;
> -        #size-cells = <1>;
> -        ranges = <0x0 0xf0007000 0x40>;
> -
> -        kcs1: kcs1@0 {
> -            compatible = "nuvoton,npcm750-kcs-bmc";
> -            reg = <0x0 0x40>;
> -            interrupts = <0 9 4>;
> -            kcs_chan = <1>;
> -            status = "disabled";
> -        };
> -
> -        kcs2: kcs2@0 {
> -            compatible = "nuvoton,npcm750-kcs-bmc";
> -            reg = <0x0 0x40>;
> -            interrupts = <0 9 4>;
> -            kcs_chan = <2>;
> -            status = "disabled";
> -        };
> -    };
> diff --git a/Documentation/devicetree/bindings/ipmi/nuvoton,npcm750-kcs-bmc.yaml b/Documentation/devicetree/bindings/ipmi/nuvoton,npcm750-kcs-bmc.yaml
> new file mode 100644
> index 000000000000..fc5df1c5e3bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ipmi/nuvoton,npcm750-kcs-bmc.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ipmi/nuvoton,npcm750-kcs-bmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM KCS BMC
> +
> +maintainers:
> +  - Avi Fishman <avifishman70@gmail.com>
> +  - Tomer Maimon <tmaimon77@gmail.com>
> +  - Tali Perry <tali.perry1@gmail.com>
> +
> +description:
> +  The Nuvoton SOCs (NPCM) are commonly used as BMCs (Baseboard Management
> +  Controllers) and the KCS interface can be used to perform in-band IPMI
> +  communication with their host.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: nuvoton,npcm750-kcs-bmc
> +      - items:
> +          - enum:
> +              - nuvoton,npcm845-kcs-bmc
> +          - const: nuvoton,npcm750-kcs-bmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  kcs_chan:
> +    description: The KCS channel number in the controller
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - kcs_chan
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    kcs@0 {
> +        compatible = "nuvoton,npcm750-kcs-bmc";
> +        reg = <0x0 0x40>;
> +        interrupts = <9 4>;
> +        kcs_chan = <1>;
> +    };
> -- 
> 2.51.0
> 

