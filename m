Return-Path: <linux-kernel+bounces-870663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC37AC0B654
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 558404EDB66
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957C2FF65C;
	Sun, 26 Oct 2025 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KwNiD+IG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CB14386D;
	Sun, 26 Oct 2025 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761518766; cv=none; b=AKTJSJABhDDIsdHaa8t1GYJulbXu9v+trB+0TppuwU9WuHHx36p16IB24BF2LcssujH50cdGgGQC7Ik8SQTUgh4jQ3q6D2lxwKxY8JPeJ+G+g/7hd+fpymWDGsaImwu3AQRfjPXYZbQ0pvkih/T/qA5uCGQYeZJYvjM35kkSZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761518766; c=relaxed/simple;
	bh=le2xvwUqcISaoyhG2EPX1Cz0XWb2oeqygji2ZzpAk7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcuL0KxYs+hU2c6oSpH31osi3aDvVU6f/U8foM9nZVOrWttDpVjqTWfDr+35UTgK/mJvjIEfeSznFLucS06MG+x6x3bsYctazR81EeAtge1yJQfkGOLYPH/wT8aDqmipwMlSBbHMX9IhVz69J7YiCbCCvki6tIAr8HLMuZ++AHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KwNiD+IG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rCRAutHedepxoaqlhY+trKzO9H8TOhlVc7iMT1F8fAg=; b=KwNiD+IGxwgKKhX16mI1eZHUh2
	+qV/XAxGesDYhgRsnt2HcXLX4Su+mon9piSbab4X7mMb9nECfPXumu5ZOAHQFlHVi55d5Ac6IUFSD
	sYAbqwrsG5pTZTKhnd2gaOVAg6/ZAs2S604YYHDR0VhCbEjfH07FmJQrfLecv3kH4FIMsJU5oDIQP
	9Ul51L64PufdveiYueEyDiv3sJviQlwR0jnfsC7StNNMDeEMF38Ga1/tzxu5498agx2qmSpPwCM2v
	9pzyXA7lDZ5IxK/phN0fKvxmw4gzrOzf3KvdSp32mqcTtmnXD96KkaqhGyytw/sbR8AvWudQGm6Nn
	LB29r/gg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vD9Uu-0000000CpNa-25U1;
	Sun, 26 Oct 2025 22:46:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/2] usb: mtu3: fix invalid kernel-doc in mtu3.h
Date: Sun, 26 Oct 2025 15:45:58 -0700
Message-ID: <20251026224558.826143-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026224558.826143-1-rdunlap@infradead.org>
References: <20251026224558.826143-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix unconventional kernel-doc lines to avoid warnings.
Summary of changes:

- change non-kernel-doc comments from "/**" to "/*"
- add "enum <enum-name> - short description" for undescribed enums
- use leading '@' for describing enum members and struct members
- add "struct <struct-name> - short description" for undescribed structs


Repair and remove invalid or unconventional lines in mtu3.h:

(This list is a combination of warnings from the old kernel-doc.pl and
the new kernel-doc.py scripts. This combo provides better coverage
of all problems.)

mtu3.h:69: warning: This comment starts with '/**', but isn't a
 kernel-doc comment.
 * IP TRUNK version
mtu3.h:69: warning: missing initial short description on line:
 * IP TRUNK version
mtu3.h:78: warning: This comment starts with '/**', but isn't a
 kernel-doc comment.
 * Normally the device works on HS or SS, to simplify fifo management,
mtu3.h:78: warning: missing initial short description on line:
 * Normally the device works on HS or SS, to simplify fifo management,
mtu3.h:89: warning: This comment starts with '/**', but isn't
 a kernel-doc comment.
 * Maximum size of ep0 response buffer for ch9 requests,
mtu3.h:89: warning: missing initial short description on line:
 * Maximum size of ep0 response buffer for ch9 requests,
mtu3.h:106: warning: Cannot understand  * @MU3D_EP0_STATE_SETUP: waits for
 SETUP or received a SETUP
 on line 106 - I thought it was a doc line
mtu3.h:130: warning: cannot understand function prototype:
 'enum mtu3_dr_force_mode'
mtu3.h:137: warning: Cannot understand  * @base: the base address of fifo
 on line 137 - I thought it was a doc line
mtu3.h:148: warning: missing initial short description on line:
 * General Purpose Descriptor (GPD):
mtu3.h:174: warning: cannot understand function prototype:
 'struct qmu_gpd'
mtu3.h:189: warning: cannot understand function prototype:
 'struct mtu3_gpd_ring'
mtu3.h:198: warning: Cannot understand * @vbus: vbus 5V used by host mode
 on line 198 - I thought it was a doc line
mtu3.h:225: warning: Cannot understand  * @mac_base: register base address
 of device MAC, exclude xHCI's
 on line 225 - I thought it was a doc line
mtu3.h:275: warning: cannot understand function prototype: 'struct mtu3_ep'

Warning: drivers/usb/mtu3/mtu3.h:135 Enum value 'MTU3_DR_FORCE_NONE'
 not described in enum 'mtu3_dr_force_mode'
Warning: drivers/usb/mtu3/mtu3.h:135 Enum value 'MTU3_DR_FORCE_HOST'
 not described in enum 'mtu3_dr_force_mode'
Warning: drivers/usb/mtu3/mtu3.h:135 Enum value 'MTU3_DR_FORCE_DEVICE'
 not described in enum 'mtu3_dr_force_mode'
Warning: drivers/usb/mtu3/mtu3.h:270 Cannot find identifier on line:
 * @fifo_size: it is (@slot + 1) * @fifo_seg_size
Warning: drivers/usb/mtu3/mtu3.h:271 Cannot find identifier on line:
 * @fifo_seg_size: it is roundup_pow_of_two(@maxp)
Warning: drivers/usb/mtu3/mtu3.h:272 Cannot find identifier on line:
 */
Warning: drivers/usb/mtu3/mtu3.h:273 Cannot find identifier on line:
struct mtu3_ep {
Warning: drivers/usb/mtu3/mtu3.h:274 Cannot find identifier on line:
        struct usb_ep ep;
Warning: drivers/usb/mtu3/mtu3.h:275 Cannot find identifier on line:
        char name[12];
Warning: drivers/usb/mtu3/mtu3.h:276 missing initial short description
 on line:
        struct mtu3 *mtu;


This removes all of the invalid/unconventional kernel-doc attempts but
still leaves quite a few struct members in structs ssusb_mtk, mtu3_ep,
and mtu3 without kernel-doc descriptions.


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 drivers/usb/mtu3/mtu3.h |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

--- linux-next.orig/drivers/usb/mtu3/mtu3.h
+++ linux-next/drivers/usb/mtu3/mtu3.h
@@ -65,7 +65,7 @@ struct mtu3_request;
 #define MTU3_U3_IP_SLOT_DEFAULT 2
 #define MTU3_U2_IP_SLOT_DEFAULT 1
 
-/**
+/*
  * IP TRUNK version
  * from 0x1003 version, USB3 Gen2 is supported, two changes affect driver:
  * 1. MAXPKT and MULTI bits layout of TXCSR1 and RXCSR1 are adjusted,
@@ -74,7 +74,7 @@ struct mtu3_request;
  */
 #define MTU3_TRUNK_VERS_1003	0x1003
 
-/**
+/*
  * Normally the device works on HS or SS, to simplify fifo management,
  * divide fifo into some 512B parts, use bitmap to manage it; And
  * 128 bits size of bitmap is large enough, that means it can manage
@@ -85,7 +85,7 @@ struct mtu3_request;
 #define MTU3_FIFO_BIT_SIZE		128
 #define MTU3_U2_IP_EP0_FIFO_SIZE	64
 
-/**
+/*
  * Maximum size of ep0 response buffer for ch9 requests,
  * the SET_SEL request uses 6 so far, and GET_STATUS is 2
  */
@@ -103,6 +103,7 @@ enum mtu3_speed {
 };
 
 /**
+ * enum mtu3_g_ep0_state - endpoint 0 states
  * @MU3D_EP0_STATE_SETUP: waits for SETUP or received a SETUP
  *		without data stage.
  * @MU3D_EP0_STATE_TX: IN data stage
@@ -121,11 +122,12 @@ enum mtu3_g_ep0_state {
 };
 
 /**
- * MTU3_DR_FORCE_NONE: automatically switch host and peripheral mode
+ * enum mtu3_dr_force_mode - indicates host/OTG operating mode
+ * @MTU3_DR_FORCE_NONE: automatically switch host and peripheral mode
  *		by IDPIN signal.
- * MTU3_DR_FORCE_HOST: force to enter host mode and override OTG
+ * @MTU3_DR_FORCE_HOST: force to enter host mode and override OTG
  *		IDPIN signal.
- * MTU3_DR_FORCE_DEVICE: force to enter peripheral mode.
+ * @MTU3_DR_FORCE_DEVICE: force to enter peripheral mode.
  */
 enum mtu3_dr_force_mode {
 	MTU3_DR_FORCE_NONE = 0,
@@ -134,6 +136,7 @@ enum mtu3_dr_force_mode {
 };
 
 /**
+ * struct mtu3_fifo_info - HW FIFO description and management data
  * @base: the base address of fifo
  * @limit: the bitmap size in bits
  * @bitmap: fifo bitmap in unit of @MTU3_EP_FIFO_UNIT
@@ -145,7 +148,7 @@ struct mtu3_fifo_info {
 };
 
 /**
- * General Purpose Descriptor (GPD):
+ * struct qmu_gpd - General Purpose Descriptor (GPD):
  *	The format of TX GPD is a little different from RX one.
  *	And the size of GPD is 16 bytes.
  *
@@ -179,11 +182,13 @@ struct qmu_gpd {
 } __packed;
 
 /**
-* dma: physical base address of GPD segment
-* start: virtual base address of GPD segment
-* end: the last GPD element
-* enqueue: the first empty GPD to use
-* dequeue: the first completed GPD serviced by ISR
+* struct mtu3_gpd_ring - GPD ring descriptor
+* @dma: physical base address of GPD segment
+* @start: virtual base address of GPD segment
+* @end: the last GPD element
+* @enqueue: the first empty GPD to use
+* @dequeue: the first completed GPD serviced by ISR
+*
 * NOTE: the size of GPD ring should be >= 2
 */
 struct mtu3_gpd_ring {
@@ -195,6 +200,7 @@ struct mtu3_gpd_ring {
 };
 
 /**
+* struct otg_switch_mtk - OTG/dual-role switch management
 * @vbus: vbus 5V used by host mode
 * @edev: external connector used to detect vbus and iddig changes
 * @id_nb : notifier for iddig(idpin) detection
@@ -222,6 +228,7 @@ struct otg_switch_mtk {
 };
 
 /**
+ * struct ssusb_mtk - SuperSpeed USB descriptor (MTK)
  * @mac_base: register base address of device MAC, exclude xHCI's
  * @ippc_base: register base address of IP Power and Clock interface (IPPC)
  * @vusb33: usb3.3V shared by device/host IP
@@ -268,6 +275,7 @@ struct ssusb_mtk {
 };
 
 /**
+ * struct mtu3_ep - common mtu3 endpoint description
  * @fifo_size: it is (@slot + 1) * @fifo_seg_size
  * @fifo_seg_size: it is roundup_pow_of_two(@maxp)
  */

