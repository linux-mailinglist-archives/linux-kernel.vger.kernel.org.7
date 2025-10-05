Return-Path: <linux-kernel+bounces-842443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7ECBBCBE3
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 22:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D81F3B44C2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 20:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C141E376C;
	Sun,  5 Oct 2025 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kael-k.io header.i=@kael-k.io header.b="zG0w2BvK"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2FA55
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759696940; cv=none; b=o98TbYaMCtPh5eLut0Ah3y9ix+ifXqSyDdNlqJBx9265pIuaLiJCsIIoMx2LYHxzSQzwn2H5HmmErtRXgwpHkoo/c7p8U3WGntP8zGVczrOZB0cBLPmEBdtoahWfGTZEvbuR/yx/SL5VfoabX6XnQrAO6b/ut2vIZ8c0wK6WEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759696940; c=relaxed/simple;
	bh=OzL0C3MxCBEKCHbGTf3T0bJDg/3i99Kle3otaNw5wyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pzfo/k5H9m5IcJQNfCcwydpXOOuRVzXd9LMPIX2u0KB8KP2DiryvulTrRoVgQAxJU4rILLglzziS1PI7ZXHL/dInF2SU84pNUtcVkHPlIs+VdDfnauLcwECENnf+fr8OYwbL0BFMGnLOi3Okktb0I2OOCNvMJwkRkJIZdr95zEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kael-k.io; spf=pass smtp.mailfrom=kael-k.io; dkim=pass (2048-bit key) header.d=kael-k.io header.i=@kael-k.io header.b=zG0w2BvK; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kael-k.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kael-k.io
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cfvTf1Vp5z9vVq;
	Sun,  5 Oct 2025 22:42:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kael-k.io; s=MBO0001;
	t=1759696934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1wRKKX9nggXZeOw9hkXI0lP/vjSDclwi3P+/1DFQRZM=;
	b=zG0w2BvKSMKui0AFpJvnRaeLkrkYynCmu6QKqeRuVD7nB74nSbCu9P3ziMK33TFavbszt3
	TAzPNkoCYyuOoGuJEfq2YJLmNKcnG52EPYl1RmtTugqQGAxIfLzVeoFb3GR4SSI+WLAQth
	gbbM3ApLy+3WhZUh5FHZIHfIK2f31KU6TzHv4tpkt1pY8Zq/LHjS/olQwIZ9J2xn2eGS7X
	XRvgS7/627xFU+nsD6ipfHinwzFeQTa9o+07D4xkDyEcBw6EDVIcMy92VKM1LEmkK15rnt
	wgWkxiiktidNNg2Bvbn8TS+1K/5gQEnuCVMMtYxFR7+NaonuX6vVX1QIynilkw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of dev@kael-k.io designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=dev@kael-k.io
From: Kael D'Alcamo <dev@kael-k.io>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] x86/cpu: Fix kernel-doc warnings
Date: Sun,  5 Oct 2025 22:41:19 +0200
Message-ID: <20251005204200.191346-1-dev@kael-k.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cfvTf1Vp5z9vVq

Fix the following kernel-doc warnings found by `make W=1`:

Warning: arch/x86/kernel/cpu/mtrr/amd.c:60 function parameter 'reg' not described in 'amd_set_mtrr'
Warning: arch/x86/kernel/cpu/mtrr/amd.c:60 function parameter 'base' not described in 'amd_set_mtrr'
Warning: arch/x86/kernel/cpu/mtrr/amd.c:60 function parameter 'size' not described in 'amd_set_mtrr'
Warning: arch/x86/kernel/cpu/mtrr/amd.c:60 function parameter 'type' not described in 'amd_set_mtrr'
Warning: arch/x86/kernel/cpu/mtrr/centaur.c:27 function parameter 'replace_reg' not described in 'centaur_get_free_region'

Kael D'Alcamo (2):
  x86/cpu: Fix kernel-doc for 'amd_set_mtrr'
  x86/cpu: Fix kernel-doc for 'centaur_get_free_region'

 arch/x86/kernel/cpu/mtrr/amd.c     | 8 ++++----
 arch/x86/kernel/cpu/mtrr/centaur.c | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.51.0


