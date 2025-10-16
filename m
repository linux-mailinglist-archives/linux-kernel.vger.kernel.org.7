Return-Path: <linux-kernel+bounces-855840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5643EBE2765
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A6D3B4071
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85E4319855;
	Thu, 16 Oct 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WJPr3Vjd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782873168F1;
	Thu, 16 Oct 2025 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607603; cv=none; b=tc3bGksvrlDksvs8v72YvRGfpZVksn2IcRMFZlp8zlLU3Z0rZAendCjqEKeo2mKGAk65QIztSucZxGYT7iFTpYJc6GbnMUi+zb3O0hGNxw5RDmQYeeUI4JGCOVIjMPetKVVCDTv8JMmyywI+3iFQPiTum0JShWtCmovp1cInXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607603; c=relaxed/simple;
	bh=v6Ocrtosc6c0YJwqmFvARUqAbo+TYf5sq0Vgbnyd4hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DqhylZMOkP/F0Qzac1zLIcTFiZK5ZRd6AiY/FIykwZ64y+Pa1FZXxhBoneMk54pEGliqjcVoFv37Cr1tbFnfZnIltj1crp+HhMTwcHj+JoJ/ybDZdRRjr0KJGlRFIm/GCzijx6PZNeMmzlL6QOFawXQbmvDX/7ueSTLuSRxXPWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WJPr3Vjd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760607599;
	bh=v6Ocrtosc6c0YJwqmFvARUqAbo+TYf5sq0Vgbnyd4hg=;
	h=From:To:Cc:Subject:Date:From;
	b=WJPr3Vjdw+HdWcDIFPdO/syP44mZ1IaUzB+ayKkHlsTWZJKh8XfkxXS7o+7OqZyRe
	 nB/6NV7lFPvnYLJ67Ynfuui7Z9G5bQFsz2mxcyPAHdmlNs1Tl53vz3rYqrH6ihWuA7
	 4tONx1T8b/c05bmRqqxeE0aXkmjRrycoOryipiRotc883PsZKgLC8khY6TY6t6LgZ2
	 xWLAKh50t/OFs13RpkcQEb1Hl7hlHrTbUVE6PKy3l0DEr4BJAtMzeRb0zwiDS4yBD/
	 vAEkIETPtO1TfEAkHTcu9EF0AgehKrgB0xU2PP7UF/r936xLldidjORhcbvYTPfIj2
	 l1Y4yBMr+vCew==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 16D1317E10C8;
	Thu, 16 Oct 2025 11:39:59 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	hsin-hsiung.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v3 0/5] SPMI: MediaTek: Add support for multi-bus
Date: Thu, 16 Oct 2025 11:39:44 +0200
Message-ID: <20251016093949.127326-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v3:
 - Added Fixes tag to commit 3, collected R-b tag from wenst

Changes in v2:
 - Fixed indentation error in dt-bindings

This series adds basic support for multi-bus (multi-master) SPMI
controllers, as found in the MediaTek MT8196 Chromebook SoC and
the MediaTek MT6991 Dimensity 9400 Smartphone SoC, including RCS
interrupt handling and per-bus registration.

AngeloGioacchino Del Regno (5):
  dt-bindings: spmi: Add MediaTek MT8196 SPMI 2 Arbiter/Controllers
  spmi: mtk-pmif: Add multi-bus support for SPMI 2.0
  spmi: mtk-pmif: Keep spinlock until read is fully done
  spmi: mtk-pmif: Implement Request Capable Slave (RCS) interrupt
  spmi: mtk-pmif: Add support for MT8196 SPMI Controller

 .../bindings/spmi/mediatek,mt8196-spmi.yaml   | 138 +++++
 drivers/spmi/spmi-mtk-pmif.c                  | 471 +++++++++++++++---
 2 files changed, 530 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spmi/mediatek,mt8196-spmi.yaml

-- 
2.51.0


