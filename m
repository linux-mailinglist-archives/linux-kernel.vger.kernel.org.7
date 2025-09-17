Return-Path: <linux-kernel+bounces-820478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAFFB7EBE5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3257D521458
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A582F39D7;
	Wed, 17 Sep 2025 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ4aLEPM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB05285073;
	Wed, 17 Sep 2025 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104898; cv=none; b=Nxqx2lWKhqsYQmTzDw+PF5BnNatypdXvoYEXprYQ5AiBqSwE4glLyA3iedZnNh1cydpEC5zSUcL0BqWA20hAsBblXhag+qvpR5p4+mAN/wJyfZEqK9+yMLdHow2r5mlRD8hK7wYRcDFrCbeuOr1/HGrcVgnuwtzDap59KY1d2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104898; c=relaxed/simple;
	bh=HkIDtJKBhiORcxYgG/tKUBLECQnj2hugI4gQ2Ch0RiA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=eejtDP5qbt2/4NQIeNxyHC/0GuS+oxYBe7pNtjV/vBCLtDwAZYPJqc58YKkLP0MqJXV/qQCrCEvUHPng9FBw/d12HOgvEH3L/PbtjKMZGLBYzIe0bjl6723ZVi/S6kmFXIs2zCliKn9vC078thB9gyFyQdiS9ltr2zAQZE7Ahng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ4aLEPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7C5C4CEF0;
	Wed, 17 Sep 2025 10:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104897;
	bh=HkIDtJKBhiORcxYgG/tKUBLECQnj2hugI4gQ2Ch0RiA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=GQ4aLEPMm2MYWmyRIVwCEa9zK+w8zBhaUeKfXqMzoQ8EH/5ImCLhxkVaMJ9QRqlBp
	 Aa37xRt98MsD5pP1t1iv+nxmhCx1Qsl23tJ77lY0LBet83cc3mHBWdmwZfDj4kYDz/
	 JDURvT9bBdTtyDyT7avTATWd+/CFk5cBiCrzS1ojUYPpiuKHS7heKku3KeLQkbqq+7
	 rxLzczVduphC1ZxQ6YDk6/IQYXV+ISZ7G/jNil75+FGK9GqT+afv49GnMh7p3j28yG
	 L4D5vhFWskjjNu4DiQog0U4b8ARgcEnvOlRbHPHTpcJD7PmYhjnomcjKWbmk+L5OZl
	 1ZbgGsjr9asnA==
Date: Wed, 17 Sep 2025 05:28:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org, 
 sound-open-firmware@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, 
 devicetree@vger.kernel.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Takashi Iwai <tiwai@suse.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: "hailong.fan" <hailong.fan@mediatek.com>
In-Reply-To: <20250917075336.5985-2-hailong.fan@mediatek.com>
References: <20250917075336.5985-1-hailong.fan@mediatek.com>
 <20250917075336.5985-2-hailong.fan@mediatek.com>
Message-Id: <175810489672.1450298.11416938707985420274.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: dsp: mediatek: add mt8196 dsp
 document


On Wed, 17 Sep 2025 15:53:05 +0800, hailong.fan wrote:
> From: Hailong Fan <hailong.fan@mediatek.com>
> 
> Add device tree binding documentation for the MediaTek
> MT8196 DSP. The DSP is used by the Sound Open Firmware
> driver node and includes registers, clocks, memory regions,
> and a mailbox for DSP communication.
> 
> Signed-off-by: Hailong Fan <hailong.fan@mediatek.com>
> ---
>  .../bindings/dsp/mediatek,mt8196-dsp.yaml     | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.example.dts:18:18: fatal error: dt-bindings/clock/mt8196-clk.h: No such file or directory
   18 |         #include <dt-bindings/clock/mt8196-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:132: Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250917075336.5985-2-hailong.fan@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


