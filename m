Return-Path: <linux-kernel+bounces-745029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1A9B113E1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307121CE4578
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914D223BCF8;
	Thu, 24 Jul 2025 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="KJMRc2su"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F823815D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396109; cv=none; b=ibUN7VN13YceiO/0cTwzAZyptczpYlV3eB4h1N/htQX2HCciQYSuhYFQDOuRlXD17PwSLPoO2ysfXNKwMuC3+ywkNwMAA2IFqjOplQgq2B7ulWo+bAqIJMHdiOI70Xc1SzVi/XPtD5+8fTnUdQ/Uai+HiGojHtTIZB3krYiQOKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396109; c=relaxed/simple;
	bh=3H7etlGw/Nhe6HAVo2NT3EYuY9jejwRantnF0G+Fhj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fTp23I6vmqVKbmmZq0DB0289tOk/UKPGDGxFI2+xUjBzsAufiYwAda1DtZiMCyISNkYCMp8ug1FYevg1bYizyOQ5n+GB1yHRQkNvYLW7IN5jObD9gXP1rhIzc7xG2yxiRoUDY9CvjUUcy34hFmpIXyjSoP2BRymlbph/JdyZOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=KJMRc2su; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
	Content-Description:In-Reply-To:References:X-Debbugs-Cc;
	bh=G1GIx/bTld7i3jsye2tQQaAkpBwO5F07jwxGvhnvPvo=; b=KJMRc2suV9oemaajHLxPMMOGLm
	qnIexYONwqIsa7DrXH7k3JRaSL3025hxN4tyP+8IUyAc6L7Mdomr11tbdcrM7tdtSDmHH/Mo8HMHk
	V655wS7asI5KIYt5TLhhCnrdypwarOK37XBFPywJaFArChP4uieK9W7OlSle+zyjdDTFJkCwjc8Cw
	vpVEyznQ3bnqTFTMBNu5TmtyDwrkQkUugxLLk47zYTn6mlf8/f+dIs+rvQQekljKpFxzy6GZQ/oS2
	suLq6bvms6guIufwl49pKPD/GLkzCwRs5i8kxcfQt9vI2LCzmzq6fFpeMe4fhsAZX4AItpgG7vAAM
	dxm1usuw==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1uf47U-00DlP2-0d;
	Fri, 25 Jul 2025 00:08:56 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Cc: Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH] riscv: uaccess: fix __put_user_nocheck for unaligned accesses
Date: Fri, 25 Jul 2025 00:08:52 +0200
Message-ID: <20250724220853.1969954-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The type of the value to write should be determined by the size of the
destination, not by the value itself, which may be a constant. This
aligns the behavior with x86_64, where __typeof__(*(__gu_ptr)) is used
to infer the correct type.

This fixes an issue in put_cmsg, which was only writing 4 out of 8
bytes to the cmsg_len field, causing the glibc tst-socket-timestamp test
to fail.

Fixes: ca1a66cdd685 ("riscv: uaccess: do not do misaligned accesses in get/put_user()")
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/riscv/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index b88a6218b7f24..22e3f52a763d1 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -311,7 +311,7 @@ do {								\
 do {								\
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&	\
 	    !IS_ALIGNED((uintptr_t)__gu_ptr, sizeof(*__gu_ptr))) {	\
-		__inttype(x) ___val = (__inttype(x))x;			\
+		__typeof__(*(__gu_ptr)) ___val = (x);		\
 		if (__asm_copy_to_user_sum_enabled(__gu_ptr, &(___val), sizeof(*__gu_ptr))) \
 			goto label;				\
 		break;						\
-- 
2.47.2


