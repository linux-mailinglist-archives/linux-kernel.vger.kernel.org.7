Return-Path: <linux-kernel+bounces-790589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0949FB3AA87
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164FDA0300D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35B7BA4A;
	Thu, 28 Aug 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4/Gt+0P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C070335BB8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407849; cv=none; b=I+Tw+zqncAsLlG/lwfSpoh28B1EpOGFah+yodbNm7ID2K755o6tjygmz+qt2ag+fLisB51P1g1kHqO/WBB2RJyTz+idEXIarujhfcN22FJZ0pT0idykJngURL+XnD2PfGy0X8PlW3OVthv3EKoQ0iH9m+fjJghi5yd7HkGfMT54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407849; c=relaxed/simple;
	bh=CJI3mkJzz6E4DWL1uxTfTQQMYsZsK1Mjk54eYEk6fPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTEVXZBCVruKBYORHMcRPDucL9jlKjxuvj4CkWj4VAG8RVYigj0sap0CdMy1zDn6PGUUycqefV5icVDPaMu4L5dOMLtkOQC1qaJu08I587Mt3Q3wQ8GI8iT7fey+m9qc4yWTpOK1u7D5IKt42o4HgjfM5JVqjK7MJKk4v9Nwm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4/Gt+0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973F7C4CEED;
	Thu, 28 Aug 2025 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756407848;
	bh=CJI3mkJzz6E4DWL1uxTfTQQMYsZsK1Mjk54eYEk6fPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4/Gt+0P29J0zsX3BUD1F9SaWCuEumhta3tnPlkNbPthWs6zoQnDwPao2z1w23dzt
	 YZ4zNgcrQRzw4ukeLxAwUW87WDSltjJIqHrXJ9TqoTu5VmBP9Ny8PUMYvqE7Lf3d3U
	 E+tEqPontks+HNcaoWZw2PYe5b80f/NTgs1lyJPoEl2XppsgOEiuX06i8GCeP/OPRl
	 IWEroQPCuvXmwZLNpBmaHM6w35swyd+7O97bEj2iiAKdJwrFt3wJfRgKAF01jtRPb1
	 rMq3b7ASDR3Z9kCOVWRoi5Gnd97hiLn5nFX4Rc91FRaiDMb/CrMSctraSD1TL/8RXk
	 8WttQqxo4J6Cw==
Date: Thu, 28 Aug 2025 21:03:52 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [for-next][PATCH 1/3] sorttable: Move ELF parsing into
 scripts/elf-parse.[ch]
Message-ID: <aLCoGIEXLRrQ9PmL@levanger>
References: <20250828182754.733989525@kernel.org>
 <20250828183125.288650678@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828183125.288650678@kernel.org>

On Thu, Aug 28, 2025 at 02:27:55PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In order to share the elf parsing that is in sorttable.c so that other
> programs could use the same code, move it into elf-parse.c and
> elf-parse.h.
> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas.schier@linux.dev>
> Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/20250825231355.597630284@kernel.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  scripts/Makefile         |   3 +
>  scripts/Makefile.vmlinux |   2 +
>  scripts/elf-parse.c      | 198 ++++++++++++++++
>  scripts/elf-parse.h      | 305 +++++++++++++++++++++++++
>  scripts/sorttable.c      | 477 +++------------------------------------
>  5 files changed, 542 insertions(+), 443 deletions(-)
>  create mode 100644 scripts/elf-parse.c
>  create mode 100644 scripts/elf-parse.h
> 
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 46f860529df5..f19624b3ed92 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -12,6 +12,8 @@ hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
>  hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_builder
>  hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_gen
>  
> +sorttable-objs := sorttable.o elf-parse.o
> +
>  ifneq ($(or $(CONFIG_X86_64),$(CONFIG_X86_32)),)
>  always-$(CONFIG_RUST)					+= target.json
>  filechk_rust_target = $< < include/config/auto.conf
> @@ -25,6 +27,7 @@ generate_rust_target-rust := y
>  rustdoc_test_builder-rust := y
>  rustdoc_test_gen-rust := y
>  
> +HOSTCFLAGS_elf-parse.o = -I$(srctree)/tools/include
>  HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
>  HOSTLDLIBS_sorttable = -lpthread
>  HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index b64862dc6f08..ebbb8b5aca83 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -97,6 +97,8 @@ ifdef CONFIG_BUILDTIME_TABLE_SORT
>  $(vmlinux-final): scripts/sorttable
>  endif
>  
> +.PRECIOUS: $(vmlinux-final)

Why do you need '.PRECIOUS' here?  Does its need match to Masahiros
explanations in 
https://git.kernel.org/torvalds/c/875ef1a57f32fcb91010dc9bc8bd1166956a579e

Kind regards,
Nicolas

