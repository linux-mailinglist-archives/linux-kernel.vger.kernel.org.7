Return-Path: <linux-kernel+bounces-874961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8640AC17CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C09365034AC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8D02DC33B;
	Wed, 29 Oct 2025 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="iFONbQYr"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84CE2D9EDA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700410; cv=none; b=PTAP43CqKl8coqxW1STqxKJKmzkPzlJ+LHkko1Op8RJivItYEDz6mTxgNGUK510NRjNObXxMqHRqQ8aatB6BvIxYJY6PdgmcjHqYtItHbUcu84xP27Y2HmFLsX23VATuhAo9nqFTzeskU3jSLprixEvczca5u5ZcfKBL6nxt0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700410; c=relaxed/simple;
	bh=vZmH4j1iRBHdyP/11gWs1D7OulzeT5LPIZQzEfM5xtY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjIwkSjBrZ1uhd+Gn0oRM/hB1Rw/WG5yb24TgnZQl9X3865++eUuzy6kVKq4CzPa/jVWWDR8TvHCwDjNctKdENtLG+fkzPIXNwtwynSaV/EKM7KyWyISp/1r/uPkV63JFj+rTz4MyFc8VZ7obbO/joNXeOE+adRdtO/RZ3b+Slw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=iFONbQYr; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1761700405;
	bh=SBAaGqZMQDv2mThH8h5PuvqVwOb0ebtKCEAGSC2lmyQ=; l=1765;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iFONbQYryQG6uxlo8L0ViC1PLvmoSfuA+BBlszn9CJj/tT5brIoD+StBfsedxOwYt
	 iae56Z4UHwQQib1iS2vHsBscRHte5cPaooSQA2g11dr6hL/vfz6JvaQ7hGj0g5eiEp
	 qIBGTvJk8nEEin/p3aSCuqvS8Lm2WLJijYyAzENrkfHAZwrNgkXwa18FanI9CmLi5O
	 ZYAbGIEQ28LFehcDtDYsoJTqo/PgzxjMV5es4btZF2eYt3Sot9D2hyqvcIRIwUtblU
	 5U/BBhotgBMBJGqcd2n2FNOvkxnnijBqCVGkaGc5XvDLeSDMqnhm4ylXvA2i1PA2P+
	 v/Pl6Pw3R7Xvw==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3436907:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 29 Oct 2025 09:13:19 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Wed, 29 Oct
 2025 09:13:18 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Wed, 29 Oct 2025 09:13:18 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"ChiYuan Huang" <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] Documentation: power: rt9756: Document exported sysfs entries
Date: Wed, 29 Oct 2025 09:14:45 +0800
Message-ID: <826a6c077242a411bf6947e51aaa4ea98d43b650.1761699952.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1761699952.git.cy_huang@richtek.com>
References: <cover.1761699952.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

Document the settings exported by rt9756 charger driver through sysfs
entries:

- watchdog_timer
- operation_mode

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
V3
- Remove customized description for battery voltage and current
---
 .../ABI/testing/sysfs-class-power-rt9756      | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9756

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9756 b/Documentation/ABI/testing/sysfs-class-power-rt9756
new file mode 100644
index 000000000000..c4d6c2b4715d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9756
@@ -0,0 +1,30 @@
+What:		/sys/class/power_supply/rt9756-*/watchdog_timer
+Date:		Dec 2025
+KernelVersion:	6.19
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry shows and sets the watchdog timer when rt9756 charger
+		operates in charging mode. When the timer expires, the device
+		will disable the charging. To prevent the timer expires, any
+		host communication can make the timer restarted.
+
+		Access: Read, Write
+
+		Valid values:
+		- 500, 1000, 5000, 30000, 40000, 80000, 128000 or 255000 (milliseconds),
+		- 0: disabled
+
+What:		/sys/class/power_supply/rt9756-*/operation_mode
+Date:		Dec 2025
+KernelVersion:	6.19
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry shows and set the operation mode when rt9756 charger
+		operates in charging phase. If 'bypass' mode is used, internal
+		path will connect vbus directly to vbat. Else, default 'div2'
+		mode for the switch-cap charging.
+
+		Access: Read, Write
+
+		Valid values:
+		- 'bypass' or 'div2'
-- 
2.34.1


