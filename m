Return-Path: <linux-kernel+bounces-850865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAE0BD447D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0BF1883BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F338313280;
	Mon, 13 Oct 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YX4mAnnB"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD330AD09
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368684; cv=none; b=Of4RZweaF74XMPrMp+VV64c8kTeiS7efxfMGpDcjPpHUU69J6P4+9/YdP792aWhcAR4JSycgAl3FozGDLgqs3Jj4fk1MkkRy9LJA4+XU6QjBsil5nRBAy+m3xm7aQDFoLele3G60GFiSmMOR98JR3b44K3/6vEAfJblRMFB4FGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368684; c=relaxed/simple;
	bh=hzol1noZC1ZW5OidI1eG4X/7ERixSktCfo7WToDn4Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=he6jEV8+top5Lyl4yqATdMmhOmjulTzxiz+WZWByJ6HgYwU6AtGNkFwF6k3wI+vKHWiug/jFXHqeA/U1X8PqWb0+oJpb470T/qDcZCIojGfuKc0gYf8LB82w6efwWmzJTvLzwC0r3HIGi71JHMuUJVQos52mQeGPlndv1H9kgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YX4mAnnB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760368677;
	bh=hzol1noZC1ZW5OidI1eG4X/7ERixSktCfo7WToDn4Ic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YX4mAnnBzUwomHzXUgIMl2M+CAK0tIw9IopNhPdO2q63jnDfhprMgs79xFo9+63ca
	 OLCE66+d70A+kgN4y4OWkPJNe7aCpVd2kx/iNEXqYF/7gWiSe8OgMueDdn9LQVydYf
	 +/h+J2ekBUhS5nr4TOLX2uVM2HVuQB8/8mMo2Hfw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 17:17:56 +0200
Subject: [PATCH v4 3/7] sysfs: introduce __SYSFS_FUNCTION_ALTERNATIVE()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-sysfs-const-attr-prep-v4-3-e0d36e828334@weissschuh.net>
References: <20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net>
In-Reply-To: <20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760368676; l=1343;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hzol1noZC1ZW5OidI1eG4X/7ERixSktCfo7WToDn4Ic=;
 b=DxQQe91LKiMRQGS7dyyMuogPmI/jmlZ9J0F4SL+pwO8xdJv5/sGpd2pqAPkIyHEC4wBxqgTSJ
 SPb4KYXzDTYBVqZHt0tUxjqtvhVfbprr8CHmgnh2MHuSbK2b3uCWz7W
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

For the constification phase of 'struct attribute' various callback
struct members will need to exist in both const and non-const variants.
Keeping both members in a union avoids memory and CPU overhead but will
be detected and trapped by Control Flow Integrity (CFI). By deciding
between a struct and a union depending whether CFI is enabled, most
configurations can avoid this overhead. Code using these callbacks will
still need to be updated to handle both members explicitly.
In the union case the compiler will recognize that testing for one union
member is enough and optimize away the code for the other one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 92f82cee5f11..02e5a9f946ee 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -58,6 +58,12 @@ do {							\
 #define sysfs_attr_init(attr) do {} while (0)
 #endif
 
+#ifdef CONFIG_CFI_CLANG
+#define __SYSFS_FUNCTION_ALTERNATIVE(MEMBERS...) struct { MEMBERS }
+#else
+#define __SYSFS_FUNCTION_ALTERNATIVE(MEMBERS...) union { MEMBERS }
+#endif
+
 /**
  * struct attribute_group - data structure used to declare an attribute group.
  * @name:	Optional: Attribute group name

-- 
2.51.0


