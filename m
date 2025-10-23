Return-Path: <linux-kernel+bounces-867617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F456C031FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 484314E6D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09AB2F691B;
	Thu, 23 Oct 2025 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdmDjyF4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583112571D4;
	Thu, 23 Oct 2025 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246100; cv=none; b=qXuJgASUS+T7yoFk91zQRjm359D/2XvSLW+B0YwfIT3+1NGGJojhPc/prJrEwTMPDBiI5T4TpGBp+a6DyTpVU+yDBgS/feS4lCL6l6YX1gTp8ad5vbiwYRB6U0/IfyB13Sq5trkYVNjU9BiKEGOM3L2hesfKZZheeBBaIIMTRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246100; c=relaxed/simple;
	bh=Rl/OP3FUtJNNdUtSALnXRPKL3CMR9JuwjVxR8uU0OvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hdyNnbmEQIN02kgNe4wS1Qf8mkMbOIwhUyrMVp9Kj6oKr7F9tmZFAqKt5mP5GTkyQ7hQcl8/X6Ut8QmBiEx+lQ1Ec0+qni25ev6LCNrUNgDzUfn+QzJf6EcezRFnsHvhro00m4O09gJFFehGn9NbWqEWfO/QB1mEEGSv3dS0ubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdmDjyF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F97C4CEE7;
	Thu, 23 Oct 2025 19:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761246099;
	bh=Rl/OP3FUtJNNdUtSALnXRPKL3CMR9JuwjVxR8uU0OvA=;
	h=From:Date:Subject:To:Cc:From;
	b=KdmDjyF4mvdZ/KlLwBcAWfYN+cmsezIappNMctorGGbd+64oe3Xbv2d8bFQf0w+Ca
	 7OxtqMf3GUxC1pvHSHD9HF/hg5KZMjK4hmL++1GSp665lcTl8kljxzYpsFxfREs+yU
	 S5Uyd/fk63E4NkxE+wmeZXJUJpQYwMP29dHaRXf7MKNU5Z5jUcCL7Hguu2orA8gZhk
	 ba3XYKBWlQM+mO8mJY6fJC5JD9rjpSnIOAWDGlGtzqb4VW4mBtWHiAfL/2dlnyQB++
	 INZS0sprULDtDZuJlt1lp2uN2p0GimKrQNv4J2qc7CGFidlu8nQXqbhh+z9vf7KEse
	 EKd+MPjxvfo4A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 23 Oct 2025 21:01:29 +0200
Subject: [PATCH] KMSAN: Restore dynamic check for
 '-fsanitize=kernel-memory'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-fix-kmsan-check-s390-clang-v1-1-4e6df477a4cc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIh7+mgC/x3MTQqDQAxA4atI1gbmBynTqxQXGjM1TDvKBKQg3
 r3B5YOPd4JyE1Z4dic0PkRlqxa+74DWqb4ZZbGG4MLgXYiY5Yflq1NFWpkKakwO6WMUfXJLfMw
 z5RzBBntj0/f8NV7XH/7mBb1sAAAA
X-Change-ID: 20251023-fix-kmsan-check-s390-clang-190d37bbcff3
To: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>
Cc: Nicolas Schier <nsc@kernel.org>, Kees Cook <kees@kernel.org>, 
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, kernel test robot <lkp@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Rl/OP3FUtJNNdUtSALnXRPKL3CMR9JuwjVxR8uU0OvA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBm/qiced1v7d/lK5Smz3a4c4Np8yvxnmv2BiNWeplO29
 S3fdbaov6OUhUGMi0FWTJGl+rHqcUPDOWcZb5yaBDOHlQlkCAMXpwBM5PxpRoaT+72Ltly+qla7
 +8WsD+m/dlx7eObXHXWJN7PuOvL89xUpZfifuvvo8lWik+0Kf687Kbsi4Gthn6lF+u3d5+ZWyW7
 5fMuHHQA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit 5ff8c11775c7 ("KMSAN: Remove tautological checks") changed
CONFIG_HAVE_KMSAN_COMPILER from a dynamic check for
'-fsanitize=kernel-memory' to just being true for CONFIG_CC_IS_CLANG.
This missed the fact that not all architectures supported
'-fsanitize=kernel-memory' at the same time. For example, SystemZ / s390
gained support for KMSAN in clang-18 [1], so builds with clang-15
through clang-17 can select KMSAN but they error with:

  clang-16: error: unsupported option '-fsanitize=kernel-memory' for target 's390x-unknown-linux-gnu'

Restore the cc-option check for '-fsanitize=kernel-memory' to make sure
the compiler target properly supports '-fsanitize=kernel-memory'. The
check for '-msan-disable-checks=1' does not need to be restored because
all supported clang versions for building the kernel support it.

Fixes: 5ff8c11775c7 ("KMSAN: Remove tautological checks")
Link: https://github.com/llvm/llvm-project/commit/a3e56a8792ffaf3a3d3538736e1042b8db45ab89 [1]
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202510220236.AVuXXCYy-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I plan to take this via kbuild-fixes for 6.18-rc3 or -rc4.
---
 lib/Kconfig.kmsan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
index 7251b6b59e69..cae1ddcc18e1 100644
--- a/lib/Kconfig.kmsan
+++ b/lib/Kconfig.kmsan
@@ -3,7 +3,7 @@ config HAVE_ARCH_KMSAN
 	bool
 
 config HAVE_KMSAN_COMPILER
-	def_bool CC_IS_CLANG
+	def_bool $(cc-option,-fsanitize=kernel-memory)
 
 config KMSAN
 	bool "KMSAN: detector of uninitialized values use"

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251023-fix-kmsan-check-s390-clang-190d37bbcff3

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


