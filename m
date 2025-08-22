Return-Path: <linux-kernel+bounces-780977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F78B30BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD831D03053
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C47A1B4F0F;
	Fri, 22 Aug 2025 02:36:35 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A1140E5F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830194; cv=none; b=TdG595u0/6pmG9JG39rfq4jxQ4rs5jTmfV0g+/1bMYgsf/FS/DhdVC99pfNZt8CLZ9H7dPg+2jfaxqk9ExzDZC+TH1tjv4wVZzfBR71NO1eQuaz4cnfaChvK0cpsG/fAD4i1B1IyA8tznY8X7Xrbl/T8Ct/G/gnuAeZ9m72iiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830194; c=relaxed/simple;
	bh=64GCeCryE0XV38xJZgYx4GLQ6ObDADFQniK43+j3YbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/YllhJhNuSwD8F+lg0W8yu8vscbs3eNvfqe50pRWtjbH+ChfizMO0Syqe9fu7rETJ8lP7XDdHaaWDVF0brfQCcw8SNz3tuvKUB8YHBjrH2SljP+xu2NnEvTU3dg4YTYrq0P7OKclejzsaDnAQdVjxRwSvaWMInBa+0OWzVtPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz14t1755830120t4c265b03
X-QQ-Originating-IP: 05WC8JQxyshosD7tyRoMbggTS/IbwKSAfPSZRqfZtY0=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 10:35:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15569888230356707103
EX-QQ-RecipientCnt: 26
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Date: Fri, 22 Aug 2025 10:34:52 +0800
Message-Id: <20250822023453.1910972-5-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822023453.1910972-1-dong100@mucse.com>
References: <20250822023453.1910972-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OaUS/vBL36PcpVpb68d9zSb+0v77JFlLidH508ojYjs8H8/an9MmYdoz
	nbGvthrC3jOwc+hkZRal8kBdHCIw2mzjUaCEMxY5zi/HLrBy1JphQWvAqR39X60PsdfeH5G
	q+NkOkGsbs7GQIlyXQiNX/np7Uj05jf8vGVPMjgkLlCzpz5A29x+rsuQFVFxATq8FyldgjS
	7vGLSVgji186t1hXZu5CKAlr2ZHB1wf+es+lmdGjefcXJ+ilXlcnkzHpOwzG8pshi5J0ihs
	UR+WSW4jlU4/veQLTgTZy8aHNE47jm54ZqHLAIevcWS5j3Mpf16i1vAftkE6BkcVZqQCqbd
	PNTa+EY3URppulH/CW1YCOqASKc0eEHzMVb4UkmBThET/ku2W00dgWFtiJBJTTExxb5Ehhn
	64sQwANbtEVh87u1SS+/Jp9IXwI5w/Hfke4u1JbAt6aIKddI+uY9tNiH033d7GtstJ/LcJo
	b04+zsBmgHb4fm2jqhr6mKPHBi2Zbp695rnZOE7Uw8Y2uVmgl7a28xOCWr7c6CtaCGBIG26
	0BBn74SdBEbqPMKgXlVnoJgTCs+MAy/hxCUceWdSie67xQ/Ec6EUlDSZk9T8n3xTwMrKBxV
	glRYH7CzO9cka++KzkeD8dgbkPtMYGE65aFYvww0OSofE/dlOORIrHT6AeRXBSiIPcVo6gq
	nQB48HgeMKka7NP4hqL1B0oh/TfM+IQTWmOavqx4fAjGhvo2OliiSwDAhkv06B9cn4isvID
	mNDWK02dixonspzMM4AF7ZM1I4PB7E5z3rKoREhO4RofozmLZCFpbwjEc2m3WHa9qIYrqrK
	iSg5ACS3dvSHF3CIMC1V7W2X4ECMpgxg02V00y46Gmu4r3UdcOcAd1Cs9G2972c58wwaKqT
	Ou+lvqyLbFJTI3HiN/JuUsFlQ9uoWrCJi2P83aQJnsLY+yQii2ABEStiup2cwFNC6tcK3TV
	wRRmMXe0w/Ehrk+1VarWGEr7ZAcwXi0ObG1ATktZBwLGiqJxxm9HOXfpfN433u/R50R3ItG
	VwkTWlodIQaYxWDkcqib+boyC4rvnHkFhKBmD7Jw2hKnGfh7c2odG6FebnAfM=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Initialize basic mbx_fw ops, such as get_capability, reset phy
and so on.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 333 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 152 ++++++++
 4 files changed, 488 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index 5fc878ada4b1..de8bcb7772ab 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -7,4 +7,5 @@
 obj-$(CONFIG_MGBE) += rnpgbe.o
 rnpgbe-objs := rnpgbe_main.o\
 	       rnpgbe_chip.o\
-	       rnpgbe_mbx.o
+	       rnpgbe_mbx.o\
+	       rnpgbe_mbx_fw.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 67e28a4667e7..a32419a34d75 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -52,6 +52,7 @@ struct mucse_hw {
 	void __iomem *hw_addr;
 	struct pci_dev *pdev;
 	enum rnpgbe_hw_type hw_type;
+	u8 pfvfnum;
 	struct mucse_mbx_info mbx;
 };
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
new file mode 100644
index 000000000000..84570763cf79
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include <linux/pci.h>
+#include <linux/if_ether.h>
+
+#include "rnpgbe.h"
+#include "rnpgbe_hw.h"
+#include "rnpgbe_mbx.h"
+#include "rnpgbe_mbx_fw.h"
+
+/**
+ * mucse_fw_send_cmd_wait - Send cmd req and wait for response
+ * @hw: pointer to the HW structure
+ * @req: pointer to the cmd req structure
+ * @reply: pointer to the fw reply structure
+ *
+ * mucse_fw_send_cmd_wait sends req to pf-fw mailbox and wait
+ * reply from fw.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
+				  struct mbx_fw_cmd_req *req,
+				  struct mbx_fw_cmd_reply *reply)
+{
+	int len = le16_to_cpu(req->datalen);
+	int retry_cnt = 3;
+	int err;
+
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
+	err = mucse_write_posted_mbx(hw, (u32 *)req, len);
+	if (err)
+		goto out;
+	do {
+		err = mucse_read_posted_mbx(hw, (u32 *)reply,
+					    sizeof(*reply));
+		if (err)
+			goto out;
+		/* mucse_write_posted_mbx return 0 means fw has
+		 * received request, wait for the expect opcode
+		 * reply with 'retry_cnt' times.
+		 */
+	} while (--retry_cnt >= 0 && reply->opcode != req->opcode);
+out:
+	mutex_unlock(&hw->mbx.lock);
+	if (!err && retry_cnt < 0)
+		return -ETIMEDOUT;
+	if (!err && reply->error_code)
+		return -EIO;
+	return err;
+}
+
+/**
+ * build_phy_abilities_req - build req with get_phy_ability opcode
+ * @req: pointer to the cmd req structure
+ **/
+static void build_phy_abilities_req(struct mbx_fw_cmd_req *req)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(GET_PHY_ABILITY);
+	req->datalen = cpu_to_le16(MBX_REQ_HDR_LEN);
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+}
+
+/**
+ * mucse_fw_get_capability - Get hw abilities from fw
+ * @hw: pointer to the HW structure
+ * @abil: pointer to the hw_abilities structure
+ *
+ * mucse_fw_get_capability tries to get hw abilities from
+ * hw.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_fw_get_capability(struct mucse_hw *hw,
+				   struct hw_abilities *abil)
+{
+	struct mbx_fw_cmd_reply reply = {};
+	struct mbx_fw_cmd_req req = {};
+	int err;
+
+	build_phy_abilities_req(&req);
+	err = mucse_fw_send_cmd_wait(hw, &req, &reply);
+	if (!err)
+		memcpy(abil, &reply.hw_abilities, sizeof(*abil));
+	return err;
+}
+
+/**
+ * mucse_mbx_get_capability - Get hw abilities from fw
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_get_capability tries to get capabities from
+ * hw. Many retrys will do if it is failed.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_get_capability(struct mucse_hw *hw)
+{
+	struct hw_abilities ability = {};
+	int try_cnt = 3;
+	int err = -EIO;
+
+	while (try_cnt--) {
+		err = mucse_fw_get_capability(hw, &ability);
+		if (err)
+			continue;
+		hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
+		return 0;
+	}
+	return err;
+}
+
+/**
+ * mbx_cookie_zalloc - Alloc a cookie structure
+ * @priv_len: private length for this cookie
+ *
+ * @return: cookie structure on success
+ **/
+static struct mbx_req_cookie *mbx_cookie_zalloc(int priv_len)
+{
+	struct mbx_req_cookie *cookie;
+
+	cookie = kzalloc(struct_size(cookie, priv, priv_len), GFP_KERNEL);
+	if (cookie) {
+		cookie->timeout_jiffies = 30 * HZ;
+		cookie->magic = COOKIE_MAGIC;
+		cookie->priv_len = priv_len;
+	}
+	return cookie;
+}
+
+/**
+ * mucse_mbx_fw_post_req - Posts a mbx req to firmware and wait reply
+ * @hw: pointer to the HW structure
+ * @req: pointer to the cmd req structure
+ * @cookie: pointer to the req cookie
+ *
+ * mucse_mbx_fw_post_req posts a mbx req to firmware and wait for the
+ * reply. cookie->wait will be set in irq handler.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
+				 struct mbx_fw_cmd_req *req,
+				 struct mbx_req_cookie *cookie)
+{
+	int len = le16_to_cpu(req->datalen);
+	int err;
+
+	cookie->errcode = 0;
+	cookie->done = 0;
+	init_waitqueue_head(&cookie->wait);
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
+	err = mucse_write_mbx_pf(hw, (u32 *)req, len);
+	if (err)
+		goto out;
+	/* if write succeeds, we must wait for firmware response or
+	 * timeout to avoid using the already freed cookie->wait
+	 */
+	err = wait_event_timeout(cookie->wait,
+				 cookie->done == 1,
+				 cookie->timeout_jiffies);
+
+	if (!err)
+		err = -ETIMEDOUT;
+	else
+		err = 0;
+	if (!err && cookie->errcode)
+		err = cookie->errcode;
+out:
+	mutex_unlock(&hw->mbx.lock);
+	return err;
+}
+
+/**
+ * build_ifinsmod - build req with insmod opcode
+ * @req: pointer to the cmd req structure
+ * @status: true for insmod, false for rmmod
+ **/
+static void build_ifinsmod(struct mbx_fw_cmd_req *req,
+			   int status)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(DRIVER_INSMOD);
+	req->datalen = cpu_to_le16(sizeof(req->ifinsmod) +
+				   MBX_REQ_HDR_LEN);
+	req->cookie = NULL;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+#define FIXED_VERSION 0xFFFFFFFF
+	req->ifinsmod.version = cpu_to_le32(FIXED_VERSION);
+	req->ifinsmod.status = cpu_to_le32(status);
+}
+
+/**
+ * mucse_mbx_ifinsmod - Echo driver insmod status to hw
+ * @hw: pointer to the HW structure
+ * @status: true for insmod, false for rmmod
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_ifinsmod(struct mucse_hw *hw, int status)
+{
+	struct mbx_fw_cmd_req req = {};
+	int len;
+	int err;
+
+	build_ifinsmod(&req, status);
+	len = le16_to_cpu(req.datalen);
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
+
+	if (status) {
+		err = mucse_write_posted_mbx(hw, (u32 *)&req,
+					     len);
+	} else {
+		err = mucse_write_mbx_pf(hw, (u32 *)&req,
+					 len);
+	}
+
+	mutex_unlock(&hw->mbx.lock);
+	return err;
+}
+
+/**
+ * build_reset_phy_req - build req with reset_phy opcode
+ * @req: pointer to the cmd req structure
+ * @cookie: pointer of cookie for this cmd
+ **/
+static void build_reset_phy_req(struct mbx_fw_cmd_req *req,
+				void *cookie)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(RESET_PHY);
+	req->datalen = cpu_to_le16(MBX_REQ_HDR_LEN);
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->cookie = cookie;
+}
+
+/**
+ * mucse_mbx_fw_reset_phy - Posts a mbx req to reset hw
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_fw_reset_phy posts a mbx req to firmware to reset hw.
+ * It uses mucse_fw_send_cmd_wait if no irq, and mucse_mbx_fw_post_req
+ * if other irq is registered.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_fw_reset_phy(struct mucse_hw *hw)
+{
+	struct mbx_fw_cmd_reply reply = {};
+	struct mbx_fw_cmd_req req = {};
+	int ret;
+
+	if (hw->mbx.irq_enabled) {
+		struct mbx_req_cookie *cookie = mbx_cookie_zalloc(0);
+
+		if (!cookie)
+			return -ENOMEM;
+
+		build_reset_phy_req(&req, cookie);
+		ret = mucse_mbx_fw_post_req(hw, &req, cookie);
+		kfree(cookie);
+		return ret;
+	}
+
+	build_reset_phy_req(&req, &req);
+	return mucse_fw_send_cmd_wait(hw, &req, &reply);
+}
+
+/**
+ * build_get_macaddress_req - build req with get_mac opcode
+ * @req: pointer to the cmd req structure
+ * @port_mask: port valid for this cmd
+ * @pfvfnum: pfvfnum for this cmd
+ * @cookie: pointer of cookie for this cmd
+ **/
+static void build_get_macaddress_req(struct mbx_fw_cmd_req *req,
+				     int port_mask, int pfvfnum,
+				     void *cookie)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le16(GET_MAC_ADDRES);
+	req->datalen = cpu_to_le16(sizeof(req->get_mac_addr) +
+				   MBX_REQ_HDR_LEN);
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->get_mac_addr.port_mask = cpu_to_le32(port_mask);
+	req->get_mac_addr.pfvf_num = cpu_to_le32(pfvfnum);
+}
+
+/**
+ * mucse_fw_get_macaddr - Posts a mbx req to request macaddr
+ * @hw: pointer to the HW structure
+ * @pfvfnum: index of pf/vf num
+ * @mac_addr: pointer to store mac_addr
+ * @port: port index
+ *
+ * mucse_fw_get_macaddr posts a mbx req to firmware to get mac_addr.
+ * It uses mucse_fw_send_cmd_wait if no irq, and mucse_mbx_fw_post_req
+ * if other irq is registered.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
+			 u8 *mac_addr,
+			 int port)
+{
+	struct mbx_fw_cmd_reply reply = {};
+	struct mbx_fw_cmd_req req = {};
+	int err;
+
+	build_get_macaddress_req(&req, BIT(port), pfvfnum, &req);
+	err = mucse_fw_send_cmd_wait(hw, &req, &reply);
+	if (err)
+		return err;
+	if (le32_to_cpu(reply.mac_addr.ports) & BIT(port))
+		memcpy(mac_addr, reply.mac_addr.addrs[port].mac, ETH_ALEN);
+	else
+		return -ENODATA;
+	return 0;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
new file mode 100644
index 000000000000..b73238d0e848
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_MBX_FW_H
+#define _RNPGBE_MBX_FW_H
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/wait.h>
+
+#include "rnpgbe.h"
+
+#define MBX_REQ_HDR_LEN 24
+
+struct mbx_fw_cmd_reply;
+typedef void (*cookie_cb)(struct mbx_fw_cmd_reply *reply, void *priv);
+
+struct mbx_req_cookie {
+	int magic;
+#define COOKIE_MAGIC 0xCE
+	cookie_cb cb;
+	int timeout_jiffies;
+	int errcode;
+	wait_queue_head_t wait;
+	int done;
+	int priv_len;
+	char priv[] __counted_by(priv_len);
+};
+
+enum MUCSE_FW_CMD {
+	GET_PHY_ABILITY = 0x0601,
+	GET_MAC_ADDRES = 0x0602,
+	RESET_PHY = 0x0603,
+	DRIVER_INSMOD = 0x0803,
+};
+
+struct hw_abilities {
+	u8 link_stat;
+	u8 port_mask;
+	__le32 speed;
+	__le16 phy_type;
+	__le16 nic_mode;
+	__le16 pfnum;
+	__le32 fw_version;
+	__le32 axi_mhz;
+	union {
+		u8 port_id[4];
+		__le32 port_ids;
+	};
+	__le32 bd_uid;
+	__le32 phy_id;
+	__le32 wol_status;
+	union {
+		__le32 ext_ability;
+		struct {
+			u32 valid : 1;
+			u32 wol_en : 1;
+			u32 pci_preset_runtime_en : 1;
+			u32 smbus_en : 1;
+			u32 ncsi_en : 1;
+			u32 rpu_en : 1;
+			u32 v2 : 1;
+			u32 pxe_en : 1;
+			u32 mctp_en : 1;
+			u32 yt8614 : 1;
+			u32 pci_ext_reset : 1;
+			u32 rpu_availble : 1;
+			u32 fw_lldp_ability : 1;
+			u32 lldp_enabled : 1;
+			u32 only_1g : 1;
+			u32 force_down_en: 1;
+		} e_host;
+	};
+} __packed;
+
+/* FW stores extended ability information in 'ext_ability' as a 32-bit
+ * little-endian value. To make these flags easily accessible in the
+ * kernel (via named 'bitfields' instead of raw bitmask operations),
+ * we use the union's 'e_host' struct, which provides named bits
+ * (e.g., 'wol_en', 'smbus_en')
+ */
+static inline void ability_update_host_endian(struct hw_abilities *abi)
+{
+	u32 host_val = le32_to_cpu(abi->ext_ability);
+
+	abi->e_host = *(typeof(abi->e_host) *)&host_val;
+}
+
+#define FLAGS_DD BIT(0)
+#define FLAGS_ERR BIT(2)
+
+struct mbx_fw_cmd_req {
+	__le16 flags;
+	__le16 opcode;
+	__le16 datalen;
+	__le16 ret_value;
+	union {
+		struct {
+			__le32 cookie_lo;
+			__le32 cookie_hi;
+		};
+
+		void *cookie;
+	};
+	__le32 reply_lo;
+	__le32 reply_hi;
+	union {
+		u8 data[32];
+		struct {
+			__le32 version;
+			__le32 status;
+		} ifinsmod;
+		struct {
+			__le32 port_mask;
+			__le32 pfvf_num;
+		} get_mac_addr;
+	};
+} __packed;
+
+struct mbx_fw_cmd_reply {
+	__le16 flags;
+	__le16 opcode;
+	__le16 error_code;
+	__le16 datalen;
+	union {
+		struct {
+			__le32 cookie_lo;
+			__le32 cookie_hi;
+		};
+		void *cookie;
+	};
+	union {
+		u8 data[40];
+		struct mac_addr {
+			__le32 ports;
+			struct _addr {
+				/* for macaddr:01:02:03:04:05:06
+				 * mac-hi=0x01020304 mac-lo=0x05060000
+				 */
+				u8 mac[8];
+			} addrs[4];
+		} mac_addr;
+		struct hw_abilities hw_abilities;
+	};
+} __packed;
+
+int mucse_mbx_get_capability(struct mucse_hw *hw);
+int mucse_mbx_ifinsmod(struct mucse_hw *hw, int status);
+int mucse_mbx_fw_reset_phy(struct mucse_hw *hw);
+int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
+			 u8 *mac_addr, int port);
+#endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


