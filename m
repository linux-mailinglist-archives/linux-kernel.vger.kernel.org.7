Return-Path: <linux-kernel+bounces-799103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5576B42705
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2E27B1D48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95122FC894;
	Wed,  3 Sep 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIkNUWit"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7B28E59E;
	Wed,  3 Sep 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917385; cv=none; b=rrK3KFNDkvXMd0rKtb3Df2QE7IdQkHm1h/q0k25+KOe0+l4zDJJuwOaJhAlWc44uzr+oSol8riC4HCoe6wSwEEHAV+vuzHg7AiCvTsvJHrYlQKOgRtAo/QpA42QE3pingfX1bKcJHeaUXkSr7BWtUkBmXQUH2wObwv1DV/dcqks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917385; c=relaxed/simple;
	bh=KeN+RCO7nq0F5xItVOtUwuICkNkgJkRsIZYT+nyc8O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG5aMu9sh9kjakU8Uvjcb1zXnvQpjMS0/8htLDyul3CRsD905DmrsJaINX8Wr1/TAoavfV6cRSlS70GF5uw+rOgDCNN5cRe/0PN+bvg8ERMdiedMX1uNMq4T4KLMrmaCEJDVupyzOZ4iZBEtNxxObVcZpsyfMedA4bn/aqz4EOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIkNUWit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADE0C4CEE7;
	Wed,  3 Sep 2025 16:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756917384;
	bh=KeN+RCO7nq0F5xItVOtUwuICkNkgJkRsIZYT+nyc8O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIkNUWitD+iC4Duzrb7Qbv+ufyTvtkNqLJ1tJGFgJOig7OGjQjx6Pc8sGFSkNfkc0
	 kEwbf5Rm4NVzdsk7Fl/JIHEtP12Vf/VMAciHL/lUGdYizwW/tRAIkwk4fWegAcIbtv
	 GpLQvcXuXvRsm3LA+/Mr1j4TyoZ3fjDMeHREaAXIbBIWrntgtFrlThxh8CvYb7KOf+
	 G0qnqxxoOmEBBiUHh+/1SAATRu8CyCxdhzwcNy8xnsjRFe8Da0G2SepjwsjO00zQG1
	 GyLAPO6+Z+AFlYMmFlQIRERIXklbv3TDyK60Rbl9Gd0OZWW1tZDIfxlfyUdwFRB2kd
	 2hTvVVv9Ixm7g==
Date: Wed, 3 Sep 2025 11:36:23 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	NXP S32 Linux Team <s32@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ciprian Costea <ciprianmarian.costea@nxp.com>,
	linux-kernel@vger.kernel.org, linaro-s32@linaro.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: nvmem: Add the nxp,s32g-ocotp yaml
 file
Message-ID: <175691738026.2409171.18098394981783190566.robh@kernel.org>
References: <cover.1756800543.git.dan.carpenter@linaro.org>
 <6a9562fc4b5a70a34eac66359bcab64be96ab873.1756800543.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a9562fc4b5a70a34eac66359bcab64be96ab873.1756800543.git.dan.carpenter@linaro.org>


On Tue, 02 Sep 2025 12:47:45 +0300, Dan Carpenter wrote:
> From: Ciprian Costea <ciprianmarian.costea@nxp.com>
> 
> Add bindings to expose the On Chip One-Time Programmable Controller
> (OCOTP) for the NXP s32g chipset.  There are three versions of this
> chip but they're compatible so we can fall back to the nxp,s32g2-ocotp
> compatible.
> 
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v3: Remove unnecessary |
>     Move $ref to end
>     Alphabetize the compatibles
>     Delete the unused ocotp: label
> 
> v2: dt_binding_check DT_SCHEMA_FILES=nxp,s32g-ocotp-nvmem.yaml is clean
>     make CHECK_DTBS=y freescale/*.dtb is clean.  Particularly the
>       freescale/s32g274a-evb.dtb file which Rob mentioned.
>     remove bogus include file
>     remove redundant "reg" description
>     remove #address-cells and #size-cells since they are already in
>     nvmem.yaml
>     Fix email From header
> ---
>  .../bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


