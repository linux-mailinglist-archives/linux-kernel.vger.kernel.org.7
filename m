Return-Path: <linux-kernel+bounces-780802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5716B30982
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D1D7B113D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F912ED14B;
	Thu, 21 Aug 2025 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWroQvBl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC42ECE9E;
	Thu, 21 Aug 2025 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815992; cv=none; b=X6yp4AbV5syVCy/d3CtRABb9rYOHO9FS938fEoyK+kn0sjNVI9i+7RyIS5Zht9Bjiu3vlmW/Y8X7D3IPToAmgsAJQTjWBUlXu6l8tBFZScQ2TcQ05HtCh07AbY+kA1y+bMqxKjN51CWEgBz7Q4QR2Dsexs7GkpKxQz7zjmzw3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815992; c=relaxed/simple;
	bh=6+cneP8xDnuU5FHp6ZE4wpE6pWPQvWdqGAQj+wxVZj8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=nlqQbuLV73MMOd7oVzvJJrPtxgMuIMLkVlj/IVkBjOV7CGMwokpLLu/b602n4NlRjBWb2AcTR/L9DMtyrwVTRVxqer/BaO4OSk3QwyFCxL1bSgwueywtvT/5kMWt7wkuvIdMZE4p5tsRsgSXsLEjcDRLc389aEfM5mJeKlCl/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWroQvBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6D8C116C6;
	Thu, 21 Aug 2025 22:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755815992;
	bh=6+cneP8xDnuU5FHp6ZE4wpE6pWPQvWdqGAQj+wxVZj8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=JWroQvBlvJj3n3GQj85XFCVw1RomjL3x/nkCU4RTbgYO65e9E7eN8T3+QPp8VPUDi
	 5rUdQz4i7YpZV3cCkF7fVvd7pwkI3tNbYHvFIXRy6kzneXEeRzPwmgcq9Izgv+1Oin
	 DYtwhazNI783UY+RndJ8i50KtG02lJ9LORgbBg4URyKshly+QMkwzjoku368tF3oaZ
	 PV3k43WFiYPE7Y++y+OTu+0uMBSP/3l5S9OJPdkyW4Abcy/2DT/Pf4bj95pe5H6liF
	 DiK8e+cKE+CBABkBpqThiec+t13OK8+NseaAbugSa7K8jOzA6hreQ1LeUfYpPCllxW
	 aST3CoSeeDmUA==
Date: Thu, 21 Aug 2025 17:39:51 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neal Gompa <neal@gompa.dev>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org, 
 Felipe Balbi <balbi@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Janne Grunau <j@jannau.net>, devicetree@vger.kernel.org, 
 Vinod Koul <vkoul@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
To: Sven Peter <sven@kernel.org>
In-Reply-To: <20250821-atcphy-6-17-v1-2-172beda182b8@kernel.org>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-2-172beda182b8@kernel.org>
Message-Id: <175581575858.1136316.14856911628324128636.robh@kernel.org>
Subject: Re: [PATCH RFC 02/22] dt-bindings: usb: Add Apple dwc3


On Thu, 21 Aug 2025 15:38:54 +0000, Sven Peter wrote:
> Apple Silicon uses Synopsys DesignWare dwc3 based USB controllers for
> their Type-C ports.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  .../devicetree/bindings/usb/apple,dwc3.yaml        | 82 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 83 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/apple,dwc3.yaml:33:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/usb/apple,dwc3.yaml:40:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/apple,dwc3.example.dtb: usb@82280000 (apple,t8103-dwc3): 'resets' is a required property
	from schema $id: http://devicetree.org/schemas/usb/apple,dwc3.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/apple,dwc3.example.dtb: usb@82280000 (apple,t8103-dwc3): 'power-domains' is a required property
	from schema $id: http://devicetree.org/schemas/usb/apple,dwc3.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250821-atcphy-6-17-v1-2-172beda182b8@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


