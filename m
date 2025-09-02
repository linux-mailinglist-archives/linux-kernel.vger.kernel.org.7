Return-Path: <linux-kernel+bounces-795809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F323B3F82A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8984F7A327B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8632E27BF7C;
	Tue,  2 Sep 2025 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l4xiHP0b"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4FA219E8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801163; cv=none; b=bHXcfbVBi5qON6PFJLGQlvS0yMCSCSa6IXaDUvMdlLfE//cyDmcie/7ts2x8MWDUttUO4cRVeqOTcUTBbqk2x81yqJBn3JM5T84/E5mkckLKqgw3ghig/oP62vNl8M6Sf5/3SDCq8OkCeds/6IG0k4r8I1O4trVqevgs53uxMxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801163; c=relaxed/simple;
	bh=YjMsLc6RufmJViCjzbcj1o+DZxgRHG8U3dF4AJZolgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvSYqpdzW9/KkethNXi5QBS6xoO7plxPcyOvzYCKkBdgtda0d6HqvFYUOuyQiKXA8Um2+Jlv1DlEcFQoRbRJ2D+4UbDiQeeUtSJovOKAfxk34AeEIYseAveUkzqMfU6NY1MmjKZB+dQR/PXE6ZfbZxZEl6H2Y994ts1TXGDCyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l4xiHP0b; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5GOSNNpMehkJcGSwkYc7NNq14fJf5Y8+4HDmpTH/Ghw=; b=l4xiHP0bOQ4ANVIRzozbdr0Jkz
	be64vVfQ+zYZ9ZDrzJqnndGv9XnU9UJ8P61BVxSCdoK9CKPmWosD+IivNhHE+/JmKPnHXmLMKJYUt
	MdM2jKO52rL43GB1raGewm+73IyD4CU+LqCSbCqrUzu1EEpHyL6xuLH1TYUP/E70wBKBMy/FnQt6A
	3X8vcd4AtKfie6j9L4MYfUpr6S2DMlgQBUeuZcOhbn5AjU7ndTXOA1WTwWJYi8DcwdMgjMFBJVLGb
	Ae/XuddHYKlTh2sQizJLc8ZneVdEn5DxzG47wSTDPyWxuEHPgZRutC3A1OqING43dAVV7/c9nCMOm
	WYqBhaKw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utMEW-00000003yAO-1Mnt;
	Tue, 02 Sep 2025 08:19:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6215130039F; Tue, 02 Sep 2025 10:19:15 +0200 (CEST)
Date: Tue, 2 Sep 2025 10:19:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: kees@kernel.org, alyssa.milburn@intel.com, scott.d.constable@intel.com,
	joao@overdrivepizza.com, andrew.cooper3@citrix.com,
	samitolvanen@google.com, nathan@kernel.org,
	alexei.starovoitov@gmail.com, mhiramat@kernel.org, ojeda@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86,ibt: Use UDB instead of 0xEA
Message-ID: <20250902081915.GK3245006@noisy.programming.kicks-ass.net>
References: <20250901191307.GI4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901191307.GI4067720@noisy.programming.kicks-ass.net>


Because this is all somewhat magical code, and this change is a little
on the large side, it as been suggested I 'upgrade' the Changelog some.

On Mon, Sep 01, 2025 at 09:13:07PM +0200, Peter Zijlstra wrote:
> 
> A while ago [0] FineIBT started using the 0xEA instruction to raise #UD.
> All existing parts will generate #UD in 64bit mode on that instruction.
> 
> However; Intel/AMD have not blessed using this instruction, it is on
> their 'reserved' opcode list for future use.
> 
> Peter Anvin worked the committees and got use of 0xD6 blessed, it
> shall be called UDB (per the next SDM or so), and it being a single
> byte instruction is easy to slip into a single byte immediate -- as
> is done by this very patch.
> 
> Reworking the FineIBT code to use UDB wasn't entirely trivial. Notably
> the FineIBT-BHI1 case ran out of bytes. In order to condense the
> encoding some it was required to move the hash register from R10D to
> EAX (thanks hpa!).
> 
> Per the x86_64 ABI, RAX is used to pass the number of vector registers
> for vararg function calls -- something that should not happen in the
> kernel. More so, the kernel is built with -mskip-rax-setup, which
> should leave RAX completely unused, allowing its re-use.

 [ For BPF; while the bpf2bpf tail-call uses RAX in its calling
   convention, that does not use CFI and is unaffected. Only the
   'regular' C->BPF transition is covered by CFI. ]

The ENDBR poison value is changed from 'OSP NOP3' to 'NOPL -42(%RAX)',
this is basically NOP4 but with UDB as its immediate. As such it is
still a non-standard NOP value unique to prior ENDBR sites, but now
also provides UDB.

Per Agner Fog's optimization guide, Jcc is assumed not-taken. That is,
the expected path should be the fallthrough case for improved
throughput.

Since the preamble now relies on the ENDBR poison to provide UDB, the
code is changed to write the poison right along with the initial
preamble -- this is possible because the ITS mitigation already
disabled IBT over rewriting the CFI scheme.

The scheme in detail:

Preamble:

  FineIBT                       FineIBT-BHI1                    FineIBT-BHI

  __cfi_\func:                  __cfi_\func:                    __cfi_\func:
    endbr                         endbr                           endbr
    subl       $0x12345678, %eax  subl      $0x12345678, %eax     subl       $0x12345678, %eax
    jcc.d32,np \func+3            cmovne    %rax, %rdi            cs cs call __bhi_args_N
                                  jcc.d8,np \func+3
  \func:                        \func:                          \func:
    nopl       -42(%rax)          nopl      -42(%rax)             nopl       -42(%rax)

Notably there are 7 bytes available after the SUBL; this enables the
BHI-1 case to fit without the nasty overlapping case it had
previously. The !BHI case uses Jcc.d32 to consume all 7 bytes without
the need for an additional NOP, while the BHI case uses CS padding to
align the CALL with the end of the preamble such that it returns to
\func+0.

Caller:

  FineIBT                               Paranoid-FineIBT

  fineibt_caller:                       fineibt_caller:
    mov     $0x12345678, %eax             mov    $0x12345678, %eax
    lea     -10(%r11), %r11               cmp    -0x11(%r11), %eax
    nop5                                  cs lea -0x10(%r11), %r11
  retpoline:                            retpoline:
    cs call __x86_indirect_thunk_r11      jne    fineibt_caller+0xd
                                          call   *%r11
                                          nop

Notably this is before apply_retpolines() which will fix up the
retpoline call -- since all parts with IBT also have eIBRS (lets
ignore ITS). Typically the retpoline site is rewritten (when still
intact) into:

    call *r11
    nop3

> [0] 06926c6cdb95 ("x86/ibt: Optimize the FineIBT instruction sequence")
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

And now I'm going to have to do a patch that makes apply_retpoline()
do CS padding instead of NOP padding for CALL... 


