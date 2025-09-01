Return-Path: <linux-kernel+bounces-794561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E39FAB3E34E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E33F1A83729
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52C831AF28;
	Mon,  1 Sep 2025 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AfH3B5ab";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e2CvqpTq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD262212FB9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730078; cv=none; b=cPCjY64aYHf/kZQlBpSR7B8bQQVEijoITL5p9shrzsi1wW21vldhTMLohQPbjki0eI92jXOi3uEFej1sqHrVNITfXMf6WoiNHPTSijzauVC/3Wirtzb/uvqtNmlHrV4Hdk9E18sPsbeeV0lmKc1Ymh9+u32WTZzqfoAVk2TEpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730078; c=relaxed/simple;
	bh=gsDbVDGiBLCLkCrBpBIWkJQQHodMQVHrZx9yXOL0A9U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bJClHGaZDGqjhLXp2TtVbd/9OYoR3emdMyb1RLeMCx+MFaxvQUrA3WfnFw2DDOfAIL4x6KlTmanrYT+1AESc1i2i2sR3MBLxobZsKcsaRUgYDemaRVBU9Ob2Cghxo4wuXnT8Ims9EPrwoIHmBg8PUXvuQbyL/mgt5JcmcpWS77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AfH3B5ab; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e2CvqpTq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756730075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pKmzuPbXP2DW5itZ0ySM9G2SRyPY+lVMopwVoWfmGwM=;
	b=AfH3B5ab3ArAI/rmXrpc3+6hAEFHrSyn0J8Pt/147w0VJm9dQ0GkRpoFz1Pwm6snJdtM/S
	Az5CkUgbUVAMO6SuxlDZ6UB0Ar6Oi+uwJEk4gOHanZbmqbOJdXHBP43st+hK1tkzjwQWYv
	hhM58ThLtxiBoC2QbmMkNl4uH86Buc5QnhS1esLRTM1hu58f2iEvWYRxxivcqxvnndfrge
	Twka6pBE6utfvix8CxUewNDhJiQ4OYTYe8KqSoohbtxCDH7J2+GagJEufGLjKqAJ35NdY6
	CVaYjAdxUN8xZmId5CyqX3VPuPQfxGB4qjemrpcjgNYpik76XVHgKJ2+C8ILBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756730075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pKmzuPbXP2DW5itZ0ySM9G2SRyPY+lVMopwVoWfmGwM=;
	b=e2CvqpTqZFC6ZRFmJsA+G3nxWQNYjB+/zakK1YRpeLEljYiWAWUhoQXuUXGzmM8YIxyDx6
	gNIQtKr6spBFExAw==
Subject: [PATCH v2 0/3] vdso/datastore: Allow prefaulting by mlockall()
Date: Mon, 01 Sep 2025 14:34:21 +0200
Message-Id: <20250901-vdso-mlockall-v2-0-68f5a6f03345@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM2StWgC/13MQQ6CMBCF4auQWVvTGUDAlfcwLCgUmVhb02KDI
 dzdijuX/0vet0LQnnWAc7aC15EDO5uCDhn0U2dvWvCQGkhSKStCEYfgxMO4/t4ZI4oTKpXnJEu
 FkD5Pr0dedu/app44zM6/dz7id/1JNdKfFFFIQWPRqK7qxxqbi2H7mr2zvBwHDe22bR9vMy2sr
 gAAAA==
X-Change-ID: 20250721-vdso-mlockall-461bb33205b1
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756730069; l=1013;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gsDbVDGiBLCLkCrBpBIWkJQQHodMQVHrZx9yXOL0A9U=;
 b=i3Vr9EEhisV9h/yrhXWI5WiI2aR/jp8PtKtLikTvjrX8dvW9qqzTSsADASwBoOAXAlD4Hkamf
 FVUenlzv8dDCaqMyOn2xBU/KeRGUb+8ZfEbkR8v0ZyMotlaShCsQuXy
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Latency-sensitive applications expect not to experience any pagefaults
after calling mlockall(). However mlockall() ignores VM_PFNMAP and VM_IO
mappings, both of which are used by the generic vDSO datastore.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Stop using nth_page() which is being removed
- Link to v1: https://lore.kernel.org/r/20250812-vdso-mlockall-v1-0-2f49ba7cf819@linutronix.de

---
Thomas Weißschuh (3):
      vdso/datastore: Explicitly prevent remote access to timens vvar page
      vdso/datastore: Allow prefaulting by mlockall()
      vdso/datastore: Map zero page for unavailable data

 kernel/time/namespace.c |  7 ++-----
 lib/vdso/datastore.c    | 38 ++++++++++++++++++++++----------------
 2 files changed, 24 insertions(+), 21 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250721-vdso-mlockall-461bb33205b1

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


