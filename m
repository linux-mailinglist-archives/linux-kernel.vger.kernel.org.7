Return-Path: <linux-kernel+bounces-868078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D722BC044C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B213B78FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24273277CA5;
	Fri, 24 Oct 2025 04:02:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18F8139579
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761278543; cv=none; b=ZRN1bgpen9ytGuMjgvduZyw4fl34k+s2IESidbH/jpikgMghYd1cYtsqrtuIqhihQk+XdnSgET8diG2CeknPKPFX9IkaOSoDihOKy2YXXYAaVxnDX5yEEyDRvRKikSms4d8HgUnTGahxHM1i/jE4t03JXFIvlc6PmmU20syhTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761278543; c=relaxed/simple;
	bh=uW36oh1z0Q4WuE2jePTIcKiwZLfT7G/8F0OJZ6IBJB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O7987c0X/hT+aepmJUxYxEeGNpfJlRQjjJfguACLOyFsrZpUiYF2yKgfbleJJGoS3BbOrdGTwbKPTue51WznzPh/u7oFgcSMG2D0F88i0EcsEd3DauhmNksIpjjoKdNB9rGspOI8+6jRjWyI5V560JAxb4ddOx3E7Dj/Oox/Bk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E4641C25;
	Thu, 23 Oct 2025 21:02:13 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 859F53F59E;
	Thu, 23 Oct 2025 21:02:19 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ben.horgan@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: [PATCH V2 0/2] arm64/mm: Add remaining TLBI_XXX_MASK macros
Date: Fri, 24 Oct 2025 05:02:05 +0100
Message-Id: <20251024040207.137480-1-anshuman.khandual@arm.com>
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

Changes in V2:

- Added KVM changes required to accommodate TLBI_TTL_MASK split
- Updated the commit message

Changes in V1:

https://lore.kernel.org/all/20251021052022.2898275-1-anshuman.khandual@arm.com/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org> 
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kvmarm@lists.linux.dev

Anshuman Khandual (2):
  arm64/mm: Drop redundant 'level' range trimming in __tlbi_level()
  arm64/mm: Add remaining TLBI_XXX_MASK macros

 arch/arm64/include/asm/tlbflush.h | 26 ++++++++++++++++++--------
 arch/arm64/kvm/nested.c           |  8 +++++---
 2 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.30.2


