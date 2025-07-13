Return-Path: <linux-kernel+bounces-729016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01418B0308D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 11:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B497161CAC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2957C27933F;
	Sun, 13 Jul 2025 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rHuXrBe/"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7427780D
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752400346; cv=none; b=b6brgpqJZPR2QoykewxA/XIh+YJ5xqnx6fvPab7D7wg4Ugic/2UcrjCPwhuIoKsvkaNGEmDmfXELiE27a0gaffLf3QWQhxkTbixOy13Kq6FvsB2U7Thynl8HMhggp/2xLuT50VhvNCxl4l/LyVNLqPhma+AfCeZnW7QA+r2qECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752400346; c=relaxed/simple;
	bh=cdJ7D3EdF5PJUi2CpxhbFNXtNwJFZM1ws1Y5su+CL44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4KURm/tcSbGPQPgnVgixQnnFWPk8Rg3Iaqjsfr4nNDRGu0nl+UJL763TPWz0CYk135J/Yu+JX0BjK7vDyb4BhPaGW0glfiyrtT3aAOD6Fv+K2gyaZxt3NznuD1EJWOw1hVVsyoh4b9TKJjLMfIk8U9Us+Gc/l43rX6Cgj2F4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rHuXrBe/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752400334;
	bh=cdJ7D3EdF5PJUi2CpxhbFNXtNwJFZM1ws1Y5su+CL44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rHuXrBe/2R8baWoV8a7QViSmRkmX8IQZlMtR/tCxBhzVUZieTB02UgidgZ4eurHDX
	 AYtkfu1obeV+zKcL+3AaWSsIO0auWrKUsHbskpJmXyRnU5IpJEFExIBlBpl/E+JNw3
	 UChKfpKq4jB2hyxUE4gSzM83IceVFclhHwzzggvU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 13 Jul 2025 11:52:19 +0200
Subject: [PATCH RESEND v2 7/7] sysfs: simplify attribute definition macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250713-sysfs-const-attr-prep-v2-7-2f42510318a5@weissschuh.net>
References: <20250713-sysfs-const-attr-prep-v2-0-2f42510318a5@weissschuh.net>
In-Reply-To: <20250713-sysfs-const-attr-prep-v2-0-2f42510318a5@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752400333; l=2010;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=cdJ7D3EdF5PJUi2CpxhbFNXtNwJFZM1ws1Y5su+CL44=;
 b=BWuOOJHvLGvd04yz9wDHBC3eJ5miHxOPhZCnWKKN06p6MfAZYKQuzio1wWoKTLMkTEC5Nqv4M
 brcIcBeT58oA9Sh+Q+A1JXVo3IvCsvn11pIhPTei5+FRK+qtFvSXNsF
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Define the macros in terms of each other.
This makes them easier to understand and also will make it easier to
implement the transition machinery for 'const struct attribute'.

__ATTR_RO_MODE() can't be implemented in terms of __ATTR() as not all
attributes have a .store callback.
The same issue theoretically exists for __ATTR_WO(), but practically it
does not occur inside the current tree.

Reorder __ATTR_RO() below __ATTR_RO_MODE() to keep the order of the
macro definition consistent with respect to each other.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 1807b0369bd4d993deab81c4497903468b751a19..2d6f984e10a96ab9916024ae7b72458edf0c5bd6 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -254,28 +254,20 @@ struct attribute_group {
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
2.50.1


