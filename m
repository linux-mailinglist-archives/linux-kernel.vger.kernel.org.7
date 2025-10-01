Return-Path: <linux-kernel+bounces-839620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC57BB2073
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A3187A6397
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5D8312823;
	Wed,  1 Oct 2025 22:59:31 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7F3126CB;
	Wed,  1 Oct 2025 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359571; cv=none; b=X84+VZSBjVjUGMbZQ/cYvdDsE65yefRdcznzZ77bQJaDfqpogyMO0qnNiMmCkKdLEoYc3Bw6B725NrVIQc8SpqQ81eehRKTiCqnYohsJrczrvApsdl92XdFeHJRTyaFpCFp9sp7LWwL6/dZV867oGn5sHUWzkJElqChNGJeZgQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359571; c=relaxed/simple;
	bh=C11U6wK5w7dhJJuII20LLz7PGV065cBlJUDvooRpgw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsjHTFWEE5YGx3I/SddWdF4JswubsNM1LqSgrYNEZpmBMrUJTcpg4ZpTG/eeNRBqSx4lezizjh7o/o6SiukGHOgdDJbmCSkYmbnyA2cd5ocJPz9SlINoqqNE4HUQ/pvWbLO+kVrxq2+FB6rQLlcUYQaXMtOKHkBYo5/HIF/PJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 1C173340A98;
	Wed, 01 Oct 2025 22:59:27 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>
Cc: Sam James <sam@gentoo.org>,
	Stian Halseth <stian@itx.no>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: don't reference obsolete termio struct for TC* constants
Date: Wed,  1 Oct 2025 23:58:40 +0100
Message-ID: <e567e380598a35683541853b0b38da9cc53098e4.1759359520.git.sam@gentoo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <fc2e8775d55f43e08eb79d326d6fdd89291898dd.1759347737.git.sam@gentoo.org>
References: <fc2e8775d55f43e08eb79d326d6fdd89291898dd.1759347737.git.sam@gentoo.org>
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
This fixes a mistake in the constants as I mixed up arches. Helge, could
you replace the patch with this one instead? Or do you want me to send
a fixup patch on top of that?

 arch/parisc/include/uapi/asm/ioctls.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/include/uapi/asm/ioctls.h b/arch/parisc/include/uapi/asm/ioctls.h
index 82d1148c6379a..74b4027a4e808 100644
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
+#define TCGETA          0x40125401
+#define TCSETA          0x80125402
+#define TCSETAW         0x80125403
+#define TCSETAF         0x80125404
 #define TCSBRK		_IO('T', 5)
 #define TCXONC		_IO('T', 6)
 #define TCFLSH		_IO('T', 7)
-- 
2.51.0


