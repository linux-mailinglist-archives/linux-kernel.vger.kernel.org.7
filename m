Return-Path: <linux-kernel+bounces-891510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07578C42D1D
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 14:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7737A4E1F2A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 13:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD58C2BAF7;
	Sat,  8 Nov 2025 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtvBGNU+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2639734D3A9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762607069; cv=none; b=IcktSWJG3Q+F/rgEDExgMc5U/4OAPiDZzYKubRG4fixlttdIFH8uO3UCANmjlVQPUTyd7s35DtWMzR7dOUm2kq11zCzDYBjaDoGxNI34Ymervqv4ybx0X1KclvR3m0dy87HFLlvT5i+XCmJ0xCKL0GZ2KObt1gR/53xK25mZfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762607069; c=relaxed/simple;
	bh=OzIMCKQb6IkHBqEEfZaauAwluqNBj8C9BUfXJwnA4oY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ngxYtwyE6512Fq022nyx3IjwnXWBtCaaC0h3HCx1eDdjDjfAnSLVUa8ODvW3nH3V+7ex9qikimmaRI7PzRrjBeFX0ro8ZtrxLl1USyHDOOxFMwyg5dorNJJdE9mTsQE6mbF3PBgvRj2sR82cGXusr6SygkjRjQX5ttJciFVJS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtvBGNU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769D0C116C6;
	Sat,  8 Nov 2025 13:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762607068;
	bh=OzIMCKQb6IkHBqEEfZaauAwluqNBj8C9BUfXJwnA4oY=;
	h=Date:From:To:Cc:Subject:From;
	b=RtvBGNU+4N8hdEO7yzqgXgyJ3o9GX1oCWIxBP4czP3+nF807u47LbIAwkFCAnAvcW
	 v/ya+BgXx/kLu35B0Xa2AgjJQrfE27XZF8usYu+LN+4EyYbFze8zdB86lFVUTCVcXE
	 gTHY+GhS0qgTPAeM1dn/xxH4D2wbDQrYHGDso7FUZENZThuA+VVdDC94cKn2kcUYlD
	 aT5Fyzrp/l/nPYvVFgvdgqCY3Ek8zvF9EAYY4Gbd/e5Z6MYtMmko0shmANlX7xjUhV
	 DHwKRayesoRGUQNefVCn2LUWyks10caync2RuD5AfkwRfT3UPfs27ReD4l2w2dqjMr
	 0XhtXXJt2B9eA==
Date: Sat, 8 Nov 2025 14:04:18 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] locking fix
Message-ID: <aQ8_0mAj3AUGgguL@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest locking/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-11-08

   # HEAD: 4cb5ac2626b5704ed712ac1d46b9d89fdfc12c5d futex: Optimize per-cpu reference counting

Fix (well, cut in half) a futex performance regression on PowerPC.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (1):
      futex: Optimize per-cpu reference counting


 kernel/futex/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 125804fbb5cb..2e77a6e5c865 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1680,10 +1680,10 @@ static bool futex_ref_get(struct futex_private_hash *fph)
 {
 	struct mm_struct *mm = fph->mm;
 
-	guard(rcu)();
+	guard(preempt)();
 
-	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
-		this_cpu_inc(*mm->futex_ref);
+	if (READ_ONCE(fph->state) == FR_PERCPU) {
+		__this_cpu_inc(*mm->futex_ref);
 		return true;
 	}
 
@@ -1694,10 +1694,10 @@ static bool futex_ref_put(struct futex_private_hash *fph)
 {
 	struct mm_struct *mm = fph->mm;
 
-	guard(rcu)();
+	guard(preempt)();
 
-	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
-		this_cpu_dec(*mm->futex_ref);
+	if (READ_ONCE(fph->state) == FR_PERCPU) {
+		__this_cpu_dec(*mm->futex_ref);
 		return false;
 	}
 

