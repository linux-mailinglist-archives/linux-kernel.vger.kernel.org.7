Return-Path: <linux-kernel+bounces-873245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F98CC1378B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F0F4213DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76162D6401;
	Tue, 28 Oct 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="F53UDBxv"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651D280A20
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639204; cv=none; b=f3kTQz/koHKf+KbVQy77dPDH0tFxK1sC+cgCw2Iwh4dGgogT2Vxr6wMbhaOQU71pL2cT5DWzQjHEEYtxtwLoosNFPgMNDDJ+G0RnqqxXp46vythMovr8TH+dGHpgVHDXBtQ9sv8AE6lMyEeeYcu+0I358Sp1NU3SMcq/2B1Aqvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639204; c=relaxed/simple;
	bh=2Qhzd2oGV2/6F82WeamAOfteFOsJBQS3O9GOKbu3nbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qomCLbUB1jHo8o/T3QWZ/J19HKtPr9FlY9m77RJjr0bcdglnmgKnDC6CAaIMmypKvwUPFKRV6VG9b+dBBcwljScQgmvbl6XQV9Zw0SA5Gk1zyBkDmw03mSSHWJBk62LvBp4SWeDHtkHpoKQdAS2tIEUgO5VUza4N5tWg/b/FY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=F53UDBxv; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761639199;
	bh=2Qhzd2oGV2/6F82WeamAOfteFOsJBQS3O9GOKbu3nbc=;
	h=From:Date:Subject:To:Cc:From;
	b=F53UDBxvBeF7d84PJVk+CpKcJVzkfoJK1Ksf9Mo2pFwGcnOOEUKqRZj6i0IUvcYoO
	 xj+OGQk10d73vCBfskU+u/wvN2x/uYmkFK8/WryZOzhpf+OP+2urqHX8ztBLmFBisT
	 2GMsditRZDAi2vG1mnPH4nuCjv9wibFv/CkfbW+4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 09:13:18 +0100
Subject: [PATCH] tools/nolibc: remove outdated comment about __sysret() in
 mmap()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-nolibc-map-failed-comment-v1-1-75af291ce011@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAB17AGkC/x3MwQqEIBCA4VeJOTegssHWq0QHR6d2IDU0IpDef
 aXjd/j/CoWzcIGpq5D5kiIpNui+A/ezcWMU3wxGmUEr88WYdiGHwR64WtnZo0shcDzRa/sZiWh
 Q5KH1R+ZV7vc9L8/zB8baCrhrAAAA
X-Change-ID: 20251028-nolibc-map-failed-comment-d1a49bbb50bd
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761639198; l=1136;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2Qhzd2oGV2/6F82WeamAOfteFOsJBQS3O9GOKbu3nbc=;
 b=D7ASp6uN7gVteodQn7MZ7VYMQ0W8l4SG2tLpX6x6kE0SKb4Sa6D3X2NX/m6HQS22ertL7pTFV
 YH/AZtpijOWBYdKp3tdgzq0+tAqt7wL9EVa9xMaE81Sxe1c/7e1RvQj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Since commit fb01ff635efd ("tools/nolibc: keep brk(), sbrk(), mmap()
away from __sysret()") the implementation of mmap() does not use the
__sysret() macro anymore.

Remove the outdated comment.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys/mman.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/include/nolibc/sys/mman.h b/tools/include/nolibc/sys/mman.h
index 5228751b458c..77084ac3405a 100644
--- a/tools/include/nolibc/sys/mman.h
+++ b/tools/include/nolibc/sys/mman.h
@@ -31,11 +31,6 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 }
 #endif
 
-/* Note that on Linux, MAP_FAILED is -1 so we can use the generic __sysret()
- * which returns -1 upon error and still satisfy user land that checks for
- * MAP_FAILED.
- */
-
 static __attribute__((unused))
 void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
 {

---
base-commit: 2602949b22330f1275138e2b5aea5d49126b9757
change-id: 20251028-nolibc-map-failed-comment-d1a49bbb50bd

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


