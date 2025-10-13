Return-Path: <linux-kernel+bounces-850364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F5BD29F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C30513448CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FFE303CAA;
	Mon, 13 Oct 2025 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pTjoi4kk"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F72FDC41
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352508; cv=none; b=gHiojChMZj3nCPLBg2r44jD737b14avuLvtm2e8RXWUtyz7FqWLU2NnZesEMIP5opY8KyfamnEkugpAGNG4qGu70gt67nXgaP1fH4uKaF+akh0uR+KTW2DVhh6DWt3G99AROjiB8fIBrJdQK+yGPam63xdLBdNTESCG2BgaI8wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352508; c=relaxed/simple;
	bh=1LBGK3TkrPoW63QLWYmeLol3aNiWj2Xkcr6MKYmW53w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5Hyp2kwp9FUM5fWdASvZg8zcpnKLsLBwnPX63t4fTi/Op4IdfMtXNUuwGItcJITSfrEa9fd3C/+mO0zvagXz0xQXHIA7sYchrjxRRaTs5FuT0fvoohGZmUNObDqvqBd0GEtQV8KwL09xvfX7AGPBIFqFV1FoMgPuiBNyxBAGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pTjoi4kk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760352024;
	bh=1LBGK3TkrPoW63QLWYmeLol3aNiWj2Xkcr6MKYmW53w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pTjoi4kk9KMK8YhfuDbvKy/w8317zuHva+xyx2B0jEZuCR9YB/UW+sL00F92mSFeD
	 GmVQdZ0h5YCxnD+1UZVrskky1mqiQSrmV74y897v86iSxwzGeAR19m6TwALBbLZpwx
	 fhCYQDk0m0uGc7WNeR0f3dL9HB3VVNZZsDJgMjvI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 12:40:19 +0200
Subject: [PATCH 2/4] x86/um/vdso: Use prototypes from generic vDSO headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-uml-vdso-cleanup-v1-2-a079c7adcc69@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352023; l=1093;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1LBGK3TkrPoW63QLWYmeLol3aNiWj2Xkcr6MKYmW53w=;
 b=MsrwrxDOXOU/dVReY9Htl3GJq1AC/ZpJPqTe1SC8mLKREvu7kOV34WL64CxKeKIs5+9fkTc2Y
 2nmIHBraG5fCGhikb0qvbXJ6rE8PCShGHBl+CbPbUqbiraEzJ8Z2iwu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The generic vDSO library provides a convenient header for the vDSO
function prototypes, use it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/um/vdso/um_vdso.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index 5cadcc04d422..02d41fdb5655 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -9,14 +9,12 @@
 /* Disable profiling for userspace code */
 #define DISABLE_BRANCH_PROFILING
 
+#include <vdso/gettime.h>
 #include <linux/time.h>
 #include <linux/getcpu.h>
 #include <asm/unistd.h>
 
 /* workaround for -Wmissing-prototypes warnings */
-int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
-int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
-__kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
 long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
 
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)

-- 
2.51.0


