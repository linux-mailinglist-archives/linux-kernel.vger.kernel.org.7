Return-Path: <linux-kernel+bounces-889599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA20C3E035
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B573B4E5C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AED52E54A0;
	Fri,  7 Nov 2025 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mZ+16pMD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B42B9A8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476522; cv=none; b=Jd5sFtYQBlQA9VXAVNusgIB3qGxMgGFU7w9P9tR1sKC6wFNdPCosPAmzKIL0BrUDyr0b52Z2qFULjgxilK4Tx6fzrrtMbcjtCiDNQxpAiovCdLxat9QA3oQ+2Fmsh3mwN64gMHJu6e1wZMTaTKNWlBZGuzor6KzW2ZxXHcdez1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476522; c=relaxed/simple;
	bh=MictNU5+MsXk7TZOzf+J7ibUODHO2bWENl4pfZuABB8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iQfmNfupUAE5ETIwZ+EOCFYFf3uMohC0+oxo7JEbxJalOJjvWd6WRPVqDvSDrFUDDfPdBg6f+vW4DGMfWc9spAu1rM/XOtfvCYJVo9329T4eqSzvbXT47MrP2qpr8ZXO0+RYU25a/JEytw/ZXhEFTwEgE7AmLWW08OQoXxNyWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mZ+16pMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A18AC4CEFB;
	Fri,  7 Nov 2025 00:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762476522;
	bh=MictNU5+MsXk7TZOzf+J7ibUODHO2bWENl4pfZuABB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mZ+16pMD4Zj8wYN/Tnds/Kdb6aAo9uyCxvi9LINQNDdjVMjJIAnlfcPd6JOc/RyYI
	 iWb4v/ISf4y9bJlYuKcxTjncfFg9G3W+ZW0ENg4Y/s8hF2UJD8yk0JDQPAU9GFTNjN
	 dZNNQbNllnwnkK8HIxpzmqywwOWPvgnWT/r/bSuc=
Date: Thu, 6 Nov 2025 16:48:40 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Breno Leitao
 <leitao@debian.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Miroslav
 Benes <mbenes@suse.cz>, Mark Brown <broonie@kernel.org>, Puranjay Mohan
 <puranjay@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: fix build ID and PC
 source parsing
Message-Id: <20251106164840.c594ed684d22c97a6df7e364@linux-foundation.org>
In-Reply-To: <aQvzC6HqCrCKd2uK@google.com>
References: <20251030010347.2731925-1-cmllamas@google.com>
	<20251030205758.b3a4de16bc8ce7ca90383f86@linux-foundation.org>
	<aQvzC6HqCrCKd2uK@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 00:59:55 +0000 Carlos Llamas <cmllamas@google.com> wrote:

> > I view the Fixes: as a recommendation we make to -stable maintainers
> > saying "I think this should be backported to <here> and later".  As
> > such, giving them multiple backporting targets must make their little
> > heads spin.
> 
> So I've heard conflicting arguments about backporting patches to stable
> for these scripts. That's why I skipped the Cc: stable tag. IIRC, the
> argument is that one should always run the ToT scripts? <shrug>

Seems weird.  Later scripts may use features which aren't present in
older kernels.  Moreso with selftests, of course.

> You are right about the multiple Fixes: though. I should have only used:
> 
>   Fixes: 2bff77c665ed ("scripts/decode_stacktrace.sh: fix decoding of lines with an additional info")

Updated, thanks.

