Return-Path: <linux-kernel+bounces-722772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC18AFDEA7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AB51898BAA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E94425FA0F;
	Wed,  9 Jul 2025 04:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XLoNoxa1"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651313D2B2;
	Wed,  9 Jul 2025 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752033650; cv=none; b=HnnA+Am8kfrhp9ITV2Qoh+PFaTayGPx0Yj8WYbXllNjTTyw6BpLgfsG1o0ShvoLwHvO7UQnJSVuXIRP7v4aepD8QvfJUVf2vfJ4Tn7CUARjYUZmcYCXdv60gNMZ0up0b81NeG4jMLqBDzXTDLnwAyV2onTP9Puk9QLFM9a+79jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752033650; c=relaxed/simple;
	bh=dSmH3YdSMwNCOvQhUp1z3YXco7w2Pd/mH6NlzP23Rn0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=uLijOFMDftUtNpFZy34/F7BeD7AQ6ytw2CCl9qBKhkzaEGbl5p8juemxR1Gv60qL7XJ9GJU6sJ5JSAbkS3fIfA7I19gvujUjYQ/01fj5Wz88z7twZTVj0R0miTkHF5qhMaPVo7M4zr/bb3CNCjzmJm3DcREx2A9FpAqQLBgDgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XLoNoxa1; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1752033337; bh=J//NFXkKWW4mxlFccCxfnS5IzGCIuTinEyv6FNfY3yE=;
	h=From:To:Cc:Subject:Date;
	b=XLoNoxa1dW4JxXyHpeT0I7sUHaAjeCr7Mahr+vc2BvNhHJoY/ijergWVN8ysITDJS
	 MnKrnwVs247ROtwYt92oW0dn+TV94WvBtpEpX3p2Bo9sdvqfk1wVUl42T3JOwQGR4R
	 KfBFkMUTZpq3X3L57vJ9N16w6rHctW+ZRyM8ySG4=
Received: from KATIEELIU-MC3.tencent.com ([113.108.77.50])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id DE382630; Wed, 09 Jul 2025 11:55:35 +0800
X-QQ-mid: xmsmtpt1752033335tx462qqc8
Message-ID: <tencent_B1C9481688D0E95E7362AB2E999DE8048207@qq.com>
X-QQ-XMAILINFO: NOHu7IGFswkwv04j6qiELNyEiK/LV2P6eLX/DSo667V8836AtJL9lvnDkm2XOB
	 Jn+4YN4E4bALMyf8oaPYdM7D3X2svjWDtzglyqSNtsfEzXcD3OWWA5xTYFYrV7hBG1+PTkY1HTMl
	 uJSoTxesRKj9Rv6my4I0npJd/rc+vc5p7GIPtguoMccwFXuvO1Lop2OsqsofRGwRQKzqixdMESIn
	 DuPJE5S6KIpyivebv5Bq39Y5ybT7XXZaZbLg0qqSByj/vL/W6d8VCrjsOH26tpacJNXXe0h9LLsY
	 Ke8eu7q5X97wF+BVKex6rrwh1nyCKmIo+FLmb0/oRGqY17fGlesjWlzqUO/e6jRF1MsTd+9GEw3e
	 k8/Q9WceYirFlP3Hb9K/E6yBPX/oHz1elIovnFOk0JVQsVS7EfSupMxNvHFldH5KzSbLiRRwGDwJ
	 0PXQld1ziHpBDmg1lq/P0/wuBRKRlIuxVS3J+wu9RyNWU3GdSIG1NsnsamdtmgKDgJ9sYgi2ea2Y
	 ASJrcA9A4gY1Kvk7SObb7BUB0M6YW4LsYXXiZRhTOle26yn1Y5+wYI51LyqhFthbylXY9iAGskBs
	 6Su+/x+OyUaAfRHlSFEi7TyHe/PVG+Ynz9yJ9KWTUurSBI09J3TFdRbFrXD5lopb5MKt3YaGjTs5
	 LBUizMi5xoIrYMDMgOaziv8gwRoApI92giuarhr3Gh7UGX5R6Knkl7b4sVdwLXqwJMmRHRarCYf7
	 8ogSCMzisd/kldDWPmfIE0hgt4oYtoGd7J2IZ5NhAK5H6OUIw7tsIiGsJUquPat9zRaBfXMBBNek
	 QumCdir5SG67jJCVnzE6GG/4J7g7z+120MDBLlWP+LNVX/dvzcfEbLrZDjUUX8rZ7b3Vz58C6sN3
	 v0b/7ZUcRpPIUWHLlaT75NMqH68XDy7eXIPizQMqb9YCaFXHguv3uc5vPCXbwOzOYrt9wc1Jsizo
	 45aSl6j6HpcZFSywuyuoCYPCTo3G1cWWR06bSaCLfGWI6PlSY7/wVXHkgfl0DZAFO1VCEN4Ze0Ur
	 XJN3YbFo355m37xQSyd3FtV21utIGlYIjeP8jMNBQgcX9JPURr+S+wevr1pGk=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Xinyu Liu <1171169449@qq.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	katieeliu@tencent.com,
	security@tencent.com,
	Xinyu Liu <1171169449@qq.com>
Subject: [PATCH] usb: gadget: configfs: Fix OOB read on empty string write
Date: Wed,  9 Jul 2025 11:55:33 +0800
X-OQ-MSGID: <20250709035533.75050-1-1171169449@qq.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing an empty string to either 'qw_sign' or 'landingPage'
sysfs attributes, the store functions attempt to access page[l - 1]
before validating that the length 'l' is greater than zero.

This patch fixes the vulnerability by adding a check at the beginning
of os_desc_qw_sign_store() and webusb_landingPage_store() to handle
the zero-length input case gracefully by returning immediately.

Signed-off-by: Xinyu Liu <katieeliu@tencent.com>
---
 drivers/usb/gadget/configfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index fba2a56dae97..1bb32d6be9b3 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1064,7 +1064,8 @@ static ssize_t webusb_landingPage_store(struct config_item *item, const char *pa
 	struct gadget_info *gi = webusb_item_to_gadget_info(item);
 	unsigned int bytes_to_strip = 0;
 	int l = len;
-
+	if (!len)
+		return len;
 	if (page[l - 1] == '\n') {
 		--l;
 		++bytes_to_strip;
@@ -1187,7 +1188,8 @@ static ssize_t os_desc_qw_sign_store(struct config_item *item, const char *page,
 {
 	struct gadget_info *gi = os_desc_item_to_gadget_info(item);
 	int res, l;
-
+	if (!len)
+		return len;
 	l = min_t(int, len, OS_STRING_QW_SIGN_LEN >> 1);
 	if (page[l - 1] == '\n')
 		--l;
-- 
2.39.5 (Apple Git-154)


