Return-Path: <linux-kernel+bounces-749649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874D8B150F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84021631E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E510223DE7;
	Tue, 29 Jul 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onxcyQH4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49031DFDAB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805468; cv=none; b=Rmgr0VaQeMANZkR/GYqRkF9PhOu6RjISPT1r4YDNXJ2lnaofryYNC6OjlZzWgb9UjmVGU0rBBFAho0IFDA7/TNkN05mX96mlD6TMuhb1vC3wOpKKJ13ZUe7k6vt4tjM6yS/9PsCvSFa/l8vZxbtZIABN5I003pPJYFl6fIFrJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805468; c=relaxed/simple;
	bh=+odpmbjGumK+zOi7X451s1t1S4s9h7ADurfQ/6v/9Xo=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=t2sKxrXfbBbp9yxifHbkToprYRdQzUBYJv1m+khgOjXiphFUjWWu2nuW/VsrlwAU1Vzrc6pLNS7N76BxOcnGcK9oze58jvuVIK2rvI5uNQwwjCVkT4YWwml/5Opw6wetwEFCYtNVsDHpeFNIZEsUUqfWxWsAEPOZjJU3SI0GqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onxcyQH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF74C4CEEF;
	Tue, 29 Jul 2025 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753805468;
	bh=+odpmbjGumK+zOi7X451s1t1S4s9h7ADurfQ/6v/9Xo=;
	h=Date:From:To:Cc:Subject:From;
	b=onxcyQH4mq+l6pY59zVwpJGVFaEpKCY239VT/c6zLglJNPSuvsXMe0ihP3A/8JuQZ
	 rl3drsy99atvomzkSyGNNsbZ/drDZRuAUGPax3A3OAKkY/puEW+fSN+K5cCsCMc7IH
	 r9s6oxvEqjp3jp6oksIRT9EKTjpbfdiDL38mdUybV9qH2GwhcudpY0RqH0nfrN2NWW
	 t+WLEURG1lqpxhztAgN8CIpgbvlXds2PaDyTmqxUsvqKha9Rzpd4pf2t/TS0Fmwu3Y
	 LoHnVz/qV/b2VsekHBHeEogVJtSgnwnGvB8DCUTgJtPJlzZohSGTeJyWMSyGlaSWa2
	 uclJvtFqutaiQ==
Date: Wed, 30 Jul 2025 01:11:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ben Hutchings <benh@debian.org>, Bhaskar Chowdhury
 <unixbhaskar@gmail.com>, Masami Hiramatsu (Google) <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] bootconfig: Updates for v6.17
Message-Id: <20250730011104.e9dad219ecde50fc42522562@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Linus,

Sorry for the confusing, this is correct update tag for v6.17.

Bootconfig updates for v6.17:

 - tools/bootconfig:
   - Fix unaligned access when building footer to avoid SIGBUS
   - Cleanup bootconfig footer size calculations

 - test scripts:
   - Fix to add shebang for a test script
   - Improve script portability using portable commands
   - Improve script portability using printf instead of echo
   - Enclose regex with quotes for syntax highlighter


Please pull the latest bootconfig-v6.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
bootconfig-v6.17

Tag SHA1: cf85f3b378433d53ead58f8502169cb989be2efd
Head SHA1: 6ed5e20466c79e3b3350bae39f678f73cf564b4e


Ben Hutchings (1):
      bootconfig: Fix unaligned access when building footer

Bhaskar Chowdhury (2):
      tools: bootconfig: Regex enclosed with quotes to make syntax highlight proper
      tools/bootconfig: scripts/ftrace.sh was missing the shebang line, so added it

Masami Hiramatsu (Google) (3):
      tools/bootconfig: Improve portability
      tools/bootconfig: Replace some echo with printf for more portability
      tools/bootconfig: Cleanup bootconfig footer size calculations

----
 tools/bootconfig/main.c             | 43 +++++++++++++++++++++----------------
 tools/bootconfig/scripts/ftrace.sh  |  1 +
 tools/bootconfig/test-bootconfig.sh | 37 +++++++++++++++----------------
 3 files changed, 44 insertions(+), 37 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

