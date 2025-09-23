Return-Path: <linux-kernel+bounces-829440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 488D1B971B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E78FA7A22D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4DF28B415;
	Tue, 23 Sep 2025 17:49:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68172874E9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649762; cv=none; b=Ae+YTro7sqGF+0LlzR1DLrp26452vf0DLGaG7xdSWUmsY5AtrBAD1tjthcQelaHTovaO7ZiqZ3ayN103gCL+FOXeByjZqvtdxTNz8VTjlA0SEy6AmdI/ocyEMCLcsdHzqy+34ZRXXwIZUEiMrR3YTBfpokv6Jw5ycP1C3vRyLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649762; c=relaxed/simple;
	bh=128ZpLwaXADL1vNovgRJUTn6L7GJXWYdUh56fZ+sRYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqI1cG6taM11rIJ+09RGLzkPYbPc3IC/CHQUbvgMajGG5igEvOoo42HbKETuxTBX4Y1kzYM/tPgxvzSe1CqH6fTDD7mddX663wzIqe/79Dy6qrz9ClRBCXdpZGZ1bg8yuO6/w0Y6rg33d4EIfKDV33smFQFyg55E4yk3ganrcLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBD86FEC;
	Tue, 23 Sep 2025 10:49:11 -0700 (PDT)
Received: from e137867.cambridge.arm.com (e137867.arm.com [10.1.30.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1734B3F5A1;
	Tue, 23 Sep 2025 10:49:15 -0700 (PDT)
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kasan-dev@googlegroups.com,
	Mark Rutland <mark.rutland@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: [RFC PATCH 01/16] kasan: mark kasan_(hw_)tags_enabled() __always_inline
Date: Tue, 23 Sep 2025 18:48:48 +0100
Message-ID: <20250923174903.76283-2-ada.coupriediaz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923174903.76283-1-ada.coupriediaz@arm.com>
References: <20250923174903.76283-1-ada.coupriediaz@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`kasan_hw_tags_enabled()` and `kasan_tags_enabled()` are marked inline,
except `kasan_enabled()` with `CONFIG_KASAN_HW_TAGS`,
which is marked `__always_inline`.

Those functions are called in the arm64 alternative callback
`kasan_hw_tags_enable()`, which requires them to be inlined to avoid
being instrumented and safe for patching.

For consistency between the four declarations and to make the arm64
alternative callback safe, mark them `__always_inline`.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 include/linux/kasan-enabled.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 6f612d69ea0c..d3d5a2327e11 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -13,19 +13,19 @@ static __always_inline bool kasan_enabled(void)
 	return static_branch_likely(&kasan_flag_enabled);
 }
 
-static inline bool kasan_hw_tags_enabled(void)
+static __always_inline bool kasan_hw_tags_enabled(void)
 {
 	return kasan_enabled();
 }
 
 #else /* CONFIG_KASAN_HW_TAGS */
 
-static inline bool kasan_enabled(void)
+static __always_inline bool kasan_enabled(void)
 {
 	return IS_ENABLED(CONFIG_KASAN);
 }
 
-static inline bool kasan_hw_tags_enabled(void)
+static __always_inline bool kasan_hw_tags_enabled(void)
 {
 	return false;
 }
-- 
2.43.0


