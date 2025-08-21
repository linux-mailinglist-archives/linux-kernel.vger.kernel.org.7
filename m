Return-Path: <linux-kernel+bounces-779547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B185B2F57D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABA8602704
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338F29CEB;
	Thu, 21 Aug 2025 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEl1Cn87"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92E2DA767
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772652; cv=none; b=ZyF1bbHJ7khYvf2HXEDHCpmyDEgvayjRl12sZIEk33+nUzk0agAtw69ohDfxfd34xY5KM3CmXlsGaAGJ7CONlwvBeVF9tbx+itv3nmI7SQih0syF95/p8r5zn5wjkA8iYqslI7SC3kuJRPo3YNF6khg9nyA04gkuqvC0I82twPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772652; c=relaxed/simple;
	bh=RVBuCyEroX7VX4W3006I0jDtc+XU/hPUdb5LYnFmQvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=suvksNrabmMA1+dsUb+7BqPw+3r57vNK6YVNH7aonLbrgf0tLhCA0oTnxcXGFRqjg2fW/BSTEMX6aYsmt7lG5YJt2NMYvhT+2ognLRWl8jeqkTvwHXkQQjr3Ac+aBduwNKYn+TOgmxLFwKKRILmJZHtfX3XwSpCTf4y3e+M/iwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEl1Cn87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13C16C4CEED;
	Thu, 21 Aug 2025 10:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755772651;
	bh=RVBuCyEroX7VX4W3006I0jDtc+XU/hPUdb5LYnFmQvE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=IEl1Cn87zl7hbzEc/mR3qhN/7I7sp6TX/F7JFuJyEcbbJeLQYcNwkuwjorDWmFH3G
	 XWkYGWkm2xzYwq6LX983MNHx1887HqzU/Eyu39DZ2Snk6OhbdVfQ+JwseqCTARDXlA
	 pe2mmK15bYIlaXquWoo9p+/dEE/cS+mqnNrDknkOiRgwe4FSd1arpPSOdzjI+YkiaW
	 Onk+D6bHYEP2EXCj0vdfcTmT8jqLsEzJy+AUFw9H7Zbj/+FchOx0sse/mcrCgacE0L
	 sRPj871yOqp4vk+6bTLgcI5F6pucQCp1tdIvKxGZ1Ok3zVNXrJDnBNbcsO3VW/nofi
	 8pOSYMepk/evg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20DECA0EDC;
	Thu, 21 Aug 2025 10:37:30 +0000 (UTC)
From: Simon Schuster via B4 Relay <devnull+schuster.simon.siemens-energy.com@kernel.org>
Date: Thu, 21 Aug 2025 12:37:07 +0200
Subject: [PATCH] nios2: ensure that memblock.current_limit is set when
 setting pfn limits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-nios2-adjust-lowmem-bounds-v1-1-ea2dd8661ae5@siemens-energy.com>
X-B4-Tracking: v=1; b=H4sIANL2pmgC/x3MwQqDMAwA0F+RnA3UglD3K8NDZ9KZMVtpVhXEf
 1/x+C7vBOUsrPBoTsi8iUqKFV3bwDT7+GYUqgZrbG9c5zBKUouePkV/+E37wgu+Uomk2JOlwfl
 ggndQgzVzkOPOn+N1/QFbLef4bAAAAA==
X-Change-ID: 20250818-nios2-adjust-lowmem-bounds-5d2d98af0fa8
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 Andreas Oetken <andreas.oetken@siemens-energy.com>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755772650; l=2529;
 i=schuster.simon@siemens-energy.com; s=20250818;
 h=from:subject:message-id;
 bh=XAavluzVGgOGPX323zI/x3pk1jtcKLayQnaSWVVemI4=;
 b=GcI81uCNpdeGjwM6REZsMNAj6DwIQzDGRCbchylCEARbO7bSUHPyscSO5GSDw63uq9NqcCk20
 zGrVRHgILeSCebLJY4VTfGDt6FGAlApBgqOENV2dbv+4T0ZzTkxcKWz
X-Developer-Key: i=schuster.simon@siemens-energy.com; a=ed25519;
 pk=PUhOMiSp43aSeRE1H41KApxYOluamBFFiMfKlBjocvo=
X-Endpoint-Received: by B4 Relay for
 schuster.simon@siemens-energy.com/20250818 with auth_id=495
X-Original-From: Simon Schuster <schuster.simon@siemens-energy.com>
Reply-To: schuster.simon@siemens-energy.com

From: Simon Schuster <schuster.simon@siemens-energy.com>

On nios2, with CONFIG_FLATMEM set, the kernel relies on
memblock_get_current_limit() to determine the limits of mem_map, in
particular for max_low_pfn.
Unfortunately, memblock.current_limit is only default initialized to
MEMBLOCK_ALLOC_ANYWHERE at this point of the bootup, potentially leading
to situations where max_low_pfn can erroneously exceed the value of
max_pfn and, thus, the valid range of available DRAM.

This can in turn cause kernel-level paging failures, e.g.:

[   76.900000] Unable to handle kernel paging request at virtual address 20303000
[   76.900000] ea = c0080890, ra = c000462c, cause = 14
[   76.900000] Kernel panic - not syncing: Oops
[   76.900000] ---[ end Kernel panic - not syncing: Oops ]---

This patch fixes this by pre-calculating memblock.current_limit
based on the upper limits of the available memory ranges via
adjust_lowmem_bounds, a simplified version of the equivalent
implementation within the arm architecture.

Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
Signed-off-by: Andreas Oetken <andreas.oetken@siemens-energy.com>
---
This patch was tested internally on 5.10.x stable for some time now and
applies and boots cleanly on next-20250815, as well.
---
 arch/nios2/kernel/setup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 2a40150142c3..f43f01c4ab93 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -142,6 +142,20 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
 	*max_high = PFN_DOWN(memblock_end_of_DRAM());
 }
 
+static void __init adjust_lowmem_bounds(void)
+{
+	phys_addr_t block_start, block_end;
+	u64 i;
+	phys_addr_t memblock_limit = 0;
+
+	for_each_mem_range(i, &block_start, &block_end) {
+		if (block_end > memblock_limit)
+			memblock_limit = block_end;
+	}
+
+	memblock_set_current_limit(memblock_limit);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	console_verbose();
@@ -157,6 +171,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Keep a copy of command line */
 	*cmdline_p = boot_command_line;
 
+	adjust_lowmem_bounds();
 	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
 
 	memblock_reserve(__pa_symbol(_stext), _end - _stext);

---
base-commit: 1357b2649c026b51353c84ddd32bc963e8999603
change-id: 20250818-nios2-adjust-lowmem-bounds-5d2d98af0fa8

Best regards,
-- 
Simon Schuster <schuster.simon@siemens-energy.com>



