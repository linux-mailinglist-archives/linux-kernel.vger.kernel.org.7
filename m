Return-Path: <linux-kernel+bounces-815502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0426B56766
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D7C189D4FB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 09:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7C122A1C5;
	Sun, 14 Sep 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOa8sOe5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70F357C9F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757843067; cv=none; b=pA/2/cW2CEjKit1U9HwGLdX5mj1qNdCLeCv6iwWESRRULB2B/o3qxBTP7Y8n/WWDCchqPsfvZYwnwNL4Q6r4QtxMPxVJxt0beeHA06lA1Am5kjvrdze4gPBYNF70oWrSR8I9x8kWuNJqbiVP6SXJtaaUqeGaC4JLxu4sXd9fStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757843067; c=relaxed/simple;
	bh=JLjbxnzQKj1JaS+va6v2e8kE1eGS+/uY4wAcRucdM4w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZhXgSNIFM+hd/lZWuYRdJLDXjOBYiL9Rar636qgDNvPvrq3/Uma1lyMpQokcbBUqgTZ27qavc86TMH8ecmYY5mM7iN5qtE50i0PHois7b/1ZlRqHNyGAWppL14dDxPNbXV7yqloGf27f5i+n3Q8kwtjMd9Rpx8UhBodsmlhb0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOa8sOe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0728C4CEF0;
	Sun, 14 Sep 2025 09:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757843067;
	bh=JLjbxnzQKj1JaS+va6v2e8kE1eGS+/uY4wAcRucdM4w=;
	h=Date:From:To:Cc:Subject:From;
	b=nOa8sOe5ZglFB0xk8DLlPVd2MfpOT+Pba8DCiNOPdDKj97yoejLdVcreSPL/txWDX
	 UbdIXiOCHMalKieQDrGbgS3TPYgt4k8vr637i0azt9Gru95zHFzh+DIJq3GNsTJoEV
	 ff4Ne1ODGSd0rIceTYAWXdl591L1IVW0DcgjbBBsbgnnukG6aZO5yIRD1CZw77rQVn
	 UkWLXm3ocx2pzFdOR0Ngvj6q7dZfSYDmFPhA/CBdJzkaMziXVU50cjhmVZOotH3TWI
	 pXK8RCCMqenzIwRsuZsl5jhJ5hQeYAoFTHN7oU9kf+1GtSFkhG5WHdoaGBfAJojTC/
	 mOlMxIoRJ86dQ==
Date: Sun, 14 Sep 2025 11:44:22 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <aMaOdgwWqzN8_UWU@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-09-14

   # HEAD: d2e1b84c5141ff2ad465279acfc3cf943c960b78 fs/resctrl: Eliminate false positive lockdep warning when reading SNC counters

Fix a CPU topology parsing bug on AMD guests, and address
a lockdep warning on the resctrl filesystem.

 Thanks,

	Ingo

------------------>
K Prateek Nayak (1):
      x86/cpu/topology: Always try cpu_parse_topology_ext() on AMD/Hygon

Reinette Chatre (1):
      fs/resctrl: Eliminate false positive lockdep warning when reading SNC counters


 arch/x86/kernel/cpu/topology_amd.c | 25 ++++++++++++++-----------
 fs/resctrl/ctrlmondata.c           |  2 +-
 fs/resctrl/internal.h              |  4 ++--
 fs/resctrl/monitor.c               |  6 ++----
 4 files changed, 19 insertions(+), 18 deletions(-)

