Return-Path: <linux-kernel+bounces-769514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C530CB26FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366091CE0D14
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9B24061F;
	Thu, 14 Aug 2025 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/CQr1WU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D185623D7D9;
	Thu, 14 Aug 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755199274; cv=none; b=m7dIre8m8mHwEIlMG2fsS53DCQXCrzFBlUwSKIexOAT21wAAgZYBYGeU8eOcUKRNQtG+9E2AYXU/qSqz8cC4gUucEniy1YIcd3C3DyrF16P6KFUh5yauvp6jjXZUqLUtMTCDHkOCWfD1BZH7JyiFyIWHN05D9wfGeOF6501wUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755199274; c=relaxed/simple;
	bh=ifOHHx6V2KJdZ0pCXCcV9hrJ66lyUldfnEN6tn1F6FQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=kFmgsF2/Ny4BreWEow7l0IdAbRpU1D3sZoUbecfab6bTdiqOHAvtEWljPhQvXLawz95M7QVU1noxHz87ZpsC3YJTy1Kgmmir5afo428jlaU36fpHbepn8URnJJstODzZ7TXsxvk2HkSGf81qjG9AZH06wkVhTyzXaCvLnmXcJcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/CQr1WU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DD5C4CEEF;
	Thu, 14 Aug 2025 19:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755199274;
	bh=ifOHHx6V2KJdZ0pCXCcV9hrJ66lyUldfnEN6tn1F6FQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=E/CQr1WU3wmFr4yYBtcvOxhjmvG+UqTkSdbQbsWGXyfo07dtdFD7dcJucf2eXNHEH
	 tKcsfJ/7ilDp/xWqD2XoQbHZQMSYFmeTOfB4W9B9oPwaUxgJPjQnQqIZ9QM7eUW7fi
	 unqvWfZwbOd+/0vjYMGYbWECyEkt5LuUecjt2x0wHTxRFYCPeAVZTjcRrqVMfQB4rX
	 Pkcv8T5NblgShm3aKtWbIcJ6Ipe8iTxuAHYdMGon2vQzhw/GrzeQ1lTC0kyUQcJ8ux
	 KYLyhveBccC7PXYUsQm4fGLDs2yQ51SRvWZqHQdPvWQfx07Xw06L2GvPiY+0CjKvkA
	 XPmblu6HQWC2Q==
Date: Thu, 14 Aug 2025 14:21:13 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Han Gao <rabenda.cn@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 Simona Vetter <simona@ffwll.ch>, Fu Wei <wefu@redhat.com>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Robert Foss <rfoss@kernel.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Guo Ren <guoren@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Heiko Stuebner <heiko@sntech.de>, 
 Drew Fustini <fustini@kernel.org>, linux-riscv@lists.infradead.org, 
 Thomas Zimmermann <tzimmermann@suse.de>, Yao Zi <ziyao@disroot.org>
To: Icenowy Zheng <uwu@icenowy.me>
In-Reply-To: <20250814164048.2336043-5-uwu@icenowy.me>
References: <20250814164048.2336043-1-uwu@icenowy.me>
 <20250814164048.2336043-5-uwu@icenowy.me>
Message-Id: <175519927254.3738647.1422282944471640003.robh@kernel.org>
Subject: Re: [RFC PATCH 4/8] dt-bindings: display/bridge: add binding for
 TH1520 HDMI controller


On Fri, 15 Aug 2025 00:40:44 +0800, Icenowy Zheng wrote:
> T-Head TH1520 SoC contains a Synopsys DesignWare HDMI controller paired
> with DesignWare HDMI PHY, with an extra clock gate for HDMI pixel clock
> and two reset controls.
> 
> Add a device tree binding to it.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  .../display/bridge/thead,th1520-dw-hdmi.yaml  | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/thead,th1520-dw-hdmi.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250814164048.2336043-5-uwu@icenowy.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


