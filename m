Return-Path: <linux-kernel+bounces-852416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B402BD8EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98742424FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5A430F937;
	Tue, 14 Oct 2025 11:06:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD583081B8
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440004; cv=none; b=gFgwYnVf8/oljXemd6ghSUT9FkWeMxrgFYyutZwUJyvUG7ldSZfYELZUV0dFhqz2uE+M0CDrxrAHAj/ewkeh0L1nxIhWRw3arcUTEJ8CiywKHJob4uUuiH+YpvsBYdzdK3AfPZq5e+S279ZYcQwZIXCN76F5h8C2jZMcorc1huA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440004; c=relaxed/simple;
	bh=5IDXp4li2TMZ9pIMe0Znpdi8ISpR0TA92qXqhPy1VBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rxQu/lBDpiAJASfkEpgN4eJirGJF+CDDzDPCJ/AJdH5fDswwFNG+WFhg3LLZ5MWLmnJ28DhaVuapatV+Sqd1xthvd/V9U8L7E52ziJowfyy0qWQRlAHU8eao13cwOIhB5cxk/NTekVFfUXgB9JSeo9fjUgOIpv5RK0sRNiQOMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4E971A9A;
	Tue, 14 Oct 2025 04:06:33 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B5033F66E;
	Tue, 14 Oct 2025 04:06:40 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ryan.roberts@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Add a fallback stub for pgd_page_paddr()
Date: Tue, 14 Oct 2025 12:06:33 +0100
Message-Id: <20251014110633.304961-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a fallback stub for pgd_page_paddr() when (PGTBALE_LEVELS <= 4) which
helps in intercepting any unintended usage and which is also in line with
existing stubs for similar [pud|p4d]_page_paddr() helpers.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index aa89c2e67ebc..fb34df92d159 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1212,6 +1212,8 @@ static inline p4d_t *p4d_offset_kimg(pgd_t *pgdp, u64 addr)
 
 static inline bool pgtable_l5_enabled(void) { return false; }
 
+#define pgd_page_paddr(pgd)	({ BUILD_BUG(); 0; })
+
 #define p4d_index(addr)		(((addr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
 
 /* Match p4d_offset folding in <asm/generic/pgtable-nop4d.h> */
-- 
2.30.2


