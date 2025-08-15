Return-Path: <linux-kernel+bounces-770012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F97B275DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E9416E50E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB0D2BEC24;
	Fri, 15 Aug 2025 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzZtiW0E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C229E108;
	Fri, 15 Aug 2025 02:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224942; cv=none; b=Uf2cf9d6AbKk+Lg0zj2+siwWMU8waUSkWdyYxgqCl89kY5Ioq4e/qnDbQSRgH1DpaOm7VQO+gv4Y42Kjy0ZsE83nS3RcXepsgXQ1qK7a8ny0l5imfEYuiGJmcHhMA6TdKTg7rFBhar49U0eMrdzRml2IIyjW3UF/UhS1aqo4hFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224942; c=relaxed/simple;
	bh=mrIFnf38WHuWo+npT76l0eVvwyuTXr6L3piFWujpfYc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ABKqCK/HBfeXdO+5b96ABamxIBVfocg1S5oNTw5NwkryekhAU9R/tuhywnwg8dA87jGh1hngxbhjxiIWT9WxKjvdfNep5VBY3ATeYhmk+azxufUc9c60Eh9tHIUWLwyUusFXQobl/vWdvXJDIiR/H5eMwaJpvYjuzYz6UGsMY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzZtiW0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34840C4CEED;
	Fri, 15 Aug 2025 02:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755224942;
	bh=mrIFnf38WHuWo+npT76l0eVvwyuTXr6L3piFWujpfYc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=EzZtiW0EkhDcPGb/p/XGknovtZlObtJ74JLzKRktWStLzPDoAREAwQEFmBGG4/lcU
	 kJuJFI88d1Yg2M2TvE6lsWrgbzUKuygxVu9K21jHkXSEyd1FkDWAAvE4XTtV3NbK/h
	 geGbVEAi8hJOV6ODUe/wkbWQEUtBmi3R97vumnNvgkw7oFM08dk40yR+BSI14Hb3oN
	 4U5DLAgmgVEtkvI86f+afxxIuhyerFeqA48dlhOsUNbh8eW9vI71vzTPwjN2zTWAaP
	 zpEC0HK44AeIIe/NNS5pDu6IK2kTLuPo1zCSpF0fhgfUHJBF7/+WEvv7QnxVxLTclW
	 6z8ISRsmiX7cg==
Date: Thu, 14 Aug 2025 21:29:01 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 linux-mediatek@lists.infradead.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org
To: Arseniy Velikanov <me@adomerle.pw>
In-Reply-To: <20250814234825.810-1-me@adomerle.pw>
References: <20250814234825.810-1-me@adomerle.pw>
Message-Id: <175522494130.180632.985870901068506270.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: phy: mtk-tphy: add property for
 software role switch


On Fri, 15 Aug 2025 03:48:24 +0400, Arseniy Velikanov wrote:
> Add a boolean property to enable software control of the PHY mode
> switching.
> 
> Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml: mediatek,software-role-switch: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250814234825.810-1-me@adomerle.pw

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


