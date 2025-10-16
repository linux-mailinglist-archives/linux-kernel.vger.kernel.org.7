Return-Path: <linux-kernel+bounces-856158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFBBBE343B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A097401089
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC04F324B31;
	Thu, 16 Oct 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="FodpsulK"
Received: from mail-m155115.qiye.163.com (mail-m155115.qiye.163.com [101.71.155.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFEA306496;
	Thu, 16 Oct 2025 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616707; cv=none; b=RlFQKHr37+eW1ZDlbpAE276xRfGRYEWyFQicoz2EUcBfIiXlx4SUlY5kPSFsBxx/ozsK1VOLW239RleuU86BhWDqJDCg8WSBeqKlDgcoNOffjj4jc1fj7FilKR55L9sqB/RFTNE+7KXec2R0tWlyfOL3c9jvfqVdV/G8ZiPRnl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616707; c=relaxed/simple;
	bh=ZXJpLmzsxHJobBislt9x9RD0VSr8jbg81a4pzG3Ts/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpReJfnAVicg9YYaX6BvGTcop7qezqInU0o6eDPnjgxjbPrdvxqm6duBlgzQAN9xevC3zZL1nO5/S+6OY7hmJFI79Oid5hU8aWseH6CjSkLM0VETn4Cd2rFS807N20QtOPnOZgsNGlukODR5kEC5QZW6o4WDrN4/um51EeITfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=FodpsulK; arc=none smtp.client-ip=101.71.155.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26265956d;
	Thu, 16 Oct 2025 20:06:32 +0800 (GMT+08:00)
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
Subject: [PATCH v5 1/6] dt-bindings: vendor-prefixes: Add Black Sesame Technologies Co., Ltd.
Date: Thu, 16 Oct 2025 20:05:53 +0800
Message-ID: <20251016120558.2390960-2-yangzh0906@thundersoft.com>
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
X-HM-Tid: 0a99ecea25f909cckunm98a0ee06127c2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGksYVk8eHk1NSUIYSBpIQlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FodpsulKPDCojROvxcmY+iPnfkF4JJ9ME0qd+d0MRzFR3+H6WIgnsH+m2DBgq2v3xZSWruB6bQv3LEHkoTSWKSNyN7qofdkflZrcC3MednsbPRKPtOVE8thuMLi+ZSxsdfg3vR5ge4dUaDs0FwNVGV+2rq91WCU0vCmiZIpnxy0=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=zdMLkxCMdwv/ZcvRRwqvZ+qNQlbpWZA9E5mCTIh0Tkc=;
	h=date:mime-version:subject:message-id:from;

Black Sesame Technologies Co., Ltd.s a leading automotive-grade
computing SoC and SoC-based intelligent vehicle solution provider.
Link: https://bst.ai/.

Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes for v4:
- adjust ^bst to the correct order
- adjust Acked-by order
Changes for v3:
- No changes

Changes for v2:
- No changes
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f1d1882009ba..df0a50b5437b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -251,6 +251,8 @@ patternProperties:
     description: Shanghai Broadmobi Communication Technology Co.,Ltd.
   "^bsh,.*":
     description: BSH Hausgeraete GmbH
+  "^bst,.*":
+    description: Black Sesame Technologies Co., Ltd.
   "^bticino,.*":
     description: Bticino International
   "^buffalo,.*":
-- 
2.43.0


