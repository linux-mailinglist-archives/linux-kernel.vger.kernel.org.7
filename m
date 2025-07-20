Return-Path: <linux-kernel+bounces-738421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B25B0B81B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 22:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BAE1899B11
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5280C213E77;
	Sun, 20 Jul 2025 20:01:28 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C62D382;
	Sun, 20 Jul 2025 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753041688; cv=none; b=pLl0VhZvOQlsCd7lc5YyFfLhEkFOMYJtUn9MP49LyXOUJaGk1VfHb4Qx9Anwr2tgLl+0RgMtQx6KtOL6vrO9SuqVIVLFVuccpYdJdaSYM6OrhniTSfZuAdld+GttbFqpZGrIUJioutiJT6rsRx6VtQBH6EdrgWWfK+kCU8xkKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753041688; c=relaxed/simple;
	bh=ko5XodbQbQ51da4c10eyXzC2IwBB+CP+8acn5vUuC4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dx/5sCbkU8GZhQDa9Np9siW/8K0x50vOG20Tt8dB1rVetnfsKJjoil3MKw007dsW2KQuBiQ0kEB6S8QDO88RKcWGGysfYJNeY9nGyupW1FG5JQ29/o+3dp8/Gft/uUtN0Uq9cLNH8bmgtY2kCp4taGILZdC1+z4Rcr7vgf0mSks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:2685:4e7b:cbf0:7870])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id C684840484;
	Sun, 20 Jul 2025 20:01:22 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:2685:4e7b:cbf0:7870) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	snovitoll@gmail.com,
	syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	contact@arnaud-lcm.com
Subject: [PATCH] usb: mon: Fix slab-out-of-bounds in mon_bin_event due to
 unsafe URB transfer_buffer access
Date: Sun, 20 Jul 2025 21:00:57 +0100
Message-ID: <20250720200057.19720-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175304168340.17734.15413668970472850681@Plesk>
X-PPP-Vhost: arnaud-lcm.com

The syzkaller fuzzer uncovered a kernel slab-out-of-bounds
 write in the USB monitoring subsystem (mon_bin) when handling
 a malformed URB (USB Request Block) with the following properties:
 - transfer_buffer_length = 0xffff
 - actual_length = 0x0 (no data transferred)
 - number_of_packets = 0x0 (non-isochronous transfer)

When reaching the mon_copy_to_buff function,
 we will try to copy into the mon rp bin with the following parameters:
off=0xcc0, from=0xffff8880246df5e1 "", length=0xf000

At the first iteration, the step_len is 0x340 and it is during the mem_cpy
that the slab-out-of-bounds happens.
As step_len < transfer_buffer_length, we can deduce that it is related
 to an issue with the transfer_buffer being invalid.
The patch proposes a safe access to the kernel
 kernel buffer urb->transfer_buffer with `copy_from_kernel_nofault`.

Reported-by: syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com
Fixes: 6f23ee1fefdc1 ("USB: add binary API to usbmon")
Closes: https://syzkaller.appspot.com/bug?extid=86b6d7c8bcc66747c505
Tested-by: syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
---
 drivers/usb/mon/mon_bin.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index c93b43f5bc46..d3bef2a37eb0 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -249,7 +249,11 @@ static unsigned int mon_copy_to_buff(const struct mon_reader_bin *this,
 		 * Copy data and advance pointers.
 		 */
 		buf = this->b_vec[off / CHUNK_SIZE].ptr + off % CHUNK_SIZE;
-		memcpy(buf, from, step_len);
+
+		if (copy_from_kernel_nofault(buf, from, step_len)) {
+			pr_warn("Failed to copy URB transfer buffer content into mon bin.");
+			return -EFAULT;
+		}
 		if ((off += step_len) >= this->b_size) off = 0;
 		from += step_len;
 		length -= step_len;
@@ -413,11 +417,13 @@ static unsigned int mon_bin_get_data(const struct mon_reader_bin *rp,
 
 	*flag = 0;
 	if (urb->num_sgs == 0) {
-		if (urb->transfer_buffer == NULL) {
+		if (
+			urb->transfer_buffer == NULL ||
+			mon_copy_to_buff(rp, offset, urb->transfer_buffer, length) < 0
+		) {
 			*flag = 'Z';
 			return length;
 		}
-		mon_copy_to_buff(rp, offset, urb->transfer_buffer, length);
 		length = 0;
 
 	} else {
@@ -434,6 +440,10 @@ static unsigned int mon_bin_get_data(const struct mon_reader_bin *rp,
 			this_len = min_t(unsigned int, sg->length, length);
 			offset = mon_copy_to_buff(rp, offset, sg_virt(sg),
 					this_len);
+			if (offset < 0) {
+				*flag = 'Z';
+				return length;
+			}
 			length -= this_len;
 		}
 		if (i == 0)
-- 
2.43.0


