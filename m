Return-Path: <linux-kernel+bounces-762170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F00B20301
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91011421EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2672DCF7C;
	Mon, 11 Aug 2025 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Di/Vm8G4"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006C2DCC1B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903674; cv=none; b=qTzAfB5gJU6sSe0WfUDRQNtDrQMTdkR6pgUsI3+XLdhYmrkRwO78xI2MLXoQ4htBybzqizpJmFgB2h9x6yzshXh96Uf1YSeu+B8Zimhw/bzmXTc9VsdjCrIJ8Xow//Vn2IxVSTvsrP/mQsLC87SqzRONfZoV+8hj/jJLaqCPuX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903674; c=relaxed/simple;
	bh=W87lX2sL3B1KxSSRP0r3YgrT1PIAqEhsSKd6TF5iAuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hRmPb4vICvw2j7pNuehLHI+yD68ab+37VtOMT/nSX3IHjnWnZrPqlWi/t8SzaXRCyCZ+85ys5xSYQhUGrSzsREVPjPmPQt1LwtxMzvD7rRSPx+2sAMbOvBkVAMIFOJKhdZWWHvNIx8lFVlflLdJfd3odQDSZ7gX0iON8VOJkNoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Di/Vm8G4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754903670;
	bh=W87lX2sL3B1KxSSRP0r3YgrT1PIAqEhsSKd6TF5iAuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Di/Vm8G4S8ogRplpGNWFyEQPAj9PUoYv8tDA/GslcuuiOPq8tJ2IXCCJI1/ZPDCfH
	 k/cvKVEvimXyn5xgWNzHTmB5JKic8/UfM//29yhutQgIJ7U0+WszveSYpQsAJgCFLp
	 1C0+qRgS6soE5rWFxqXeEDn4SiDBBNu8DMotTn9Q=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 11 Aug 2025 11:14:29 +0200
Subject: [PATCH v3 3/7] sysfs: introduce __SYSFS_FUNCTION_ALTERNATIVE()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-sysfs-const-attr-prep-v3-3-0d973ff46afc@weissschuh.net>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
In-Reply-To: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754903670; l=1400;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=W87lX2sL3B1KxSSRP0r3YgrT1PIAqEhsSKd6TF5iAuY=;
 b=zj5BTNH0VDhanoakw49qtnXU1O4RnvHWsQGfmJzqI/Rq1mvldEuz36vnc6j5ouAHh2tKb5tDo
 aVX+bVGMaXvBVGNygSldchvyi3wIWB6nF+LuXv8vFH+q7teOPhAjms9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

For the constification phase of 'struct attribute' various callback
struct members will need to exist in both const and non-const variants.
Keeping both members in a union avoids memory and CPU overhead but will
be detected and trapped by Control Flow Integrity (CFI).
By deciding between a struct and a union depending whether CFI is
enabled, most configurations can avoid this overhead.
Code using these callbacks will still need to be updated to handle both
members explicitly.
In the union case the compiler will recognize that testing for one union
member is enough and optimize away the code for the other one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 118a9b1d3b3e7528fb213d83f85d31bbac0dc309..3966947e78b8c030971daf5ee66bf5ab40bc2a17 100644
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
2.50.1


