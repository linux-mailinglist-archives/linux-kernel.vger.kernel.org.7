Return-Path: <linux-kernel+bounces-833961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDC4BA36C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE89E7B2A01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399582F363D;
	Fri, 26 Sep 2025 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="tO7fiBFK"
Received: from mx07-007fc201.pphosted.com (mx07-007fc201.pphosted.com [185.132.181.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56A2F2615;
	Fri, 26 Sep 2025 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.181.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884510; cv=none; b=OhDB45pBOp8PVKxYRSfISgbjqaqO6TvGzsZiod1bjsAN4DCouqYbAe+h3UJqH2n1Caf+P0aLLEGM4DRTfdKCcksq+vhJ6lJW8XxSto7JbRmgDWGvNu/DQyLDW++Lz6O6raqRFR2uBawPRJE1NuqzD+vgivb40SDsPXEd91CXask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884510; c=relaxed/simple;
	bh=ypbB64g64hLiHsaXRhzRYoFbG+JnL5Ml3OwN5Xb5KQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A7TTvYpoaFXNeYS+iK+BCRRAW4TckywtMABC2LFD8tgG+dHcOC4Dk50iYhyXaKRn87eT2SRhNM1f+rza1oUoSYo9cI1Kzy3Ikux18It6N6Bhopkc+KPHmWSDfBGHwJQMJnkwE7bNm0xwXvIXb2gyIVLNEy2KJYLQp+96iNn8HNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=tO7fiBFK; arc=none smtp.client-ip=185.132.181.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456228.ppops.net [127.0.0.1])
	by mx07-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58QAw1Ke1882429;
	Fri, 26 Sep 2025 12:58:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp-2025; bh=poH4Zv3BSEZZRfeBs/BYP0qb
	hDlbX80PMCX4Nlcr1pM=; b=tO7fiBFK3kRRVGhyacES/BNN25iVkXIx2Rw1tkNN
	iqh2HihN23I+YiSGuVoFsQHeSbSMyVAHiJiMMhS14ldwSHhjHS14E7SwFH+ocOCW
	IshjHy4n6dhWF4HRpjYa4GoxJKmQ+lbQBb9tP+tSDGtsDk+xWx2x18Q6fxwRV7NJ
	MxWmoIMbuRFce4n7EWr/k1GUjVq4UGPvVeLXXaSQ7lx5rC9JRKjQhfLU4dFtehcr
	8x4YIgwCewPxruI2WM+S4fZkESO0+rNngDjB7DHyY7/vLv5bg/a2j/GtAIuWCmWO
	iw1Vyvz50CZeeplbsQ+bb7byCI8QgyXF1U2K3hTTGAC2pg==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx07-007fc201.pphosted.com (PPS) with ESMTPS id 49dbt3g7x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 12:58:01 +0200 (MEST)
Received: from KAN23-025.cab.de (10.10.3.180) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Fri, 26 Sep
 2025 12:58:17 +0200
From: Markus Heidelberg <m.heidelberg@cab.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Markus
 Heidelberg <m.heidelberg@cab.de>
Subject: [PATCH 0/3] Spelling and typo fixes in devicetree documentation
Date: Fri, 26 Sep 2025 12:57:46 +0200
Message-ID: <20250926105749.209674-1-m.heidelberg@cab.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Adranos.cab.de (10.10.1.54) To Adranos.cab.de (10.10.1.54)
X-Authority-Analysis: v=2.4 cv=fOA0HJae c=1 sm=1 tr=0 ts=68d671b9 cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=kldc_9v1VKEA:10 a=yJojWOMRYYMA:10 a=1X8hm8xGiD6ghu71sTcA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ydhUAsWeJpKilqdfkDQ3AlmjcOmNlcwq
X-Proofpoint-ORIG-GUID: ydhUAsWeJpKilqdfkDQ3AlmjcOmNlcwq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEwMCBTYWx0ZWRfX/SlYGYxSShfb
 B8lmyM0eGE8eExyHe+eAPUGfO7UktBtVTru8EJndr3w6hDsTtxuT99ZFsVuhnC5f+hQxOenCnEy
 zZSUfoQkRQfOWkWU8mVbOpooiv6umTf+9EKdRhgHa9r+TkkX05YAuAbBHoBHBRojkikaRkN4X83
 r3lF2TXW6yVYq4Rp2t/NC7QSGv2NJzoho9jst4OlZW+NP8kVWTUk1xvZWvPKk6diBH1myOeMR/m
 Sao3qFR82UaJGRi7YJwQl69Hl4g89EvlJx5A2+A9CMSLVea/5buHU9IQK1OfUcRyFExreTKVwV3
 Mr0kAbSl0cuJ9BjUhBI4TvihnA7yCJQ1xqTr/uV8k3ywU8YbpKJz7uVVemhWgQzGwaPk/NW7WJ8
 FLWZPBSJ6MhjJtCA0c1E1k/yhvpDNg==

Markus Heidelberg (3):
  docs: dt: fix grammar and spelling
  dt-bindings: fix spelling, typos, grammar, duplicated words
  scripts: dt_to_config: fix grammar and a typo in --help text

 .../devicetree/bindings/arm/arm,vexpress-juno.yaml   |  2 +-
 .../devicetree/bindings/example-schema.yaml          |  2 +-
 Documentation/devicetree/bindings/gpio/gpio.txt      | 12 ++++++------
 .../devicetree/bindings/iommu/mediatek,iommu.yaml    |  2 +-
 Documentation/devicetree/bindings/leds/common.yaml   |  2 +-
 .../devicetree/bindings/mfd/ti,lp87524-q1.yaml       |  2 +-
 .../devicetree/bindings/mfd/ti,lp87561-q1.yaml       |  2 +-
 .../devicetree/bindings/mfd/ti,lp87565-q1.yaml       |  2 +-
 .../bindings/mmc/mmc-controller-common.yaml          |  4 ++--
 .../devicetree/bindings/net/amlogic,meson-dwmac.yaml |  2 +-
 .../devicetree/bindings/net/ethernet-controller.yaml |  2 +-
 .../devicetree/bindings/net/ethernet-phy.yaml        |  2 +-
 .../devicetree/bindings/net/micrel-ksz90x1.txt       |  4 ++--
 Documentation/devicetree/bindings/net/micrel.txt     |  2 +-
 .../devicetree/bindings/submitting-patches.rst       |  2 +-
 Documentation/devicetree/of_unittest.rst             |  4 ++--
 Documentation/devicetree/overlay-notes.rst           |  6 +++---
 Documentation/devicetree/usage-model.rst             |  6 +++---
 scripts/dtc/dt_to_config                             |  8 ++++----
 19 files changed, 34 insertions(+), 34 deletions(-)


base-commit: e42136a03dca4f11547aea8a53b64b6668b45fe0
prerequisite-patch-id: 81e067eae729d71e41b653c4f550dd3449003592
prerequisite-patch-id: 21078cbf43929b4a0d56ab4bb4acea907af70d7a
prerequisite-patch-id: 068f9b31e37cd42f8f5f755d0950ccbf2e3d447b
-- 
2.43.0


