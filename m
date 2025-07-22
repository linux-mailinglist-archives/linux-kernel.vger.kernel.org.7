Return-Path: <linux-kernel+bounces-741107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26774B0E01D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77C2561A80
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B62ECD14;
	Tue, 22 Jul 2025 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1fDguDZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6079B2EA742;
	Tue, 22 Jul 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196949; cv=none; b=AXwKQIBJo3s3fQ42Nc6h+0i5QQLLAxLaeDusU5oh/vReaFlWZsF/5LnVlFLdzOeWtnnzZGGe1P3Ta9iGjzHxnGYh6VMWAFOXng8CWsVSeXxhSjZbZ1K7R+DHU/6L0od4CcvYZqRsDB+Vfn6CPHq+uam3YfIh6boRkM/no5YYO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196949; c=relaxed/simple;
	bh=kb7yQu9cFrXMBq6waUNjUscIziKeLqsouZSE3H5G5s0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UM1YoQzbQtgAqwwzV68VjtY727QkPeeymSy+2Xdlg91QIv4HO14gAc/k6hoJktIHkUF5f6EuZ7QuGIPm0qQJBknCd2Gmbq7+DIHnGn7qNjw4c+QxIs2XESUPKZo4HDtGFLIu6281l958FWsnnX/HtsrpYaeM4+s4r7z05zdk6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1fDguDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 209DCC4CEF7;
	Tue, 22 Jul 2025 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196949;
	bh=kb7yQu9cFrXMBq6waUNjUscIziKeLqsouZSE3H5G5s0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S1fDguDZ8AoxC5eX6IZL4n1z6q0dcfZowLSi5o1EupjUwGLjBQxS/BVP4xND7K2a8
	 w29gWcPYrUc04A4wKvDi20wexJa2yTFBDsbKbAIEWF7XKQCBlTH0QwiBuez6JFfjPs
	 OS/gjQnV6WQirz48Lgts88CBaXmiO9BUYqmZq5k/eK/E3/r8Jp9Dznn5OoKpNZcman
	 86hgqXxY8ArK9Hpi5x0pynflHT6Vjaz3V9ok4izKibACBdkVauFrOpINcLpSCe02tn
	 819CNSxmpT20PRznwfrSkBw1qLCcIbc5ivXm6x73+tedNAxIY4clEx/zUtCKs+r2pO
	 5UmakNRxYymGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A05C83F34;
	Tue, 22 Jul 2025 15:09:09 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Date: Tue, 22 Jul 2025 23:07:54 +0800
Subject: [PATCH 4/4] firmware: stratix10-svc: Add for SDM mailbox doorbell
 interrupt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-sip_svc_irq-v1-4-c5b9e02c1ce6@altera.com>
References: <20250722-sip_svc_irq-v1-0-c5b9e02c1ce6@altera.com>
In-Reply-To: <20250722-sip_svc_irq-v1-0-c5b9e02c1ce6@altera.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahesh Rao <mahesh.rao@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753196946; l=10436;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=hx3/zwBUt7WiXtNLJ8gUWse7GWY5YI8ZYnNkxjxE7Gw=;
 b=oXJ2P+IcUmUc3pLrK5YCDxDKYP80B3eGzt7A9Bh6zb1VWvp7MnjrM+FiCGYnHtZonepDgfhPr
 5IvfIyLswJ+DWbU3r0DFXuEra0O9Uo0SlBAaaO/Q1grsX3oPPu/cmrB
X-Developer-Key: i=mahesh.rao@altera.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=
X-Endpoint-Received: by B4 Relay for mahesh.rao@altera.com/20250107 with
 auth_id=337
X-Original-From: Mahesh Rao <mahesh.rao@altera.com>
Reply-To: mahesh.rao@altera.com

From: Mahesh Rao <mahesh.rao@altera.com>

Add support for SDM (Secure Device Manager) mailbox
doorbell interrupt for async transactions. On interrupt,
a workqueue is triggered which polls the ATF for
pending responses and retrieves the bitmap of all
retrieved and unprocessed transaction ids of mailbox
responses from SDM. It then triggers the corresponding
registered callbacks.

Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/firmware/stratix10-svc.c             | 117 ++++++++++++++++++++++++---
 include/linux/firmware/intel/stratix10-smc.h |  23 ++++++
 2 files changed, 130 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 491a8149033f975d515444f025723658c51aa1fe..807226d5ec53bffe7e7f31b60718703434e94c90 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -9,12 +9,14 @@
 #include <linux/delay.h>
 #include <linux/genalloc.h>
 #include <linux/hashtable.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kfifo.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -22,6 +24,7 @@
 #include <linux/firmware/intel/stratix10-smc.h>
 #include <linux/firmware/intel/stratix10-svc-client.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 /**
  * SVC_NUM_DATA_IN_FIFO - number of struct stratix10_svc_data in the FIFO
@@ -213,6 +216,7 @@ struct stratix10_async_chan {
  *                               asynchronous operations
  * @initialized: Flag indicating whether the control structure has
  *               been initialized
+ * @irq: Interrupt request number associated with the asynchronous control
  * @invoke_fn: Function pointer for invoking Stratix10 service calls
  *             to EL3 secure firmware
  * @async_id_pool: Pointer to the ID pool used for asynchronous
@@ -223,11 +227,13 @@ struct stratix10_async_chan {
  *                     structure
  * @trx_list_wr_lock: Spinlock for protecting the transaction list
  *                    write operations
+ * @async_work: Work structure for scheduling asynchronous work
  * @trx_list: Hash table for managing asynchronous transactions
  */
 
 struct stratix10_async_ctrl {
 	bool initialized;
+	int irq;
 	void (*invoke_fn)(struct stratix10_async_ctrl *actrl,
 			  const struct arm_smccc_1_2_regs *args,
 			  struct arm_smccc_1_2_regs *res);
@@ -236,6 +242,7 @@ struct stratix10_async_ctrl {
 	struct stratix10_async_chan *common_async_chan;
 	/* spinlock to protect the writes to trx_list hash table */
 	spinlock_t trx_list_wr_lock;
+	struct work_struct async_work;
 	DECLARE_HASHTABLE(trx_list, ASYNC_TRX_HASH_BITS);
 };
 
@@ -1709,14 +1716,81 @@ static inline void stratix10_smc_1_2(struct stratix10_async_ctrl *actrl,
 	arm_smccc_1_2_smc(args, res);
 }
 
+static irqreturn_t stratix10_svc_async_irq_handler(int irq, void *dev_id)
+{
+	struct stratix10_async_ctrl *actrl = &ctrl->actrl;
+	struct stratix10_svc_controller *ctrl = dev_id;
+
+	queue_work(system_bh_wq, &actrl->async_work);
+	disable_irq_nosync(actrl->irq);
+	return IRQ_HANDLED;
+}
+/**
+ * stratix10_async_workqueue_handler - Handler for the asynchronous
+ * workqueue in Stratix10 service controller.
+ * @work: Pointer to the work structure that contains the asynchronous
+ *        workqueue handler.
+ * This function is the handler for the asynchronous workqueue. It performs
+ * the following tasks:
+ * - Invokes the asynchronous polling on interrupt supervisory call.
+ * - On success,it retrieves the bitmap of pending transactions from mailbox
+ *   fifo in ATF.
+ * - It processes each pending transaction by calling the corresponding
+ *   callback function.
+ *
+ * The function ensures that the IRQ is enabled after processing the transactions
+ * and logs the total time taken to handle the transactions along with the number
+ * of transactions handled and the CPU on which the handler ran.
+ */
+static void stratix10_async_workqueue_handler(struct work_struct *work)
+{
+	struct stratix10_async_ctrl *actrl =
+		container_of(work, struct stratix10_async_ctrl, async_work);
+	struct arm_smccc_1_2_regs
+		args = { .a0 = INTEL_SIP_SMC_ASYNC_POLL_ON_IRQ }, res;
+	DECLARE_BITMAP(pend_on_irq, TOTAL_TRANSACTION_IDS);
+	struct stratix10_svc_async_handler *handler;
+	unsigned long transaction_id = 0;
+	u64 bitmap_array[4];
+
+	actrl->invoke_fn(actrl, &args, &res);
+	if (res.a0 == INTEL_SIP_SMC_STATUS_OK) {
+		bitmap_array[0] = res.a1;
+		bitmap_array[1] = res.a2;
+		bitmap_array[2] = res.a3;
+		bitmap_array[3] = res.a4;
+		bitmap_from_arr64(pend_on_irq, bitmap_array, TOTAL_TRANSACTION_IDS);
+		rcu_read_lock();
+		do {
+			transaction_id = find_next_bit(pend_on_irq,
+						       TOTAL_TRANSACTION_IDS,
+						       transaction_id);
+			if (transaction_id >= TOTAL_TRANSACTION_IDS)
+				break;
+			hash_for_each_possible_rcu_notrace(actrl->trx_list,
+							   handler, next,
+							   transaction_id) {
+				if (handler->transaction_id == transaction_id) {
+					handler->cb(handler->cb_arg);
+					break;
+				}
+			}
+			transaction_id++;
+		} while (transaction_id < TOTAL_TRANSACTION_IDS);
+		rcu_read_unlock();
+	}
+	enable_irq(actrl->irq);
+}
+
 /**
  * stratix10_svc_async_init - Initialize the Stratix10 service
  *                            controller for asynchronous operations.
  * @controller: Pointer to the Stratix10 service controller structure.
  *
  * This function initializes the asynchronous service controller by
- * setting up the necessary data structures and initializing the
- * transaction list.
+ * setting up the necessary data structures ,initializing the
+ * transaction list and registering the IRQ handler for asynchronous
+ * transactions.
  *
  * Return: 0 on success, -EINVAL if the controller is NULL or already
  *         initialized, -ENOMEM if memory allocation fails,
@@ -1728,7 +1802,7 @@ static int stratix10_svc_async_init(struct stratix10_svc_controller *controller)
 	struct stratix10_async_ctrl *actrl;
 	struct arm_smccc_res res;
 	struct device *dev;
-	int ret;
+	int ret, irq;
 
 	if (!controller)
 		return -EINVAL;
@@ -1775,6 +1849,22 @@ static int stratix10_svc_async_init(struct stratix10_svc_controller *controller)
 	hash_init(actrl->trx_list);
 	atomic_set(&actrl->common_achan_refcount, 0);
 
+	irq = of_irq_get(dev_of_node(dev), 0);
+	if (irq < 0) {
+		dev_warn(dev, "Failed to get IRQ, falling back to polling mode\n");
+	} else {
+		ret = devm_request_any_context_irq(dev, irq, stratix10_svc_async_irq_handler,
+						   IRQF_NO_AUTOEN, "stratix10_svc", controller);
+		if (ret == 0) {
+			dev_alert(dev,
+				  "Registered IRQ %d for sip async operations\n",
+				irq);
+			actrl->irq = irq;
+			INIT_WORK(&actrl->async_work, stratix10_async_workqueue_handler);
+			enable_irq(actrl->irq);
+		}
+	}
+
 	actrl->initialized = true;
 	return 0;
 }
@@ -1784,13 +1874,14 @@ static int stratix10_svc_async_init(struct stratix10_svc_controller *controller)
  *                            service controller
  * @ctrl: Pointer to the stratix10_svc_controller structure
  *
- * This function performs the necessary cleanup for the asynchronous
- * service controller. It checks if the controller is valid and if it
- * has been initialized. It then locks the transaction list and safely
- * removes and deallocates each handler in the list. The function also
- * removes any asynchronous clients associated with the controller's
- * channels and destroys the asynchronous ID pool. Finally, it resets
- * the asynchronous ID pool and invoke function pointers to NULL.
+ * This function performs the necessary cleanup for the asynchronous service
+ * controller. It checks if the controller is valid and if it has been
+ * initialized. Also If the controller has an IRQ assigned, it frees the IRQ
+ * and flushes any pending asynchronous work. It then locks the transaction
+ * list and safely removes and deallocates each handler in the list.
+ * The function also removes any asynchronous clients associated with the
+ * controller's channels and destroys the asynchronous ID pool. Finally, it
+ * resets the asynchronous ID pool and invoke function pointers to NULL.
  *
  * Return: 0 on success, -EINVAL if the controller is invalid or not
  *         initialized.
@@ -1812,6 +1903,12 @@ static int stratix10_svc_async_exit(struct stratix10_svc_controller *ctrl)
 
 	actrl->initialized = false;
 
+	if (actrl->irq > 0) {
+		free_irq(actrl->irq, ctrl);
+		flush_work(&actrl->async_work);
+		actrl->irq = 0;
+	}
+
 	spin_lock(&actrl->trx_list_wr_lock);
 	hash_for_each_safe(actrl->trx_list, i, tmp, handler, next) {
 		stratix10_deallocate_id(handler->achan->job_id_pool,
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index f87273af5e284b8912d87eb9d7179eb3d43e40e1..45e9dd4211f4994d67e5a6e00a5a817e96d42a8d 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -645,6 +645,29 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_ASYNC_POLL \
 	INTEL_SIP_SMC_ASYNC_VAL(INTEL_SIP_SMC_ASYNC_FUNC_ID_POLL)
 
+/**
+ * Request INTEL_SIP_SMC_ASYNC_POLL_ON_IRQ
+ * Async call used by service driver at EL1 to read response from SDM
+ * mailbox and to retrieve the transaction id's of the read response's.
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_ASYNC_POLL_ON_IRQ
+ * a1 transaction job id
+ * a2-7 will be used to return the response data
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1-a4 will contain bitmap of available responses's transaction id as set
+ *  bit position.
+ * a5-17 not used
+ * Or
+ * a0 INTEL_SIP_SMC_STATUS_NO_RESPONSE
+ * a1-17 not used
+ */
+#define INTEL_SIP_SMC_ASYNC_FUNC_ID_IRQ_POLL (0xC9)
+#define INTEL_SIP_SMC_ASYNC_POLL_ON_IRQ \
+	INTEL_SIP_SMC_ASYNC_VAL(INTEL_SIP_SMC_ASYNC_FUNC_ID_IRQ_POLL)
+
 /**
  * Request INTEL_SIP_SMC_ASYNC_RSU_GET_SPT
  * Async call to get RSU SPT from SDM.

-- 
2.35.3



