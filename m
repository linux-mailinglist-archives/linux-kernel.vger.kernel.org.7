Return-Path: <linux-kernel+bounces-851287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 365DEBD6084
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C24E18A448D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899B02DCF5B;
	Mon, 13 Oct 2025 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VEVeMG49"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E772264D9;
	Mon, 13 Oct 2025 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760386144; cv=none; b=jYMYe6cxH0HNzazB4oxKR75IAOlQsJntUd3uW4GvQUHmF8DXm4ojGu/90G448C0osvtMrU1dlGhDd9m+lcOgHw7+rNJq368fi4ypASjlQZMPv+28PEn9gCs54SUt1oG05TvhceA1OlGMIjGr9mkEJZTnQTTrf1hmkRUEaiH3i4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760386144; c=relaxed/simple;
	bh=XgmD1ikiWRGjsOisVLgFenvS377IO/OkgORPSqWiRfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5FvkWUMOjE1Tgc9tsAnnm8LhStkZ/hUOYkTJTOjkL4tolcSPp2WCytpk3umeZyKVIKVstNfO2hSLbpFoMxEVzLixoNr8GC5EIrOqz0nhSlMt8+mrC9Owwt5G4RAZ/jIjxhH110GL9KRjKoxiCV/EUYvgow5OBMGth3F4HbgcFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VEVeMG49; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=chv778uAQObgvsJQILIe6lBSnlTiooTbvIYxYRfhO4c=; b=VEVeMG49JtwfS/Y9Ai9bEqe7Jr
	4hVUxSVAskVKaNBbum/+2rBqaNifyFDJ/cMtxXKzwoMGH8PnJuOcWERPc2CPkhM0bnzAxLkFdJT/t
	3jRILBDGj4Cjlfie+QgxfXnyl6g3Yw+Fvvn4lLOskfx22Tep9UX0dDsLxoxgeg/H7vIa+Gz5qujb5
	aovv0x3hteFV+CGGWkr53aZUpfhrzCwTKlbWF7ukdaRGkzEePOSriJ9pWrgteiI1yJ234JDF4Y3Eo
	3OjaBAE1tSkVRlRg/P73WqN2DcHD+vs0URkYHUGuCeVab7U4M5ehYLepS/oQ2IgkHSU8AyzCQam77
	SCMKUCBg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Oqi-0000000D18e-17Ew;
	Mon, 13 Oct 2025 20:08:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8A09A300212; Mon, 13 Oct 2025 22:08:51 +0200 (CEST)
Date: Mon, 13 Oct 2025 22:08:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [tip:x86/core 1/1] vmlinux.o: warning: objtool:
 rcar_pcie_probe+0x13e: no-cfi indirect call!
Message-ID: <20251013200851.GA2969753@noisy.programming.kicks-ass.net>
References: <202510092124.O2IX0Jek-lkp@intel.com>
 <20251010032001.GA3741500@ax162>
 <20251010071032.GE4067720@noisy.programming.kicks-ass.net>
 <20251010074446.GE4068168@noisy.programming.kicks-ass.net>
 <20251010223012.GA3597090@ax162>
 <20251013082629.GH4067720@noisy.programming.kicks-ass.net>
 <20251013183059.GA690226@ax162>
 <20251013185011.GA2734756@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013185011.GA2734756@noisy.programming.kicks-ass.net>

On Mon, Oct 13, 2025 at 08:50:12PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 13, 2025 at 11:30:59AM -0700, Nathan Chancellor wrote:
> 
> > Is there any way for objtool to detect these instances and emit a
> > slightly differently worded message? Figured it was worth asking ;)
> 
> Objtool doesn't really do value tracking, but I'll see if I can hack
> something together.
> 
> That is, as long as its always:
> 
>   xor %r11, %r11
>   cs call __x86_indirect_thunk_r11
> 
> without any instructions in between, it should be relatively straight
> forward. But the moment there can be anything in between we need to
> track the value of r11 back from the call or something.

vmlinux.o: warning: objtool: rcar_pcie_probe+0x13e: (*NULL)() FTW!

---
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 0ad5cc70ecbe..2fb92d944d8c 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -236,6 +236,19 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		}
 		break;
 
+	case 0x31: /* XOR */
+		if (!opts.cfi)
+			break;
+
+		/* kCFI requires all indirect calls through r11 */
+
+		if (modrm_mod == 3 && modrm_reg == modrm_rm) {
+			/* XOR %reg, %reg */
+			if (modrm_reg == 11)
+				insn->type = INSN_ZERO_INDIRECT;
+		}
+		break;
+
 	case 0x50 ... 0x57:
 
 		/* push reg */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a5770570b106..9382d5d18885 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4029,7 +4029,13 @@ static int validate_retpoline(struct objtool_file *file)
 			struct instruction *prev =
 				prev_insn_same_sym(file, insn);
 
-			if (!prev || prev->type != INSN_BUG) {
+			if (!prev) {
+				WARN_INSN(insn, "indirect call as first instruction!");
+				warnings++;
+			} else if (prev->type == INSN_ZERO_INDIRECT) {
+				WARN_INSN(insn, "(*NULL)() FTW!");
+				warnings++;
+			} else if (prev->type != INSN_BUG) {
 				WARN_INSN(insn, "no-cfi indirect call!");
 				warnings++;
 			}
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index be33c7b43180..d9fea571a455 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -30,6 +30,7 @@ enum insn_type {
 	INSN_TRAP,
 	INSN_ENDBR,
 	INSN_LEA_RIP,
+	INSN_ZERO_INDIRECT,
 	INSN_OTHER,
 };
 

