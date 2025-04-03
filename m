Return-Path: <linux-kernel+bounces-586876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF2A7A4EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 16:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A469189B5BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 14:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E07E24EA9D;
	Thu,  3 Apr 2025 14:15:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926C424BC06;
	Thu,  3 Apr 2025 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689744; cv=none; b=of3ESyLbo8nwNANaFnFlGREs5rQEhxryRy5FdLY89Zk1L8Gvvd3/7OwIxP3L3Jg+DX8Dzr9fAfdoEj9QztRwf3yS7U430EXB5+K/APCz8x/q8U1iZiRCgTOq1/cbuPSRCiLs5VGMDCMykEv7cRz6FJx7ltPrTJvGmbYQYixg3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689744; c=relaxed/simple;
	bh=AiYbxfa7rppp5u2RwXjvYnfXrLJ26nxxEOM/gL5qO50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gup9jJM4ftcGw8sExHZASDTzhdO9xzPqQlcJ/brKr6OmCPw4AUMm1XudvQ3rMOJnUb12TEXCFpzyryi+bV5RiSfO7xLtUizjpm/gUgzs2hYCFC6kJ98jVzJYhiGqmmXn48DRWBO45KDz/wq/jUa8NmeC/YXDXL0I9FTksy+6vMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 415C5106F;
	Thu,  3 Apr 2025 07:15:43 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF4373F59E;
	Thu,  3 Apr 2025 07:15:37 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	anshuman.khandual@arm.com,
	joey.gouly@arm.com,
	yury.khrustalev@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	frederic@kernel.org,
	shameerali.kolothum.thodi@huawei.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	huangxiaojia2@huawei.com,
	akpm@linux-foundation.org,
	surenb@google.com,
	robin.murphy@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 0/3] support FEAT_MTE_TAGGED_FAR feature
Date: Thu,  3 Apr 2025 15:15:32 +0100
Message-Id: <20250403141535.23496-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FEAT_MTE_TAGGED_FAR feature provides support for
reporting all non-address bits during a synchronous MTE tag check fault.

This patchset extends the reporting tag to include
not only the memory tag (logical tag) but also the address tag via
si_addr when FEAT_MTE_TAGGED_FAR feature is supported.

Yeoreum Yun (3):
  arm64: add FEAT_MTE_TAGGED_FAR feature
  arm64/mm/fault: use original FAR_EL1 value when ARM64_MTE_FAR is
    supported
  Documentation/arm64: reflects FEAT_MTE_TAGGED_FAR description

 Documentation/arch/arm64/tagged-pointers.rst | 11 ++++++-----
 arch/arm64/include/asm/hwcap.h               |  1 +
 arch/arm64/include/uapi/asm/hwcap.h          |  1 +
 arch/arm64/kernel/cpufeature.c               |  9 +++++++++
 arch/arm64/kernel/cpuinfo.c                  |  1 +
 arch/arm64/mm/fault.c                        |  7 +++++--
 arch/arm64/tools/cpucaps                     |  1 +
 7 files changed, 24 insertions(+), 7 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


