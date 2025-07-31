Return-Path: <linux-kernel+bounces-751752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B26DFB16D06
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7551AA7510
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C8E202C2A;
	Thu, 31 Jul 2025 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6tOIERH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D3E194A59
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948811; cv=none; b=fFjtXdgu/r697dDCvJIzSM6n0SA/yVSj+xbt0oD7q8tlQsa+T1Q1iIz6zrv099+IulX9JZAHQImfwjdoPDjnn+Euv3VhbFv0q0zp7pBjO8a7PdNxOYBFtHAhI6vGNdnDoYXyMgoy5nV8VBN4ThntRusM+d2VI6eU7Ou7fM3lh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948811; c=relaxed/simple;
	bh=4xDbxTT63MttPxZ1aQxDx6XS4uLn1H4yK96PfunOJ28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kmHdS8+cFILQXo5XX1GmBABFUkstgZ73MULDExCWtVRLeGV9xymBg41jDbGLMxY4JPGbMuBhq6hF9M2roVCBzdW1A6w0rsPhx7KXh/hfk+IXizykOS/fotjpwiDpfcf0QdrUtVxRGETVEsfwSR77SKJbq7+2Ulj6nUDCtO1h6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6tOIERH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3783C4CEF5;
	Thu, 31 Jul 2025 08:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753948810;
	bh=4xDbxTT63MttPxZ1aQxDx6XS4uLn1H4yK96PfunOJ28=;
	h=From:To:Cc:Subject:Date:From;
	b=b6tOIERHfXKH6FfNngK9vFA09b76y2fTpTS8r02Rny4lXuj6PmhrvtfaoeoqsUldd
	 UOi0Fl9toxsKno3lwGoXG9V/rEPUywWv71RGp6Ii1ms77lIDgf2R3gvFku0aub4T8j
	 a2lAzMgdwm0gwtch31w5udyErp7y5YA98qGf3KqI7If7AbQcM/T7ATk0QgluxrvGQH
	 t6aTDKcnFJWF+UfaPn/7OHUDKOJt79hBByBXs1HV4aEKE9mEzgHz288gO978+kI0Rl
	 KB+Io0hDApGCZF9DzylI4nr6daM0WLPT2gnL5jGaAleaeGjE2kMlZXv04JdJ85TOjg
	 yxNz62Sxzyw7A==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kho: fix kho_test_restore section mismatch warning
Date: Thu, 31 Jul 2025 10:00:00 +0200
Message-Id: <20250731080007.2037366-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

kho_test_restore_data() is not always inlined, and that configuration
causes a link warning:

WARNING: modpost: vmlinux: section mismatch in reference: kho_test_restore+0xd2 (section: .text.unlikely) -> kho_test_restore_data.isra.0 (section: .init.text)
ERROR: modpost: Section mismatches detected.

Mark it __init as well to be consistent with the rest of the call chain.

Fixes: c2d288f7ab13 ("kho: add test for kexec handover")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/test_kho.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index f5fe39c7c2b1..aeeb693d0251 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -239,7 +239,7 @@ static int __init kho_test_restore_data(const void *fdt, int node)
 	return 0;
 }
 
-static int kho_test_restore(phys_addr_t fdt_phys)
+static int __init kho_test_restore(phys_addr_t fdt_phys)
 {
 	void *fdt = phys_to_virt(fdt_phys);
 	const unsigned int *magic;
-- 
2.39.5


