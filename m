Return-Path: <linux-kernel+bounces-887580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE00C38A23
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F89C1888B8C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72A1E1E00;
	Thu,  6 Nov 2025 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tYo8mysr"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E291D9A5D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390804; cv=none; b=u8KoNilCFWJ4xeascm9FJ/4TWX1RLpN+jTDBR8MeHFaGVBWVcP2gHoaj+arxTQ6WXRSIBWmDkFdYfanmZ9kdIeEBsm8Xzyys92/fS3x/RkpIMsl07SNNStbvaqE32L+vQu0i/e8Acw4ULo1HXSaTkTby9E7Y537iOESJ9x4GH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390804; c=relaxed/simple;
	bh=zQpg74RsSYorhAac1SEWVIm7deECvLz6LWYEitEmAA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2hZSPPM13EBZFmXf823MKNeFDy0xEeTMEu6w7t2kLUpEulmjgx+Q/QafscBs9j5leZjwMvFdCvTUylKBSpUYpnj0u9VT/bkxoAARt1POwpsIyWI7IsPG2bEvEObDR69e2vjsdDNQ6Cg/zUzv3LCsi3K/znfO+6m5MtXRxSgWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tYo8mysr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-295c64cb951so86475ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762390801; x=1762995601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lCgwEti9mZ/dpfOqhDoMH4tBNKYeZkGpoLO7Z8lKIRY=;
        b=tYo8mysrTcS7NMK5DtU36KEKJ9QpbWqvtOG8USfCh8HuU9vKawBUFN0h17H7rJ8qyY
         JGa96Ij652Wr3nKpcQ8aOjSHOpmfiwEf+1zJg2op3alF0PniiGMZTVDnlyxeawVIRtT+
         Jn2kdNnJV+1qnOAY9EXmey+KcYjaH2pNsxoMOwGmrCUBlFpyoq9MGedZHmO0d7vvnXfF
         BzrELBUMCYlbAocsWvAestH0hDhRTXlqxvW2xM9QdYq5SQWXF53lG3FsveN1PWO1dqr2
         XogR8BYHuM6N7WFelm25P4WbjsIJcf6RYerU1cST8ur+FIflU/cu03bw/9gt//BOk3p3
         46dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762390801; x=1762995601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCgwEti9mZ/dpfOqhDoMH4tBNKYeZkGpoLO7Z8lKIRY=;
        b=hli+xkWe/SL1HqqLQsE4M9eaQeH5blOpmUX09FDqGiuSASLTxfon9WqRgpDMEhzM4I
         dOeN0b/G75eO7QuzUUt5w9mEFcWfC7sH3sgY+zFZ7Yfp5hi2E6xkVHmSJFflC9JTMTG0
         55pNvvgL0GJu0Sg3IUkwDCROxKzsCeIr/KGwmfSN2Fiz+PBD1hoIH4AuN+4Xyq0vv6PV
         JnizZJbQYwbVHLJfDSdBXKKTjLl/5QgeVgMoraEQGJnFTEieKZVN3dF0Yj5OfEitD/YU
         Zv4nVr7kpExQ/MJLdcw1PesrW7meAnbRqjlvVTgZw/+da/ACEQm3P9uiLTxmhwEockeN
         8iIg==
X-Forwarded-Encrypted: i=1; AJvYcCWJT5zfcrLFXNLK7STo5Gs0N8AmLA6PCbr7cK9aK+qZHno8M+hmD4f37NoI1lXd40Vs3piFUQSQx/DF8+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6yX3mn0hBxxLaBMiv/mqLDxd5pJKzzXL/l0eAsGZ/k3MWa/q
	KVEuKBK0k8ZV+KcyRY/Dsd01NP9AjJbG8yFtXcX4MRRk4oKJmkTG4Ja/SQVKQSKThw==
X-Gm-Gg: ASbGncuIBLWqhVechw/dQ9oWAU1aV7wKmdq8ZJFMld8oE6cwHh3CNJVwW00/76HMo30
	TMSEvowA51ktzoKA8CDWdS79NmQGffOlBPhvoDlYXMC22zc3h9JgmpMgXyBp6hLud0KLNN0oQLS
	7+ZiUExC8YaE6j8fl3rnOyRjtx6zUCByR2MsSHDj809JqNffR3oeLA4BL/Ec2pEoccEwOF64vvb
	RzbJ7RL2Slf1muGek99VC2SUGklVIMhOYYs6eX2Nl06IrTMGABgbUnZBEY22Tbt3RD30EGQM0Ke
	li5FIj4ZwQBxMgT5+8y+7Ld+WrgesMni9pZMZiFWVAaeDXTsczwa86RvvFECEr9p82CacYPJVTW
	UhN0YXzEj4RyjjYNpYhayGAJYbdJiI+KY2kO4n2WyHTuNhq/MBi18C6w7+v9jN/FsnqyWnA56Db
	8hgLiz4pDXgycOkI6DQ7pYzKzjkMTdiOIPscGYZncc4EV+mQKzQYcqIqWPHa8r1x7yQgRm7wXak
	qHwaYHMKQj795ZpqTwYYrpklNA=
X-Google-Smtp-Source: AGHT+IETVt2lcb1Kv+5hX1oRalANoIKnI0D32NdxUJbTbTWRl1hA6Vs6F6EhnmrUhTEass0HIC8PVw==
X-Received: by 2002:a17:902:c412:b0:294:e585:1f39 with SMTP id d9443c01a7336-29655ca6fadmr2157535ad.14.1762390800419;
        Wed, 05 Nov 2025 17:00:00 -0800 (PST)
Received: from google.com (116.241.118.34.bc.googleusercontent.com. [34.118.241.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ce9645sm578982a12.10.2025.11.05.16.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:59:59 -0800 (PST)
Date: Thu, 6 Nov 2025 00:59:55 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Miroslav Benes <mbenes@suse.cz>, Mark Brown <broonie@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: fix build ID and PC source
 parsing
Message-ID: <aQvzC6HqCrCKd2uK@google.com>
References: <20251030010347.2731925-1-cmllamas@google.com>
 <20251030205758.b3a4de16bc8ce7ca90383f86@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030205758.b3a4de16bc8ce7ca90383f86@linux-foundation.org>

On Thu, Oct 30, 2025 at 08:57:58PM -0700, Andrew Morton wrote:
> On Thu, 30 Oct 2025 01:03:33 +0000 Carlos Llamas <cmllamas@google.com> wrote:
> 
> > Support for parsing PC source info in stacktraces (e.g. '(P)') was
> > added in commit 2bff77c665ed ("scripts/decode_stacktrace.sh: fix
> > decoding of lines with an additional info"). However, this logic was
> > placed after the build ID processing. This incorrect order fails to
> > parse lines containing both elements, e.g.:
> > 
> >   drm_gem_mmap_obj+0x114/0x200 [drm 03d0564e0529947d67bb2008c3548be77279fd27] (P)
> > 
> > This patch fixes the problem by extracting the PC source info first and
> > then processing the module build ID. With this change, the line above is
> > now properly parsed as such:
> > 
> >   drm_gem_mmap_obj (./include/linux/mmap_lock.h:212 ./include/linux/mm.h:811 drivers/gpu/drm/drm_gem.c:1177) drm (P)
> > 
> > While here, also add a brief explanation the build ID section.
> 
> Thanks for fixing this.  I'll queue it in mm.git's mm-hotfixes branch
> with a plan to upstream it into 6.18-rcX.

Thanks Andrew, and sorry for the late reply I completely missed this
email.

> 
> I'll add a cc:stable tag so this gets fixed in earlier kernel releases
> also.
> 
> But....
> 
> > Fixes: bdf8eafbf7f5 ("arm64: stacktrace: report source of unwind data")
> > Fixes: 2bff77c665ed ("scripts/decode_stacktrace.sh: fix decoding of lines with an additional info")
> 
> Which kernel releases?  We're fixing a commit from Oct 2024 and a
> commit from Jan 2025.  How are downstream people to understand what
> we're recommending here?
> 
> I view the Fixes: as a recommendation we make to -stable maintainers
> saying "I think this should be backported to <here> and later".  As
> such, giving them multiple backporting targets must make their little
> heads spin.

So I've heard conflicting arguments about backporting patches to stable
for these scripts. That's why I skipped the Cc: stable tag. IIRC, the
argument is that one should always run the ToT scripts? <shrug>

You are right about the multiple Fixes: though. I should have only used:

  Fixes: 2bff77c665ed ("scripts/decode_stacktrace.sh: fix decoding of lines with an additional info")

Thanks,
--
Carlos Llamas

