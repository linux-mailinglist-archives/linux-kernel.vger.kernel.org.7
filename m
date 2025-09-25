Return-Path: <linux-kernel+bounces-833184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C0FBA15E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DAD4C81F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB43164AA;
	Thu, 25 Sep 2025 20:36:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDD61F8AC5;
	Thu, 25 Sep 2025 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832587; cv=none; b=V84wr5cMKj5iDpk0Yzo7F6mDeRpaGJKlEKIXIm7Ih6KH8KgJd6YG1KTj9mTGypsrifT/hYdLsFrq0HdNUx7Z9b382kUreXUUtib0Zv86vK9tBiDZoZgVmKy/a43Z9+zIhCHPd9C0BTkm/gZgLivXViruyQeaSKcbX4CRy0ZkHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832587; c=relaxed/simple;
	bh=CaAAdPzlWPvcy2qjq1UEGpKLI3+wDLrkFifkVdWo2e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWIH38agPsWgvN22Ieo0sZT6Ux1znLG/TBXdjuNrGm7CykO0qBgXo0OZhAZkUGVzjixnf4ocXnKCmL+ttQeefGxNtca6Ifw9rNbBBk2g/Gw97Rzwc1t8mNRD9dEL+yHiCoByNjxyNsvQ1nyrcJJIABKUUh9/Q7YBo4JsSO4S5Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9464E1C2B;
	Thu, 25 Sep 2025 13:36:15 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 042AA3F694;
	Thu, 25 Sep 2025 13:36:20 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 01/10] firmware: arm_scmi: Define a common SCMI_MAX_PROTOCOLS value
Date: Thu, 25 Sep 2025 21:35:45 +0100
Message-ID: <20250925203554.482371-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925203554.482371-1-cristian.marussi@arm.com>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a common definition of SCMI_MAX_PROTOCOLS and use it all over the
SCMI stack.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/notify.c | 4 +---
 include/linux/scmi_protocol.h      | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index dee9f238f6fd..78e9e27dc9ec 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -94,8 +94,6 @@
 #include "common.h"
 #include "notify.h"
 
-#define SCMI_MAX_PROTO		256
-
 #define PROTO_ID_MASK		GENMASK(31, 24)
 #define EVT_ID_MASK		GENMASK(23, 16)
 #define SRC_ID_MASK		GENMASK(15, 0)
@@ -1673,7 +1671,7 @@ int scmi_notification_init(struct scmi_handle *handle)
 	ni->gid = gid;
 	ni->handle = handle;
 
-	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTO,
+	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTOCOLS,
 						sizeof(char *), GFP_KERNEL);
 	if (!ni->registered_protocols)
 		goto err;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 688466a0e816..59527193d6dd 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -926,8 +926,11 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_VOLTAGE = 0x17,
 	SCMI_PROTOCOL_POWERCAP = 0x18,
 	SCMI_PROTOCOL_PINCTRL = 0x19,
+	SCMI_PROTOCOL_LAST = 0x7f,
 };
 
+#define SCMI_MAX_PROTOCOLS	256
+
 enum scmi_system_events {
 	SCMI_SYSTEM_SHUTDOWN,
 	SCMI_SYSTEM_COLDRESET,
-- 
2.51.0


