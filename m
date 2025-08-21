Return-Path: <linux-kernel+bounces-780801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A22B30987
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF3D62358D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AE92ECE9F;
	Thu, 21 Aug 2025 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB7tZjdv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2302ECD12;
	Thu, 21 Aug 2025 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815991; cv=none; b=fm3HFLt0FZNyeMRBr98InMW5foacnfSy5fA7qyd+KPiI0JhnLoRGTD/158LeTzn/bzFxeH8GclSLtZldFehAatAzZHPlDOCOU9TS9dFlFyqVkzwp3UTnEwA1BXvq6jDVEksatCK8/qt3uduVVD2IZT2haW4SlNqTgIbw354FlDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815991; c=relaxed/simple;
	bh=vuZhFVJxi98oZW9G4+46GRkaq4U3k45zs10DSDHFn2k=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Y3fb0xunnxzcJojERMkoKu/RjWqZbglFyacNSxIQ6ceaMd+TUfVXVUxCW4+MxqHcTu+pLd9I+pRXBrMhXBtnVunGkvqWZJaHQRvzUX+nZcM7002apFM9W+6zapU8SzaCKjdRfxiNWKKrmIctsEGl+fcOTVZRv3p2ReRACZZQFT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB7tZjdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEC0C4CEEB;
	Thu, 21 Aug 2025 22:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755815991;
	bh=vuZhFVJxi98oZW9G4+46GRkaq4U3k45zs10DSDHFn2k=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=QB7tZjdvYg84DKSiyFtv3QG8PehyI3EomBo3qpPbXBg3avH2COX+5vcwJVq4K0EM4
	 1itP36tXMVtW/ALvIMSVpq8cDpVb/RFo6/3NcSsOVpnkZTLfvwSbf3oOgHQELjDKXw
	 YZKl56kdsVoRrdL+Z+s6weaNU5i0psZgmy2mdZ/0HJ9Vx1vsAbG58rnQg2SjpsLv4F
	 8rPB8pQICq1KDfP8D3L2GeW+gG9UQd3IqYQOHFqtIs/b85M0XstjATm3xQA6vympYZ
	 Jeg3COmMvyLyOF49z3CZiiKSwnRVXnPTkmP0YpCIQC+ZB8Pg3CyUV7HilsWOIJ9BPn
	 vmniA3eB5h5IA==
Date: Thu, 21 Aug 2025 17:39:50 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
 linux-usb@vger.kernel.org, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 devicetree@vger.kernel.org, linux-phy@lists.infradead.org, 
 Philipp Zabel <p.zabel@pengutronix.de>, Felipe Balbi <balbi@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>
To: Sven Peter <sven@kernel.org>
In-Reply-To: <20250821-atcphy-6-17-v1-1-172beda182b8@kernel.org>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-1-172beda182b8@kernel.org>
Message-Id: <175581575751.1136230.16771549350883688048.robh@kernel.org>
Subject: Re: [PATCH RFC 01/22] dt-bindings: usb: snps,dwc3: Allow multiple
 iommus


On Thu, 21 Aug 2025 15:38:53 +0000, Sven Peter wrote:
> Apple's dwc3 variant requires two iommus.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dtb: usb@a6f8800 (qcom,sdm845-dwc3): usb@a600000:iommus: [[4294967295, 1856, 0]] is too short
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dtb: usb@a6f8800 (qcom,sdm845-dwc3): usb@a600000: Unevaluated properties are not allowed ('iommus' was unexpected)
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dtb: usb@a6f8800 (qcom,sdm845-dwc3): usb@a600000: Unevaluated properties are not allowed ('iommus' was unexpected)
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dtb: usb@a600000 (snps,dwc3): iommus: [[4294967295, 1856, 0]] is too short
	from schema $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dtb: usb@a600000 (snps,dwc3): Unevaluated properties are not allowed ('iommus' was unexpected)
	from schema $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250821-atcphy-6-17-v1-1-172beda182b8@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


