Return-Path: <linux-kernel+bounces-868380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE3C05131
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AD5F502D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDA53090C1;
	Fri, 24 Oct 2025 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mdwKhxVx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31813308F1E;
	Fri, 24 Oct 2025 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294777; cv=none; b=oJi8v4ix+NicmrOec5Y2AwBxg3ddWLH4p6HQOQYOlSwGvPLI+jvS6zfQRpXEfW4ZEPFhGTMyZhw4kVXLeJxAM8Wjw5EtJOEyS0ehxulcdxW2WoyJ84P5w4qzX24rWp8tTM3NjaADZONPXBcfcJ9Qt9nzl4G2RNGUGxvVY+WGCLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294777; c=relaxed/simple;
	bh=/xXfoyNB40eXSe6uoEs0dSEKGlQMCkc++6Fih/1zXNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SSuATho7Kl7GV0vYVQcF81I+fApk5aXrAJqtg4jM9zkznyaPPfjY3TEaY7xu0ziG8cswkw1VOVtzcJ3QssbdSfgwhQebGejv9hCXGEHmELBg2OgOJzt1u6cmpAeqYNHJsd9/MD5zvStBEusxPKRW7H7JZAEAXzdFU6ysPzImZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mdwKhxVx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761294773;
	bh=/xXfoyNB40eXSe6uoEs0dSEKGlQMCkc++6Fih/1zXNw=;
	h=From:To:Cc:Subject:Date:From;
	b=mdwKhxVxD+EOB87gibbxJjRuCjqFqdwgNTZAxM5gQ/k/WXAyvQVQ9+YrpiIO9Lwik
	 MghNzhsZlb5NRsIT4p9cj8ukFNBMoFIhxoqcfv9ym5/u+KrE7XDPthBxrOHW+JSVzk
	 g7OAhhZC4W7NvozjSfaQx1/Q616Jv06IDd3BN4WtsF7RW6cQUat0n7ipFUfJwXCDeW
	 l/sTI324NV2YSjX92rYFePzhgZdgP8cZi1gOIxH4tteDMzxqy19/Rz7yu7MXNjfuSZ
	 J0j9adJ2vL1aplbtohwAGnOZ72Uc0/GxOoar3Xg980zzBYN8lpMKFuy4NyT7nDk24F
	 ANeV4USrsBxJw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3654917E00A6;
	Fri, 24 Oct 2025 10:32:53 +0200 (CEST)
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
Subject: [PATCH v4 0/5] SPMI: MediaTek: Add support for multi-bus
Date: Fri, 24 Oct 2025 10:32:42 +0200
Message-ID: <20251024083247.25814-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v4:
 - Refactored IRQ domain handling due to deprecation of function
   irq_domain_add_tree() to use the new irq_domain_create_tree()
 - Added .irq_eoi() callback for rcs_irq as that better reflects
   the actual functionality of this interrupt controller (as its
   SLV_x_y_EINT registers are really signaling "EOI", not "ACK")
 - Fixed to use generic_handle_domain_irq_safe() to avoid races
 - Tested again on MT8196 Chromebook

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
 drivers/spmi/spmi-mtk-pmif.c                  | 472 +++++++++++++++---
 2 files changed, 530 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spmi/mediatek,mt8196-spmi.yaml

-- 
2.51.1


