Return-Path: <linux-kernel+bounces-773195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C3B29C99
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A65318A1CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF6302CBD;
	Mon, 18 Aug 2025 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJiVdLYR"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05BA308F02;
	Mon, 18 Aug 2025 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506648; cv=none; b=YKL7TWn/z50fgvYhSTRmnw5WEAQsktUzSd9mBS/fBZaiqIlISGoeaRbmiC7yKCod1JeTDL8+JacCFd9Y2RyGVAmcDKRxxbmTscUu7r058sx7+r3V14SPZ/CTTmxAI4CuUqhNUiUtdCqPeBCxk6mGkixv+zBs2Pm5DPC8dac115A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506648; c=relaxed/simple;
	bh=o5LJJMwTtsVbnSLH+/OYa2s6s1EHDZCy8cdlkUZK1bQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ntht57ygLcl9PViH5y/xJ0qDkM3Mk+IzDEAvcuGcr0Ci21wsc8ooojBMpWTgI2MFO5enIMomR4TbyN9tqvaXyc8FalAXjoW+9oMgNx56aKMvdml35IIzCt4zEWXeNuI/FmsKkjEahZG/iHKHgiV0kmp5iYgnF9FGZbbngixG8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJiVdLYR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ea887f6so2790131b3a.2;
        Mon, 18 Aug 2025 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506646; x=1756111446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqOtN4IH/xkxIsMcT4OL/9ZRyjFeoBWhcMonq91nfe8=;
        b=SJiVdLYRsNOEFSbLQnn0X25tjPsAxFWhNj7vUQNZ04DOg4107xsgLD/OOyB27CS8m2
         W2F2Kz5KXuLD48rKvAbMt/n3MsIIU8fMUzGxk8D3V2ay1Prlq1USy4JOHXNeoXZqyMcA
         XHbDgMun8YkiGKYquR0vs1Hiyv+28CKlCKZoTnCovDcW3gfU7PBIhmMNTVh8Ki/nu2bS
         NFvl0CIQZjXIS9E9DL+wHFMxE6g8ykfvycoKvFbAhbHH+ppkkub+oAnReSi0jaJ7/9xx
         bGCxNi7lGyw8TQxIHUgABn94tUQC6Ni+2P84U8sVupuKEJLXvpKtj5yR1FGo97VfUtsa
         wbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506646; x=1756111446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqOtN4IH/xkxIsMcT4OL/9ZRyjFeoBWhcMonq91nfe8=;
        b=wTDepIjU7cNYpXt11lJDXUbmzDTr/pN+I3oib6JkwyEPhvbcyV0qbLKHvWdXgM50Cs
         EhuWUWxLjRd2uDGKEJ0hdksnNHLi7f3YxJ6dOVMZpKRfdqD8qjthYghg+cT5zRTgz3VT
         qnzJ3K+BYD62bz7spgi+A9nvQCLVm5a5B4fSw//7Z93BWnCvMKiV1ENAIYBIR275EX15
         hgR4RfjLNEJ3PDBEpS+3ayDynj+KnwdXB1fdFQn8usfUX83ypK+WLeCBzDuhCvzyEBqk
         7F43QnLfz39RermSZS3pWbCejZ3k7jkqpjXx6bYyHcTHnMKg9X0sWS1W79rEn4T22Qzg
         9Z9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7YXtTzNoAtO1F3CkhaUCc7PGbxPyNlc9TPFrxRbHbojmrGQEOe32UzKiU/9TQETaq5KQ0XPuO5aIz@vger.kernel.org, AJvYcCWrUShBe2st6S7MT/epe8xG4tovuK2+h/O9FwGkkHxBgDZwTPvXN+fgaBkoKhk6WIg1Qd8ehnuqvXzGKs1W@vger.kernel.org
X-Gm-Message-State: AOJu0YxozjL4D7G8K9NemPK+GfWK/7/avTBJMO4NCjl2V99687roZ4nJ
	AqA9bdfNoQqXzPWNt2j/zwcUVt86XDjs0VrCQrWP0CY0UhWPIIFMSA6y
X-Gm-Gg: ASbGncvggLFOZvL2j20QqW+Li2lNVNQ0LUh8OsD6d3O08Tg5MdX9p5bAuMEZ71w/qe+
	UB0hFGpsY4YzAKFLsQf7sXzZ0L0poh+5s6id2kacuk8LrPSeJgTOYTv04W+qiY0Yk1G4NrjZUBK
	g4ThfHuIHbAFNG4ZUOWRGjQTM6FNPBBWoWtJEvhDyDSisBeodbR6gIftHM/TqVm1o12UgMjy1mN
	II90Lhn4bflj3p5xGZr4tYliHNonlJpLmAFIXKMr0ZBtC3J96ZXoeEhKUPoY6s2ZjCWphyU9hj8
	4D6KW4Y3Fb0u7y2aDwevJoYUOBe0n8j8YR4xQqWy14Bei6WeSjhsxDEpZaMGOV7EJmKmgBM8RUK
	nrew/nvAkC4YF/srilJlK76WMsBBa7YBnQeRoxYKRDrSBEN8=
X-Google-Smtp-Source: AGHT+IGSUtSzX20U6ELEtvflPkBQHdvy1+YFJKOKUK/QuBSW1fyN5z0BVTWBPbT/JL/DNgL5AqRIig==
X-Received: by 2002:a17:903:38c5:b0:240:99e6:6bc3 with SMTP id d9443c01a7336-2446d7493a5mr131159275ad.20.1755506645977;
        Mon, 18 Aug 2025 01:44:05 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:44:05 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:43:00 +0800
Subject: [PATCH v2 7/9] nvme: apple: Add Apple A11 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-7-65648cd189e0@gmail.com>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
In-Reply-To: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13406;
 i=towinchenmi@gmail.com; h=from:subject:message-id;
 bh=o5LJJMwTtsVbnSLH+/OYa2s6s1EHDZCy8cdlkUZK1bQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouelwsb0pmI91h4tRAJZQLkQ/2RfpVE0dLR6F
 MsjwPO4ppOJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JCcOD/9THCgOxFPQg3b9sHpbsdDJJcBjPJ0/odCTfAtNr1UcwDpJWTTsuQomtLpoy20gHRMdES7
 sP1N6jV0fOBriqxZFfFUDGYobUTk3aMCDXBXZL5oKTF0GVJ5uEzVr3hXCCk/XdIOe39B19XzI4m
 JHzmMRo6N375vUSSp4anO5a8ggrOtOLl1TUOYjTPzn2EpiEIQhUGj+TaCMmsTRn89ku+A4rv72F
 mPi/rSYJIILdZUGftuVjnS0Y66mNDyr8odAws6vZpalyHdf8sJjfv0QSrixCV1DGiY2z63wOKI6
 6QFJxj4NqyAwhTHk1aY9lSLWfW2MFUrx8YiPO2+1mzExgvTWhOKW2mg9mzwxNVKPJpdgJ8PBeNy
 bzkhYh/eA/DjUNA73ZUr8rWlHNcrj+oujh7qnFFlICeXsmNBxXzAUnFCjwenSlKUBitSZZqTI4s
 IbkNRV9NSotNv4miN3Z12PNM+OH6n4Lc+CzHlv+I+PUiLD7Rs+oS7qc2tpLEHhU70+Pyv5mxuKq
 XAc8NgwYHto88xewx+e4I7OADDaNDlXKlYq7BW1hx8bKyCZ9aJLaFIHFim40lCvzGnMCbzYD6Wz
 z1DDGjSIpZkCsaET29FnN7cCtHCdXBKY/8lbtd4Gvq+B1SVGx1RgRjZ1wKaJDOmOurmlXhw/67F
 sN91YDIglzxKIyw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for ANS2 NVMe on Apple A11 SoC.

This version of ANS2 is less quirky than the one in M1, and does not have
NVMMU or Linear SQ. However, it still requires a non-standard 128-byte
SQE.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/nvme/host/apple.c | 198 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 139 insertions(+), 59 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 1286c31320e630cb012009d6b962526e0553869f..f3999b8ef7ab759fe7b6d14bfc03671c51f21e82 100644
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
 
@@ -166,11 +168,18 @@ struct apple_nvme_iod {
 	struct scatterlist *sg;
 };
 
+struct apple_nvme_hw {
+	bool has_lsq_nvmmu;
+	u32 max_queue_depth;
+	void (*submit_cmd)(struct apple_nvme_queue *q, struct nvme_command *cmd);
+};
+
 struct apple_nvme {
 	struct device *dev;
 
 	void __iomem *mmio_coproc;
 	void __iomem *mmio_nvme;
+	const struct apple_nvme_hw *hw;
 
 	struct device **pd_dev;
 	struct device_link **pd_link;
@@ -215,10 +224,12 @@ static inline struct apple_nvme *queue_to_apple_nvme(struct apple_nvme_queue *q)
 
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
@@ -280,7 +291,31 @@ static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
 				     "NVMMU TCB invalidation failed\n");
 }
 
-static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
+static void apple_nvme_submit_cmd_t8015(struct apple_nvme_queue *q,
+				  struct nvme_command *cmd)
+{
+	struct apple_nvme *anv = queue_to_apple_nvme(q);
+	u32 tag;
+
+	spin_lock_irq(&anv->lock);
+
+	tag = q->sq_tail;
+	q->sq_tail += 1;
+
+	if (q->sq_tail == anv->hw->max_queue_depth)
+		q->sq_tail = 0;
+
+	if (q->is_adminq)
+		memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
+	else
+		memcpy((void *)q->sqes + (tag << APPLE_NVME_IOSQES), cmd, sizeof(*cmd));
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
@@ -590,7 +625,8 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
 	__u16 command_id = READ_ONCE(cqe->command_id);
 	struct request *req;
 
-	apple_nvmmu_inval(q, command_id);
+	if (anv->hw->has_lsq_nvmmu)
+		apple_nvmmu_inval(q, command_id);
 
 	req = nvme_find_rq(apple_nvme_queue_tagset(anv, q), command_id);
 	if (unlikely(!req)) {
@@ -685,7 +721,7 @@ static int apple_nvme_create_cq(struct apple_nvme *anv)
 	c.create_cq.opcode = nvme_admin_create_cq;
 	c.create_cq.prp1 = cpu_to_le64(anv->ioq.cq_dma_addr);
 	c.create_cq.cqid = cpu_to_le16(1);
-	c.create_cq.qsize = cpu_to_le16(APPLE_ANS_MAX_QUEUE_DEPTH - 1);
+	c.create_cq.qsize = cpu_to_le16(anv->hw->max_queue_depth - 1);
 	c.create_cq.cq_flags = cpu_to_le16(NVME_QUEUE_PHYS_CONTIG | NVME_CQ_IRQ_ENABLED);
 	c.create_cq.irq_vector = cpu_to_le16(0);
 
@@ -713,7 +749,7 @@ static int apple_nvme_create_sq(struct apple_nvme *anv)
 	c.create_sq.opcode = nvme_admin_create_sq;
 	c.create_sq.prp1 = cpu_to_le64(anv->ioq.sq_dma_addr);
 	c.create_sq.sqid = cpu_to_le16(1);
-	c.create_sq.qsize = cpu_to_le16(APPLE_ANS_MAX_QUEUE_DEPTH - 1);
+	c.create_sq.qsize = cpu_to_le16(anv->hw->max_queue_depth - 1);
 	c.create_sq.sq_flags = cpu_to_le16(NVME_QUEUE_PHYS_CONTIG);
 	c.create_sq.cqid = cpu_to_le16(1);
 
@@ -765,7 +801,7 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	nvme_start_request(req);
-	apple_nvme_submit_cmd(q, cmnd);
+	anv->hw->submit_cmd(q, cmnd);
 	return BLK_STS_OK;
 
 out_free_cmd:
@@ -970,11 +1006,13 @@ static const struct blk_mq_ops apple_nvme_mq_ops = {
 static void apple_nvme_init_queue(struct apple_nvme_queue *q)
 {
 	unsigned int depth = apple_nvme_queue_depth(q);
+	struct apple_nvme *anv = queue_to_apple_nvme(q);
 
 	q->cq_head = 0;
 	q->cq_phase = 1;
-	memset(q->tcbs, 0,
-	       APPLE_ANS_MAX_QUEUE_DEPTH * sizeof(struct apple_nvmmu_tcb));
+	if (anv->hw->has_lsq_nvmmu)
+		memset(q->tcbs, 0,
+			anv->hw->max_queue_depth * sizeof(struct apple_nvmmu_tcb));
 	memset(q->cqes, 0, depth * sizeof(struct nvme_completion));
 	WRITE_ONCE(q->enabled, true);
 	wmb(); /* ensure the first interrupt sees the initialization */
@@ -1069,49 +1107,56 @@ static void apple_nvme_reset_work(struct work_struct *work)
 
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
+		 * Enable NVMMU and linear submission queues.
+		 * While we could keep those disabled and pretend this is slightly
+		 * more common NVMe controller we'd still need some quirks (e.g.
+		 * sq entries will be 128 bytes) and Apple might drop support for
+		 * that mode in the future.
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
+		 * This is probably a chicken bit: without it all commands where any PRP
+		 * is set to zero (including those that don't use that field) fail and
+		 * the co-processor complains about "completed with err BAD_CMD-" or
+		 * a "NULL_PRP_PTR_ERR" in the syslog
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
@@ -1282,8 +1327,9 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
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
@@ -1307,6 +1353,7 @@ static int apple_nvme_queue_alloc(struct apple_nvme *anv,
 				  struct apple_nvme_queue *q)
 {
 	unsigned int depth = apple_nvme_queue_depth(q);
+	size_t iosq_size;
 
 	q->cqes = dmam_alloc_coherent(anv->dev,
 				      depth * sizeof(struct nvme_completion),
@@ -1314,22 +1361,29 @@ static int apple_nvme_queue_alloc(struct apple_nvme *anv,
 	if (!q->cqes)
 		return -ENOMEM;
 
+	if (anv->hw->has_lsq_nvmmu)
+		iosq_size = depth * sizeof(struct nvme_command);
+	else
+		iosq_size = depth << APPLE_NVME_IOSQES;
+
 	q->sqes = dmam_alloc_coherent(anv->dev,
-				      depth * sizeof(struct nvme_command),
+				      iosq_size,
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
+		 * We need the maximum queue depth here because the NVMMU only has a
+		 * single depth configuration shared between both queues.
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
@@ -1413,6 +1467,12 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 	anv->adminq.is_adminq = true;
 	platform_set_drvdata(pdev, anv);
 
+	anv->hw = (const struct apple_nvme_hw *)of_device_get_match_data(&pdev->dev);
+	if (!anv->hw) {
+		ret = -ENODEV;
+		goto put_dev;
+	}
+
 	ret = apple_nvme_attach_genpd(anv);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Failed to attach power domains");
@@ -1444,10 +1504,17 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
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
@@ -1625,8 +1692,21 @@ static int apple_nvme_suspend(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(apple_nvme_pm_ops, apple_nvme_suspend,
 				apple_nvme_resume);
 
+static const struct apple_nvme_hw apple_nvme_t8015_hw = {
+	.has_lsq_nvmmu = false,
+	.max_queue_depth = 16,
+	.submit_cmd = &apple_nvme_submit_cmd_t8015,
+};
+
+static const struct apple_nvme_hw apple_nvme_t8103_hw = {
+	.has_lsq_nvmmu = true,
+	.max_queue_depth = 64,
+	.submit_cmd = &apple_nvme_submit_cmd_t8103,
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


