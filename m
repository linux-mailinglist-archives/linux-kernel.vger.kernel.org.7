Return-Path: <linux-kernel+bounces-855080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B0ABE02C4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA31419C277C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80933254B2;
	Wed, 15 Oct 2025 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvsXYo3t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBFD3254AC;
	Wed, 15 Oct 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552879; cv=none; b=Ft9Vol1uZStV4pl/+nMpONdQhBHtsyyIVHsaTvEbZTnZPpKWarCUTMT5DcaoY8UYQCZWJeyew/iFxSJDGsDkzZHcabL6ZUS42tACSYzx/6Kf7+PyVTe/DpNhyjthwRd995v47njjwxlEPGLnuFt4pecOmRB53CP1Vp/oXzaqGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552879; c=relaxed/simple;
	bh=rySxjUJGg5L0aeZfKHHZ0liCV/P4tKXtl04chJYFmac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPiaXku/8pxKIv28Zjxng0W27k2xDLG7LYnRiVXwQL6eRp7afX/BTv/NSNbBX4wRAYIAuX9mXB/OGC/F1yOO5PL/vVMVDiyErr4WpJ3jYScvvrcQ/o6tOqtGRtbKYpremHrGyvjFP/wWyj4V2qriG5Akez+DieLLbBBceg5xOw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvsXYo3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D958C4CEF8;
	Wed, 15 Oct 2025 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760552878;
	bh=rySxjUJGg5L0aeZfKHHZ0liCV/P4tKXtl04chJYFmac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvsXYo3tNsSSd1Bz9TDhzLY1SF60Zj/zoVNkVcI9gooMMrugG/vEvL3ZQmZVTEddb
	 nphzg6XcABe8gl9eMhGNC9/aJsyz/wBDpNJC4SO8A0glFGnAv2L7JiZjy/Ov/6xHZW
	 3dJj5m5opzwG6VWnATLPfb1MiUBPb3rK2LDLMJtNeGqPj8JwvuMiw1Bipx7KdVgnCT
	 1meUG04vCBWam7Q+YQwf5nBrmvoBDhqvUyz1I1cPVqRwo4hodMQqTj3AEfpFqiBFfn
	 /Qk6cX7PKw1xUqzQPEVJaAYtMFkPlKvrENokbCFdql3cXXcBT7z8hn2RtAarg90WOZ
	 19Efg6D7mTxyg==
Date: Wed, 15 Oct 2025 11:27:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	clang-built-linux@googlegroups.com,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] arch/powerpc: Remove .interp section in vmlinux
Message-ID: <20251015182754.GA1055324@ax162>
References: <eeaf8fd6628a75d19872ab31cf7e7179e2baef5e.1751366959.git.christophe.leroy@csgroup.eu>
 <20251013040148.560439-1-vishalc@linux.ibm.com>
 <2b4a3215-1620-40c9-a00c-ca833ebbb7b6@csgroup.eu>
 <aOypxKMzsLR5tAtv@linux.ibm.com>
 <20251015002154.GA2300901@ax162>
 <aO8XEhMdT19UOPlp@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO8XEhMdT19UOPlp@linux.ibm.com>

On Wed, Oct 15, 2025 at 09:07:54AM +0530, Vishal Chourasia wrote:
> Hello Nathan,
> 
> On Tue, Oct 14, 2025 at 05:21:54PM -0700, Nathan Chancellor wrote:
> > In this bug report, you mention using LLVM=1. Does the issue happen if
> > you use GNU ld (ld.bfd) via LD (i.e., LD=powerpc64le-linux-gnu-ld or
> > equivalent) over ld.lld from LLVM=1? This sounds more likely to be a
> > linker difference rather than a compiler difference.
> 
> Thank you for the insight.
> 
> Yes, when using powerpc64le-linux-gnu-ld linker .interp section is not
> emitted.
> 
> Command:
> $ make LLVM=1 ARCH=powerpc LD=powerpc64le-linux-gnu-ld -j 8 zImage
> $ llvm-readelf -p .comment vmlinux
> 
> String dump of section '.comment':
> [     0] clang version 22.0.0git (https://github.com/llvm/llvm-project.git 7314565281ec28b745502c3f429fd431e16673eb)
> 
> $ llvm-readelf -p .interp vmlinux                                                                                    
> llvm-readelf: warning: 'vmlinux': could not find section '.interp'

Thanks for confirming. Does this fix the issue for you? It appears to
work for me.

Cheers,
Nathan

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index de6ee7d35cff..15850296c0a9 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -330,7 +330,6 @@ SECTIONS
 	}
 	.hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }
 	.gnu.hash : AT(ADDR(.gnu.hash) - LOAD_OFFSET) { *(.gnu.hash) }
-	.interp : AT(ADDR(.interp) - LOAD_OFFSET) { *(.interp) }
 	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
 	{
 		__rela_dyn_start = .;

