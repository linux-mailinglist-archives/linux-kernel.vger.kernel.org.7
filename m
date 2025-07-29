Return-Path: <linux-kernel+bounces-749022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549C2B148FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE951882E50
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F74125FA2C;
	Tue, 29 Jul 2025 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axvlOlce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F2F36124
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753773139; cv=none; b=os1Rwq+3Wx0vXlg2dl178/gsDhW8rur0gqif9rpVRU6tBW8f8I43y1OnwFCSthflyBcy+BCunuWiK5YZnP5qs+6BVP3gMGv95geAFzLH9370e7IA9Psv0g/A0KBPOLF3q8VG7LklUN6MVqSW/WL8ewV7QtNab+cprUKamsyvU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753773139; c=relaxed/simple;
	bh=vf4mFVXlMOq0Wh1BYmvW7YGdr+Elk/7fJ6J9GPeUiHc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KZj6uxRo1mclzUIQuOpwT3SSXPP7mVxRtgCd1a1RRNDY82f1fMJ7zjQeVbjd/NW1C9L6Ox+/k8XaXNzlUUbbAY2Y3M4WuOUJevgix7ecnMEvje4kJbxf7notCD2HY3bov2Wr8IgPctITe9yX7obd8UDj2jfu/6i4UbjyZtqo0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axvlOlce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C85C4CEEF;
	Tue, 29 Jul 2025 07:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753773138;
	bh=vf4mFVXlMOq0Wh1BYmvW7YGdr+Elk/7fJ6J9GPeUiHc=;
	h=Date:From:To:Cc:Subject:From;
	b=axvlOlceNNhBSE+AKQ5BwkJVNCwyXTQxgGY06Wk3b/yhkNCZr1dAL1i3CjoVrfQCL
	 FbRE79JTx16YfFuh73NPMswNPEsnbRpwBiogFT2AkZXomWIWONUfag7+X6UY3VA+mJ
	 e4A3dM51yvTWcSboH0+32X53z9mO6bIKMmR1EtCE+DFGMCCJDMdfHwzfb+O5dOhy02
	 KRfhHRQC7nrYVUpKoaEwOdWf78FZq1IOH2+0Ty4v85NDOclCahTAi2aF7kgEiOkiau
	 hD1BSi75s0Ohl7G/LYZSUBCFIx+QteWcsqusmHhqDjJAK1eoEba1yNMw64furQa3Bc
	 Xm/KP1HrclTFw==
Date: Tue, 29 Jul 2025 09:12:14 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [GIT PULL] x86/fpu updates for v6.17
Message-ID: <aIh0TvRcSPfV0ULC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/fpu Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2025-07-29

   # HEAD: 1cec9ac2d071cfd2da562241aab0ef701355762a x86/fpu: Delay instruction pointer fixup until after warning

x86 FPU changes for v6.17:

 - Most of the changes are related to the implementation of
   CET supervisor state support for guests, and its preparatory
   changes. (Chao Gao)

 - Improve/fix the debug output for unexpected FPU exceptions
   (Dave Hansen)

 Thanks,

	Ingo

------------------>
Chao Gao (4):
      x86/fpu/xstate: Differentiate default features for host and guest FPUs
      x86/fpu: Initialize guest FPU permissions from guest defaults
      x86/fpu: Initialize guest fpstate and FPU pseudo container from guest defaults
      x86/fpu: Remove xfd argument from __fpstate_reset()

Dave Hansen (1):
      x86/fpu: Delay instruction pointer fixup until after warning

Yang Weijiang (2):
      x86/fpu/xstate: Introduce "guest-only" supervisor xfeature set
      x86/fpu/xstate: Add CET supervisor xfeature support as a guest-only feature


 arch/x86/include/asm/fpu/types.h  | 49 +++++++++++++++++++++++++++++++-----
 arch/x86/include/asm/fpu/xstate.h |  9 ++++---
 arch/x86/kernel/fpu/core.c        | 53 ++++++++++++++++++++++++++++-----------
 arch/x86/kernel/fpu/init.c        |  1 +
 arch/x86/kernel/fpu/xstate.c      | 40 +++++++++++++++++++++++------
 arch/x86/mm/extable.c             |  5 ++--
 6 files changed, 124 insertions(+), 33 deletions(-)

