Return-Path: <linux-kernel+bounces-824517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B00B8971B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40DE3BF61C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37B73112DE;
	Fri, 19 Sep 2025 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a0FV84yg"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10015310635
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284865; cv=none; b=G1dMAN40Xi1AfEo1diM1XSi4GtpsNM4toHVFj4tOuaIMGWqdBlRCHD3W9bfW5NSTDCO84UpB0zTvJzcJCHXMRpCK4Y4H2VYFG40/tzmc7zR7JneKFdxv1xNSvhyEkAmm9s0dXbP2kdkPCg6uBVMVHgakpBoEKKE9/GGdWAVqo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284865; c=relaxed/simple;
	bh=N1o6nW5DLqfFTakYp0Dch/r0Y9z2pI9JP9BytE2dbRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMdaLbRXk9cXvEegj0jOoAjqvKxX+N973laLD1ZJY6HM6r3Lg5UBHHj13BOAC4GMQONJlcMxgkJ687m73d6ZJoQuPZ9hjIh5/vkWG6xhe5f1rTWhTf0rf7mZUiPfftpJOo0QKU70V0VueODgqmAIxufDceYlzB8+gbM9/kYvQ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a0FV84yg; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758284860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dZxoJoq3xmtiWyy6xhrPhCO7fEeP17Cu+fe/6atKDK8=;
	b=a0FV84ygxvknrciWZ9hz6hPgOYG+3Jgix9RA8feuleoRkkd+GDvSe48xhabvI3hFFbJowf
	huYrIs+iwKQPybusL+/YRhf7U+db4CmWZoGHCuaqb95vFg+924W7Y9eQk4loCG+k38IFjW
	d5mgbIWY5uc5i5dGbtjcyC6AzWWxUc8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Jann Horn <jannh@google.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] USB: core: replace memdup_user with memdup_array_user in proc_do_submiturb
Date: Fri, 19 Sep 2025 14:25:57 +0200
Message-ID: <20250919122601.1094728-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use memdup_array_user() instead of memdup_user() in proc_do_submiturb().
Compared to memdup_user(), memdup_array_user() automatically checks for
multiplication overflow. Remove the obsolete local variable 'isofrmlen'.

Return early if an error occurs instead of manually setting 'ret' and
using 'goto error'.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/usb/core/devio.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index f6ce6e26e0d4..a259fb6d6292 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1624,7 +1624,7 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
 	struct usb_host_endpoint *ep;
 	struct async *as = NULL;
 	struct usb_ctrlrequest *dr = NULL;
-	unsigned int u, totlen, isofrmlen;
+	unsigned int u, totlen;
 	int i, ret, num_sgs = 0, ifnum = -1;
 	int number_of_packets = 0;
 	unsigned int stream_id = 0;
@@ -1745,14 +1745,10 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
 		if (!usb_endpoint_xfer_isoc(&ep->desc))
 			return -EINVAL;
 		number_of_packets = uurb->number_of_packets;
-		isofrmlen = sizeof(struct usbdevfs_iso_packet_desc) *
-				   number_of_packets;
-		isopkt = memdup_user(iso_frame_desc, isofrmlen);
-		if (IS_ERR(isopkt)) {
-			ret = PTR_ERR(isopkt);
-			isopkt = NULL;
-			goto error;
-		}
+		isopkt = memdup_array_user(iso_frame_desc, number_of_packets,
+				sizeof(struct usbdevfs_iso_packet_desc));
+		if (IS_ERR(isopkt))
+			return PTR_ERR(isopkt);
 		for (totlen = u = 0; u < number_of_packets; u++) {
 			/*
 			 * arbitrary limit need for USB 3.1 Gen2
-- 
2.51.0


