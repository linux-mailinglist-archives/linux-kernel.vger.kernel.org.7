Return-Path: <linux-kernel+bounces-867065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D583C017D4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1551507089
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69EB2EBDD7;
	Thu, 23 Oct 2025 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="d6OCRYzx"
Received: from smtp64.ord1d.emailsrvr.com (smtp64.ord1d.emailsrvr.com [184.106.54.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D214E329C54
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226607; cv=none; b=WkKRc48d/uzxyzCmVoBA2UH7jl3jEpDwPMNB+j3kUX0p4OMbJweT1TLKOB3dtYOaG76g9rpOVCMDrNf2KSfhQuIeapAz5brnGYWZfJZxrlQPv7gDIeR1ocEcZSOYV7iIcSBWiKzg2/ShSYO20ppztonp3ZVJCvZ6wDtWjYXeWZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226607; c=relaxed/simple;
	bh=y5IaZwnAwDnImYBuI3AiQn7FHODEcM2jojuv0AzXxvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbL+uUvzIuHINE+dtQymEjYwlCXmwJBYhnHwZoVahdLajq1oGqHMFNUrRXDVi7D4ZxxaZdIWbcnTf+h504IVvyRL2EKG0w4Tu3Vh87ntVku45plTZFCBZ81V3nd1AjDk67UHLVjjsmBjcO1jjQPni+ogqoLvYcKcG+xxPZLNkDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=d6OCRYzx; arc=none smtp.client-ip=184.106.54.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761226057;
	bh=y5IaZwnAwDnImYBuI3AiQn7FHODEcM2jojuv0AzXxvE=;
	h=From:To:Subject:Date:From;
	b=d6OCRYzxvhKzmScoEDwvHL4FbAk7Ir5Pfd7DOpyNtI9YgqMadrgFESn6zlQUqNeiT
	 4aDEb73+XQCzuqgN/2+QDyE8xlxw/cKS4KmWuY9dEHZuGYg8HPgX0IMRj6C+qQulVU
	 ANhwtOFFwuq8iK27SumaoUVeO4oOlpbr1KlTjlBo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 51773402A9;
	Thu, 23 Oct 2025 09:27:36 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 1/2] comedi: Add reference counting for Comedi command handling
Date: Thu, 23 Oct 2025 14:06:45 +0100
Message-ID: <20251023132706.7983-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023132706.7983-1-abbotti@mev.co.uk>
References: <20251023132706.7983-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: a5f18e55-3fae-4f0c-8e4d-f1649ff649d1-2-1

For interrupts from badly behaved hardware (as emulated by Syzbot), it
is possible for the Comedi core functions that manage the progress of
asynchronous data acquisition to be called from driver ISRs while no
asynchronous command has been set up, which can cause problems such as
invalid pointer dereferencing or dividing by zero.

To help protect against that, introduce new functions to maintain a
reference counter for asynchronous commands that are being set up.
`comedi_get_is_subdevice_running(s)` will check if a command has been
set up on a subdevice and is still marked as running, and if so will
increment the reference counter and return `true`, otherwise it will
return `false` without modifying the reference counter.
`comedi_put_is_subdevice_running(s)` will decrement the reference
counter and set a completion event when decremented to 0.

Change the `do_cmd_ioctl()` function (responsible for setting up the
asynchronous command) to  reinitialize the completion event and set the
reference counter to 1 before it marks the subdevice as running.  Change
the `do_become_nonbusy()` function (responsible for destroying a
completed command) to call `comedi_put_is_subdevice_running(s)` and wait
for the completion event after marking the subdevice as not running.

Because the subdevice normally gets marked as not running before the
call to `do_become_nonbusy()` (and may also be called when the Comedi
device is being detached from the low-level driver), add a new flag
`COMEDI_SRF_BUSY` to the set of subdevice run-flags that indicates that
an asynchronous command was set up and will need to be destroyed.  This
flag is set by `do_cmd_ioctl()` and cleared and checked by
`do_become_nonbusy()`.

Subsequent patches will change the Comedi core functions that are called
from low-level drivers for asynchrous command handling to make use of
the `comedi_get_is_subdevice_running()` and
`comedi_put_is_subdevice_running()` functions, and will modify the ISRs
of some of these low-level drivers if they dereference the subdevice's
`async` pointer directly.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/comedi_fops.c     | 78 ++++++++++++++++++++++++++++----
 drivers/comedi/drivers.c         |  1 +
 include/linux/comedi/comedidev.h |  7 +++
 3 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 7e2f2b1a1c36..595723e24c74 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -38,6 +38,7 @@
  * COMEDI_SRF_ERROR:		indicates an COMEDI_CB_ERROR event has occurred
  *				since the last command was started
  * COMEDI_SRF_RUNNING:		command is running
+ * COMEDI_SRF_BUSY:		command was started and subdevice still busy
  * COMEDI_SRF_FREE_SPRIV:	free s->private on detach
  *
  * COMEDI_SRF_BUSY_MASK:	runflags that indicate the subdevice is "busy"
@@ -45,9 +46,11 @@
 #define COMEDI_SRF_RT		BIT(1)
 #define COMEDI_SRF_ERROR	BIT(2)
 #define COMEDI_SRF_RUNNING	BIT(27)
+#define COMEDI_SRF_BUSY		BIT(28)
 #define COMEDI_SRF_FREE_SPRIV	BIT(31)
 
-#define COMEDI_SRF_BUSY_MASK	(COMEDI_SRF_ERROR | COMEDI_SRF_RUNNING)
+#define COMEDI_SRF_BUSY_MASK	\
+	(COMEDI_SRF_ERROR | COMEDI_SRF_RUNNING | COMEDI_SRF_BUSY)
 
 /**
  * struct comedi_file - Per-file private data for COMEDI device
@@ -665,6 +668,11 @@ static bool comedi_is_runflags_in_error(unsigned int runflags)
 	return runflags & COMEDI_SRF_ERROR;
 }
 
+static bool comedi_is_runflags_busy(unsigned int runflags)
+{
+	return runflags & COMEDI_SRF_BUSY;
+}
+
 /**
  * comedi_is_subdevice_running() - Check if async command running on subdevice
  * @s: COMEDI subdevice.
@@ -687,6 +695,46 @@ static bool __comedi_is_subdevice_running(struct comedi_subdevice *s)
 	return comedi_is_runflags_running(runflags);
 }
 
+/**
+ * comedi_get_is_subdevice_running() - Get if async command running on subdevice
+ * @s: COMEDI subdevice.
+ *
+ * If an asynchronous COMEDI command is running on the subdevice, increment
+ * a reference counter.  If the function return value indicates that a
+ * command is running, then the details of the command will not be destroyed
+ * before a matching call to comedi_put_is_subdevice_running().
+ *
+ * Return: %true if an asynchronous COMEDI command is active on the
+ * subdevice, else %false.
+ */
+bool comedi_get_is_subdevice_running(struct comedi_subdevice *s)
+{
+	unsigned long flags;
+	bool running;
+
+	spin_lock_irqsave(&s->spin_lock, flags);
+	running = __comedi_is_subdevice_running(s);
+	if (running)
+		refcount_inc(&s->async->run_active);
+	spin_unlock_irqrestore(&s->spin_lock, flags);
+	return running;
+}
+EXPORT_SYMBOL_GPL(comedi_get_is_subdevice_running);
+
+/**
+ * comedi_put_is_subdevice_running() - Put if async command running on subdevice
+ * @s: COMEDI subdevice.
+ *
+ * Decrements the reference counter that was incremented when
+ * comedi_get_is_subdevice_running() returned %true.
+ */
+void comedi_put_is_subdevice_running(struct comedi_subdevice *s)
+{
+	if (refcount_dec_and_test(&s->async->run_active))
+		complete_all(&s->async->run_complete);
+}
+EXPORT_SYMBOL_GPL(comedi_put_is_subdevice_running);
+
 bool comedi_can_auto_free_spriv(struct comedi_subdevice *s)
 {
 	unsigned int runflags = __comedi_get_subdevice_runflags(s);
@@ -736,20 +784,28 @@ static void do_become_nonbusy(struct comedi_device *dev,
 			      struct comedi_subdevice *s)
 {
 	struct comedi_async *async = s->async;
+	unsigned int runflags;
+	unsigned long flags;
 
 	lockdep_assert_held(&dev->mutex);
-	comedi_update_subdevice_runflags(s, COMEDI_SRF_RUNNING, 0);
-	if (async) {
+	spin_lock_irqsave(&s->spin_lock, flags);
+	runflags = __comedi_get_subdevice_runflags(s);
+	__comedi_clear_subdevice_runflags(s, COMEDI_SRF_RUNNING |
+					     COMEDI_SRF_BUSY);
+	spin_unlock_irqrestore(&s->spin_lock, flags);
+	if (comedi_is_runflags_busy(runflags)) {
+		/*
+		 * "Run active" counter was set to 1 when setting up the
+		 * command.  Decrement it and wait for it to become 0.
+		 */
+		comedi_put_is_subdevice_running(s);
+		wait_for_completion(&async->run_complete);
 		comedi_buf_reset(s);
 		async->inttrig = NULL;
 		kfree(async->cmd.chanlist);
 		async->cmd.chanlist = NULL;
 		s->busy = NULL;
 		wake_up_interruptible_all(&async->wait_head);
-	} else {
-		dev_err(dev->class_dev,
-			"BUG: (?) %s called with async=NULL\n", __func__);
-		s->busy = NULL;
 	}
 }
 
@@ -1860,8 +1916,14 @@ static int do_cmd_ioctl(struct comedi_device *dev,
 	if (async->cmd.flags & CMDF_WAKE_EOS)
 		async->cb_mask |= COMEDI_CB_EOS;
 
+	/*
+	 * Set the "run active" counter with an initial count of 1 that will
+	 * complete the "safe to reset" event when it is decremented to 0.
+	 */
+	refcount_set(&s->async->run_active, 1);
+	reinit_completion(&s->async->run_complete);
 	comedi_update_subdevice_runflags(s, COMEDI_SRF_BUSY_MASK,
-					 COMEDI_SRF_RUNNING);
+					 COMEDI_SRF_RUNNING | COMEDI_SRF_BUSY);
 
 	/*
 	 * Set s->busy _after_ setting COMEDI_SRF_RUNNING flag to avoid
diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index c9ebaadc5e82..fd6e6cbe47ad 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -677,6 +677,7 @@ static int __comedi_device_postconfig_async(struct comedi_device *dev,
 		return -ENOMEM;
 
 	init_waitqueue_head(&async->wait_head);
+	init_completion(&async->run_complete);
 	s->async = async;
 
 	async->max_bufsize = comedi_default_buf_maxsize_kb * 1024;
diff --git a/include/linux/comedi/comedidev.h b/include/linux/comedi/comedidev.h
index 4cb0400ad616..35fdc41845ce 100644
--- a/include/linux/comedi/comedidev.h
+++ b/include/linux/comedi/comedidev.h
@@ -15,6 +15,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/rwsem.h>
 #include <linux/kref.h>
+#include <linux/completion.h>
 #include <linux/comedi.h>
 
 #define COMEDI_VERSION(a, b, c) (((a) << 16) + ((b) << 8) + (c))
@@ -272,6 +273,8 @@ struct comedi_buf_map {
  * @events: Bit-vector of events that have occurred.
  * @cmd: Details of comedi command in progress.
  * @wait_head: Task wait queue for file reader or writer.
+ * @run_complete: "run complete" completion event.
+ * @run_active: "run active" reference counter.
  * @cb_mask: Bit-vector of events that should wake waiting tasks.
  * @inttrig: Software trigger function for command, or NULL.
  *
@@ -357,6 +360,8 @@ struct comedi_async {
 	unsigned int events;
 	struct comedi_cmd cmd;
 	wait_queue_head_t wait_head;
+	struct completion run_complete;
+	refcount_t run_active;
 	unsigned int cb_mask;
 	int (*inttrig)(struct comedi_device *dev, struct comedi_subdevice *s,
 		       unsigned int x);
@@ -584,6 +589,8 @@ struct comedi_device *comedi_dev_get_from_minor(unsigned int minor);
 int comedi_dev_put(struct comedi_device *dev);
 
 bool comedi_is_subdevice_running(struct comedi_subdevice *s);
+bool comedi_get_is_subdevice_running(struct comedi_subdevice *s);
+void comedi_put_is_subdevice_running(struct comedi_subdevice *s);
 
 void *comedi_alloc_spriv(struct comedi_subdevice *s, size_t size);
 void comedi_set_spriv_auto_free(struct comedi_subdevice *s);
-- 
2.51.0


