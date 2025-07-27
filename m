Return-Path: <linux-kernel+bounces-747278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A6B131C3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790843BA768
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE3B233727;
	Sun, 27 Jul 2025 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNVl+31E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78ED232368;
	Sun, 27 Jul 2025 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753648061; cv=none; b=gIL4o4wpYIF9HfpAmlYclaZhXcx+DDd6AF+SaKjscwZ+lrmWQAzi40qSICjwv8iEKihNFVoq8DSxonY9kjL7hdsv622EasYwfvNgDKXQvgZf1ElpSYO/kROiKvkkfZ2wqurn76nzALjCafX4obAjnrUJgdUn5i15dX8K2B2Abto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753648061; c=relaxed/simple;
	bh=ZE7PSM2KnsublRw2gVAyFR2kIwpn1Ua6FQHLHsugA6U=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=dBlqGTstZRXJ/9nMDJykibJSsLY8K7Ngjz4ZfYiTh4Ny3LgYnnW16hrwmOmKmld0onUSD4m1olZZvHxGJd5g/cHRriVBbvpLKj9uPQOQxYxc3VpxFbWN95JVzRUuUhMwwQtJ2AbBB8D165pZd2Ck30w4AjRKjk4O9lVSEMtP5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNVl+31E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CA5C4CEEB;
	Sun, 27 Jul 2025 20:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753648061;
	bh=ZE7PSM2KnsublRw2gVAyFR2kIwpn1Ua6FQHLHsugA6U=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=LNVl+31E3NMJrHyQtuJYp4yaIK/rnBsBIB/Etng8qQXg+EGYcBdXWYXJUpcMyVFl+
	 CeZ66Y6k2Hup+/keLrW4abFUgnBqilsT2rbdSRJyrcaVwO77N9awRNA3BWtwFcEUdO
	 NzZZWNYsDWXqvPYHklCSFW5i4ty+PXVrVyxc0qDic3j7RPzdyOvjWiFqGUfc0kuCQO
	 TbCcBz7brHiwZUkPcLGs7XMsnC0+pY9EXREJGlDwtDDpVoMcSPfNYsiFAZX7xDXreK
	 pk8AwqliHmgHZjQb8uBptexbi7t1mpVcVtqKHVJw3CXXcrlD5/sLteJU3yMpLBoAZW
	 hqEJi9V0Ij77w==
Date: Sun, 27 Jul 2025 15:27:40 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Yongqiang Niu <yongqiang.niu@mediatek.com>, devicetree@vger.kernel.org, 
 CK Hu <ck.hu@mediatek.com>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-mediatek@lists.infradead.org, 
 David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, dri-devel@lists.freedesktop.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Simona Vetter <simona@ffwll.ch>
To: Jay Liu <jay.liu@mediatek.com>
In-Reply-To: <20250727071609.26037-5-jay.liu@mediatek.com>
References: <20250727071609.26037-1-jay.liu@mediatek.com>
 <20250727071609.26037-5-jay.liu@mediatek.com>
Message-Id: <175364805648.3160.7761307037849167349.robh@kernel.org>
Subject: Re: [PATCH v2 4/7] dt-bindings: display: mediatek: disp-tdshp: Add
 support for MT8196


On Sun, 27 Jul 2025 15:15:54 +0800, Jay Liu wrote:
> Add disp-tdshp hardware description for MediaTek MT8196 SoC
> 
> Signed-off-by: Jay Liu <jay.liu@mediatek.com>
> Signed-off-by: 20220315152503 created <jay.liu@mediatek.com>
> ---
>  .../display/mediatek/mediatek,disp-tdshp.yaml | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml:23:7: [warning] wrong indentation: expected 4 but found 6 (indentation)
./Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml:41:5: [warning] wrong indentation: expected 2 but found 4 (indentation)
./Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml:42:10: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml:43:10: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml:45:9: [error] syntax error: expected <block end>, but found '<scalar>' (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml:45:9: did not find expected key
make[2]: *** Deleting file 'Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.example.dts'
Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml:45:9: did not find expected key
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1526: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250727071609.26037-5-jay.liu@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


