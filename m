Return-Path: <linux-kernel+bounces-839630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA295BB20AF
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 01:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55787B1A3E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 23:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C954F22FDE8;
	Wed,  1 Oct 2025 23:01:10 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD120468D;
	Wed,  1 Oct 2025 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359670; cv=none; b=XNoQvRWxrh6nj0sbyet+lf2m0oZRs0QUDo4O9Eqvo/FvydEO//ZCwkWs4YsCHz8Lrquo60lxZKPdEs1ztjTOCf4j1BXBC9jiTZF8vKqGELISl8xSvd1lsY3gF50dF+lkIM1lN85ymYiQ6gAbU6tz/34w0ZpL9OPqx0VlD4Uo6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359670; c=relaxed/simple;
	bh=g1lAUYudTpPqZXDYdfWdsA3Hy0Dj0A2tT6SBbbh+2NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MaAuOhiUOq2mqarAQ1c+1acv1niAX49NA4ViB23wqdV2cEB+TmLfS2X/W2agf1JQdJ/xDTSScFIWSRwEeYv4l0Ry8hQ2V6kUJra7EoQEKhfitLU+m0m+GZDZU8n+6ABBjOI9ecHsaf0TJ+8/kv1B5+kTHVq+EOxHeIHuIaOyt1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 0CFEE340BE2;
	Wed, 01 Oct 2025 23:01:05 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>
Cc: Sam James <sam@gentoo.org>,
	Stian Halseth <stian@itx.no>,
	Magnus Lindholm <linmag7@gmail.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: don't reference obsolete termio struct for TC* constants
Date: Thu,  2 Oct 2025 00:00:32 +0100
Message-ID: <99f1a93cf8cd4f0ece8611be2860677084663aac.1759359610.git.sam@gentoo.org>
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
Co-authored-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Sam James <sam@gentoo.org>
---
v3: Fix constants per Magnus.
v2: Fix title.

 arch/alpha/include/uapi/asm/ioctls.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/uapi/asm/ioctls.h
index 971311605288f..a09d04b49cc65 100644
--- a/arch/alpha/include/uapi/asm/ioctls.h
+++ b/arch/alpha/include/uapi/asm/ioctls.h
@@ -23,10 +23,10 @@
 #define TCSETSW		_IOW('t', 21, struct termios)
 #define TCSETSF		_IOW('t', 22, struct termios)
 
-#define TCGETA		_IOR('t', 23, struct termio)
-#define TCSETA		_IOW('t', 24, struct termio)
-#define TCSETAW		_IOW('t', 25, struct termio)
-#define TCSETAF		_IOW('t', 28, struct termio)
+#define TCGETA          0x40127417
+#define TCSETA          0x80127418
+#define TCSETAW         0x80127419
+#define TCSETAF         0x8012741c
 
 #define TCSBRK		_IO('t', 29)
 #define TCXONC		_IO('t', 30)
-- 
2.51.0


