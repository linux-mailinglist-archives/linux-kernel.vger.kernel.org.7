Return-Path: <linux-kernel+bounces-839443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB5CBB1A19
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2785D2A71B9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD132D59FA;
	Wed,  1 Oct 2025 19:40:17 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95659335C7;
	Wed,  1 Oct 2025 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347616; cv=none; b=n4aWZ9aolrzDeZm0iquZftD1WJkmlmJdZ6kL5izMNe+TvFFROIYFhkCq/cxyppioa8GEr9bboZyZxrb7ohgP2DYdnjE2iDx1BVhT0NGY1Xzl7AjkbCamzeZ2zcjJsAg+YIEm1OTEkHmCdZNTkqMaIXwDD8DmCdTbcuDbWYYPQWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347616; c=relaxed/simple;
	bh=J56mz6NnRk7lZ5MgIF9qe7mwYMQfzelsGhhabldQLm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quQmJtRlBf8ChhVsefbPT2XLlbiX1KsrQlaNVlgnCDnBKuu3P0c/9jhiJNoavEA+iJwdQycr66p+xPYvjtlku2X1UR2SH3o06sSQoYnJaooG2YD30h+IpEodsD4vl/wuTkUbzOTUUxXQJ8QTAvLsskbsosNQY8fmgBzd3tEpvSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E8334340E16;
	Wed, 01 Oct 2025 19:40:13 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>
Cc: Sam James <sam@gentoo.org>,
	Stian Halseth <stian@itx.no>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] alpha: don't reference obsolete termio struct for TC* constants
Date: Wed,  1 Oct 2025 20:39:51 +0100
Message-ID: <01fd56ffad6a29c92a93938a55f56dc4a6e8371e.1759347592.git.sam@gentoo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <d55e5e19c4d30ab1602718b1263d051413edf562.1759347592.git.sam@gentoo.org>
References: <d55e5e19c4d30ab1602718b1263d051413edf562.1759347592.git.sam@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar in nature to ab107276607af90b13a5994997e19b7b9731e251. glibc-2.42
drops the legacy termio struct, but the ioctls.h header still defines some
TC* constants in terms of termio (via sizeof). Hardcode the values instead.

This fixes building Python for example, which falls over like:
  ./Modules/termios.c:1119:16: error: invalid application of 'sizeof' to incomplete type 'struct termio'

Link: https://bugs.gentoo.org/961769
Link: https://bugs.gentoo.org/962600
Co-authored-by: Stian Halseth <stian@itx.no>
Signed-off-by: Sam James <sam@gentoo.org>
---
 arch/alpha/include/uapi/asm/ioctls.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/uapi/asm/ioctls.h
index 971311605288f..857e280f95d1e 100644
--- a/arch/alpha/include/uapi/asm/ioctls.h
+++ b/arch/alpha/include/uapi/asm/ioctls.h
@@ -23,10 +23,10 @@
 #define TCSETSW		_IOW('t', 21, struct termios)
 #define TCSETSF		_IOW('t', 22, struct termios)
 
-#define TCGETA		_IOR('t', 23, struct termio)
-#define TCSETA		_IOW('t', 24, struct termio)
-#define TCSETAW		_IOW('t', 25, struct termio)
-#define TCSETAF		_IOW('t', 28, struct termio)
+#define TCGETA          0x5405
+#define TCSETA          0x5406
+#define TCSETAW         0x5407
+#define TCSETAF         0x5408
 
 #define TCSBRK		_IO('t', 29)
 #define TCXONC		_IO('t', 30)
-- 
2.51.0


