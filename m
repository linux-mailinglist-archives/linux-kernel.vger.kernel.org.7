Return-Path: <linux-kernel+bounces-738401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D548B0B7E7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35DE3A8219
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206A617AE11;
	Sun, 20 Jul 2025 19:16:59 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B5376
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753039018; cv=none; b=or8FEZUF1JdO5V2j1A9kEdfSdfyqQlDbmWkxsFbNhpmyQPBmI5ZmDyH4F7jjy99FGdDrKYj6ZGrRzWevbQFmVlzyrF5ZJ1XADvplF/CM7gEzUrXKzT2LMznTXDWdET0Oopzj3qn+9og32RAoeMk92WChb2VBpDn19OoYrHBT9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753039018; c=relaxed/simple;
	bh=vPmF1Fs/GjyeIaxxnO7OOCkhOFAwW4eaXYi+1ftcxbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNrLuY+6kJAQFilZZT5oySHmlswqfvgy0El/1AKqniQQlokPKG7Xl5BcwWpLS2oxpgd15fpfpdw/bqxK2K60LdkoK6Jnmc01BNL9+3jCF+FKMr8Xu/8e2JYqcUjNUF7jZfBxSkxF2k0E/xw3UUWYHRc1eUDOULUpE78LCNPVZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:2685:4e7b:cbf0:7870])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id ADA0C4081E;
	Sun, 20 Jul 2025 19:16:47 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:2685:4e7b:cbf0:7870) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: syztest
Date: Sun, 20 Jul 2025 20:16:42 +0100
Message-ID: <20250720191642.14512-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <68665197.a70a0220.2b31f5.0019.GAE@google.com>
References: <68665197.a70a0220.2b31f5.0019.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175303900811.21000.16461581606215600176@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

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


