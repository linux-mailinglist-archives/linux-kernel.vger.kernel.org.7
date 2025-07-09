Return-Path: <linux-kernel+bounces-724241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A457AFF058
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AAF11C2220F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE4224B13;
	Wed,  9 Jul 2025 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1ksb/8S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38278F40
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084050; cv=none; b=A4eDqgTkTLdHChZ9agWE4easHGC7wUkfO5rRxgI7q5thC8q0GnamR1aQlGl8KtKAnppaOND5F5T0Zz0xqfkIRWhms4SZ/1ajNd1bOaxtSEFrIsOQhz4WFHss6fvEeTIsMZNvVKHK+qK3rw+QQlzX4g0qMGjwhAHZrFItVpgN5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084050; c=relaxed/simple;
	bh=8QFngT3qZDDRnKx6wfqcgnqCy5ZyvvwC+DiON91sZwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arNVGFsxIpXwD4/dHEVpDmv2fCea+OWWXw8g+4j4ME271TahPxj3Nhfzw1U1JlIY5JuX/kNnyIcFxAXSE7Jg6Ttwfr0tXmRHQ7BtC5PQ/637xHKyg88ycMDiasc/74LnGUfduXmEOUbaMIdNsPjQymPeTVJPSaJ+Bw6oMvYgsqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1ksb/8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7AFC4CEEF;
	Wed,  9 Jul 2025 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084050;
	bh=8QFngT3qZDDRnKx6wfqcgnqCy5ZyvvwC+DiON91sZwg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=D1ksb/8ScGnVO1gzNIfiH5696QpvffCINyeQRUeyI1tVXkalj0cmYrjR+0XdBSoaC
	 gP+K02WhpChaCbMFhSwOwbPU8JTJ831i8CXqjmzOoRiei5rPNLuOLQ804pB9PFH6Uu
	 VUj+9Nx7+W5XRT9LH8BXxm09HOuvWF0gEn5bSUVBrN00aclkS7VQGdIdZFk803goyq
	 yCp9BiHwKI7qJmSEjsWdHqtBVE+TcLd/EbC/N45c9/6AuojLjFANS/MEuBRAaf1RA9
	 gzSfuGolwbvQkckXv5RJc98apcyYdGxxz9Jy3pJ9eeu0Gma4oMvzNC2EbAbeQUr0eg
	 DtrSdAg8ZZleg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C0192CE0B9F; Wed,  9 Jul 2025 11:00:49 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:00:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jon Pan-Doh <pandoh@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>
Subject: [PATCH v6 0/3] ratelimit: Add tests for lib/ratelimit.c
Message-ID: <d1007957-97ff-4f6f-92ac-606f68c65dfa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fbe93a52-365e-47fe-93a4-44a44547d601@paulmck-laptop>
 <4edcefb0-cdbd-4422-8a08-ffc091de158e@paulmck-laptop>
 <72ee57b8-9e2a-4cad-aaa0-1e3353d146d8@paulmck-laptop>
 <b0883f20-c337-40bb-b564-c535a162bf54@paulmck-laptop>
 <1bcf7d5e-b89c-4118-b872-c8896bdbdc19@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bcf7d5e-b89c-4118-b872-c8896bdbdc19@paulmck-laptop>

Hello!

This v6 series adds a simple "smoke" test along with a simple stress test:

1.	Add trivial kunit test for ratelimit.

2.	Make the ratelimit test more reliable, courtesy of Petr Mladek.

3.	Add stress test for ratelimit.

							Thanx, Paul

Changes since v5:

o	Drop patches that have since been accepted into mainline.

o	Add Petr Mladek's patch improving the reliability of the simple
	test.

Changes since v4:

o	Add a simple stress test.

o	Move the tests to the end of the series for bisectability.

o	Add Reviewed-by tags.

Changes since v3:

o	Correctly handle zero-initialized ratelimit_state structures,
	being careful to avoid acquiring the uninitialized ->lock.

o	Remove redundant checks of the "burst" local variable.

o	Add Reviewed-by tags.

Changes since v2:

o	Apply feedback from Bert Karwatzki, Srikanth Aithal, and Mark
	Brown, fixing a hang that happened on some systems.

o	Applied Reviewed-by tags and added links.

o	Added a prototype patch from Petr Mladek that splats if either
	interval or burst are negative.

o	Added several commits that simplify the code.

Changes since v1 (RFC):

o	Switch from lockless fastpath to carrying out needed updates
	upon trylock failure, per Petr Mladek feedback.  This greatly
	simplifies the code and is a much smaller change from the
	current code.  There is a small performance penalty compared to
	the lockless fastpath, but not enough to matter.

o	Never unconditionally acquire the lock, again per Petr Mladek
	feedback.

o	Better define effects of non-positive burst values (always
	ratelimit) and non-positive interval values (never ratelimit
	when the burst value is positive).

o	The changes from Petr's original are supplied as five incremental
	patches, but could easily be folded into Petr's original if
	desired.  (Left to my lazy self, they stay as-is.)

------------------------------------------------------------------------

 b/lib/Kconfig.debug          |   11 +++++
 b/lib/tests/Makefile         |    1 
 b/lib/tests/test_ratelimit.c |   79 +++++++++++++++++++++++++++++++++++++++++++
 lib/tests/test_ratelimit.c   |   77 ++++++++++++++++++++++++++++++++++++++---
 4 files changed, 162 insertions(+), 6 deletions(-)

