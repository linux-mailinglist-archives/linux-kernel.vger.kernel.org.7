Return-Path: <linux-kernel+bounces-732827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA901B06C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BF35044AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3B523ABB0;
	Wed, 16 Jul 2025 03:54:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD4013D53B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752638081; cv=none; b=JmZoQPzNeJpi4Ih8uk1GZNyxJReqfceQH87SwnFguutR5k8nbMSRUM58Okn7lR4GhX2p8l82GAV3uAl2eyebFra/0V0Nq+v8tM7rXGW/OnxnMVMrSDa/qa3IeS5p6s3LkGgktB4OhYL5se7NMsl4HCJnupjPFA3SUdZHWsZF6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752638081; c=relaxed/simple;
	bh=mc8owewhgoATTE2pKMvFljsMrkIZ2xXHYCkKv0bwR94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H0UXeXhCndOI1aRmysrLyttI4MNPCAdRJ86ZRD+7HyBVypcF+6Q4OXdK4DuBIMF1vNnNClc2M3mz4Sr4aY2A+5na9yjN8d0TiscaUYNAUVQ0A1ENwwMPJ1e4SlwrXzhbOCAYqJr2TzT03H39QQI9hF2zxGht2H1W75kZo5tRunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3A7012FC;
	Tue, 15 Jul 2025 20:54:29 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 132A43F6A8;
	Tue, 15 Jul 2025 20:54:36 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH V2] arm64/mm: Drop redundant addr increment in set_huge_pte_at()
Date: Wed, 16 Jul 2025 04:54:32 +0100
Message-Id: <20250716035432.293682-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'addr' need not be incremented in the loop because that is not going to
be used subsequently.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Dev Jain <dev.jain@arm.com> 
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V2:

- Updated the commit message

 arch/arm64/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0c8737f4f2ce..1d90a7e75333 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -225,7 +225,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	ncontig = num_contig_ptes(sz, &pgsize);
 
 	if (!pte_present(pte)) {
-		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
+		for (i = 0; i < ncontig; i++, ptep++)
 			__set_ptes_anysz(mm, ptep, pte, 1, pgsize);
 		return;
 	}
-- 
2.30.2


