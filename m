Return-Path: <linux-kernel+bounces-839444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DE2BB1A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2753A4ECE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3722D63E8;
	Wed,  1 Oct 2025 19:40:17 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9562D347B4;
	Wed,  1 Oct 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347617; cv=none; b=oGQNq/PKX6wh+CmnXuxqnWWBC8paaWTtlZIjTgr4JGZ+vsfoQevXAF9g2hP1Nm+eV4DpGQ46b051g7TgV1/9lFeOpmTuMG+M+DhHO8CGLFgTR7vHqxh+TnvLRIZlH2gsz+5YUhjjQSEjkVz8/XhxRVawk41Azy3DIOZJ5tiyxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347617; c=relaxed/simple;
	bh=GjvKThdNt9MwfVXiKim86Oku7IsGjWscR/bHrE8L4uI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEPHDkKGU2EOZf49roowsXe8/NcxrFQTx1t6QVqi/Dk149gzijz+ny7VWhr0Ob3FMD0s9dhx+w8mu3OkV0ZSGTplq+Gd0OZXb+OQjyz6/SsBNzTRzoOZu5obW+4Okopj5HH5+EUe1eXqMw2ODNBzSHSHgOoaT1ornB4WGc/LlUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3CFB8340E15;
	Wed, 01 Oct 2025 19:40:12 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>
Cc: Sam James <sam@gentoo.org>,
	Stian Halseth <stian@itx.no>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] parisc: don't reference obsolete termio struct for TC* constants
Date: Wed,  1 Oct 2025 20:39:50 +0100
Message-ID: <d55e5e19c4d30ab1602718b1263d051413edf562.1759347592.git.sam@gentoo.org>
X-Mailer: git-send-email 2.51.0
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
 arch/parisc/include/uapi/asm/ioctls.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/include/uapi/asm/ioctls.h b/arch/parisc/include/uapi/asm/ioctls.h
index 82d1148c6379a..b90253c8265ae 100644
--- a/arch/parisc/include/uapi/asm/ioctls.h
+++ b/arch/parisc/include/uapi/asm/ioctls.h
@@ -10,10 +10,10 @@
 #define TCSETS		_IOW('T', 17, struct termios) /* TCSETATTR */
 #define TCSETSW		_IOW('T', 18, struct termios) /* TCSETATTRD */
 #define TCSETSF		_IOW('T', 19, struct termios) /* TCSETATTRF */
-#define TCGETA		_IOR('T', 1, struct termio)
-#define TCSETA		_IOW('T', 2, struct termio)
-#define TCSETAW		_IOW('T', 3, struct termio)
-#define TCSETAF		_IOW('T', 4, struct termio)
+#define TCGETA          0x5405
+#define TCSETA          0x5406
+#define TCSETAW         0x5407
+#define TCSETAF         0x5408
 #define TCSBRK		_IO('T', 5)
 #define TCXONC		_IO('T', 6)
 #define TCFLSH		_IO('T', 7)
-- 
2.51.0


