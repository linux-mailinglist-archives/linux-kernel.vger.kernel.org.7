Return-Path: <linux-kernel+bounces-875430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3298CC190F4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FD2407313
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87382D46B1;
	Wed, 29 Oct 2025 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Fq2271Uz"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8731B137
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725548; cv=none; b=Th/ZWgeGI982ohl7WmT1cXpMja0Y4pFbK/H3NSF/pmbtQT4MvunjOz5AcxqhkdAlZuPPxid/lLAKQk0OrgyeoEwPM25PkxjoYqSn1ORt/J/ldoyoV7GdfcM1nqLzBDslJ1C23OcjA2GGp8VQEF3u/wbPO7qbeIhyoIYpCPsCKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725548; c=relaxed/simple;
	bh=syHV3tyj6les3ZkK7XNdRxpEE5VUzXh5wQdxQ7YotzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ryUFb4Yq4UtGqThEwf5JPmPNYxATrWH7BlM/p8VVk8TrauoooWyzQ+h5svrhA5TKRQ2+I7FUt9cPc7FrWAXP17Wlyd7slTND4BiW0X+02GOmnVbjPpSYGYw+4Lg5TLhj9VpFPeU5rRUDiqiLu5+7YuUkg486TgV7P8lLKWhNx+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Fq2271Uz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761725542;
	bh=syHV3tyj6les3ZkK7XNdRxpEE5VUzXh5wQdxQ7YotzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fq2271Uz+9A2lAKYb4TIpYsXPH9Oeaz1WQEwlNVrDRb46GcgqSFW2Z8jBjyI+i4pt
	 5J5htRi5t/NVvLPp2zqLLQ0jpo1BoQs5f09tWT/8rceUIMJ6dAQs2nJR/kN8vgUsPY
	 G1m0qPKNaN7jz7lAipSVjNEgEHprObW4WBWtAlmk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 09:12:16 +0100
Subject: [PATCH v5 7/7] sysfs: simplify attribute definition macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-sysfs-const-attr-prep-v5-7-ea7d745acff4@weissschuh.net>
References: <20251029-sysfs-const-attr-prep-v5-0-ea7d745acff4@weissschuh.net>
In-Reply-To: <20251029-sysfs-const-attr-prep-v5-0-ea7d745acff4@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725539; l=1943;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=syHV3tyj6les3ZkK7XNdRxpEE5VUzXh5wQdxQ7YotzA=;
 b=J/UyntzDaMe5tIDA7uFvK/eLolLaZq4DUB/HRcNI4P8VxeAKOnXw8inrSjVZYVUaRFol5ZRKz
 AES05Sg/xHBABZxrAOJiUtDyzf8XH/4eOFugybChzaCR4G0KUGqrzUT
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
index 592886ed6ca9..c33a96b7391a 100644
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
2.51.1.dirty


