Return-Path: <linux-kernel+bounces-892581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FA6C4562B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6625C3B2764
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F13E2F7AD5;
	Mon, 10 Nov 2025 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="mckvut2U"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF07E1DF723
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763625; cv=none; b=l/hHNC3MLgA1BvmdLNn5FQwW+BAQKB3Q+4qu8BaDhmheah1NjwAsy2Py4OE5JBh1pJFP82tqJo45E1QxrxB5BR4efo0tvXiiTLSOeWtP/yDMHSH6zdA/NByJ6xxxO3O3bmL4ojVXjuNafvshspZzbzARVw1KD3MvOWtKe883XzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763625; c=relaxed/simple;
	bh=uBx3TTx8SiBf0Skz//BkoPNkXs72K72Nlwad1aJq0mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmqNJUev7Ri6ZMPRSwzABf9HuK2NzAiZ/MDXjROrKtGg8tW9eu8o7cgaPYpPUx8lmsITTOygzlkZyVCWgDMQw9cy3xFKxyieFfEKr6aLzBk/4ibF2rSVYmOp2FQozj+k1QDetk0MXsqFWLCnb8QPN1fYW8W05qgZY+4Jar4Orw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=mckvut2U; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b0246b27b2so2865173b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1762763620; x=1763368420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9W3FiH61PXB01Py0YT0DyF3yVtibwGHGN6X4HmrHdZM=;
        b=mckvut2UvyRGEXaPriVHQXB9e9/6/cPqh0Q5wUauycKVoTskeawAUkY/oKWg1ul22X
         lBRZd+htBz5OpAb9lU64MpSS+pshIM/biqTVQ3V8rSSUAPdwQAKrSPW9ZPWo10QrcakF
         HOCKDayeHa3xyhgcRpVhQddMzTh7M+b77vfxJsNAIrA01c+zhTWxGdDm6eZ01qP66msu
         AvvPm/Dud/loej7xG3ZIH2TcbaDrItw33ixuQvMYudSDlTq4Yw04VIr5DWzic7KZgSmX
         sneBdYHU3Z666VQX/ezHspTOSrWjPuD0s1MAxdqV6zE8NMjvS8ghP4pBb9rcKzWoJj6+
         Wm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762763620; x=1763368420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9W3FiH61PXB01Py0YT0DyF3yVtibwGHGN6X4HmrHdZM=;
        b=mLp6nVzJiUF1ipEHAyUOKPfct0aRbrg+Za+spJNCBTPA08fnbbBI0NDJFr9DwPrhl0
         E5N4pVyGY7YFJPWytzIgZaO+nPtNvjb8b5vvTWJan6VOUVjta3RBgU/TYxriviFdhDg1
         pJgF3k98cs6Emp9SWxfUnvlSVNoh5cZYgyuZ+UuiDKV2uUG84MkNi7QaII94sDGmJx+q
         5v8a09O/ebZSJB4PjUr1I88T4X6fczk0jo5dDUFCr4vWvT4C4e+0mGWYOPe+B5AfqM/X
         8GRB7LdKz1BsS3id1fmOO41cKhhKELSwr2CDfnZWv7sLhzKwbhZVskiasOcgSoPtUxNm
         lgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+JUx45/cc30UZPigUABmLFtlVfSJaPa+zHZIvqjIRT3mCb/in2eW3Bs3W04D525GiKtr/bpptu46onZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkNFEUELgY8Vu8VHgMKePgB/Pkxs+EUzkwgthd4PQi9WgNy/Y
	YJX7Pu8BLTlhbVSMp/qInP3g7KEP/9KrKYTcmsuqtjQIGgeD7lMLvrzzkGGELFi6N6hL
X-Gm-Gg: ASbGncsRW8MwKUYMbohg4uUKSBtVn+QXBFJnwogjLkw5UmL/k2+2rebexnW5P7FMjUp
	9thxiPnceCrbw+STz8zXKW1ae9kmIXlXNvYXg0f3Wn4EbRcW1uTeELQh5ZXrWW5av1ZE7oZjmUs
	s49KoyMu1exHxb8JUyyvu/Hc5Ek1s2XoIPM9ScLIJo2vuk3kIGA3Ynb3Dzs8WOW2cKjGsgxFc9W
	auxBPKUeapq6N8XCkVgooj1iDQoBhkH8qqBLOiEs9mquU11txe3JDx3Q0Z5rZ8A5cAFPPBlNA1X
	HMulbycPnikrcmNpz8hOIBqVyBvWcGHevgXAEFnRprn7/wet2L2XUqKDsiPLfmU3WVT1qkIfCAF
	/pqrsij/tvVOEiItiOCPdZs5UkAb1ufmTDiMdKK8Sg0m+YMrWhxuI5DFZ+lsp9FwEwszc6Jn8w0
	RIjET8RDEAyfavhg==
X-Google-Smtp-Source: AGHT+IH20G8/vOi25tL6yEQJ0PIkmJwVb77kQ8AjlIy+H6VwJNucancO3/ooq3CWSr8k/LVVHchYPQ==
X-Received: by 2002:a05:6a00:23c1:b0:781:1b5a:95b2 with SMTP id d2e1a72fcca58-7b22717bb94mr11073296b3a.28.1762763619980;
        Mon, 10 Nov 2025 00:33:39 -0800 (PST)
Received: from sultan-box ([142.147.89.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc175d85sm11217510b3a.43.2025.11.10.00.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 00:33:39 -0800 (PST)
Date: Mon, 10 Nov 2025 00:33:35 -0800
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
Message-ID: <aRGjX1pv0y_lVext@sultan-box>
References: <20251024090643.271883-1-Bin.Du@amd.com>
 <aQsYJhbGifdXhjCJ@sultan-box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rnS6dzQWgB30Ue73"
Content-Disposition: inline
In-Reply-To: <aQsYJhbGifdXhjCJ@sultan-box>


--rnS6dzQWgB30Ue73
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bin,

On Wed, Nov 05, 2025 at 01:25:58AM -0800, Sultan Alsawaf wrote:
> Hi Bin,
> 
> To expedite review, I've attached a patch containing a bunch of fixes I've made
> on top of v5. Most of my changes should be self-explanatory; feel free to ask
> further about specific changes if you have any questions.
> 
> I haven't had a chance to review all of the v4 -> v5 changes yet, but I figured
> I should send what I've got so far.
> 
> FYI, there is a regression in isp4if_dequeue_buffer() where the bufq lock isn't
> protecting the list_del() anymore. I also checked the compiler output when using
> guard() versus scoped_guard() in that function and there is no difference:
> 
>   sha1sum:
>   5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // guard()
>   5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // scoped_guard()
> 
> So guard() should be used there again, which I've done in my patch.
> 
> I also have a few questions:
> 
> 1. Does ISP FW provide a register interface to disable the IRQ? If so, it is
>    faster to use that than using disable_irq_nosync() to disable the IRQ from
>    the CPU's side.
> 
> 2. When the IRQ is re-enabled in isp4sd_fw_resp_func(), is there anything
>    beforehand to mask all pending interrupts from the ISP so that there isn't a
>    bunch of stale interrupts firing as soon the IRQ is re-enabled?
> 
> 3. Is there any risk of deadlock due to the stream kthread racing with the ISP
>    when the ISP posts a new response _after_ the kthread determines there are no
>    more new responses but _before_ the enable_irq() in isp4sd_fw_resp_func()?
> 
> 4. Why are some lines much longer than before? It seems inconsistent that now
>    there is a mix of several lines wrapped to 80 cols and many lines going
>    beyond 80 cols. And there are multiple places where code is wrapped before
>    reaching 80 cols even with lots of room left, specifically for cases where it
>    wouldn't hurt readability to put more characters onto each line.

I've attached a new, complete patch of changes to apply on top of v5. You may
ignore the incomplete patch from my previous email and use the new one instead.

I made many changes and also answered questions 1-3 myself.

Please apply this on top of v5 and let me know if you have any questions.

BTW, I noticed a strange regression in v5 even without any of my changes: every
time you use cheese after using it one time, the video will freeze after 30-60
seconds with this message printed to dmesg:
  [ 2032.716559] amd_isp_capture amd_isp_capture: -><- fail respid unknown respid(0x30002)

And the video never unfreezes. I haven't found the cause for the regression yet;
can you try to reproduce it?

Thanks,
Sultan

--rnS6dzQWgB30Ue73
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename*0=media-platform-amd-Big-squash-of-fixes-cleanup-on-top-of-v5-pat;
	filename*1=chset.patch

From 482166e2ac974e4e27f190237accba397bb99652 Mon Sep 17 00:00:00 2001
From: Sultan Alsawaf <sultan@kerneltoast.com>
Date: Mon, 10 Nov 2025 00:22:51 -0800
Subject: [PATCH] media: platform: amd: Big squash of fixes/cleanup on top of
 v5 patchset

-Rewrote IRQ handling to disable/enable interrupts using ISP register since
 it is faster
-Rewrote ringbuffer handling in isp4if_f2h_resp(), fixing the safety checks
 to check the read pointer before doing memcpy possibly out-of-bounds on
 the ringbuffer. Also simplified the ringbuffer logic a lot.
-Fixed a regression in v4 -> v5 where isp4if_dequeue_buffer() didn't
 protect the list_del with bufq_lock
-Fixed a subtle use-after-free possibility when the timeout is hit on a
 sync command at the same time the command finishes, existed since v1
-Added missing pm_runtime_disable() to isp4_capture_remove() and to
 isp4_capture_probe() error path
-Cleaned up all remaining stray semicolons after curly close braces
-Added missing memset for FW command struct in isp4sd_stop_stream()
-Removed streams 2 and 3 from ISP4IF_FW_RESP_RB_IRQ_EN_MASK so they don't
 get enabled in the interrupt enable register
-Added error handling to cleanup kthreads when there is a failure in
 starting a kthread
-Fixed a race on kthread creation where it is possible the waitqueue head
 isn't initialized by the time it is used in the IRQ handler, because the
 kthread was responsible for initializing the waitqueue head
-Removed an always false status check in isp4sd_pwroff_and_deinit()
-Fixed isp4sd_init_stream() getting called in isp4sd_start_stream() even
 after a stream is started, and reordered all of those status checks to
 come before isp4sd_init_stream()
-Fixed error handling in isp4sd_start_stream() to return the received
 error from a function that failed
-Moved dbg message in isp4sd_stop_stream() to go under the lock because it
 reads output_info->start_status
-Removed the GET_*_REG_BASE() macros, unnecessary and redundant
-Fixed incorrect err message in isp4sd_init_stream() due to copy/paste
 error
-Lots of dead code cleanup and small code style cleanups throughout

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 drivers/media/platform/amd/isp4/isp4.c        | 155 ++++---
 drivers/media/platform/amd/isp4/isp4.h        |   2 +
 drivers/media/platform/amd/isp4/isp4_debug.c  |  18 +-
 .../media/platform/amd/isp4/isp4_interface.c  | 347 ++++++----------
 .../media/platform/amd/isp4/isp4_interface.h  |  19 +-
 drivers/media/platform/amd/isp4/isp4_subdev.c | 386 +++++++-----------
 drivers/media/platform/amd/isp4/isp4_subdev.h |   5 +-
 drivers/media/platform/amd/isp4/isp4_video.c  |  47 +--
 drivers/media/platform/amd/isp4/isp4_video.h  |  23 +-
 9 files changed, 418 insertions(+), 584 deletions(-)

diff --git a/drivers/media/platform/amd/isp4/isp4.c b/drivers/media/platform/amd/isp4/isp4.c
index 78a7a998d86e..5ecc21337fd3 100644
--- a/drivers/media/platform/amd/isp4/isp4.c
+++ b/drivers/media/platform/amd/isp4/isp4.c
@@ -18,72 +18,95 @@
 	(ISP_SYS_INT0_STATUS__SYS_INT_RINGBUFFER_WPT9_INT_MASK  | \
 	 ISP_SYS_INT0_STATUS__SYS_INT_RINGBUFFER_WPT12_INT_MASK)
 
-const char *isp4_irq_name[] = {
-	"isp_irq_global",
-	"isp_irq_stream1"
+static const struct {
+	const char *name;
+	u32 status_mask;
+	u32 en_mask;
+	u32 ack_mask;
+	u32 rb_int_num;
+} isp4_irq[ISP4SD_MAX_FW_RESP_STREAM_NUM] = {
+	/* The IRQ order is aligned with the isp4_subdev.fw_resp_thread order */
+	{
+		.name = "isp_irq_global",
+		.status_mask = ISP_SYS_INT0_STATUS__SYS_INT_RINGBUFFER_WPT12_INT_MASK,
+		.en_mask = ISP_SYS_INT0_EN__SYS_INT_RINGBUFFER_WPT12_EN_MASK,
+		.ack_mask = ISP_SYS_INT0_ACK__SYS_INT_RINGBUFFER_WPT12_ACK_MASK,
+		.rb_int_num = 4, /* ISP_4_1__SRCID__ISP_RINGBUFFER_WPT12 */
+	},
+	{
+		.name = "isp_irq_stream1",
+		.status_mask = ISP_SYS_INT0_STATUS__SYS_INT_RINGBUFFER_WPT9_INT_MASK,
+		.en_mask = ISP_SYS_INT0_EN__SYS_INT_RINGBUFFER_WPT9_EN_MASK,
+		.ack_mask = ISP_SYS_INT0_ACK__SYS_INT_RINGBUFFER_WPT9_ACK_MASK,
+		.rb_int_num = 0, /* ISP_4_1__SRCID__ISP_RINGBUFFER_WPT9 */
+	},
 };
 
-const u32 isp4_irq_status_mask[ISP4SD_MAX_FW_RESP_STREAM_NUM] = {
-	/* global response */
-	ISP_SYS_INT0_STATUS__SYS_INT_RINGBUFFER_WPT12_INT_MASK,
-	/* stream 1 response */
-	ISP_SYS_INT0_STATUS__SYS_INT_RINGBUFFER_WPT9_INT_MASK
-};
-
-const u32 isp4_irq_ack_mask[ISP4SD_MAX_FW_RESP_STREAM_NUM] = {
-	/* global ack */
-	ISP_SYS_INT0_ACK__SYS_INT_RINGBUFFER_WPT12_ACK_MASK,
-	/* stream 1 ack */
-	ISP_SYS_INT0_ACK__SYS_INT_RINGBUFFER_WPT9_ACK_MASK
-};
-
-/* irq num, the irq order is aligend with the isp4_subdev.fw_resp_thread order */
-static const u32 isp4_ringbuf_interrupt_num[ISP4SD_MAX_FW_RESP_STREAM_NUM] = {
-	4, /* ISP_4_1__SRCID__ISP_RINGBUFFER_WPT12 */
-	0  /* ISP_4_1__SRCID__ISP_RINGBUFFER_WPT9 */
-};
-
-static void isp4_wake_up_resp_thread(struct isp4_subdev *isp_subdev, u32 index)
+void isp4_intr_enable(struct isp4_subdev *isp_subdev, u32 index, bool enable)
 {
-	if (isp_subdev && index < ISP4SD_MAX_FW_RESP_STREAM_NUM) {
-		struct isp4sd_thread_handler *thread_ctx = &isp_subdev->fw_resp_thread[index];
-
-		thread_ctx->wq_cond = 1;
-		wake_up_interruptible(&thread_ctx->waitq);
-	}
+	u32 intr_en;
+
+	/* Synchronize ISP_SYS_INT0_EN writes with the IRQ handler's writes */
+	spin_lock_irq(&isp_subdev->irq_lock);
+	intr_en = isp4hw_rreg(GET_ISP4IF_REG_BASE(isp_subdev), ISP_SYS_INT0_EN);
+	if (enable)
+		intr_en |= isp4_irq[index].en_mask;
+	else
+		intr_en &= ~isp4_irq[index].en_mask;
+	isp4hw_wreg(isp_subdev->mmio, ISP_SYS_INT0_EN, intr_en);
+	spin_unlock_irq(&isp_subdev->irq_lock);
 }
 
-static void isp4_resp_interrupt_notify(struct isp4_subdev *isp_subdev, u32 intr_status)
+static void isp4_wake_up_resp_thread(struct isp4_subdev *isp_subdev, u32 index)
 {
-	u32 intr_ack = 0;
-
-	for (size_t i = 0; i < ARRAY_SIZE(isp4_irq_status_mask); i++) {
-		if (intr_status & isp4_irq_status_mask[i]) {
-			disable_irq_nosync(isp_subdev->irq[i]);
-			isp4_wake_up_resp_thread(isp_subdev, i);
-
-			intr_ack |= isp4_irq_ack_mask[i];
-		}
-	}
+	struct isp4sd_thread_handler *thread_ctx = &isp_subdev->fw_resp_thread[index];
 
-	/* clear ISP_SYS interrupts */
-	isp4hw_wreg(ISP4_GET_ISP_REG_BASE(isp_subdev), ISP_SYS_INT0_ACK, intr_ack);
+	thread_ctx->resp_ready = true;
+	wake_up_interruptible(&thread_ctx->waitq);
 }
 
 static irqreturn_t isp4_irq_handler(int irq, void *arg)
 {
-	struct isp4_device *isp_dev = arg;
-	struct isp4_subdev *isp_subdev;
-	u32 isp_sys_irq_status;
-	u32 r1;
-
-	isp_subdev = &isp_dev->isp_subdev;
-	/* check ISP_SYS interrupts status */
-	r1 = isp4hw_rreg(ISP4_GET_ISP_REG_BASE(isp_subdev), ISP_SYS_INT0_STATUS);
-
-	isp_sys_irq_status = r1 & ISP4_FW_RESP_RB_IRQ_STATUS_MASK;
+	struct isp4_subdev *isp_subdev = arg;
+	u32 intr_ack = 0, intr_en, intr_status;
+	int seen = 0;
+
+	/* Get the ISP_SYS interrupt status */
+	intr_status = isp4hw_rreg(isp_subdev->mmio, ISP_SYS_INT0_STATUS);
+	intr_status &= ISP4_FW_RESP_RB_IRQ_STATUS_MASK;
+
+	/* Synchronize ISP_SYS_INT0_EN r/w with isp4_enable_interrupt() */
+	spin_lock(&isp_subdev->irq_lock);
+	intr_en = isp4hw_rreg(isp_subdev->mmio, ISP_SYS_INT0_EN);
+
+	/* Find which _enabled_ ISP_SYS interrupts fired */
+	for (size_t i = 0; i < ARRAY_SIZE(isp4_irq); i++) {
+		if ((intr_en & isp4_irq[i].en_mask) &&
+		    (intr_status & isp4_irq[i].status_mask)) {
+			intr_ack |= isp4_irq[i].ack_mask;
+			intr_en &= ~isp4_irq[i].en_mask;
+			seen |= BIT(i);
+		}
+	}
 
-	isp4_resp_interrupt_notify(isp_subdev, isp_sys_irq_status);
+	/*
+	 * Disable the ISP_SYS interrupts that fired. Must be done before waking
+	 * the response threads, since they re-enable interrupts when finished.
+	 */
+	isp4hw_wreg(isp_subdev->mmio, ISP_SYS_INT0_EN, intr_en);
+	spin_unlock(&isp_subdev->irq_lock);
+
+	/*
+	 * Clear the ISP_SYS interrupts. This must be done _after_ the
+	 * interrupts are disabled, so that ISP FW won't flag any new interrupts
+	 * on these streams, and thus we don't need to clear interrupts again
+	 * before re-enabling them.
+	 */
+	isp4hw_wreg(isp_subdev->mmio, ISP_SYS_INT0_ACK, intr_ack);
+
+	/* Wake up the response threads */
+	for (int i; (i = ffs(seen)); seen = (seen >> i) << i)
+		isp4_wake_up_resp_thread(isp_subdev, i - 1);
 
 	return IRQ_HANDLED;
 }
@@ -109,15 +132,14 @@ static int isp4_capture_probe(struct platform_device *pdev)
 	if (IS_ERR(isp_subdev->mmio))
 		return dev_err_probe(dev, PTR_ERR(isp_subdev->mmio), "isp ioremap fail\n");
 
-	for (i = 0; i < ARRAY_SIZE(isp4_ringbuf_interrupt_num); i++) {
-		irq[i] = platform_get_irq(pdev, isp4_ringbuf_interrupt_num[i]);
+	for (i = 0; i < ARRAY_SIZE(isp4_irq); i++) {
+		irq[i] = platform_get_irq(pdev, isp4_irq[i].rb_int_num);
 		if (irq[i] < 0)
 			return dev_err_probe(dev, irq[i], "fail to get irq %d\n",
-					     isp4_ringbuf_interrupt_num[i]);
+					     isp4_irq[i].rb_int_num);
 
-		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
-		ret = devm_request_irq(dev, irq[i], isp4_irq_handler, 0, isp4_irq_name[i],
-				       isp_dev);
+		ret = devm_request_irq(dev, irq[i], isp4_irq_handler,
+				       IRQF_NO_AUTOEN, isp4_irq[i].name, isp_subdev);
 		if (ret)
 			return dev_err_probe(dev, ret, "fail to req irq %d\n", irq[i]);
 	}
@@ -132,8 +154,6 @@ static int isp4_capture_probe(struct platform_device *pdev)
 	isp_dev->mdev.dev = dev;
 	media_device_init(&isp_dev->mdev);
 
-	pm_runtime_set_suspended(dev);
-	pm_runtime_enable(dev);
 	/* register v4l2 device */
 	snprintf(isp_dev->v4l2_dev.name, sizeof(isp_dev->v4l2_dev.name),
 		 "AMD-V4L2-ROOT");
@@ -141,10 +161,13 @@ static int isp4_capture_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "fail register v4l2 device\n");
 
+	pm_runtime_set_suspended(dev);
+	pm_runtime_enable(dev);
+	spin_lock_init(&isp_subdev->irq_lock);
 	ret = isp4sd_init(&isp_dev->isp_subdev, &isp_dev->v4l2_dev, irq);
 	if (ret) {
 		dev_err(dev, "fail init isp4 sub dev %d\n", ret);
-		goto err_unreg_v4l2;
+		goto err_pm_disable;
 	}
 
 	ret = media_create_pad_link(&isp_dev->isp_subdev.sdev.entity,
@@ -170,16 +193,17 @@ static int isp4_capture_probe(struct platform_device *pdev)
 
 err_isp4_deinit:
 	isp4sd_deinit(&isp_dev->isp_subdev);
-err_unreg_v4l2:
+err_pm_disable:
+	pm_runtime_disable(dev);
 	v4l2_device_unregister(&isp_dev->v4l2_dev);
 	media_device_cleanup(&isp_dev->mdev);
-
 	return dev_err_probe(dev, ret, "isp probe fail\n");
 }
 
 static void isp4_capture_remove(struct platform_device *pdev)
 {
 	struct isp4_device *isp_dev = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
 
 	isp_debugfs_remove(isp_dev);
 
@@ -187,6 +211,7 @@ static void isp4_capture_remove(struct platform_device *pdev)
 	isp4sd_deinit(&isp_dev->isp_subdev);
 	v4l2_device_unregister(&isp_dev->v4l2_dev);
 	media_device_cleanup(&isp_dev->mdev);
+	pm_runtime_disable(dev);
 }
 
 static struct platform_driver isp4_capture_drv = {
diff --git a/drivers/media/platform/amd/isp4/isp4.h b/drivers/media/platform/amd/isp4/isp4.h
index 54cd033326f9..a4d130ebe8e8 100644
--- a/drivers/media/platform/amd/isp4/isp4.h
+++ b/drivers/media/platform/amd/isp4/isp4.h
@@ -18,4 +18,6 @@ struct isp4_device {
 	struct platform_device *pdev;
 };
 
+void isp4_intr_enable(struct isp4_subdev *isp_subdev, u32 index, bool enable);
+
 #endif /* _ISP4_H_ */
diff --git a/drivers/media/platform/amd/isp4/isp4_debug.c b/drivers/media/platform/amd/isp4/isp4_debug.c
index 746a92707e54..5f631cf811c7 100644
--- a/drivers/media/platform/amd/isp4/isp4_debug.c
+++ b/drivers/media/platform/amd/isp4/isp4_debug.c
@@ -47,8 +47,8 @@ static u32 isp_fw_fill_rb_log(struct isp4_subdev *isp, u8 *sys, u32 rb_size)
 
 	guard(mutex)(&ispif->isp4if_mutex);
 
-	rd_ptr = isp4hw_rreg(ISP4_GET_ISP_REG_BASE(isp), ISP_LOG_RB_RPTR0);
-	wr_ptr = isp4hw_rreg(ISP4_GET_ISP_REG_BASE(isp), ISP_LOG_RB_WPTR0);
+	rd_ptr = isp4hw_rreg(isp->mmio, ISP_LOG_RB_RPTR0);
+	wr_ptr = isp4hw_rreg(isp->mmio, ISP_LOG_RB_WPTR0);
 
 	do {
 		if (wr_ptr > rd_ptr)
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
@@ -70,9 +70,9 @@ static u32 isp_fw_fill_rb_log(struct isp4_subdev *isp, u8 *sys, u32 rb_size)
 		rd_ptr = (rd_ptr + cnt) % rb_size;
 	} while (rd_ptr < wr_ptr);
 
-	isp4hw_wreg(ISP4_GET_ISP_REG_BASE(isp), ISP_LOG_RB_RPTR0, rd_ptr);
+	isp4hw_wreg(isp->mmio, ISP_LOG_RB_RPTR0, rd_ptr);
 
-unlock_and_quit:
+quit:
 	return total_cnt;
 }
 
@@ -159,7 +159,7 @@ char *isp4dbg_get_buf_done_str(u32 status)
 	default:
 		return "Unknown Buf Done Status";
 	}
-};
+}
 
 char *isp4dbg_get_img_fmt_str(int fmt /* enum isp4fw_image_format * */)
 {
@@ -233,7 +233,7 @@ char *isp4dbg_get_cmd_str(u32 cmd)
 		return ISP4DBG_MACRO_2_STR(CMD_ID_ENABLE_OUT_CHAN);
 	default:
 		return "unknown cmd";
-	};
+	}
 }
 
 char *isp4dbg_get_resp_str(u32 cmd)
@@ -245,7 +245,7 @@ char *isp4dbg_get_resp_str(u32 cmd)
 		return ISP4DBG_MACRO_2_STR(RESP_ID_NOTI_FRAME_DONE);
 	default:
 		return "unknown respid";
-	};
+	}
 }
 
 char *isp4dbg_get_if_stream_str(u32 stream /* enum fw_cmd_resp_stream_id */)
diff --git a/drivers/media/platform/amd/isp4/isp4_interface.c b/drivers/media/platform/amd/isp4/isp4_interface.c
index 1852bd56a947..8d36f8b483ff 100644
--- a/drivers/media/platform/amd/isp4/isp4_interface.c
+++ b/drivers/media/platform/amd/isp4/isp4_interface.c
@@ -12,10 +12,10 @@
 
 #define ISP4IF_FW_RESP_RB_IRQ_EN_MASK \
 	(ISP_SYS_INT0_EN__SYS_INT_RINGBUFFER_WPT9_EN_MASK |  \
-	 ISP_SYS_INT0_EN__SYS_INT_RINGBUFFER_WPT10_EN_MASK | \
-	 ISP_SYS_INT0_EN__SYS_INT_RINGBUFFER_WPT11_EN_MASK | \
 	 ISP_SYS_INT0_EN__SYS_INT_RINGBUFFER_WPT12_EN_MASK)
 
+#define ISP4IF_FW_CMD_TIMEOUT (HZ / 2)
+
 struct isp4if_rb_config {
 	const char *name;
 	u32 index;
@@ -204,7 +204,7 @@ static int isp4if_alloc_fw_gpumem(struct isp4_interface *ispif)
 	return -ENOMEM;
 }
 
-static u32 isp4if_compute_check_sum(const u8 *buf, size_t buf_size)
+static u32 isp4if_compute_check_sum(const void *buf, size_t buf_size)
 {
 	const u8 *surplus_ptr;
 	const u32 *buffer;
@@ -281,16 +281,16 @@ struct isp4if_cmd_element *isp4if_rm_cmd_from_cmdq(struct isp4_interface *ispif,
 						   u32 cmd_id)
 {
 	struct isp4if_cmd_element *buf_node;
-	struct isp4if_cmd_element *tmp_node;
 
-	scoped_guard(spinlock, &ispif->cmdq_lock)
-		list_for_each_entry_safe(buf_node, tmp_node, &ispif->cmdq, list) {
-			if (buf_node->seq_num == seq_num &&
-			    buf_node->cmd_id == cmd_id) {
-				list_del(&buf_node->list);
-				return buf_node;
-			}
+	guard(spinlock)(&ispif->cmdq_lock);
+
+	list_for_each_entry(buf_node, &ispif->cmdq, list) {
+		if (buf_node->seq_num == seq_num &&
+		    buf_node->cmd_id == cmd_id) {
+			list_del(&buf_node->list);
+			return buf_node;
 		}
+	}
 
 	return NULL;
 }
@@ -372,17 +372,14 @@ static inline enum isp4if_stream_id isp4if_get_fw_stream(u32 cmd_id)
 	return ISP4IF_STREAM_ID_1;
 }
 
-static int isp4if_send_fw_cmd(struct isp4_interface *ispif, u32 cmd_id, void *package,
-			      u32 package_size, struct completion *cmd_complete, u32 *seq)
+static int isp4if_send_fw_cmd(struct isp4_interface *ispif, u32 cmd_id, const void *package,
+			      u32 package_size, bool sync)
 {
 	enum isp4if_stream_id stream = isp4if_get_fw_stream(cmd_id);
-	struct isp4if_cmd_element *cmd_ele = NULL;
-	struct isp4if_rb_config *rb_config;
+	struct isp4if_cmd_element *ele = NULL;
 	struct device *dev = ispif->dev;
-	struct isp4fw_cmd cmd = {};
+	struct isp4fw_cmd cmd;
 	u32 seq_num;
-	u32 rreg;
-	u32 wreg;
 	int ret;
 
 	if (package_size > sizeof(cmd.cmd_param)) {
@@ -391,32 +388,40 @@ static int isp4if_send_fw_cmd(struct isp4_interface *ispif, u32 cmd_id, void *pa
 		return -EINVAL;
 	}
 
-	/*
-	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
-	 * zeroed, since this may not guarantee on all compilers.
-	 */
-	memset(&cmd, 0, sizeof(cmd));
-	rb_config = &isp4if_resp_rb_config[stream];
-	rreg = rb_config->reg_rptr;
-	wreg = rb_config->reg_wptr;
+	/* Allocate the sync command object early and outside of the lock */
+	if (sync) {
+		ele = kmalloc(sizeof(*ele), GFP_KERNEL);
+		if (!ele)
+			return -ENOMEM;
+
+		/* Get two references: one for the resp thread, one for us */
+		atomic_set(&ele->refcnt, 2);
+		init_completion(&ele->cmd_done);
+	}
 
 	guard(mutex)(&ispif->isp4if_mutex);
 
 	ret = read_poll_timeout(isp4if_is_cmdq_rb_full, ret, !ret, ISP4IF_MAX_SLEEP_TIME * 1000,
 				ISP4IF_MAX_SLEEP_COUNT * ISP4IF_MAX_SLEEP_TIME * 1000, false,
 				ispif, stream);
-
 	if (ret) {
-		u32 rd_ptr = isp4hw_rreg(ispif->mmio, rreg);
-		u32 wr_ptr = isp4hw_rreg(ispif->mmio, wreg);
+		struct isp4if_rb_config *rb_config = &isp4if_resp_rb_config[stream];
+		u32 rd_ptr = isp4hw_rreg(ispif->mmio, rb_config->reg_rptr);
+		u32 wr_ptr = isp4hw_rreg(ispif->mmio, rb_config->reg_wptr);
 
 		dev_err(dev,
 			"failed to get free cmdq slot, stream %s(%d),rd %u, wr %u\n",
 			isp4dbg_get_if_stream_str(stream),
 			stream, rd_ptr, wr_ptr);
-		return -ETIMEDOUT;
+		ret = -ETIMEDOUT;
+		goto free_ele;
 	}
 
+	/*
+	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
+	 * zeroed, since this is not guaranteed on all compilers.
+	 */
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.cmd_id = cmd_id;
 	switch (stream) {
 	case ISP4IF_STREAM_ID_GLOBAL:
@@ -427,7 +432,8 @@ static int isp4if_send_fw_cmd(struct isp4_interface *ispif, u32 cmd_id, void *pa
 		break;
 	default:
 		dev_err(dev, "fail bad stream id %d\n", stream);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free_ele;
 	}
 
 	if (package && package_size)
@@ -435,39 +441,53 @@ static int isp4if_send_fw_cmd(struct isp4_interface *ispif, u32 cmd_id, void *pa
 
 	seq_num = ispif->host2fw_seq_num++;
 	cmd.cmd_seq_num = seq_num;
-	cmd.cmd_check_sum =
-		isp4if_compute_check_sum((u8 *)&cmd, sizeof(cmd) - sizeof(u32));
+	cmd.cmd_check_sum = isp4if_compute_check_sum(&cmd, sizeof(cmd) - sizeof(u32));
 
-	if (seq)
-		*seq = seq_num;
 	/*
 	 * only append the fw cmd to queue when its response needs to be waited for,
 	 * currently there are only two such commands, disable channel and stop stream
 	 * which are only sent after close camera
 	 */
-	if (cmd_complete) {
-		cmd_ele = kmalloc(sizeof(*cmd_ele), GFP_KERNEL);
-		if (!cmd_ele)
-			return -ENOMEM;
-
-		cmd_ele->seq_num = seq_num;
-		cmd_ele->cmd_id = cmd_id;
-		cmd_ele->cmd_complete = cmd_complete;
-
+	if (ele) {
+		ele->seq_num = seq_num;
+		ele->cmd_id = cmd_id;
 		scoped_guard(spinlock, &ispif->cmdq_lock)
-			list_add_tail(&cmd_ele->list, &ispif->cmdq);
+			list_add_tail(&ele->list, &ispif->cmdq);
 	}
 
 	ret = isp4if_insert_isp_fw_cmd(ispif, stream, &cmd);
 	if (ret) {
 		dev_err(dev, "fail for insert_isp_fw_cmd camId %s(0x%08x)\n",
 			isp4dbg_get_cmd_str(cmd_id), cmd_id);
-		if (cmd_ele) {
-			cmd_ele = isp4if_rm_cmd_from_cmdq(ispif, seq_num, cmd_id);
-			kfree(cmd_ele);
+		goto err_dequeue_ele;
+	}
+
+	if (ele) {
+		ret = wait_for_completion_timeout(&ele->cmd_done, ISP4IF_FW_CMD_TIMEOUT);
+		if (!ret) {
+			ret = -ETIMEDOUT;
+			goto err_dequeue_ele;
 		}
+		ret = 0;
+		goto put_ele_ref;
 	}
 
+	return 0;
+
+err_dequeue_ele:
+	/*
+	 * Try to remove the command from the queue. If that fails, then it
+	 * means the response thread is currently using the object, and we need
+	 * to use the refcount to avoid a use-after-free by either side.
+	 */
+	if (ele && isp4if_rm_cmd_from_cmdq(ispif, seq_num, cmd_id))
+		goto free_ele;
+put_ele_ref:
+	/* Don't free the command if we didn't put the last reference */
+	if (ele && atomic_dec_return(&ele->refcnt))
+		ele = NULL;
+free_ele:
+	kfree(ele);
 	return ret;
 }
 
@@ -477,11 +497,10 @@ static int isp4if_send_buffer(struct isp4_interface *ispif, struct isp4if_img_bu
 
 	/*
 	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
-	 * zeroed, since this may not guarantee on all compilers.
+	 * zeroed, since this is not guaranteed on all compilers.
 	 */
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.buffer_type = BUFFER_TYPE_PREVIEW;
-	cmd.buffer.vmid_space.bit.vmid = 0;
 	cmd.buffer.vmid_space.bit.space = ADDR_SPACE_TYPE_GPU_VA;
 	isp4if_split_addr64(buf_info->planes[0].mc_addr,
 			    &cmd.buffer.buf_base_a_lo,
@@ -498,26 +517,20 @@ static int isp4if_send_buffer(struct isp4_interface *ispif, struct isp4if_img_bu
 			    &cmd.buffer.buf_base_c_hi);
 	cmd.buffer.buf_size_c = buf_info->planes[2].len;
 
-	return isp4if_send_fw_cmd(ispif, CMD_ID_SEND_BUFFER, &cmd, sizeof(cmd), NULL, NULL);
+	return isp4if_send_fw_cmd(ispif, CMD_ID_SEND_BUFFER, &cmd, sizeof(cmd), false);
 }
 
 static void isp4if_init_rb_config(struct isp4_interface *ispif, struct isp4if_rb_config *rb_config)
 {
-	u32 lo;
-	u32 hi;
+	u32 lo, hi;
 
 	isp4if_split_addr64(rb_config->base_mc_addr, &lo, &hi);
 
-	isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif),
-		    rb_config->reg_rptr, 0x0);
-	isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif),
-		    rb_config->reg_wptr, 0x0);
-	isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif),
-		    rb_config->reg_base_lo, lo);
-	isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif),
-		    rb_config->reg_base_hi, hi);
-	isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif),
-		    rb_config->reg_size, rb_config->val_size);
+	isp4hw_wreg(ispif->mmio, rb_config->reg_rptr, 0x0);
+	isp4hw_wreg(ispif->mmio, rb_config->reg_wptr, 0x0);
+	isp4hw_wreg(ispif->mmio, rb_config->reg_base_lo, lo);
+	isp4hw_wreg(ispif->mmio, rb_config->reg_base_hi, hi);
+	isp4hw_wreg(ispif->mmio, rb_config->reg_size, rb_config->val_size);
 }
 
 static int isp4if_fw_init(struct isp4_interface *ispif)
@@ -577,7 +590,7 @@ static int isp4if_wait_fw_ready(struct isp4_interface *ispif, u32 isp_status_add
 	/* wait for FW initialize done! */
 	if (!read_poll_timeout(isp4hw_rreg, reg_val, reg_val & ISP_STATUS__CCPU_REPORT_MASK,
 			       interval_ms * 1000, timeout_ms * 1000, false,
-			       GET_ISP4IF_REG_BASE(ispif), isp_status_addr))
+			       ispif->mmio, isp_status_addr))
 		return 0;
 
 	dev_err(dev, "ISP CCPU FW boot failed\n");
@@ -589,30 +602,30 @@ static void isp4if_enable_ccpu(struct isp4_interface *ispif)
 {
 	u32 reg_val;
 
-	reg_val = isp4hw_rreg(GET_ISP4IF_REG_BASE(ispif), ISP_SOFT_RESET);
+	reg_val = isp4hw_rreg(ispif->mmio, ISP_SOFT_RESET);
 	reg_val &= (~ISP_SOFT_RESET__CCPU_SOFT_RESET_MASK);
-	isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif), ISP_SOFT_RESET, reg_val);
+	isp4hw_wreg(ispif->mmio, ISP_SOFT_RESET, reg_val);
 
 	usleep_range(100, 150);
 
-	reg_val = isp4hw_rreg(GET_ISP4IF_REG_BASE(ispif), ISP_CCPU_CNTL);
+	reg_val = isp4hw_rreg(ispif->mmio, ISP_CCPU_CNTL);
 	reg_val &= (~ISP_CCPU_CNTL__CCPU_HOST_SOFT_RST_MASK);
-	isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif), ISP_CCPU_CNTL, reg_val);
+	isp4hw_wreg(ispif->mmio, ISP_CCPU_CNTL, reg_val);
 }
 
 static void isp4if_disable_ccpu(struct isp4_interface *ispif)
 {
 	u32 reg_val;
 
-	reg_val = isp4hw_rreg(GET_ISP4IF_REG_BASE(ispif), ISP_CCPU_CNTL);
+	reg_val = isp4hw_rreg(ispif->mmio, ISP_CCPU_CNTL);
 	reg_val |= ISP_CCPU_CNTL__CCPU_HOST_SOFT_RST_MASK;
-	isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif), ISP_CCPU_CNTL, reg_val);
+	isp4hw_wreg(ispif->mmio, ISP_CCPU_CNTL, reg_val);
 
 	usleep_range(100, 150);
 
-	reg_val = isp4hw_rreg(GET_ISP4IF_REG_BASE(ispif), ISP_SOFT_RESET);
+	reg_val = isp4hw_rreg(ispif->mmio, ISP_SOFT_RESET);
 	reg_val |= ISP_SOFT_RESET__CCPU_SOFT_RESET_MASK;
-	isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif), ISP_SOFT_RESET, reg_val);
+	isp4hw_wreg(ispif->mmio, ISP_SOFT_RESET, reg_val);
 }
 
 static int isp4if_fw_boot(struct isp4_interface *ispif)
@@ -629,7 +642,7 @@ static int isp4if_fw_boot(struct isp4_interface *ispif)
 	isp4if_fw_init(ispif);
 
 	/* clear ccpu status */
-	isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif), ISP_STATUS, 0x0);
+	isp4hw_wreg(ispif->mmio, ISP_STATUS, 0x0);
 
 	isp4if_enable_ccpu(ispif);
 
@@ -639,8 +652,7 @@ static int isp4if_fw_boot(struct isp4_interface *ispif)
 	}
 
 	/* enable interrupts */
-	isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif), ISP_SYS_INT0_EN,
-		    ISP4IF_FW_RESP_RB_IRQ_EN_MASK);
+	isp4hw_wreg(ispif->mmio, ISP_SYS_INT0_EN, ISP4IF_FW_RESP_RB_IRQ_EN_MASK);
 
 	ispif->status = ISP4IF_STATUS_FW_RUNNING;
 
@@ -651,163 +663,71 @@ static int isp4if_fw_boot(struct isp4_interface *ispif)
 
 int isp4if_f2h_resp(struct isp4_interface *ispif, enum isp4if_stream_id stream, void *resp)
 {
-	struct isp4fw_resp *response = resp;
-	struct isp4if_rb_config *rb_config;
+	struct isp4if_rb_config *rb_config = &isp4if_resp_rb_config[stream];
+	u32 rreg = rb_config->reg_rptr, wreg = rb_config->reg_wptr;
+	void *mem_sys = rb_config->base_sys_addr;
+	struct isp4fw_resp *rstruct = resp;
+	const u32 rstruct_sz = sizeof(*rstruct);
 	struct device *dev = ispif->dev;
-	u32 rd_ptr_dbg;
-	u32 wr_ptr_dbg;
-	void *mem_sys;
-	u64 mem_addr;
+	u32 len = rb_config->val_size;
+	u32 rd_ptr, wr_ptr;
+	u32 bytes_to_end;
 	u32 checksum;
-	u32 rd_ptr;
-	u32 wr_ptr;
-	u32 rreg;
-	u32 wreg;
-	u32 len;
 
-	rb_config = &isp4if_resp_rb_config[stream];
-	rreg = rb_config->reg_rptr;
-	wreg = rb_config->reg_wptr;
-	mem_sys = rb_config->base_sys_addr;
-	mem_addr = rb_config->base_mc_addr;
-	len = rb_config->val_size;
-
-	rd_ptr = isp4hw_rreg(GET_ISP4IF_REG_BASE(ispif), rreg);
-	wr_ptr = isp4hw_rreg(GET_ISP4IF_REG_BASE(ispif), wreg);
-	rd_ptr_dbg = rd_ptr;
-	wr_ptr_dbg = wr_ptr;
-
-	if (rd_ptr > len) {
-		dev_err(dev, "fail %s(%u),rd_ptr %u(should<=%u),wr_ptr %u\n",
-			isp4dbg_get_if_stream_str(stream),
-			stream, rd_ptr, len, wr_ptr);
-		return -EINVAL;
-	}
-
-	if (wr_ptr > len) {
-		dev_err(dev, "fail %s(%u),wr_ptr %u(should<=%u), rd_ptr %u\n",
-			isp4dbg_get_if_stream_str(stream),
-			stream, wr_ptr, len, rd_ptr);
-		return -EINVAL;
-	}
+	rd_ptr = isp4hw_rreg(ispif->mmio, rreg);
+	wr_ptr = isp4hw_rreg(ispif->mmio, wreg);
+	if (rd_ptr >= len || wr_ptr >= len)
+		goto err_rb_invalid;
 
-	if (rd_ptr < wr_ptr) {
-		if ((wr_ptr - rd_ptr) >= (sizeof(struct isp4fw_resp))) {
-			memcpy((u8 *)response, (u8 *)mem_sys + rd_ptr,
-			       sizeof(struct isp4fw_resp));
-
-			rd_ptr += sizeof(struct isp4fw_resp);
-			if (rd_ptr < len) {
-				isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif),
-					    rreg, rd_ptr);
-			} else {
-				dev_err(dev, "%s(%u),rd %u(should<=%u),wr %u\n",
-					isp4dbg_get_if_stream_str(stream),
-					stream, rd_ptr, len, wr_ptr);
-				return -EINVAL;
-			}
+	/* Read and write pointers are equal, indicating the ringbuf is empty */
+	if (rd_ptr == wr_ptr)
+		return -ENODATA;
 
-		} else {
-			dev_err(dev, "sth wrong with wptr and rptr\n");
-			return -EINVAL;
-		}
-	} else if (rd_ptr > wr_ptr) {
-		u32 size;
-		u8 *dst;
-
-		dst = (u8 *)response;
-
-		size = len - rd_ptr;
-		if (size > sizeof(struct isp4fw_resp)) {
-			mem_addr += rd_ptr;
-			memcpy((u8 *)response,
-			       (u8 *)(mem_sys) + rd_ptr,
-			       sizeof(struct isp4fw_resp));
-			rd_ptr += sizeof(struct isp4fw_resp);
-			if (rd_ptr < len) {
-				isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif),
-					    rreg, rd_ptr);
-			} else {
-				dev_err(dev, "%s(%u),rd %u(should<=%u),wr %u\n",
-					isp4dbg_get_if_stream_str(stream),
-					stream, rd_ptr, len, wr_ptr);
-				return -EINVAL;
-			}
+	bytes_to_end = len - rd_ptr;
+	if (bytes_to_end >= rstruct_sz) {
+		/* FW response is just a straight copy from the read pointer */
+		if (wr_ptr > rd_ptr && wr_ptr - rd_ptr < rstruct_sz)
+			goto err_rb_invalid;
 
-		} else {
-			if ((size + wr_ptr) < (sizeof(struct isp4fw_resp))) {
-				dev_err(dev, "sth wrong with wptr and rptr1\n");
-				return -EINVAL;
-			}
-
-			memcpy(dst, (u8 *)(mem_sys) + rd_ptr, size);
-
-			dst += size;
-			size = sizeof(struct isp4fw_resp) - size;
-			if (size)
-				memcpy(dst, (u8 *)(mem_sys), size);
-			rd_ptr = size;
-			if (rd_ptr < len) {
-				isp4hw_wreg(GET_ISP4IF_REG_BASE(ispif),
-					    rreg, rd_ptr);
-			} else {
-				dev_err(dev, "%s(%u),rd %u(should<=%u),wr %u\n",
-					isp4dbg_get_if_stream_str(stream),
-					stream, rd_ptr, len, wr_ptr);
-				return -EINVAL;
-			}
-		}
+		memcpy(resp, mem_sys + rd_ptr, rstruct_sz);
+		isp4hw_wreg(ispif->mmio, rreg, (rd_ptr + rstruct_sz) % len);
 	} else {
-		return -ETIME;
-	}
+		/* FW response is split because the ringbuf wrapped around */
+		if (wr_ptr > rd_ptr || wr_ptr < rstruct_sz - bytes_to_end)
+			goto err_rb_invalid;
 
-	checksum = isp4if_compute_check_sum((u8 *)response,
-					    sizeof(struct isp4fw_resp) - sizeof(u32));
+		memcpy(resp, mem_sys + rd_ptr, bytes_to_end);
+		memcpy(resp + bytes_to_end, mem_sys, rstruct_sz - bytes_to_end);
+		isp4hw_wreg(ispif->mmio, rreg, rstruct_sz - bytes_to_end);
+	}
 
-	if (checksum != response->resp_check_sum) {
+	checksum = isp4if_compute_check_sum(rstruct, rstruct_sz - sizeof(u32));
+	if (checksum != rstruct->resp_check_sum) {
 		dev_err(dev, "resp checksum 0x%x,should 0x%x,rptr %u,wptr %u\n",
-			checksum, response->resp_check_sum, rd_ptr_dbg, wr_ptr_dbg);
-
+			checksum, rstruct->resp_check_sum, rd_ptr, wr_ptr);
 		dev_err(dev, "%s(%u), seqNo %u, resp_id %s(0x%x)\n",
-			isp4dbg_get_if_stream_str(stream), stream, response->resp_seq_num,
-			isp4dbg_get_resp_str(response->resp_id), response->resp_id);
-
+			isp4dbg_get_if_stream_str(stream), stream, rstruct->resp_seq_num,
+			isp4dbg_get_resp_str(rstruct->resp_id), rstruct->resp_id);
 		return -EINVAL;
 	}
 
 	return 0;
+
+err_rb_invalid:
+	dev_err(dev, "rb invalid: stream=%u(%s), rd=%u, wr=%u, len=%u, rstruct_sz=%u\n",
+		stream, isp4dbg_get_if_stream_str(stream), rd_ptr, wr_ptr, len, rstruct_sz);
+	return -EINVAL;
 }
 
-int isp4if_send_command(struct isp4_interface *ispif, u32 cmd_id, void *package, u32 package_size)
+int isp4if_send_command(struct isp4_interface *ispif, u32 cmd_id, const void *package, u32 package_size)
 {
-	return isp4if_send_fw_cmd(ispif, cmd_id, package, package_size, NULL, NULL);
+	return isp4if_send_fw_cmd(ispif, cmd_id, package, package_size, false);
 }
 
-int isp4if_send_command_sync(struct isp4_interface *ispif, u32 cmd_id, void *package,
-			     u32 package_size, u32 timeout)
+int isp4if_send_command_sync(struct isp4_interface *ispif, u32 cmd_id, const void *package,
+			     u32 package_size)
 {
-	DECLARE_COMPLETION_ONSTACK(cmd_completion);
-	struct device *dev = ispif->dev;
-	int ret;
-	u32 seq;
-
-	ret = isp4if_send_fw_cmd(ispif, cmd_id, package, package_size, &cmd_completion, &seq);
-
-	if (ret) {
-		dev_err(dev, "send fw cmd fail %d\n", ret);
-		return ret;
-	}
-
-	ret = wait_for_completion_timeout(&cmd_completion, msecs_to_jiffies(timeout));
-	if (ret == 0) {
-		struct isp4if_cmd_element *ele;
-
-		ele = isp4if_rm_cmd_from_cmdq(ispif, seq, cmd_id);
-		kfree(ele);
-		return -ETIMEDOUT;
-	}
-
-	return 0;
+	return isp4if_send_fw_cmd(ispif, cmd_id, package, package_size, true);
 }
 
 void isp4if_clear_bufq(struct isp4_interface *ispif)
@@ -842,8 +762,9 @@ struct isp4if_img_buf_node *isp4if_dequeue_buffer(struct isp4_interface *ispif)
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
index 688a4ea84dc6..02c7c83b6d98 100644
--- a/drivers/media/platform/amd/isp4/isp4_interface.h
+++ b/drivers/media/platform/amd/isp4/isp4_interface.h
@@ -48,10 +48,10 @@ enum isp4if_status {
 };
 
 struct isp4if_gpu_mem_info {
-	u64	mem_size;
-	u64	gpu_mc_addr;
-	void	*sys_addr;
-	void	*mem_handle;
+	u64 mem_size;
+	u64 gpu_mc_addr;
+	void *sys_addr;
+	void *mem_handle;
 };
 
 struct isp4if_img_buf_info {
@@ -71,7 +71,8 @@ struct isp4if_cmd_element {
 	struct list_head list;
 	u32 seq_num;
 	u32 cmd_id;
-	struct completion *cmd_complete;
+	struct completion cmd_done;
+	atomic_t refcnt;
 };
 
 struct isp4_interface {
@@ -113,13 +114,13 @@ static inline u64 isp4if_join_addr64(u32 lo, u32 hi)
 	return (((u64)hi) << 32) | (u64)lo;
 }
 
-int isp4if_f2h_resp(struct isp4_interface *ispif, enum isp4if_stream_id stream, void *response);
+int isp4if_f2h_resp(struct isp4_interface *ispif, enum isp4if_stream_id stream, void *resp);
 
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
index 17480ae5150d..552b06f56a15 100644
--- a/drivers/media/platform/amd/isp4/isp4_subdev.c
+++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
@@ -9,7 +9,7 @@
 #include "isp4_debug.h"
 #include "isp4_fw_cmd_resp.h"
 #include "isp4_interface.h"
-#include "isp4_subdev.h"
+#include "isp4.h"
 
 #define ISP4SD_MAX_CMD_RESP_BUF_SIZE (4 * 1024)
 #define ISP4SD_MIN_BUF_CNT_BEF_START_STREAM 4
@@ -17,8 +17,6 @@
 #define ISP4SD_PERFORMANCE_STATE_LOW 0
 #define ISP4SD_PERFORMANCE_STATE_HIGH 1
 
-#define ISP4SD_FW_CMD_TIMEOUT_IN_MS  500
-
 /* align 32KB */
 #define ISP4SD_META_BUF_SIZE ALIGN(sizeof(struct isp4fw_meta_info), 0x8000)
 
@@ -55,12 +53,10 @@ static int isp4sd_setup_fw_mem_pool(struct isp4_subdev *isp_subdev)
 
 	/*
 	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
-	 * zeroed, since this may not guarantee on all compilers.
+	 * zeroed, since this is not guaranteed on all compilers.
 	 */
 	memset(&buf_type, 0, sizeof(buf_type));
 	buf_type.buffer_type = BUFFER_TYPE_MEM_POOL;
-	buf_type.buffer.buf_tags = 0;
-	buf_type.buffer.vmid_space.bit.vmid = 0;
 	buf_type.buffer.vmid_space.bit.space = ADDR_SPACE_TYPE_GPU_VA;
 	isp4if_split_addr64(ispif->fw_mem_pool->gpu_mc_addr,
 			    &buf_type.buffer.buf_base_a_lo,
@@ -82,7 +78,7 @@ static int isp4sd_setup_fw_mem_pool(struct isp4_subdev *isp_subdev)
 		buf_type.buffer.buf_size_a);
 
 	return 0;
-};
+}
 
 static int isp4sd_set_stream_path(struct isp4_subdev *isp_subdev)
 {
@@ -92,7 +88,7 @@ static int isp4sd_set_stream_path(struct isp4_subdev *isp_subdev)
 
 	/*
 	 * The struct will be shared with ISP FW, use memset() to guarantee padding bits are
-	 * zeroed, since this may not guarantee on all compilers.
+	 * zeroed, since this is not guaranteed on all compilers.
 	 */
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.stream_cfg.mipi_pipe_path_cfg.isp4fw_sensor_id = SENSOR_ID_ON_MIPI0;
@@ -113,16 +109,14 @@ static int isp4sd_send_meta_buf(struct isp4_subdev *isp_subdev)
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
 
@@ -131,8 +125,6 @@ static int isp4sd_send_meta_buf(struct isp4_subdev *isp_subdev)
 			return -ENOMEM;
 		}
 		buf_type.buffer_type = BUFFER_TYPE_META_INFO;
-		buf_type.buffer.buf_tags = 0;
-		buf_type.buffer.vmid_space.bit.vmid = 0;
 		buf_type.buffer.vmid_space.bit.space = ADDR_SPACE_TYPE_GPU_VA;
 		isp4if_split_addr64(isp_subdev->ispif.meta_info_buf[i]->gpu_mc_addr,
 				    &buf_type.buffer.buf_base_a_lo,
@@ -140,8 +132,7 @@ static int isp4sd_send_meta_buf(struct isp4_subdev *isp_subdev)
 		buf_type.buffer.buf_size_a =
 			(u32)isp_subdev->ispif.meta_info_buf[i]->mem_size;
 		ret = isp4if_send_command(ispif, CMD_ID_SEND_BUFFER,
-					  &buf_type,
-					  sizeof(buf_type));
+					  &buf_type, sizeof(buf_type));
 		if (ret) {
 			dev_err(dev, "send meta info(%u) fail\n", i);
 			return ret;
@@ -158,7 +149,6 @@ static bool isp4sd_get_str_out_prop(struct isp4_subdev *isp_subdev,
 {
 	struct device *dev = isp_subdev->dev;
 	struct v4l2_mbus_framefmt *format;
-	bool ret;
 
 	format = v4l2_subdev_state_get_format(state, pad, 0);
 	if (!format) {
@@ -173,7 +163,6 @@ static bool isp4sd_get_str_out_prop(struct isp4_subdev *isp_subdev,
 		out_prop->height = format->height;
 		out_prop->luma_pitch = format->width;
 		out_prop->chroma_pitch = out_prop->width;
-		ret = true;
 		break;
 	case MEDIA_BUS_FMT_YUYV8_1X16:
 		out_prop->image_format = IMAGE_FORMAT_YUV422INTERLEAVED;
@@ -181,18 +170,17 @@ static bool isp4sd_get_str_out_prop(struct isp4_subdev *isp_subdev,
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
@@ -201,23 +189,23 @@ static int isp4sd_kickoff_stream(struct isp4_subdev *isp_subdev, u32 w, u32 h)
 	struct isp4_interface *ispif = &isp_subdev->ispif;
 	struct device *dev = isp_subdev->dev;
 
-	if (sensor_info->status == ISP4SD_START_STATUS_STARTED) {
+	if (sensor_info->status == ISP4SD_START_STATUS_STARTED)
 		return 0;
-	} else if (sensor_info->status == ISP4SD_START_STATUS_START_FAIL) {
+
+	if (sensor_info->status == ISP4SD_START_STATUS_START_FAIL) {
 		dev_err(dev, "fail for previous start fail\n");
 		return -EINVAL;
 	}
 
 	dev_dbg(dev, "w:%u,h:%u\n", w, h);
 
-	sensor_info->status = ISP4SD_START_STATUS_START_FAIL;
-
 	if (isp4sd_send_meta_buf(isp_subdev)) {
 		dev_err(dev, "fail to send meta buf\n");
+		sensor_info->status = ISP4SD_START_STATUS_START_FAIL;
 		return -EINVAL;
-	};
+	}
 
-	sensor_info->status = ISP4SD_START_STATUS_NOT_START;
+	sensor_info->status = ISP4SD_START_STATUS_OFF;
 
 	if (!sensor_info->start_stream_cmd_sent &&
 	    sensor_info->buf_sent_cnt >=
@@ -249,7 +237,6 @@ static int isp4sd_setup_output(struct isp4_subdev *isp_subdev,
 	struct isp4fw_cmd_set_out_ch_prop cmd_ch_prop;
 	struct isp4fw_cmd_enable_out_ch cmd_ch_en;
 	struct device *dev = isp_subdev->dev;
-	struct isp4fw_image_prop *out_prop;
 	int ret;
 
 	if (output_info->start_status == ISP4SD_START_STATUS_STARTED)
@@ -262,20 +249,12 @@ static int isp4sd_setup_output(struct isp4_subdev *isp_subdev,
 
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
@@ -288,29 +267,34 @@ static int isp4sd_setup_output(struct isp4_subdev *isp_subdev,
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
 		return ret;
 	}
 
-	dev_dbg(dev, "enable channel %s\n",
-		isp4dbg_get_out_ch_str(cmd_ch_en.ch));
+	dev_dbg(dev, "enable channel %s\n", isp4dbg_get_out_ch_str(cmd_ch_en.ch));
 
 	if (!sensor_info->start_stream_cmd_sent) {
-		ret = isp4sd_kickoff_stream(isp_subdev, out_prop->width,
-					    out_prop->height);
+		ret = isp4sd_kickoff_stream(isp_subdev,
+					    cmd_ch_prop.image_prop.width,
+					    cmd_ch_prop.image_prop.height);
 		if (ret) {
 			dev_err(dev, "kickoff stream fail %d\n", ret);
 			return ret;
@@ -345,7 +329,7 @@ static int isp4sd_init_stream(struct isp4_subdev *isp_subdev)
 
 	ret  = isp4sd_setup_fw_mem_pool(isp_subdev);
 	if (ret) {
-		dev_err(dev, "fail to  setup fw mem pool\n");
+		dev_err(dev, "fail to setup fw mem pool\n");
 		return ret;
 	}
 
@@ -363,19 +347,16 @@ static void isp4sd_reset_stream_info(struct isp4_subdev *isp_subdev,
 {
 	struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
 	struct v4l2_mbus_framefmt *format;
-	struct isp4sd_output_info *str_info;
 
 	format = v4l2_subdev_state_get_format(state, pad, 0);
-
 	if (!format) {
-		dev_err(isp_subdev->dev, "fail to setup stream path\n");
+		dev_err(isp_subdev->dev, "fail to get v4l2 format\n");
 	} else {
 		memset(format, 0, sizeof(*format));
 		format->code = MEDIA_BUS_FMT_YUYV8_1_5X8;
 	}
 
-	str_info = &sensor_info->output_info;
-	str_info->start_status = ISP4SD_START_STATUS_NOT_START;
+	sensor_info->output_info.start_status = ISP4SD_START_STATUS_OFF;
 }
 
 static bool isp4sd_is_stream_running(struct isp4_subdev *isp_subdev)
@@ -396,7 +377,7 @@ static void isp4sd_reset_camera_info(struct isp4_subdev *isp_subdev,
 {
 	struct isp4sd_sensor_info *info  = &isp_subdev->sensor_info;
 
-	info->status = ISP4SD_START_STATUS_NOT_START;
+	info->status = ISP4SD_START_STATUS_OFF;
 	isp4sd_reset_stream_info(isp_subdev, state, pad);
 
 	info->start_stream_cmd_sent = false;
@@ -410,14 +391,12 @@ static int isp4sd_uninit_stream(struct isp4_subdev *isp_subdev,
 	bool running;
 
 	running = isp4sd_is_stream_running(isp_subdev);
-
 	if (running) {
 		dev_dbg(dev, "fail for stream is still running\n");
 		return -EINVAL;
 	}
 
 	isp4sd_reset_camera_info(isp_subdev, state, pad);
-
 	isp4if_clear_cmdq(ispif);
 	return 0;
 }
@@ -437,15 +416,11 @@ static void isp4sd_fw_resp_cmd_done(struct isp4_subdev *isp_subdev,
 		para->cmd_id, para->cmd_status, para->cmd_seq_num,
 		ele);
 
-	if (!ele)
-		return;
-
-	if (ele->cmd_complete) {
-		dev_dbg(dev, "signal cmd_complete %p\n", ele->cmd_complete);
-		complete(ele->cmd_complete);
+	if (ele) {
+		complete(&ele->cmd_done);
+		if (atomic_dec_and_test(&ele->refcnt))
+			kfree(ele);
 	}
-
-	kfree(ele);
 }
 
 static struct isp4fw_meta_info *isp4sd_get_meta_by_mc(struct isp4_subdev *isp_subdev,
@@ -463,36 +438,6 @@ static struct isp4fw_meta_info *isp4sd_get_meta_by_mc(struct isp4_subdev *isp_su
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
@@ -508,38 +453,33 @@ static void isp4sd_send_meta_info(struct isp4_subdev *isp_subdev,
 
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
@@ -548,24 +488,32 @@ static void isp4sd_fw_resp_frame_done(struct isp4_subdev *isp_subdev,
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
 
@@ -584,12 +532,20 @@ static void isp4sd_fw_resp_func(struct isp4_subdev *isp_subdev,
 		isp_fw_log_print(isp_subdev);
 
 	while (true) {
-		int ret;
-
-		ret = isp4if_f2h_resp(ispif, stream_id, &resp);
-		if (ret) {
-			enable_irq(isp_subdev->irq[stream_id]);
-			break;
+		if (isp4if_f2h_resp(ispif, stream_id, &resp)) {
+			/*
+			 * Re-enable the interrupt and then recheck to see if
+			 * there is a new response. To ensure that an in-flight
+			 * interrupt is not lost, enabling the interrupt must
+			 * occur _before_ checking for a new response, hence a
+			 * memory barrier is needed. Disable the interrupt again
+			 * if there was a new response.
+			 */
+			isp4_intr_enable(isp_subdev, stream_id, true);
+			mb();
+			if (likely(isp4if_f2h_resp(ispif, stream_id, &resp)))
+				break;
+			isp4_intr_enable(isp_subdev, stream_id, false);
 		}
 
 		switch (resp.resp_id) {
@@ -610,50 +566,42 @@ static void isp4sd_fw_resp_func(struct isp4_subdev *isp_subdev,
 	}
 }
 
-static s32 isp4sd_fw_resp_thread_wrapper(void *context)
+static s32 isp4sd_fw_resp_thread(void *context)
 {
 	struct isp4_subdev_thread_param *para = context;
-	struct isp4sd_thread_handler *thread_ctx;
-	enum isp4if_stream_id stream_id;
-
-	struct isp4_subdev *isp_subdev;
-	struct device *dev;
+	struct isp4_subdev *isp_subdev = para->isp_subdev;
+	struct isp4sd_thread_handler *thread_ctx =
+		&isp_subdev->fw_resp_thread[para->idx];
+	struct device *dev = isp_subdev->dev;
 
-	if (!para)
-		return -EINVAL;
+	dev_dbg(dev, "[%u] fw resp thread started\n", para->idx);
+	while (true) {
+		wait_event_interruptible(thread_ctx->waitq, thread_ctx->resp_ready);
+		thread_ctx->resp_ready = false;
 
-	isp_subdev = para->isp_subdev;
-	dev = isp_subdev->dev;
+		if (kthread_should_stop()) {
+			dev_dbg(dev, "[%u] fw resp thread quit\n", para->idx);
+			break;
+		}
 
-	switch (para->idx) {
-	case 0:
-		stream_id = ISP4IF_STREAM_ID_GLOBAL;
-		break;
-	case 1:
-		stream_id = ISP4IF_STREAM_ID_1;
-		break;
-	default:
-		dev_err(dev, "fail invalid %d\n", para->idx);
-		return -EINVAL;
+		isp4sd_fw_resp_func(isp_subdev, para->idx);
 	}
 
-	thread_ctx = &isp_subdev->fw_resp_thread[para->idx];
-
-	thread_ctx->wq_cond = 0;
-	init_waitqueue_head(&thread_ctx->waitq);
+	return 0;
+}
 
-	dev_dbg(dev, "[%u] started\n", para->idx);
+static int isp4sd_stop_resp_proc_threads(struct isp4_subdev *isp_subdev)
+{
+	int i;
 
-	while (true) {
-		wait_event_interruptible(thread_ctx->waitq, thread_ctx->wq_cond != 0);
-		thread_ctx->wq_cond = 0;
+	for (i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++) {
+		struct isp4sd_thread_handler *thread_ctx =
+				&isp_subdev->fw_resp_thread[i];
 
-		if (kthread_should_stop()) {
-			dev_dbg(dev, "[%u] quit\n", para->idx);
-			break;
+		if (thread_ctx->thread) {
+			kthread_stop(thread_ctx->thread);
+			thread_ctx->thread = NULL;
 		}
-
-		isp4sd_fw_resp_func(isp_subdev, stream_id);
 	}
 
 	return 0;
@@ -669,30 +617,17 @@ static int isp4sd_start_resp_proc_threads(struct isp4_subdev *isp_subdev)
 
 		isp_subdev->isp_resp_para[i].idx = i;
 		isp_subdev->isp_resp_para[i].isp_subdev = isp_subdev;
+		init_waitqueue_head(&thread_ctx->waitq);
+		thread_ctx->resp_ready = false;
 
-		thread_ctx->thread = kthread_run(isp4sd_fw_resp_thread_wrapper,
+		thread_ctx->thread = kthread_run(isp4sd_fw_resp_thread,
 						 &isp_subdev->isp_resp_para[i],
 						 isp4sd_thread_name[i]);
 		if (IS_ERR(thread_ctx->thread)) {
 			dev_err(dev, "create thread [%d] fail\n", i);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
-static int isp4sd_stop_resp_proc_threads(struct isp4_subdev *isp_subdev)
-{
-	int i;
-
-	for (i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++) {
-		struct isp4sd_thread_handler *thread_ctx =
-				&isp_subdev->fw_resp_thread[i];
-
-		if (thread_ctx->thread) {
-			kthread_stop(thread_ctx->thread);
 			thread_ctx->thread = NULL;
+			isp4sd_stop_resp_proc_threads(isp_subdev);
+			return -EINVAL;
 		}
 	}
 
@@ -712,11 +647,7 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
 		return -EINVAL;
 	}
 
-	sensor_info->status = ISP4SD_START_STATUS_NOT_START;
-	if (isp_subdev->sensor_info.status == ISP4SD_START_STATUS_STARTED) {
-		dev_dbg(dev, "no need power off isp_subdev\n");
-		return 0;
-	}
+	sensor_info->status = ISP4SD_START_STATUS_OFF;
 
 	for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
 		disable_irq(isp_subdev->irq[i]);
@@ -733,7 +664,7 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
 			perf_state, ret);
 
 	/* hold ccpu reset */
-	isp4hw_wreg(isp_subdev->mmio, ISP_SOFT_RESET, 0x0);
+	isp4hw_wreg(isp_subdev->mmio, ISP_SOFT_RESET, 0);
 	isp4hw_wreg(isp_subdev->mmio, ISP_POWER_STATUS, 0);
 	ret = pm_runtime_put_sync(dev);
 	if (ret)
@@ -778,7 +709,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev *isp_subdev)
 		if (ret) {
 			dev_err(dev, "fail to power on isp_subdev ret %d\n",
 				ret);
-			goto err_unlock_and_close;
+			goto err_deinit;
 		}
 
 		/* ISPPG ISP Power Status */
@@ -788,7 +719,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev *isp_subdev)
 			dev_err(dev,
 				"fail to set performance state %u, ret %d\n",
 				perf_state, ret);
-			goto err_unlock_and_close;
+			goto err_deinit;
 		}
 
 		ispif->status = ISP4IF_STATUS_PWR_ON;
@@ -800,21 +731,20 @@ static int isp4sd_pwron_and_init(struct isp4_subdev *isp_subdev)
 	ret = isp4if_start(ispif);
 	if (ret) {
 		dev_err(dev, "fail to start isp_subdev interface\n");
-		goto err_unlock_and_close;
+		goto err_deinit;
 	}
 
 	if (isp4sd_start_resp_proc_threads(isp_subdev)) {
 		dev_err(dev, "isp_start_resp_proc_threads fail");
-		goto err_unlock_and_close;
-	} else {
-		dev_dbg(dev, "create resp threads ok");
+		goto err_deinit;
 	}
+	dev_dbg(dev, "create resp threads ok");
 
 	for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
 		enable_irq(isp_subdev->irq[i]);
 
 	return 0;
-err_unlock_and_close:
+err_deinit:
 	isp4sd_pwroff_and_deinit(isp_subdev);
 	return -EINVAL;
 }
@@ -828,28 +758,29 @@ static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
 	struct device *dev = isp_subdev->dev;
 	int ret = 0;
 
-	dev_dbg(dev, "status %i\n", output_info->start_status);
 	guard(mutex)(&isp_subdev->ops_mutex);
+	dev_dbg(dev, "status %i\n", output_info->start_status);
 
 	if (output_info->start_status == ISP4SD_START_STATUS_STARTED) {
 		struct isp4fw_cmd_enable_out_ch cmd_ch_disable;
 
+		/*
+		 * The struct will be shared with ISP FW, use memset() to guarantee
+		 * padding bits are zeroed, since this is not guaranteed on all compilers.
+		 */
+		memset(&cmd_ch_disable, 0, sizeof(cmd_ch_disable));
 		cmd_ch_disable.ch = ISP_PIPE_OUT_CH_PREVIEW;
-		cmd_ch_disable.is_enable = false;
-		ret = isp4if_send_command_sync(ispif,
-					       CMD_ID_ENABLE_OUT_CHAN,
+		/* `cmd_ch_disable.is_enable` is already false */
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
@@ -858,7 +789,7 @@ static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
 
 	isp4if_clear_bufq(ispif);
 
-	output_info->start_status = ISP4SD_START_STATUS_NOT_START;
+	output_info->start_status = ISP4SD_START_STATUS_OFF;
 	isp4sd_reset_stream_info(isp_subdev, state, pad);
 
 	isp4sd_uninit_stream(isp_subdev, state, pad);
@@ -882,39 +813,33 @@ static int isp4sd_start_stream(struct isp4_subdev *isp_subdev,
 		return -EINVAL;
 	}
 
-	ret = isp4sd_init_stream(isp_subdev);
+	switch (output_info->start_status) {
+	case ISP4SD_START_STATUS_OFF:
+		break;
+	case ISP4SD_START_STATUS_STARTED:
+		dev_dbg(dev, "stream already started, do nothing\n");
+		return 0;
+	case ISP4SD_START_STATUS_START_FAIL:
+		dev_err(dev, "stream previously failed to start\n");
+		return -EINVAL;
+	}
 
+	ret = isp4sd_init_stream(isp_subdev);
 	if (ret) {
 		dev_err(dev, "fail to init isp_subdev stream\n");
-		ret = -EINVAL;
-		goto unlock_and_check_ret;
+		goto err_stop_stream;
 	}
 
-	if (output_info->start_status == ISP4SD_START_STATUS_STARTED) {
-		ret = 0;
-		dev_dbg(dev, "stream started, do nothing\n");
-		goto unlock_and_check_ret;
-	} else if (output_info->start_status ==
-		   ISP4SD_START_STATUS_START_FAIL) {
-		ret = -EINVAL;
-		dev_err(dev, "stream  fail to start before\n");
-		goto unlock_and_check_ret;
-	}
-
-	if (isp4sd_setup_output(isp_subdev, state, pad)) {
+	ret = isp4sd_setup_output(isp_subdev, state, pad);
+	if (ret) {
 		dev_err(dev, "fail to setup output\n");
-		ret = -EINVAL;
-	} else {
-		ret = 0;
-		dev_dbg(dev, "suc to setup out\n");
+		goto err_stop_stream;
 	}
 
-unlock_and_check_ret:
-	if (ret) {
-		isp4sd_stop_stream(isp_subdev, state, pad);
-		dev_err(dev, "start stream fail\n");
-	}
+	return 0;
 
+err_stop_stream:
+	isp4sd_stop_stream(isp_subdev, state, pad);
 	return ret;
 }
 
@@ -975,7 +900,6 @@ static int isp4sd_ioc_send_img_buf(struct v4l2_subdev *sd,
 
 error_release_buf_node:
 	isp4if_dealloc_buffer_node(buf_node);
-
 	return ret;
 }
 
@@ -1125,7 +1049,7 @@ int isp4sd_init(struct isp4_subdev *isp_subdev, struct v4l2_device *v4l2_dev,
 
 	mutex_init(&isp_subdev->ops_mutex);
 	sensor_info->start_stream_cmd_sent = false;
-	sensor_info->status = ISP4SD_START_STATUS_NOT_START;
+	sensor_info->status = ISP4SD_START_STATUS_OFF;
 
 	/* create ISP enable gpio control */
 	isp_subdev->enable_gpio = devm_gpiod_get(isp_subdev->dev,
diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.h b/drivers/media/platform/amd/isp4/isp4_subdev.h
index 32a5f888a16d..ab3fdb855242 100644
--- a/drivers/media/platform/amd/isp4/isp4_subdev.h
+++ b/drivers/media/platform/amd/isp4/isp4_subdev.h
@@ -46,7 +46,7 @@ enum isp4sd_status {
 
 /* used to indicate the status of sensor, output stream */
 enum isp4sd_start_status {
-	ISP4SD_START_STATUS_NOT_START,
+	ISP4SD_START_STATUS_OFF,
 	ISP4SD_START_STATUS_STARTED,
 	ISP4SD_START_STATUS_START_FAIL,
 };
@@ -83,7 +83,7 @@ struct isp4sd_sensor_info {
 struct isp4sd_thread_handler {
 	struct task_struct *thread;
 	wait_queue_head_t waitq;
-	int wq_cond;
+	bool resp_ready;
 };
 
 struct isp4_subdev_thread_param {
@@ -114,6 +114,7 @@ struct isp4_subdev {
 	void __iomem *mmio;
 	struct isp4_subdev_thread_param isp_resp_para[ISP4SD_MAX_FW_RESP_STREAM_NUM];
 	int irq[ISP4SD_MAX_FW_RESP_STREAM_NUM];
+	spinlock_t irq_lock;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dir;
 	bool enable_fw_log;
diff --git a/drivers/media/platform/amd/isp4/isp4_video.c b/drivers/media/platform/amd/isp4/isp4_video.c
index 456435f6e771..c435f7c4a417 100644
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
@@ -661,7 +641,7 @@ static int isp4vid_set_fmt_2_isp(struct v4l2_subdev *sdev, struct v4l2_pix_forma
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 	fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
 	fmt.pad = ISP4VID_PAD_VIDEO_OUTPUT;
 	fmt.format.width = pix_fmt->width;
@@ -853,7 +833,7 @@ static unsigned int isp4vid_get_image_size(struct v4l2_pix_format *fmt)
 	default:
 		return 0;
 	}
-};
+}
 
 static int isp4vid_qops_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 				    unsigned int *nplanes, unsigned int sizes[],
@@ -867,7 +847,7 @@ static int isp4vid_qops_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers
 			"fail to setup queue, no mplane supported %u\n",
 			*nplanes);
 		return -EINVAL;
-	};
+	}
 
 	if (*nplanes == 1) {
 		unsigned int size;
@@ -966,8 +946,8 @@ static void isp4vid_qops_buffer_queue(struct vb2_buffer *vb)
 	if (isp_vdev->stream_started)
 		isp_vdev->ops->send_buffer(isp_vdev->isp_sdev, img_buf);
 
-	guard(mutex)(&isp_vdev->buf_list_lock);
-	list_add_tail(&buf->list, &isp_vdev->buf_list);
+	scoped_guard(mutex, &isp_vdev->buf_list_lock)
+		list_add_tail(&buf->list, &isp_vdev->buf_list);
 }
 
 static int isp4vid_qops_start_streaming(struct vb2_queue *vq, unsigned int count)
@@ -1007,10 +987,8 @@ static int isp4vid_qops_start_streaming(struct vb2_queue *vq, unsigned int count
 		}
 	}
 
-	list_for_each_entry(isp4vid_buf, &isp_vdev->buf_list, list) {
-		isp_vdev->ops->send_buffer(isp_vdev->isp_sdev,
-					   &isp4vid_buf->img_buf);
-	}
+	list_for_each_entry(isp4vid_buf, &isp_vdev->buf_list, list)
+		isp_vdev->ops->send_buffer(isp_vdev->isp_sdev, &isp4vid_buf->img_buf);
 
 	/* Start the media pipeline */
 	ret = video_device_pipeline_start(&isp_vdev->vdev, &isp_vdev->pipe);
@@ -1162,12 +1140,13 @@ int isp4vid_dev_init(struct isp4vid_dev *isp_vdev, struct v4l2_subdev *isp_sdev,
 	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (ret) {
 		dev_err(v4l2_dev->dev, "register video device fail:%d\n", ret);
-		media_entity_cleanup(&isp_vdev->vdev.entity);
-		goto err_release_vb2_queue;
+		goto err_entity_cleanup;
 	}
 
 	return 0;
 
+err_entity_cleanup:
+	media_entity_cleanup(&isp_vdev->vdev.entity);
 err_release_vb2_queue:
 	vb2_queue_release(q);
 	return ret;
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


--rnS6dzQWgB30Ue73--

