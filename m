Return-Path: <linux-kernel+bounces-853097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05987BDAA11
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E70F34E61F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA18302750;
	Tue, 14 Oct 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahcDOgNZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765130170F;
	Tue, 14 Oct 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459718; cv=none; b=TEaWERQ9ULRtYfIS2GzEPnaUnJzD+n67u6sjPrW8nI0EZvuL6NCHjF6A4gc57abTk9GP8Uk7mK04n/oB89A3HoxHsAz1gVdl6gZ6GJdbxlOl/nbiqF7BCifGp2E9ziWqWMHLcHoF7iH05XchoyKgdju1WM8lviuFk3/XUmfLClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459718; c=relaxed/simple;
	bh=afIBMvvyewK7T1JQaV1lFqdy0D48AjPJ/P3G7C+fgHo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=LMEVMfF8LQuJ+GI8sniiuo2M8qD0tPJorFoHVv6UgWEPb8bD7hdSrF+fr8fuY12NGcwL1K4uPS+4kGhJ31fhCdSuaMgOPD5GhfJ0tUYEcihPh5XZU5hxa9DGQW1FNY33Pvn3n1XU7/Ue42JFM3D6Rex+a4fa7HxCjHh7JvsoDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahcDOgNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45DFC19421;
	Tue, 14 Oct 2025 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760459718;
	bh=afIBMvvyewK7T1JQaV1lFqdy0D48AjPJ/P3G7C+fgHo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ahcDOgNZB4FQ7ysHF9u9HamH62wp+JQIKWcXS/ppPW2wxQ/eFj5wzu0Yy1BXdnMFI
	 UfHmS2w0m5jPK6+95qhuVB3yNCCHNphibVYhh886Qdqs9LQOCtCxX4O9NuA4fldiYS
	 08Isd9kUyyFq5hbA8Kuc8xobFgSgvc0GDIvJFATw1ogstdCNbQnuP8UVicX5kMkG3o
	 2kyA6E/gZddQy+iRDWhOJx8TdBFBQEPyhSvaWa+/KqjjNl5XiBYSUmuBts70d/OQGc
	 90E1i+A0rpFMWGM4Ude031x5qODQpmUm8w7rLFfiVyP3COldp/k9lQsj5Df2aaq1dl
	 RwT4VUhUM/jEA==
Date: Tue, 14 Oct 2025 11:35:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Joan Na <joan.na@analog.com>, Mark Brown <broonie@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>
To: Joan-Na-adi <joan.na.devcode@gmail.com>
In-Reply-To: <20251014053142.15835-4-joan.na@analog.com>
References: <20251014053142.15835-1-joan.na@analog.com>
 <20251014053142.15835-4-joan.na@analog.com>
Message-Id: <176045970397.4162063.2449885497355673633.robh@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: regulator: Add MAX77675 regulator
 binding


On Tue, 14 Oct 2025 14:31:42 +0900, Joan-Na-adi wrote:
> From: Joan Na <joan.na@analog.com>
> 
> Add device tree binding YAML schema for the Maxim MAX77675 PMIC regulator.
> This defines the node properties and supported regulator names for use
> in device tree sources.
> 
> Fixed:
> - Missing explanation of `maxim,fps-slot` default value
> - Updated DT binding enums to use string values (e.g., "low", "high") instead of integers
> - Converted several binary properties to boolean type
> - Renamed time-based properties to use standard unit suffixes (e.g., "-sec", "-us")
> - Added default values for properties
> 
> Signed-off-by: Joan Na <joan.na@analog.com>
> ---
>  .../bindings/regulator/maxim,max77675.yaml    | 205 ++++++++++++++++++
>  1 file changed, 205 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:36:12: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:36:27: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:36:43: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:37:14: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:45:12: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:45:20: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:46:14: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:58:12: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:58:19: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:58:27: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:58:34: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:59:14: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:126:16: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:126:25: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:126:34: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:126:43: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/regulator/maxim,max77675.yaml:126:52: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251014053142.15835-4-joan.na@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


