Return-Path: <linux-kernel+bounces-824650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD62B89C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BDA568270
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476DF2561C2;
	Fri, 19 Sep 2025 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="FkfZ9BD6"
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D1B1F3D56
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290564; cv=none; b=h5/M6rBovYUAweFDN4Hxw2E4kndsbp2DW0zrCaFobzNk0RK1ASjFJrZyfSoFDaN6mi9sEfisK6SF5z5u3b/NDVv/Wj11l37BQRWWO5sBtw/LQl0J+HtQh/C1ApCnMJayTBWG5RzUHij1u2QKwhMBFC0gzV/D2C8Xm7C1OlePRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290564; c=relaxed/simple;
	bh=OrJsWhLsTTyW2lra5WwbIAhrk7/5g0JKyP9ZZKoFX0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qG6uSVxO3ItXIxY3NQ6PH9q7evbmW8TntC1ZGq8gTda6cbj0LWCjH5qZsDR8Vq1XCW5JZIQSe/X/FcWCrecikrDLIsJihUx+YjHbzQspMwKgc9yUY4tYjMqieTxhVAdCF9sYAaqKx345oBQZzaEKktrg6LHZArpGpPx3xLC/sfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=FkfZ9BD6; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id D8B3F82468
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:56:12 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:4419:0:640:5be6:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 5B0E2C0085;
	Fri, 19 Sep 2025 16:56:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1uTTw6eM48c0-aUvTvDhQ;
	Fri, 19 Sep 2025 16:56:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1758290163; bh=fqlmACInvcZ6zw+CwXBmhZen3vj8qTOuebjt3QcIS1c=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=FkfZ9BD66+lAh76B41lltffvFvE45i5357T0rpNdS09tltBlVFjRuFI55nxNhn4+y
	 dTHmMICvBjzgGZ3d1n0323WBaEKtef0+yKtna9m5cYyZiUsorseMJBY3hMitxnkpSq
	 zNCd8GSJwyu0iL3MKKBAiJEsmoA8do9cu/d9OtsM=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH RESEND] objtool: speedup subsequent calls to dead_end_function()
Date: Fri, 19 Sep 2025 16:55:57 +0300
Message-ID: <20250919135557.280852-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running over KASAN-enabled vmlinux.o, some functions comes from the
sanitizer runtime may be processed by 'dead_end_function()' a lot of
times, so it's reasonable to record the result in 'struct symbol' of
the relevant function. Briefly testing over huge 'make allyesconfig'
vmlinux.o, this may speedup objtool by nearly 10%.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 tools/objtool/check.c               | 5 ++++-
 tools/objtool/include/objtool/elf.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d14f20ef1db1..d4c0ef419b95 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -322,7 +322,10 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 
 static bool dead_end_function(struct objtool_file *file, struct symbol *func)
 {
-	return __dead_end_function(file, func, 0);
+	if (func->functype == UNKNOWN)
+		func->functype = (__dead_end_function(file, func, 0)
+				  ? NORETURN : REGULAR);
+	return func->functype == NORETURN;
 }
 
 static void init_cfi_state(struct cfi_state *cfi)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 0a2fa3ac0079..2c491eb07741 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -70,6 +70,7 @@ struct symbol {
 	u8 local_label       : 1;
 	u8 frame_pointer     : 1;
 	u8 ignore	     : 1;
+	enum { UNKNOWN, REGULAR, NORETURN } functype : 2;
 	struct list_head pv_target;
 	struct reloc *relocs;
 	struct section *group_sec;
-- 
2.51.0


