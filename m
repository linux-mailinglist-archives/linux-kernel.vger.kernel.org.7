Return-Path: <linux-kernel+bounces-621343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8090A9D814
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 08:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E603C4C3B14
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 06:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2AF17A2F0;
	Sat, 26 Apr 2025 06:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQSQDSPq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7186334
	for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647438; cv=none; b=rqlazf4vHkUP62zHbLIRsFHUuXfS83zp8XGp+M1QwfgubaeMWORieLtVnbYVBxDcANVdXX/uc/g1jBLYeOJY/p5d88jb9RJYuvMm63BunR91HkdQ1kQ0QQl7KpYoxKPRXuaSQMaBZNl87UbrAZvNB9DOKZ/gPMCehGSx/QmzQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647438; c=relaxed/simple;
	bh=0XokfoSh8++cl3/KKEd8xD10OAMywI6GvWNX7omzZHM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mk8cGgF3WxlbbchB3+o+VbvlonjkOyClvxDqHvw99l4tamgwsClIZQvVKdfEBRW/Idq0vVn4GCW66S+R9WbFg2q/wHiDXxc726yumsYpQ+ajBybZEZhCywieoVWQHKlox9Fauxfu7ogMzwsFcg060c5b0wdifYKon16SRQ8C0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQSQDSPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500BFC4CEE2;
	Sat, 26 Apr 2025 06:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745647437;
	bh=0XokfoSh8++cl3/KKEd8xD10OAMywI6GvWNX7omzZHM=;
	h=Date:From:To:Cc:Subject:From;
	b=HQSQDSPq0QX9v8P9A0t14Uyhckho356ZjRBtjOadxduEn6RH4tEhvn7whOpG+ENpD
	 S7loToyDnQbbQv7fIjbcDb5rhfq0+k52w7QFiiR2cfoYKInL523uUXksM++yHdAFlf
	 RRHBhdczW0bzxSZ0jTKi6NzwbtSphhcXWuFEHqO+4JgPagOuAExwKoUkZxcfp2OfVb
	 k1bpY+6YSd1anyvAq/5lBR67yPtJ902hIyUru3jyI1lsoKLdhSvtb3wAse8d/7VYtm
	 6n6yy2V8vEALKrpO4LnJ7iHo24+bmHMn9MJZksvGwKObKvjN3kPKqe1nn+kfnw9awX
	 0kr/xMM6dWM9g==
Date: Fri, 25 Apr 2025 23:03:54 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] move-lib-kunit fix for v6.15-rc4
Message-ID: <202504252302.665FB14F3@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this single fix for the kunit lib/tests/ relocation for
v6.15-rc4.

Thanks!

-Kees

The following changes since commit 3f2925174f8bd811f9399cb4049f6b75fd2fba91:

  lib/prime_numbers: KUnit test should not select PRIME_NUMBERS (2025-04-15 13:50:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/move-lib-kunit-v6.15-rc4

for you to fetch changes up to 4ea404fdbc39971814cd3eb36b43c11fb6f32e17:

  lib: Ensure prime numbers tests are included in KUnit test runs (2025-04-22 08:48:10 -0700)

----------------------------------------------------------------
move-lib-kunit fix for v6.15-rc4

- Ensure prime numbers tests are included in KUnit test runs (Mark Brown)

----------------------------------------------------------------
Mark Brown (1):
      lib: Ensure prime numbers tests are included in KUnit test runs

 tools/testing/kunit/configs/all_tests.config | 2 ++
 1 file changed, 2 insertions(+)

-- 
Kees Cook

