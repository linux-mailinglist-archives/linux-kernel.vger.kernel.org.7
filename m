Return-Path: <linux-kernel+bounces-738489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B35B0B910
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576241895FA4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 23:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78FE223DDD;
	Sun, 20 Jul 2025 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9zY/gPg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F821DE3BA;
	Sun, 20 Jul 2025 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753052815; cv=none; b=shTM4PKM9bqDKje8gt3Qh9uke0fH+RXFI/IiXwK1UEjoeb/iWuvbfgfTRAv2L32UUcj//e5KoSZXKXroQ3Ps1tc3kpSsdJLahNxI71BcBNDN8RtEtlyhaMr7lCclPXZbboxObdduzxqJQ0PVdWNBQ0DWGBRXX4hw77WG814zN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753052815; c=relaxed/simple;
	bh=emHV5RQ/RrniE4MPPCCTB1Pwwx//e94/Z9PsguhmOpk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=kOMzAF4FmozDfZ4QQcB5t5ZnPK+R9eZKp7zejBatWD8ej2VvCrUVykP5WTU5wfmxO4QUf9EckQMWsMkHTuHeZRn30n6i6ntqM7vKvIcYB4F3AGfvkr9hoPPa46p8K+TxFDU5oovYOonNSiIHGoejyYqdGS7W1Y/5potwQajMMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9zY/gPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D56C4CEE7;
	Sun, 20 Jul 2025 23:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753052814;
	bh=emHV5RQ/RrniE4MPPCCTB1Pwwx//e94/Z9PsguhmOpk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=B9zY/gPgqMz3F7IdOsfY7DjaSwvImwGVCx00hBMxc2qSLPfvk1fAi35R5xs542RFB
	 5QEoBnPyRx8mdc9CV2+5mXfQnJawpZKHv1/IH6Zz1BtnDfDOzHhDvK0B/AKK8QuoRy
	 rf75S+Yjn86phaTGRruXlelzORPX+iH7doH2yPiq3V9WlnY7m6QNs+cZHADlq3MPnH
	 AlHxgcAUdUbg28hYQ30RLRT+vsajrVO/ESE6l0WAc07OsY259nUHDkCbQl9m/TKl07
	 5DqHNspUf6Wio9bPmX/1mrWdwDchQB4Ii6DqF8qiQ8GD80/Yk9oDDW4jgZGo4HtXQb
	 PYvrRGOcaILqg==
Date: Sun, 20 Jul 2025 18:06:53 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, Maxime Ripard <mripard@kernel.org>, 
 linux-kernel@vger.kernel.org, Alain Volmat <alain.volmat@foss.st.com>, 
 Conor Dooley <conor+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
In-Reply-To: <20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com>
References: <20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com>
Message-Id: <175305254683.3034354.17781723128972055309.robh@kernel.org>
Subject: Re: [PATCH 0/4] STi device-tree display subsystem rework


On Thu, 17 Jul 2025 21:15:31 +0200, Raphael Gallais-Pou wrote:
> This serie aims to rework the display-subsystem node, which was
> previously included directly within the SoC node.  This was wrong
> because it is an abstraction and describes how IPs behave together, not
> what the hardware is.  Instead, extract display-subsystem outside of the
> SoC node, and let IPs describe their connections.  Doing so helps the
> readability, and eases the understanding of the hardware.
> 
> Several nodes have been renamed to stick to the generic names defined in
> the device-tree specification.
> 
> This series depends on another sent a few days ago.  It is not critical
> though, since not having it only triggers warnings when building
> deprecated device-trees.  Please see link below.
> 
> Link: https://lore.kernel.org/lkml/20250714-sti-rework-v2-0-f4274920858b@gmail.com
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
> Raphael Gallais-Pou (4):
>       drm/sti: check dma_set_coherent_mask return value
>       drm/sti: make use of drm_of_component_probe
>       ARM: dts: sti: extract display subsystem out of soc
>       ARM: dts: sti: remove useless cells fields
> 
>  arch/arm/boot/dts/st/stih410.dtsi | 316 ++++++++++++++++++++++----------------
>  drivers/gpu/drm/sti/sti_drv.c     |  18 +--
>  2 files changed, 192 insertions(+), 142 deletions(-)
> ---
> base-commit: b9a572f471993d3e8bf874fcb57f331d66650440
> change-id: 20250401-sti-rework-b009551a362c
> 
> Best regards,
> --
> Raphael Gallais-Pou <rgallaispou@gmail.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: base-commit b9a572f471993d3e8bf874fcb57f331d66650440 not known, ignoring
 Base: attempting to guess base-commit...
 Base: tags/v6.16-rc1-11-g2436e190bbdd (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/st/' for 20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com:

arch/arm/boot/dts/st/stih410-b2120.dtb: soc (simple-bus): sti-display-subsystem@0: 'anyOf' conditional failed, one must be fixed:
	'reg' is a required property
	'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm/boot/dts/st/stih410-b2120.dtb: /soc/display-controller@9d11000: failed to match any schema with compatible: ['st,stih407-compositor']
arch/arm/boot/dts/st/stih410-b2120.dtb: /soc/encoder@8d08000: failed to match any schema with compatible: ['st,stih407-tvout']
arch/arm/boot/dts/st/stih410-b2120.dtb: encoder@8d08000 (st,stih407-tvout): 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
arch/arm/boot/dts/st/stih410-b2120.dtb: /soc/hdmi@8d04000: failed to match any schema with compatible: ['st,stih407-hdmi']
arch/arm/boot/dts/st/stih410-b2260.dtb: /soc/display-controller@9d11000: failed to match any schema with compatible: ['st,stih407-compositor']
arch/arm/boot/dts/st/stih410-b2120.dtb: /soc/analog@8d02000: failed to match any schema with compatible: ['st,stih407-hda']
arch/arm/boot/dts/st/stih410-b2120.dtb: /soc/plane@9c00000: failed to match any schema with compatible: ['st,stih407-hqvdp']
arch/arm/boot/dts/st/stih410-b2260.dtb: /soc/encoder@8d08000: failed to match any schema with compatible: ['st,stih407-tvout']
arch/arm/boot/dts/st/stih410-b2260.dtb: encoder@8d08000 (st,stih407-tvout): 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
arch/arm/boot/dts/st/stih410-b2260.dtb: /soc/hdmi@8d04000: failed to match any schema with compatible: ['st,stih407-hdmi']
arch/arm/boot/dts/st/stih410-b2260.dtb: /soc/analog@8d02000: failed to match any schema with compatible: ['st,stih407-hda']
arch/arm/boot/dts/st/stih410-b2260.dtb: /soc/plane@9c00000: failed to match any schema with compatible: ['st,stih407-hqvdp']
arch/arm/boot/dts/st/stih410-b2120.dtb: /display-subsystem: failed to match any schema with compatible: ['st,sti-display-subsystem']
arch/arm/boot/dts/st/stih410-b2120.dtb: display-subsystem (st,sti-display-subsystem): 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
arch/arm/boot/dts/st/stih410-b2260.dtb: /display-subsystem: failed to match any schema with compatible: ['st,sti-display-subsystem']
arch/arm/boot/dts/st/stih410-b2260.dtb: display-subsystem (st,sti-display-subsystem): 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#






