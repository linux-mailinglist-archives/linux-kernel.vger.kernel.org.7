Return-Path: <linux-kernel+bounces-867886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE9C03BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15D03B4517
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA6C27057D;
	Thu, 23 Oct 2025 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjmvcGOS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8262372633;
	Thu, 23 Oct 2025 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761260495; cv=none; b=EQ3vGoF+HLIliehLowkQ9br8/8esviwtrA+YzgE8bOJJQ4SbTv3A4nvQylRI5sRtqipitpFEr5iCI2mrvOI4EpiewRsojdbt/goaCYqnnOXThIPSLDsxXI8wwkgquzy8iYDbBp+Y+tLaigD6BJ1MisNtww30QA90KPJ8aMHPrcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761260495; c=relaxed/simple;
	bh=IyFkWO+w0klAeH0jZ6fETuRI5b4tLipGY81idAm0dmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyPG18C+DpZemCr0oEH8OT6NpMZrKdeTyBHS/4J4A7Bw49kxX6b7qFejioYYSLeuYDeyEiA15R6VpOLDk5Af6fAj9kEiK9MiyMlXFi8vHfwm/Iv2f3j5NM0rptYvbUqk675BfVIe4l7KI2RCzN9IiDx/zUChp8QZxg2HOKSL5kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjmvcGOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C5BC4CEE7;
	Thu, 23 Oct 2025 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761260494;
	bh=IyFkWO+w0klAeH0jZ6fETuRI5b4tLipGY81idAm0dmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjmvcGOST41E5xN43loL8USOhOYtqZJOA7WYJffK9HI8+aYD7ID5pkbu+OQIlH8Zr
	 0yT6b1CBSP+pXNJG87U5Qb4mNByfsUYsAxjMijBb+MCJFFoOHqxNZfYuPuaddWOxL8
	 4C6HYsqPm/jFNSWiiwc6qWqnJvajwjWWXPqAUqeufWQAlqtK4pA7fc0+3kJLNDW3Q+
	 O6BQYoJb8RrTpghKIR23rn8aJlMzGAVXa0Cbsv2HzWOmBCEskAosEBh1t8AIW22SRa
	 RiCpsQniSEPsWlwZkqxKZP/iUjrxpTLR3j9xX8PF0TZdM+W252tHXDe7FYHg26R7St
	 /ZQu2hNq4MD9g==
Date: Fri, 24 Oct 2025 00:01:30 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>
Cc: Nicolas Schier <nsc@kernel.org>, Kees Cook <kees@kernel.org>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] KMSAN: Restore dynamic check for
 '-fsanitize=kernel-memory'
Message-ID: <20251023230130.GA3006010@ax162>
References: <20251023-fix-kmsan-check-s390-clang-v1-1-4e6df477a4cc@kernel.org>
 <176126007537.2563454.16050415911756189258.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176126007537.2563454.16050415911756189258.b4-ty@kernel.org>

On Thu, Oct 23, 2025 at 11:54:35PM +0100, Nathan Chancellor wrote:
> On Thu, 23 Oct 2025 21:01:29 +0200, Nathan Chancellor wrote:
> > Commit 5ff8c11775c7 ("KMSAN: Remove tautological checks") changed
> > CONFIG_HAVE_KMSAN_COMPILER from a dynamic check for
> > '-fsanitize=kernel-memory' to just being true for CONFIG_CC_IS_CLANG.
> > This missed the fact that not all architectures supported
> > '-fsanitize=kernel-memory' at the same time. For example, SystemZ / s390
> > gained support for KMSAN in clang-18 [1], so builds with clang-15
> > through clang-17 can select KMSAN but they error with:
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] KMSAN: Restore dynamic check for '-fsanitize=kernel-memory'
>       https://git.kernel.org/kbuild/c/a16758f0142ab

Whoops, sent the applied message for the wrong change... This is going
to be in kbuild-fixes as https://git.kernel.org/kbuild/c/3423b2866797c
for -next testing but I will adjust it for any tags I receive in the
next few days.

Cheers,
Nathan

