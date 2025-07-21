Return-Path: <linux-kernel+bounces-738924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7AB0BF1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE58F17C423
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACD0289835;
	Mon, 21 Jul 2025 08:36:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245D2288CA3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087001; cv=none; b=IRq4s0UX4lrvj7wTPqfRGLF4Rf1Msu/5uzAwa7RyOTqXpKuNYPdbAd1EPTX+D7SONTU3kLS4SRRhS/eGpqKw0GcnUyEcPYKeG6KNCUBYtrbLNd8nQSz3M+QMLYkUC2p+pHq7lR4P5UtGhpFnQ/Y52+9zWRhRWMueTT0UMpWrLx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087001; c=relaxed/simple;
	bh=FMjhLsDLNRXCPI7UG2W/acu+b+xaiVyshGkAVxY+Lwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=apYlESWhgoi8sm6lD9ZWiF6oK4YzLTy9DfoWtMdksip/OL3lOM8mfJUkqMTBg+MORlq40hV+n9x6leur59qPzCl44sdRxxgKx7fkIOVJk1qnbCrXvWmPr/1aPxR6R2SSqmkEqaGhki3uXYhxSKRlk/NWty6sfrIuQsMYFtiyKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 901063105;
	Mon, 21 Jul 2025 01:36:32 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 959C63F66E;
	Mon, 21 Jul 2025 01:36:36 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	ardb@kernel.org,
	frederic@kernel.org,
	james.morse@arm.com,
	joey.gouly@arm.com,
	scott@os.amperecomputing.com,
	maz@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 3/7] arm64/Kconfig: add LSUI Kconfig
Date: Mon, 21 Jul 2025 09:36:14 +0100
Message-Id: <20250721083618.2743569-4-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250721083618.2743569-1-yeoreum.yun@arm.com>
References: <20250721083618.2743569-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since Armv9.6, FEAT_LSUI supplies the load/store instructions for
previleged level to access to access user memory without clearing
PSTATE.PAN bit.
It's enough to add CONFIG_AS_HAS_LSUI only because the code for LUSI uses
indiviual `.arch_extension` entries.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 393d71124f5d..c0beb44ed5b8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2238,6 +2238,15 @@ config ARM64_GCS
 
 endmenu # "v9.4 architectural features"
 
+config AS_HAS_LSUI
+	def_bool $(as-instr,.arch_extension lsui)
+	help
+	 Unprivileged Load Store is an extension to introduce unprivileged
+	 variants of load and store instructions so that clearing PSTATE.PAN
+	 is never required in privileged mode.
+	 This feature is available with clang version 20 and later and not yet
+	 supported by gcc.
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


