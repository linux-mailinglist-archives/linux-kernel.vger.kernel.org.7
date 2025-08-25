Return-Path: <linux-kernel+bounces-784370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE3DB33A88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41551201668
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57F11F239B;
	Mon, 25 Aug 2025 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef48rW+u"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA402D375D;
	Mon, 25 Aug 2025 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113379; cv=none; b=A/RdGNYyLOh+1XkLDoHCMg7vwyGrHYzBIl9Qeszy9UIhYohvl8Mbn3euj6+pcngUioIKW0J/p7rFXpUU47LxxNzYQfi4DReOprU+1I4GC+BZ47RVopuO2NFTt0Z41RZUbKtsINiWDZ11SGmg+ub15KTTafjD3UqqxXtfVRaz3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113379; c=relaxed/simple;
	bh=EP2maDZNX/L8/MsVIGQbi95tV8ISG4kZg5AEcjYpYJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D8dI9op8jQa6Cpdrrg5/ZGKYpaDAtCIckWm/1C5P0LRUcsBcgBaio2/JACU+Ia3knOJroMTVC4Swy/6rORAy8iL12nYTCfSvoaUAp2Mo+E7amJRMNbplBBda9Q7w8uEGsdZ3aUftr0KBbPoYPVwd1GumPfvdMIj3L6zaPOXr0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef48rW+u; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3254abaf13dso1208947a91.2;
        Mon, 25 Aug 2025 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113376; x=1756718176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RhXQ+h/W7vkWVgu90QiUh64dQ6/rniCVZCTAu1ZHrM=;
        b=ef48rW+uUZd+tUzDzTXtHwIaceM4G4WEMVsovYfMUaO5/Jf1/pzXo9RM9/bMnarKl5
         E+Xe9+ZkR+M2wBaVzQWEoWBCoERe14/cXWskz5vOoxKexFiOK8Pie55DR9kKUG6Z8uob
         ux6rSQJ+yU5Eaiv2/kq3fXG4dluuuKrWX3sqhCyFyi2Yr6Ag6C8h2d8RI/uZNJP32Arl
         9LxOhA+/oK/04bhPkDy5oWN0EBo3fcA0WMHESv0PlfQekeBOhP3ncWQyVV/tgJN42Hq6
         JnChcJotG/TpnKAo1QQpsK5pZaoRVaAW4p99uyDqePmRkyARB9z4XNO9oOMTqnfqqh9/
         Ol/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113376; x=1756718176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RhXQ+h/W7vkWVgu90QiUh64dQ6/rniCVZCTAu1ZHrM=;
        b=CN0LC64KSD6aYrUw3sMu1t+tIHVoddH+L3WlTNE2YR2dDqJt7OW3QzSLu7jR8BQTZM
         tNgBFcGnCARvkioAxNHnGawUcTq+blXiiTvIfb4Wa3GVrtZr2JvKn6ul+Pksf5asCY4u
         L6kZB2l/sJoKWRB4tCEyJLs1hIxkRMitWUk07OKnG7x0Tfd6TkiO+/qf1f3jiGKG4XMS
         Ga8cA5+SWotLaFDNX31IJGc3gQMDQB/mSj+VkH0NxtqKM7bmH70D7+AsPD0CMwrBzz9h
         45PEcPKA0HAVLVZKC+hfxNtAtwKips8BUdkhVEIg5IjUwHIEJ3eyfgAOF/PFzl8hTy7K
         04Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUBV8XaZMuylNWEKZnR0tCy6fm4CQA7449u8an2fAXObxooowNxoxSrU9myW2ybXE58w91bv/cGapD2@vger.kernel.org, AJvYcCXv9LU0m9fAQuZcVClmWYvbvQ6a93EByqUSpFxfFrJ0F+PegjRLWn5C2UXgpj71U5vrntg4zfVjuwVbqeLk@vger.kernel.org
X-Gm-Message-State: AOJu0YwUjc+PlYHrCxa5P6VX7990JKkqw0bdBWV/ngTDkr6SrbrMuqKG
	+/gVswNtpcdebc8L8+u9a0qssS9R8JZAPrWVz87Rat516gBYcj1Nq3yR
X-Gm-Gg: ASbGncvQV2YCxKV7nPkpMvpbF72+1pqsG4BrUKOJRfkyCmTcXBUi120iaFrq7XUz0GU
	sQ2kKHfQynXykWBwMYSLIKd19NEz1RZrKD+RtZmewbBCH+nt5Qk5FAVbuwm+DuJNJzo4yJcqaZ7
	PFixALPXTmVme1b9O7mk51LlH0/DARLFo7d4QLIpCpizkzLzN5Qg0OKcVCvV7Ak0PZomEq94Muv
	BR8ok7WGrQLUzvdzirxcQVeZc6HshBfHE7Nvb7Y6pZxPnq9WcrD6Xj8RsucfgRMhapS3Wph9E6j
	kEZQtuQjXzB/+P77hk2PnBo/OVbtF9eVOvdkKbmKMm8AZdE+zxfu57Dj/PxymUO430tnW/ZUgbb
	hgQFUjPi3ZcypjyPBd3clLN/Y+8c=
X-Google-Smtp-Source: AGHT+IHqcsi4pWGp71KVZidv4p+Xk8lFkI2xbej+aigVyL+o8tO99TXq53h6bKVJG475liw4k/ZBkw==
X-Received: by 2002:a17:903:46ce:b0:246:de48:1f54 with SMTP id d9443c01a7336-246de482122mr30410545ad.47.1756113376291;
        Mon, 25 Aug 2025 02:16:16 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2466887fc8dsm62873875ad.122.2025.08.25.02.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:16:15 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 25 Aug 2025 17:15:05 +0800
Subject: [PATCH v4 2/4] nvme: apple: Add Apple A11 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-t8015-nvme-v4-2-6ffc8f891b6e@gmail.com>
References: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
In-Reply-To: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13147;
 i=towinchenmi@gmail.com; h=from:subject:message-id;
 bh=EP2maDZNX/L8/MsVIGQbi95tV8ISG4kZg5AEcjYpYJ8=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBorCnRVkNFcPItWrIQaSlJP4AQwtfPwIfCEbBfL
 m+YhhzbfFWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKwp0QAKCRABygi3psUI
 JCDAD/96UbQeRz+tsoeNKSshLuakSJ9dkSMJxCe8F60UuuZlQDdYbEkLtbiQQLFnBh9pgLNbxIH
 VJy7ozCAW2wc0Aj20hC5o8eVSVdSOGpJTXUCD25LKTRBDHEoKBGqLvhKW2W21wl2U7IcmTvpnYx
 wY/RT9/1Y4TjNXYZuxg0S7+ReG2QvVZS3FBfa/Km84QUvFetRAY5vBFVDUJLBvRVxCwKGXWlybm
 9mOevezPTjwVNi4g+4bN/2hwPvtP8BkDrWIrWXDhtOCw5z9FlHzeentq47+yQGRmBtLmyAQB125
 HNCu8LWZUVmwcaEk+okUPAz42FunpidWi3Mx5tHoNaQCDMnCLTTuOra2499EYU2MS6KDrafePKp
 CGYpI72X70M3tcXCi5HG0K0BXiSGtcohVc+Q/cE341ehlhvSdkl4ZiFCaRnjHiXmYUYIQhxbvpO
 e2Sl/7NmZLvynVpgB6Chz8/OVQow6yUW+yRsseQHOux9zXO75ocE2l7qfzULIBhS+QhxFfw9olb
 LZjZIzA9Ez2TLWVMOg6sLEgAHQyJfBJf3FvbM/SUgaU/LFZKVSvnyqaXmvYrrc8cBNQ0TgVLgiF
 moiFuzXCHeFbwZuRr/um5DuLyzOG1TgfXn3BmpqbOD665TSYTvyluR6Zb2Hs5S83wAibTWMv2hy
 YnyMdcwH1zScObg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for ANS2 NVMe on Apple A11 SoC.

This version of ANS2 is less quirky than the one in M1, and does not have
NVMMU or Linear SQ. However, it still requires a non-standard 128-byte
SQE.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/nvme/host/apple.c | 197 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 137 insertions(+), 60 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 1286c31320e630cb012009d6b962526e0553869f..f35d3f71d14f32cf7ea8de00c30991fc153ff383 100644
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
@@ -1069,49 +1108,55 @@ static void apple_nvme_reset_work(struct work_struct *work)
 
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
+		writel(anv->hw->max_queue_depth
+			| (anv->hw->max_queue_depth << 16), anv->mmio_nvme
+			+ APPLE_ANS_MAX_PEND_CMDS_CTRL);
 
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
@@ -1314,22 +1361,28 @@ static int apple_nvme_queue_alloc(struct apple_nvme *anv,
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
@@ -1413,6 +1466,12 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
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
@@ -1444,10 +1503,17 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
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
@@ -1625,8 +1691,19 @@ static int apple_nvme_suspend(struct device *dev)
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
2.51.0


