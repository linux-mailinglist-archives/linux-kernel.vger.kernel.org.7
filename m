Return-Path: <linux-kernel+bounces-779643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256CFB2F6BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FDA3A7831
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305AD30E853;
	Thu, 21 Aug 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2fFVzfk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8192367AE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775665; cv=none; b=S43S8qE9/TeMSt5FPIfQ2t29Gnu3jlb7+vHPc7XV3KH8Z7Ll3sGEIdCeU7hn28vNAQ8UkTCNc+I9FeRD+ada+lWW8Yqs1z7RBBhGW8shJY7xRMUqu5PlRYU075I9ZV+JWuaBEXrU9IJC68ugPAXdlO/vzGCuhLoOXULRRgvLavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775665; c=relaxed/simple;
	bh=1M9j+PL0n2Y6NH2XjNF7fuQwEwS11EOrVMi3fRSifwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KxO6o+WP6b4zIGcGZ8l7T0bCi6LnhPw1evcJ0mV1C1ItWVfNOxzl/yT66FPXWAgb+/96wt+ogvorywuuLm1kXTGjFH+F8OvyGws8pji6L4gBmOJBDppg7Q5KajM1iXGItFeHdtkDCjuf17OD50g/BfQkHXUMLjSRspyT6H1V45s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2fFVzfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20A16C4CEED;
	Thu, 21 Aug 2025 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755775665;
	bh=1M9j+PL0n2Y6NH2XjNF7fuQwEwS11EOrVMi3fRSifwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N2fFVzfkdDB7GMIspdbWMZpvAcU3dGmdaTj3qgZjchgPgc7MOdWR66qfxpyBUFtIv
	 WeJeOURS2BKBKpwbv/wsi8sDD8adH+9QDYfKgF0gLfk8K0AOLYAofZaCWrAdopQfnH
	 F1SKnzqV4xr//+T+3MDtIHQ73Tj7DW/QaKCtOjqdotBsBfIUGmfeiSg7qeBGloF5bF
	 Qqwac79x3Sw693koPMtmL9i5TME7cQA8fAtkD4GVsCwon1z0Rcezt8ibjUgyilblna
	 tzHbmh9HyLlPBhL7aK5xEn9ofyGWqBoNncOfB2uNwojLVJ333lO/l4N5ucUqVJpU9D
	 7RaCAwyOReXvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5BCCA0EFF;
	Thu, 21 Aug 2025 11:27:45 +0000 (UTC)
From: Simon Schuster via B4 Relay <devnull+schuster.simon.siemens-energy.com@kernel.org>
Date: Thu, 21 Aug 2025 13:27:37 +0200
Subject: [PATCH 1/2] copy_process: Handle architectures where
 sizeof(unsigned long) < sizeof(u64)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-nios2-implement-clone3-v1-1-1bb24017376a@siemens-energy.com>
References: <20250821-nios2-implement-clone3-v1-0-1bb24017376a@siemens-energy.com>
In-Reply-To: <20250821-nios2-implement-clone3-v1-0-1bb24017376a@siemens-energy.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755775663; l=2756;
 i=schuster.simon@siemens-energy.com; s=20250818;
 h=from:subject:message-id;
 bh=fATaBcMTm8PaXx+wvHRntwDrs2IKs0+IzRTpuUxyYa4=;
 b=y7/IgnYV/3SkSNwCoqgDE/+S2MUsRejhrdpl2L+U7VnPzMzgttiqeo7QuevGlQKo7aBzvBcQ5
 485HV4aRh6JBpSGlbRD35ZZAmT8+Yb7t7dbqgXJf0B1MkEE0oKL4n0t
X-Developer-Key: i=schuster.simon@siemens-energy.com; a=ed25519;
 pk=PUhOMiSp43aSeRE1H41KApxYOluamBFFiMfKlBjocvo=
X-Endpoint-Received: by B4 Relay for
 schuster.simon@siemens-energy.com/20250818 with auth_id=495
X-Original-From: Simon Schuster <schuster.simon@siemens-energy.com>
Reply-To: schuster.simon@siemens-energy.com

From: Simon Schuster <schuster.simon@siemens-energy.com>

With the introduction of clone3 in commit 7f192e3cd316 ("fork: add
clone3") the effective bit width of clone_flags on all architectures was
increased from 32bit to 64bit. However, the signature of the copy_*
helper functions (e.g., copy_sighand) used by copy_process was not
adapted, as such, they potentially truncate the flags on architectures
such as nios2, where unsigned long is a 32bit unsigned integer type.

This can, for instance, be observed via failures of kernel selftest
clone3_clear_sighand, which attempts to trigger the conditional

	if (clone_flags & CLONE_CLEAR_SIGHAND)

in function copy_sighand within fork.c that will always fail given:

	unsigned long /* == uint32_t */ clone_flags
	#define CLONE_CLEAR_SIGHAND 0x100000000ULL

This commit fixes the bug by always passing clone_flags via their
declared u64 type, invariant of architecture-dependent integer sizes.

Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
---
 kernel/fork.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 5115be549234..0e9b2dd6c365 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1510,7 +1510,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	return NULL;
 }
 
-static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_mm(u64 clone_flags, struct task_struct *tsk)
 {
 	struct mm_struct *mm, *oldmm;
 
@@ -1548,7 +1548,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_fs(u64 clone_flags, struct task_struct *tsk)
 {
 	struct fs_struct *fs = current->fs;
 	if (clone_flags & CLONE_FS) {
@@ -1569,7 +1569,7 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
+static int copy_files(u64 clone_flags, struct task_struct *tsk,
 		      int no_files)
 {
 	struct files_struct *oldf, *newf;
@@ -1599,7 +1599,7 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
 	return 0;
 }
 
-static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_sighand(u64 clone_flags, struct task_struct *tsk)
 {
 	struct sighand_struct *sig;
 
@@ -1648,7 +1648,7 @@ static void posix_cpu_timers_init_group(struct signal_struct *sig)
 	posix_cputimers_group_init(pct, cpu_limit);
 }
 
-static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_signal(u64 clone_flags, struct task_struct *tsk)
 {
 	struct signal_struct *sig;
 

-- 
2.39.5



