Return-Path: <linux-kernel+bounces-612288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 661ADA94D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 09:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A63B1889487
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 07:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1359C1E1A16;
	Mon, 21 Apr 2025 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elclvoT+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F91718641;
	Mon, 21 Apr 2025 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220559; cv=none; b=FNHLP97PT/ui61mdIiwVECmzJTpSub6N/eyA6lXKZnDoed41CxLd0icZozt3UypLjnYtXGYw1okbYQZmggdRS74jmJaJVvmCnIFnNR9uSxYivb5AC3Gr4vPHqatcBmukyzNmT6/UegOs6fUzYM+s+n93+2feu6wLNTULM8ojCEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220559; c=relaxed/simple;
	bh=AsfbiDjIVGcOHxoZBj404PVsbS0hHdvffd79DyXm0zw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=VCF96avuWEercIaME3zJ9hpsqQ5OxMe/14OaduOzQ16T6Li+OVxYUIABGWvVEHSALdCzopL49jhnfUacQg2nuZgh2OjMCSUIqCvIa5idr8FNg9klRCnihULpqWdxNGn7rUnZ37B8TyZUEVuk2/cHbI4U1WUFShRk8XExM0jpy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elclvoT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85660C4CEE4;
	Mon, 21 Apr 2025 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745220558;
	bh=AsfbiDjIVGcOHxoZBj404PVsbS0hHdvffd79DyXm0zw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=elclvoT+rKeEsXkmzDTwOoBFoMwx4Qu3exhJ6CQWv+/TF9zxKsr77GD6mtPSxypnh
	 5oXwnoB0khUMMpqQpR0DiazrtlEEzt+CltbSfTptx8pDVkaNInPhkiDh2/XlPH2Uq6
	 zivbAcrvwhpDGJmMvzZ02LhNFRm+dkJueQqEsJT6JNJ2D80AOa1CpYIFo2iTQOC4T5
	 Uin3In3zrWFGv5T8gpHu0XhyQHv7KRxq6sRBDIlmUlEav9OO3m0oSWStWNGkdvWihu
	 TP75G+flspaMDpfgw3gwBUHs69n6E33+LsQDVSuKZAcp91S7et32WKsUePxGDFqwXS
	 s1s2Ge09dybew==
Date: Mon, 21 Apr 2025 02:29:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, 
 linux-kernel@vger.kernel.org, Frank.Li@nxp.com, 
 alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org, 
 miquel.raynal@bootlin.com, devicetree@vger.kernel.org, 
 conor.culhane@silvaco.com, linux-arm-kernel@lists.infradead.org, 
 shawnguo@kernel.org, kernel@pengutronix.de, imx@lists.linux.dev, 
 conor+dt@kernel.org
To: carlos.song@nxp.com
In-Reply-To: <20250421061544.2471379-2-carlos.song@nxp.com>
References: <20250421061544.2471379-1-carlos.song@nxp.com>
 <20250421061544.2471379-2-carlos.song@nxp.com>
Message-Id: <174522055654.901015.12807309511179699830.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: i3c: silvaco,i3c-master: add i.MX94
 and i.MX95 I3C


On Mon, 21 Apr 2025 14:15:42 +0800, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> Add compatible string "nxp,imx94-i3c" and "nxp,imx95-i3c" for the i.MX94
> chip and i.MX95 chip. Backward is compatible with "silvaco,i3c-master-v1".
> 
> Also i.MX94 and i.MX95 I3C only need two clocks and Legacy I3C needs
> three clocks. So add restrictions for clock and clock-names properties
> for different Socs.
> 
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
>  .../bindings/i3c/silvaco,i3c-master.yaml      | 45 ++++++++++++++++---
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml:16:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml:19:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250421061544.2471379-2-carlos.song@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


