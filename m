Return-Path: <linux-kernel+bounces-851719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF4BD721F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793E93A4F46
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676B82FFF89;
	Tue, 14 Oct 2025 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TMEZi4kB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E901F239B
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410835; cv=none; b=LCu/MLOq2cShvXe6BTZ2qL+nPHq9B7NzOKBjUfJDpUjt2oR2qh2bAqwTr7/wAy1nHk3T8MdNNuKiPhhPLabYUrICgzdva+hgUMNA1jF4ThVBjnMmPCWYwOp6S7CMt11z0r5YCfW8Mrxv3UDl44b6Z8HwOGL8RxHrL/EX/T+C82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410835; c=relaxed/simple;
	bh=gN7Y64XPH1v6BbvQx6OuSvY1gJnDjmQQzG6JZjFDn34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOLtpQjMcGg1EaDVt6m6cxf9u6bJuMgPz5coeucU6D9KP4y1YlY3C9rIch2wpiWrCKaoY/YMsSNs7B7MHWr6kzckHlWjK7cik10Hsyz3w11f+iaSSlX+fNQ0C0cBWPY+gxXth7g/i0qd++Jj9buVS9qJRJuNj5Chd75PVpDCOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TMEZi4kB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=p5zB5BlzE1gYfG5UC1xZutrWrB4UFAYVHYExZLV5Cdw=; b=TMEZi4kBu03EYm3HiAKEYYwo8U
	PhTyfzKoVJAD57X2l/sihpDgYuksZKKDtSEFp+4keGSTzfFDYMBBtRgeI3gJBcR41N7qJylR/KISw
	VnHqncYHTPLkLn6gDB2UYjV18wrKqEjTQ4SZD4XqzBuwsUqhAa4Aqbsk4+SyQ89Dv0iwaqEEcfKuv
	rjWHdlSt3uoOxZ/GOSiUmtjLp8RdWx3pbocpgk/zoGU3gQ5tegMKUL6XVOEfGKm14RQpxNXpMMYT7
	+mKUsD+gHg/mXskbDcfMyZIxDXJJXrum8to1gamRR1Hv7mT73Dj0Zc1Y+V5dnlSM35xDw+tveYuHr
	Tt73bFGw==;
Received: from [50.53.43.113] (helo=smtpauth.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8VH4-00000004sCd-1X7F;
	Tue, 14 Oct 2025 03:00:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	Jens Taprogge <jens.taprogge@taprogge.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	industrypack-devel@lists.sourceforge.net
Subject: [PATCH] ipack: fix ipack.h kernel-doc warnings
Date: Mon, 13 Oct 2025 20:00:26 -0700
Message-ID: <20251014030026.759198-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various kernel-doc warnings in ipack.h:

Remove an empty kernel-doc comment.
Add 2 missing struct short descriptions.
Fix a typo in a description.
Add a missing struct field description.
Add some missing Return descriptions.
Clarify one function short description.

Warning: ../include/linux/ipack.h:73 Cannot find identifier on line:
 */
Warning: ../include/linux/ipack.h:74 Cannot find identifier on line:
struct ipack_region {
Warning: ../include/linux/ipack.h:75 Cannot find identifier on line:
        phys_addr_t start;
Warning: ../include/linux/ipack.h:76 Cannot find identifier on line:
        size_t      size;
Warning: ../include/linux/ipack.h:77 Cannot find identifier on line:
};
Warning: ../include/linux/ipack.h:78 Cannot find identifier on line:

Warning: ../include/linux/ipack.h:79 Cannot find identifier on line:
/**
Warning: ipack.h:80 missing initial short description on line:
 *      struct ipack_device
Warning: ipack.h:163 missing initial short description on line:
 *      struct ipack_bus_device
Warning: ipack.h:130 struct member 'id_table' not described in 'ipack_driver'
Warning: ipack.h:189 No description found for return value of 'ipack_bus_register'
Warning: ipack.h:194 No description found for return value of 'ipack_bus_unregister' ***
Warning: ipack.h:202 No description found for return value of 'ipack_driver_register'
Warning: ipack.h:221 No description found for return value of 'ipack_device_init'
Warning: ipack.h:236 No description found for return value of 'ipack_device_add'
Warning: ipack.h:271 No description found for return value of 'ipack_get_carrier'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Jens Taprogge <jens.taprogge@taprogge.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: industrypack-devel@lists.sourceforge.net
---
 include/linux/ipack.h |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- linux-next-20251013.orig/include/linux/ipack.h
+++ linux-next-20251013/include/linux/ipack.h
@@ -70,15 +70,13 @@ enum ipack_space {
 	IPACK_SPACE_COUNT,
 };
 
-/**
- */
 struct ipack_region {
 	phys_addr_t start;
 	size_t      size;
 };
 
 /**
- *	struct ipack_device
+ *	struct ipack_device - subsystem representation of an IPack device
  *
  *	@slot: Slot where the device is plugged in the carrier board
  *	@bus: ipack_bus_device where the device is plugged to.
@@ -89,7 +87,7 @@ struct ipack_region {
  *
  * Warning: Direct access to mapped memory is possible but the endianness
  * is not the same with PCI carrier or VME carrier. The endianness is managed
- * by the carrier board throught bus->ops.
+ * by the carrier board through bus->ops.
  */
 struct ipack_device {
 	unsigned int slot;
@@ -124,6 +122,7 @@ struct ipack_driver_ops {
  * struct ipack_driver -- Specific data to each ipack device driver
  *
  * @driver: Device driver kernel representation
+ * @id_table: Device ID table for this driver
  * @ops:    Callbacks provided by the IPack device driver
  */
 struct ipack_driver {
@@ -161,7 +160,7 @@ struct ipack_bus_ops {
 };
 
 /**
- *	struct ipack_bus_device
+ *	struct ipack_bus_device - IPack bus representation
  *
  *	@dev: pointer to carrier device
  *	@slots: number of slots available
@@ -185,6 +184,8 @@ struct ipack_bus_device {
  *
  * The carrier board device should call this function to register itself as
  * available bus device in ipack.
+ *
+ * Return: %NULL on error or &struct ipack_bus_device on success
  */
 struct ipack_bus_device *ipack_bus_register(struct device *parent, int slots,
 					    const struct ipack_bus_ops *ops,
@@ -192,6 +193,8 @@ struct ipack_bus_device *ipack_bus_regis
 
 /**
  *	ipack_bus_unregister -- unregister an ipack bus
+ *
+ *	Return: %0
  */
 int ipack_bus_unregister(struct ipack_bus_device *bus);
 
@@ -200,6 +203,8 @@ int ipack_bus_unregister(struct ipack_bu
  *
  * Called by a ipack driver to register itself as a driver
  * that can manage ipack devices.
+ *
+ * Return: zero on success or error code on failure.
  */
 int ipack_driver_register(struct ipack_driver *edrv, struct module *owner,
 			  const char *name);
@@ -215,7 +220,7 @@ void ipack_driver_unregister(struct ipac
  * function.  The rest of the fields will be allocated and populated
  * during initalization.
  *
- * Return zero on success or error code on failure.
+ * Return: zero on success or error code on failure.
  *
  * NOTE: _Never_ directly free @dev after calling this function, even
  * if it returned an error! Always use ipack_put_device() to give up the
@@ -230,7 +235,7 @@ int ipack_device_init(struct ipack_devic
  * Add a new IPack device. The call is done by the carrier driver
  * after calling ipack_device_init().
  *
- * Return zero on success or error code on failure.
+ * Return: zero on success or error code on failure.
  *
  * NOTE: _Never_ directly free @dev after calling this function, even
  * if it returned an error! Always use ipack_put_device() to give up the
@@ -266,9 +271,11 @@ void ipack_put_device(struct ipack_devic
 	 .device = (dev)
 
 /**
- * ipack_get_carrier - it increase the carrier ref. counter of
+ * ipack_get_carrier - try to increase the carrier ref. counter of
  *                     the carrier module
  * @dev: mezzanine device which wants to get the carrier
+ *
+ * Return: true on success.
  */
 static inline int ipack_get_carrier(struct ipack_device *dev)
 {

