Return-Path: <linux-kernel+bounces-870542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B73C0B175
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89A6F4E28F5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172462FE584;
	Sun, 26 Oct 2025 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kael-k.io header.i=@kael-k.io header.b="QyRNHR8A"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930212F7AA0
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761508562; cv=none; b=cDv9ThrzSIYKKZQ69G5xym3ZYI2YGqZCaMLlTfb4AK4g+KkUg2At4MZe13M9f9w5NidZvGIyyk6+jVMwK8TD8UbtgScJ6nfLxRHioC5fkCiaM32yPYI7EDJaOT0iUTdinV1O037TZv1g3acfcotpsIuQYAvhQuQ/nrBU3TVbXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761508562; c=relaxed/simple;
	bh=H0TxvcJ51hfZQupFN5c3WS8Pcmpw6ozRMAeo8gfaMuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESFGz60Mt+Cl9Q6ZdmS5n9+ikN/aVp9wySUT2eQpzN2TwlQBmPwH84K61CiXlMWt4ixpQkVNKRPvwChTPtqhwF4mlT67/XFl+z0SVtICzv1jvHiGgGh1e9wieoKriAp5XFhi4btEnQFC1ZBmSjRBWCUy73IopIzTCpuX5hfYTpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kael-k.io; spf=pass smtp.mailfrom=kael-k.io; dkim=pass (2048-bit key) header.d=kael-k.io header.i=@kael-k.io header.b=QyRNHR8A; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kael-k.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kael-k.io
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cvnSR5z0hz9syH;
	Sun, 26 Oct 2025 20:55:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kael-k.io; s=MBO0001;
	t=1761508551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHm7bXIAc/FvP5v5MZJahiEX6nNrUjC13Ed/WE41dwA=;
	b=QyRNHR8AWxfbuf+0lqAZxv4bt04XfpOnnqz1xMGhhGoJvr7KhQNZDfc8LIXHEiDTDi2MH9
	q3XaYj46ae57TDI+Ff26d0h2Ufogf9fpWlrCN8yMWHT2Xrvum+kI7S+SiRBnyQ/ciTnIat
	qUB+hyA/nXogmq3m8h2/UFGHEnv5tyX3eAcu0AlJASCy1ZwHtMfScdTS/rRTgAa9shonFq
	7tFMWHwdph3/c+dhryvZcJ8T0y7ifqZd711Ol8zT2NyPLcPQG4/KvtzAs3FMJDTYJLae5O
	SmtjqJZcYCAsoIaNEQAYUbqpUxp5prTfYBmUNODdiTn/qy4aVgKhS+pfEfnV3A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of dev@kael-k.io designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=dev@kael-k.io
From: Kael D'Alcamo <dev@kael-k.io>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] x86/mtrr: Fix kernel-doc warnings in amd.c and centaur.c
Date: Sun, 26 Oct 2025 20:54:42 +0100
Message-ID: <20251026195511.79300-2-dev@kael-k.io>
In-Reply-To: <20251026195511.79300-1-dev@kael-k.io>
References: <20251021103739.GBaPdic1JTakX2bA9i@fat_crate.local>
 <20251026195511.79300-1-dev@kael-k.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cvnSR5z0hz9syH

Fix kernel-doc issues in amd.c and centaur.c that triggered warnings when
building with `W=1`

Signed-off-by: Kael D'Alcamo <dev@kael-k.io>
---
 arch/x86/kernel/cpu/mtrr/amd.c     | 8 ++++----
 arch/x86/kernel/cpu/mtrr/centaur.c | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/amd.c b/arch/x86/kernel/cpu/mtrr/amd.c
index ef3e8e42b782..02508a0a1a04 100644
--- a/arch/x86/kernel/cpu/mtrr/amd.c
+++ b/arch/x86/kernel/cpu/mtrr/amd.c
@@ -49,10 +49,10 @@ amd_get_mtrr(unsigned int reg, unsigned long *base,
 /**
  * amd_set_mtrr - Set variable MTRR register on the local CPU.
  *
- * @reg The register to set.
- * @base The base address of the region.
- * @size The size of the region. If this is 0 the region is disabled.
- * @type The type of the region.
+ * @reg: The register to set.
+ * @base: The base address of the region.
+ * @size: The size of the region. If this is 0 the region is disabled.
+ * @type: The type of the region.
  *
  * Returns nothing.
  */
diff --git a/arch/x86/kernel/cpu/mtrr/centaur.c b/arch/x86/kernel/cpu/mtrr/centaur.c
index 6f6c3ae92943..f4c72402c284 100644
--- a/arch/x86/kernel/cpu/mtrr/centaur.c
+++ b/arch/x86/kernel/cpu/mtrr/centaur.c
@@ -20,6 +20,7 @@ static u8 centaur_mcr_type;	/* 0 for winchip, 1 for winchip2 */
  *
  * @base: The starting (base) address of the region.
  * @size: The size (in bytes) of the region.
+ * @replace_reg: mtrr index to be replaced; set to invalid value if none.
  *
  * Returns: the index of the region on success, else -1 on error.
  */
-- 
2.51.1


