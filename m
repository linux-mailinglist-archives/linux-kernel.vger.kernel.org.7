Return-Path: <linux-kernel+bounces-802227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E23B44F45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8907BF7EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACE52D6E4E;
	Fri,  5 Sep 2025 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YhgA+1QE"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E78286D76;
	Fri,  5 Sep 2025 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056652; cv=none; b=F5uDkzn+RZBEXDfNjKyKKr3fs+yK4RjJ3d5aRhiSA6lWcFpokeG8A42BHixBYdayx5F9/PLXzYFej0Uv8Q+Ct6tMFnkHy7AtjJ8+0XIkvmQpjsKwcp5KQ13WW9LAxHMfkreEAR1Tw5HoX4dRq3PMtd2J8dzO3Z5T+xH8ZT+TLZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056652; c=relaxed/simple;
	bh=zvzF3I22x58AKMut8FakhVAUJz47DBp4si0JPq3EADc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YRzBtVWWj33fNuWXmaRXZFqtIAowIQmVR+93DPutaS+EA2Dsk10ETKRdfS8e4Y2nRodQnrRQUHkx/yB8a5gc9Mt1izETQyY9tCGRL/yxwntOS2aU0HG5GImRIPtrz2Bturf9TLp1hZEI/82W+5RZlIFFaus3YR9Wi6ZnPrhwMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YhgA+1QE; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5b99d82e8a2811f0b33aeb1e7f16c2b6-20250905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1ErL5bVo2x3f2K2HF24mhghjLaSR58ICwgymuW5068A=;
	b=YhgA+1QE+EYeQAi6AsS1h2Ug49sTte5kMzkxxGHTNJtrxMBHl2cExVbNhpjNucVragecg/nXkGDU3eooyhBnmJfhqQ2GT78XFyWKBxAnswEFZdVmBgyx5TBV3UmPe2f/DHKRIOWJlKF59E62ZodExzbvDcxbCi2AEoGAP7u9NCA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:b33041a0-032b-42ef-acbe-f079c8495939,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:21303b6c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5b99d82e8a2811f0b33aeb1e7f16c2b6-20250905
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <cyril.chao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1288314928; Fri, 05 Sep 2025 15:17:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 5 Sep 2025 15:17:14 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 5 Sep 2025 15:17:13 +0800
From: Cyril Chao <Cyril.Chao@mediatek.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Darren Ye
	<darren.ye@mediatek.com>, Cyril Chao <cyril.chao@mediatek.com>
CC: <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Cyril Chao
	<Cyril.Chao@mediatek.com>
Subject: [PATCH v2 00/10] ASoC: mediatek: Add support for MT8189 SoC
Date: Fri, 5 Sep 2025 15:15:45 +0800
Message-ID: <20250905071659.25805-1-Cyril.Chao@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N

Based on tag: next-20250903, linux-next/master

This series of patches adds support for Mediatek AFE of MT8189 SoC.
Patches are based on broonie tree "for-next" branch.

Changes in v2:
This version refines the implementation of the MT8189 audio driver,
leveraging the feedback and comments provided during the review of the 
MT8196 v6 patch series since they have samilar code structure.
  - Refined the I2S DAI implementation based on reviewer comments,
    removed unused widgets.
  - Refined the TDM DAI implementation based on reviewer comments,
    optimized the MUX widget flow.
  - Refined the ADDA DAI implementation based on reviewer comments.
  - Refined the PCM DAI implementation based on reviewer comments.
  - Refined the platform driver based on reviewers comments, optimized
    the Channel Merge(CM) related flow.
  - Moved the pinctrl widget from the machine driver to the platform
    driver based on reviewer comments.
  - Removed unused clock initialization and settings to reduce redundancy.
  - Added a restriction to limit the sample rate to 48kHz.
  - Updated the machine driver’s compatible name as per the reviewer’s suggestions.
  - Modify the patch order of the dt-bindings and driver implementation.

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

 .../sound/mediatek,mt8189-afe-pcm.yaml        |   162 +
 .../sound/mediatek,mt8189-nau8825.yaml        |   101 +
 sound/soc/mediatek/Kconfig                    |    28 +
 sound/soc/mediatek/Makefile                   |     1 +
 sound/soc/mediatek/mt8189/Makefile            |    18 +
 sound/soc/mediatek/mt8189/mt8189-afe-clk.c    |   738 ++
 sound/soc/mediatek/mt8189/mt8189-afe-clk.h    |    72 +
 sound/soc/mediatek/mt8189/mt8189-afe-common.h |   238 +
 sound/soc/mediatek/mt8189/mt8189-afe-pcm.c    |  2617 ++++
 sound/soc/mediatek/mt8189/mt8189-dai-adda.c   |  1228 ++
 sound/soc/mediatek/mt8189/mt8189-dai-i2s.c    |  1463 +++
 sound/soc/mediatek/mt8189/mt8189-dai-pcm.c    |   332 +
 sound/soc/mediatek/mt8189/mt8189-dai-tdm.c    |   672 +
 .../mediatek/mt8189/mt8189-interconnection.h  |    97 +
 sound/soc/mediatek/mt8189/mt8189-nau8825.c    |  1041 ++
 sound/soc/mediatek/mt8189/mt8189-reg.h        | 10773 ++++++++++++++++
 16 files changed, 19581 insertions(+)
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


