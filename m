Return-Path: <linux-kernel+bounces-863423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B89BF7D83
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4277E356226
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217D3350D74;
	Tue, 21 Oct 2025 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m3ZEEAhl"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6AD2F6175
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067137; cv=none; b=WXSWKKNzz2ddrsem49Gg2IJNuOEsvFWXF1nClWGvkq0Fc0sdW6NdOT6/JnweADbUzP/Qxz9qhlEanycXKvVEer7B5g4aO48GTio4/ZF6GHKgpLLS4SHWBSSuSun8uItc9dl0tJtl7KRzfh3IoNKLx+AoqEM3bJh3NdXf9kaZSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067137; c=relaxed/simple;
	bh=r35hMGMVewGjTDxqeCV1BR3G18FQLXyTtBc0u31fhEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSGkq0ks4c8ApZ9GQXbrLUXBeTk8F4FAdUn91b0KabVR4bPn5u+pfiTQdRaVQOY56B3ot3pYCLVrA3r5FrCKn0POsbXpS2IefKB0+MbnlVS618zGojq4li5Rvi2Wku1NN51gsSupwyEKvqDNa9PPHXhCSzyti2pQBJJVn18TRcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m3ZEEAhl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rRkqHwh1tGglv+zgC/2nNvVskSIGh0jfX0Xvn+5nHPE=; b=m3ZEEAhlwDrzVBufHnGSu5k7pg
	9S7FZKx84GjX7R8tE1zWa9ZIHFw3FYYELCDo8veIFY1IsvfzQokjBtkwp2OXAVocKZQTDSv3USaaF
	OcaHMvaHdGECeVtMpZRWIYAthbBT8cB2KtCzj6yRl5QhRclwgyCCS5do4iuFdG3Q38Oz02W3MDavf
	LNhHkohrjrO0TqcmRhspEJn/qZ37oDPJ7eZK+Jbiko4gTYBdhZZo5wY0s5yEdTiyxwsfQvaj9OxJx
	PrFSBZf+OdPrn4DtYj9v3wmyKOyNyoH2vhiICD+4FdHvbRytvFVh/WGPXULoVkLbBcjXRw0nL6bZj
	pQIuSc/g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0Y-0000000DsPz-4AcJ;
	Tue, 21 Oct 2025 17:18:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 11F6F3030E8; Mon, 20 Oct 2025 14:38:35 +0200 (CEST)
Date: Mon, 20 Oct 2025 14:38:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] objtool: fix failure when being compiled on x32 system
Message-ID: <20251020123835.GE4067720@noisy.programming.kicks-ass.net>
References: <1ac32fff-2e67-5155-f570-69aad5bf5412@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ac32fff-2e67-5155-f570-69aad5bf5412@redhat.com>

On Mon, Oct 20, 2025 at 02:23:58PM +0200, Mikulas Patocka wrote:
> Fix compilation failure when compiling the kernel with the x32 toolchain.
> 
> In file included from check.c:16:
> check.c: In function ‘check_abs_references’:
> /usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:47:17: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 7 has type ‘u64’ {aka ‘long
> long unsigned int’} [-Werror=format=]
>    47 |                 "%s%s%s: objtool" extra ": " format "\n",               \
>       |                 ^~~~~~~~~~~~~~~~~
> /usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:54:9: note: in expansion of macro ‘___WARN’
>    54 |         ___WARN(severity, "", format, ##__VA_ARGS__)
>       |         ^~~~~~~
> /usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:74:27: note: in expansion of macro ‘__WARN’
>    74 | #define WARN(format, ...) __WARN(WARN_STR, format, ##__VA_ARGS__)
>       |                           ^~~~~~
> check.c:4713:33: note: in expansion of macro ‘WARN’
>  4713 |                                 WARN("section %s has absolute relocation at offset 0x%lx",
>       |                                 ^~~~
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Fixes: 0d6e4563fc03 ("objtool: Add action to check for absence of absolute relocations")

You could've kept Ard's Ack. I'll go add it manually.

Thanks!

