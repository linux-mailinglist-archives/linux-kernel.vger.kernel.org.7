Return-Path: <linux-kernel+bounces-803479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0ABB46049
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDEF718921AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B98E345743;
	Fri,  5 Sep 2025 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnVo+TTa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01EC8FE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093762; cv=none; b=W7MrYQKm5O9H4D9tqiWiQsm3omzJOhzt6vFGfLhLp4VdAW2q6JZ/gowm77OjDKXgHWRT/2942arQxHCBYOUyFu/jsUt7r5a73lhLTq8kw4xPzOCtAdxwE+y0DJNvREsDNo6j9A184nPEf5oRwzKHbWidTixKDjGsnP/Dtdz7dws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093762; c=relaxed/simple;
	bh=umg3I6wPb8guAG/qPCKFRIIy4aNrvO/HLOtPHL8FpMI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tW2tzMJdOUvfboeHrFpk2JnPKhvMQmA9dW74iu8fvwp31UcknwHpDIo9ygXBTPzVDY9bt5yVTl09sCEccWyvKbFWZEekbK8ygjqZszwihex9tLmX8WY3//RwiXVqB6bNja1iJjPwIBVApCcn1ESeMVvl0pFC+bA1Gd9o20WfITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnVo+TTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668F5C4CEF1;
	Fri,  5 Sep 2025 17:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757093762;
	bh=umg3I6wPb8guAG/qPCKFRIIy4aNrvO/HLOtPHL8FpMI=;
	h=Date:From:To:Cc:Subject:From;
	b=VnVo+TTaKMzoU/HUmR6xMccJWH/cGlE+veh7agFbYMdgrmK1KW61uOcEViNn1/xth
	 TQK/MdaGT+rPeT5d2z7CPtIcog+zj0KkgkcJ81Fv/8F9v9xznAa9XUr9Qwg7S5959M
	 80K+BtTjfaeRA+MGJOMO3iYOKhXL1Glkg7jcTZLAOXsFigvR9KVKpLJByguety2jYO
	 s5vK7sI+S70t8AvJuCyPmzU3qsd15uds6YOjgdIOldgHg7396f0ojRAm461d7m1xlD
	 x/R5ZaeM3FE2UOdz7mZNE2kQ6qc7QTL+QMW2nFI615zFdUARe1nAdnh3yeNY1CeG3v
	 JxyGTtLA+Kvig==
Date: Fri, 5 Sep 2025 18:35:58 +0100
From: Catalin Marinas <cmarinas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.17-rc5
Message-ID: <aLsffo3bIIH4hYSQ@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit d82aa5d3501b25bfb7bc2a24a68ad0a83b2ad10b:

  kselftest/arm64: Don't open code SVE_PT_SIZE() in fp-ptrace (2025-08-30 11:31:11 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to a7ed7b9d0ebb038db9963d574da0311cab0b666a:

  arm64: ftrace: fix unreachable PLT for ftrace_caller in init_module with CONFIG_DYNAMIC_FTRACE (2025-09-05 16:56:20 +0100)

----------------------------------------------------------------
arm64 fixes:

 - Incorrect __BITS_PER_LONG as 64 when compiling the compat vDSO

 - Unreachable PLT for ftrace_caller() in a module's .init.text
   following past reworking of the module VA range selection

 - Memory leak in the ACPI iort_rmr_alloc_sids() after a failed
   krealloc_array()

----------------------------------------------------------------
Miaoqian Lin (1):
      ACPI/IORT: Fix memory leak in iort_rmr_alloc_sids()

Thomas Weiﬂschuh (1):
      arm64: uapi: Provide correct __BITS_PER_LONG for the compat vDSO

panfan (1):
      arm64: ftrace: fix unreachable PLT for ftrace_caller in init_module with CONFIG_DYNAMIC_FTRACE

 arch/arm64/include/asm/module.h           |  1 +
 arch/arm64/include/asm/module.lds.h       |  1 +
 arch/arm64/include/uapi/asm/bitsperlong.h |  5 +++++
 arch/arm64/kernel/ftrace.c                | 13 ++++++++++---
 arch/arm64/kernel/module-plts.c           | 12 +++++++++++-
 arch/arm64/kernel/module.c                | 11 +++++++++++
 drivers/acpi/arm64/iort.c                 |  4 +++-
 7 files changed, 42 insertions(+), 5 deletions(-)

-- 
Catalin

