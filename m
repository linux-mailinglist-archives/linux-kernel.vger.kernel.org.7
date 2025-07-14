Return-Path: <linux-kernel+bounces-729899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC851B03D46
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8A7175287
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ADC246778;
	Mon, 14 Jul 2025 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCRc4uDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A715B17C77
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492168; cv=none; b=CGzjrsEOPuwrHrqYUGFkmTP2jumtd7TZSCHCEASkGf8GT7Hpr4R4ghJZ3dVl8ZB7m7AWzZ+cw4ok1udHCJ4k1WkZt0ZunrgAPJLmdtlrtRVfBHIAFi8JnScY+SZP5shXTLNZhl6DJ6l34IkbtefLSEICVHlU8VAoqHnccy6eCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492168; c=relaxed/simple;
	bh=eupN5HxOGmkNc6Cw38VhHgDtAG0xIE1iOkot5oZjUsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dxvKrkBf3wl0fHo6yCwsdhIZNGO41E5B/WJcqZH27e/WcOJJ6COHWPgum/ZAJzJ8DPYkQ/tcSwBXy7x5JS+K3Tuab7hkyw+lq3ZHDVj+cUAnElx5Tkb9eFFkZz5PKP71xH72pOoofFSI76ijMhL8p/rOyKb5pxcm10SJO1hLi6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCRc4uDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31133C4CEED;
	Mon, 14 Jul 2025 11:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752492168;
	bh=eupN5HxOGmkNc6Cw38VhHgDtAG0xIE1iOkot5oZjUsY=;
	h=From:Date:Subject:To:Cc:From;
	b=sCRc4uDGr1GQfCSwBB6l/HLI1O3njulL2xrtgZ0DGT8bPoxcqX+Bg9sc6j71ZP2Mn
	 kX2VJ7uJPeeWREbAl/Mf2PNrJPhUjoSx+fpqpxLtoPg3NWpthbue5I4NFoaraEfVHJ
	 Trw2hjMsNMJPLG0TO7yFxCiwuZtl5gpCchnYee8KGFj4LPVDMRNOUIhh/UTY47vy+R
	 Ch+Sb+byjf5pgxKlMGetMO4yy3p623PBGD1+oT6WzmvWsl91ZbIzrFjuL0w+um2yl9
	 utFEWzT7YtqSqM0lwVhfZWScF1NwEDH0ecjufF4w1fCJ2XP0W0hxv0tq1zi/kMxXjF
	 6a+yyL3ieR0oA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 14 Jul 2025 12:21:27 +0100
Subject: [PATCH v2] arm64/gcs: Don't call gcs_free() when releasing
 task_struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-arm64-gcs-release-task-v2-1-8a83cadfc846@kernel.org>
X-B4-Tracking: v=1; b=H4sIADfodGgC/3WNyw6CMBBFf8XM2jFtLTVx5X8YFn0M0IBgZgjRE
 P7dSty6PCe5564gxJkErocVmJYseRoLmOMBYufHljCnwmCUqZTTCj0/nMU2CjIN5IVw9tLjWV1
 ScKrxOlgo4ydTk197+F4X7rLME7/3n0V/7S9pqn/JRaPGysaQoknBanfriUcaThO3UG/b9gGil
 KfevQAAAA==
X-Change-ID: 20250610-arm64-gcs-release-task-307db60fa1b4
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2024; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eupN5HxOGmkNc6Cw38VhHgDtAG0xIE1iOkot5oZjUsY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBodOiG/3RE8umgKHyexaxCTtokEiAZNAKiXsr7i
 GT4UAh59D+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaHTohgAKCRAk1otyXVSH
 0O28B/4obCY4pUwxBTPWO9pFk0szGkgyIClyInyNfoLM3PHfgdRBCbSitvja06qJCMG99mvyARS
 L9sGhNUFiOctWMBlThdrPL3+AdqWoa5+uMo6v2ycHOWN2ymDB35ltHv5CUMk/qIWIZDkefJmt1q
 Uqp4Bmrgpit8jbHNFKNDEiWhLLUSPOlRz6dGrKvaplIq9v42/+X862XtmvbUAJnZaUS9/640m2c
 L6MijVPyx9xZm97yKd4ouyrzVei1HtvoiQN6jnZfuwNgn+rMThZORYmhn9fhaQziLSAUeVu0v15
 891M7H9Eq7/DdtxAksZWEGd6eTChdmXQnppL6LYIcyk1d399
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently we call gcs_free() when releasing task_struct but this is
redundant, it attempts to deallocate any kernel managed userspace GCS
which should no longer be relevant and resets values in the struct we're
in the process of freeing.

By the time arch_release_task_struct() is called the mm will have been
disassociated from the task so the check for a mm in gcs_free() will
always be false, for threads that are exiting leaving the mm active
deactivate_mm() will have been called previously and freed any kernel
managed GCS.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Remove stale comment in gcs_free().
- Link to v1: https://lore.kernel.org/r/20250625-arm64-gcs-release-task-v1-1-54cbdc2db416@kernel.org
---
 arch/arm64/kernel/process.c | 1 -
 arch/arm64/mm/gcs.c         | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 5954cec19660..5dcfab9ce012 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -341,7 +341,6 @@ void flush_thread(void)
 void arch_release_task_struct(struct task_struct *tsk)
 {
 	fpsimd_release_task(tsk);
-	gcs_free(tsk);
 }
 
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 5c46ec527b1c..6e93f78de79b 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -157,12 +157,6 @@ void gcs_free(struct task_struct *task)
 	if (!system_supports_gcs())
 		return;
 
-	/*
-	 * When fork() with CLONE_VM fails, the child (tsk) already
-	 * has a GCS allocated, and exit_thread() calls this function
-	 * to free it.  In this case the parent (current) and the
-	 * child share the same mm struct.
-	 */
 	if (!task->mm || task->mm != current->mm)
 		return;
 

---
base-commit: 86731a2a651e58953fc949573895f2fa6d456841
change-id: 20250610-arm64-gcs-release-task-307db60fa1b4

Best regards,
--  
Mark Brown <broonie@kernel.org>


