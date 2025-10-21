Return-Path: <linux-kernel+bounces-862187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024C8BF4A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E7E18C4544
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3F82472A8;
	Tue, 21 Oct 2025 05:20:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D315199FB0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761024036; cv=none; b=n6XsiZ7tiGtpuoR4E3CfLOvXbAMv2YOVCGyo+dCrD/Y7aWxPRv75JVXkZKJfhCVlREpqnsoazFnRsn3QeAGACqhYfrJh4EcEzMOwQe6wqHhH138RPil8riSik+7UngE4dZzwMlNL1rDZaZmoO8jb/xP7ztt/VKisKWMETRYSCTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761024036; c=relaxed/simple;
	bh=3W4thCbVLo946W8mDgOD40SYbSmkEsppKPaYy6oM+z0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NEmDv73tWN70WgP4WI7OcZNwRKnlhF4zueqnrUO2UIHdCqYHOOZb6pV1d5e24Yot/lCK17GNyAiUgoYbPJNctDanW1urGXfDx9LQru0e5Fx3WJU5pEc1tbyrjyUIk3uCLEgRPFeXSaxx318o4Nuiiht9/gkfafGwEhWGf5fM2kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 543701063;
	Mon, 20 Oct 2025 22:20:25 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 228103F59E;
	Mon, 20 Oct 2025 22:20:31 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64/mm: Add remaining TLBI_XXX_MASK macros
Date: Tue, 21 Oct 2025 06:20:20 +0100
Message-Id: <20251021052022.2898275-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add remaining TLBI_XXX_MASK macros. But before that drop one redundant
'level' trimming operation in __tlbi_level().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  arm64/mm: Drop redundant 'level' range trimming in __tlbi_level()
  arm64/mm: Add remaining TLBI_XXX_MASK macros

 arch/arm64/include/asm/tlbflush.h | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

-- 
2.30.2


