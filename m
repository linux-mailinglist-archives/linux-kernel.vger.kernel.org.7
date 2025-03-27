Return-Path: <linux-kernel+bounces-578955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DCFA73DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 19:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9870189366B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1015621A458;
	Thu, 27 Mar 2025 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nWsnWiiP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC4218EB3;
	Thu, 27 Mar 2025 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743099505; cv=none; b=EIGqvUFVdX2yAV1X5BSy4Vd6avjUSpDkQyVdP3vFK5RB8T9Eoxto8HY1cWSbjWATbbmUQdxpIqDsTwpW93ZxX2u+xR66TEfrq53Mz7WXezAMNj+c7sxKOvD1LuN/SwZlpLeymS3aYCTXQF9tlaX4Kchd/XG9PHCNNlj4J/HMLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743099505; c=relaxed/simple;
	bh=1bC94iLOVn4uSZE28DCVE/Z1lxJpVgGYizWuGyj1fB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vd0k6dRvTlGuhPjBJy4f26hetu50FFAxHBHHvpt01PASSbUWn5QdLpfIBDf4hhOejN+OP/t5Y4zRcQ8ls9btkI0XMU7nqZw/h8kFFPlXO+VWPWCIVQo6DeM4rgWKPIskkdmi3YCmekJQ8mOvrnj0Z1B7840MW6GkQowDA1ijXyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nWsnWiiP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RElAqC023840;
	Thu, 27 Mar 2025 18:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QkU6cfXx/Dr1uYdS2bfC4yKOb27hRI4xX4Mjt2GlxX0=; b=nWsnWiiPd2BhTQo2
	8bvwRq7Eyr3yMh8LCCDfuk/SXkQbpNukzvr4A4R66oU3PmGnp5Y+Yeo0w09T3vue
	4JYS0hV8suACJbj1eqqWEu+sLl1Uns0BXlWaWmOCnRVIwh/bpA3XIfCi9Fy+rANI
	aXzrjtC81dBCEuqIj+0J97gY2Tt/kGays9pGkqXp64pNSHDoVQ7ijZgQlosIAg4b
	qnNh7nFqwkbdlodmMjTuAQk0RBEAf1C5Wbyu2SP+jmUdu1Ign7AZHlK8OQtHCeR5
	W1EPvlsTzXeaqCfYpgYZWI/kcO/WfBgjLFlrn4EG660ta9NShqlsNyHbuG0R5u8P
	GiugpQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kyr9qahq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 18:18:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52RIIFs2028891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 18:18:15 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Mar 2025 11:18:11 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH V4 2/2] mailbox: tmelite-qmp: Introduce TMEL QMP mailbox driver
Date: Thu, 27 Mar 2025 23:47:50 +0530
Message-ID: <20250327181750.3733881-3-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327181750.3733881-1-quic_srichara@quicinc.com>
References: <20250327181750.3733881-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0rO4P6gnHKFRp6byxTJdsYHwAuRh45Fp
X-Authority-Analysis: v=2.4 cv=UblRSLSN c=1 sm=1 tr=0 ts=67e59668 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=hOkhvlhF9aMxycy05ToA:9 a=RVmHIydaz68A:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 0rO4P6gnHKFRp6byxTJdsYHwAuRh45Fp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_03,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270125

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

This mailbox facilitates the communication between the TMEL server
subsystem (Trust Management Engine Lite) and the TMEL client
(APPSS/BTSS/AUDIOSS), used for secure services like secure image
authentication, enable/disable efuses, crypto services etc. Each client in
the SoC has its own block of message RAM and IRQ for communication with the
TMEL SS. The protocol used to communicate in the message RAM is known as
Qualcomm Messaging Protocol (QMP).

Remote proc driver subscribes to this mailbox and uses the
mbox_send_message to use TMEL to securely authenticate/teardown the images.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
[V4]
        Fixed TME-L naming in all places and expanded it.
        Folded tmel_work in tmel.
        Added more kernel doc as relevant.
        Removed __packed in all places, as not required.
        Renamed all functions to have tmel_ prefixes.
        Used readl/writel in all places.
	Added Inline for all required functions.
        Removed redundant type conversions.
        Removed redundant 'goto's
        Added __free macro
        Fixed Linux std errno in tmel_sec_boot_auth/teardown
        Added spinlock in qmp_startup
        Used of_mbox_index_xlate and dropped the tmel_qmp_mbox_xlate
        Updated header file to have only mbox consumer required and moved rest to .c file
        Fixed the TMEL_MSG macros to use standard GENMASK
        Moved the irq registration to end of probe

    Following tests were done and no issues.

       *)  Checkpatch
       *)  Codespell
       *)  Sparse
       *)  kerneldoc check
       *)  Kernel lock debugging
       *)  dt_binding_check and dtbs_check

[V3]

        Fixed wrong code/comments wrappings.
        Fixed Kconfig and Makefile entries to right place.
        Removed unused headers inclusion.
        Fixed locking, removed the mutexes and having only tx spinlock.
        Removed the use of global ptr for tmel, made it as device specific.
        Replaced pr_err/pr_debug with dev_err/dev_dbg in all places.
        Fixed usage of dev_err_probe.
        Fixed xlate callback as per comments.
        Used devm equivalents and kcalloc version as per comments.
        Removed all un-nessecary wrapper macros for register access, inlined it
        as per comments.
        Re-organised the function layout as per comments and make it more readable.
        Removed the pictures in headers files as per comments.
        Used Field_prep/get as per comments.
        Fixed Kernel test reported issues.
        Fixed all other comments as well.

    Following tests were done and no issues.

       *)  Checkpatch
       *)  Codespell
       *)  Sparse
       *)  kerneldoc check
       *)  Kernel lock debugging
       *)  dt_binding_check and dtbs_check

[v2]
     Added HW description in the bindings patch.
     Fixed review comments for bindings from Krzysztof and Dmitry
     Changed patch#2 driver to add work for mailbox tx processing
     Cleaned up patch#2 for some checkpatch warnings.
     There are some checkpatch [CHECK] like below, which looks like false positive.

	CHECK: Macro argument 'm' may be better as '(m)' to avoid precedence issues
	#1072: FILE: include/linux/mailbox/tmelcom-qmp.h:40:
	+#define TMEL_MSG_UID_CREATE(m, a)      ((u32)(((m & 0xff) << 8) | (a & 0xff)))

[v1]
      RFC Post

 drivers/mailbox/Kconfig             |  10 +
 drivers/mailbox/Makefile            |   2 +
 drivers/mailbox/qcom-tmel-qmp.c     | 947 ++++++++++++++++++++++++++++
 include/linux/mailbox/tmelcom-qmp.h |  65 ++
 4 files changed, 1024 insertions(+)
 create mode 100644 drivers/mailbox/qcom-tmel-qmp.c
 create mode 100644 include/linux/mailbox/tmelcom-qmp.h

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index ed52db272f4d..a574c421227a 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -320,6 +320,16 @@ config QCOM_IPCC
 	  acts as an interrupt controller for receiving interrupts from clients.
 	  Say Y here if you want to build this driver.
 
+config QCOM_TMEL_QMP_MAILBOX
+	tristate "QCOM Mailbox Protocol(QMP) for TMEL SS"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  Say yes to add support for the QMP Mailbox Protocol driver for
+	  Trust Management Engine Lite Sub System (TMEL SS).
+	  QMP is a lightweight communication protocol for sending messages to
+	  TMEL. This protocol fits into the Generic Mailbox Framework.
+	  QMP uses a mailbox registers.
+
 config THEAD_TH1520_MBOX
 	tristate "T-head TH1520 Mailbox"
 	depends on ARCH_THEAD || COMPILE_TEST
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 9a1542b55539..31d5a4f96690 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -69,4 +69,6 @@ obj-$(CONFIG_QCOM_CPUCP_MBOX)	+= qcom-cpucp-mbox.o
 
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
 
+obj-$(CONFIG_QCOM_TMEL_QMP_MAILBOX) += qcom-tmel-qmp.o
+
 obj-$(CONFIG_THEAD_TH1520_MBOX)	+= mailbox-th1520.o
diff --git a/drivers/mailbox/qcom-tmel-qmp.c b/drivers/mailbox/qcom-tmel-qmp.c
new file mode 100644
index 000000000000..b8b8573f4d51
--- /dev/null
+++ b/drivers/mailbox/qcom-tmel-qmp.c
@@ -0,0 +1,947 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox/tmelcom-qmp.h>
+#include <linux/platform_device.h>
+#include <linux/uio.h>
+
+#define QMP_NUM_CHANS		0x1
+#define QMP_TOUT_MS		1000
+#define QMP_CTRL_DATA_SIZE	4
+#define QMP_MAX_PKT_SIZE	0x18
+#define QMP_UCORE_DESC_OFFSET	0x1000
+#define QMP_SEND_TIMEOUT	30000
+
+#define QMP_HW_MBOX_SIZE		32
+#define QMP_MBOX_RSV_SIZE		4
+#define QMP_MBOX_IPC_PACKET_SIZE	(QMP_HW_MBOX_SIZE - QMP_CTRL_DATA_SIZE - QMP_MBOX_RSV_SIZE)
+#define QMP_MBOX_IPC_MAX_PARAMS		5
+
+#define QMP_MAX_PARAM_IN_PARAM_ID	14
+#define QMP_PARAM_CNT_FOR_OUTBUF	3
+#define QMP_SRAM_IPC_MAX_PARAMS		(QMP_MAX_PARAM_IN_PARAM_ID * QMP_PARAM_CNT_FOR_OUTBUF)
+#define QMP_SRAM_IPC_MAX_BUF_SIZE	(QMP_SRAM_IPC_MAX_PARAMS * sizeof(u32))
+
+#define TMEL_ERROR_GENERIC		(0x1u)
+#define TMEL_ERROR_NOT_SUPPORTED	(0x2u)
+#define TMEL_ERROR_BAD_PARAMETER	(0x3u)
+#define TMEL_ERROR_BAD_MESSAGE		(0x4u)
+#define TMEL_ERROR_BAD_ADDRESS		(0x5u)
+#define TMEL_ERROR_TMELCOM_FAILURE	(0x6u)
+#define TMEL_ERROR_TMEL_BUSY		(0x7u)
+
+/*
+ * mbox data can be shared over mem or sram
+ */
+enum ipc_type {
+	IPC_MBOX_MEM,
+	IPC_MBOX_SRAM,
+};
+
+/*
+ * mbox header indicates the type of payload and action required.
+ */
+struct ipc_header {
+	u8 ipc_type:1;
+	u8 msg_len:7;
+	u8 msg_type;
+	u8 action_id;
+	s8 response;
+};
+
+struct mbox_payload {
+	u32 param[QMP_MBOX_IPC_MAX_PARAMS];
+};
+
+struct sram_payload {
+	u32 payload_ptr;
+	u32 payload_len;
+};
+
+union ipc_payload {
+	struct mbox_payload mbox_payload;
+	struct sram_payload sram_payload;
+};
+
+struct tmel_ipc_pkt {
+	struct ipc_header msg_hdr;
+	union ipc_payload payload;
+};
+
+/**
+ * enum qmp_local_state - definition of the local state machine
+ * @LINK_DISCONNECTED: Init state, waiting for ucore to start
+ * @LINK_NEGOTIATION: Set local link state to up, wait for ucore ack
+ * @LINK_CONNECTED: Link state up, channel not connected
+ * @LOCAL_CONNECTING: Channel opening locally, wait for ucore ack
+ * @CHANNEL_CONNECTED: Channel fully opened
+ * @LOCAL_DISCONNECTING: Channel disconnected locally, wait for ucore ack
+ */
+enum qmp_local_state {
+	LINK_DISCONNECTED,
+	LINK_NEGOTIATION,
+	LINK_CONNECTED,
+	LOCAL_CONNECTING,
+	CHANNEL_CONNECTED,
+	LOCAL_DISCONNECTING,
+};
+
+/**
+ * struct qmp_channel_desc - IPC bits
+ * @bits: Var to access each member
+ * @val: u32 representation of above
+ */
+union qmp_channel_desc {
+	struct {
+		u32 link_state:1;
+		u32 link_state_ack:1;
+		u32 ch_state:1;
+		u32 ch_state_ack:1;
+		u32 tx:1;
+		u32 tx_ack:1;
+		u32 rx_done:1;
+		u32 rx_done_ack:1;
+		u32 reserved:8;
+		u32 frag_size:8;
+		u32 rem_frag_count:8;
+	} bits;
+	unsigned int val;
+};
+
+/**
+ * struct qmp_device - local information for managing a single mailbox
+ * @dev: The device that corresponds to this mailbox
+ * @mcore_desc: Local core (APSS) mailbox descriptor
+ * @ucore_desc: Remote core (TME-L) mailbox descriptor
+ * @mcore: Local core (APSS) channel descriptor
+ * @ucore: Remote core (TME-L) channel descriptor
+ * @rx_pkt: Buffer to pass to client, holds received data from mailbox
+ * @mbox_client: Mailbox client for the IPC interrupt
+ * @mbox_chan: Mailbox client chan for the IPC interrupt
+ * @local_state: Current state of mailbox protocol
+ * @tx_lock: Serialize access for writes to mailbox
+ * @link_complete: Use to block until link negotiation with remote proc
+ * @ch_complete: Use to block until the channel is fully opened
+ * @tx_sent: True if tx is sent and remote proc has not sent ack
+ */
+struct qmp_device {
+	struct device *dev;
+
+	void __iomem *mcore_desc;
+	void __iomem *ucore_desc;
+	union qmp_channel_desc mcore;
+	union qmp_channel_desc ucore;
+
+	struct kvec rx_pkt;
+
+	struct mbox_client mbox_client;
+	struct mbox_chan *mbox_chan;
+
+	enum qmp_local_state local_state;
+
+	/*
+	 * Serialize access to mcore IPC descriptors.
+	 * mcore refers to the IPC request descriptors sent to TMEL,
+	 * protecting it from various SM transitions using this.
+	 */
+	spinlock_t tx_lock;
+
+	struct completion link_complete;
+	struct completion ch_complete;
+
+	atomic_t tx_sent;
+};
+
+/**
+ * struct tmel - tmel controller instance
+ * @dev: The device that corresponds to this mailbox
+ * @ctrl: Mailbox controller for use by tmel clients
+ * @mdev: qmp_device associated with this tmel instance
+ * @pkt: Buffer from client, to be sent over mailbox
+ * @ipc_pkt: wrapper used for prepare/un_prepare
+ * @sram_dma_addr: mailbox sram address to copy the data
+ * @waitq: Use to wait for posted messages completion
+ * @rx_done: Use to indicate receive completion from remote
+ * @twork: worker for posting the client req to tmel ctrl
+ * @data: client data to be sent for the current request
+ */
+struct tmel {
+	struct device *dev;
+	struct mbox_controller ctrl;
+	struct qmp_device *mdev;
+	struct kvec pkt;
+	struct tmel_ipc_pkt *ipc_pkt;
+	dma_addr_t sram_dma_addr;
+	wait_queue_head_t waitq;
+	bool rx_done;
+	struct work_struct twork;
+	void *data;
+};
+
+struct tmel_msg_param_type_buf_in {
+	u32 buf;
+	u32 buf_len;
+};
+
+struct tmel_secboot_sec_auth_req {
+	u32 sw_id;
+	struct tmel_msg_param_type_buf_in elf_buf;
+	struct tmel_msg_param_type_buf_in region_list;
+	u32 relocate;
+};
+
+struct tmel_secboot_sec_auth_resp {
+	u32 first_seg_addr;
+	u32 first_seg_len;
+	u32 entry_addr;
+	u32 extended_error;
+	u32 status;
+};
+
+struct tmel_secboot_sec_auth {
+	struct tmel_secboot_sec_auth_req req;
+	struct tmel_secboot_sec_auth_resp resp;
+};
+
+struct tmel_secboot_sec {
+	struct device *dev;
+	void *elf_buf;
+	struct tmel_secboot_sec_auth msg;
+};
+
+struct tmel_secboot_teardown_req {
+	u32 sw_id;
+	u32 secondary_sw_id;
+};
+
+struct tmel_secboot_teardown_resp {
+	u32 status;
+};
+
+struct tmel_secboot_teardown {
+	struct tmel_secboot_teardown_req req;
+	struct tmel_secboot_teardown_resp resp;
+};
+
+/**
+ * tmel_qmp_send_irq() - send an irq to a remote entity as an event signal.
+ * @mdev: Which remote entity that should receive the irq.
+ */
+static inline void tmel_qmp_send_irq(struct qmp_device *mdev)
+{
+	writel(mdev->mcore.val, mdev->mcore_desc);
+	/* Ensure desc update is visible before IPC */
+	wmb();
+
+	dev_dbg(mdev->dev, "%s: mcore 0x%x ucore 0x%x", __func__,
+		mdev->mcore.val, mdev->ucore.val);
+
+	mbox_send_message(mdev->mbox_chan, NULL);
+	mbox_client_txdone(mdev->mbox_chan, 0);
+}
+
+/**
+ * tmel_qmp_send_data() - Send the data to remote and notify.
+ * @mdev: qmp_device to send the data to.
+ * @data: Data to be sent to remote processor, should be in the format of
+ *	  a kvec.
+ *
+ * Copy the data to the channel's mailbox and notify remote subsystem of new
+ * data. This function will return an error if the previous message sent has
+ * not been read.
+ */
+static inline int tmel_qmp_send_data(struct qmp_device *mdev, void *data)
+{
+	struct kvec *pkt = (struct kvec *)data;
+	void __iomem *addr;
+	unsigned long flags;
+
+	if (pkt->iov_len > QMP_MAX_PKT_SIZE) {
+		dev_err(mdev->dev, "Unsupported packet size");
+		return -EINVAL;
+	}
+
+	if (atomic_read(&mdev->tx_sent))
+		return -EAGAIN;
+
+	dev_dbg(mdev->dev, "%s: mcore 0x%x ucore 0x%x", __func__,
+		mdev->mcore.val, mdev->ucore.val);
+
+	addr = mdev->mcore_desc + QMP_CTRL_DATA_SIZE;
+	memcpy_toio(addr, pkt->iov_base, pkt->iov_len);
+
+	mdev->mcore.bits.frag_size = pkt->iov_len;
+	mdev->mcore.bits.rem_frag_count = 0;
+
+	dev_dbg(mdev->dev, "Copied buffer to mbox, sz: %d",
+		mdev->mcore.bits.frag_size);
+
+	atomic_set(&mdev->tx_sent, 1);
+
+	spin_lock_irqsave(&mdev->tx_lock, flags);
+	mdev->mcore.bits.tx = !(mdev->mcore.bits.tx);
+	tmel_qmp_send_irq(mdev);
+	spin_unlock_irqrestore(&mdev->tx_lock, flags);
+
+	return 0;
+}
+
+/**
+ * tmel_qmp_notify_client() - Notify the tmel client about remote data.
+ * @tdev: tmel device to notify.
+ * @message: response pkt from remote processor, should be in format of kvec.
+ *
+ * Wakeup the clients after receiving data from the remote.
+ */
+static inline void tmel_qmp_notify_client(struct tmel *tdev, void *message)
+{
+	struct kvec *pkt = NULL;
+
+	if (!message) {
+		dev_err(tdev->dev, "spurious message received\n");
+		goto notify_fail;
+	}
+
+	if (tdev->rx_done) {
+		dev_err(tdev->dev, "tmel response pending\n");
+		goto notify_fail;
+	}
+
+	pkt = (struct kvec *)message;
+	tdev->pkt.iov_len = pkt->iov_len;
+	tdev->pkt.iov_base = pkt->iov_base;
+	tdev->rx_done = true;
+
+notify_fail:
+	wake_up_interruptible(&tdev->waitq);
+}
+
+/**
+ * tmel_qmp_recv_data() - Receive data and send ack.
+ * @tdev: tmel device that received the notification.
+ * @mbox_of: offset of mailbox after QMP Control data.
+ *
+ * Copies data from mailbox and passes to the client upon receiving data
+ * available notification. Also acknowledges the read completion.
+ */
+static inline void tmel_qmp_recv_data(struct tmel *tdev, u32 mbox_of)
+{
+	struct qmp_device *mdev = tdev->mdev;
+	void __iomem *addr;
+	struct kvec *pkt;
+
+	addr = mdev->ucore_desc + mbox_of;
+	pkt = &mdev->rx_pkt;
+	pkt->iov_len = mdev->ucore.bits.frag_size;
+
+	memcpy_fromio(pkt->iov_base, addr, pkt->iov_len);
+	mdev->mcore.bits.tx_ack = mdev->ucore.bits.tx;
+	dev_dbg(mdev->dev, "%s: Send RX data to TMEL Client", __func__);
+	tmel_qmp_notify_client(tdev, pkt);
+
+	mdev->mcore.bits.rx_done = !(mdev->mcore.bits.rx_done);
+	tmel_qmp_send_irq(mdev);
+}
+
+/**
+ * tmel_qmp_clr_mcore_ch_state() - Clear the mcore state of a mailbox.
+ * @mdev: mailbox device to be initialized.
+ */
+static inline void tmel_qmp_clr_mcore_ch_state(struct qmp_device *mdev)
+{
+	/* Clear all fields except link_state */
+	mdev->mcore.bits.ch_state = 0;
+	mdev->mcore.bits.ch_state_ack = 0;
+	mdev->mcore.bits.tx =  0;
+	mdev->mcore.bits.tx_ack =  0;
+	mdev->mcore.bits.rx_done = 0;
+	mdev->mcore.bits.rx_done_ack = 0;
+	mdev->mcore.bits.frag_size = 0;
+	mdev->mcore.bits.rem_frag_count = 0;
+}
+
+/**
+ * tmel_qmp_rx() - Handle incoming messages from remote processor.
+ * @tdev: tmel device to send the event to.
+ */
+static inline void tmel_qmp_rx(struct tmel *tdev)
+{
+	struct qmp_device *mdev = tdev->mdev;
+	unsigned long flags;
+
+	/* read remote_desc from mailbox register */
+	mdev->ucore.val = readl(mdev->ucore_desc);
+
+	dev_dbg(mdev->dev, "%s: mcore 0x%x ucore 0x%x", __func__,
+		mdev->mcore.val, mdev->ucore.val);
+
+	spin_lock_irqsave(&mdev->tx_lock, flags);
+
+	/* Check if remote link down */
+	if (mdev->local_state >= LINK_CONNECTED &&
+	    !(mdev->ucore.bits.link_state)) {
+		mdev->local_state = LINK_NEGOTIATION;
+		mdev->mcore.bits.link_state_ack = mdev->ucore.bits.link_state;
+		tmel_qmp_send_irq(mdev);
+		spin_unlock_irqrestore(&mdev->tx_lock, flags);
+		return;
+	}
+
+	switch (mdev->local_state) {
+	case LINK_NEGOTIATION:
+		if (!(mdev->mcore.bits.link_state) ||
+		    !(mdev->ucore.bits.link_state)) {
+			dev_err(mdev->dev, "rx irq:link down state\n");
+			break;
+		}
+		tmel_qmp_clr_mcore_ch_state(mdev);
+		mdev->mcore.bits.link_state_ack = mdev->ucore.bits.link_state;
+		mdev->local_state = LINK_CONNECTED;
+		complete_all(&mdev->link_complete);
+		dev_dbg(mdev->dev, "Set to link connected");
+		break;
+	case LINK_CONNECTED:
+		/* No need to handle until local opens */
+		break;
+	case LOCAL_CONNECTING:
+		/* Ack to remote ch_state change */
+		mdev->mcore.bits.ch_state_ack = mdev->ucore.bits.ch_state;
+		mdev->local_state = CHANNEL_CONNECTED;
+		complete_all(&mdev->ch_complete);
+		dev_dbg(mdev->dev, "Set to channel connected");
+		tmel_qmp_send_irq(mdev);
+		break;
+	case CHANNEL_CONNECTED:
+		/* Check for remote channel down */
+		if (!(mdev->ucore.bits.ch_state)) {
+			mdev->local_state = LOCAL_CONNECTING;
+			mdev->mcore.bits.ch_state_ack = mdev->ucore.bits.ch_state;
+			dev_dbg(mdev->dev, "Remote Disconnect");
+			tmel_qmp_send_irq(mdev);
+		}
+
+		/* Check TX done */
+		if (atomic_read(&mdev->tx_sent) &&
+		    mdev->ucore.bits.rx_done != mdev->mcore.bits.rx_done_ack) {
+			/* Ack to remote */
+			mdev->mcore.bits.rx_done_ack = mdev->ucore.bits.rx_done;
+			atomic_set(&mdev->tx_sent, 0);
+			dev_dbg(mdev->dev, "TX flag cleared");
+		}
+
+		/* Check if remote is Transmitting */
+		if (!(mdev->ucore.bits.tx != mdev->mcore.bits.tx_ack))
+			break;
+		if (mdev->ucore.bits.frag_size == 0 ||
+		    mdev->ucore.bits.frag_size > QMP_MAX_PKT_SIZE) {
+			dev_err(mdev->dev, "Rx frag size error %d\n",
+				mdev->ucore.bits.frag_size);
+			break;
+		}
+		tmel_qmp_recv_data(tdev, QMP_CTRL_DATA_SIZE);
+		break;
+	case LOCAL_DISCONNECTING:
+		if (!(mdev->mcore.bits.ch_state)) {
+			tmel_qmp_clr_mcore_ch_state(mdev);
+			mdev->local_state = LINK_CONNECTED;
+			dev_dbg(mdev->dev, "Channel closed");
+			reinit_completion(&mdev->ch_complete);
+		}
+
+		break;
+	default:
+		dev_err(mdev->dev, "Local Channel State corrupted\n");
+	}
+	spin_unlock_irqrestore(&mdev->tx_lock, flags);
+}
+
+/**
+ * tmel_qmp_irq_handler() - Handle incoming messages from remote processor.
+ * @irq: ipc interrupt from remote
+ * @priv: ptr to the corresponding tmel device.
+ */
+static inline irqreturn_t tmel_qmp_irq_handler(int irq, void *priv)
+{
+	struct tmel *tdev = (struct tmel *)priv;
+
+	tmel_qmp_rx(tdev);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * tmel_prepare_msg() - copies the payload to the mbox destination
+ * @tdev: the tmel device
+ * @msg_uid: msg_type/action_id combo
+ * @msg_buf: payload to be sent
+ * @msg_size: size of the payload
+ */
+static inline int tmel_prepare_msg(struct tmel *tdev, u32 msg_uid,
+				   void *msg_buf, size_t msg_size)
+{
+	struct tmel_ipc_pkt *ipc_pkt = tdev->ipc_pkt;
+	struct ipc_header *msg_hdr = &ipc_pkt->msg_hdr;
+	struct mbox_payload *mbox_payload = &ipc_pkt->payload.mbox_payload;
+	struct sram_payload *sram_payload = &ipc_pkt->payload.sram_payload;
+	int ret;
+
+	memset(ipc_pkt, 0, sizeof(struct tmel_ipc_pkt));
+
+	msg_hdr->msg_type = TMEL_MSG_UID_MSG_TYPE(msg_uid);
+	msg_hdr->action_id = TMEL_MSG_UID_ACTION_ID(msg_uid);
+
+	dev_dbg(tdev->dev, "uid: %d, msg_size: %zu msg_type:%d, action_id:%d\n",
+		msg_uid, msg_size, msg_hdr->msg_type, msg_hdr->action_id);
+
+	if (sizeof(struct ipc_header) + msg_size <= QMP_MBOX_IPC_PACKET_SIZE) {
+		/* Mbox only */
+		msg_hdr->ipc_type = IPC_MBOX_MEM;
+		msg_hdr->msg_len = msg_size;
+		memcpy((void *)mbox_payload, msg_buf, msg_size);
+	} else if (msg_size <= QMP_SRAM_IPC_MAX_BUF_SIZE) {
+		/* SRAM */
+		msg_hdr->ipc_type = IPC_MBOX_SRAM;
+		msg_hdr->msg_len = 8;
+
+		tdev->sram_dma_addr = dma_map_single(tdev->dev, msg_buf,
+						     msg_size,
+						     DMA_BIDIRECTIONAL);
+		ret = dma_mapping_error(tdev->dev, tdev->sram_dma_addr);
+		if (ret) {
+			dev_err(tdev->dev, "SRAM DMA mapping error: %d\n", ret);
+			return ret;
+		}
+
+		sram_payload->payload_ptr = tdev->sram_dma_addr;
+		sram_payload->payload_len = msg_size;
+	} else {
+		dev_err(tdev->dev, "Invalid payload length: %zu\n", msg_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * tmel_unprepare_message() - Get the response data back for client
+ * @tdev: the tmel device
+ * @msg_buf: payload to be sent
+ * @msg_size: size of the payload
+ */
+static inline void tmel_unprepare_message(struct tmel *tdev, void *msg_buf, size_t msg_size)
+{
+	struct tmel_ipc_pkt *ipc_pkt = (struct tmel_ipc_pkt *)tdev->pkt.iov_base;
+	struct mbox_payload *mbox_payload = &ipc_pkt->payload.mbox_payload;
+
+	if (ipc_pkt->msg_hdr.ipc_type == IPC_MBOX_MEM) {
+		memcpy(msg_buf, mbox_payload, msg_size);
+	} else if (ipc_pkt->msg_hdr.ipc_type == IPC_MBOX_SRAM) {
+		dma_unmap_single(tdev->dev, tdev->sram_dma_addr, msg_size, DMA_BIDIRECTIONAL);
+		tdev->sram_dma_addr = 0;
+	}
+}
+
+static inline bool tmel_rx_done(struct tmel *tdev)
+{
+	return tdev->rx_done;
+}
+
+/**
+ * tmel_process_request() - process client msg and wait for response
+ * @tdev: the tmel device
+ * @msg_uid: msg_type/action_id combo
+ * @msg_buf: payload to be sent
+ * @msg_size: size of the payload
+ */
+static inline int tmel_process_request(struct tmel *tdev, u32 msg_uid,
+				       void *msg_buf, size_t msg_size)
+{
+	struct qmp_device *mdev = tdev->mdev;
+	struct tmel_ipc_pkt *resp_ipc_pkt;
+	struct mbox_chan *chan;
+	unsigned long jiffies;
+	long time_left = 0;
+	int ret = 0;
+
+	chan = &tdev->ctrl.chans[0];
+
+	if (!msg_buf || !msg_size) {
+		dev_err(tdev->dev, "Invalid msg_buf or msg_size\n");
+		return -EINVAL;
+	}
+
+	tdev->rx_done = false;
+
+	ret = tmel_prepare_msg(tdev, msg_uid, msg_buf, msg_size);
+	if (ret)
+		return ret;
+
+	tdev->pkt.iov_len = sizeof(struct tmel_ipc_pkt);
+	tdev->pkt.iov_base = (void *)tdev->ipc_pkt;
+
+	tmel_qmp_send_data(mdev, &tdev->pkt);
+	jiffies = msecs_to_jiffies(QMP_SEND_TIMEOUT);
+
+	time_left = wait_event_interruptible_timeout(tdev->waitq,
+						     tmel_rx_done(tdev),
+						     jiffies);
+
+	if (!time_left) {
+		dev_err(tdev->dev, "Request timed out\n");
+		atomic_set(&mdev->tx_sent, 0);
+		mbox_chan_txdone(chan, ret);
+		return -ETIMEDOUT;
+	}
+
+	if (tdev->pkt.iov_len != sizeof(struct tmel_ipc_pkt))
+		return -EPROTO;
+
+	resp_ipc_pkt = (struct tmel_ipc_pkt *)tdev->pkt.iov_base;
+	tmel_unprepare_message(tdev, msg_buf, msg_size);
+	tdev->rx_done = false;
+
+	return resp_ipc_pkt->msg_hdr.response;
+}
+
+/**
+ * tmel_secboot_sec_free() - Release the dma alloc and kmalloc'ed memory
+ * @ptr: Address of the tmel_secboot_sec wrapper for dma and kmalloc region.
+ */
+void tmel_secboot_sec_free(void *ptr)
+{
+	struct tmel_secboot_sec *smsg = ptr;
+	void *elf_buf = smsg->elf_buf;
+	dma_addr_t elf_buf_phys;
+	u32 size;
+
+	elf_buf_phys = smsg->msg.req.elf_buf.buf;
+	size = smsg->msg.req.elf_buf.buf_len;
+	dma_free_coherent(smsg->dev, size, elf_buf, elf_buf_phys);
+	kfree(smsg);
+}
+
+/**
+ * tmel_secboot_sec_auth() - authenticate the remote subsys image
+ * @tdev: the tmel device
+ * @sw_id: pas_id of the remote
+ * @metadata: payload to be sent
+ * @size: size of the payload
+ */
+static inline int tmel_secboot_sec_auth(struct tmel *tdev, u32 sw_id,
+					void *metadata, size_t size)
+{
+	struct tmel_secboot_sec *smsg __free(tmel_secboot_sec_f) = NULL;
+	struct device *dev = tdev->dev;
+	dma_addr_t elf_buf_phys;
+	void *elf_buf;
+	int ret;
+
+	if (!dev || !metadata)
+		return -EINVAL;
+
+	smsg = kzalloc(sizeof(*smsg), GFP_KERNEL);
+
+	elf_buf = dma_alloc_coherent(dev, size, &elf_buf_phys, GFP_KERNEL);
+	if (!elf_buf)
+		return -ENOMEM;
+
+	memcpy(elf_buf, metadata, size);
+
+	smsg->dev = dev;
+	smsg->elf_buf = elf_buf;
+
+	smsg->msg.req.sw_id = sw_id;
+	smsg->msg.req.elf_buf.buf = (u32)elf_buf_phys;
+	smsg->msg.req.elf_buf.buf_len = (u32)size;
+
+	ret = tmel_process_request(tdev, TMEL_MSG_UID_SECBOOT_SEC_AUTH,
+				   &smsg->msg,
+				   sizeof(struct tmel_secboot_sec_auth));
+	if (ret) {
+		dev_err(dev, "Failed to send IPC: %d\n", ret);
+	} else if (smsg->msg.resp.status) {
+		dev_err(dev, "Failed with status: %d", smsg->msg.resp.status);
+		ret = smsg->msg.resp.status ? -EINVAL : 0;
+	} else if (smsg->msg.resp.extended_error) {
+		dev_err(dev, "Failed with error: %d", smsg->msg.resp.extended_error);
+		ret = smsg->msg.resp.extended_error ? -EINVAL : 0;
+	}
+
+	return ret;
+}
+
+/**
+ * tmel_secboot_teardown() - teardown the remote subsys
+ * @tdev: tmel device
+ * @sw_id: pas_id of the remote
+ * @secondary_sw_id: extra argument for the pas_id
+ */
+static inline int tmel_secboot_teardown(struct tmel *tdev, u32 sw_id,
+					u32 secondary_sw_id)
+{
+	struct tmel_secboot_teardown msg = {0};
+	struct device *dev = tdev->dev;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	msg.req.sw_id = sw_id;
+	msg.req.secondary_sw_id = secondary_sw_id;
+	msg.resp.status = TMEL_ERROR_GENERIC;
+
+	ret = tmel_process_request(tdev, TMEL_MSG_UID_SECBOOT_SS_TEAR_DOWN,
+				   &msg, sizeof(msg));
+	if (ret) {
+		dev_err(dev, "Failed to send IPC: %d\n", ret);
+	} else if (msg.resp.status) {
+		dev_err(dev, "Failed with status: %d\n", msg.resp.status);
+		ret = msg.resp.status ? -EINVAL : 0;
+	}
+
+	return ret;
+}
+
+static inline void tmel_qmp_send_work(struct work_struct *work)
+{
+	struct tmel *tdev = container_of(work, struct tmel, twork);
+	struct tmel_qmp_msg *tmsg = tdev->data;
+	struct tmel_sec_auth *smsg = tmsg->msg;
+	struct mbox_chan *chan;
+	int ret;
+
+	chan = &tdev->ctrl.chans[0];
+
+	switch (tmsg->msg_id) {
+	case TMEL_MSG_UID_SECBOOT_SEC_AUTH:
+		ret = tmel_secboot_sec_auth(tdev, smsg->pas_id, smsg->data, smsg->size);
+		break;
+	case TMEL_MSG_UID_SECBOOT_SS_TEAR_DOWN:
+		ret = tmel_secboot_teardown(tdev, smsg->pas_id, 0);
+		break;
+	}
+
+	mbox_chan_txdone(chan, ret);
+}
+
+/**
+ * tmel_qmp_startup() - Start qmp mailbox channel for communication.
+ * @chan: mailbox channel that is being opened.
+ * Waits for remote subsystem to open channel if link is not
+ * initiated or until timeout.
+ */
+static inline int tmel_qmp_startup(struct mbox_chan *chan)
+{
+	struct tmel *tdev = chan->con_priv;
+	struct qmp_device *mdev = tdev->mdev;
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * Kick start the SM from the negotiation phase
+	 * Rest of the link changes would follow when remote responds.
+	 */
+	spin_lock_irqsave(&mdev->tx_lock, flags);
+	mdev->mcore.bits.link_state = 1;
+	mdev->local_state = LINK_NEGOTIATION;
+	spin_unlock_irqrestore(&mdev->tx_lock, flags);
+
+	mdev->rx_pkt.iov_base = devm_kcalloc(mdev->dev, 1, QMP_MAX_PKT_SIZE,
+					     GFP_KERNEL);
+	if (!mdev->rx_pkt.iov_base)
+		return -ENOMEM;
+
+	tmel_qmp_send_irq(mdev);
+
+	ret = wait_for_completion_timeout(&mdev->link_complete,
+					  msecs_to_jiffies(QMP_TOUT_MS));
+	if (!ret)
+		return -EAGAIN;
+
+	spin_lock_irqsave(&mdev->tx_lock, flags);
+	if (mdev->local_state == LINK_CONNECTED) {
+		mdev->mcore.bits.ch_state = 1;
+		mdev->local_state = LOCAL_CONNECTING;
+		dev_dbg(mdev->dev, "link complete, local connecting");
+		tmel_qmp_send_irq(mdev);
+	}
+	spin_unlock_irqrestore(&mdev->tx_lock, flags);
+
+	ret = wait_for_completion_timeout(&mdev->ch_complete,
+					  msecs_to_jiffies(QMP_TOUT_MS));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+/**
+ * tmel_qmp_shutdown() - Shutdown this mailbox channel.
+ * @chan: mailbox channel to be shutdown.
+ * Disconnect this mailbox channel so the client does not receive anymore
+ * data and can reliquish control of the channel.
+ */
+static inline void tmel_qmp_shutdown(struct mbox_chan *chan)
+{
+	struct qmp_device *mdev = chan->con_priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mdev->tx_lock, flags);
+	if (mdev->local_state != LINK_DISCONNECTED) {
+		mdev->local_state = LOCAL_DISCONNECTING;
+		mdev->mcore.bits.ch_state = 0;
+		tmel_qmp_send_irq(mdev);
+	}
+	spin_unlock_irqrestore(&mdev->tx_lock, flags);
+}
+
+static inline int tmel_qmp_send(struct mbox_chan *chan, void *data)
+{
+	struct tmel *tdev = chan->con_priv;
+
+	tdev->data = data;
+	queue_work(system_wq, &tdev->twork);
+
+	return 0;
+}
+
+static struct mbox_chan_ops tmel_qmp_ops = {
+	.startup = tmel_qmp_startup,
+	.shutdown = tmel_qmp_shutdown,
+	.send_data = tmel_qmp_send,
+};
+
+static inline struct tmel *tmel_init(struct platform_device *pdev)
+{
+	struct tmel *tdev;
+	struct mbox_chan *chans;
+
+	tdev = devm_kcalloc(&pdev->dev, 1, sizeof(*tdev), GFP_KERNEL);
+	if (!tdev)
+		return ERR_PTR(-ENOMEM);
+
+	tdev->ipc_pkt = devm_kcalloc(&pdev->dev, 1, sizeof(struct tmel_ipc_pkt), GFP_KERNEL);
+	if (!tdev->ipc_pkt)
+		return ERR_PTR(-ENOMEM);
+
+	init_waitqueue_head(&tdev->waitq);
+
+	tdev->rx_done = false;
+	tdev->dev = &pdev->dev;
+	platform_set_drvdata(pdev, tdev);
+
+	chans = devm_kcalloc(&pdev->dev, QMP_NUM_CHANS, sizeof(*chans), GFP_KERNEL);
+	if (!chans)
+		return ERR_PTR(-ENOMEM);
+
+	tdev->ctrl.chans = chans;
+	INIT_WORK(&tdev->twork, tmel_qmp_send_work);
+
+	return tdev;
+}
+
+static inline struct qmp_device *qmp_init(struct platform_device *pdev)
+{
+	struct qmp_device *mdev;
+
+	mdev = devm_kcalloc(&pdev->dev, 1, sizeof(*mdev), GFP_KERNEL);
+	if (!mdev)
+		return ERR_PTR(-ENOMEM);
+
+	mdev->dev = &pdev->dev;
+	mdev->mcore_desc = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mdev->mcore_desc))
+		return ERR_PTR(-EIO);
+
+	mdev->ucore_desc = mdev->mcore_desc + QMP_UCORE_DESC_OFFSET;
+
+	spin_lock_init(&mdev->tx_lock);
+	mdev->local_state = LINK_DISCONNECTED;
+	init_completion(&mdev->link_complete);
+	init_completion(&mdev->ch_complete);
+
+	return mdev;
+}
+
+static inline int qmp_mbox_client_init(struct qmp_device *mdev)
+{
+	int ret = 0;
+
+	mdev->mbox_client.dev = mdev->dev;
+	mdev->mbox_client.knows_txdone = false;
+	mdev->mbox_chan = mbox_request_channel(&mdev->mbox_client, 0);
+	if (IS_ERR(mdev->mbox_chan))
+		ret = PTR_ERR(mdev->mbox_chan);
+
+	return ret;
+}
+
+static inline int tmel_mbox_ctrl_init(struct tmel *tdev)
+{
+	tdev->ctrl.dev = tdev->dev;
+	tdev->ctrl.ops = &tmel_qmp_ops;
+	tdev->ctrl.chans[0].con_priv = tdev;
+	tdev->ctrl.num_chans = QMP_NUM_CHANS;
+	tdev->ctrl.txdone_irq = true;
+
+	return devm_mbox_controller_register(tdev->dev, &tdev->ctrl);
+}
+
+static inline int tmel_qmp_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct qmp_device *mdev;
+	struct tmel *tdev;
+	int ret = 0;
+
+	tdev = tmel_init(pdev);
+	if (IS_ERR(tdev))
+		return dev_err_probe(tdev->dev, ret, "tmel device init failed\n");
+
+	mdev = qmp_init(pdev);
+	if (IS_ERR(mdev))
+		return dev_err_probe(tdev->dev, ret, "qmp device init failed\n");
+
+	tdev->mdev = mdev;
+
+	ret = qmp_mbox_client_init(mdev);
+	if (ret)
+		return dev_err_probe(mdev->dev, ret, "IPC chan missing, client init failed");
+
+	ret = tmel_mbox_ctrl_init(tdev);
+	if (ret)
+		return dev_err_probe(tdev->dev, ret, "failed to register mbox controller");
+
+	ret = platform_get_irq(pdev, 0);
+	ret = devm_request_threaded_irq(tdev->dev, ret, NULL, tmel_qmp_irq_handler,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					node->name, (void *)tdev);
+	if (ret < 0)
+		return dev_err_probe(tdev->dev, ret, "request threaded irq failed\n");
+
+	return ret;
+}
+
+static const struct of_device_id tmel_qmp_dt_match[] = {
+	{ .compatible = "qcom,ipq5424-tmel" },
+	{},
+};
+
+static struct platform_driver tmel_qmp_driver = {
+	.driver = {
+		.name = "tmel_qmp_mbox",
+		.of_match_table = tmel_qmp_dt_match,
+	},
+	.probe = tmel_qmp_probe,
+};
+module_platform_driver(tmel_qmp_driver);
+
+MODULE_DESCRIPTION("QCOM TMEL QMP driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mailbox/tmelcom-qmp.h b/include/linux/mailbox/tmelcom-qmp.h
new file mode 100644
index 000000000000..338fdea1e37e
--- /dev/null
+++ b/include/linux/mailbox/tmelcom-qmp.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _TMELCOM_H_
+#define _TMELCOM_H_
+
+#include <linux/bitfield.h>
+
+/*
+ * Macro used to define unique TMEL Message Identifier based on
+ * message type and action identifier.
+ */
+#define MSGTYPE_MASK GENMASK(15, 8)
+#define ACTIONID_MASK GENMASK(7, 0)
+
+#define TMEL_MSG_UID_CREATE(msg_type, action_id) \
+	(FIELD_PREP_CONST(MSGTYPE_MASK, msg_type) | \
+	FIELD_PREP_CONST(ACTIONID_MASK, action_id))
+
+/*
+ * Helper macro to extract the messageType from TMEL_MSG_UID
+ */
+#define TMEL_MSG_UID_MSG_TYPE(v)	FIELD_GET(MSGTYPE_MASK, v)
+
+/*
+ * Helper macro to extract the actionID from TMEL_MSG_UID
+ */
+#define TMEL_MSG_UID_ACTION_ID(v)	FIELD_GET(ACTIONID_MASK, v)
+
+/*
+ * All definitions of supported messageTypes.
+ */
+#define TMEL_MSG_SECBOOT	0x00
+
+/*
+ * Action IDs for TMEL_MSG_SECBOOT
+ */
+#define TMEL_ACTION_SECBOOT_SEC_AUTH		0x04
+#define TMEL_ACTION_SECBOOT_SS_TEAR_DOWN	0x0a
+
+/*
+ * UIDs for TMEL_MSG_SECBOOT
+ */
+#define TMEL_MSG_UID_SECBOOT_SEC_AUTH	    TMEL_MSG_UID_CREATE(TMEL_MSG_SECBOOT,\
+					    TMEL_ACTION_SECBOOT_SEC_AUTH)
+
+#define TMEL_MSG_UID_SECBOOT_SS_TEAR_DOWN	TMEL_MSG_UID_CREATE(TMEL_MSG_SECBOOT,\
+						TMEL_ACTION_SECBOOT_SS_TEAR_DOWN)
+
+struct tmel_qmp_msg {
+	void *msg;
+	u32 msg_id;
+};
+
+struct tmel_sec_auth {
+	void *data;
+	u32 size;
+	u32 pas_id;
+};
+
+void tmel_secboot_sec_free(void *ptr);
+
+DEFINE_FREE(tmel_secboot_sec_f, void *, if (_T) tmel_secboot_sec_free(_T))
+#endif  /* _TMELCOM_H_ */
-- 
2.34.1


