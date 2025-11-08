Return-Path: <linux-kernel+bounces-891515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A376CC42D3F
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 14:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406F83AED86
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793D91B983F;
	Sat,  8 Nov 2025 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM+atdce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C534D3BC
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762607989; cv=none; b=Q71HuGWHe2N7USQQHLMwsjTh1gbU3xJGyIMKyg5f1BqoNvEU61b+MG+r5JYZF9KLuPAonyb0IXsrJbBPBBxads4gEnm7cwL6Ny/n+Pnzxe8ktYc3CxvJwXF/Inz7t/E4PdUnQaXalLFBS8TTPIkYZ9H3ewwltFFKm+HByH1G7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762607989; c=relaxed/simple;
	bh=bRWXV5qbG2/QcLXbEaYSXCrIde9aHS0caKKlLFie6t4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pm0cCa/cN9+FARLtv2CUc5l5yHgTaFARuqBbvjIY9xh1DI/7vd37aYmqI0YyMrgfteHDfYoAi2yYiPiCuR6c+UmOHKV+TgTqYZqT1gsnOXBDVP0RZjArwD6aMJ2nA4+pukiktvbZvpDc3CJmqX0QNw0mlsaE3Hm/FwQ5lOJZFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM+atdce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3663FC4CEF7;
	Sat,  8 Nov 2025 13:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762607989;
	bh=bRWXV5qbG2/QcLXbEaYSXCrIde9aHS0caKKlLFie6t4=;
	h=Date:From:To:Cc:Subject:From;
	b=XM+atdceLWO7fGKMCtpCXmsxxrRg8zcS+NIQeSlo5cMbyXDuiydztBVMf+rjMfMKd
	 h0bVmbVit88nyHtNMEQyzjfS7J0tMAUuw39BN6oqxp48LKbsrzDyrT0uFjDL7ULGoJ
	 MIeZkx+D+RAzkLPtpNbP8AQzmNpKn82XPPUF11jjqybHi4O2VEQGCb5tsGdNT2QktI
	 VkwZmxfQEiFZgn1khsoEeZRvFn3kF0pKxdtRgO7qaVX4Ts4qwpPE8BSryStegbwWc/
	 /guXyDxguewTL5NU2VKmzU3LshBovGKFUqyKRQS4Iv2whHU6RUp22AQfhT7FQMLlJT
	 vUduH3A79mnsQ==
Date: Sat, 8 Nov 2025 14:19:42 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <aQ9DblCt0YOn09Bd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-11-08

   # HEAD: d23550efc6800841b4d1639784afaebdea946ae0 x86/microcode/AMD: Add more known models to entry sign checking

Miscellaneous fixes:

 - Fix AMD PCI root device caching regression that triggers
   on certain firmware variants

 - Fix the zen5_rdseed_microcode[] array to be NULL-terminated

 - Add more AMD models to microcode signature checking

 Thanks,

	Ingo

------------------>
Mario Limonciello (1):
      x86/CPU/AMD: Add missing terminator for zen5_rdseed_microcode

Mario Limonciello (AMD) (1):
      x86/microcode/AMD: Add more known models to entry sign checking

Yazen Ghannam (1):
      x86/amd_node: Fix AMD root device caching


 arch/x86/include/asm/amd/node.h     |   1 -
 arch/x86/kernel/amd_node.c          | 150 ++++++++++++------------------------
 arch/x86/kernel/cpu/amd.c           |   1 +
 arch/x86/kernel/cpu/microcode/amd.c |   2 +
 4 files changed, 54 insertions(+), 100 deletions(-)

