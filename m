Return-Path: <linux-kernel+bounces-829723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C9AB97B68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11C84C3EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5CD30B534;
	Tue, 23 Sep 2025 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1RtNLee"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3272628
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666793; cv=none; b=MFLdaBElObSZn6kAVg7Ps6fwTLMtKjmWzIkOS5qKlVkVrZ/cecdhTPWwIDqxHNPLRc8ywDxPCttcuqY4uH95ipfR8J5yYiCtIgTW3ZD43r9mN8O8yRBTK8axTqzPsyIyIjaHLyKCavmoaYtstBrF+VAFQVenyZynW2HKzGfN/3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666793; c=relaxed/simple;
	bh=NwH6GE3m2onkBeCcCK5WtHquHOe0iUr7q4uBqzbYf8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFMwG8biil4p5XzeC8QvQvilYTPytDOWE3vNqP3Hg7VQx+biIXbei7VkikN8ICkJb48Fa1dNJ8XG1hcfThVJSf7YBom0wi/z776TAUELN5lmb9SXBaFgO2lWsrGAts5yVFlqka7cJlikBRhR/gTSFRhyEQF66FD5jdTFyiICTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1RtNLee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15308C4CEF5;
	Tue, 23 Sep 2025 22:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758666792;
	bh=NwH6GE3m2onkBeCcCK5WtHquHOe0iUr7q4uBqzbYf8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1RtNLeeAux1mIv8S+K4EfZoBroH1Pl4CAIchZRQJQZgAeeObhlnOfnOxUqdtJAxf
	 nBM0TOmplx0k66rMH9hkrUkuEvRU/eMxm1lgOvUoJui8rs09QgiLWfucSxMUICdIEU
	 Sy8qW3dH75iDrlLXFSJ6JBOQf7VdiK2D3ISKVK9UiC23TpxLFSIC9xs+iEPoEzbyRb
	 2Z03vO9XrFbnO/Lu9fn7JhDATtkijtNeNc4GJzDXmK66V90WqeCSbB6j0r1AcZLGme
	 UNXh/v4AYAe+PwaQjjmfWKBEVAf39u8zLS5cLNGV/6PmTZEZVXcUG7k9AAy4vemgCh
	 lAZ2AAB/89o1A==
Date: Tue, 23 Sep 2025 15:33:10 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
Message-ID: <jxvtccnmr35xtevd7kjd5tn4n4bpwvfo2baajidwv5yfsvqcvb@mj7t4zfpllm7>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250619145659.1377970-1-alexandre.chartre@oracle.com>

On Thu, Jun 19, 2025 at 04:56:42PM +0200, Alexandre Chartre wrote:
> Hi,
> 
> Version v2 of this RFC addresses all comments from Josh and Peter,
> in particular:
> 
> - add --disas option to disassemble functions
> - do not fail the build if libopcodes is not available. Instead objtool
>   is then built without disassembly support. In that case, objtool prints
>   a warning message if trying to use disassembly.
> 
>   Example:
>   $ ./tools/objtool/objtool --disas --link vmlinux.o
>   vmlinux.o: warning: objtool: Rebuild with libopcodes for disassembly support
>   
> - remove dbuffer
> - rename VTRACE* to TRACE*
> - add trace.[ch] for trace-related functions and macros

Sorry for the delay... this is looking really good.  A few nits I saw
when testing:

1) With "make -s" I see

  Auto-detecting system features:
  ...                                  libbfd: [ on  ]
  ...                disassembler-init-styled: [ on  ]

but I'm thinking that should be completely silent?

2) Also seeing an oddity with --trace:

  $ OBJTOOL_ARGS='--trace=shrink_node' make -s -j12 mm/vmscan.o
  shrink_node: validation begin
   12440:  shrink_node                                                 push   %rbp                                                -  - statecfa=rsp+16 rbp=(cfa-16) stack_size=16
   12440:  shrink_node                                                 push   %rbp
   12441:  shrink_node+0x1                                             mov    %rsp,%rbp                                           -  - statecfa=rbp+16
   12441:  shrink_node+0x1                                             mov    %rsp,%rbp

For the instructions which have unwinding state changes, it's printing
them twice.  Also the formatting looks a little off (two dashes;
"statecfa").

-- 
Josh

