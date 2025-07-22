Return-Path: <linux-kernel+bounces-741242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9A4B0E1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE478542FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742CC27E079;
	Tue, 22 Jul 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqMc/D5M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA227D784
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201853; cv=none; b=fZm3HlHQhmEWyLcwmblIEwrIPxYktD3eJa+o6uW2IGW8z19mSiNQ0GuLDDMjLl8bHXlQln3D/K+SnsDqvbh3VQy20gwLnYf0rnezyYBPd00vUFU16Mdp5rObaIhGv5+YaJig7mRAlZjMA15ICQofNYfMyaRceSjrrhty6nnm7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201853; c=relaxed/simple;
	bh=Ufv8POEsKPA95JS4zzpBbCIz71MKBgILHS7LH3IxQTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=un9E3Cnoow1xGOJlMvSPdpbfsQT63cjEoM1HNi/jBGh/4e0RzGcARzC7+KetYfomfgNQKw47eC9XV/zIizuE6NDjW7zYAKtq5nbuSl941mBiUdgW3LXS0kjOAKgUqRRP0og2B8qniohVD+0ZKkEa6H/Ldl14cNeCfUgxxgC5Npk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqMc/D5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CD7C4CEF8;
	Tue, 22 Jul 2025 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201853;
	bh=Ufv8POEsKPA95JS4zzpBbCIz71MKBgILHS7LH3IxQTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OqMc/D5MJKvBW7ISGaN8XfIKKeYMbRzux58mp+sYNFxM7eg5HL82iDRGnPmQbz0RS
	 OqiZ091Hm2Ms546QOFnDKTylxvp6eFt5eDr1csZqIXXWyfs46moZcoIbcP7uRfRViv
	 V6fTnL8eqMXZqCu5dPPlVlR2OFrt8CRMv6VffDgGdrbVMQsRRHG1zDBqRtatfWKRkR
	 wNjsmFklTQPsEKpLDSEyV/7bD3n4KbV8Uuc92kVF1V2Ozqmr1aRziH8Xr5twlTyp68
	 SDeFSIzdadEtTBvHYwTiOk1fidRXjQk4iaPfnpAFMNbnANX78/rsqu94dEE6L7kzUB
	 OMR+r+82vNZdg==
From: Dinh Nguyen <dinguyen@kernel.org>
To: gregkh@linuxfoundation.org
Cc: dinguyen@kernel.org,
	linux-kernel@vger.kernel.org,
	Mahesh Rao <mahesh.rao@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 4/5] firmware: stratix10-svc: Add support for RSU commands in asynchronous framework
Date: Tue, 22 Jul 2025 11:30:44 -0500
Message-ID: <20250722163045.168186-4-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20250722163045.168186-1-dinguyen@kernel.org>
References: <20250722163045.168186-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mahesh Rao <mahesh.rao@altera.com>

Integrate Remote System Update(RSU) service commands
into the asynchronous framework for communicating
with SDM. This allows the RSU commands to be processed
asynchronously, improving the responsiveness of the
Stratix10 service channel.

The asynchronous framework now supports the following
RSU commands:

* COMMAND_RSU_GET_SPT_TABLE
* COMMAND_RSU_STATUS
* COMMAND_RSU_NOTIFY

Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/firmware/stratix10-svc.c              | 72 +++++++++++++++++++
 include/linux/firmware/intel/stratix10-smc.h  | 52 ++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  4 ++
 3 files changed, 128 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 4480ba8b2e11..491a8149033f 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -87,6 +87,12 @@
 #define STRATIX10_SIP_SMC_SET_TRANSACTIONID_X1(transaction_id) \
 	(FIELD_PREP(STRATIX10_TRANS_ID_FIELD, transaction_id))
 
+/* 10-bit mask for extracting the SDM status code */
+#define STRATIX10_SDM_STATUS_MASK GENMASK(9, 0)
+/* Macro to get the SDM mailbox error status */
+#define STRATIX10_GET_SDM_STATUS_CODE(status) \
+	(FIELD_GET(STRATIX10_SDM_STATUS_MASK, status))
+
 typedef void (svc_invoke_fn)(unsigned long, unsigned long, unsigned long,
 			     unsigned long, unsigned long, unsigned long,
 			     unsigned long, unsigned long,
@@ -1454,6 +1460,16 @@ int stratix10_svc_async_send(struct stratix10_svc_chan *chan, void *msg,
 		STRATIX10_SIP_SMC_SET_TRANSACTIONID_X1(handle->transaction_id);
 
 	switch (p_msg->command) {
+	case COMMAND_RSU_GET_SPT_TABLE:
+		args.a0 = INTEL_SIP_SMC_ASYNC_RSU_GET_SPT;
+		break;
+	case COMMAND_RSU_STATUS:
+		args.a0 = INTEL_SIP_SMC_ASYNC_RSU_GET_ERROR_STATUS;
+		break;
+	case COMMAND_RSU_NOTIFY:
+		args.a0 = INTEL_SIP_SMC_ASYNC_RSU_NOTIFY;
+		args.a2 = p_msg->arg[0];
+		break;
 	default:
 		dev_err(ctrl->dev, "Invalid command ,%d\n", p_msg->command);
 		ret = -EINVAL;
@@ -1508,6 +1524,56 @@ int stratix10_svc_async_send(struct stratix10_svc_chan *chan, void *msg,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(stratix10_svc_async_send);
+
+/**
+ * stratix10_svc_async_prepare_response - Prepare the response data for
+ * an asynchronous transaction.
+ * @chan: Pointer to the service channel structure.
+ * @handle: Pointer to the asynchronous handler structure.
+ * @data: Pointer to the callback data structure.
+ *
+ * This function prepares the response data for an asynchronous transaction. It
+ * extracts the response data from the SMC response structure and stores it in
+ * the callback data structure. The function also logs the completion of the
+ * asynchronous transaction.
+ *
+ * Return: 0 on success, -ENOENT if the command is invalid
+ */
+static int stratix10_svc_async_prepare_response(struct stratix10_svc_chan *chan,
+						struct stratix10_svc_async_handler *handle,
+						struct stratix10_svc_cb_data *data)
+{
+	struct stratix10_svc_client_msg *p_msg =
+		(struct stratix10_svc_client_msg *)handle->msg;
+	struct stratix10_svc_controller *ctrl = chan->ctrl;
+
+	data->status = STRATIX10_GET_SDM_STATUS_CODE(handle->res.a1);
+
+	switch (p_msg->command) {
+	case COMMAND_RSU_NOTIFY:
+		break;
+	case COMMAND_RSU_GET_SPT_TABLE:
+		data->kaddr1 = (void *)&handle->res.a2;
+		data->kaddr2 = (void *)&handle->res.a3;
+		break;
+	case COMMAND_RSU_STATUS:
+		/* COMMAND_RSU_STATUS has more elements than the cb_data
+		 * can acomodate, so passing the response structure to the
+		 * response function to be handled before done command is
+		 * executed by the client.
+		 */
+		data->kaddr1 = (void *)&handle->res;
+		break;
+
+	default:
+		dev_alert(ctrl->dev, "Invalid command\n ,%d", p_msg->command);
+		return -ENOENT;
+	}
+	dev_dbg(ctrl->dev, "Async message completed transaction_id 0x%02x\n",
+		handle->transaction_id);
+	return 0;
+}
+
 /**
  * stratix10_svc_async_poll - Polls the status of an asynchronous
  * transaction.
@@ -1536,6 +1602,7 @@ int stratix10_svc_async_poll(struct stratix10_svc_chan *chan, void *tx_handle,
 	struct stratix10_svc_controller *ctrl;
 	struct stratix10_async_ctrl *actrl;
 	struct stratix10_async_chan *achan;
+	int ret;
 
 	if (!chan || !tx_handle || !data)
 		return -EINVAL;
@@ -1565,6 +1632,11 @@ int stratix10_svc_async_poll(struct stratix10_svc_chan *chan, void *tx_handle,
 	memset(data, 0, sizeof(*data));
 
 	if (handle->res.a0 == INTEL_SIP_SMC_STATUS_OK) {
+		ret = stratix10_svc_async_prepare_response(chan, handle, data);
+		if (ret) {
+			dev_err(ctrl->dev, "Error in preparation of response,%d\n", ret);
+			WARN_ON_ONCE(1);
+		}
 		return 0;
 	} else if (handle->res.a0 == INTEL_SIP_SMC_STATUS_BUSY) {
 		dev_dbg(ctrl->dev, "async message is still in progress\n");
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index c98ed992d23b..f87273af5e28 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -644,4 +644,56 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_ASYNC_FUNC_ID_POLL (0xC8)
 #define INTEL_SIP_SMC_ASYNC_POLL \
 	INTEL_SIP_SMC_ASYNC_VAL(INTEL_SIP_SMC_ASYNC_FUNC_ID_POLL)
+
+/**
+ * Request INTEL_SIP_SMC_ASYNC_RSU_GET_SPT
+ * Async call to get RSU SPT from SDM.
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_ASYNC_RSU_GET_SPT
+ * a1 transaction job id
+ * a2-a17 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK ,INTEL_SIP_SMC_STATUS_REJECTED
+ * or INTEL_SIP_SMC_STATUS_BUSY
+ * a1-a17 not used
+ */
+#define INTEL_SIP_SMC_ASYNC_FUNC_ID_RSU_GET_SPT (0xEA)
+#define INTEL_SIP_SMC_ASYNC_RSU_GET_SPT \
+	INTEL_SIP_SMC_ASYNC_VAL(INTEL_SIP_SMC_ASYNC_FUNC_ID_RSU_GET_SPT)
+
+/**
+ * Request INTEL_SIP_SMC_ASYNC_RSU_GET_ERROR_STATUS
+ * Async call to get RSU error status from SDM.
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_ASYNC_RSU_GET_ERROR_STATUS
+ * a1 transaction job id
+ * a2-a17 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK ,INTEL_SIP_SMC_STATUS_REJECTED
+ * or INTEL_SIP_SMC_STATUS_BUSY
+ * a1-a17 not used
+ */
+#define INTEL_SIP_SMC_ASYNC_FUNC_ID_RSU_GET_ERROR_STATUS (0xEB)
+#define INTEL_SIP_SMC_ASYNC_RSU_GET_ERROR_STATUS \
+	INTEL_SIP_SMC_ASYNC_VAL(INTEL_SIP_SMC_ASYNC_FUNC_ID_RSU_GET_ERROR_STATUS)
+
+/**
+ * Request INTEL_SIP_SMC_ASYNC_RSU_NOTIFY
+ * Async call to send NOTIFY value to SDM.
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_ASYNC_RSU_NOTIFY
+ * a1 transaction job id
+ * a2 notify value
+ * a3-a17 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK ,INTEL_SIP_SMC_STATUS_REJECTED
+ * or INTEL_SIP_SMC_STATUS_BUSY
+ * a1-a17 not used
+ */
+#define INTEL_SIP_SMC_ASYNC_FUNC_ID_RSU_NOTIFY (0xEC)
+#define INTEL_SIP_SMC_ASYNC_RSU_NOTIFY \
+	INTEL_SIP_SMC_ASYNC_VAL(INTEL_SIP_SMC_ASYNC_FUNC_ID_RSU_NOTIFY)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index bda837815bae..cf0eac544614 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -125,6 +125,9 @@ struct stratix10_svc_chan;
  * @COMMAND_RSU_DCMF_STATUS: query firmware for the DCMF status
  * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  *
+ * @COMMAND_RSU_GET_SPT_TABLE: query firmware for SPT table
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
  * @COMMAND_FCS_REQUEST_SERVICE: request validation of image from firmware,
  * return status is SVC_STATUS_OK, SVC_STATUS_INVALID_PARAM
  *
@@ -159,6 +162,7 @@ enum stratix10_svc_command_code {
 	COMMAND_RSU_DCMF_VERSION,
 	COMMAND_RSU_DCMF_STATUS,
 	COMMAND_FIRMWARE_VERSION,
+	COMMAND_RSU_GET_SPT_TABLE,
 	/* for FCS */
 	COMMAND_FCS_REQUEST_SERVICE = 20,
 	COMMAND_FCS_SEND_CERTIFICATE,
-- 
2.42.0.411.g813d9a9188


