Return-Path: <linux-kernel+bounces-842444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9D6BBCBE7
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 22:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08A51894DA7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 20:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDFC1E9B1C;
	Sun,  5 Oct 2025 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kael-k.io header.i=@kael-k.io header.b="gtzQznhY"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A1A55
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759696949; cv=none; b=hDTmfuOxafPvW9CDBR0zFaysVGMJ7L7OGYaAbHJIsfHYUlWy8WdL+2jUMjy2D52Ho4P0dRSVn3DmBl1b+CfCUjD6CakQ+hNGSfYODOTaWfvLxgSXvB6hmWkeC7MZWBfxjD/S4sjTbbTKp4TXo9x7y+U+EF5HfuPQK+9HTcCtpk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759696949; c=relaxed/simple;
	bh=OM0BTEzXZXOp8VqEkLQrJ2dabWQmZTkVIzKahFarOOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQOf+CP3byoBUQiA8+Do9xGnCNydzxOg4jneCztQEoCwQaQftTTvw56M73jBzm3R+aoeNY322eoCzvHT+rZLR9eCFX+3jmVsWwbyFh8tI3pnu39ZwfZ9SNyv8ZaPnxP6uTmkLkNszYJXKVrJAppibDjHFFpO6uspDVCTkYT3byQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kael-k.io; spf=pass smtp.mailfrom=kael-k.io; dkim=pass (2048-bit key) header.d=kael-k.io header.i=@kael-k.io header.b=gtzQznhY; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kael-k.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kael-k.io
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cfvTr0J1Rz9v8T;
	Sun,  5 Oct 2025 22:42:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kael-k.io; s=MBO0001;
	t=1759696944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSIH05BZK9cp23wWeCCQDin855DWzBQyWCko2O7hkx4=;
	b=gtzQznhYQAxubbb9cKD+y6Vfhva7pm0h1+eiHb0gEdJ5i19VYj2xqrALq1H+nrd8OHuWiR
	t2aD70pKERjEC4ug1uh7QtcOnpFiicgsI8QK5Bt4DGHZm2GwiQ1cYtObqZnMiO4kJ7LbzY
	Xul3eHYFj7WpE+xudzoTnU7CGD6kO3FPrkAwrC9OvV/cJxcbks0oFv25fNL4EYf33hOHOr
	9bbeJtKM20Q+ewp7bjDRtlDHqIV+xtagf8VQaQh3rvOEfL6iBuM5xFXRLBiwuuv91e2I8j
	0zzHEGq03Men7i2tPTk9TfVerJ86Qx/vB/Of+GnEHQqo5iQCv/VseX32POhQGA==
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
Subject: [PATCH 1/2] x86/cpu: Fix kernel-doc for 'amd_set_mtrr'
Date: Sun,  5 Oct 2025 22:41:20 +0200
Message-ID: <20251005204200.191346-2-dev@kael-k.io>
In-Reply-To: <20251005204200.191346-1-dev@kael-k.io>
References: <20251005204200.191346-1-dev@kael-k.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cfvTr0J1Rz9v8T

Signed-off-by: Kael D'Alcamo <dev@kael-k.io>
---
 arch/x86/kernel/cpu/mtrr/amd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
-- 
2.51.0


