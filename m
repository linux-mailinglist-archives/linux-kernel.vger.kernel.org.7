Return-Path: <linux-kernel+bounces-834214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E59BA4344
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC50618989ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A751F09B3;
	Fri, 26 Sep 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dkbw00RB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n3qiOmUZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB01C32FF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896830; cv=none; b=PUam7UBxL3zNCOYK7/RIYV9DeYDnaI3nRJvzdRl6lPrRkclhVWBYJJDUDeEvl1Fi5QYvcwx2LBoeSECVAtbaqgN74K6L0k8VI4UzJONWQOXZ2XRKUkx1vubkj0BhKcJDphSmzpJs+iB4mHqNCwN4mdnZaR/czrMwr7aPTklrECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896830; c=relaxed/simple;
	bh=lcDQRiCPya8vcqhTTqYOmiGofxrEghenqoSraXXfUro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y2cI7sjjV1dJBJ1bw+Qb8b1v03fZSGsgAZuct1WvD4gF8TrNdAlrTSg8nahkDW5uiXDV2DE1CBHGbli7evRnarG1vEDc840cAKCZKVoAb8c1IgkMgPNEuXNNKLs/L4RMptc+rY3Dtvpmhvdghqa5n5Ry+zBTS8EFt66peXX7RY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dkbw00RB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n3qiOmUZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758896825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hoykd/ZYbPKM0Mz2PJ8cWxo2hA1pM+9vY9snyfQBfNU=;
	b=dkbw00RBj1Jb7+GRrFp/hhO/ZPTgb3ps0PkznJCzd2m4bYbo+gl14O9MupVaaQn0SEF84V
	SZ3bdEeBeo9nfXK8wjQM9bquTXCNq+/shC2sFge+DBm4+0bwdo0SAg9Uhijoylomdjzsf1
	vhXYkQznO/yUfG60oN4pHct3KN3fTCRm7DO9mRLvX6oStN+jWE87c5k4esPl6pvZZqHe2Q
	/RDkmVuxqSltWU4BEXVe0GkmYw+zxQdqY9YhgYlP3nV4fW3pQjN9E0o2Vw9G/6gkGtZ1dJ
	BX+OpvfA4/rG7SQQvBhGu9M1GzkC0yTSF0M8b9WdAhuXPAyzzfL9VXsqHrVVVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758896825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hoykd/ZYbPKM0Mz2PJ8cWxo2hA1pM+9vY9snyfQBfNU=;
	b=n3qiOmUZU2vv0db31hLJKs0xiXXby5VF+gMk7CGLqWR7QLAvGdRgihH4PmSPNeMwHt7M5e
	Ura6Qn0J9+0Bt8Dg==
Date: Fri, 26 Sep 2025 16:26:58 +0200
Subject: [PATCH] tools/nolibc: handle NULL wstatus arugment to waitpid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250926-nolibc-waitpid-nullable-v1-1-4e90500f6ffa@linutronix.de>
X-B4-Tracking: v=1; b=H4sIALGi1mgC/x3MSQqAMAxA0atI1gZqi4peRVx0iBooVVonEO9uc
 fkW/z+QKDIl6IsHIp2ceA0ZVVmAXXSYCdllgxSyFp1sMKyejcVL876xw3B4r40ndEIJMqrplGs
 h11ukie//PIzv+wHzs/KZaQAAAA==
X-Change-ID: 20250926-nolibc-waitpid-nullable-d030eb3693d7
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758896819; l=1642;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lcDQRiCPya8vcqhTTqYOmiGofxrEghenqoSraXXfUro=;
 b=ZqFWTQxo3B4Nmw3i7B98qk5e4zxasTBpdbga9JyP1D0nWxhp/rwDoVE9eMHiWvTvJ41Jjv4b2
 NYvuR97pVCQC9G9OqzD921xc2hunDIKIp+XRpDAUBSnhIFRNb+kkOLE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

wstatus is allowed to be NULL. Avoid a segmentation fault in this case.

Fixes: 0c89abf5ab3f ("tools/nolibc: implement waitpid() in terms of waitid()")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/sys/wait.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/include/nolibc/sys/wait.h b/tools/include/nolibc/sys/wait.h
index 4e66e1f7a03e4585c91ec4ea68333b910600239a..9d9319ba92cbd31ee00afa85a2105d7bb00751b8 100644
--- a/tools/include/nolibc/sys/wait.h
+++ b/tools/include/nolibc/sys/wait.h
@@ -65,23 +65,29 @@ pid_t waitpid(pid_t pid, int *status, int options)
 
 	switch (info.si_code) {
 	case 0:
-		*status = 0;
+		if (status)
+			*status = 0;
 		break;
 	case CLD_EXITED:
-		*status = (info.si_status & 0xff) << 8;
+		if (status)
+			*status = (info.si_status & 0xff) << 8;
 		break;
 	case CLD_KILLED:
-		*status = info.si_status & 0x7f;
+		if (status)
+			*status = info.si_status & 0x7f;
 		break;
 	case CLD_DUMPED:
-		*status = (info.si_status & 0x7f) | 0x80;
+		if (status)
+			*status = (info.si_status & 0x7f) | 0x80;
 		break;
 	case CLD_STOPPED:
 	case CLD_TRAPPED:
-		*status = (info.si_status << 8) + 0x7f;
+		if (status)
+			*status = (info.si_status << 8) + 0x7f;
 		break;
 	case CLD_CONTINUED:
-		*status = 0xffff;
+		if (status)
+			*status = 0xffff;
 		break;
 	default:
 		return -1;

---
base-commit: 2d965c1ae4135ed6f505661458f6dabd39488dac
change-id: 20250926-nolibc-waitpid-nullable-d030eb3693d7

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


