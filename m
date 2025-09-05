Return-Path: <linux-kernel+bounces-803234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C146B45C75
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF513A00AFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62132F7AC3;
	Fri,  5 Sep 2025 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="r3gubX1N"
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896923D7F8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085820; cv=none; b=E/NzIIdvOJxHkVHKO6nqKGYhKZMo8h/tfVqAgHQh3DzW6egj+bzHk1slWBuVP/NA7Gz0eyxfI5l7eF372mGe9GPRlU2sWnEc/Q5tBKKF22b/zLV1H8hYF5mSxNLeUq4r+HEuaMNda+EtCrX3lqSgNi+J7e+ODKc4QWbMwbvM7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085820; c=relaxed/simple;
	bh=S/ML7WZ1uTpSMmbmHDUhBmDT8Vs7Wg0IF2zur/NJRnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=efEdvHqWNXF283VRXCwJoFCwF8syXlY7dIvfLSqRnbE6MXRwjFj2hvWOcxQo5AVVKLuplfPDdhYYWeOHA59gB9ZJGo5n84SGzEa0iX5UyHX/ipc8r8wMnltKChKoWY6Oc4Gf/sdhlkepjPzT5PW74IzCJj+3nIfoMyt3SUKabOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=r3gubX1N; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
From: Eric Hagberg <ehagberg@janestreet.com>
To: linux-kernel@vger.kernel.org
Cc: Eric Hagberg <ehagberg@janestreet.com>,
 	stable@vger.kernel.org
Subject: [PATCH] x86/boot/compressed/64: clear high flags from pgd entry in configure_5level_paging
Date: Fri,  5 Sep 2025 11:14:31 -0400
Message-ID: <20250905151431.2825114-1-ehagberg@janestreet.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1757085454;
  bh=sQWCESy/4YoQ7ON6d1VtuvMNA3SUhWe2COWsmV3LXhc=;
  h=From:To:Cc:Subject:Date;
  b=r3gubX1NVHSXJIAd4gu88nrKdKp+J15IjXbBY4/Vyw+438ZgKItMXIHfa3h6In8kf
  4w6gVWk0nIpRZz9xqCj9VysQbWfqY9USV/VoGwlr6QicuqMfJro6Bqc35LfVxRaC0D
  WCIGFexF0IIaz5ZzV/PXNN8FoNic5061ea8bFosBWHwtE771GzC8lZeu5IZb9o0pY6
  5wEuRoURRc8YOGpfp+QHhjBmNe4MaARt1ZcBMpsMCHZ9zjwnzQh55I6UoEp8mrezYu
  K7M7Kq/1bkIDjyKr+nhjVwwhnZHrGGHWOwDRMTW4kAbFFPPc1CSH7wiVf6rZMJVgmF
  963nQ3nbSHA7Q==

In commit d0ceea662d45 ("x86/mm: Add _PAGE_NOPTISHADOW bit to avoid
updating userspace page tables") we started setting _PAGE_NOPTISHADOW (bit
58) in identity map PTEs created by kernel_ident_mapping_init. In
configure_5level_paging when transiting from 5-level paging to 4-level
paging we copy the first p4d to become our new (4-level) pgd by
dereferencing the first entry in the current pgd, but we only mask off the
low 12 bits in the pgd entry.

When kexecing, the previous kernel sets up an identity map using
kernel_ident_mapping_init before transiting to the new kernel, which means
the new kernel gets a pgd with entries with bit 58 set. Then we mask off
only the low 12 bits, resulting in a non-canonical address, and try to
copy from it, and fault.

Fixes: d0ceea662d45 ("x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables")
Signed-off-by: Eric Hagberg <ehagberg@janestreet.com>
Cc: stable@vger.kernel.org
---
 arch/x86/boot/compressed/pgtable_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index bdd26050dff7..c785c5d54a11 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -180,7 +180,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 		 * We cannot just point to the page table from trampoline as it
 		 * may be above 4G.
 		 */
-		src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
+		src = *(unsigned long *)__native_read_cr3() & PTE_PFN_MASK;
 		memcpy(trampoline_32bit, (void *)src, PAGE_SIZE);
 	}
 
-- 
2.43.7


