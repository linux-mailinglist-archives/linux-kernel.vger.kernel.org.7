Return-Path: <linux-kernel+bounces-703308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8354BAE8E78
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 21:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19787B4D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 19:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41CE2DF3EF;
	Wed, 25 Jun 2025 19:20:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DBF2DCBE4;
	Wed, 25 Jun 2025 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879218; cv=none; b=V6C1wkdp9fB7pWAKInu1aS2A/Dpr+8dyjj6+P1AQFaLo57UhDKaKEZz2fnp9IQm4d2N6i34boE51ks8eUV0IciesGK2bqK4b25M0UxSh0y036vGsK7wUPRX80bRP30HD6637FoLjes0GccD7lqfQjcjZd+vOno8B+c3+XHLbAKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879218; c=relaxed/simple;
	bh=nghOLqlbUU1ETGkmaBvasOmudvtp7wQSovaHwLAIq1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPabmnlbMRRmaQAA6EwlNzrB0Og2AyfjAaMA2bbJvm51dOZZAmr6NSHI1O1cxGdIUCW17wU9gh4EI+sA8I6iPJwRSG6pPLKPP6saLTyD4PN/zmk9P3iTbLWbNMOvOab7AiCKhPUdrzq/B20EqF3q2l1Yq2qXpMISZNNgzufaCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EB9C106F;
	Wed, 25 Jun 2025 12:19:58 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C1EC3F58B;
	Wed, 25 Jun 2025 12:20:16 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v7 2/2] tpm_crb_ffa: handle tpm busy return code
Date: Wed, 25 Jun 2025 14:19:43 -0500
Message-ID: <20250625191943.1009830-3-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625191943.1009830-1-prachotan.bathi@arm.com>
References: <20250625191943.1009830-1-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms supporting direct message request v2 [1] can support secure
partitions that support multiple services. For CRB over FF-A interface,
if the firmware TPM or TPM service [1] shares its Secure Partition (SP)
with another service, message requests may fail with a -EBUSY error.

To handle this, replace the single check and call with a retry loop
that attempts the TPM message send operation until it succeeds or a
configurable timeout is reached. Implement a _try_send_receive function
to do a single send/receive and modify the existing send_receive to
add this retry loop.
The retry mechanism introduces a module parameter (`busy_timeout_ms`,
default: 2000ms) to control how long to keep retrying on -EBUSY
responses. Between retries, the code waits briefly (50-100 microseconds)
to avoid busy-waiting and handling TPM BUSY conditions more gracefully.

The parameter can be modified at run-time as such:
echo 3000 | tee /sys/module/tpm_crb_ffa/parameters/busy_timeout_ms
This changes the timeout from the default 2000ms to 3000ms.

[1] TPM Service Command Response Buffer Interface Over FF-A
https://developer.arm.com/documentation/den0138/latest/

Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 +++
 drivers/char/tpm/tpm_crb_ffa.c                | 65 +++++++++++++++----
 2 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..5cb5dbfd761f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7214,6 +7214,14 @@
 			causing a major performance hit, and the space where
 			machines are deployed is by other means guarded.
 
+	tpm_crb_ffa.busy_timeout_ms= [ARM64,TPM]
+			Maximum time in milliseconds to retry sending a message 
+			to the TPM service before giving up. This parameter controls 
+			how long the system will continue retrying when the TPM 
+			service is busy.
+			Format: <unsigned int>
+			Default: 2000 (2 seconds)
+
 	tpm_suspend_pcr=[HW,TPM]
 			Format: integer pcr id
 			Specify that at suspend time, the tpm driver
diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 089d1e54bb46..1a51c966e42c 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -10,8 +10,12 @@
 #define pr_fmt(fmt) "CRB_FFA: " fmt
 
 #include <linux/arm_ffa.h>
+#include <linux/delay.h>
+#include <linux/moduleparam.h>
 #include "tpm_crb_ffa.h"
 
+#define memzero(s, n) memset((s), 0, (n))
+
 /* TPM service function status codes */
 #define CRB_FFA_OK			0x05000001
 #define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
@@ -178,22 +182,18 @@ int tpm_crb_ffa_init(void)
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
 
-static int __tpm_crb_ffa_send_receive(unsigned long func_id,
-				      unsigned long a0,
-				      unsigned long a1,
-				      unsigned long a2)
+static int __tpm_crb_ffa_try_send_receive(unsigned long func_id,
+					  unsigned long a0, unsigned long a1,
+					  unsigned long a2)
 {
 	const struct ffa_msg_ops *msg_ops;
 	int ret;
 
-	if (!tpm_crb_ffa)
-		return -ENOENT;
-
 	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
 
 	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
-		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
-		       sizeof(struct ffa_send_direct_data2));
+		memzero(&tpm_crb_ffa->direct_msg_data2,
+			sizeof(struct ffa_send_direct_data2));
 
 		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
 		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
@@ -201,12 +201,12 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
 		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
 
 		ret = msg_ops->sync_send_receive2(tpm_crb_ffa->ffa_dev,
-				&tpm_crb_ffa->direct_msg_data2);
+						&tpm_crb_ffa->direct_msg_data2);
 		if (!ret)
 			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
 	} else {
-		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
-		       sizeof(struct ffa_send_direct_data));
+		memzero(&tpm_crb_ffa->direct_msg_data,
+			sizeof(struct ffa_send_direct_data));
 
 		tpm_crb_ffa->direct_msg_data.data1 = func_id;
 		tpm_crb_ffa->direct_msg_data.data2 = a0;
@@ -214,11 +214,50 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
 		tpm_crb_ffa->direct_msg_data.data4 = a2;
 
 		ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
-				&tpm_crb_ffa->direct_msg_data);
+						 &tpm_crb_ffa->direct_msg_data);
 		if (!ret)
 			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
 	}
 
+	return ret;
+}
+
+static unsigned int busy_timeout_ms = 2000;
+/**
+ * busy_timeout_ms - Maximum time to retry before giving up on busy
+ *
+ * This parameter defines the maximum time in milliseconds to retry
+ * sending a message to the TPM service before giving up.
+ */
+module_param(busy_timeout_ms, uint, 0644);
+MODULE_PARM_DESC(busy_timeout_ms,
+		 "Maximum time(in ms) to retry before giving up on busy");
+
+static int __tpm_crb_ffa_send_receive(unsigned long func_id, unsigned long a0,
+				      unsigned long a1, unsigned long a2)
+{
+	ktime_t start, stop;
+	int ret;
+
+	if (!tpm_crb_ffa)
+		return -ENOENT;
+
+	start = ktime_get();
+	stop = ktime_add(start, ms_to_ktime(busy_timeout_ms));
+
+	for (;;) {
+		ret = __tpm_crb_ffa_try_send_receive(func_id, a0, a1, a2);
+
+		if (ret != -EBUSY)
+			break;
+
+		usleep_range(50, 100);
+		if (ktime_after(ktime_get(), stop)) {
+			dev_warn(&tpm_crb_ffa->ffa_dev->dev,
+				 "Busy retry timed out\n");
+			break;
+		}
+	}
 
 	return ret;
 }
-- 
2.43.0


