Return-Path: <linux-kernel+bounces-859662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 414B5BEE3A1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E9E189CE74
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC752E7F21;
	Sun, 19 Oct 2025 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="U3rP289B"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09742E7BAE
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760872358; cv=none; b=aB/RXkSRizRXj0tCyNgAkEI4MZcpO3ZUNPAPFTFpwMNWCwYSLjdwXcBxJqpm+va/Es4adTq4HYWl6soaZUYBnl3LVtLpH9qR5f/OSy+N1rR5l9R5zF3w619squE22KwNBMuYQltCpvh9OQPo1z/nYayuLPtRzIo3lgdD3XmLAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760872358; c=relaxed/simple;
	bh=5H9+f+IXwNdydqF9WxzN9iOcTldOlZRpbj48xToX24c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZUNwujBWNEmXW3lR5/YnpxSLlx0vZDRltRoRd8qHMJ5QHeMmkPK4LcsZm0XCg/FDFViMtizURSPLyOYUhW5xevTCMsmBxo0IoXKOA+tnoKEG6KY7gp2nIEeoloq6FOAAsnzc/yj6VGbgxZZ1JJ9bsQEKJFVWGdmrTlLDK3Bz9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=U3rP289B; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CEF6440E01AB;
	Sun, 19 Oct 2025 11:12:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VSP2PJmw_0nR; Sun, 19 Oct 2025 11:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760872348; bh=lorrIr802DcgwSEvme1zKMxqrzK2kOtBY4mFQ+Q/cQI=;
	h=Date:From:To:Cc:Subject:From;
	b=U3rP289BtkRYPTXokjraM25iupAseMBA17xrhap4ubsY8vwlKnJHraZN3BBGxDxyW
	 WSnkkiP6kOMWGsnimAK5sq+riUADOs9kIaARpxSWOXFQdZi/K5cTH/9t1ky5O5vi+j
	 LB/7tJOC7L7FRcjPqet+lWE8zoQpICo/bubhr6Q5Wnt5GuL+k80ZWreFNPlBJTk4bU
	 mp6qJPJbtFZ6g2h97gY4GQBXZmIP6gurJUzavjltitNdi/p60AlizjS8QEaWlwTeUy
	 aoLM85s7J5o3l8qlm/H1mn+0tMFfKmDxdhYGs68Yqkt1Ypf8OkYJ2ZIfHLWbrwx+vz
	 VHlj7DNawI0AkinpSXWuWBYyCPJx16TusEkCV7r7ypOY8uSbbzzjOvAc5O9k+xtopp
	 yVPFEL+Drb0l2q3Bn+ZKMeByg2jKNr4kUBI7vG/ypTuzQn9BXgLdm/DtvB7/ej++OV
	 knxtZIqOW5OHp0BMpYJqmEmEdhsaQ4scioJmVFPIMyOULoYAPXT9q1JmVGZC1jJpVY
	 DRHfMb2erQBNyso0ala+td2rOfKHyZT+8/C2/eddivMbB3OLPKgPivNtXmnk841zf2
	 ZhQS2CBXskx3dMmaNDiD/CzHM7b1ZBhaApz/+U+p/mFMpo8naCOwcacmUcS4U2hmIv
	 +MnuUYtqkh8tDWYgY98tb9as=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2FE3E40E016E;
	Sun, 19 Oct 2025 11:12:25 +0000 (UTC)
Date: Sun, 19 Oct 2025 13:12:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.18-rc2
Message-ID: <20251019111222.GAaPTHlvJPUC-U56Z0@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the perf/urgent lineup for v6.18-rc2.

Thx.

---

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.18_rc2

for you to fetch changes up to fa4f4bae893fbce8a3edfff1ab7ece0c01dc1328:

  perf/core: Fix MMAP2 event device with backing files (2025-10-14 10:38:10 +0200)

----------------------------------------------------------------
- Make sure perf reporting works correctly in setups using overlayfs or FUSE

- Move the uprobe optimization to a better location logically

----------------------------------------------------------------
Adrian Hunter (3):
      perf/core: Fix address filter match with backing files
      perf/core: Fix MMAP event path names with backing files
      perf/core: Fix MMAP2 event device with backing files

Jiri Olsa (1):
      uprobe: Move arch_uprobe_optimize right after handlers execution

 kernel/events/core.c    | 8 ++++----
 kernel/events/uprobes.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

