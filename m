Return-Path: <linux-kernel+bounces-850861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2139BD444D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82551886839
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F26830B51C;
	Mon, 13 Oct 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gvpolZHj"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B21D30AD07
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368681; cv=none; b=AtmRzlZZwx4Vt9M6rvsPQb9fulvjrC917lODbvGcafjG9eyXH45RjsXHNDWDRrDZhv1Ih59akoRW6vWUxmABicAPKr+7oBQpesm2XfJ0JEZfwtgpwBnlq6CnLkJFVhwotG5cHHfcTEvm7XwT72DGYp9fAtBCf0epc3URZWvk+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368681; c=relaxed/simple;
	bh=dm4gTICqg1OgZaecjOSXE0OQrJAwU67NZfNKwaH4c3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQxik+JZ49JUz/tZRqVNzpuFhe+FiPLSOx3kghF1/3A4JA46vzEjUqfJ1Ii9BoJ2Y9hkMZ2/Ma8sllGEHBJ1qDbJI6jHV9j8Nd8WFDR6Wm9BHzp7YBnqDgtHyW3X3FcF3546eLgPnysgTJ1ZWyraDI1FFmnGijiDazs5Gac2M5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gvpolZHj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760368678;
	bh=dm4gTICqg1OgZaecjOSXE0OQrJAwU67NZfNKwaH4c3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gvpolZHjecBcORbnp+/DhkBvjDScZsZ44gsoeiOUGQF9QliiUW5jan5zxs4UPPano
	 ccyeUadTgsjjlWDzh5mvO6g6Tzo1sNBsuTSj/X7speDlHaXnO0KbB3gSQr25Olw78s
	 5hlo/LxhMbPxKW5naNGIkJm8ZUeMO0Bb978kkg6M=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 17:17:58 +0200
Subject: [PATCH v4 5/7] samples/kobject: add is_visible() callback to
 attribute group
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-sysfs-const-attr-prep-v4-5-e0d36e828334@weissschuh.net>
References: <20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net>
In-Reply-To: <20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760368676; l=1275;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dm4gTICqg1OgZaecjOSXE0OQrJAwU67NZfNKwaH4c3g=;
 b=B8MMKxepjwjk2NJ+wbUDB9FnqXY/K50XUPXNHtULvEtcic+Gz2bLDObnlKyL2lXYV9e94Avwg
 xakxUN5/jG8CQKrXvLeNg0P3MABtLtczY1bu0qEs/IXu/8oHu7vxH43
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

There was no example for the is_visible() callback so far.

It will also become an example and test for the constification of
'struct attribute' later.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 samples/kobject/kset-example.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index 579ce150217c..1aac595ed949 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -178,7 +178,22 @@ static struct attribute *foo_default_attrs[] = {
 	&bar_attribute.attr,
 	NULL,	/* need to NULL terminate the list of attributes */
 };
-ATTRIBUTE_GROUPS(foo_default);
+
+static umode_t foo_default_attrs_is_visible(struct kobject *kobj,
+					    struct attribute *attr,
+					    int n)
+{
+	/* Hide attributes with the same name as the kobject. */
+	if (strcmp(kobject_name(kobj), attr->name) == 0)
+		return 0;
+	return attr->mode;
+}
+
+static const struct attribute_group foo_default_group = {
+	.attrs		= foo_default_attrs,
+	.is_visible	= foo_default_attrs_is_visible,
+};
+__ATTRIBUTE_GROUPS(foo_default);
 
 /*
  * Our own ktype for our kobjects.  Here we specify our sysfs ops, the

-- 
2.51.0


