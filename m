Return-Path: <linux-kernel+bounces-715459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4714EAF765C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 15:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C85F1C85DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50332E7BB6;
	Thu,  3 Jul 2025 13:58:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D752E7641
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551081; cv=none; b=RNuWzilXPgT42FFPl2jr9Njk5ReYG9S3hC4ZQe2gQ0/DpYePn3go0db2IddytAqlvr3vDvHHxT25FRyN7PGF3B6WY3cIRmzzEuug9s8Kex8LnWvPpaFiA6aaPhgOKwdYpKENc8ngug+Gk+2PuCbpSRkwQw0W1Xv1wb766BkQi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551081; c=relaxed/simple;
	bh=z10Vr3D+0ttXESB+cLOMUStVc7NxLhcnQoVRRSsW49s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZR0Kojr7BcCdF/ubSj+rj20RqainvRfOfpaXHTfinua+AaUZX3AtlrhwNuPzzdxbC0nZM/Tak7SDNSV+ctV0JkNnCC2q+o39cnzdEGL8ReWqf/lOapK96Qyoao0H9gwkR3xqL2G/ZYvCyzuH1VUOpueeN61NuENa0lAtJWfktxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFCBF1596;
	Thu,  3 Jul 2025 06:57:44 -0700 (PDT)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8C8B83F63F;
	Thu,  3 Jul 2025 06:57:56 -0700 (PDT)
From: Ben Horgan <ben.horgan@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org
Cc: james.morse@arm.com,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH 0/2] Fix and add warning of misuse of type##_replace_bits()
Date: Thu,  3 Jul 2025 14:57:27 +0100
Message-ID: <20250703135729.1807517-1-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By inspection there is one mistake in the use of u64_replace_bits(). Fix
this and while I'm here add a __must_check annotation to help avoid the
same mistake happening again.

Ben Horgan (2):
  KVM: arm64: Fix enforcement of upper bound on MDCR_EL2.HPMN
  bitfield: Ensure the return value of type##_replace_bits() is checked

 arch/arm64/kvm/sys_regs.c | 2 +-
 include/linux/bitfield.h  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.43.0


