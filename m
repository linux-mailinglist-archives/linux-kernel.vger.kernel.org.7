Return-Path: <linux-kernel+bounces-872091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FA2C0F3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 599754F8406
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37473115A2;
	Mon, 27 Oct 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="BykgYhuK"
Received: from smtp117.iad3a.emailsrvr.com (smtp117.iad3a.emailsrvr.com [173.203.187.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01C230ACEC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581809; cv=none; b=dUqIXv7tGwFJHhRjcNck+PJHMxKf2alR9NQQtKy8nH5B6n9J/Ns7UlyMPIdcKu1UqaFmofYCvPADEgItURVp1+8jz51LQvXThEZ6T+r1k4g4cs+ztrwTg72qpgELnz9ihBApm6yTv9wdNb4JOsh9K5OiLnpjsHDCAwZu48wIxno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581809; c=relaxed/simple;
	bh=ePRI/MSMfRnhEdeSQJddeCnuTYSx2BlvJAQXxM92f1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc7x8Pnnwsu84nrVOIHn0V1MdE6Z8PmEc6kFw8bnCxBvifWQMiiDGQQ3HQ/qaYmVVIPukN93PUkX47v150InXZ3HoysO1CVLMtDK5taV9GnSNCDMqYZn5dCdpOsoYPtnCiDu0gudYRmJamIqJDfNhswRkVdnmI+NoyKGqPfQfBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=BykgYhuK; arc=none smtp.client-ip=173.203.187.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761579481;
	bh=ePRI/MSMfRnhEdeSQJddeCnuTYSx2BlvJAQXxM92f1M=;
	h=From:To:Subject:Date:From;
	b=BykgYhuKWsyVW60WByfm1Xi9B2wWmTkIw8KYuqiZu1ZKagzGc06vPkiVDx8M5Sovq
	 NNBbx+THJyaqwoEuxUae1+vqGV9V6WtfRcWc41Efm6fWIrBoBVxa0rdbb2oZnhWfOg
	 FOjEDdnkiwygl9JIBK/BeQUEKspCUoChkFmG2d5U=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id A57FC2535F;
	Mon, 27 Oct 2025 11:38:00 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH 1/2] comedi: kcomedilib: Add loop checking variants of open and close
Date: Mon, 27 Oct 2025 15:25:02 +0000
Message-ID: <20251027153748.4569-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027153748.4569-1-abbotti@mev.co.uk>
References: <20251027153748.4569-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 91387a8e-76e7-4b89-824f-f1251498570e-2-1

Add `comedi_open_from(path, from)` and `comedi_close_from(dev, from)` as
variants of the existing `comedi_from(path)` and `comedi_close(dev)`.
The additional `from` parameter is a minor device number that tells the
function that the COMEDI device is being opened or closed from another
COMEDI device if the value is in the range [0,
`COMEDI_NUM_BOARD_MINORS`-1].  In that case the function will refuse to
open the device if it would lead to a chain of devices opening each
other.  (It will also impose a limit on the number of simultaneous opens
from one device to another because we need to count those.)

The new functions are intended to be used by the "comedi_bond" driver,
which is the only driver that uses the existing `comedi_open()` and
`comedi_close()` functions.  The new functions will be used to avoid
some possible deadlock situations.

Replace the existing, exported `comedi_open()` and `comedi_close()`
functions with inline wrapper functions that call the newly exported
`comedi_open_from()` and `comedi_close_from()` functions.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/kcomedilib/kcomedilib_main.c | 120 +++++++++++++++++++-
 include/linux/comedi/comedilib.h            |  34 +++++-
 2 files changed, 147 insertions(+), 7 deletions(-)

diff --git a/drivers/comedi/kcomedilib/kcomedilib_main.c b/drivers/comedi/kcomedilib/kcomedilib_main.c
index 43fbe1a63b14..baa9eaaf97d4 100644
--- a/drivers/comedi/kcomedilib/kcomedilib_main.c
+++ b/drivers/comedi/kcomedilib/kcomedilib_main.c
@@ -15,6 +15,7 @@
 #include <linux/fcntl.h>
 #include <linux/mm.h>
 #include <linux/io.h>
+#include <linux/bitmap.h>
 
 #include <linux/comedi.h>
 #include <linux/comedi/comedidev.h>
@@ -24,7 +25,104 @@ MODULE_AUTHOR("David Schleef <ds@schleef.org>");
 MODULE_DESCRIPTION("Comedi kernel library");
 MODULE_LICENSE("GPL");
 
-struct comedi_device *comedi_open(const char *filename)
+static DEFINE_MUTEX(kcomedilib_to_from_lock);
+
+/*
+ * Row index is the "to" node, column index is the "from" node, element value
+ * is the number of links from the "from" node to the "to" node.
+ */
+static unsigned char
+	kcomedilib_to_from[COMEDI_NUM_BOARD_MINORS][COMEDI_NUM_BOARD_MINORS];
+
+static bool kcomedilib_set_link_from_to(unsigned int from, unsigned int to)
+{
+	DECLARE_BITMAP(destinations[2], COMEDI_NUM_BOARD_MINORS);
+	unsigned int cur = 0;
+	bool okay = true;
+
+	/*
+	 * Allow "from" node to be out of range (no loop checking),
+	 * but require "to" node to be in range.
+	 */
+	if (to >= COMEDI_NUM_BOARD_MINORS)
+		return false;
+	if (from >= COMEDI_NUM_BOARD_MINORS)
+		return true;
+
+	/*
+	 * Check that kcomedilib_to_from[to][from] can be made non-zero
+	 * without creating a loop.
+	 *
+	 * Termination of the loop-testing code relies on the assumption that
+	 * kcomedilib_to_from[][] does not contain any loops.
+	 *
+	 * Start with a set destinations set containing "from" as the only
+	 * element and work backwards looking for loops.
+	 */
+	bitmap_zero(destinations[cur], COMEDI_NUM_BOARD_MINORS);
+	set_bit(from, destinations[cur]);
+	mutex_lock(&kcomedilib_to_from_lock);
+	do {
+		unsigned int next = 1 - cur;
+		unsigned int t = 0;
+
+		if (test_bit(to, destinations[cur])) {
+			/* Loop detected. */
+			okay = false;
+			break;
+		}
+		/* Create next set of destinations. */
+		bitmap_zero(destinations[next], COMEDI_NUM_BOARD_MINORS);
+		while ((t = find_next_bit(destinations[cur],
+					  COMEDI_NUM_BOARD_MINORS,
+					  t)) < COMEDI_NUM_BOARD_MINORS) {
+			unsigned int f;
+
+			for (f = 0; f < COMEDI_NUM_BOARD_MINORS; f++) {
+				if (kcomedilib_to_from[t][f])
+					set_bit(f, destinations[next]);
+			}
+			t++;
+		}
+		cur = next;
+	} while (!bitmap_empty(destinations[cur], COMEDI_NUM_BOARD_MINORS));
+	if (okay) {
+		/* Allow a maximum of 255 links from "from" to "to". */
+		if (kcomedilib_to_from[to][from] < 255)
+			kcomedilib_to_from[to][from]++;
+		else
+			okay = false;
+	}
+	mutex_unlock(&kcomedilib_to_from_lock);
+	return okay;
+}
+
+static void kcomedilib_clear_link_from_to(unsigned int from, unsigned int to)
+{
+	if (to < COMEDI_NUM_BOARD_MINORS && from < COMEDI_NUM_BOARD_MINORS) {
+		mutex_lock(&kcomedilib_to_from_lock);
+		if (kcomedilib_to_from[to][from])
+			kcomedilib_to_from[to][from]--;
+		mutex_unlock(&kcomedilib_to_from_lock);
+	}
+}
+
+/**
+ * comedi_open_from() - Open a COMEDI device from the kernel with loop checks
+ * @filename: Fake pathname of the form "/dev/comediN".
+ * @from: Device number it is being opened from (if in range).
+ *
+ * Converts @filename to a COMEDI device number and "opens" it if it exists
+ * and is attached to a low-level COMEDI driver.
+ *
+ * If @from is in range, refuse to open the device if doing so would form a
+ * loop of devices opening each other.  There is also a limit of 255 on the
+ * number of concurrent opens from one device to another.
+ *
+ * Return: A pointer to the COMEDI device on success.
+ * Return %NULL on failure.
+ */
+struct comedi_device *comedi_open_from(const char *filename, int from)
 {
 	struct comedi_device *dev, *retval = NULL;
 	unsigned int minor;
@@ -43,7 +141,7 @@ struct comedi_device *comedi_open(const char *filename)
 		return NULL;
 
 	down_read(&dev->attach_lock);
-	if (dev->attached)
+	if (dev->attached && kcomedilib_set_link_from_to(from, minor))
 		retval = dev;
 	else
 		retval = NULL;
@@ -54,14 +152,26 @@ struct comedi_device *comedi_open(const char *filename)
 
 	return retval;
 }
-EXPORT_SYMBOL_GPL(comedi_open);
+EXPORT_SYMBOL_GPL(comedi_open_from);
 
-int comedi_close(struct comedi_device *dev)
+/**
+ * comedi_close_from() - Close a COMEDI device from the kernel with loop checks
+ * @dev: COMEDI device.
+ * @from: Device number it was opened from (if in range).
+ *
+ * Closes a COMEDI device previously opened by comedi_open_from().
+ *
+ * If @from is in range, it should be match the one used by comedi_open_from().
+ *
+ * Returns: 0
+ */
+int comedi_close_from(struct comedi_device *dev, int from)
 {
+	kcomedilib_clear_link_from_to(from, dev->minor);
 	comedi_dev_put(dev);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(comedi_close);
+EXPORT_SYMBOL_GPL(comedi_close_from);
 
 static int comedi_do_insn(struct comedi_device *dev,
 			  struct comedi_insn *insn,
diff --git a/include/linux/comedi/comedilib.h b/include/linux/comedi/comedilib.h
index 0223c9cd9215..1f2b22b383cc 100644
--- a/include/linux/comedi/comedilib.h
+++ b/include/linux/comedi/comedilib.h
@@ -10,8 +10,38 @@
 #ifndef _LINUX_COMEDILIB_H
 #define _LINUX_COMEDILIB_H
 
-struct comedi_device *comedi_open(const char *path);
-int comedi_close(struct comedi_device *dev);
+struct comedi_device *comedi_open_from(const char *path, int from);
+
+/**
+ * comedi_open() - Open a COMEDI device from the kernel
+ * @filename: Fake pathname of the form "/dev/comediN".
+ *
+ * Converts @filename to a COMEDI device number and "opens" it if it exists
+ * and is attached to a low-level COMEDI driver.
+ *
+ * Return: A pointer to the COMEDI device on success.
+ * Return %NULL on failure.
+ */
+static inline struct comedi_device *comedi_open(const char *path)
+{
+	return comedi_open_from(path, -1);
+}
+
+int comedi_close_from(struct comedi_device *dev, int from);
+
+/**
+ * comedi_close() - Close a COMEDI device from the kernel
+ * @dev: COMEDI device.
+ *
+ * Closes a COMEDI device previously opened by comedi_open().
+ *
+ * Returns: 0
+ */
+static inline int comedi_close(struct comedi_device *dev)
+{
+	return comedi_close_from(dev, -1);
+}
+
 int comedi_dio_get_config(struct comedi_device *dev, unsigned int subdev,
 			  unsigned int chan, unsigned int *io);
 int comedi_dio_config(struct comedi_device *dev, unsigned int subdev,
-- 
2.51.0


