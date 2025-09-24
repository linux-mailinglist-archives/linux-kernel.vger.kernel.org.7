Return-Path: <linux-kernel+bounces-830610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7ABB9A1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F1977B68ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB003064AE;
	Wed, 24 Sep 2025 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HPfYkXLA"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611B13054E8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721655; cv=none; b=cjdOvoXOIKkvYRZgrZcW8Bu5uJDZ+2ILGuKiKSfdpWo7mm8KYW+oM1fnWKZlBxhz0NWjvMX2JONHBkopoLHKQEGei/YRVPtISbEJCrhKRoEY7OCG8QUjLsnWCcr3ofoty1zO9WrOQMkPO64tHLnwUVRaTH5XaJl9B2nbnhZlUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721655; c=relaxed/simple;
	bh=g3mVbQEmSZSox+3rar4GDne8V7SWg8EuyYhYo65mxMU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hRjNoi76cLG88t1FfquatSTmW0vrJPU3/iPjr5/PuDvxRa/+IPmJQU0CAG756egt3dpAjgH6PmnJGcaf5sDaXTxhkjzcIKbYZkNv/d37e5AVFsoPuNSxqmsT7u6yJOjitk2KGlXy0gsPcXUBe5Lt3BiIYLPuTsSmPOzUtkiW32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HPfYkXLA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=/kke/R2RN+R2Wvie6ypomPBx+8JQhx98os7Yw9mzMeE=; b=HPfYkXLA1cT+g9jLGmkau4wDuZ
	o+0kMKoNnIFvSoPvXh+1LNG1GaGN/naVF5Xf0eA5I8Q/FMRnTLIdoBdimdKRu/MfUmf7tv3VwIiwA
	UDGzY1H/+wb1ShAoFgOBsqmxkW+EBIKBSSvHLar2zG+Wcwjo8j0H5WpbydqITnzyQ8h1Vwm4BEFsG
	PdJX530gQxHWZPlZzo2iDcqL8Ri0H0+D6jpMDiWoksSXoqEWc5DBBzYGynkzy/aS48pStQfCHWjPb
	jVemUao6/1NuSiereFDY0gkhldCSufyVKDtQ6zOrHmMCA3AVaeGY+k7wgSjwMPTGzt/CLU9paraaU
	5XjFgvjw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1PqD-00000008jyY-0I9o;
	Wed, 24 Sep 2025 13:47:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0A0D1302D64; Wed, 24 Sep 2025 15:47:28 +0200 (CEST)
Message-ID: <20250924134644.154610650@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 15:45:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alexandre.chartre@oracle.com
Subject: [PATCH 3/3] objtool/x86: Fix NOP decode
References: <20250924134507.288529132@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

For x86_64 the kernel consistently uses 2 instructions for all NOPs:

  90       - NOP
  0f 1f /0 - NOPL

Notably:

 - REP NOP is PAUSE, not a NOP instruction.

 - 0f {0c...0f} is reserved space,
   except for 0f 0d /1, which is PREFETCHW, not a NOP.

 - 0f {19,1c...1f} is reserved space,
   except for 0f 1f /0, which is NOPL.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -494,7 +494,8 @@ int arch_decode_instruction(struct objto
 		break;
 
 	case 0x90:
-		insn->type = INSN_NOP;
+		if (prefix != 0xf3) /* REP NOP := PAUSE */
+			insn->type = INSN_NOP;
 		break;
 
 	case 0x9c:
@@ -547,13 +548,14 @@ int arch_decode_instruction(struct objto
 
 		} else if (op2 == 0x0b || op2 == 0xb9) {
 
-			/* ud2 */
+			/* ud2, ud1 */
 			insn->type = INSN_BUG;
 
-		} else if (op2 == 0x0d || op2 == 0x1f) {
+		} else if (op2 == 0x1f) {
 
-			/* nopl/nopw */
-			insn->type = INSN_NOP;
+			/* 0f 1f /0 := NOPL */
+			if (modrm_reg == 0)
+				insn->type = INSN_NOP;
 
 		} else if (op2 == 0x1e) {
 



