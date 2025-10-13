Return-Path: <linux-kernel+bounces-850866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F7EBD4486
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673C51884650
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8886D30BB82;
	Mon, 13 Oct 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GxaKm0VB"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA63128B6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368684; cv=none; b=BSj70aZtfxjmtRAxA1I1STivCTbVlo2eIT8iMidVd1Iy8+Lgwp1OULZE+TTuzGy+UliU7ct089pSOEl0no1JkHtLpUVEfl4FKwgRNQEGDJMI0/sVKy1bz+KSX/fPyxX5dcP9vS3UT0DKKTA0jTBcykKZpZoyF3tCInwy2bf/rX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368684; c=relaxed/simple;
	bh=EMXTzVHacQ1r9rYJzvj8RPO+T9sQPK+/cpWqLdb5FT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fP24JsTi3ge2RaCvH8LdUZWduJ9lAHrbUaprdEMNlDksfFo/zi9rX7A/+Wdq4suya/kOsLDUHynSSrWcgngAAU1Kz05XE+e1U1PWc54RrbAxjFscLuUdEm8N/pA+qaVY+TJSw7DH6ZulnE7y26jeK8cqbr48/AyvZjuj9NGdT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GxaKm0VB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760368678;
	bh=EMXTzVHacQ1r9rYJzvj8RPO+T9sQPK+/cpWqLdb5FT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GxaKm0VB+cc/c9X5j2pVJpDa3bkXMAopOKyicEcKqUDSEeY0pKEOI9jWOUlpKgqhu
	 RBiRiD1k6XM9Ap9ijBYH53X633s+hqzjY76oStC+RFdkJG2bwW4ZIdOZkUUsFF8exZ
	 pFW+/Oh1L9aUeScOQKEgxCZRAv2cETRl33t3T81k=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 17:18:00 +0200
Subject: [PATCH v4 7/7] sysfs: simplify attribute definition macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-sysfs-const-attr-prep-v4-7-e0d36e828334@weissschuh.net>
References: <20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net>
In-Reply-To: <20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760368676; l=1937;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EMXTzVHacQ1r9rYJzvj8RPO+T9sQPK+/cpWqLdb5FT0=;
 b=n9YHRjuatErfi4EG0WyI/TEBJh5u/9bNGdnjdgWr4qY7t4Y4JKvE+0eHCfVeT6+Y0kVD4sYac
 OJ9sjT3D2PnCzHhXZFF1rpEeMXBYQKeNr326JSHadnCX0pwKVxd8ZAD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Define the macros in terms of each other.
This makes them easier to understand and also will make it easier to
implement the transition machinery for 'const struct attribute'.

__ATTR_RO_MODE() can't be implemented in terms of __ATTR() as not all
attributes have a .store callback. The same issue theoretically exists
for __ATTR_WO(), but practically that does not occur today.

Reorder __ATTR_RO() below __ATTR_RO_MODE() to keep the order of the
macro definition consistent with respect to each other.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index ec4aed8c8181..5ce303dec7d7 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -251,28 +251,20 @@ struct attribute_group {
 	.store	= _store,						\
 }
 
-#define __ATTR_RO(_name) {						\
-	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
-	.show	= _name##_show,						\
-}
-
 #define __ATTR_RO_MODE(_name, _mode) {					\
 	.attr	= { .name = __stringify(_name),				\
 		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
 	.show	= _name##_show,						\
 }
 
-#define __ATTR_RW_MODE(_name, _mode) {					\
-	.attr	= { .name = __stringify(_name),				\
-		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
-	.show	= _name##_show,						\
-	.store	= _name##_store,					\
-}
+#define __ATTR_RO(_name)						\
+	__ATTR_RO_MODE(_name, 0444)
 
-#define __ATTR_WO(_name) {						\
-	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
-	.store	= _name##_store,					\
-}
+#define __ATTR_RW_MODE(_name, _mode)					\
+	__ATTR(_name, _mode, _name##_show, _name##_store)
+
+#define __ATTR_WO(_name)						\
+	__ATTR(_name, 0200, NULL, _name##_store)
 
 #define __ATTR_RW(_name) __ATTR(_name, 0644, _name##_show, _name##_store)
 

-- 
2.51.0


