Return-Path: <linux-kernel+bounces-818758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 913CBB59613
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF86F321F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E996A30DEDE;
	Tue, 16 Sep 2025 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LYahr09J"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C72ECD11
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025430; cv=none; b=jg4Pt8fkBWm/ahU5cvv7rMz69XYnDPLLFrs6/gVaL6UDBa7zmsVQED935TCRFfLRF0kuEz2AHdyPyUlKLKV1xzex5D9Lzda4koIG+XvRJrnkZbK2fB86Gwej3Q9oi5pQY9kjXJXyXfENv4fOckTu6CIbDr5/uEcfdR6wnW8CtlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025430; c=relaxed/simple;
	bh=nGDtXhiz+KlmQ+/KJW9I4wpgUJcccbG3xcVGWXXZVR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZuNX743kuWtUul4vcGcBXisQen4Xk3Df0AyvmloeNzGWA1Fr3Xe/MuuoH2C8NJCy5K3T566GkfQePSBFFfB3qsgVrhqI0gWKzIRBUZ5eEgXvUhLLzGzsDG78tItFFd5qxZfvt305wh0ootTgfdyDGjtQeaTR8HJ0PpENhb0ggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LYahr09J; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758025424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+h/tS4Y8NkiODxjDm62cUtCTJlDmAXLw6Hr1X8jKoRs=;
	b=LYahr09JqJAo8rIJfCPhxd6R3gUWSkIKz99cDNFshfSCm6wjybz29zSvtYXmePm2Zp0WfQ
	LdcN05UY26L6g+knxqwvptLNRP/MljyWSksKecGoRcuhAm2Cf4ZES2WPlX+4H9CPM5cmzs
	gENX7Y6WoyltkuZl0oBjQ/3J2aN1k5E=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: use struct_size and flex_array_size in ioctl_add_descriptor
Date: Tue, 16 Sep 2025 14:21:45 +0200
Message-ID: <20250916122143.2459993-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use struct_size() to determine the memory needed for a new 'struct
descriptor_resource' and flex_array_size() to calculate the number of
bytes to copy from userspace. This removes the hardcoded size (4 bytes)
for the 'u32 data[]' entries.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/firewire/core-cdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 78b10c6ef7fe..622bcbed6f1d 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -937,11 +937,12 @@ static int ioctl_add_descriptor(struct client *client, union ioctl_arg *arg)
 	if (a->length > 256)
 		return -EINVAL;
 
-	r = kmalloc(sizeof(*r) + a->length * 4, GFP_KERNEL);
+	r = kmalloc(struct_size(r, data, a->length), GFP_KERNEL);
 	if (r == NULL)
 		return -ENOMEM;
 
-	if (copy_from_user(r->data, u64_to_uptr(a->data), a->length * 4)) {
+	if (copy_from_user(r->data, u64_to_uptr(a->data),
+			   flex_array_size(r, data, a->length))) {
 		ret = -EFAULT;
 		goto failed;
 	}
-- 
2.51.0


