Return-Path: <linux-kernel+bounces-720252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B86AFB91C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016294A6269
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9B722DFB1;
	Mon,  7 Jul 2025 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="IKamk4RV"
Received: from smtp79.iad3a.emailsrvr.com (smtp79.iad3a.emailsrvr.com [173.203.187.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5986F224B0E
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907110; cv=none; b=crCNEqO+VEmOgiw3jCfsAQ9PYrbGwjRq1hlH0Gr/qu/Bs0l+RNdOgyfc/j5Msh2fAKCMuaIqMYwUBdBykyQ9XzWk4dng7iOmNNc/9zMMSqzCM7zPohA8FMqNhojnqdbRt5CtAEkgHpO7fJNKEVzf6n3HSoWzdqgIowjKFyGtEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907110; c=relaxed/simple;
	bh=BAtdjqU+UrMQvby1bp04z3uiYeP5xMV3MbeUNW96Mo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meRoGhWUj77M+FzzJktkBA/XWgjXkgUcXgzZlbUvXtWsGz0JutiyhZQBhQqfhCRAEqjJq+5n1GUGqOyIAsWNbQ1hY6Wm0oUPVCAlJB+2eV60VAORNHO4AhKrrEuSr+McjQS36F+ulkAxINrVf6H5sr97jb6hOb/cgvJ+CN2bYug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=IKamk4RV; arc=none smtp.client-ip=173.203.187.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1751904889;
	bh=BAtdjqU+UrMQvby1bp04z3uiYeP5xMV3MbeUNW96Mo8=;
	h=From:To:Subject:Date:From;
	b=IKamk4RVTnnuD+lnuicDE3w1Fhn353KfTUDIBoHO903B8/ZnVXG1VyzgdL8X/fml9
	 1smCAfU6EOuzgmHqpxYOeBJZnigEUauut7aH6r0+BTxrHf4vIo+VC6AywhZwrdQGX6
	 5IRogg/Mk3CKW1ZmFtruc0jcB0Kl6ggCQKky6/ls=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 883D65DB7;
	Mon,  7 Jul 2025 12:14:48 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: Fix initialization of data for instructions that write to subdevice
Date: Mon,  7 Jul 2025 17:14:39 +0100
Message-ID: <20250707161439.88385-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: ee79df78-f328-41a5-9cda-7d77cfae3ae9-1-1

Some Comedi subdevice instruction handlers are known to access
instruction data elements beyond the first `insn->n` elements in some
cases.  The `do_insn_ioctl()` and `do_insnlist_ioctl()` functions
allocate at least `MIN_SAMPLES` (16) data elements to deal with this,
but they do not initialize all of that.  For Comedi instruction codes
that write to the subdevice, the first `insn->n` data elements are
copied from user-space, but the remaining elements are left
uninitialized.  That could be a problem if the subdevice instruction
handler reads the uninitialized data.  Ensure that the first
`MIN_SAMPLES` elements are initialized before calling these instruction
handlers, filling the uncopied elements with 0.  For
`do_insnlist_ioctl()`, the same data buffer elements are used for
handling a list of instructions, so ensure the first `MIN_SAMPLES`
elements are initialized for each instruction that writes to the
subdevice.

Fixes: ed9eccbe8970 ("Staging: add comedi core")
Cc: <stable@vger.kernel.org> # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
Patch does not apply cleanly to longterm kernels 5.4.x and 5.10.x.
---
 drivers/comedi/comedi_fops.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 3383a7ce27ff..0f8b471d5032 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1556,21 +1556,27 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 	}
 
 	for (i = 0; i < n_insns; ++i) {
+		unsigned int n = insns[i].n;
+
 		if (insns[i].insn & INSN_MASK_WRITE) {
 			if (copy_from_user(data, insns[i].data,
-					   insns[i].n * sizeof(unsigned int))) {
+					   n * sizeof(unsigned int))) {
 				dev_dbg(dev->class_dev,
 					"copy_from_user failed\n");
 				ret = -EFAULT;
 				goto error;
 			}
+			if (n < MIN_SAMPLES) {
+				memset(&data[n], 0, (MIN_SAMPLES - n) *
+						    sizeof(unsigned int));
+			}
 		}
 		ret = parse_insn(dev, insns + i, data, file);
 		if (ret < 0)
 			goto error;
 		if (insns[i].insn & INSN_MASK_READ) {
 			if (copy_to_user(insns[i].data, data,
-					 insns[i].n * sizeof(unsigned int))) {
+					 n * sizeof(unsigned int))) {
 				dev_dbg(dev->class_dev,
 					"copy_to_user failed\n");
 				ret = -EFAULT;
@@ -1633,6 +1639,10 @@ static int do_insn_ioctl(struct comedi_device *dev,
 			ret = -EFAULT;
 			goto error;
 		}
+		if (insn->n < MIN_SAMPLES) {
+			memset(&data[insn->n], 0,
+			       (MIN_SAMPLES - insn->n) * sizeof(unsigned int));
+		}
 	}
 	ret = parse_insn(dev, insn, data, file);
 	if (ret < 0)
-- 
2.47.2


