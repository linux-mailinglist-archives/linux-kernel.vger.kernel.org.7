Return-Path: <linux-kernel+bounces-749028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8C8B1490D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1EA7AC18D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F0E262FFF;
	Tue, 29 Jul 2025 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dowUfN5K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63E25F97A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753773945; cv=none; b=XaAmceos7D2OMS3yqC1ZC3YmPedL6UKhfQqzB8xY50cR2H9QReACIkCLyCxVFCsSStqophVqovfXWtbNeIBN7IwBY765pYB2Bz/E62IdF9+tkjwUIqTjLk3teeZDQ4RJNS4U26PH5qGyn5BmR0Lb3eOfROVkHsCIMD22SARxoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753773945; c=relaxed/simple;
	bh=w3b2uoZKbeFSVszXIgs60MmF3xQfFesEKR/Qq41OviE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pmDD+efs7OYQ5lIbGZMgRjer41pZCbafKMstB0HsMDE20+EyGAWXZl7uhFoDwthsZcli5s0cJNiRN/NMeQwVz95z4Aoa2NQZQ6iMubJQowYCjHcI0i3Zq87NZBpSZJqB3bPVzOdro1fDIwVHunCzTMs2WjK4iedN0Ir9qBOg1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dowUfN5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE07C4CEEF;
	Tue, 29 Jul 2025 07:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753773945;
	bh=w3b2uoZKbeFSVszXIgs60MmF3xQfFesEKR/Qq41OviE=;
	h=Date:From:To:Cc:Subject:From;
	b=dowUfN5Kvtz3m2kQC7tFTlMD02MsaK+dhI/PUhP2tTuGqlRf7EWr60JJxobn6ufTc
	 rBytkPgIjr6JeKjsjFGaKSKdO+cDqcb3KZIo+WfcFr4QApDDMPlWi3HzlP/CNOKrnX
	 QB+8QbHDCA2dQbh+sDU5GoewMl9QTs9m/BtrlXaWSbLqqqjr5OSJXG0wWn+1zQcH7i
	 R/+HaPh+on3NKrhQmPGDrivBHGmnw76/i0RMea37eva6eneMUPSkzvalGOAW9D9qtF
	 OSyLqcPJoSbXumRbt5gmju3Sv2d30afhr938JIvoHhseAG+XdVbi5qUftZAsn4yX09
	 mm2pjTl0pZSKg==
Date: Tue, 29 Jul 2025 09:25:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL] x86/platform updates for v6.17: AMD Hardware Feedback
 Interface (HFI) support
Message-ID: <aIh3dfKMDmR8pN2B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/platform Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2025-07-29

   # HEAD: f12682148262aa6deed32c0593c67658573d0600 x86/itmt: Add debugfs file to show core priorities

x86/platform changes for v6.17:

This tree adds support for the AMD hardware feedback interface (HFI),
by Perry Yuan.

 Thanks,

	Ingo

------------------>
Mario Limonciello (5):
      MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
      cpufreq/amd-pstate: Disable preferred cores on designs with workload classification
      platform/x86/amd: hfi: Set ITMT priority from ranking data
      platform/x86/amd: hfi: Add debugfs support
      x86/itmt: Add debugfs file to show core priorities

Perry Yuan (8):
      Documentation/x86: Add AMD Hardware Feedback Interface documentation
      x86/msr-index: Add AMD workload classification MSRs
      platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
      platform/x86: hfi: Parse CPU core ranking data from shared memory
      platform/x86: hfi: Init per-cpu scores for each class
      platform/x86: hfi: Add online and offline callback support
      platform/x86: hfi: Add power management callback
      x86/process: Clear hardware feedback history for AMD processors


 Documentation/arch/x86/amd-hfi.rst    | 133 ++++++++
 Documentation/arch/x86/index.rst      |   1 +
 MAINTAINERS                           |   9 +
 arch/x86/include/asm/msr-index.h      |   5 +
 arch/x86/kernel/itmt.c                |  23 ++
 arch/x86/kernel/process_64.c          |   4 +
 drivers/cpufreq/amd-pstate.c          |   7 +
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  18 ++
 drivers/platform/x86/amd/hfi/Makefile |   7 +
 drivers/platform/x86/amd/hfi/hfi.c    | 551 ++++++++++++++++++++++++++++++++++
 12 files changed, 760 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

