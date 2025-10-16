Return-Path: <linux-kernel+bounces-856164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ACABE3477
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA054066AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB5832D7FC;
	Thu, 16 Oct 2025 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="Dk1et/Nk"
Received: from mail-m49237.qiye.163.com (mail-m49237.qiye.163.com [45.254.49.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCB732BF32;
	Thu, 16 Oct 2025 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616731; cv=none; b=BL31DBD9FD6+AVn673hoUJCyb0QJMNOfSsIvCxmj/HaS7SczCrWvxBHQMlqd6tYvRWbVSzfhD42hWDS+qnialtx3UaJlVbZcuJ9Squd53lRuPJHjgAqcVwiuBktw1fpW+RB+f6Tw8QikVmq451sJavHWoogonPAikNGXZ8O95ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616731; c=relaxed/simple;
	bh=nnO835dkU0CcnQ/bkazdpz2nytqKQ9A0ksh3GJCOu8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhhj/J8amKRaZQFMRl7RmPvgOxUj3nnIE8dL9dI2+nXisdaoukpDm2fhGXGfdmsQ/JqyNfrXseQtaLVWBoI69Cq/WGkxUvyJP0N4QEzwnUsThaw8zsaPK2/a+UceN06+7HoomoV8Ap5aeEMsenGjAzSEZC2+9bZiTG6ieNM/mA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=Dk1et/Nk; arc=none smtp.client-ip=45.254.49.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26265958d;
	Thu, 16 Oct 2025 20:06:51 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzysztof.kozlowski@linaro.org
Cc: krzk+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	robh@kernel.org,
	conor+dt@kernel.org,
	gordon.ge@bst.ai,
	bst-upstream@bstai.top,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v5 6/6] MAINTAINERS: add Black Sesame Technologies (BST) ARM SoC support
Date: Thu, 16 Oct 2025 20:05:58 +0800
Message-ID: <20251016120558.2390960-7-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016120558.2390960-1-yangzh0906@thundersoft.com>
References: <20251016120558.2390960-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99ecea710e09cckunm98a0ee06128ad
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSh9IVh5KGBlDTB1OSBlIHlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Dk1et/NkrQ7aZ0NPv4CTjrYYp9Tn7qD9pL3NdHP9TihvJ23t/6KWS5WHsoIw/C1r6hNxoQ0nmwWONRXqL0oU50bY52PSCZ00dkos/17xrnh0MwxgDXwuk8q+VDNNacS0fi+rix6sPWFt3xSorapfsrsuSGeKIDza4OnODFXodQw=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=8vmS3EfhUykAvBVymJGJnTFBE7v+DMHYK0Xp3FKpXE8=;
	h=date:mime-version:subject:message-id:from;

Add a MAINTAINERS entry for Black Sesame Technologies (BST) ARM SoC
support. This entry covers device tree bindings, drivers, and board files
for BST SoCs, and platform support.

Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
Change for v5:
  - Remove MMC driver and dt-bindings entries (MMC patches will be submitted separately)
  - Change status from "Maintained" to "Supported" based on review feedback

Change for v4:
  - Changed file name: sdhci-of-bst-c1200.c to sdhci-of-bst.c
  - Changed title from "add and consolidate" to just "add"
  - Simplified commit message description
  - Removed Signed-off-by line for Ge Gordon

Change for v3:
 - No changes

Change for v2:
 - No changes
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..841d3f055778 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2543,6 +2543,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/arm/blaize.yaml
 F:	arch/arm64/boot/dts/blaize/
 
+ARM/BST SOC SUPPORT
+M:	Ge Gordon <gordon.ge@bst.ai>
+R:	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/arm/bst.yaml
+F:	arch/arm64/boot/dts/bst/
+
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Andre Przywara <andre.przywara@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.43.0


