Return-Path: <linux-kernel+bounces-870294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8433FC0A655
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 11:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 311A83440FF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 10:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69701246BD8;
	Sun, 26 Oct 2025 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dN663kkO"
Received: from smtp.smtpout.orange.fr (smtp-74.smtpout.orange.fr [80.12.242.74])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFDF3B7A8;
	Sun, 26 Oct 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761476062; cv=none; b=VhtpGXrpg1SePi0Rxs+7enYtxB+CXDpmL/yxJ8vu1JmirXZBPfJCRASVr+75+jhUq8kEp1n8z/BetArepFePmN3gTE7983NG8ZF+SpdflvpKYIKdPMWPo33ITPDvcse8eeLUu2NPDRBZvh39+TdB5b6pDnRZVz+QMBgRNWj9l+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761476062; c=relaxed/simple;
	bh=tK7HS9bj/DEqYFWNQwvGX6kIY9II8FCtL5zQJwqPB64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H8bhNihl1wRbvdIYWrVMGumcm9xSt+2K04Hc1cTNHmb++jMgFO7aUAh+U0x1UO3UsKEN+ylGrRwSkOZz8C2odjvCOHbyGMQxK1gzGCbSfiC5Gp+1v88c01UGEQhZPN3i5bbsK3paTDvR+4gYvQRzVwHkwRRrvBeMbFACsoekR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dN663kkO; arc=none smtp.client-ip=80.12.242.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id CyN1vAKxM7TjyCyN1vOFVf; Sun, 26 Oct 2025 11:53:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1761475991;
	bh=nLTWNBJbJPgxe0pVePlYQcmuPVBtcUlK4ki+WghVXJE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=dN663kkOmoL1Yqtgf9bVfvFh8G1TTPKem18dWi4I2911mqyC5iut+ymVsKal1toGP
	 GK2J+gdGuZka/JHwzkIIsdZqTBFkb0js8kNl5iB3pR50ziH/u1rNduIQ4sO0mvhz+h
	 r0haMKkGv2xttG7+CRbFMzhDseidaiRZA0//eHz8jxK7n7Q2LEpT7ZFzk9UhGDS2vQ
	 hs7S09rfKLv1agePW2zPKkANzCpOxohm204s/HZ6MMIfoxg7+caSI+oC8vej2XXr2W
	 bFem56uVJRHEESHx87OXSlVcO7/2+dZYhcXcm0zf3u7Wkrklk7P+L1lzkkfi5Myktc
	 +gIqKDc6ftgpA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Oct 2025 11:53:11 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	xen-devel@lists.xenproject.org,
	linux-usb@vger.kernel.org
Subject: [PATCH] xen/usb: Constify struct hc_driver
Date: Sun, 26 Oct 2025 11:51:04 +0100
Message-ID: <63241c9e857646d895ce615b998d41ee4829f9e3.1761475831.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct hc_driver' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  52065	  23176	    256	  75497	  126e9	drivers/usb/host/xen-hcd.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  52897	  22344	    256	  75497	  126e9	drivers/usb/host/xen-hcd.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/host/xen-hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xen-hcd.c b/drivers/usb/host/xen-hcd.c
index 1c2a95fe41e5..0a94d302911a 100644
--- a/drivers/usb/host/xen-hcd.c
+++ b/drivers/usb/host/xen-hcd.c
@@ -1388,7 +1388,7 @@ static int xenhcd_get_frame(struct usb_hcd *hcd)
 	return 0;
 }
 
-static struct hc_driver xenhcd_usb20_hc_driver = {
+static const struct hc_driver xenhcd_usb20_hc_driver = {
 	.description = "xen-hcd",
 	.product_desc = "Xen USB2.0 Virtual Host Controller",
 	.hcd_priv_size = sizeof(struct xenhcd_info),
@@ -1413,7 +1413,7 @@ static struct hc_driver xenhcd_usb20_hc_driver = {
 #endif
 };
 
-static struct hc_driver xenhcd_usb11_hc_driver = {
+static const struct hc_driver xenhcd_usb11_hc_driver = {
 	.description = "xen-hcd",
 	.product_desc = "Xen USB1.1 Virtual Host Controller",
 	.hcd_priv_size = sizeof(struct xenhcd_info),
-- 
2.51.0


