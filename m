Return-Path: <linux-kernel+bounces-872156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F790C0F647
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CB31892AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9543A31354E;
	Mon, 27 Oct 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g8iGTxdW"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF570308F26
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583166; cv=none; b=Quo+xWUnaLjV8IXlR7lwuxI5zDAyM2Vysgrb5AQwgtYZP51wm45XauQw+Vm+Mpj5EY2p/EX9KONYIw3IZNnV2D/Y3VK3I0NzloWusJZNjnBQMSQcBhlQHj4HU0+GVUEnc9XsujNqrarWHU8dua2AV32LUohT+MBZ3mVQEvvV+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583166; c=relaxed/simple;
	bh=Be5QKlB3ucCGPljf5TzeXWg3vuhXfK/eO1AzyQTYrdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXSt4Re1tBQMYQ3aVvuRSN0nUlMu2BgpSQRQUvra0Miz25Dp3JNojIMzeLXtd68Zyrk1cGVWNwZlHYBGUPOM6Vsx64KT4LoiNuxefe1Fq1bAKN3d/MezKbI5Is7fIlpvJMyDdOPOuQ6FJCjrUHU4zE6FBnEJ8NLKX8xeR8l0Iek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g8iGTxdW; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761583161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lrmaKxUS2WXVIok7XCApX8mmODfYJ7Tl/+25KX1yE2Q=;
	b=g8iGTxdWMNCrRYVcKrgTUS/g47VjqbtzuLt53eNJq62k9tQM3hDda+vDA+b3zb98LhS0OJ
	kSi0DBZuIOe9tEKkIGgWcBG3z4AnLvkXB7DWixrX/bwiyAFDf0fehZKjrSi1b73/j3yQXv
	GPFfiFEnJ7bjsddnw9p5cJKeSS4eNO8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miroslav Benes <mbenes@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: Re-add resume_play_dead() to noreturn list
Date: Mon, 27 Oct 2025 17:39:07 +0100
Message-ID: <20251027163907.184681-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

resume_play_dead() was added to the noreturn list in commit 52668badd34b
("x86/cpu: Mark {hlt,resume}_play_dead() __noreturn"), but was dropped
in commit 6245ce4ab670 ("objtool: Move noreturn function list to
separate file") when the list was moved to noreturns.h.

Fix this by adding resume_play_dead() to the list again.

Fixes: 6245ce4ab670 ("objtool: Move noreturn function list to separate file")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 tools/objtool/noreturns.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 14f8ab653449..e63d85968f83 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -42,6 +42,7 @@ NORETURN(panic)
 NORETURN(vpanic)
 NORETURN(panic_smp_self_stop)
 NORETURN(rest_init)
+NORETURN(resume_play_dead)
 NORETURN(rewind_stack_and_make_dead)
 NORETURN(rust_begin_unwind)
 NORETURN(rust_helper_BUG)
-- 
2.51.0


