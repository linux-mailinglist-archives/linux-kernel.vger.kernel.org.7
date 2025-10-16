Return-Path: <linux-kernel+bounces-855480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF844BE15EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504EF19A29EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4E018C008;
	Thu, 16 Oct 2025 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejyR8HoU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA4433C4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585763; cv=none; b=P+WbVzRP/Vw5aTaKV+9nwP+qxw+qLAngFqOZE/xedYLFUQI2GL+z11z92LHsT5zzyjTYsqW6eKAZwJ8lO6Xm5TvWgA2n+mOPLuwIuRt9ZEky4UDCY0xV7o8TNUDU38WxQvNKjKVWjUROFVABQ1WxjopFD5Or59HCPSKTasX49CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585763; c=relaxed/simple;
	bh=l5rTux2wxu+QKHK7pXYKfIgq7TRwY71ZmNv8aZcYVzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGvK9RYm41RsIjpYoqPxF4jQdXUK4H2IAr0g+PXcbjPZxw2ksjxBUDWMtLspXy1sVSWH/VDiQp0Dk0UgkgZu8EQrnhRSlkPkiZe36JFVnYod1jx0U1+2h3DM1zU1Ng52LS2Rq7FUU0KCC2drWMqGl7ctWkwBE/2TbqybFcgdT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ejyR8HoU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=H9qSlColPO6uZAQQbyL92LE31zkOMC1U83EF7nWfIBo=; b=ejyR8HoUxXftCA3ApxM1xw+C2b
	ShoFZIM1jEpncBJ1XunV0CCva6TfJ8tPT4grzV6wOStd69FvgPypXW9DoUCeMkxKRkN1VCPDnzIaX
	iRDMdcH5yGHx+QuUksHGRrMkVV6znjACEQ5+W0jC2ZojsDBrUkhowFOJkjEVzOqBe+PyXuMClZt4W
	k8d5J0SIzO9KVeQ1maXqU8jbNQgS9DGOkPpLuHoHoMxcbr7z2bhHqSYemX1iosuy2Ax7zxfZBm3fI
	RTi2YFsKT0PsfqRKqZgaWH6FZaZ38vl24qNZjU43jK55V8HO6wky5bvJ0i7CzTiBgOmnUvAsBuz98
	LIorAFFg==;
Received: from [50.53.43.113] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9EmH-0000000Cxht-3sEt;
	Thu, 16 Oct 2025 03:35:50 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	Jens Taprogge <jens.taprogge@taprogge.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	industrypack-devel@lists.sourceforge.net
Subject: [PATCH v2] ipack: fix ipack.h kernel-doc warnings
Date: Wed, 15 Oct 2025 20:35:43 -0700
Message-ID: <20251016033543.1142049-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various kernel-doc warnings in ipack.h:

 - Remove an empty kernel-doc comment.
 - Add 2 missing struct short descriptions.
 - Fix a typo in a description.
 - Add a missing struct field description.
 - Add some missing Return descriptions.
 - Clarify one function short description.

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
v2: reformat patch description with indents (Vaibhav)

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

