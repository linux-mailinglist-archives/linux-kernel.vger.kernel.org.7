Return-Path: <linux-kernel+bounces-879605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDDC2390D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9F93B08B0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A5E32AAA6;
	Fri, 31 Oct 2025 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IlwmoIaI"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FF329C7A;
	Fri, 31 Oct 2025 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895956; cv=none; b=ABlePVKotOF+lTUg5q2C87zxUVWB3TgucORThlwI7D90B4Lfo08nTr2fEFZlzgcYQJAq36QcAzy4Rbzdf7IYupJLS6lwHpQKRTAWwzbLJuSFJ691XvDkS/Hy99GZx0gq9KTb+xMGoHNAB+yJRMPGEjhAkkyF/U20P7Rx4dfvEWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895956; c=relaxed/simple;
	bh=/x/YvjEp5yjSDc4AXtliKMadeGfaBM99iQAQNwi/zsk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A2iuPdKD/d3gER5WYgodXekBG3G9dWzi5S8/vRE+Au5+v1AJEYQgpkIS2OAE5jGWuqDZ9fAPgYNGEQdG4hVlfH9eD3MnD8OEBB5auQxt/UreAbhA9BpD3dgSglUx2kylOUhZ2VBsurv9YTDaHXgxYHCaj7yIpF1lQCxKzDoeSdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IlwmoIaI; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c12514aeb62b11f0b33aeb1e7f16c2b6-20251031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IUNEBOxFD6xbKWIsX6dDsySLLQp/Ba+RMkl0Vl7CkHI=;
	b=IlwmoIaIJ/N8TtHiCn49/wJDuFn+txgqfijlhAu6P2ocQ/Ba/rUhKh9wwo9qD5UDO2cBkC3MDjr3DNSLvKTgsl9ipO+vmY+3CgE35WHX6xU9EtTvx5WCKSAW4Q56M6HBfow/l8ynwRFHueRia6opyWJGoL8TXx90bm1xWW0DdTE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:c348cbd5-e186-462e-9fdd-d8ccb93d845b,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:474b7626-cfd6-4a1d-a1a8-72ac3fdb69c4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c12514aeb62b11f0b33aeb1e7f16c2b6-20251031
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <cyril.chao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1784688552; Fri, 31 Oct 2025 15:32:28 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 31 Oct 2025 15:32:28 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 31 Oct 2025 15:32:27 +0800
From: Cyril Chao <Cyril.Chao@mediatek.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Cyril Chao <cyril.chao@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Cyril Chao
	<Cyril.Chao@mediatek.com>
Subject: [PATCH v3 00/10] ASoC: mediatek: Add support for MT8189 SoC
Date: Fri, 31 Oct 2025 15:31:54 +0800
Message-ID: <20251031073216.8662-1-Cyril.Chao@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Based on tag: next-20251031, linux-next/master

This series of patches adds support for Mediatek AFE of MT8189 SoC.
Patches are based on broonie tree "for-next" branch.

Changes in v3:
  - Added support for CS35L codec in the machine driver.
  - Added I2SOUT0/I2SOUT1 MCLK configuration and enabled the clocks.
  - Added dpcm_merged_format flag to the dai-link to ensure codec
    format constraints are applied.
  - Added support for ES8326 codec in the machine driver.
  - Updated the dt-bindings description based on reviewer comments.

Cyril Chao (10):
  ASoC: mediatek: mt8189: add common header
  ASoC: mediatek: mt8189: support audio clock control
  ASoC: mediatek: mt8189: support ADDA in platform driver
  ASoC: mediatek: mt8189: support I2S in platform driver
  ASoC: mediatek: mt8189: support TDM in platform driver
  ASoC: mediatek: mt8189: support PCM in platform driver
  ASoC: dt-bindings: mediatek,mt8189-afe-pcm: add audio afe document
  ASoC: mediatek: mt8189: add platform driver
  ASoC: dt-bindings: mediatek,mt8189-nau8825: add mt8189-nau8825
    document
  ASoC: mediatek: mt8189: add machine driver with nau8825

 .../sound/mediatek,mt8189-afe-pcm.yaml        |   178 +
 .../sound/mediatek,mt8189-nau8825.yaml        |   101 +
 sound/soc/mediatek/Kconfig                    |    31 +
 sound/soc/mediatek/Makefile                   |     1 +
 sound/soc/mediatek/mt8189/Makefile            |    18 +
 sound/soc/mediatek/mt8189/mt8189-afe-clk.c    |   750 ++
 sound/soc/mediatek/mt8189/mt8189-afe-clk.h    |    76 +
 sound/soc/mediatek/mt8189/mt8189-afe-common.h |   240 +
 sound/soc/mediatek/mt8189/mt8189-afe-pcm.c    |  2617 ++++
 sound/soc/mediatek/mt8189/mt8189-dai-adda.c   |  1228 ++
 sound/soc/mediatek/mt8189/mt8189-dai-i2s.c    |  1463 +++
 sound/soc/mediatek/mt8189/mt8189-dai-pcm.c    |   332 +
 sound/soc/mediatek/mt8189/mt8189-dai-tdm.c    |   672 +
 .../mediatek/mt8189/mt8189-interconnection.h  |    97 +
 sound/soc/mediatek/mt8189/mt8189-nau8825.c    |  1178 ++
 sound/soc/mediatek/mt8189/mt8189-reg.h        | 10773 ++++++++++++++++
 16 files changed, 19755 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8189-afe-pcm.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8189-nau8825.yaml
 create mode 100644 sound/soc/mediatek/mt8189/Makefile
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-dai-adda.c
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-dai-i2s.c
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-dai-pcm.c
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-dai-tdm.c
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-interconnection.h
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-nau8825.c
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-reg.h

-- 
2.45.2


