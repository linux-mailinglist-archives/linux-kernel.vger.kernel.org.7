Return-Path: <linux-kernel+bounces-890884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82389C41474
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A71542338A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B55633B6C6;
	Fri,  7 Nov 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpCpYhr/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CD132D7E0;
	Fri,  7 Nov 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540145; cv=none; b=J2kNQBKDt3kCJdM4xkM8ZgMGrXPWcxxqlyDabu2rc1IAwJkadSIMdr4Ek/sYz0rNeeUYjkRhnofvLquNHPdQT9rhmmnz+pBg31zMMulMVZNtnTXrUHI/HOfb4v1CnOYrHsn8e7FadgJTwP3He4OLcQJrEsEQ8dKMN7eSEnr5qRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540145; c=relaxed/simple;
	bh=1uk4f/vvzKN01nl74e544DZxNDjhLmkBY4gp+8iXipM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qDxu1HLcNQ1VEg3K1pad18fT8QblVI6I6in80dJUDKw6ZTKAsQTtVAmTGk9TCrixfEYFNINOITz105EmnDX9a9jAbsyO2CbnD9P00CJCJyeaHC5/VTWA45itaN8XsP/qsdqcmDPuO6lPS6iO7PH7J6kJV8nnZXC2u2j36abuloA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpCpYhr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B563C19422;
	Fri,  7 Nov 2025 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762540144;
	bh=1uk4f/vvzKN01nl74e544DZxNDjhLmkBY4gp+8iXipM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rpCpYhr/tJSK4Qe+NNdCQG5oDqDbyp+jiNy/wps1xyyULzxLrXvo0fJYQYjyE7WV6
	 ZZkPjoOU0kWIRH5zuqPBllOx55xu1hZl1l9wmFzvYKS3i4Qcg53TQgAt79C68jlVko
	 au7XjjFe1/DbGBwHaB5xUxHBhmcpm7VzJe92yOMMszBPPEb8XbmGmGqLkEQMxeKr97
	 O8puomL2/D8n2CuqFuhs3bGle1W1ab/kGXFKXjdXiVfWp+39VFW45vhB+E5aeCxCT+
	 R/fmcLjybvZh4WitAvZAwyuPy5uLt8HXIpAzK7qw1TiW22LWoZZFseIQ8Jj0rlOzrO
	 /45oArUXclawQ==
From: Nathan Chancellor <nathan@kernel.org>
To: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <20251106105000.2103276-1-andriy.shevchenko@linux.intel.com>
References: <20251106105000.2103276-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] compiler_types: Warn about unused static inline
 functions on second
Message-Id: <176254014196.4089614.8446049205890806125.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 11:29:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Thu, 06 Nov 2025 11:50:00 +0100, Andy Shevchenko wrote:
> Per Nathan, clang catches unused "static inline" functions in C files since
> commit 6863f5643dd7 ("kbuild: allow Clang to find unused static inline
> functions for W=1 build").
> 
> Linus said:
> 
> > So I entirely ignore W=1 issues, because I think so many of the extra
> > warnings are bogus.
> >
> > But if this one in particular is causing more problems than most -
> > some teams do seem to use W=1 as part of their test builds - it's fine
> > to send me a patch that just moves bad warnings to W=2.
> >
> > And if anybody uses W=2 for their test builds, that's THEIR problem..
> 
> [...]

Applied, thanks!

[1/1] compiler_types: Warn about unused static inline functions on second
      https://git.kernel.org/kbuild/c/9818af18db4bf

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


