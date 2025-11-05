Return-Path: <linux-kernel+bounces-886152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2320C34D08
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3567634D390
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CC02FB0A1;
	Wed,  5 Nov 2025 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="NRfXS5u9"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE32DAFBB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334766; cv=none; b=PN/DVmpmBRHCd2FQrU4tmbXJBqp5iKMocOz23/kHUNr0ucmxmRzOu709poth0V9Sg4mY6oLWUx+0E8/gusC/TfWDxRZPrhLo60DDqrhUdy25twCh/D73pT5SePYv5uXHiw6krVCy+7M6TdikRP6Lp//izsvO8LbsxVby6zIQQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334766; c=relaxed/simple;
	bh=6zglBeSuL681tEqj0/2LJbvh7bFnQ2sz2rtmh6aMfpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GakbC7nCs1hxf5bMffFJnI5g6GJyDHhO+DseIpUK4JeU2YheJtdbjKOtxoCZFzajSjGhCJm3MfDBLfTc2eHWsWZv1uRwiVlMvcrNrrOGbjwA9iVnBnIul4mr5PyzWUSnaOzjJWcf0N/i2M/GESHC3dsVJbFf7jKtRzKt98cyAmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=NRfXS5u9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782e93932ffso6185518b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1762334763; x=1762939563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0fDU+744z8AVUsyjHxWeE/9Xy3UmNKBQZws/D3TFG3o=;
        b=NRfXS5u9hiWjdyRc8yd2r2DkDRYcNNX5QMXXgJyO+ra6+eRUqD1Y/LHqP3WSzKQ2XM
         8jK7NpR0sMrAyjDEpEFffpY51P9zBqOL107e5Tyz7hO0f3N3ZNswM9ShRD+jHmZstG54
         ow/+jAffDeYlf16c8eOWGpaKUjbNfDkaRcZkYmg9fuccIwLjs8ZUD7T0+5cPe+DzI7VZ
         FEucft6RqTEyENCO6MGLDkarynryjQN1H/IBT0G0Ty7DAfrp9Z1Qnv1uqw4jbIA1xFM7
         GE1ihg1kqKBWCIyp14V1FvKc66sf3keL9Za7aQfEQ461wIcEMWNHv/K4oCaH8kRNQdlD
         n0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334763; x=1762939563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fDU+744z8AVUsyjHxWeE/9Xy3UmNKBQZws/D3TFG3o=;
        b=DoaG0xNQrTlrDxZYPGXUMbgpACyKL6MZ5z24c5wGf/EGfBiXEUPjwtNRNGV7ab5zE+
         LFK6+zp73FWkLfyhM3Lf/jecpxeqJ8CVAkiPxfFNSWGOO7kgUfRRIGIFgN/zJ3PukeiX
         /c4aOUpEoavx9yEVLXHROKksp2etrzkol8kMkB963jwYMAzNvWyvCu5qF39+N46E1VuE
         dhQyiKfYqd3/K4EGTsP2TPdF8DW1q+t66ZXHMiG90UhfI2Xpj09I/TBHPFhgpS1eCxFu
         RW+8z0F3uP3hYIKUiydac6JO/6rHRkejWqGDm/MYX7r6hTnPufLcfo9QXLwapjmR8egN
         a8uw==
X-Forwarded-Encrypted: i=1; AJvYcCVp1XjtazIA1uRKDzaXHC3UrMEo//9KfYN8H/Nn2aRQNjiIQ3dXkAPUkjVI8TIGiSMiEHRtzZQumdIVPdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcvlEsrGzAQ2H4ejtBCI/awodw15vTC5FsInfpV5Vx3N0CRpV
	DrDJdIpJUWjT4y138fWTcTW9TxHV2V5EK0eHPSodSx5DYpKbv6lfySzrJ/o1J5l/xlfV
X-Gm-Gg: ASbGncu6Sfdy6Q+WKk6OfAt7naJVABbSHLMAuWo/37Dn4m5vtKt8CNs/nZUKzd2ZqjZ
	uMn0j6OBL6poNcvdyZnqI15/0g7GJY+HwNMU/TiQRtgbdcTd9gzZDm9dvBwPzZl8lKw7l7pSIEG
	0LlB5vpkRJYjl24yzPSNQDyENg7FTNoeqNw8BKZ6rYCvskXJnWSYvLjK/Q1OiztBn1nUxJLNABq
	GAb6rFufUmd+Rj5snf+esqvJxR11WyPhLVVp1G4Ae3YKIPc9z6Q/msvU1Rx7B6EW51muTvzlDb+
	ktxqS4JAkAYrt31+uESwx1rkvWvlXN49IdKcAGItgJbz2D+DeyaZ697TRcayqoZZCgynS4nx8rf
	WfWepYO9Q14gz6Ga3DI0F58LepGC3XyNuHBAmFFbfZ7mlw/vjIdHF7uLImolcygomSN7K78qf/I
	RFzsY=
X-Google-Smtp-Source: AGHT+IGThHhboNgmcb6EWWK970iNOlAo511u0NpaH5fHRFgGRDrlywCmnFMhGroIn4Yt+pmf6905Pg==
X-Received: by 2002:a05:6a00:3c8f:b0:7a2:6caa:38b6 with SMTP id d2e1a72fcca58-7ae1f98572dmr3048728b3a.29.1762334763349;
        Wed, 05 Nov 2025 01:26:03 -0800 (PST)
Received: from sultan-box ([142.147.89.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3829626sm5578717b3a.16.2025.11.05.01.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:26:02 -0800 (PST)
Date: Wed, 5 Nov 2025 01:25:58 -0800
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Bin Du <Bin.Du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com, mario.limonciello@amd.com,
	richard.gong@amd.com, anson.tsao@amd.com
Subject: Re: [PATCH v5 0/7] Add AMD ISP4 driver
Message-ID: <aQsYJhbGifdXhjCJ@sultan-box>
References: <20251024090643.271883-1-Bin.Du@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LPfsSJd9/wEaNyHP"
Content-Disposition: inline
In-Reply-To: <20251024090643.271883-1-Bin.Du@amd.com>


--LPfsSJd9/wEaNyHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bin,

To expedite review, I've attached a patch containing a bunch of fixes I've made
on top of v5. Most of my changes should be self-explanatory; feel free to ask
further about specific changes if you have any questions.

I haven't had a chance to review all of the v4 -> v5 changes yet, but I figured
I should send what I've got so far.

FYI, there is a regression in isp4if_dequeue_buffer() where the bufq lock isn't
protecting the list_del() anymore. I also checked the compiler output when using
guard() versus scoped_guard() in that function and there is no difference:

  sha1sum:
  5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // guard()
  5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // scoped_guard()

So guard() should be used there again, which I've done in my patch.

I also have a few questions:

1. Does ISP FW provide a register interface to disable the IRQ? If so, it is
   faster to use that than using disable_irq_nosync() to disable the IRQ from
   the CPU's side.

2. When the IRQ is re-enabled in isp4sd_fw_resp_func(), is there anything
   beforehand to mask all pending interrupts from the ISP so that there isn't a
   bunch of stale interrupts firing as soon the IRQ is re-enabled?

3. Is there any risk of deadlock due to the stream kthread racing with the ISP
   when the ISP posts a new response _after_ the kthread determines there are no
   more new responses but _before_ the enable_irq() in isp4sd_fw_resp_func()?

4. Why are some lines much longer than before? It seems inconsistent that now
   there is a mix of several lines wrapped to 80 cols and many lines going
   beyond 80 cols. And there are multiple places where code is wrapped before
   reaching 80 cols even with lots of room left, specifically for cases where it
   wouldn't hurt readability to put more characters onto each line.

Sultan

--LPfsSJd9/wEaNyHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=amd-isp4-v5-fixes-round-1.patch

From 83fd6cffdc34204495044c28f384488c3a8ae08b Mon Sep 17 00:00:00 2001
From: Sultan Alsawaf <sultan@kerneltoast.com>
Date: Wed, 5 Nov 2025 00:57:55 -0800
Subject: [PATCH] amd isp4 v5 fixes round 1

---
 drivers/media/platform/amd/isp4/isp4.c        |   5 +-
 drivers/media/platform/amd/isp4/isp4_debug.c  |   6 +-
 .../media/platform/amd/isp4/isp4_interface.c  |  33 ++--
 .../media/platform/amd/isp4/isp4_interface.h  |   6 +-
 drivers/media/platform/amd/isp4/isp4_subdev.c | 168 +++++++-----------
 drivers/media/platform/amd/isp4/isp4_video.c  |  26 +--
 drivers/media/platform/amd/isp4/isp4_video.h  |  23 +--
 7 files changed, 96 insertions(+), 171 deletions(-)

diff --git a/drivers/media/platform/amd/isp4/isp4.c b/drivers/media/platform/amd/isp4/isp4.c
index 78a7a998d86e..d136da830a2f 100644
--- a/drivers/media/platform/amd/isp4/isp4.c
+++ b/drivers/media/platform/amd/isp4/isp4.c
@@ -115,9 +115,8 @@ static int isp4_capture_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, irq[i], "fail to get irq %d\n",
 					     isp4_ringbuf_interrupt_num[i]);
 
-		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
-		ret = devm_request_irq(dev, irq[i], isp4_irq_handler, 0, isp4_irq_name[i],
-				       isp_dev);
+		ret = devm_request_irq(dev, irq[i], isp4_irq_handler,
+				       IRQF_NO_AUTOEN, isp4_irq_name[i], isp_dev);
 		if (ret)
 			return dev_err_probe(dev, ret, "fail to req irq %d\n", irq[i]);
 	}
diff --git a/drivers/media/platform/amd/isp4/isp4_debug.c b/drivers/media/platform/amd/isp4/isp4_debug.c
index 746a92707e54..86f34ada78ac 100644
--- a/drivers/media/platform/amd/isp4/isp4_debug.c
+++ b/drivers/media/platform/amd/isp4/isp4_debug.c
@@ -56,11 +56,11 @@ static u32 isp_fw_fill_rb_log(struct isp4_subdev *isp, u8 *sys, u32 rb_size)
 		else if (wr_ptr < rd_ptr)
 			cnt = rb_size - rd_ptr;
 		else
-			goto unlock_and_quit;
+			goto quit;
 
 		if (cnt > rb_size) {
 			dev_err(dev, "fail bad fw log size %u\n", cnt);
-			goto unlock_and_quit;
+			goto quit;
 		}
 
 		memcpy(buf + offset, (u8 *)(sys + rd_ptr), cnt);
@@ -72,7 +72,7 @@ static u32 isp_fw_fill_rb_log(struct isp4_subdev *isp, u8 *sys, u32 rb_size)
 
 	isp4hw_wreg(ISP4_GET_ISP_REG_BASE(isp), ISP_LOG_RB_RPTR0, rd_ptr);
 
-unlock_and_quit:
+quit:
 	return total_cnt;
 }
 
diff --git a/drivers/media/platform/amd/isp4/isp4_interface.c b/drivers/media/platform/amd/isp4/isp4_interface.c
index 1852bd56a947..b92df92f8827 100644
--- a/drivers/media/platform/amd/isp4/isp4_interface.c
+++ b/drivers/media/platform/amd/isp4/isp4_interface.c
@@ -16,6 +16,8 @@
 	 ISP_SYS_INT0_EN__SYS_INT_RINGBUFFER_WPT11_EN_MASK | \
 	 ISP_SYS_INT0_EN__SYS_INT_RINGBUFFER_WPT12_EN_MASK)
 
+#define ISP4IF_FW_CMD_TIMEOUT (HZ / 2)
+
 struct isp4if_rb_config {
 	const char *name;
 	u32 index;
@@ -281,10 +283,9 @@ struct isp4if_cmd_element *isp4if_rm_cmd_from_cmdq(struct isp4_interface *ispif,
 						   u32 cmd_id)
 {
 	struct isp4if_cmd_element *buf_node;
-	struct isp4if_cmd_element *tmp_node;
 
 	scoped_guard(spinlock, &ispif->cmdq_lock)
-		list_for_each_entry_safe(buf_node, tmp_node, &ispif->cmdq, list) {
+		list_for_each_entry(buf_node, &ispif->cmdq, list) {
 			if (buf_node->seq_num == seq_num &&
 			    buf_node->cmd_id == cmd_id) {
 				list_del(&buf_node->list);
@@ -372,14 +373,14 @@ static inline enum isp4if_stream_id isp4if_get_fw_stream(u32 cmd_id)
 	return ISP4IF_STREAM_ID_1;
 }
 
-static int isp4if_send_fw_cmd(struct isp4_interface *ispif, u32 cmd_id, void *package,
+static int isp4if_send_fw_cmd(struct isp4_interface *ispif, u32 cmd_id, const void *package,
 			      u32 package_size, struct completion *cmd_complete, u32 *seq)
 {
 	enum isp4if_stream_id stream = isp4if_get_fw_stream(cmd_id);
 	struct isp4if_cmd_element *cmd_ele = NULL;
 	struct isp4if_rb_config *rb_config;
 	struct device *dev = ispif->dev;
-	struct isp4fw_cmd cmd = {};
+	struct isp4fw_cmd cmd;
 	u32 seq_num;
 	u32 rreg;
 	u32 wreg;
@@ -393,7 +394,7 @@ static int isp4if_send_fw_cmd(struct isp4_interface *ispif, u32 cmd_id, void *pa
 
 	/*
 	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
-	 * zeroed, since this may not guarantee on all compilers.
+	 * zeroed, since this is not guaranteed on all compilers.
 	 */
 	memset(&cmd, 0, sizeof(cmd));
 	rb_config = &isp4if_resp_rb_config[stream];
@@ -477,7 +478,7 @@ static int isp4if_send_buffer(struct isp4_interface *ispif, struct isp4if_img_bu
 
 	/*
 	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
-	 * zeroed, since this may not guarantee on all compilers.
+	 * zeroed, since this is not guaranteed on all compilers.
 	 */
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.buffer_type = BUFFER_TYPE_PREVIEW;
@@ -778,13 +779,13 @@ int isp4if_f2h_resp(struct isp4_interface *ispif, enum isp4if_stream_id stream,
 	return 0;
 }
 
-int isp4if_send_command(struct isp4_interface *ispif, u32 cmd_id, void *package, u32 package_size)
+int isp4if_send_command(struct isp4_interface *ispif, u32 cmd_id, const void *package, u32 package_size)
 {
 	return isp4if_send_fw_cmd(ispif, cmd_id, package, package_size, NULL, NULL);
 }
 
-int isp4if_send_command_sync(struct isp4_interface *ispif, u32 cmd_id, void *package,
-			     u32 package_size, u32 timeout)
+int isp4if_send_command_sync(struct isp4_interface *ispif, u32 cmd_id, const void *package,
+			     u32 package_size)
 {
 	DECLARE_COMPLETION_ONSTACK(cmd_completion);
 	struct device *dev = ispif->dev;
@@ -798,12 +799,9 @@ int isp4if_send_command_sync(struct isp4_interface *ispif, u32 cmd_id, void *pac
 		return ret;
 	}
 
-	ret = wait_for_completion_timeout(&cmd_completion, msecs_to_jiffies(timeout));
-	if (ret == 0) {
-		struct isp4if_cmd_element *ele;
-
-		ele = isp4if_rm_cmd_from_cmdq(ispif, seq, cmd_id);
-		kfree(ele);
+	ret = wait_for_completion_timeout(&cmd_completion, ISP4IF_FW_CMD_TIMEOUT);
+	if (!ret) {
+		kfree(isp4if_rm_cmd_from_cmdq(ispif, seq, cmd_id));
 		return -ETIMEDOUT;
 	}
 
@@ -842,8 +840,9 @@ struct isp4if_img_buf_node *isp4if_dequeue_buffer(struct isp4_interface *ispif)
 {
 	struct isp4if_img_buf_node *buf_node;
 
-	scoped_guard(spinlock, &ispif->bufq_lock)
-		buf_node = list_first_entry_or_null(&ispif->bufq, typeof(*buf_node), node);
+	guard(spinlock)(&ispif->bufq_lock);
+
+	buf_node = list_first_entry_or_null(&ispif->bufq, typeof(*buf_node), node);
 	if (buf_node)
 		list_del(&buf_node->node);
 
diff --git a/drivers/media/platform/amd/isp4/isp4_interface.h b/drivers/media/platform/amd/isp4/isp4_interface.h
index 688a4ea84dc6..1f589c31dc43 100644
--- a/drivers/media/platform/amd/isp4/isp4_interface.h
+++ b/drivers/media/platform/amd/isp4/isp4_interface.h
@@ -115,11 +115,11 @@ static inline u64 isp4if_join_addr64(u32 lo, u32 hi)
 
 int isp4if_f2h_resp(struct isp4_interface *ispif, enum isp4if_stream_id stream, void *response);
 
-int isp4if_send_command(struct isp4_interface *ispif, u32 cmd_id, void *package,
+int isp4if_send_command(struct isp4_interface *ispif, u32 cmd_id, const void *package,
 			u32 package_size);
 
-int isp4if_send_command_sync(struct isp4_interface *ispif, u32 cmd_id, void *package,
-			     u32 package_size, u32 timeout);
+int isp4if_send_command_sync(struct isp4_interface *ispif, u32 cmd_id, const void *package,
+			     u32 package_size);
 
 struct isp4if_cmd_element *isp4if_rm_cmd_from_cmdq(struct isp4_interface *ispif, u32 seq_num,
 						   u32 cmd_id);
diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/media/platform/amd/isp4/isp4_subdev.c
index 17480ae5150d..0e9e6ec59ed8 100644
--- a/drivers/media/platform/amd/isp4/isp4_subdev.c
+++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
@@ -17,8 +17,6 @@
 #define ISP4SD_PERFORMANCE_STATE_LOW 0
 #define ISP4SD_PERFORMANCE_STATE_HIGH 1
 
-#define ISP4SD_FW_CMD_TIMEOUT_IN_MS  500
-
 /* align 32KB */
 #define ISP4SD_META_BUF_SIZE ALIGN(sizeof(struct isp4fw_meta_info), 0x8000)
 
@@ -55,7 +53,7 @@ static int isp4sd_setup_fw_mem_pool(struct isp4_subdev *isp_subdev)
 
 	/*
 	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
-	 * zeroed, since this may not guarantee on all compilers.
+	 * zeroed, since this is not guaranteed on all compilers.
 	 */
 	memset(&buf_type, 0, sizeof(buf_type));
 	buf_type.buffer_type = BUFFER_TYPE_MEM_POOL;
@@ -92,7 +90,7 @@ static int isp4sd_set_stream_path(struct isp4_subdev *isp_subdev)
 
 	/*
 	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
-	 * zeroed, since this may not guarantee on all compilers.
+	 * zeroed, since this is not guaranteed on all compilers.
 	 */
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.stream_cfg.mipi_pipe_path_cfg.isp4fw_sensor_id = SENSOR_ID_ON_MIPI0;
@@ -113,16 +111,14 @@ static int isp4sd_send_meta_buf(struct isp4_subdev *isp_subdev)
 {
 	struct isp4_interface *ispif = &isp_subdev->ispif;
 	struct isp4fw_cmd_send_buffer buf_type;
-	struct isp4sd_sensor_info *sensor_info;
 	struct device *dev = isp_subdev->dev;
-	u32 i;
+	int i;
 
 	/*
 	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
-	 * zeroed, since this may not guarantee on all compilers.
+	 * zeroed, since this is not guaranteed on all compilers.
 	 */
 	memset(&buf_type, 0, sizeof(buf_type));
-	sensor_info = &isp_subdev->sensor_info;
 	for (i = 0; i < ISP4IF_MAX_STREAM_BUF_COUNT; i++) {
 		int ret;
 
@@ -140,8 +136,7 @@ static int isp4sd_send_meta_buf(struct isp4_subdev *isp_subdev)
 		buf_type.buffer.buf_size_a =
 			(u32)isp_subdev->ispif.meta_info_buf[i]->mem_size;
 		ret = isp4if_send_command(ispif, CMD_ID_SEND_BUFFER,
-					  &buf_type,
-					  sizeof(buf_type));
+					  &buf_type, sizeof(buf_type));
 		if (ret) {
 			dev_err(dev, "send meta info(%u) fail\n", i);
 			return ret;
@@ -158,7 +153,6 @@ static bool isp4sd_get_str_out_prop(struct isp4_subdev *isp_subdev,
 {
 	struct device *dev = isp_subdev->dev;
 	struct v4l2_mbus_framefmt *format;
-	bool ret;
 
 	format = v4l2_subdev_state_get_format(state, pad, 0);
 	if (!format) {
@@ -173,7 +167,6 @@ static bool isp4sd_get_str_out_prop(struct isp4_subdev *isp_subdev,
 		out_prop->height = format->height;
 		out_prop->luma_pitch = format->width;
 		out_prop->chroma_pitch = out_prop->width;
-		ret = true;
 		break;
 	case MEDIA_BUS_FMT_YUYV8_1X16:
 		out_prop->image_format = IMAGE_FORMAT_YUV422INTERLEAVED;
@@ -181,18 +174,17 @@ static bool isp4sd_get_str_out_prop(struct isp4_subdev *isp_subdev,
 		out_prop->height = format->height;
 		out_prop->luma_pitch = format->width * 2;
 		out_prop->chroma_pitch = 0;
-		ret = true;
 		break;
 	default:
 		dev_err(dev, "fail for bad image format:0x%x\n",
 			format->code);
-		ret = false;
-		break;
+		return false;
 	}
 
 	if (!out_prop->width || !out_prop->height)
-		ret = false;
-	return ret;
+		return false;
+
+	return true;
 }
 
 static int isp4sd_kickoff_stream(struct isp4_subdev *isp_subdev, u32 w, u32 h)
@@ -249,7 +241,6 @@ static int isp4sd_setup_output(struct isp4_subdev *isp_subdev,
 	struct isp4fw_cmd_set_out_ch_prop cmd_ch_prop;
 	struct isp4fw_cmd_enable_out_ch cmd_ch_en;
 	struct device *dev = isp_subdev->dev;
-	struct isp4fw_image_prop *out_prop;
 	int ret;
 
 	if (output_info->start_status == ISP4SD_START_STATUS_STARTED)
@@ -262,20 +253,12 @@ static int isp4sd_setup_output(struct isp4_subdev *isp_subdev,
 
 	/*
 	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
-	 * zeroed, since this may not guarantee on all compilers.
+	 * zeroed, since this is not guaranteed on all compilers.
 	 */
 	memset(&cmd_ch_prop, 0, sizeof(cmd_ch_prop));
-	/*
-	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
-	 * zeroed, since this may not guarantee on all compilers.
-	 */
-	memset(&cmd_ch_en, 0, sizeof(cmd_ch_en));
-	out_prop = &cmd_ch_prop.image_prop;
 	cmd_ch_prop.ch = ISP_PIPE_OUT_CH_PREVIEW;
-	cmd_ch_en.ch = ISP_PIPE_OUT_CH_PREVIEW;
-	cmd_ch_en.is_enable = true;
 
-	if (!isp4sd_get_str_out_prop(isp_subdev, out_prop, state, pad)) {
+	if (!isp4sd_get_str_out_prop(isp_subdev, &cmd_ch_prop.image_prop, state, pad)) {
 		dev_err(dev, "fail to get out prop\n");
 		return -EINVAL;
 	}
@@ -288,17 +271,23 @@ static int isp4sd_setup_output(struct isp4_subdev *isp_subdev,
 		cmd_ch_prop.image_prop.chroma_pitch);
 
 	ret = isp4if_send_command(ispif, CMD_ID_SET_OUT_CHAN_PROP,
-				  &cmd_ch_prop,
-				  sizeof(cmd_ch_prop));
+				  &cmd_ch_prop, sizeof(cmd_ch_prop));
 	if (ret) {
 		output_info->start_status = ISP4SD_START_STATUS_START_FAIL;
 		dev_err(dev, "fail to set out prop\n");
 		return ret;
-	};
+	}
+
+	/*
+	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
+	 * zeroed, since this is not guaranteed on all compilers.
+	 */
+	memset(&cmd_ch_en, 0, sizeof(cmd_ch_en));
+	cmd_ch_en.ch = ISP_PIPE_OUT_CH_PREVIEW;
+	cmd_ch_en.is_enable = true;
 
 	ret = isp4if_send_command(ispif, CMD_ID_ENABLE_OUT_CHAN,
 				  &cmd_ch_en, sizeof(cmd_ch_en));
-
 	if (ret) {
 		output_info->start_status = ISP4SD_START_STATUS_START_FAIL;
 		dev_err(dev, "fail to enable channel\n");
@@ -309,8 +298,9 @@ static int isp4sd_setup_output(struct isp4_subdev *isp_subdev,
 		isp4dbg_get_out_ch_str(cmd_ch_en.ch));
 
 	if (!sensor_info->start_stream_cmd_sent) {
-		ret = isp4sd_kickoff_stream(isp_subdev, out_prop->width,
-					    out_prop->height);
+		ret = isp4sd_kickoff_stream(isp_subdev,
+					    cmd_ch_prop.image_prop.width,
+					    cmd_ch_prop.image_prop.height);
 		if (ret) {
 			dev_err(dev, "kickoff stream fail %d\n", ret);
 			return ret;
@@ -463,36 +453,6 @@ static struct isp4fw_meta_info *isp4sd_get_meta_by_mc(struct isp4_subdev *isp_su
 	return NULL;
 }
 
-static struct isp4if_img_buf_node *
-isp4sd_preview_done(struct isp4_subdev *isp_subdev,
-		    struct isp4fw_meta_info *meta,
-		    struct isp4vid_framedone_param *pcb)
-{
-	struct isp4_interface *ispif = &isp_subdev->ispif;
-	struct isp4if_img_buf_node *prev = NULL;
-	struct device *dev = isp_subdev->dev;
-
-	pcb->preview.status = ISP4VID_BUF_DONE_STATUS_ABSENT;
-	if (meta->preview.enabled &&
-	    (meta->preview.status == BUFFER_STATUS_SKIPPED ||
-	     meta->preview.status == BUFFER_STATUS_DONE ||
-	     meta->preview.status == BUFFER_STATUS_DIRTY)) {
-		prev = isp4if_dequeue_buffer(ispif);
-		if (!prev) {
-			dev_err(dev, "fail null prev buf\n");
-		} else {
-			pcb->preview.buf = prev->buf_info;
-			pcb->preview.status = ISP4VID_BUF_DONE_STATUS_SUCCESS;
-		}
-	} else if (meta->preview.enabled) {
-		dev_err(dev, "fail bad preview status %u(%s)\n",
-			meta->preview.status,
-			isp4dbg_get_buf_done_str(meta->preview.status));
-	}
-
-	return prev;
-}
-
 static void isp4sd_send_meta_info(struct isp4_subdev *isp_subdev,
 				  u64 meta_info_mc)
 {
@@ -508,38 +468,35 @@ static void isp4sd_send_meta_info(struct isp4_subdev *isp_subdev,
 
 	/*
 	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
-	 * zeroed, since this may not guarantee on all compilers.
+	 * zeroed, since this is not guaranteed on all compilers.
 	 */
 	memset(&buf_type, 0, sizeof(buf_type));
-	if (meta_info_mc) {
-		buf_type.buffer_type = BUFFER_TYPE_META_INFO;
-		buf_type.buffer.buf_tags = 0;
-		buf_type.buffer.vmid_space.bit.vmid = 0;
-		buf_type.buffer.vmid_space.bit.space = ADDR_SPACE_TYPE_GPU_VA;
-		isp4if_split_addr64(meta_info_mc,
-				    &buf_type.buffer.buf_base_a_lo,
-				    &buf_type.buffer.buf_base_a_hi);
+	buf_type.buffer_type = BUFFER_TYPE_META_INFO;
+	buf_type.buffer.buf_tags = 0;
+	buf_type.buffer.vmid_space.bit.vmid = 0;
+	buf_type.buffer.vmid_space.bit.space = ADDR_SPACE_TYPE_GPU_VA;
+	isp4if_split_addr64(meta_info_mc,
+			    &buf_type.buffer.buf_base_a_lo,
+			    &buf_type.buffer.buf_base_a_hi);
+	buf_type.buffer.buf_size_a = ISP4SD_META_BUF_SIZE;
 
-		buf_type.buffer.buf_size_a = ISP4SD_META_BUF_SIZE;
-		if (isp4if_send_command(ispif, CMD_ID_SEND_BUFFER,
-					&buf_type, sizeof(buf_type))) {
-			dev_err(dev, "fail send meta_info 0x%llx\n",
-				meta_info_mc);
-		} else {
-			dev_dbg(dev, "resend meta_info 0x%llx\n", meta_info_mc);
-		}
-	}
+	if (isp4if_send_command(ispif, CMD_ID_SEND_BUFFER,
+				&buf_type, sizeof(buf_type)))
+		dev_err(dev, "fail send meta_info 0x%llx\n",
+			meta_info_mc);
+	else
+		dev_dbg(dev, "resend meta_info 0x%llx\n", meta_info_mc);
 }
 
 static void isp4sd_fw_resp_frame_done(struct isp4_subdev *isp_subdev,
 				      enum isp4if_stream_id stream_id,
 				      struct isp4fw_resp_param_package *para)
 {
-	struct isp4vid_framedone_param pcb = {};
+	struct isp4_interface *ispif = &isp_subdev->ispif;
 	struct device *dev = isp_subdev->dev;
 	struct isp4if_img_buf_node *prev;
 	struct isp4fw_meta_info *meta;
-	u64 mc = 0;
+	u64 mc;
 
 	mc = isp4if_join_addr64(para->package_addr_lo, para->package_addr_hi);
 	meta = isp4sd_get_meta_by_mc(isp_subdev, mc);
@@ -548,24 +505,32 @@ static void isp4sd_fw_resp_frame_done(struct isp4_subdev *isp_subdev,
 		return;
 	}
 
-	pcb.poc = meta->poc;
-	pcb.cam_id = 0;
-
 	dev_dbg(dev, "ts:%llu,streamId:%d,poc:%u,preview_en:%u,%s(%i)\n",
 		ktime_get_ns(), stream_id, meta->poc,
 		meta->preview.enabled,
 		isp4dbg_get_buf_done_str(meta->preview.status),
 		meta->preview.status);
 
-	prev = isp4sd_preview_done(isp_subdev, meta, &pcb);
-	if (pcb.preview.status != ISP4VID_BUF_DONE_STATUS_ABSENT) {
-		isp4dbg_show_bufmeta_info(dev, "prev", &meta->preview,
-					  &pcb.preview.buf);
-		isp4vid_notify(&isp_subdev->isp_vdev, &pcb);
+	if (meta->preview.enabled &&
+	    (meta->preview.status == BUFFER_STATUS_SKIPPED ||
+	     meta->preview.status == BUFFER_STATUS_DONE ||
+	     meta->preview.status == BUFFER_STATUS_DIRTY)) {
+		prev = isp4if_dequeue_buffer(ispif);
+		if (prev) {
+			isp4dbg_show_bufmeta_info(dev, "prev", &meta->preview,
+						  &prev->buf_info);
+			isp4vid_handle_frame_done(&isp_subdev->isp_vdev,
+						  &prev->buf_info);
+			isp4if_dealloc_buffer_node(prev);
+		} else {
+			dev_err(dev, "fail null prev buf\n");
+		}
+	} else if (meta->preview.enabled) {
+		dev_err(dev, "fail bad preview status %u(%s)\n",
+			meta->preview.status,
+			isp4dbg_get_buf_done_str(meta->preview.status));
 	}
 
-	isp4if_dealloc_buffer_node(prev);
-
 	if (isp_subdev->sensor_info.status == ISP4SD_START_STATUS_STARTED)
 		isp4sd_send_meta_info(isp_subdev, mc);
 
@@ -834,22 +799,23 @@ static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
 	if (output_info->start_status == ISP4SD_START_STATUS_STARTED) {
 		struct isp4fw_cmd_enable_out_ch cmd_ch_disable;
 
+		/*
+		 * The struct will be shared with ISP FW, use memset() to guarantee
+		 * padding bits are zeroed, since this is not guaranteed on all compilers.
+		 */
+		memset(&cmd_ch_disable, 0, sizeof(cmd_ch_disable));
 		cmd_ch_disable.ch = ISP_PIPE_OUT_CH_PREVIEW;
 		cmd_ch_disable.is_enable = false;
-		ret = isp4if_send_command_sync(ispif,
-					       CMD_ID_ENABLE_OUT_CHAN,
+		ret = isp4if_send_command_sync(ispif, CMD_ID_ENABLE_OUT_CHAN,
 					       &cmd_ch_disable,
-					       sizeof(cmd_ch_disable),
-					       ISP4SD_FW_CMD_TIMEOUT_IN_MS);
+					       sizeof(cmd_ch_disable));
 		if (ret)
 			dev_err(dev, "fail to disable stream\n");
 		else
 			dev_dbg(dev, "wait disable stream suc\n");
 
 		ret = isp4if_send_command_sync(ispif, CMD_ID_STOP_STREAM,
-					       NULL,
-					       0,
-					       ISP4SD_FW_CMD_TIMEOUT_IN_MS);
+					       NULL, 0);
 		if (ret)
 			dev_err(dev, "fail to stop steam\n");
 		else
diff --git a/drivers/media/platform/amd/isp4/isp4_video.c b/drivers/media/platform/amd/isp4/isp4_video.c
index 456435f6e771..ca876cb72154 100644
--- a/drivers/media/platform/amd/isp4/isp4_video.c
+++ b/drivers/media/platform/amd/isp4/isp4_video.c
@@ -60,12 +60,10 @@ static const struct v4l2_fract isp4vid_tpfs[] = {
 	{ 1, ISP4VID_MAX_PREVIEW_FPS }
 };
 
-static void isp4vid_handle_frame_done(struct isp4vid_dev *isp_vdev,
-				      const struct isp4if_img_buf_info *img_buf,
-				      bool done_suc)
+void isp4vid_handle_frame_done(struct isp4vid_dev *isp_vdev,
+			       const struct isp4if_img_buf_info *img_buf)
 {
 	struct isp4vid_capture_buffer *isp4vid_buf;
-	enum vb2_buffer_state state;
 	void *vbuf;
 
 	scoped_guard(mutex, &isp_vdev->buf_list_lock) {
@@ -95,30 +93,12 @@ static void isp4vid_handle_frame_done(struct isp4vid_dev *isp_vdev,
 	vb2_set_plane_payload(&isp4vid_buf->vb2.vb2_buf,
 			      0, isp_vdev->format.sizeimage);
 
-	state = done_suc ? VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
-	vb2_buffer_done(&isp4vid_buf->vb2.vb2_buf, state);
+	vb2_buffer_done(&isp4vid_buf->vb2.vb2_buf, VB2_BUF_STATE_DONE);
 
 	dev_dbg(isp_vdev->dev, "call vb2_buffer_done(size=%u)\n",
 		isp_vdev->format.sizeimage);
 }
 
-s32 isp4vid_notify(void *cb_ctx, struct isp4vid_framedone_param *evt_param)
-{
-	struct isp4vid_dev *isp4vid_vdev = cb_ctx;
-
-	if (evt_param->preview.status != ISP4VID_BUF_DONE_STATUS_ABSENT) {
-		bool suc;
-
-		suc = (evt_param->preview.status ==
-		       ISP4VID_BUF_DONE_STATUS_SUCCESS);
-		isp4vid_handle_frame_done(isp4vid_vdev,
-					  &evt_param->preview.buf,
-					  suc);
-	}
-
-	return 0;
-}
-
 static unsigned int isp4vid_vb2_num_users(void *buf_priv)
 {
 	struct isp4vid_vb2_buf *buf = buf_priv;
diff --git a/drivers/media/platform/amd/isp4/isp4_video.h b/drivers/media/platform/amd/isp4/isp4_video.h
index d925f67567e7..b87316d2a2e5 100644
--- a/drivers/media/platform/amd/isp4/isp4_video.h
+++ b/drivers/media/platform/amd/isp4/isp4_video.h
@@ -11,26 +11,6 @@
 
 #include "isp4_interface.h"
 
-enum isp4vid_buf_done_status {
-	/* It means no corresponding image buf in fw response */
-	ISP4VID_BUF_DONE_STATUS_ABSENT,
-	ISP4VID_BUF_DONE_STATUS_SUCCESS,
-	ISP4VID_BUF_DONE_STATUS_FAILED
-};
-
-struct isp4vid_buf_done_info {
-	enum isp4vid_buf_done_status status;
-	struct isp4if_img_buf_info buf;
-};
-
-/* call back parameter for CB_EVT_ID_FRAME_DONE */
-struct isp4vid_framedone_param {
-	s32 poc;
-	s32 cam_id;
-	s64 time_stamp;
-	struct isp4vid_buf_done_info preview;
-};
-
 struct isp4vid_capture_buffer {
 	/*
 	 * struct vb2_v4l2_buffer must be the first element
@@ -79,6 +59,7 @@ int isp4vid_dev_init(struct isp4vid_dev *isp_vdev,
 
 void isp4vid_dev_deinit(struct isp4vid_dev *isp_vdev);
 
-s32 isp4vid_notify(void *cb_ctx, struct isp4vid_framedone_param *evt_param);
+void isp4vid_handle_frame_done(struct isp4vid_dev *isp_vdev,
+			       const struct isp4if_img_buf_info *img_buf);
 
 #endif /* _ISP4_VIDEO_H_ */
-- 
2.51.2


--LPfsSJd9/wEaNyHP--

