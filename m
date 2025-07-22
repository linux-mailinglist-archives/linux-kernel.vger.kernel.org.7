Return-Path: <linux-kernel+bounces-741211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF47B0E180
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F52563EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FAE27A909;
	Tue, 22 Jul 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttZmMtvR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1F223B60F;
	Tue, 22 Jul 2025 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201082; cv=none; b=F0v9A58DMwubSrGbglLJ5hP2z4416qE8QnzuFE4KT8KjyI5lTqe9lurd2ujqeV/him72ipidM5KqKZxDrIWguRptHSM+O+YW7ZGw0aHCjKihPmils2JloMN6gcPN3sii7VMCLrVmufm5YoDkNqHPyZs9MMh2/IBIVy+8bE1wRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201082; c=relaxed/simple;
	bh=yjS80vPxjMJCNr9tnhhU3iSJTGyP21dlZvKU/OvWtds=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=P9m4LhDxURXnU/VBpfG4BIDlzw3rAzy8Fv4c6lGzCl0FXevZUbbIf+wL3CwW566vcYIFpIyt6qQDT/rt/7YWcC+WZTBzhn/ENkLrQ7KZnEdFOtDS9qviIOUjZvDBTcJrpFlYj3yEow2hVAP779R+f57WFjzOIDqUY4LQuvX4S80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttZmMtvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92C4C4CEF1;
	Tue, 22 Jul 2025 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201082;
	bh=yjS80vPxjMJCNr9tnhhU3iSJTGyP21dlZvKU/OvWtds=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ttZmMtvRfY+DBptFFGd91cD0D9zwmkXKiM38X1A1RpyQCJUe683oAIcrTjwp3eVxT
	 lR9cWqgP0vnPSbVe9e/lE/DfoszEZcRRFp95VksjonbRVcbRaHfG590cs/H7IO6sdc
	 6i0UtgTlY8WV+E7BJPiWqXb3JZidTZLAuTruCpssg1LkOOJ+eUVjP210EQ6Sc5k9Qn
	 rD1tc0qGMbF/q9Bow2n19+iMIMswrE4kd0yZ6Gr+NQ1NmgP2vWDx2Ofxbps3pUZs4z
	 Uw0bVw6rj634J94mEgAeJXfoubXtcQd1bZlf2SBf0mA3NWxE+3zYDV2+MuMs3hcwlR
	 /GRMTwS0CLXjQ==
Date: Tue, 22 Jul 2025 11:18:01 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, 
 Conor Dooley <conor+dt@kernel.org>
To: Erik Beck <xunil@tahomasoft.com>
In-Reply-To: <20250721201714.233962-1-xunil@tahomasoft.com>
References: <20250721201714.233962-1-xunil@tahomasoft.com>
Message-Id: <175320094809.3954940.10517428670274309157.robh@kernel.org>
Subject: Re: [PATCH 2/2 v2a]: New board support,LinkStar-H68k-1432v1
 (RK3568)


On Mon, 21 Jul 2025 16:17:12 -0400, Erik Beck wrote:
> 
> Signed-off-by: Erik Beck <xunil@tahomasoft.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../rockchip/rk3568-linkstar-h68k-1432v1.dts  | 740 ++++++++++++++++++
>  2 files changed, 741 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-linkstar-h68k-1432v1.dts
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
 Base: attempting to guess base-commit...
 Base: tags/v6.16-rc3-17-g404dcaa62651 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250721201714.233962-1-xunil@tahomasoft.com:

arch/arm64/boot/dts/rockchip/rk3568-linkstar-h68k-1432v1.dtb: / (seeed,rk3568-linkstar-h68k-1432v1): compatible: 'oneOf' conditional failed, one must be fixed:
	['seeed,rk3568-linkstar-h68k-1432v1', 'rockchip,rk3568'] is too short
	'vamrs,ficus' was expected
	'vamrs,rock960' was expected
	'amarula,vyasa-rk3288' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['anbernic,rg351m', 'anbernic,rg351v']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['anbernic,rg353p', 'anbernic,rg353ps', 'anbernic,rg353v', 'anbernic,rg353vs', 'anbernic,rg503', 'anbernic,rg-arc-d', 'anbernic,rg-arc-s']
	'ariaboard,photonicat' was expected
	'armsom,sige5' was expected
	'armsom,sige7' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['armsom,w3']
	'asus,rk3288-tinker' was expected
	'asus,rk3288-tinker-s' was expected
	'azw,beelink-a1' was expected
	'bigtreetech,cb2-manta' was expected
	'bigtreetech,pi2' was expected
	'mundoreader,bq-curie2' was expected
	'mundoreader,bq-edison2qc' was expected
	'chipspark,popmetal-rk3288' was expected
	'chipspark,rayeager-px2' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['coolpi,pi-cm5-evb']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['coolpi,pi-cm5-genbook']
	'coolpi,pi-4b' was expected
	'edgeble,neural-compute-module-2-io' was expected
	'edgeble,neural-compute-module-6a-io' was expected
	'elgin,rv1108-r1' was expected
	'embedfire,lubancat-1' was expected
	'embedfire,lubancat-2' was expected
	'engicam,px30-core-ctouch2' was expected
	'engicam,px30-core-ctouch2-of10' was expected
	'engicam,px30-core-edimm2.2' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['mntre,reform2-rcore']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['firefly,itx-3588j']
	'firefly,px30-jd4-core-mb' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['firefly,firefly-rk3288', 'firefly,firefly-rk3288-beta']
	'firefly,firefly-rk3288-reload' was expected
	'firefly,firefly-rk3399' was expected
	'firefly,roc-rk3308-cc' was expected
	'firefly,roc-rk3328-cc' was expected
	'firefly,roc-rk3328-pc' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['firefly,roc-rk3399-pc', 'firefly,roc-rk3399-pc-mezzanine']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['firefly,roc-rk3399-pc-plus']
	'firefly,roc-rk3576-pc' was expected
	'firefly,rk3566-roc-pc' was expected
	'firefly,rk3568-roc-pc' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['forlinx,ok3588-c']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['friendlyarm,nanopi-r2c', 'friendlyarm,nanopi-r2c-plus', 'friendlyarm,nanopi-r2s', 'friendlyarm,nanopi-r2s-plus']
	'friendlyarm,nanopi-r3s' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['friendlyarm,nanopc-t4', 'friendlyarm,nanopi-m4', 'friendlyarm,nanopi-m4b', 'friendlyarm,nanopi-neo4', 'friendlyarm,nanopi-r4s', 'friendlyarm,nanopi-r4s-enterprise']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['friendlyarm,nanopi-r5c', 'friendlyarm,nanopi-r5s']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['friendlyarm,nanopi-r6c', 'friendlyarm,nanopi-r6s']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['friendlyarm,nanopc-t6', 'friendlyarm,nanopc-t6-lts']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['friendlyarm,cm3588-nas']
	'gameforce,ace' was expected
	'gameforce,chi' was expected
	'geekbuying,geekbox' was expected
	'geniatech,xpi-3128' was expected
	'google,bob-rev13' was expected
	'google,veyron-brain-rev0' was expected
	'google,veyron-fievel-rev8' was expected
	'google,gru-rev15' was expected
	'google,veyron-jaq-rev5' was expected
	'google,veyron-jerry-rev15' was expected
	'google,kevin-rev15' was expected
	'google,veyron-mickey-rev8' was expected
	'google,veyron-mighty-rev5' was expected
	'google,veyron-minnie-rev4' was expected
	'google,veyron-pinky-rev2' was expected
	'google,scarlet-rev15-sku0' was expected
	'google,scarlet-rev15-sku7' was expected
	'google,scarlet-rev15-sku2' was expected
	'google,veyron-speedy-rev9' was expected
	'google,veyron-tiger-rev8' was expected
	'haochuangyi,h96-max-v58' was expected
	'haoyu,marsboard-rk3066' was expected
	'hardkernel,rk3326-odroid-go2' was expected
	'hardkernel,rk3326-odroid-go2-v11' was expected
	'hardkernel,rk3326-odroid-go3' was expected
	'hardkernel,odroid-m1' was expected
	'hardkernel,odroid-m1s' was expected
	'hardkernel,odroid-m2' was expected
	'hugsun,x99' was expected
	'indiedroid,nova' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['khadas,edge', 'khadas,edge-captain', 'khadas,edge-v']
	'khadas,edge2' was expected
	'kobol,helios64' was expected
	'mecer,xms6' was expected
	'leez,p710' was expected
	'lckfb,tspi-rk3566' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['lunzn,fastrhino-r66s', 'lunzn,fastrhino-r68s']
	'mqmaker,miqi' was expected
	'neardi,lba3368' was expected
	'netxeon,r89' was expected
	'openailab,eaidk-610' was expected
	'xunlong,rk3399-orangepi' was expected
	'phytec,rk3288-pcm-947' was expected
	'pine64,pinebook-pro' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['pine64,pinenote-v1.1', 'pine64,pinenote-v1.2']
	'pine64,pinephone-pro' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['pine64,pinetab2-v0.1', 'pine64,pinetab2-v2.0']
	'pine64,rock64' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['pine64,rockpro64-v2.1', 'pine64,rockpro64-v2.0']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['pine64,quartz64-a', 'pine64,quartz64-b']
	'pine64,quartzpro64' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['pine64,soquartz-blade', 'pine64,soquartz-cm4io', 'pine64,soquartz-model-a']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['powkiddy,rgb10max3', 'powkiddy,rgb20sx', 'powkiddy,rgb30', 'powkiddy,rk2023', 'powkiddy,x55']
	'prt,mecsbc' was expected
	'qnap,ts433' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['radxa,cm3-io']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['radxa,e25']
	'radxa,e20c' was expected
	'radxa,e52c' was expected
	'radxa,rock' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['radxa,rockpi4a', 'radxa,rockpi4a-plus', 'radxa,rockpi4b', 'radxa,rockpi4b-plus', 'radxa,rockpi4c']
	'radxa,rock-4c-plus' was expected
	'radxa,rock-4d' was expected
	'radxa,rock-4se' was expected
	'radxa,rockpi-e' was expected
	'radxa,rockpi-n8' was expected
	'radxa,rockpi-n10' was expected
	'radxa,rockpis' was expected
	'radxa,rock2-square' was expected
	'radxa,rock3a' was expected
	'radxa,rock-3b' was expected
	'radxa,rock-3c' was expected
	'radxa,rock-5-itx' was expected
	'radxa,rock-5a' was expected
	'radxa,rock-5b' was expected
	'radxa,rock-5b-plus' was expected
	'radxa,rock-5c' was expected
	'radxa,rock-s0' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['radxa,zero-3e', 'radxa,zero-3w']
	'relfor,saib' was expected
	'rikomagic,mk808' was expected
	'rockchip,rk3036-kylin' was expected
	'rockchip,px3-evb' was expected
	'rockchip,px30-evb' was expected
	'rockchip,px5-evb' was expected
	'rockchip,r88' was expected
	'rockchip,rk3036-evb' was expected
	'rockchip,rk3128-evb' was expected
	'rockchip,rk3228-evb' was expected
	'rockchip,rk3229-evb' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['rockchip,rk3288-evb-act8846', 'rockchip,rk3288-evb-rk808']
	'rockchip,rk3308-evb' was expected
	'rockchip,rk3328-evb' was expected
	'rockchip,rk3368-evb-act8846' was expected
	'rockchip,rk3399-evb' was expected
	'rockchip,rk3399-evb-ind' was expected
	'rockchip,rk3399-sapphire' was expected
	'rockchip,rk3399-sapphire-excavator' was expected
	'rockchip,rk3562-evb2-v10' was expected
	'rockchip,rk3566-box-demo' was expected
	'rockchip,rk3568-evb1-v10' was expected
	'rockchip,rk3576-evb1-v10' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['rockchip,rk3588-evb1-v10', 'rockchip,rk3588-evb2-v10']
	'rockchip,rk3588s-evb1-v10' was expected
	'rockchip,rv1108-evb' was expected
	'rockchip,rk3588-toybrick-x0' was expected
	'sinovoip,rk3308-bpi-p2pro' was expected
	'sinovoip,rk3568-bpi-r2pro' was expected
	'itead,sonoff-ihost' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['tsd,px30-cobra-ltk050h3146w', 'tsd,px30-cobra-ltk050h3146w-a2', 'tsd,px30-cobra-ltk050h3148w', 'tsd,px30-cobra-ltk500hd1829']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['tsd,px30-pp1516-ltk050h3146w-a2', 'tsd,px30-pp1516-ltk050h3148w']
	'tsd,px30-ringneck-haikou' was expected
	'tsd,rk3368-lion-haikou' was expected
	'tsd,rk3399-puma-haikou' was expected
	'tsd,rk3588-jaguar' was expected
	'tsd,rk3588-tiger-haikou' was expected
	'tronsmart,orion-r68-meta' was expected
	'turing,rk1' was expected
	'wolfvision,rk3568-pf5' was expected
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['xunlong,orangepi-3b-v1.1', 'xunlong,orangepi-3b-v2.1']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['xunlong,orangepi-5-max', 'xunlong,orangepi-5-plus', 'xunlong,orangepi-5-ultra']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['xunlong,orangepi-r1-plus', 'xunlong,orangepi-r1-plus-lts']
	'seeed,rk3568-linkstar-h68k-1432v1' is not one of ['xunlong,orangepi-5', 'xunlong,orangepi-5b']
	'zkmagic,a95x-z2' was expected
	'rockchip,rk3399' was expected
	'rockchip,rk3288' was expected
	'rockchip,rk3326' was expected
	'rockchip,rk3566' was expected
	'rockchip,rk3576' was expected
	'rockchip,rk3588' was expected
	'armsom,lm7' was expected
	'rockchip,rk3328' was expected
	'bigtreetech,cb2' was expected
	'rockchip,rk3066a' was expected
	'rockchip,rk3188' was expected
	'coolpi,pi-cm5' was expected
	'rockchip,rk3588s' was expected
	'edgeble,neural-compute-module-2' was expected
	'rockchip,rk3568' is not one of ['edgeble,neural-compute-module-6a', 'edgeble,neural-compute-module-6b']
	'rockchip,rv1108' was expected
	'engicam,px30-core' was expected
	'firefly,icore-3588q' was expected
	'firefly,core-3588j' was expected
	'firefly,px30-jd4-core' was expected
	'rockchip,rk3308' was expected
	'forlinx,fet3588-c' was expected
	'friendlyarm,cm3588' was expected
	'rockchip,rk3368' was expected
	'rockchip,rk3128' was expected
	'google,bob-rev12' was expected
	'google,veyron-brain' was expected
	'google,veyron-fievel-rev7' was expected
	'google,gru-rev14' was expected
	'google,veyron-jaq-rev4' was expected
	'google,veyron-jerry-rev14' was expected
	'google,kevin-rev14' was expected
	'google,veyron-mickey-rev7' was expected
	'google,veyron-mighty-rev4' was expected
	'google,veyron-minnie-rev3' was expected
	'google,veyron-pinky' was expected
	'google,scarlet-rev15' was expected
	'google,scarlet-rev15-sku4' was expected
	'google,veyron-speedy-rev8' was expected
	'google,veyron-tiger-rev7' was expected
	'rockchip,rk3229' was expected
	'phytec,rk3288-phycore-som' was expected
	'pine64,pinenote' was expected
	'pine64,pinetab2' was expected
	'pine64,rockpro64' was expected
	'pine64,soquartz' was expected
	'radxa,cm3' was expected
	'radxa,cm3i' was expected
	'rockchip,rk3528' was expected
	'rockchip,rk3582' was expected
	'radxa,rockpi4' was expected
	'vamrs,rk3288-vmarc-som' was expected
	'vamrs,rk3399pro-vmarc-som' was expected
	'rockchip,rv1109' was expected
	'rockchip,rk3036' was expected
	'rockchip,px3' was expected
	'rockchip,px30' was expected
	'rockchip,px5' was expected
	'rockchip,rk3228' was expected
	'rockchip,rk3562' was expected
	'rockchip,rk3568' is not one of ['rockchip,rv1126', 'rockchip,rv1109']
	'tsd,px30-cobra' was expected
	'tsd,px30-pp1516' was expected
	'tsd,rk3588-tiger' was expected
	'xunlong,orangepi-3b' was expected
	'rockchip,rk3318' was expected
	from schema $id: http://devicetree.org/schemas/arm/rockchip.yaml#
arch/arm64/boot/dts/rockchip/rk3568-linkstar-h68k-1432v1.dtb: /: failed to match any schema with compatible: ['seeed,rk3568-linkstar-h68k-1432v1', 'rockchip,rk3568']






