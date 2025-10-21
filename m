Return-Path: <linux-kernel+bounces-862076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D687BF45F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3123BAA1B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB5B275AF0;
	Tue, 21 Oct 2025 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeNkvJws"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641A44AEE2;
	Tue, 21 Oct 2025 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761013191; cv=none; b=PIGMWx2ybhJ8AkTZyCnLYmR9xp7WdvuqiI/5+9vk3ZBOrtX2MIrEPjdwjgDkOQYDVnhQxiunjW4AyJzorstxqp/WM9Yi8l6LmSKsiUfOjCuey0VdmkY4QXD7x48yN047K3ZvYyeiKkrKhLZFyWczo1XplI3SMM8rdeVAyXOWaF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761013191; c=relaxed/simple;
	bh=k0IODMQL//HmcYNybquqw9b9ocqnHrvWWX8AkSnFqHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwaDnkTXjC6XTfKtpp9mlUmtR7bJYVGcplRExrc9zRR0gnC8v+3wK2g5GIu484MEyQ4Mcay2pi/ESKyCVKFI7b+EGlSnQR7jL9aG4cUATsmaP7REAOM1MvNHnkaXUgbiRxxl9nlsbDQHEus4D+U4ar2QsCCEr0otfcwAdaLC18c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeNkvJws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C5FC4CEFB;
	Tue, 21 Oct 2025 02:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761013190;
	bh=k0IODMQL//HmcYNybquqw9b9ocqnHrvWWX8AkSnFqHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeNkvJwsEInlT+RzdsQSNB0LwxuwjVBxqc6LUysr26l2GCxjWeKzNzW1Dff6rLl49
	 KjyWIM/N9n8xwke/FNZQovwWVUEOuuKjG92s2nl8plEaJCm1QlxuhgOavNR+9SnWKg
	 lhyx4quDVFbt7f9xgSvNTHlrzSQ41Z0TiKAGQrTcbsmsUC5A4UMJSEEGAMwGFF/NTV
	 fTQddQCIthgSROZ4ytJshXYHVWMS2j/uMRPy7fmCDkNkGwz8E9JJf1bGgiSa3+eb0i
	 eGFumVGYDCLsRPIHmayBaXrFDt87vyw1DhgPc1f19cqOrkuTTc2AQR3SuXflOixA9c
	 poLfOTgzgQ/lw==
Date: Tue, 21 Oct 2025 07:49:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: Convert Actions Owl SPS to DT schema
Message-ID: <e7ve2cp4x4slaqjgxyzvlc4ndgvtjbf7q5rgpcbjhxgr5ymix6@zie2hysmsox7>
References: <20251013215834.783501-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013215834.783501-1-robh@kernel.org>

On Mon, Oct 13, 2025 at 04:58:26PM -0500, Rob Herring (Arm) wrote:
> Convert the Actions S500/S700/S900 Smart Power System binding to DT
> schema format. It's a straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  .../bindings/power/actions,owl-sps.txt        | 21 ----------
>  .../bindings/power/actions,s500-sps.yaml      | 39 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.txt
>  create mode 100644 Documentation/devicetree/bindings/power/actions,s500-sps.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/actions,owl-sps.txt b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
> deleted file mode 100644
> index a3571937b019..000000000000
> --- a/Documentation/devicetree/bindings/power/actions,owl-sps.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Actions Semi Owl Smart Power System (SPS)
> -
> -Required properties:
> -- compatible          :  "actions,s500-sps" for S500
> -                         "actions,s700-sps" for S700
> -                         "actions,s900-sps" for S900
> -- reg                 :  Offset and length of the register set for the device.
> -- #power-domain-cells :  Must be 1.
> -                         See macros in:
> -                          include/dt-bindings/power/owl-s500-powergate.h for S500
> -                          include/dt-bindings/power/owl-s700-powergate.h for S700
> -                          include/dt-bindings/power/owl-s900-powergate.h for S900
> -
> -
> -Example:
> -
> -		sps: power-controller@b01b0100 {
> -			compatible = "actions,s500-sps";
> -			reg = <0xb01b0100 0x100>;
> -			#power-domain-cells = <1>;
> -		};
> diff --git a/Documentation/devicetree/bindings/power/actions,s500-sps.yaml b/Documentation/devicetree/bindings/power/actions,s500-sps.yaml
> new file mode 100644
> index 000000000000..bb942817b3db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/actions,s500-sps.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/actions,s500-sps.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi Owl Smart Power System (SPS)
> +
> +maintainers:
> +  - Andreas Färber <afaerber@suse.de>
> +  - Manivannan Sadhasivam <mani@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - actions,s500-sps
> +      - actions,s700-sps
> +      - actions,s900-sps
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    power-controller@b01b0100 {
> +        compatible = "actions,s500-sps";
> +        reg = <0xb01b0100 0x100>;
> +        #power-domain-cells = <1>;
> +    };
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்

