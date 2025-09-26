Return-Path: <linux-kernel+bounces-834148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D19BA4047
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C667B3274
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1347D2F745C;
	Fri, 26 Sep 2025 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3Mp8xcI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7532557A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895366; cv=none; b=OFi0D7yXt13u3IFkZeKDvb6keXvee+GrtxXvBo5JfzPTCOfmHwBDtyo7nNUIZA0OiPpXzBXJecTR/rEmobZwmQqG9CQPtdLJ+zvxCPz4LxUggXPkoccI12h40w1R6IuC9fqd8ArGQsX2tLOZXo/njD55pSLKAaaDS5WrO7wG9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895366; c=relaxed/simple;
	bh=0VPycO6P7EOVVi/AxeRFuxYW86TK6fB2Dzy5J+Lez6I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Oh/hkJkSAiQYiArjvfiZwQNZi2jQeUMpoppdhUPEWym8d+5YP8AS09+7dppyEBYsy7oHNUZ0gkuw5qSq1rTfwk+MV+t8rMD6+oMKG0tp+ihehaRXtdlVZFqxXrClfHAWY7P9dU6xKCecxayW9oHkKBPB2TFlUH8wMhBipr5qHEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3Mp8xcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12ADC4CEF4;
	Fri, 26 Sep 2025 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758895365;
	bh=0VPycO6P7EOVVi/AxeRFuxYW86TK6fB2Dzy5J+Lez6I=;
	h=Date:From:To:Cc:Subject:From;
	b=m3Mp8xcIPiOn7qpI1sRXJfzfkXc8ROdf8oKl7OTUsMEwYb75MrlkVB0WGjMGKsRph
	 nlo16q+gsb5LPSZ6Fxyq+AuSB7mZjNukVbzH2ZjJQsIOUoPpTG1To4I8erSj2LzR9X
	 BobEwtm/AeU1EA9/lPT4Cxn2X4gzTDVRpnvNLt+xVBWgtBKIXYHSzCJhPLX7+e++Qz
	 EL02OwebrkwmCY4ihYo26PSb1O0Qq3JX6OmEJWRk7qC2pWVStAWNOpQp+5mDxK8TTB
	 1BeDIgcR5Sxs91eC5KyalUx+0C9+8D299Fn5b96Yp1/QQ62tsu2uPrDByyieoGEfzu
	 ggS3502195s+w==
Date: Fri, 26 Sep 2025 16:02:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <aNadAaV951IoOgRT@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-09-26

   # HEAD: 2066f00e5b2dc061fb6d8c88fadaebc97f11feaa x86/topology: Implement topology_is_core_online() to address SMT regression

Fix a CPU topology code regression that caused the mishandling
of certain boot command line options, and re-enable CONFIG_PTDUMP
on i386 that was mistakenly turned off in the Kconfig.

 Thanks,

	Ingo

------------------>
Alexander Popov (1):
      x86/Kconfig: Reenable PTDUMP on i386

Thomas Gleixner (1):
      x86/topology: Implement topology_is_core_online() to address SMT regression


 arch/x86/Kconfig                |  2 +-
 arch/x86/include/asm/topology.h | 10 ++++++++++
 arch/x86/kernel/cpu/topology.c  | 13 +++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

