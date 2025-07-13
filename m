Return-Path: <linux-kernel+bounces-729013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22062B0308A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 11:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E96317F725
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D12A277026;
	Sun, 13 Jul 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="B3AJNb0c"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6262309B5
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752400344; cv=none; b=QM8FLoclDPUzjJu2ofiGfp9YoufKRU1M64nsjRS8wNgobMgz77icdq0GtJnPfGlX0oURgQD3ENFGjoZmz26btBBQsK7GRF123tjLW8JylOq0K57Dadzl+4EfE1HZiMxNBA2NevcZkO6HqDsvUNkDZUnRQIQ2CRq+FqYHsvLEcEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752400344; c=relaxed/simple;
	bh=W87lX2sL3B1KxSSRP0r3YgrT1PIAqEhsSKd6TF5iAuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WoouU2KdmTHNcSx8d02kLtas+6ig44zMOGdeIqOHNlDHWNi3eaacDg4Wf6hmB+/omRFox3NEZ+bwk6j+caqZF4Bc1mRZqyOhr2Gn/yE5LRuDpUP0psTEsYRp8wcKtC3IVyVIMgUvBQDXpeIvWbk7pY1U/GZxeSwBmHfjJmCXRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=B3AJNb0c; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752400334;
	bh=W87lX2sL3B1KxSSRP0r3YgrT1PIAqEhsSKd6TF5iAuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B3AJNb0c0k1o0wJWQQiFjYJifBGO6RjNbojQQ8nyGO5TkEJxaFC52oH/yuoZfkEd8
	 wHLvlo7v4A79F5UFpROoC7iQ+LdgZ5mAYI7H8VV2jk/BsxW5EA1rY4KPSpe2l3FQVl
	 zW+il3srtEuvSjkL8dr01K4/wWVChQ8yENXJGwvo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 13 Jul 2025 11:52:15 +0200
Subject: [PATCH RESEND v2 3/7] sysfs: introduce
 __SYSFS_FUNCTION_ALTERNATIVE()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250713-sysfs-const-attr-prep-v2-3-2f42510318a5@weissschuh.net>
References: <20250713-sysfs-const-attr-prep-v2-0-2f42510318a5@weissschuh.net>
In-Reply-To: <20250713-sysfs-const-attr-prep-v2-0-2f42510318a5@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752400333; l=1400;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=W87lX2sL3B1KxSSRP0r3YgrT1PIAqEhsSKd6TF5iAuY=;
 b=uFmhsIH5cBfUOTqoCg7vj99HMgBB79/NP/9iUPi+cAryoypI+YoAL6eryyvJw3ZxsPh7KKF6r
 DoLdJi09gbuBPxNxnvxr5SNQmBFgJNjL1PSN3jm5AQ9OxytWo985DiU
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


