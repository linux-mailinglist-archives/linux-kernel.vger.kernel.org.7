Return-Path: <linux-kernel+bounces-762176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560A3B20306
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F3420953
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8D52DECC2;
	Mon, 11 Aug 2025 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DvEvvSxA"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA12DE6FE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903678; cv=none; b=svSl5qPTKQSk42l2dkhbAwr+PLoZk/h+2RPECDFuRUyu+jke/tkhQZmWt4op5XUF0QUWkzdLup1RHXltnmv1NpaNHt0YPCypnA0U74p3UcN1WUuY0A19w+Y0Uh97YcvlAhskciYFlY3YUmFn2xPDzuIE1+LANFwzIqaY59oFXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903678; c=relaxed/simple;
	bh=AIte5Rjg6BxBjZaqnkGlhXa3GSlWbi2KFz56gvpWyYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TtWR7a//QscGHEoMvc3BsSZy+I40oWcB9aHENPNywG6u7hzPFXFj5/0UGwvUibTk14q0WyBUCBRlIn/8ODRNe47PB5v9xFVOOkfCi44qCSn0VajufcszB1snhBxesHfz7EUsWOgA6nLpmE2Fte8afGCl9G70naGObub5j2G+fN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DvEvvSxA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754903671;
	bh=AIte5Rjg6BxBjZaqnkGlhXa3GSlWbi2KFz56gvpWyYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DvEvvSxA1+jVu9S6BVD+vKnDyv7itkUezwgNxl/4cBLi3gVu+vv5eRFIJrC+tFt+C
	 DY9zqP++siDrT1yGmMrIw+GhT0jeijsplZjG/WAhjaa7xfRZ6bUvN+3dUgUDBSB3pQ
	 3UOzdwKVvJ2gZb2Ca6rNCqSs+daUGSdY1JpHYC4E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 11 Aug 2025 11:14:31 +0200
Subject: [PATCH v3 5/7] samples/kobject: add is_visible() callback to
 attribute group
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-sysfs-const-attr-prep-v3-5-0d973ff46afc@weissschuh.net>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
In-Reply-To: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754903670; l=1331;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AIte5Rjg6BxBjZaqnkGlhXa3GSlWbi2KFz56gvpWyYM=;
 b=Lb/bpjwn15cGqRhoBQwepr4+DWBfuULU/3jSb92Emnw3456ff85lTNO+hHadENsVQcoKQH45I
 ZpI9yC7XUg4Cpwi5fHw0TG5PAgX6j6R+nIJfxYpIq4RlYdWwLwsDGJO
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
index 579ce150217c6e613887e32a08206573543b3091..1aac595ed9498b30448485a60d9376cb5b5ea1d3 100644
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


