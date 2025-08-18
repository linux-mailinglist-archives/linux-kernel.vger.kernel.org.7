Return-Path: <linux-kernel+bounces-773259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 107BFB29D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCF61889CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61891307AEA;
	Mon, 18 Aug 2025 09:14:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9813A302CB9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508486; cv=none; b=jnbjngzplPMZen7BDEs30CqcfxV7VX2LN+WUejQCW24gJu7bUaJQxZ5VOVnXq9UyafP4ZPC4cU68YwFCEoilrviPknOmQwnv9PoDGp8BNfPwYsC+NVZc5eKOSDH9GRIGrOQmu+FCK9or6y/HV+UcGyIgHMPtiQ6O2CjajdaxMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508486; c=relaxed/simple;
	bh=iEgMdHCj64lPwtzO/Q8uUiUIa0QLyyep5PSIGpPb0ao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rk01tMpigcDVnnnoCVoNWXnh5EVXVPyIy4dOXvG6DhzHvphf5Ws0/ZDR4ADavkpo7RlLQ7mUCGwvRhuN8JPXym6wFULT+pHrPZV1ieo61VgCw8iVeEsyPT+jMIjlRBRKNXmijjHLp2xBpCEoRtSYhbs6CLcOu2e+5wcczLgSeSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E45C21424;
	Mon, 18 Aug 2025 02:14:35 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD7203F58B;
	Mon, 18 Aug 2025 02:14:41 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC 0/3] arm64/ptdump: Add ARM64_PTDUMP_CONSOLE
Date: Mon, 18 Aug 2025 14:44:33 +0530
Message-Id: <20250818091436.938517-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable early kernel page table dump for debug purpose when required through
a new config ARM64_PTDUMP_CONSOLE. But first this reorganizes ptdump_init()
separating out the debugfs creation so that it can be called early on. Then
adds kernel console print support for existing pt_dump_seq_[printf|puts]()
helpers.

This series applies on v6.17-rc2

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Anshuman Khandual (3):
  arm64/ptdump: Re-organize ptdump_init()
  arm64/ptdump: Enable console output in pt_dump_seq_[printf|puts]()
  arm64/ptdump: Add ARM64_PTDUMP_CONSOLE

 arch/arm64/Kconfig.debug           | 12 +++++++++
 arch/arm64/include/asm/ptdump.h    |  9 +++++++
 arch/arm64/kernel/setup.c          |  3 +++
 arch/arm64/mm/ptdump.c             | 42 ++++++++++++++++++++++--------
 drivers/firmware/efi/arm-runtime.c |  4 +--
 5 files changed, 57 insertions(+), 13 deletions(-)

-- 
2.25.1


