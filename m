Return-Path: <linux-kernel+bounces-874931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B7AC1787F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AFF407646
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78EA2528FD;
	Wed, 29 Oct 2025 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVbsE3Zo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26E224E00F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697267; cv=none; b=Pf/eSk885OjfL9L4g7YJSOm6FSakeQGce4FUWWRwiQhyPbfGx/K96yRGTBGAKJAJseTn5BENFsEqdc2GCSvQX2Vx+ibMzWhl75w++uNlAH6Fw2msYLMU0J9Gr0U+zH7XA1f35Dtz0yV9wOm3auAA0lWKSP2t4KzVlRUCJsvGZek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697267; c=relaxed/simple;
	bh=TAABpdWBjBz0YmvO4QU6LC7sa80TpzxauvQWxrSQoQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brMuSfA+RmCZND1VgnXaMAcF2JlsjZXdoN+wCYOhPN/hT6HZAXZG/RV5y0I0BouZk7dhPU2mp9dY9Fl9UF/MRPnA3P1C4451sI2FYIqd/tB1Z1MIq34Vid2CHyFStZ/HqFfL3loM8gHPnzC+7yTkBnrnNq438krHnbu5G2lL8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVbsE3Zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0B1C4CEE7;
	Wed, 29 Oct 2025 00:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761697266;
	bh=TAABpdWBjBz0YmvO4QU6LC7sa80TpzxauvQWxrSQoQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVbsE3ZoOMRsREPsE+3aELa0tmPyQc6OhLKecmKaa09i2yuCIcaEkvc37CmUj9P3X
	 JGziDruui3caaUyM21A3zp1D90I4rHIWVCAaJe2l7BKyHcm6KpFdIjW/VXi1Xp3yCl
	 u7yo57DfcLKKZzSUsqGenEOYfLMtLWHFO12Cpgd04H0kRIXGKQxNY8TXwwscDj5038
	 DhEQpM1SVrmwW3XEuWoJ4B2ZTa8evEp9EPY3iG0PHA9MzZRRx8/x7a256nU1AoGdjB
	 QowviA67bRTswaxT+Btdz0YuxS+Kh+be6D+qliLOoe3ACQP9noVuxdGpg1pL647KwZ
	 dXarS1zVrwcpA==
Date: Tue, 28 Oct 2025 17:21:04 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: odd objtool 'unreachable instruction' warning
Message-ID: <ubqjeplvslhnspqw6pnqwo7c6sq2ygdtmkuqr4q3hjlxfkuwii@xn63k6qz22mz>
References: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>

On Tue, Oct 28, 2025 at 12:29:11PM -0700, Linus Torvalds wrote:
> Josh, Peter,
>  due to another entirely unrelated discussion, I ended up resurrecting
> my "make asm readable" patch that I have had in my local tree when I
> want to look at the actual generated code for user accesses.
> 
> That is a local hack that just removes the alternative noise for the
> common ops, so that I actually see the fences and clac/stac
> instructions as such, instead of seeing them as nops in the object
> file or as horrible noise in the assembler output.
> 
> So that patch is not something I'd ever commit in general, but it's
> really useful for checking code generation - but it results in odd
> objdump warnings these days (I say "these days", because I've used
> that patch locally over the years, and the objdump warning hasn't
> always been there).
> 
> It's a pretty odd warning, because the code looks fine to me, but I
> might be missing something obvious.
> 
> Anyway, this is clearly not a big and urgent problem, but I'd love for
> you to take a look. I'm attaching the patch I use so  you can see what
> I mean.. Any ideas what triggers that warning? Because I'd love to
> keep this patch in my local tree without having objtool be upset with
> me....

Ironically I think this "bug" was introduced by a patch whose goal was
to fix a regression in STAC/CLAC code readability:

  2d12c6fb7875 ("objtool: Remove ANNOTATE_IGNORE_ALTERNATIVE from CLAC/STAC")

See the diff below, hopefully that fixes things for you?  I can post a
proper patch in a bit.

On a related note, it would be nice if we could make that codegen more
readable...  Here were a few formats I had played with before, any
thoughts?

Option 1:

# <ALTERNATIVE>
# ORIGINAL:
771:	nop
772:	.skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)), 0x90; 773: .pushsection .altinstructions, "a"; .long 771b - .; .long 774f - .; .4byte ( 9*32+20); .byte 773b-771b; .byte 775f-774f; .popsection; .pushsection .altinstr_replacement, "ax"
# REPLACEMENT: [X86_FEATURE_SMAP]
774:	stac
775:	.popsection
# </ALTERNATIVE>

Option 2:

# <ALTERNATIVE>
# ORIGINAL:    nop
# REPLACEMENT: stac [X86_FEATURE_SMAP]
771:	nop
772:	.skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)), 0x90; 773: .pushsection .altinstructions, "a"; .long 771b - .; .long 774f - .; .4byte ( 9*32+20); .byte 773b-771b; .byte 775f-774f; .popsection; .pushsection .altinstr_replacement, "ax"
774:	stac
775:	.popsection
# </ALTERNATIVE>

Note there's also an objtool "disas" feature Alexandre is working on
which will show the disassembly annotated with runtime patching info
(alternatives, static branches, etc):

  https://lore.kernel.org/20250619145659.1377970-1-alexandre.chartre@oracle.com


diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 620854fdaaf63..9004fbc067693 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3516,8 +3516,11 @@ static bool skip_alt_group(struct instruction *insn)
 {
 	struct instruction *alt_insn = insn->alts ? insn->alts->insn : NULL;
 
+	if (!insn->alt_group)
+		return false;
+
 	/* ANNOTATE_IGNORE_ALTERNATIVE */
-	if (insn->alt_group && insn->alt_group->ignore)
+	if (insn->alt_group->ignore)
 		return true;
 
 	/*

