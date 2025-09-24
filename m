Return-Path: <linux-kernel+bounces-830608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D4B9A1AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F114C3A7F77
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA78A304971;
	Wed, 24 Sep 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PTvjL6Th"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EACA6F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721653; cv=none; b=d5pv2k0+XrQ3SIvOhvOhrie15gtYIgVkxHdAmiwDIWdZicSTgUrv9Y8RiMqttVUkR8fvJSJCCY1H3aemd1tC/saaCT018uCQUcTpJ/jvzmzW0CRdSMv8kPGa6+mTMFGeMsSl3z346LV/QMUQFPA7ys23/9q6kSr4YojKWu3RzuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721653; c=relaxed/simple;
	bh=OBfMOW22D98davzTH45xo1zVpW2eTbrHV63JoKZq7lE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=P+1luJvug7ufGC0JQRRR5K5L4UCVdMpQZh4PZ+pc3D9lZe3ffgj0FzjxkVQfsw4Uek8OpFyca8bEUpG4otfXHfco9eJDLEDgKIfJsciJMpHRzakAK5bbFTpqWzqaW/kJ+xYoQolgsx5aWyeEZe4+2e67LLyUMADRxerpgOXntr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PTvjL6Th; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=M6Mu1EgZSYpGGeuwl+54OvBXl6dGSzkTbe6klqtPCT4=; b=PTvjL6Th1k+WraWEz4sdwoJB+j
	O0Z/2kkzGbYui49Blsmhhbh3WumT9lLyaPx0b3SIezybrdm8JL+wdiJySKr53kRHpwBNxIVFmjHjG
	evaMPRwJb3/AzflfB46ic1Nf6brvcy/1f/UzhxYQLiWA2d9v2GbfsyXwJpDR766cKZTVX3xPdnN49
	p61JXRE2UUrdFhFjcASfkZpMpjjc+zZXwrx8kbDUdohtAfPI/xCv8mS3/TvglRhq5P5rzriE5o24H
	IIiQlyfTplNLM10rgOnFQXzESULdaJy/gE2Jp7l2eqczCv76LKfBc76GSopTo7b+OyK/9PEylAjcX
	Eze68QtA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1PqD-0000000GLzD-0S6M;
	Wed, 24 Sep 2025 13:47:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 01B8530043D; Wed, 24 Sep 2025 15:47:28 +0200 (CEST)
Message-ID: <20250924134643.907226869@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 15:45:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alexandre.chartre@oracle.com
Subject: [PATCH 1/3] objtool/x86: Remove 0xea hack
References: <20250924134507.288529132@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Was properly fixed in the decoder with commit 4b626015e1bf ("x86/insn:
Stop decoding i64 instructions in x86-64 mode at opcode")

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |    9 ---------
 1 file changed, 9 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -189,15 +189,6 @@ int arch_decode_instruction(struct objto
 	op2 = ins.opcode.bytes[1];
 	op3 = ins.opcode.bytes[2];
 
-	/*
-	 * XXX hack, decoder is buggered and thinks 0xea is 7 bytes long.
-	 */
-	if (op1 == 0xea) {
-		insn->len = 1;
-		insn->type = INSN_BUG;
-		return 0;
-	}
-
 	if (ins.rex_prefix.nbytes) {
 		rex = ins.rex_prefix.bytes[0];
 		rex_w = X86_REX_W(rex) >> 3;



