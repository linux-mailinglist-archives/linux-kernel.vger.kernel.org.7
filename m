Return-Path: <linux-kernel+bounces-746288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD05B124F2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57FF1CE1EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D677324EF7F;
	Fri, 25 Jul 2025 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMa/+Vqg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA671FC3;
	Fri, 25 Jul 2025 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473316; cv=none; b=bBh2sI2JtDt58s+p1VzDu/tAd7PlY0bC9477YDWRTYtc8NedfXp0ijM2fdVjxj3c6KFmSg2mq/x8X86hvcl33OwlbB12HKYQ2McgqCjauk7EFeQ3CwD8e8rxPwQS3S5huZ/dmDyk61hpgNWAR3FJ5TRuIk4c8s+tmT0vstrh1Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473316; c=relaxed/simple;
	bh=jq9de0xqHLOElQGfL/L1lyP1mynw3m8ZDqHzHHdA4MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2RnVOirC+avXv2GwqC9wSjj9u/eszSV3rw4jWHXD5kxjuJL5FeQvyiCaJGg8/6XL4v6dLV14DNjxCvVxQ8hAHgsdfV4xbW7SBPEjf2yfwMSlrioyW1tr3i6UpjNk+rPYVCsp2OlyGnBoGrQBmZg1wtEysXoct125OQZd//79OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMa/+Vqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A1CC4CEE7;
	Fri, 25 Jul 2025 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753473314;
	bh=jq9de0xqHLOElQGfL/L1lyP1mynw3m8ZDqHzHHdA4MI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMa/+VqgMV9PX2gL59g4RWjYm/JyjLaxc35biNPL3h4LAgpR3QvewTjpbLCv5Pmlx
	 BYLgtMrjXeWzVvs/m7eUCwq+D2XII76VRsfx9xRwBFM+gDFJ4o1HOXdM0WG/B6eiop
	 GK1IS9ecewmb99ONrZmPZn456JWFvmYsR36gVaL34lveAfrttwE3RomcaTngAvhkPT
	 eDLHG7VEsxra0D3IPpmJKc4t4BdwNf16HXInE51YOXweh7ifZrDaQj0YUQkQrRxxck
	 b2yNvqrEt8fYV2XwtBHW2Fgj9R3fJAVTbcbU8K2ipqdZ++PFMYi+5GgZfyN72eGsGm
	 7MlRcing5aIYg==
Date: Fri, 25 Jul 2025 14:55:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [RESEND v2 1/1] dt-bindings: fsl: convert fsl,vf610-mscm-ir.txt
 to yaml format
Message-ID: <175347331284.1746158.8891118148462091112.robh@kernel.org>
References: <20250724190342.1321632-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724190342.1321632-1-Frank.Li@nxp.com>


On Thu, 24 Jul 2025 15:03:41 -0400, Frank Li wrote:
> Convert fsl,vf610-mscm-ir.txt to yaml format.
> 
> Additional changes:
> - remove label at example dts.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> V2 resend, add Krzysztof Kozlowski's review by.
> 
> Change from v1 to v2
> - move under interrupt-controller
> ---
>  .../arm/freescale/fsl,vf610-mscm-ir.txt       | 30 ---------
>  .../fsl,vf610-mscm-ir.yaml                    | 63 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-ir.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,vf610-mscm-ir.yaml
> 

Applied, thanks!


