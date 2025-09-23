Return-Path: <linux-kernel+bounces-828021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8F3B93BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0829C2A79CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE8E169AD2;
	Tue, 23 Sep 2025 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kULXYs47"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00EE224F6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588592; cv=none; b=oHaXVpbn8VqobkSYl/HLyJOz+cbM0YeSFkRqxb2qxwKSumI2hL8ppM3AD+X/UBswTeUb93ZrHNqPCszYx0wgF4rTrXgKCfMugxq4j8mHRyTlIXPE+3B8iSh7BdQN9pI+hQFtJ7wVX4TXLNPexcMnk4W/o5EAOGWtnAJ+LS5zjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588592; c=relaxed/simple;
	bh=bIhRHUnmctIDv3HPTEHyBJu6gUurniJczAwCvnLe5pc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oJZRcldP4DNvLLkEVd3Jn6tC5Wz3RxPocyrWpzbVWsAb4nMCeYQkrfhL1ER92nn+HqUHHdtHuuXnHfnj9w1jjof3cTI5cZXcW2QDrvGXWv2Si2F8a9p1w3ORx2ATfa5sB2jEVi3s/rvytYISNghdPvWuZ0TzeJYunX23TBh+Yyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kULXYs47; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f3998c607so2355196b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758588590; x=1759193390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JYNZYEdbeSfJXU456u0Z1WWugnswfgBTK+xPZiksE+k=;
        b=kULXYs47r4Nwz5JKGrdutnzu2WI3Y1eHoJno0IMJfBUa80LVakzeP0i71VjO0NuSDr
         grvX8dUsWtlFAfVTjQdRfqqqey+KsEP3l6UDUFFwMCe8PK5uUQXoJhtrRsKvqA84PX05
         Va4xjwwQ7CDqq/iJ5eAluLD1s6SG5HCY0VBqWoltVB9iPMP/Hy0i6DgWrAGE1a/XHiCZ
         z4oULFXu2T0QAhzFOa/nFL7AjSOGbuTUnXdX4NQ7mfZuzMOfaSgsRqyLnns3AWrQlNfF
         8UGxIZDLl6O1FMM6cqu1juF7y+246qmWfouncR6vEr6PTjqtfjc44KlasvPsehkXepgn
         BoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758588590; x=1759193390;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JYNZYEdbeSfJXU456u0Z1WWugnswfgBTK+xPZiksE+k=;
        b=Jr8ZXDY5Obv4aB9Fu7Sjdt+Spdk7TCT6QdQGriO89eXT2L8EnmoBT/Z9qe6sutWgo0
         KWH7fUgJki7bs+j+xMQN6xdvR3et3FN8usXRhRgiDXd6trH3sXftGWhVCH2ZcmS7ejrD
         EJ81gJO/+AoKsbFM1+89iiwKSREH/J0rui4IlOu2wT7Swjc8c75IZnHU9dPziA8yM/fL
         CaLeZxH26qRnp2x5B+hObyUdyf4A6AdVplZSyfENYOwHAFNMc1vcGaVL75nGAA0+EQqE
         G+jY57rAVJ0w+ve5BpGbWIj/NRWbP+MWxUishofT+S32LN8iFe7QPh/Snr9ZI20v3RIu
         vJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCUzVnvnqO0Zdd17Ob7FiEJRkXSrhm7X3d8GuOXKH3Hy20aVJnwHMZA5nm98e/AWc389q7Bm52a+mGsfGZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6ESoZg3eyGkdqXnjFCInj9y9L+9QurnXci2FoOTMlR1LFAF+
	tBFOGo4Rqa06HgwsglRuPYROp44MNhg8oqZhyrwqDZaa9oQw7+nx4YlKwQ7+r5GheY3JiF0Nz7m
	16TOx2jrOZ8Qr2H4J7PQf9fPnUg==
X-Google-Smtp-Source: AGHT+IH/oklu/yHttqdW4ywEE86izIRddKV2q7XNUDla51GEy3oxk+cfYtfaw7j/OMrLj+vru51p70e1oZ1pYVEKhQ==
X-Received: from pfbeq16.prod.google.com ([2002:a05:6a00:37d0:b0:776:2171:b436])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:cc5:b0:77f:5358:b43d with SMTP id d2e1a72fcca58-77f53847a3fmr1091764b3a.6.1758588590050;
 Mon, 22 Sep 2025 17:49:50 -0700 (PDT)
Date: Tue, 23 Sep 2025 00:49:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923004941.982086-1-dylanbhatch@google.com>
Subject: [PATCH] objtool: Let --hacks=jump_label read special sections with alts.
From: Dylan Hatch <dylanbhatch@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Dylan Hatch <dylanbhatch@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Weinan Liu <wnliu@google.com>, Naveen N Rao <naveen@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Sathvika Vasireddy <sv@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The objtool command line 'objtool --hacks=jump_label foo.o' on its own
should be expected to rewrite jump labels to NOPs. This means the
add_special_section_alts() code path needs to run when only this option
is provided.

This is mainly relevant in certain debugging situations, but could
potentially also fix kernel builds in which objtool is run with
--hacks=jump_label but without --orc, --stackval, --uaccess, or
--hacks=noinstr.

Fixes: de6fbcedf5ab ("objtool: Read special sections with alts only when specific options are selected")
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d14f20ef1db1..1b4b4bd7dc90 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2562,7 +2562,7 @@ static int decode_sections(struct objtool_file *file)
 	 * Must be before add_jump_destinations(), which depends on 'func'
 	 * being set for alternatives, to enable proper sibling call detection.
 	 */
-	if (opts.stackval || opts.orc || opts.uaccess || opts.noinstr) {
+	if (opts.stackval || opts.orc || opts.uaccess || opts.noinstr || opts.hack_jump_label) {
 		ret = add_special_section_alts(file);
 		if (ret)
 			return ret;
-- 
2.51.0.534.gc79095c0ca-goog


