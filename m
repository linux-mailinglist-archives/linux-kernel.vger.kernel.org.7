Return-Path: <linux-kernel+bounces-850365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC2EBD29FD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F0B44F02B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2C43043B5;
	Mon, 13 Oct 2025 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="J6mngZ5l"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24D302179
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352510; cv=none; b=vC7DZuKKLcrwd5lxSqVVAUXcWNSFKqKIuG1XNx+13FoGr994Otymhzc8I5IyNpI37ejPAMunvtbdeyYX7Ir+0IVtbbEsWid/HGnd3SLKX5Xj8gcr2Rz9gSsgOyfNx0zGsUBiOhG0ydF0gNtyKOjAQdCpWPtKRbON/A5BYJw3aek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352510; c=relaxed/simple;
	bh=1LVkRx8kRsF68/oifLyumQVqZEvOwQPq1xNG3PoVF1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZlQCucnwsAtzsypxY0PwDxkWR9uNdPxJ16wuMwP8ldF4OJDI5PLZOTrPmoWeIRwAFH+uWJtF/mzAzO+o1fcNujS2VUUZ/pjQC8sQz/poa+95q0uRlJA+6M1zqoQ7H6Ol2I9/j9JoccQYnItewKlBS0SOn1kN3GwUTLZPMagABEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=J6mngZ5l; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760352024;
	bh=1LVkRx8kRsF68/oifLyumQVqZEvOwQPq1xNG3PoVF1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J6mngZ5lrtIRvMVqQUBJixn0amS1NZH/0oIVAzVy8lRtWUVPuqh7z7s3OcWJ3FVTm
	 /NXElh7G6j6Hzijz7uaA7kKOXcT2GH4xTamjNhd0JQp3oyEJFyIj8ZbHb0XvOhQzPo
	 mSDPSaY/361xM+3FffvLTOMVnzgLNnznjVNnj2go=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 12:40:18 +0200
Subject: [PATCH 1/4] x86/um/vdso: Fix prototype of clock_gettime()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-uml-vdso-cleanup-v1-1-a079c7adcc69@weissschuh.net>
References: <20251013-uml-vdso-cleanup-v1-0-a079c7adcc69@weissschuh.net>
In-Reply-To: <20251013-uml-vdso-cleanup-v1-0-a079c7adcc69@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352023; l=1689;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1LVkRx8kRsF68/oifLyumQVqZEvOwQPq1xNG3PoVF1A=;
 b=6UzajuXf5P86gem69w6a2djFM4jes8KR7Z+AzzHnTw4uM+roZNNIk2t1Jq+8CO6OVy0pS/y+F
 PC1ENOK3eoBBrpWRQyQSH5h8EA2YJElWI2s0v3x8dePl7ZxczNQsnBN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The clock_gettime() system call takes a pointer to
'struct __kernel_timespec', not 'struct __kernel_old_timespec'.
Right now this is not an issue as the vDSO never works with the
actual struct but only passes it through to the kernel.

Fix the prototype for consistency with the system call.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/um/vdso/um_vdso.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index cbae2584124f..5cadcc04d422 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -14,12 +14,12 @@
 #include <asm/unistd.h>
 
 /* workaround for -Wmissing-prototypes warnings */
-int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts);
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 __kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
 long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
 
-int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
 	long ret;
 
@@ -30,7 +30,7 @@ int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 
 	return ret;
 }
-int clock_gettime(clockid_t, struct __kernel_old_timespec *)
+int clock_gettime(clockid_t, struct __kernel_timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)

-- 
2.51.0


