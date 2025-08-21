Return-Path: <linux-kernel+bounces-780263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761FCB2FF9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84996586757
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C8726B2C8;
	Thu, 21 Aug 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnAdf3Ge"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096ED275B0D;
	Thu, 21 Aug 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791881; cv=none; b=jxSyKCWUTVRDcJorjsXcPz+6uVTCYWwDQC3HMB7w4SAy9v88KYiWKjZLk4WWiFYNbKR2JZmiK3sBmavQ1c8PABQtFG3HKtFavIGA+d0KbzW/4jVKffQRw2C+vvx+Ff6XDrmB8XcPlAbHHdwbcrbP22tvxaygT3oITEU378rQjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791881; c=relaxed/simple;
	bh=l8WoV3YlyoxpdOjeHsTAr+LWXJ/wtTFGjsdJKC46ar4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b+SZ+tbtVmyMvbvzmPUAnaSkQ8L5+gYTfuGrTeJG64Pcsw53PWQTID4yb5OSP/EwD12lKxBXrgmb1VQrHffAR2jNkFozODEvpdXJc6WNDXUVoxUh2zf4vbMlH9EBNqeyfHClkPEMEktUrPj5p1YvN4C3ZYt9FgRYWCKghJEL/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnAdf3Ge; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea6ccb7so1034950b3a.2;
        Thu, 21 Aug 2025 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791879; x=1756396679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7voIdUaBxDRgC5zsji/FHeXok30rGXfnded7LBrZ1jU=;
        b=MnAdf3Ge1ZN0R8XWKOzxbpq0/E4mufix61yGwvXwScyOT5qcbk5Fvs7L+/DXn9TMxD
         OgpIKA6nvx+UJg2y8UkvDTGA2Om3q19rBPieH10sQY2u5j8eJ7/j7AobsacVOZnruxDV
         27KBE8jaAZ6zVqhaXLIfzL8ZDqmqCPp4+zPEnabxE43oKjzldQIk5TyxSmWLQ1mjC43v
         f5jwywTv07sm0Gw5M5ZyKIBF4r1JdoEGjPbMkKfYLAOdC/3ur0Nj9ZiLNP036Ec7A3yl
         tWYpqe0Phc4S2dIVV8+AfDRkLzLUtp+CqMQtIZBUJSePxEMf6ww8mGGC1qcQUQOVx+8d
         scgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791879; x=1756396679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7voIdUaBxDRgC5zsji/FHeXok30rGXfnded7LBrZ1jU=;
        b=q4DK4RxRHpLjpxMtxxHN1sEOJ0KAsxhSKJ6JeGfWeYM58r5NY4pvWBui71xUV1SmMM
         Tj1Mu7WZrq0R+Zzdr5aWmVfeI4SkEZPqYEI+4NHiU8kXS5iI5eb16QAols9HuREAie8w
         ZxC3VFvZ5N06Vwe3vrgEy+rkYCFUABMnHG4lJTxpZWJrJX94Le5DFhrKxZHEUc9uMHek
         ixedimMv9y551el4UwtkkKLXDrWmvj0aej1kXXAoaKp5d/O3bcTWXeSwWPSlw8WUbPHb
         xTMIv0I7bv3MsD8eZS0XxFFxgNUTcaifPk4Qv7ccM8PE9FrHhnryGvRH7GWPtbE97ULE
         TtaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU70iUtBBMLcn6wZW91Rw9m0Lz91Kd9aNeE68z7tMrdJz7vTzfcPWToR/fZrzJMuQPA37Lj1Pl4qUBti6YK@vger.kernel.org, AJvYcCWZZQsgoleMnWsH2cYiArnHMHwamhlR/LCXdCxsI4W6JGD6NX6gFSGzsDNJPhnvq45ubd6oENRsFq7c@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsoE/yiBb8+s7EpgSFIPBgtePFsViZAvLfArPI8ouLNhVcB9T
	4AFtQh6x/ydGDSggdj8aYEwIOVVXKjeD3E8JfDWIAf4Rgwj2jnCM2VpM5R5fEIUM
X-Gm-Gg: ASbGncseTO2ptXcLiGJo00Z1oTMFNtgFCt7vlQ/whkllaTfk2LqpooR1SdkIRX4xCtd
	pZuiEAgfsymMbNtm8eXWyOot3p7iHdXRHLbhyIWf6TDRx0KQprmvSnfDCdzjimilaaEBCxfgkK2
	aHMSGT+I54KLd53jli1tJ0T/vOa0cn6gNDA/AkbGIx9TXHEosc/CO/Nkzlx+BWi5QxJ7IJoueeo
	NBiU2ig4qa0jRnmflj7FW0H2Q2Iu3j9mIoTQsCYDf5Fza6Zq+lGqd2IoJXEbFzE8nvfSRvBRSz0
	STypFy03mXBgtQdn+ivUeUtCuX4h/Qqy09R6cRzzc4hRY30d+kIyeUKUIOtz4VC8mvSOfX52Y75
	qkcaFR6laPqRtDWV4XysaNp08RSXU3Dx5UYixHhyk19YGqrY=
X-Google-Smtp-Source: AGHT+IHJ8XiiMKNg9oU7aMgvuJznSZ90yQjZ9amgqL1Eue98y8of0rhI9lWh/pPHNh28cv90SzmelA==
X-Received: by 2002:a05:6a21:9992:b0:21c:faa4:9ab8 with SMTP id adf61e73a8af0-24330820cf0mr4907458637.10.1755791879271;
        Thu, 21 Aug 2025 08:57:59 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:58 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:44 +0800
Subject: [PATCH v3 7/9] nvme: apple: Add Apple A11 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13100;
 i=towinchenmi@gmail.com; h=from:subject:message-id;
 bh=l8WoV3YlyoxpdOjeHsTAr+LWXJ/wtTFGjsdJKC46ar4=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HVsE2yJnFM9MBvWj878fzdyalrFpk6pG2t+
 qRo+8bT9GWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1QAKCRABygi3psUI
 JPHpD/sGzwgCfR/nENB7AFQtUmMGkWVUO0+oXslTj4LzAl+hMFVX9KBDo08K5x48YtZB8LT3o1w
 EGa9TTodg3kP7ENDgIfEDkfVoTLWa1RAdEcIDHcLtezxds1PBtTrQiuQMJWLjFN8rWwv2JqLVoB
 CosDzppTfBXQ6S5SRPPRbQYe+j//zZh+vXi8xBTnsvLIkQFWmLc2vrrA3xqb1ORjp1ZLJpArqLF
 xvKTAwlWxmdt+IBr6rgC5H3XSfTWIp9/jBzyOPGeuaWoa9Z7mJOJ/Pdf1+T/xiGGkVg51cXanz9
 X/O6JKNtm3avrcesfAdcqmDTbTmr01HS3ZtLf7R+0dZ/zyDSBRcdnaTts+XCpiReAhhRIDA6wsI
 qY/wv4atjfUetFYbeoSb+FhJM6MdDzatoyY4gORPZQbFE6Yg8cCODoNUuBuwKh1rnPmRte+MibO
 2WOnwrphb6jz/j4jUsSS5KvAU9k+81h9F++uGfAZskxsv9YzUYR/oMab7En/MekbzjEreBmRZsT
 7LbH3PASkOzOh2sxh0NqwtTv3IpJZL37+DY/9yhbgk0aNsWRIfkdIWApiZMEn6/DRT/f4JvK6Yx
 FYF90n3G46dx2nGur411EqXSj1XK31rQ2DjPVma8Yyc8d2OVVKIxQvl099OQJ0IJv75sIi19AOc
 z2AOzeY/+SzB67Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for ANS2 NVMe on Apple A11 SoC.

This version of ANS2 is less quirky than the one in M1, and does not have
NVMMU or Linear SQ. However, it still requires a non-standard 128-byte
SQE.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/nvme/host/apple.c | 196 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 136 insertions(+), 60 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 1286c31320e630cb012009d6b962526e0553869f..d899ea3684af1d02daa236c77c973f5831d8f593 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -35,7 +35,6 @@
 #include "nvme.h"
 
 #define APPLE_ANS_BOOT_TIMEOUT	  USEC_PER_SEC
-#define APPLE_ANS_MAX_QUEUE_DEPTH 64
 
 #define APPLE_ANS_COPROC_CPU_CONTROL	 0x44
 #define APPLE_ANS_COPROC_CPU_CONTROL_RUN BIT(4)
@@ -75,6 +74,8 @@
 #define APPLE_NVME_AQ_DEPTH	   2
 #define APPLE_NVME_AQ_MQ_TAG_DEPTH (APPLE_NVME_AQ_DEPTH - 1)
 
+#define APPLE_NVME_IOSQES	7
+
 /*
  * These can be higher, but we need to ensure that any command doesn't
  * require an sg allocation that needs more than a page of data.
@@ -142,6 +143,7 @@ struct apple_nvme_queue {
 	u32 __iomem *sq_db;
 	u32 __iomem *cq_db;
 
+	u16 sq_tail;
 	u16 cq_head;
 	u8 cq_phase;
 
@@ -166,11 +168,17 @@ struct apple_nvme_iod {
 	struct scatterlist *sg;
 };
 
+struct apple_nvme_hw {
+	bool has_lsq_nvmmu;
+	u32 max_queue_depth;
+};
+
 struct apple_nvme {
 	struct device *dev;
 
 	void __iomem *mmio_coproc;
 	void __iomem *mmio_nvme;
+	const struct apple_nvme_hw *hw;
 
 	struct device **pd_dev;
 	struct device_link **pd_link;
@@ -215,10 +223,12 @@ static inline struct apple_nvme *queue_to_apple_nvme(struct apple_nvme_queue *q)
 
 static unsigned int apple_nvme_queue_depth(struct apple_nvme_queue *q)
 {
-	if (q->is_adminq)
+	struct apple_nvme *anv = queue_to_apple_nvme(q);
+
+	if (q->is_adminq && anv->hw->has_lsq_nvmmu)
 		return APPLE_NVME_AQ_DEPTH;
 
-	return APPLE_ANS_MAX_QUEUE_DEPTH;
+	return anv->hw->max_queue_depth;
 }
 
 static void apple_nvme_rtkit_crashed(void *cookie, const void *crashlog, size_t crashlog_size)
@@ -280,7 +290,28 @@ static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
 				     "NVMMU TCB invalidation failed\n");
 }
 
-static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
+static void apple_nvme_submit_cmd_t8015(struct apple_nvme_queue *q,
+				  struct nvme_command *cmd)
+{
+	struct apple_nvme *anv = queue_to_apple_nvme(q);
+
+	spin_lock_irq(&anv->lock);
+
+	if (q->is_adminq)
+		memcpy(&q->sqes[q->sq_tail], cmd, sizeof(*cmd));
+	else
+		memcpy((void *)q->sqes + (q->sq_tail << APPLE_NVME_IOSQES),
+			cmd, sizeof(*cmd));
+
+	if (++q->sq_tail == anv->hw->max_queue_depth)
+		q->sq_tail = 0;
+
+	writel(q->sq_tail, q->sq_db);
+	spin_unlock_irq(&anv->lock);
+}
+
+
+static void apple_nvme_submit_cmd_t8103(struct apple_nvme_queue *q,
 				  struct nvme_command *cmd)
 {
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
@@ -590,7 +621,8 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
 	__u16 command_id = READ_ONCE(cqe->command_id);
 	struct request *req;
 
-	apple_nvmmu_inval(q, command_id);
+	if (anv->hw->has_lsq_nvmmu)
+		apple_nvmmu_inval(q, command_id);
 
 	req = nvme_find_rq(apple_nvme_queue_tagset(anv, q), command_id);
 	if (unlikely(!req)) {
@@ -685,7 +717,7 @@ static int apple_nvme_create_cq(struct apple_nvme *anv)
 	c.create_cq.opcode = nvme_admin_create_cq;
 	c.create_cq.prp1 = cpu_to_le64(anv->ioq.cq_dma_addr);
 	c.create_cq.cqid = cpu_to_le16(1);
-	c.create_cq.qsize = cpu_to_le16(APPLE_ANS_MAX_QUEUE_DEPTH - 1);
+	c.create_cq.qsize = cpu_to_le16(anv->hw->max_queue_depth - 1);
 	c.create_cq.cq_flags = cpu_to_le16(NVME_QUEUE_PHYS_CONTIG | NVME_CQ_IRQ_ENABLED);
 	c.create_cq.irq_vector = cpu_to_le16(0);
 
@@ -713,7 +745,7 @@ static int apple_nvme_create_sq(struct apple_nvme *anv)
 	c.create_sq.opcode = nvme_admin_create_sq;
 	c.create_sq.prp1 = cpu_to_le64(anv->ioq.sq_dma_addr);
 	c.create_sq.sqid = cpu_to_le16(1);
-	c.create_sq.qsize = cpu_to_le16(APPLE_ANS_MAX_QUEUE_DEPTH - 1);
+	c.create_sq.qsize = cpu_to_le16(anv->hw->max_queue_depth - 1);
 	c.create_sq.sq_flags = cpu_to_le16(NVME_QUEUE_PHYS_CONTIG);
 	c.create_sq.cqid = cpu_to_le16(1);
 
@@ -765,7 +797,12 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	nvme_start_request(req);
-	apple_nvme_submit_cmd(q, cmnd);
+
+	if (anv->hw->has_lsq_nvmmu)
+		apple_nvme_submit_cmd_t8103(q, cmnd);
+	else
+		apple_nvme_submit_cmd_t8015(q, cmnd);
+
 	return BLK_STS_OK;
 
 out_free_cmd:
@@ -970,11 +1007,13 @@ static const struct blk_mq_ops apple_nvme_mq_ops = {
 static void apple_nvme_init_queue(struct apple_nvme_queue *q)
 {
 	unsigned int depth = apple_nvme_queue_depth(q);
+	struct apple_nvme *anv = queue_to_apple_nvme(q);
 
 	q->cq_head = 0;
 	q->cq_phase = 1;
-	memset(q->tcbs, 0,
-	       APPLE_ANS_MAX_QUEUE_DEPTH * sizeof(struct apple_nvmmu_tcb));
+	if (anv->hw->has_lsq_nvmmu)
+		memset(q->tcbs, 0, anv->hw->max_queue_depth
+			* sizeof(struct apple_nvmmu_tcb));
 	memset(q->cqes, 0, depth * sizeof(struct nvme_completion));
 	WRITE_ONCE(q->enabled, true);
 	wmb(); /* ensure the first interrupt sees the initialization */
@@ -1069,49 +1108,54 @@ static void apple_nvme_reset_work(struct work_struct *work)
 
 	dma_set_max_seg_size(anv->dev, 0xffffffff);
 
-	/*
-	 * Enable NVMMU and linear submission queues.
-	 * While we could keep those disabled and pretend this is slightly
-	 * more common NVMe controller we'd still need some quirks (e.g.
-	 * sq entries will be 128 bytes) and Apple might drop support for
-	 * that mode in the future.
-	 */
-	writel(APPLE_ANS_LINEAR_SQ_EN,
-	       anv->mmio_nvme + APPLE_ANS_LINEAR_SQ_CTRL);
+	if (anv->hw->has_lsq_nvmmu) {
+		/*
+		 * Enable NVMMU and linear submission queues which is required
+		 * since T6000.
+		 */
+		writel(APPLE_ANS_LINEAR_SQ_EN,
+			anv->mmio_nvme + APPLE_ANS_LINEAR_SQ_CTRL);
 
-	/* Allow as many pending command as possible for both queues */
-	writel(APPLE_ANS_MAX_QUEUE_DEPTH | (APPLE_ANS_MAX_QUEUE_DEPTH << 16),
-	       anv->mmio_nvme + APPLE_ANS_MAX_PEND_CMDS_CTRL);
+		/* Allow as many pending command as possible for both queues */
+		writel(anv->hw->max_queue_depth | (anv->hw->max_queue_depth << 16),
+			anv->mmio_nvme + APPLE_ANS_MAX_PEND_CMDS_CTRL);
 
-	/* Setup the NVMMU for the maximum admin and IO queue depth */
-	writel(APPLE_ANS_MAX_QUEUE_DEPTH - 1,
-	       anv->mmio_nvme + APPLE_NVMMU_NUM_TCBS);
+		/* Setup the NVMMU for the maximum admin and IO queue depth */
+		writel(anv->hw->max_queue_depth - 1,
+			anv->mmio_nvme + APPLE_NVMMU_NUM_TCBS);
 
-	/*
-	 * This is probably a chicken bit: without it all commands where any PRP
-	 * is set to zero (including those that don't use that field) fail and
-	 * the co-processor complains about "completed with err BAD_CMD-" or
-	 * a "NULL_PRP_PTR_ERR" in the syslog
-	 */
-	writel(readl(anv->mmio_nvme + APPLE_ANS_UNKNOWN_CTRL) &
-		       ~APPLE_ANS_PRP_NULL_CHECK,
-	       anv->mmio_nvme + APPLE_ANS_UNKNOWN_CTRL);
+		/*
+		 * This is probably a chicken bit: without it all commands
+		 * where any PRP is set to zero (including those that don't use
+		 * that field) fail and the co-processor complains about
+		 * "completed with err BAD_CMD-" or a "NULL_PRP_PTR_ERR" in the
+		 * syslog
+		 */
+		writel(readl(anv->mmio_nvme + APPLE_ANS_UNKNOWN_CTRL) &
+			~APPLE_ANS_PRP_NULL_CHECK,
+			anv->mmio_nvme + APPLE_ANS_UNKNOWN_CTRL);
+	}
 
 	/* Setup the admin queue */
-	aqa = APPLE_NVME_AQ_DEPTH - 1;
+	if (anv->hw->has_lsq_nvmmu)
+		aqa = APPLE_NVME_AQ_DEPTH - 1;
+	else
+		aqa = anv->hw->max_queue_depth - 1;
 	aqa |= aqa << 16;
 	writel(aqa, anv->mmio_nvme + NVME_REG_AQA);
 	writeq(anv->adminq.sq_dma_addr, anv->mmio_nvme + NVME_REG_ASQ);
 	writeq(anv->adminq.cq_dma_addr, anv->mmio_nvme + NVME_REG_ACQ);
 
-	/* Setup NVMMU for both queues */
-	writeq(anv->adminq.tcb_dma_addr,
-	       anv->mmio_nvme + APPLE_NVMMU_ASQ_TCB_BASE);
-	writeq(anv->ioq.tcb_dma_addr,
-	       anv->mmio_nvme + APPLE_NVMMU_IOSQ_TCB_BASE);
+	if (anv->hw->has_lsq_nvmmu) {
+		/* Setup NVMMU for both queues */
+		writeq(anv->adminq.tcb_dma_addr,
+			anv->mmio_nvme + APPLE_NVMMU_ASQ_TCB_BASE);
+		writeq(anv->ioq.tcb_dma_addr,
+			anv->mmio_nvme + APPLE_NVMMU_IOSQ_TCB_BASE);
+	}
 
 	anv->ctrl.sqsize =
-		APPLE_ANS_MAX_QUEUE_DEPTH - 1; /* 0's based queue depth */
+		anv->hw->max_queue_depth - 1; /* 0's based queue depth */
 	anv->ctrl.cap = readq(anv->mmio_nvme + NVME_REG_CAP);
 
 	dev_dbg(anv->dev, "Enabling controller now");
@@ -1282,8 +1326,9 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 	 * both queues. The admin queue gets the first APPLE_NVME_AQ_DEPTH which
 	 * must be marked as reserved in the IO queue.
 	 */
-	anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
-	anv->tagset.queue_depth = APPLE_ANS_MAX_QUEUE_DEPTH - 1;
+	if (anv->hw->has_lsq_nvmmu)
+		anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
+	anv->tagset.queue_depth = anv->hw->max_queue_depth - 1;
 	anv->tagset.timeout = NVME_IO_TIMEOUT;
 	anv->tagset.numa_node = NUMA_NO_NODE;
 	anv->tagset.cmd_size = sizeof(struct apple_nvme_iod);
@@ -1307,6 +1352,7 @@ static int apple_nvme_queue_alloc(struct apple_nvme *anv,
 				  struct apple_nvme_queue *q)
 {
 	unsigned int depth = apple_nvme_queue_depth(q);
+	size_t iosq_size;
 
 	q->cqes = dmam_alloc_coherent(anv->dev,
 				      depth * sizeof(struct nvme_completion),
@@ -1314,22 +1360,28 @@ static int apple_nvme_queue_alloc(struct apple_nvme *anv,
 	if (!q->cqes)
 		return -ENOMEM;
 
-	q->sqes = dmam_alloc_coherent(anv->dev,
-				      depth * sizeof(struct nvme_command),
+	if (anv->hw->has_lsq_nvmmu)
+		iosq_size = depth * sizeof(struct nvme_command);
+	else
+		iosq_size = depth << APPLE_NVME_IOSQES;
+
+	q->sqes = dmam_alloc_coherent(anv->dev, iosq_size,
 				      &q->sq_dma_addr, GFP_KERNEL);
 	if (!q->sqes)
 		return -ENOMEM;
 
-	/*
-	 * We need the maximum queue depth here because the NVMMU only has a
-	 * single depth configuration shared between both queues.
-	 */
-	q->tcbs = dmam_alloc_coherent(anv->dev,
-				      APPLE_ANS_MAX_QUEUE_DEPTH *
-					      sizeof(struct apple_nvmmu_tcb),
-				      &q->tcb_dma_addr, GFP_KERNEL);
-	if (!q->tcbs)
-		return -ENOMEM;
+	if (anv->hw->has_lsq_nvmmu) {
+		/*
+		 * We need the maximum queue depth here because the NVMMU only
+		 * has a single depth configuration shared between both queues.
+		 */
+		q->tcbs = dmam_alloc_coherent(anv->dev,
+			anv->hw->max_queue_depth *
+				sizeof(struct apple_nvmmu_tcb),
+			&q->tcb_dma_addr, GFP_KERNEL);
+		if (!q->tcbs)
+			return -ENOMEM;
+	}
 
 	/*
 	 * initialize phase to make sure the allocated and empty memory
@@ -1413,6 +1465,12 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 	anv->adminq.is_adminq = true;
 	platform_set_drvdata(pdev, anv);
 
+	anv->hw = of_device_get_match_data(&pdev->dev);
+	if (!anv->hw) {
+		ret = -ENODEV;
+		goto put_dev;
+	}
+
 	ret = apple_nvme_attach_genpd(anv);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Failed to attach power domains");
@@ -1444,10 +1502,17 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 		goto put_dev;
 	}
 
-	anv->adminq.sq_db = anv->mmio_nvme + APPLE_ANS_LINEAR_ASQ_DB;
-	anv->adminq.cq_db = anv->mmio_nvme + APPLE_ANS_ACQ_DB;
-	anv->ioq.sq_db = anv->mmio_nvme + APPLE_ANS_LINEAR_IOSQ_DB;
-	anv->ioq.cq_db = anv->mmio_nvme + APPLE_ANS_IOCQ_DB;
+	if (anv->hw->has_lsq_nvmmu) {
+		anv->adminq.sq_db = anv->mmio_nvme + APPLE_ANS_LINEAR_ASQ_DB;
+		anv->adminq.cq_db = anv->mmio_nvme + APPLE_ANS_ACQ_DB;
+		anv->ioq.sq_db = anv->mmio_nvme + APPLE_ANS_LINEAR_IOSQ_DB;
+		anv->ioq.cq_db = anv->mmio_nvme + APPLE_ANS_IOCQ_DB;
+	} else {
+		anv->adminq.sq_db = anv->mmio_nvme + NVME_REG_DBS;
+		anv->adminq.cq_db = anv->mmio_nvme + APPLE_ANS_ACQ_DB;
+		anv->ioq.sq_db = anv->mmio_nvme + NVME_REG_DBS + 8;
+		anv->ioq.cq_db = anv->mmio_nvme + APPLE_ANS_IOCQ_DB;
+	}
 
 	anv->sart = devm_apple_sart_get(dev);
 	if (IS_ERR(anv->sart)) {
@@ -1625,8 +1690,19 @@ static int apple_nvme_suspend(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(apple_nvme_pm_ops, apple_nvme_suspend,
 				apple_nvme_resume);
 
+static const struct apple_nvme_hw apple_nvme_t8015_hw = {
+	.has_lsq_nvmmu = false,
+	.max_queue_depth = 16,
+};
+
+static const struct apple_nvme_hw apple_nvme_t8103_hw = {
+	.has_lsq_nvmmu = true,
+	.max_queue_depth = 64,
+};
+
 static const struct of_device_id apple_nvme_of_match[] = {
-	{ .compatible = "apple,nvme-ans2" },
+	{ .compatible = "apple,t8015-nvme-ans2", .data = &apple_nvme_t8015_hw },
+	{ .compatible = "apple,nvme-ans2", .data = &apple_nvme_t8103_hw },
 	{},
 };
 MODULE_DEVICE_TABLE(of, apple_nvme_of_match);

-- 
2.50.1


