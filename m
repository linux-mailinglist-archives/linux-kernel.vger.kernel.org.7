Return-Path: <linux-kernel+bounces-875429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25941C190FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A02463373
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9790831E0E4;
	Wed, 29 Oct 2025 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="U/lEPiZn"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D431B11C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725548; cv=none; b=lV3oSNyet6J1Sotj+qyVr+35mwJj1ih8ljzP2/8Y02Nq9rplmnva11KlyxgQAKHSwEUOjSt8DIgfpjqQVTmFOPrxXV0JrwiehfW7eBO57wDnw9mnQXVdYhDFYpJ3f3RZc4MdPSAcOY7uCZKElO9BKUwMxxirfKpY7Iyi+j9dZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725548; c=relaxed/simple;
	bh=C2IydpU5hcWQZVOVyKtsRIF55iGkuvWV7aaqsvWnHQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aDn5QyLSk/RFCoPa6fAOvy2QeR4cUIbU/SLzbU/4umVV+pzlRW4Bu597BcQZOSMIeJ+WR2qeBI7WK4/62zhAZRSeELbAcxBbVTf3lzNLDvAxSWRB4aAcQ8gejMUaYint3YPjmvntHmLrOWA8RpXNHEezxlqhvm8f/z1JMaVelFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=U/lEPiZn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761725541;
	bh=C2IydpU5hcWQZVOVyKtsRIF55iGkuvWV7aaqsvWnHQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U/lEPiZnoYuN9VNzuatzhfazDX8nEgb0324K43YOftXidUWw5NUdwL47D/bzjFBR0
	 jFnliB6WX646DyqsQ3RCCn5ZC87JVA4uyrk1dBrK46R/nFsRkrrFurmwaN4jlFAND9
	 EKA2nZPe/sm6RseX3KEPwhSDGhwYQv3qGSQAQtuc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 09:12:14 +0100
Subject: [PATCH v5 5/7] samples/kobject: add is_visible() callback to
 attribute group
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-sysfs-const-attr-prep-v5-5-ea7d745acff4@weissschuh.net>
References: <20251029-sysfs-const-attr-prep-v5-0-ea7d745acff4@weissschuh.net>
In-Reply-To: <20251029-sysfs-const-attr-prep-v5-0-ea7d745acff4@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725539; l=1281;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=C2IydpU5hcWQZVOVyKtsRIF55iGkuvWV7aaqsvWnHQM=;
 b=5JML33F84eRJeO6ECh7AtZ/qswSN5jCvGmupGuhkotk9V3EtY7OMqUYk1iUh36x1eF1QzBf14
 2l2pOaHaQOUBiuBul3h4JMimbzpjEJqG+KxWAaUdpsZT2NqwX2Q7vjH
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
2.51.1.dirty


