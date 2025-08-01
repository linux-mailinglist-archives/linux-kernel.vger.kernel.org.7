Return-Path: <linux-kernel+bounces-752963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2A1B17D1A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F401886779
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0EA1FAC42;
	Fri,  1 Aug 2025 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XZD1SFxU"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7A2E3709;
	Fri,  1 Aug 2025 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032164; cv=none; b=nLy3p1LSLxIQBXYFyw6tZHJpLHPMpiCSC8BP7jZWVWckXpGBS1iSrsos5FuFI58sDC//uSbTVR6C2GAW+LfP4Mi1yTrgKrF7Jkd30wCUs38qA7GOOuU48uy6B5uc05fNRprYTQrYA2zFXShEwUWU7JaEuzwN0m0AuukdLXZFtBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032164; c=relaxed/simple;
	bh=1jkF4ywknW5+lLr4t7bPNvAeL+uE/YEK/XyaOnr9i0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LPVO9/JkeLfHtPU9ht3wrI3eUbaWHL1Yw9a8hzHhPtQbhoyU7jXbGWROAx0ZbtSaXwk2tibJKK9cix0L+RIB1NyBIXJd9+vaOvuV5jqar582czGo6iHCKpn3PBGnIZIwdZjUq90WoESH/BN7i4u/hVX1NenromYlWme22fC3uLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XZD1SFxU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 704e8f5a6ea611f0b33aeb1e7f16c2b6-20250801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=c8ULTO9RcU8KETwiMOBzfaheYWRJeLf8x+TFxOvGL1c=;
	b=XZD1SFxU9baAbs4qMapA0/0GhP8rDrS2YoTAdARN3IG4QmvnNSUfLRSduf7bXiQW3CUh5wTgprpM5AWnesjQj4dgVxHhIJkf5qiEv+8S7Q91kMVbrFNChdd1340MNFm2T/CtNyW8yhmqY7BSWOLvwpHHmH8IHoUFW6zBLfy9fCs=;
X-CID-CACHE: Type:Local,Time:202508011430+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:335c27f4-f71b-4ac7-9017-bc8e02136c7e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:69e77e9a-32fc-44a3-90ac-aa371853f23f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|110|817,TC:0,Content:-50|-10|-8|
	-7|-6|-5|14,EDM:-3,IP:nil,URL:0,File:6,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,USB|NGT
X-CID-BAS: 2,USB|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-VIRUS: cid:0,bav:0
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 704e8f5a6ea611f0b33aeb1e7f16c2b6-20250801
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <niklaus.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 856501299; Fri, 01 Aug 2025 15:09:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 1 Aug 2025 15:09:15 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 1 Aug 2025 15:09:14 +0800
From: niklaus.liu <niklaus.liu@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Flora Fu
	<flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, niklaus.liu
	<niklaus.liu@mediatek.com>
Subject:
Date: Fri, 1 Aug 2025 14:39:34 +0800
Message-ID: <20250801070913.3109-1-niklaus.liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Subject: [MT8189] Pwrap/SPMI/regulator driver

Add support for MT8188 Pwrap,SPMI driver,add dt-bindings description related.
modify mt6315 regulator buck function.

niklaus.liu (3):
  dt-bindings: mediatek : add binding for pwrap,spmi
  soc:mediatek  mt8189: Porting driver for spmi/pwrap
  regulator: Modify mt6315 regulator mode mask

 .../bindings/soc/mediatek/mediatek,pwrap.yaml |  1 +
 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      |  1 +
 drivers/regulator/mt6315-regulator.c          |  6 +++++
 drivers/soc/mediatek/mtk-pmic-wrap.c          | 27 +++++++++++++++++++
 drivers/spmi/spmi-mtk-pmif.c                  |  3 +++
 5 files changed, 38 insertions(+)

-- 
2.46.0


