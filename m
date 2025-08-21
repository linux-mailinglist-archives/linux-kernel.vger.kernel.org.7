Return-Path: <linux-kernel+bounces-779642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C559B2F6A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D8D5A7556
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADA030E83E;
	Thu, 21 Aug 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xreu90YK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7A82153E7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775665; cv=none; b=oEelePMzxsl29xQGwtvUOikPrGbg441v+HNCsJhWf/msWTSFgcX7HtNGyDi8VMH/rjavOlbVxfUl80OiU3Y2jozhnnZhZGpq/m0A1BlwrRLIBhI3pi2nE65QWgdPhmQ/X4F3xPyAV7Vh8uC0d33Ck1blp4P2nTZ6XZzGg4Ca7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775665; c=relaxed/simple;
	bh=3jlVObemI8wNIqbrx4GvyEPDpvdLGZ3e4VpPlUqrZvQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RqJ7jgT3niqXzPMgC2PS5akBDlpdCgKjR3cN86FVZGqJtp+FnqQxkQDPbnovHR+rDd4FLDA2KVQbUMNrAUkmXd+fRILr0ChtRrRDPItvJ1SptK6HOJI07/o4y+BlQzTiKYiNxI3cr0dTndWmeq3nwmvzp1svn9hcDAA8HSWP0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xreu90YK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11C27C4CEEB;
	Thu, 21 Aug 2025 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755775665;
	bh=3jlVObemI8wNIqbrx4GvyEPDpvdLGZ3e4VpPlUqrZvQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Xreu90YKRQkLt1GO00XLRQQzdbuLIWkk65EQ5x8E2usICSaQzGLr3rUvLMlI61Tm6
	 aiBsHyhQBqAHVqio3Upg/jGa9zuH/uhNM1iJPc1bJBRtJ7OqOHEXcUBxhxS+s8W+Qn
	 scFoT6OqjMgbaZCuUyrihQhdZfNI9/7PxKjV2CbNFOmr7RuvwHiNBOyxqJRPw6m4wJ
	 mQpH3HGADdDY3UarIDl33cXw27pa1p/ln9xaIYrVUFQv07mA3wIXLMOHtFC21vsHQq
	 2uvCYKY7hbNu6dZEL4IZ9HapzJbNuHxpArLOzFm+aj8ODjBQleJuOuiqG+j6VwnamX
	 TOJ+WSssFboww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB60FCA0EEB;
	Thu, 21 Aug 2025 11:27:44 +0000 (UTC)
From: Simon Schuster via B4 Relay <devnull+schuster.simon.siemens-energy.com@kernel.org>
Subject: [PATCH 0/2] nios2: Add architecture support for clone3
Date: Thu, 21 Aug 2025 13:27:36 +0200
Message-Id: <20250821-nios2-implement-clone3-v1-0-1bb24017376a@siemens-energy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKgCp2gC/x3MwQpAQBCA4VfRnE2tETavIgfWYIpZ7UpK3t3m+
 B3+/4HIQThCmz0Q+JIoXhOKPAO3DrowypQMZKgytrCo4iOh7MfGO+uJbvPKJTYzVeTI2NqMkOI
 j8Cz3P+769/0A89WUVmgAAAA=
X-Change-ID: 20250818-nios2-implement-clone3-7f252c20860b
To: Dinh Nguyen <dinguyen@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Simon Schuster <schuster.simon@siemens-energy.com>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755775663; l=1662;
 i=schuster.simon@siemens-energy.com; s=20250818;
 h=from:subject:message-id;
 bh=3jlVObemI8wNIqbrx4GvyEPDpvdLGZ3e4VpPlUqrZvQ=;
 b=EvDLXxPY5S6pbpEC5hc9qqVLOseYDpRYpX2Y6TYKHHZX+LeSi4Q1+g0YK6AAKayY4Ep67AapT
 z5MIMrak0rXAMAqA/7z5o+qoiazxY9e5SyLNyqkwcBCJL6n99MlLudo
X-Developer-Key: i=schuster.simon@siemens-energy.com; a=ed25519;
 pk=PUhOMiSp43aSeRE1H41KApxYOluamBFFiMfKlBjocvo=
X-Endpoint-Received: by B4 Relay for
 schuster.simon@siemens-energy.com/20250818 with auth_id=495
X-Original-From: Simon Schuster <schuster.simon@siemens-energy.com>
Reply-To: schuster.simon@siemens-energy.com

This series adds support for the clone3 system call to the nios2
architecture. This addresses the build-time warning "warning: clone3()
entry point is missing, please fix" introduced in 505d66d1abfb9
("clone3: drop __ARCH_WANT_SYS_CLONE3 macro"). The implementation passes
the relevant clone3 tests of kselftest when applied on top of
next-20250815:

	./run_kselftest.sh
	TAP version 13
	1..4
	# selftests: clone3: clone3
	ok 1 selftests: clone3: clone3
	# selftests: clone3: clone3_clear_sighand
	ok 2 selftests: clone3: clone3_clear_sighand
	# selftests: clone3: clone3_set_tid
	ok 3 selftests: clone3: clone3_set_tid
	# selftests: clone3: clone3_cap_checkpoint_restore
	ok 4 selftests: clone3: clone3_cap_checkpoint_restore

The series also includes a small patch to kernel/fork.c that ensures
that clone_flags are passed correctly on architectures where unsigned
long is insufficient to store the u64 clone_flags.

Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
---
Simon Schuster (2):
      copy_process: Handle architectures where sizeof(unsigned long) < sizeof(u64)
      nios2: implement architecture-specific portion of sys_clone3

 arch/nios2/include/asm/syscalls.h |  1 +
 arch/nios2/include/asm/unistd.h   |  2 --
 arch/nios2/kernel/entry.S         |  6 ++++++
 arch/nios2/kernel/syscall_table.c |  1 +
 kernel/fork.c                     | 10 +++++-----
 5 files changed, 13 insertions(+), 7 deletions(-)
---
base-commit: 1357b2649c026b51353c84ddd32bc963e8999603
change-id: 20250818-nios2-implement-clone3-7f252c20860b

Best regards,
-- 
Simon Schuster <schuster.simon@siemens-energy.com>



