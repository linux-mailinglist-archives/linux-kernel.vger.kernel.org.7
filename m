Return-Path: <linux-kernel+bounces-818944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1003AB5986A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326667B6C10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9469E3191B0;
	Tue, 16 Sep 2025 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vLzesQEt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IvnXF+cQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625833081C2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031164; cv=none; b=TXU7tmX+1gUSbF1EDXRP9Rhz7zzwwgAcGQgYTwfIS+jA75JjLBfRbOSMRPuB99OL9EX+qD4AJ5/r26L0xVGEPyzDE1NnNRZyvSjrsLStMDZgPS4PtvQ+HPc8owjtXali1/E0ycsAd05YZTFXnqr33Y9mgZws6uQOfE/Rzcl7kqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031164; c=relaxed/simple;
	bh=ZNw6/Pkl7XVlQGnaKL39G6YlmhiimA7IoIxBZICvlEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eZFHr4JZILk4h09GWJfUuQuBjwyVc9BO5jUv3ZebuO6CUxFpBK22YLbGXFdKkF5+t03OJ5SPqHSVjW0nasYK0iwC6dFgVWqhox+LoPjCkI+pAO1RyFI9IW2lk49wUH1XltsfENC83bUmC2PAnoenQttdIxxzWa/MzAxlc7XDeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vLzesQEt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IvnXF+cQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758031160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eEokiboM8tmZkAlMvBN1bGzcqO+asQMBDxG4dhVmeBk=;
	b=vLzesQEt79T9vEZS87nGJ3oFPBeJCNAwazyD667XiAI5WjR+RUthQ62DZrdqo9F5Z9bfyy
	FirvLO7u0l0zhVJM7WM43Isrg/X2my+VsK7/rHQrfzQBqW+nRMM0YsdkgSviK3jMlJM0yy
	KvCUjWsxCTQIymli3/xxvksfN7ecZOMGfvo47kycpMkwbU9pOeWhHk4Z/0EBccFWMSQ1TO
	wijnI2Sh/Up55tPS/3d4NspG7ZMlMxm5X5YGdi9penOHevjsoWyg4vEBtzBkCwOrzNgU3m
	Ekt/vfw/gyZfcEL+B80tBc7HiqJeXXQ4gh2O+qjTAUmXY3lNG8/k/APY3HEqIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758031160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eEokiboM8tmZkAlMvBN1bGzcqO+asQMBDxG4dhVmeBk=;
	b=IvnXF+cQPlSxoKRVcUugTsHSI4/Vc/Y8F9duk+4CtplOWJFnS/t5Gyv9LT/FrCqazDviWB
	uQ8o/S7i8gq6igBg==
Date: Tue, 16 Sep 2025 15:59:08 +0200
Subject: [PATCH] mm: forward declare struct rcuwait together with
 rcuwait_wake_up()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250916-mm-rcuwait-v1-1-39a3beea6ec3@linutronix.de>
X-B4-Tracking: v=1; b=H4sIACttyWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Mz3dxc3aLk0vLEzBJdA+Nk07RUS9M0Y7MUJaCGgqLUtMwKsGHRsbW
 1AH9cvMNcAAAA
X-Change-ID: 20250916-mm-rcuwait-03c5fe95f36d
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758031154; l=1328;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ZNw6/Pkl7XVlQGnaKL39G6YlmhiimA7IoIxBZICvlEw=;
 b=n9IUalFfEZypJVfZ5xG9sKuoLwQY6WLapbIL5Tsm0Ihq9HdJyfjSxomCoNNvVRfzoRMRKlwwU
 w2RMLjLCyeTCivvRtUHgdpP5S2lf2S+ufnTX1SHxylc6FYfu3OKX7LE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

At the point of the forward declaration of rcuwait_wake_up()
in mmap_lock.h 'struct rcuwait' may have not yet been declared,
leading to compiler errors.

Add an explicit forward declaration for the struct.

Fixes: 75404e07663b ("mm: move mmap/vma locking logic into specific files")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
This doesn't seem to break any in-tree code right now.
I stumbled upon it while building a series for the next cycle.
Instead of putting this fix into my series and spamming all the mm
maintainers with it, maybe this could be part of the last mm bugfix pull
for this cycle.
---
 include/linux/mmap_lock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 11a078de9150df1beff4f0bfb16e199333767614..9792dd4fff0ff73829833aae8ea3229a31757d61 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -3,6 +3,7 @@
 #define _LINUX_MMAP_LOCK_H
 
 /* Avoid a dependency loop by declaring here. */
+struct rcuwait;
 extern int rcuwait_wake_up(struct rcuwait *w);
 
 #include <linux/lockdep.h>

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250916-mm-rcuwait-03c5fe95f36d

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


