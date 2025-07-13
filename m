Return-Path: <linux-kernel+bounces-729018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9667B0308E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 11:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133211A60638
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D53D229B12;
	Sun, 13 Jul 2025 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IVoEelo/"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9E277CA9
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752400347; cv=none; b=FPOMQT3lJ0bOuuH8UgeLxI2X5bh6D78iVwGy/+GHVjW4T2PRvo/XRSBTSEkb/tlVuMMqBQV4CnzFzXko7OKvRiD474RfHpxWDg0ieHvv3wde9D+dZ2RwwEkuVCiQK+Ui+dLwbyu96ftjDy6bhJqW34MqXCcB4K/1hxjMs97RL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752400347; c=relaxed/simple;
	bh=Z//Faceuwef39wP/7RdyrYvgfLi9/56AANS8dtYn4Ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eTvM40ABnDKlJ/Ds0DBIIEWpVHXwGaV/sftub0bp6S/i9Kssgv4rx2zKpvBwpj8Lx3ChyXTkc4MadH6TBas5uH2m9hRkRfFqkL8xo/fjqpbCmNa7wRH0TaO+71GbXXK4tXRkdan2iGFxoeXjCQEpWQm5lUktqbgdvazXkY1TdD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IVoEelo/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752400334;
	bh=Z//Faceuwef39wP/7RdyrYvgfLi9/56AANS8dtYn4Ug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IVoEelo/prYQzxczKUMzM6n3aRFRCfChR5hzZHl1Of59In4InKz6YEnMD6D3Kild3
	 EMMxTmt+Gy1cgJZmqNxEitiGXJvMXTtDaBQ0V2v7OYZo6P1b2D61S61Q69AR5arDYK
	 i8dOVfFb73SrUNWO9gRF8D6Kzx/3xHgbC9j89jBg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 13 Jul 2025 11:52:17 +0200
Subject: [PATCH RESEND v2 5/7] samples/kobject: add is_visible() callback
 to attribute group
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250713-sysfs-const-attr-prep-v2-5-2f42510318a5@weissschuh.net>
References: <20250713-sysfs-const-attr-prep-v2-0-2f42510318a5@weissschuh.net>
In-Reply-To: <20250713-sysfs-const-attr-prep-v2-0-2f42510318a5@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752400333; l=1331;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Z//Faceuwef39wP/7RdyrYvgfLi9/56AANS8dtYn4Ug=;
 b=PJsEbGuzxyboB1sZTgIsX5Xk/jm+ebciTYh94GnU/XLuDXLhwRv+cd8G3i0gAUqHdxEEgGFr5
 us9gJk5CXIIBG1A991keKD2u5bCgP4z3vmOcEjASwM5CZjNHGys2c2o
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
index 552d7e363539a8f82ab8e0446c732f85ed2c5612..7d8c68763ff8af696cbafaed1d5f1b173bb4860e 100644
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
2.50.1


