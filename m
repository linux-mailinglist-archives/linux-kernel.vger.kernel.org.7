Return-Path: <linux-kernel+bounces-744007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F38B106DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B45C3AD2FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A04423F412;
	Thu, 24 Jul 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvgzl6in"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358623F405
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350251; cv=none; b=o3Gp9v0zUeFvtf7tDm6QeFAfyaw5KCDp3ExxqIJ7HQXhDcvhim9DdFhRme/pk6zI8e+GDO0grAtAnOCTQJD87bubh6OQMBf5duVSqka52LNFgJSPO+xpzf9KNgpMyiMMDkg3RY3OHw1fuR3jLDegXXIQrVXdZ4sVEaUeULh4mMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350251; c=relaxed/simple;
	bh=D3byKs9Kwszr4DgyFzPmK6s1lfZaS5QDw8nvwjwooa0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ojTFXpzcyQfrId9eGpb4LwRZiOCXtTywejV673qnbWSHUZ7NmH4UEo9XMLCr7yGxEf4wk5g15M6jLGsBhRkWRlLw/B6Mklb3TVdvqTR1dutEfiWIwpfSl+tRfDIepTHnld6Gwq2Ru60AsCnvZalENxABWje4Kqe5FnKby3jXPq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvgzl6in; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9393AC4CEED;
	Thu, 24 Jul 2025 09:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753350251;
	bh=D3byKs9Kwszr4DgyFzPmK6s1lfZaS5QDw8nvwjwooa0=;
	h=Date:From:To:Cc:Subject:From;
	b=jvgzl6inm2gUq6RWsC4X3qU5YA3tseV0s77NazxsGNHNKZU+RV/J4aXYPzcBZO0SJ
	 aLg9nzUeejJM3S3on8hSjBPUoAm4Z5uOQENpBC2ClFxo8rLTEhcIvVEUEqW1HMhStL
	 AxB+8eF/LRvlCDq+nhqsJfI/FhmoAQynzwzw5wiZxU2kOCJeSti0fXkOqpXJ9P0i9N
	 mClsqG1Dk9gZK/2y+iLkAaoIoPEL6CPHNtAwXYz0vHSmfXy8qkF3lXXAQ4ofHxXhxK
	 fLKeiAY/04T+VIPtMRMPTot+PKbYovUdVZvERcndlz4+YY8vn72WwxOVDUBpMuzME0
	 XTEW7FN2TLqrg==
Date: Thu, 24 Jul 2025 10:44:06 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	maz@kernel.org, mark.rutland@arm.com
Subject: [GIT PULL] arm64 fixes for 6.16
Message-ID: <aIIAZiQ6ca3DFHpE@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these two important arm64 fixes ahead of the 6.16 release.

The first fixes a regression introduced during the merge window where
the KVM UUID (which is used to advertise KVM-specific hypercalls for
things like time synchronisation in the guest) was corrupted thanks to
an endianness bug introduced when converting the code to use the
UUID_INIT() helper.

The second fixes a stack-pointer corruption issue during context-switch
which has been observed in the wild when taking a pseudo-NMI with
shadow call stack enabled.

Please pull.

Cheers,

Will

--->8

The following changes since commit 9dd1757493416310a5e71146a08bc228869f8dae:

  arm64/mm: Drop wrong writes into TCR2_EL1 (2025-07-04 16:46:04 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to d42e6c20de6192f8e4ab4cf10be8c694ef27e8cb:

  arm64/entry: Mask DAIF in cpu_switch_to(), call_on_irq_stack() (2025-07-22 16:39:30 +0100)

----------------------------------------------------------------
arm64 fixes for 6.16

- Fix broken UUID value for the KVM/arm64 hypervisor SMCCC interface.

- Fix stack corruption on context-switch, primarily seen on (but not
  limited to) configurations with both pNMI and SCS enabled.

----------------------------------------------------------------
Ada Couprie Diaz (1):
      arm64/entry: Mask DAIF in cpu_switch_to(), call_on_irq_stack()

Jack Thomson (1):
      arm64: kvm, smccc: Fix vendor uuid

 arch/arm64/include/asm/assembler.h | 5 +++++
 arch/arm64/kernel/entry.S          | 6 ++++++
 include/linux/arm-smccc.h          | 2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

