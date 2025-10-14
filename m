Return-Path: <linux-kernel+bounces-852149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99258BD8495
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33EA424A27
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551582E2DCD;
	Tue, 14 Oct 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWEAtvBK"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741232DA760
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431923; cv=none; b=rbl6RGzuQEDy9sStXeQHXjcWkrIEA0J6B5S4zYEpB+fyWZla5b3dZ5W80LBleOClCrCb0iv9dhCXAclh2YR8zzbQZ1G7KM74pIUQy6RccXzQrsRn0MEzr8bHgfNv3u3VNnaQrc+n1cxmtdbCOYzQm4lKGuym3JPqAQR2sbuI2qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431923; c=relaxed/simple;
	bh=PxY9YI4CSmdKhC6uoizpHkfwmH3aq/ev/ew2lUtOZuE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h7EhDKxI4dLopmm3oL9HOB6tWSu/ra9RUEJIwgDiW+tCUSHeRT3LDNc8JBQ3T1weI4tqrP5ut7fQ+OkwPjAhvUeftWaTnL+444H5iD7u/TckSz38TMDdRmEXlxHnn4frxywlzt4iOYVsw1kWoomRGVmFEBcTQarnsLLRJGbmgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HWEAtvBK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5533921eb2so7128499a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760431921; x=1761036721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bX12dqdVlICTMSRoW5hHUvlBwoKcGr52PuS1MGrj6wY=;
        b=HWEAtvBKRJzCwsZpxc8cEQk4D5VsMXPcLM6KNQ74Er9O9GSI9uCAPLdY0IFN32YzFr
         4ghCsTFcxdncomvoRBPcGxPgrpAxhcYmthssDlwVRkRhuGGl0pOB/PjpV5+059WmgM0l
         XnygJbTwelO3cFA2qZm31JaY1xtQZ4AE+raeDVDePw+3tmatL5XZ3Wnd7BbfeuIxkziY
         hD8PfvnZhspoD5uN9OOGj800lNtSVkOuu0LBnlWJJQKuhpRt4AUVO8d7R8V1cCHClspH
         dg2Jj6clC5R2wOtWwAUFTw7Z/MycARw6arxWyl+1palnv4xpGUMmuwvFBYjn90fuz+KR
         EmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760431921; x=1761036721;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bX12dqdVlICTMSRoW5hHUvlBwoKcGr52PuS1MGrj6wY=;
        b=jxD2p9Ia32SWOJIvRxEXWcDy9atuq0yByfj2bsK+SYMPBZEL9fOaEu/mM9CfTzNDff
         9p58bU+LiOPbirhC7BW5PUDXvKdPH7npqQqpAd5i1SXpJVwOmrSHG4mYozevEiz0XX7J
         ksIl4NQnT88ZhOIt15NSGG7VUP8GEeac3kuYFhSZ/WlcPswqCSU8rV8/uBF+u8/YmX8J
         w0P2ooSYCKVfDLxarlU75vGEYgP21EHlHwG8uIkQR1ASIENkvsJ9ATWH17XUpGdqPDsW
         9EPMU1H3WRdjeW18BEHO8UNLWaosWPO5KpPtiAv4fIvqlOCbysCrXoHOOwN1JJ7F0vA8
         Q7AA==
X-Forwarded-Encrypted: i=1; AJvYcCWp6PDhKsisgNxOCqV5Imyusatc8BzI7J6yThBGvTLWoVO4FThuSHb5Eid7qX0tw71qiNFHcR6TXA7YK1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOCWUO6xfo2EK6y81Xy4WXA9OIw4Pmx6L/zUrKNVTt6PASKhMr
	mXM8PqbaifH7asrZtMuO7pmGDqWZ41eK7m6in1bOPpiNfD3atPIsX/JK5JWRoGeXFVMOjtaYE0C
	1EAdwiA==
X-Google-Smtp-Source: AGHT+IG+Fi46f+lO8zssLsTmLd69T+nbCbw1cECTScqiKJBBv7O5leY+nhhN6mss+yBFIX4Zx7GK1+Ok9KU=
X-Received: from plbka8.prod.google.com ([2002:a17:903:3348:b0:290:28e2:ce54])
 (user=hhhuuu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f0e:b0:248:a642:eec6
 with SMTP id d9443c01a7336-29027402f2dmr259664015ad.50.1760431920649; Tue, 14
 Oct 2025 01:52:00 -0700 (PDT)
Date: Tue, 14 Oct 2025 08:51:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Message-ID: <20251014085156.2651449-1-hhhuuu@google.com>
Subject: [PATCH v2] usb: gadget: udc: fix race condition in usb_del_gadget
From: Jimmy Hu <hhhuuu@google.com>
To: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc: badhri@google.com, hhhuuu@google.com, stern@rowland.harvard.edu, 
	royluo@google.com, Thinh.Nguyen@synopsys.com, balbi@ti.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A race condition during gadget teardown can lead to a use-after-free
in usb_gadget_state_work(), as reported by KASAN:

  BUG: KASAN: invalid-access in sysfs_notify+0_x_2c/0_x_d0
  Workqueue: events usb_gadget_state_work

The fundamental race occurs because a concurrent event (e.g., an
interrupt) can call usb_gadget_set_state() and schedule gadget->work
at any time during the cleanup process in usb_del_gadget().

Commit 399a45e5237c ("usb: gadget: core: flush gadget workqueue after
device removal") attempted to fix this by moving flush_work() to after
device_del(). However, this does not fully solve the race, as a new
work item can still be scheduled *after* flush_work() completes but
before the gadget's memory is freed, leading to the same use-after-free.

This patch fixes the race condition robustly by introducing a 'teardown'
flag and a 'state_lock' spinlock to the usb_gadget struct. The flag is
set during cleanup in usb_del_gadget() *before* calling flush_work() to
prevent any new work from being scheduled once cleanup has commenced.
The scheduling site, usb_gadget_set_state(), now checks this flag under
the lock before queueing the work, thus safely closing the race window.

Changes in v2:
  - Removed redundant inline comments as suggested by Alan Stern.

Fixes: 5702f75375aa9 ("usb: gadget: udc-core: move sysfs_notify() to a workqueue")
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
Cc: stable@vger.kernel.org
---
 drivers/usb/gadget/udc/core.c | 17 ++++++++++++++++-
 include/linux/usb/gadget.h    |  5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d709e24c1fd4..66d2428835da 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1123,8 +1123,13 @@ static void usb_gadget_state_work(struct work_struct *work)
 void usb_gadget_set_state(struct usb_gadget *gadget,
 		enum usb_device_state state)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&gadget->state_lock, flags);
 	gadget->state = state;
-	schedule_work(&gadget->work);
+	if (!gadget->teardown)
+		schedule_work(&gadget->work);
+	spin_unlock_irqrestore(&gadget->state_lock, flags);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
@@ -1357,6 +1362,8 @@ static void usb_udc_nop_release(struct device *dev)
 void usb_initialize_gadget(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
 {
+	spin_lock_init(&gadget->state_lock);
+	gadget->teardown = false;
 	INIT_WORK(&gadget->work, usb_gadget_state_work);
 	gadget->dev.parent = parent;
 
@@ -1531,6 +1538,7 @@ EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
 void usb_del_gadget(struct usb_gadget *gadget)
 {
 	struct usb_udc *udc = gadget->udc;
+	unsigned long flags;
 
 	if (!udc)
 		return;
@@ -1544,6 +1552,13 @@ void usb_del_gadget(struct usb_gadget *gadget)
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	sysfs_remove_link(&udc->dev.kobj, "gadget");
 	device_del(&gadget->dev);
+	/*
+	 * Set the teardown flag before flushing the work to prevent new work
+	 * from being scheduled while we are cleaning up.
+	 */
+	spin_lock_irqsave(&gadget->state_lock, flags);
+	gadget->teardown = true;
+	spin_unlock_irqrestore(&gadget->state_lock, flags);
 	flush_work(&gadget->work);
 	ida_free(&gadget_id_numbers, gadget->id_number);
 	cancel_work_sync(&udc->vbus_work);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 0f28c5512fcb..8b5e593f7966 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -351,6 +351,9 @@ struct usb_gadget_ops {
  *	can handle. The UDC must support this and all slower speeds and lower
  *	number of lanes.
  * @state: the state we are now (attached, suspended, configured, etc)
+ * @state_lock: Spinlock protecting the `state` and `teardown` members.
+ * @teardown: True if the device is undergoing teardown, used to prevent
+ *	new work from being scheduled during cleanup.
  * @name: Identifies the controller hardware type.  Used in diagnostics
  *	and sometimes configuration.
  * @dev: Driver model state for this abstract device.
@@ -426,6 +429,8 @@ struct usb_gadget {
 	enum usb_ssp_rate		max_ssp_rate;
 
 	enum usb_device_state		state;
+	spinlock_t			state_lock;
+	bool				teardown;
 	const char			*name;
 	struct device			dev;
 	unsigned			isoch_delay;
-- 
2.51.0.760.g7b8bcc2412-goog


