Return-Path: <linux-kernel+bounces-746531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0E8B127CA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BC13AEE6A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C509BE5E;
	Sat, 26 Jul 2025 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOZg23/V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0758800
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488094; cv=none; b=IvJ7nnQkr/wawdZOrAR6GSrmigaRXuOl7Xx5li7GuiZdRUfY5Evd0pga5wTqYtKt1ipQ1q/Jg0pO8C3MS8isgS+25/ThweZ9rr4zTRGCjqfhsDgQlClMQ7H+QvrmwwNhzIZDUJY4od7vjbRfju1LV1ROb7Pjae6ofrnbpQPtnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488094; c=relaxed/simple;
	bh=N1/yfwHwDYJpay+cT09hf+QA8XqVXzmqMFOFJCwANqg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F5+qeGmmgjuHI6G3iWJnCmR7SO00TQ4bW7jhyl7N/qi72YdVnO534DfRKuWbKkZCMC7FJ6atJyJ+S2YuG6oKmZUMxx3aam/TJA4Dz/RTuJ/EBMpIU5MXEqblM0TluXa7x+JavKWRD+Ni+yIJK37dgZUcSc2DMjq0tvrSd/y7cTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOZg23/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B061C4CEE7;
	Sat, 26 Jul 2025 00:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753488092;
	bh=N1/yfwHwDYJpay+cT09hf+QA8XqVXzmqMFOFJCwANqg=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=ZOZg23/VFb5PfKSaTBW6HdCtaIa3EeQ4DZevUnWY2MsZY2G522/PVWVKxeg067OJ+
	 dBqzzqHoWH1kDiw4XcCyr7N2I6dyweVj4F8HH/PYd5TBy2cTTWu1gF6GApUtzruspK
	 Vuhcw88SPSw83dTHZafRfcRNshu2JxpIA9g073P/Jv0eKb2KhYdUClKcAOy+8ExDxO
	 U7324OwJZpWf/fi/e09hv8Fl81aCuhdlO5jldWAMg1rU4SzVrc9Tou23W1LcGc+ccb
	 gNByPiExCfuCLDKuP8PQmQ6qyip4mCa97LgKVZfzURWsbmsM6Woe22X+A8ifeKYW5k
	 vL5AsDL6MhqKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F3A58CE0E5A; Fri, 25 Jul 2025 17:01:31 -0700 (PDT)
Date: Fri, 25 Jul 2025 17:01:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	haakon.bugge@oracle.com, pmladek@suse.com,
	akpm@linux-foundation.org, john.ogness@linutronix.de
Subject: [GIT PULL] Rate-limit changes for v6.17
Message-ID: <6a4a7b55-6fa2-4f28-99f7-c65135c69aa1@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

When the v6.17 merge window opens, please pull this rate-limit update from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/ratelimit.2025.07.23a
  # HEAD: 5c23ce0cb897b491a12667e3c15288eb03f8928d: lib: Add stress test for ratelimit (2025-06-24 05:47:35 -0700)

----------------------------------------------------------------
lib/ratelimit: Add functional and stress tests

Changes
-------

* Add trivial kunit test for ratelimit
* Make the ratelimit test more reliable (Petr Mladek)
* Add stress test for ratelimit

----------------------------------------------------------------
Paul E. McKenney (2):
      lib: Add trivial kunit test for ratelimit
      lib: Add stress test for ratelimit

Petr Mladek (1):
      lib: Make the ratelimit test more reliable

 lib/Kconfig.debug          |  11 ++++
 lib/tests/Makefile         |   1 +
 lib/tests/test_ratelimit.c | 144 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 lib/tests/test_ratelimit.c

