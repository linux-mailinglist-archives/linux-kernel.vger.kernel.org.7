Return-Path: <linux-kernel+bounces-769881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5429B274BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFF95C6B41
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5646823DD;
	Fri, 15 Aug 2025 01:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpifKG5M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AFBE571;
	Fri, 15 Aug 2025 01:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221510; cv=none; b=bJha62YjXWy0qU4Jr0wmsSYYY4x13acUgk5aME/14CeB5PwGU6s12ErI8H55CBvKWuMGcP4iPhV2wzCHGhUUdNbrw2c6/q2rwokneEiasq7ZR600ZWdMpYP2FtlKvxLPzanw0tOmmSaAF/9UnrYkcy6zabFeiVQjOXzWm/O8TXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221510; c=relaxed/simple;
	bh=e9/U7Zymov2op6Tt2ARZLhwTYZsxnmBtyH8fYBAWN4Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dSVtYjdv1kTrb2+NJ8L62nYDBj93hpYtZGB83OIM+XZB+BGycNBlxhnzN+8iDmR5a/0NRFhc5jWXKpeqgiRbTdSQmht1pc/HhIrhx8PPRwtHWMGXpwSoPu7MR8Kjz20ezz6I3D8+G43V/yq7AChHky8lMHelngsTcVHvbfGCteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpifKG5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03D9C4CEED;
	Fri, 15 Aug 2025 01:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755221509;
	bh=e9/U7Zymov2op6Tt2ARZLhwTYZsxnmBtyH8fYBAWN4Y=;
	h=From:Subject:Date:To:Cc:From;
	b=GpifKG5MQZT9Dc+mtXS6bS2OQD+C6e+AcGNzhnhE2GOKYW+JYSXRCgppXGndwjnr9
	 +jSxk39nD6mnSVfKqci6gbyxhZF73fDPOUhioL5YimBijvj6VRx01hapCM7G8zP7JH
	 d8APpazP3eIXavOn/Jq7J9GzjF4WvdpA9Lb3DQ0MT5VLQQeyaafMblsEXASYQ95vOf
	 C01NQ//u0+LDWj0lH+CA+hcZo70abxPAqp+7FjvlUMTtJsuYbZ6Cl0TWVmoj7SOi8g
	 YKPnOBbnd0OVxSgsWUsDt5sTfErr6xdvDTcYmj3jFTIoST8KaRXSE/06s5h29HtHZR
	 9wKBxFyaoWK2A==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/6] x86: Clean ups after minimum support compiler version
 bump
Date: Thu, 14 Aug 2025 18:31:36 -0700
Message-Id: <20250814-x86-min-ver-cleanups-v1-0-ff7f19457523@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPmNnmgC/x3MTQqAIBBA4avErBtI0f6uEi3UxhooC6UIorsnL
 b/Few8kikwJ+uKBSBcn3kOGKAtwiwkzIU/ZICupq1YovNsaNw54UUS3kgnnkdB62xitvHCyg5w
 ekTzf/3YY3/cDpm810mYAAAA=
X-Change-ID: 20250814-x86-min-ver-cleanups-bfb7a54f1c29
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004; i=nathan@kernel.org;
 h=from:subject:message-id; bh=e9/U7Zymov2op6Tt2ARZLhwTYZsxnmBtyH8fYBAWN4Y=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBnz+phePrX/LHNU5HuMcM7pPxv9G7+pHxK9pDOnVfPyp
 /L8+fd9OkpZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEbt5nZGj6cSAkXF56/sfD
 fXczA9jWln3gfJr20mh76KN+/lK110qMDD+M1kv85HN7U2S1+ueJGz5W3RnTDzNdWXTh6qTdV1l
 Kf/EBAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi x86 folks,

Here is a small series of clean ups that I noticed after PeterZ made a
comment about '-mskip-rax-setup' being supported with all compiler
versions that x86 requires to build (GCC 8.1+ and LLVM 15+). This has
seen a build with GCC 8, GCC 15, LLVM 15, and LLVM 21.

---
Nathan Chancellor (6):
      x86/build: Remove cc-option for GCC retpoline flags
      x86/build: Remove cc-option from stack alignment flags
      x86/build: Clean up stack alignment flags in CC_FLAGS_FPU
      x86/build: Remove cc-option from -mno-fp-ret-in-387
      x86/build: Remove cc-option from -mskip-rax-setup
      x86/Kconfig: Clean up LLVM version checks in IBT configurations

 arch/x86/Kconfig  |  8 +-------
 arch/x86/Makefile | 25 +++++++------------------
 2 files changed, 8 insertions(+), 25 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250814-x86-min-ver-cleanups-bfb7a54f1c29

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


