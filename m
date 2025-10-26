Return-Path: <linux-kernel+bounces-870306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 238EBC0A6D8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E155349C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A2B248F69;
	Sun, 26 Oct 2025 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MzWiUUJA"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C4C19E968
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761480123; cv=none; b=RMvQxTs0KyUp56Mls+TwZqzoqBySHF+d5SDZfhp34lUgTw62bnOpWEaCO9molyZUwQOrmj56818yIXQM/Q/wfCvC8MaDmkUAwy1vNYFGMN15o7u7AaesEF1VInYMutQikkXFjUyxZpVDDZvqjbcOOSbrG4V8aH5IkebjfdtejbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761480123; c=relaxed/simple;
	bh=CzH7FPqCvtZsjox5xz/DcP+0N/CpJi2XEMWkMDy+pvM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vm+oBxQ3msuxGFow+8lUk3+8EwBZri+OYrqLZaQy95xAaEhfyy1XREjEXIpa4cbSzqlzULvhRExLfPH5CXg8qBsPWtmrbDlHQVE1ZbjW1BqphaNRE9SkXtFJh8uyDvnNlslhTCgwtiKNhFlqLDRoytKPN6BERjcDDOLq0Ukq9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MzWiUUJA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EBFE140E01AB;
	Sun, 26 Oct 2025 12:01:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id B-hD-33Zgg1A; Sun, 26 Oct 2025 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761480114; bh=WvCMgqozrlp88COIpUKSgr4+bdoDf5ctzZr89X4ts54=;
	h=Date:From:To:Cc:Subject:From;
	b=MzWiUUJAhs+7k4knRZtAqjI6K9xNVlX2vbr4Ebml/ocy/CW87vTC6p+PYy5aphPIn
	 /Sixqzqwn+8fq9/OC44qTYzizVLWLfXP2UNlCCbLPhVS4dIvMo1LCQOS75H/vgEVjh
	 cNnyZxDcLqwSvULghUmXCoQB50Yng9cqGv0TC7UURCAKGTdKAuexYLlUhKB5jV+hyy
	 Eigml8ZuHVlz6AXakMA5wMPTXt2YChfaI6rHqaAz3GD1aJejzAZoXPagXxwGLeW4vw
	 7KMhlN0JE8ig4IktazbKS/Bs7dQpIh2QHf+KkeAVB5Cl8xlJYgqxndxixYUEnUlQf2
	 +OFOdM2MZS+f9fY6/J3/uwL09s7SJNkuaih1Que/vXNIkdwgS8JphMBMzBx+4rLcgO
	 IFsolDYrUJ0poKZ52xBupcUM8/xmcxNWg9A07sf0351jYlV2Gt0mx7M4QAxi/+UrMK
	 mJVfVZQr5IYzirHpbyUsrJ0Y9OdFBZqHDgX5oBNNu/9b9ONKFL/V2TJaquWrUi1w6s
	 GaNbXBib6e/tWSVOOBu39Ir2DGWE/P+9Ge7ZBuLBD9foLdHHWyAZ0zMN1M/TrDptXe
	 UN/eA2AKpJznd/kJFVY+EtqS9aAaVug6iN6bMSxRiLEy4N9RaiakiWFaoLSUghnAKx
	 r8tB6dUBODrMJh9O+xgrpxxI=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 464CE40E00DA;
	Sun, 26 Oct 2025 12:01:51 +0000 (UTC)
Date: Sun, 26 Oct 2025 13:01:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for v6.18-rc3
Message-ID: <20251026120144.GAaP4NqP3HN06aP34r@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the objtool/urgent lineup for v6.18-rc3.

Thx.

---

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/objtool_urgent_for_v6.18_rc3

for you to fetch changes up to 49c98f30f4021b560676a336f8a46a4f642eee2b:

  objtool: Fix failure when being compiled on x32 system (2025-10-22 15:21:55 +0200)

----------------------------------------------------------------
- Fix x32 build due to wrong format specifier on that sub-arch

- Add one more Rust noreturn function to objtool's list

----------------------------------------------------------------
Miguel Ojeda (1):
      objtool/rust: add one more `noreturn` Rust function

Mikulas Patocka (1):
      objtool: Fix failure when being compiled on x32 system

 tools/objtool/check.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

