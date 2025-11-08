Return-Path: <linux-kernel+bounces-891368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB9C428C0
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 08:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E65188C4BB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BB72D94B9;
	Sat,  8 Nov 2025 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="erZkpZ7c"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F517B50F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762586153; cv=none; b=MWLfvhyVDB3rFOlKg4HIFOOPKW0thCG1TBZZPbaP8LFRs+HchworMPrNCo6tjYo8/mRVR0DnqWM4tyN23U7GNBS2ZdNHZY2Bv2BLMB1R9rj5K+HeYXaa11s0Nb5Quv2reJMWQSoHxWsXoYvMTCKkLG79ovOM2eqHnsJ2IP8voH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762586153; c=relaxed/simple;
	bh=wK8Xiq1RoGTw7Txm1DiFEykQZzbIU2Xb8JPOR0D43dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c973vJn93obSaEIhMw20+FyxhPN3kovgRfl0RXSZsk/S8tkepdX97JVk5mTJ5LKbpsUjVeeyhaIo6dTZ887c+Fup3uvx6iapDfRZ10PpoGVjFn5jdconV+bD9gf5tvjrXyo+IIZ4xnGesT3Fn/TUjMQtSJN8TVu2b1xjq/qqaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=erZkpZ7c; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id Hd9ev6dTch1kKHd9evz6Wz; Sat, 08 Nov 2025 08:14:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1762586075;
	bh=gt4TIp6o9ARF2q2rWgDsh+y1CnIg7O4/hOAA4gB0+BU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=erZkpZ7c6PC5VRELYtEgB5bW/Gckd+IL59KEPVGKw71XlJ94nZA6RuoTyl/XIP4h+
	 fRjEzl/ZuoN9jqOJt8T5VA1leqHxnd1QsyDueqRvKynkhfcbhRP8A/GwnXtHPxMZel
	 66VT9zTNHxU0e0N9xVas0xYsw5usG4y1j6QZlZrQUBOIHDA9cmYTEb5NBKCZtXw3H3
	 Gt8rR1b0Vqle0hXzRePj1EPOGinvVbo2OuRVgH/XfpnLFCrKz6OuYer74sf04zjVps
	 irnyJHcOCUZlO2rt0gtK3W+FRuligWHYz7yMIEhq3uK9j7bPf/nRJBtNiRWYYHl3+f
	 rye9/82QTq/qw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Nov 2025 08:14:35 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: krzk@kernel.org,
	Andrea della Porta <andrea.porta@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v3] misc: rp1: Fix an error handling path in rp1_probe()
Date: Sat,  8 Nov 2025 08:14:04 +0100
Message-ID: <9bc1206de787fa86384f3e5ba0a8027947bc00ff.1762585959.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DT is used to get the reference of 'rp1_node', it should be released
when not needed anymore, otherwise it is leaking.

In such a case, add the missing of_node_put() call at the end of the probe,
as already done in the error handling path.

Fixes: 49d63971f963 ("misc: rp1: RaspberryPi RP1 misc driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is compile tested only.

Changes in v3:
   - Don't use cleanup.h in this case   [Krzysztof Kozlowski]

Changes in v2:
  - implement Dan's suggestions   [Dan Carpenter]
v2: https://lore.kernel.org/lkml/8f55f8866a6680830c9d318201a29293ac50a591.1761334487.git.christophe.jaillet@wanadoo.fr/

v1: https://lore.kernel.org/lkml/4e92a271fdb98560c4e659556a1f3e99e7d0d38e.1760987458.git.christophe.jaillet@wanadoo.fr/
---
 drivers/misc/rp1/rp1_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
index 803832006ec8..a342bcc6164b 100644
--- a/drivers/misc/rp1/rp1_pci.c
+++ b/drivers/misc/rp1/rp1_pci.c
@@ -289,6 +289,9 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_unload_overlay;
 	}
 
+	if (skip_ovl)
+		of_node_put(rp1_node);
+
 	return 0;
 
 err_unload_overlay:
-- 
2.51.1


