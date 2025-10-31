Return-Path: <linux-kernel+bounces-879485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5ADC23398
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F091891C82
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4802882B6;
	Fri, 31 Oct 2025 03:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="m4QCuV9i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E6286D7D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761883079; cv=none; b=lCDQmywqnmrbpM+2VUACsyoruACSsK0RZwgWDxg+HtdoYXpGyLje1vAzlFpBuhAokqIdOrJ7OuhliB5L6IGh8tKaK+wjXRAZN2Erx8ecqEGq9rFxTdXyq07/hM93pRKPQ0vjAxe70MugqPN8IZQVomMwN9nXEvpT/MksJ/6m+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761883079; c=relaxed/simple;
	bh=/UZRBjw9RfJb/KrRXbW6BNHMszA5v/cbjnVLf7lt/e4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gw9pCL89waV0CnimX6x2EVIoQbw75CO6bv8kSEODgqEHF0HKrewRMbZDWJJ/aEHUkNcx/6iIFYPZs71W/85wpwnnuHKuYdYk8kDok3Uj04n15AMGEQlY+7uXwr6c+Iw5GjkHprYv7bTKFBIc4VilOm00pfX21oyUS/QzZ2Ihm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=m4QCuV9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD00C4CEE7;
	Fri, 31 Oct 2025 03:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761883079;
	bh=/UZRBjw9RfJb/KrRXbW6BNHMszA5v/cbjnVLf7lt/e4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m4QCuV9ilTW5+vUFlxukKtoNz7X7UsLczeYkpUEL85BlBvWXHnVJtiQzLyCBWZcMz
	 71/6eZ/vKqf01qhIG05zPIpbBQfFj4fUgurEm+IURdYiWensgCMdyNvUJz65cN1YwT
	 g2klrFwszVx/fkHMuQU1GS079Ijbkw4GTp9s1RsQ=
Date: Thu, 30 Oct 2025 20:57:58 -0700
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
Message-Id: <20251030205758.b3a4de16bc8ce7ca90383f86@linux-foundation.org>
In-Reply-To: <20251030010347.2731925-1-cmllamas@google.com>
References: <20251030010347.2731925-1-cmllamas@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 01:03:33 +0000 Carlos Llamas <cmllamas@google.com> wrote:

> Support for parsing PC source info in stacktraces (e.g. '(P)') was
> added in commit 2bff77c665ed ("scripts/decode_stacktrace.sh: fix
> decoding of lines with an additional info"). However, this logic was
> placed after the build ID processing. This incorrect order fails to
> parse lines containing both elements, e.g.:
> 
>   drm_gem_mmap_obj+0x114/0x200 [drm 03d0564e0529947d67bb2008c3548be77279fd27] (P)
> 
> This patch fixes the problem by extracting the PC source info first and
> then processing the module build ID. With this change, the line above is
> now properly parsed as such:
> 
>   drm_gem_mmap_obj (./include/linux/mmap_lock.h:212 ./include/linux/mm.h:811 drivers/gpu/drm/drm_gem.c:1177) drm (P)
> 
> While here, also add a brief explanation the build ID section.

Thanks for fixing this.  I'll queue it in mm.git's mm-hotfixes branch
with a plan to upstream it into 6.18-rcX.

I'll add a cc:stable tag so this gets fixed in earlier kernel releases
also.

But....

> Fixes: bdf8eafbf7f5 ("arm64: stacktrace: report source of unwind data")
> Fixes: 2bff77c665ed ("scripts/decode_stacktrace.sh: fix decoding of lines with an additional info")

Which kernel releases?  We're fixing a commit from Oct 2024 and a
commit from Jan 2025.  How are downstream people to understand what
we're recommending here?

I view the Fixes: as a recommendation we make to -stable maintainers
saying "I think this should be backported to <here> and later".  As
such, giving them multiple backporting targets must make their little
heads spin.

So can we choose a single point in KernelTime here?  And reflect this
in a single Fixes: line?

Thanks.


Joe, I'd appreciate it if checkpatch weer to somehow draw people's
attention to this (fairly frequent) problem.


