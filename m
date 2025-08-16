Return-Path: <linux-kernel+bounces-772001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BE7B28DAA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C0AAC05BC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAFD2D7D3F;
	Sat, 16 Aug 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egpGU+B2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38BE202963;
	Sat, 16 Aug 2025 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755347389; cv=none; b=qLq4aEHbYvbtDM8Nu/3t9EZa2AX7ySMQ1bCu5f85sQFb6wDED5bFM5cS96y+ux0Mk9KwgOjvXiQCdkKDQlTQCotWDmRRPOVvF24H7/tDcu4nOrgk8mmn18zqW9GYedvU2vwOyQFw+bEZzN4LzAgxitOKK8he6h8Zif4VFiohcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755347389; c=relaxed/simple;
	bh=VI+6xO96wk37w+RND69wrlguvv4gCVOsEMWuyLRPQM0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=uIIOj979WBjXone5sfIzikUhyVJRK6QE1JjwGL8d2VtH1a954uNpX3aJaNs8WHV673tk5S6jzu6Fcr/fLkzJWSy0uIi4OgKdkDXiqxo9weWK57m8vc2O9sKRtLw89z/1mTSk73Dj58g+xj3T5XNgUdlrRbf7YgYtbUy14y/o8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egpGU+B2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385BCC4CEEF;
	Sat, 16 Aug 2025 12:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755347389;
	bh=VI+6xO96wk37w+RND69wrlguvv4gCVOsEMWuyLRPQM0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=egpGU+B2hOEHejlVWCKK/FIjyUT8EFvDI8M3ZTgEDQ1Le25wo5nknJsUuygLD8yrY
	 B6befhhS++UgEmNob2ttan+6wjJTsyFgosG8NSGGuGA8daHP+rFCtTkByzQkjgSB1t
	 zhxxOofCYIROBlKxMl4tx2QibaUZCuE4+ooMy+/JDsdkW7GTzmfr3Q5SZ0M/KyAVGq
	 OaLisCYbQVTMzWWcPQtwnmTbgdufHDaGE1kvYzX2z/+DjNds4QJXSSeBe2VmVtoQax
	 fZ3M7sHcp2JahsNW6v6UO2mQWsd6Iy+sMOrSqVQxBVV9yTkP9BBjC7q9NA22KsYzL6
	 rk0czJ9Ue3/tw==
Date: Sat, 16 Aug 2025 07:29:48 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>, 
 Ciprian Costea <ciprianmarian.costea@nxp.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linaro-s32@linaro.org, 
 NXP S32 Linux Team <s32@nxp.com>, linux-kernel@vger.kernel.org
To: Ciprian Costea <dan.carpenter@linaro.org>
In-Reply-To: <7d0e025ed3fdc9e545f1d0b84f6a1cbb9dfb4e91.1755341000.git.dan.carpenter@linaro.org>
References: <cover.1755341000.git.dan.carpenter@linaro.org>
 <7d0e025ed3fdc9e545f1d0b84f6a1cbb9dfb4e91.1755341000.git.dan.carpenter@linaro.org>
Message-Id: <175534738837.644771.11317656897363628070.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: Add the nxp,s32g-ocotp yaml
 file


On Sat, 16 Aug 2025 13:47:03 +0300, Ciprian Costea wrote:
> Add bindings to expose the On Chip One-Time Programmable Controller
> (OCOTP) for the NXP s32g chipset.  There are three versions of this
> chip but they're compatible so we can fall back to the nxp,s32g2-ocotp
> compatible.
> 
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  .../bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml  | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.example.dts:18:18: fatal error: dt-bindings/nvmem/s32g-ocotp-nvmem.h: No such file or directory
   18 |         #include <dt-bindings/nvmem/s32g-ocotp-nvmem.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:132: Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1524: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/7d0e025ed3fdc9e545f1d0b84f6a1cbb9dfb4e91.1755341000.git.dan.carpenter@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


