Return-Path: <linux-kernel+bounces-875427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5ADC18EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56B1634FFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA72F31AF17;
	Wed, 29 Oct 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Thh1dyLx"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4179313269
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725545; cv=none; b=gB/5gPxbj/pO7NUOKloNjMhx5TXdfMCFGLox5i+iscWdbricV0VRL74Ds0gIt7CH6Tr+W0oosoDFBQ2UxClKNI6/yXMM+Ta/jehh0osg4DHABF7opFci44ajKnZ0NvaiFvECVIaBH0M94Q/8ZgZbZwpDRTtDlpZIEbjLYssWWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725545; c=relaxed/simple;
	bh=T4GDySY+12QZFTxg7oIvleS0IgVlOECCc0h2coxbMA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J5u2mBbh6JnoXDIWwJf200YyvAYde8fFUhoBdkPQDiRlWeodx1ZyEw2TmUd+amme2Z0SMS/Wf+sS4wksg+et4xyYOj4iHaCX2WhQMEwzgaGt11Qz1JzOBJ/H8f4ztsPZBXWFgARQUyfFyTFuDL2QEb0HEHkzrAKlrkDtEOtamhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Thh1dyLx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761725540;
	bh=T4GDySY+12QZFTxg7oIvleS0IgVlOECCc0h2coxbMA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Thh1dyLxtdLmGPqCarFWbEBPHOQW3lzvi68VQjds6zmvqDpKxpR2/D7ZYGvP9a9TE
	 Ej5dYwRVY77E/LMVk1MC8jCB7NCD0MPbUhpGGPO0TIxVFwH/JP89yXRme7px+dejkZ
	 TBfEusXpUcZgl1ouZIhZoehu5nuRWsYtnaYPwwt4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 09:12:12 +0100
Subject: [PATCH v5 3/7] sysfs: introduce __SYSFS_FUNCTION_ALTERNATIVE()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-sysfs-const-attr-prep-v5-3-ea7d745acff4@weissschuh.net>
References: <20251029-sysfs-const-attr-prep-v5-0-ea7d745acff4@weissschuh.net>
In-Reply-To: <20251029-sysfs-const-attr-prep-v5-0-ea7d745acff4@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725539; l=1343;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=T4GDySY+12QZFTxg7oIvleS0IgVlOECCc0h2coxbMA0=;
 b=gkobSXD0pzF5SBRjlRFzcx0oGQBnLPHHOKoz6DOR5+LkDpB81dUhtlXzfUv+IeqOo4bJcI0IM
 gQRQHoP8amZCkMcuOiOYj3wZ+M5Wtejfbx6s6Nx1PGLZlGCRRTa7WBg
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
index 92f82cee5f11..9cef5bf24ba7 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -58,6 +58,12 @@ do {							\
 #define sysfs_attr_init(attr) do {} while (0)
 #endif
 
+#ifdef CONFIG_CFI
+#define __SYSFS_FUNCTION_ALTERNATIVE(MEMBERS...) struct { MEMBERS }
+#else
+#define __SYSFS_FUNCTION_ALTERNATIVE(MEMBERS...) union { MEMBERS }
+#endif
+
 /**
  * struct attribute_group - data structure used to declare an attribute group.
  * @name:	Optional: Attribute group name

-- 
2.51.1.dirty


