Return-Path: <linux-kernel+bounces-749565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3B9B1500F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20623189CD15
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A705C28A1DD;
	Tue, 29 Jul 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVerkWbI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAF13B298
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802066; cv=none; b=OWsUtAAp6sJss+9PKSYdpVkFE5cTOblrrKJvznM0d4wRsmxbDxcnVAWcooYDdoUc1pShdKI9XX/PvEozgOiknw5SsSzOAfK/BOTz4qsbV5+HsFbmRV9S/klZEeEJHVNbUyGYNcI12hrK5qfIajRX2PPHMWbDSSYyN28T+w8CWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802066; c=relaxed/simple;
	bh=TJSTMQs8WGJ2sZYgigFhRCFiMDkqXDx9NeynkCg4beM=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=ED2uYRpwcS7nKErOhZ3bDquwJ01m6Jn2TW90QwyBqtReV0gBbS56qgzLZxMmBHPVEsHyfpjq9v5Hu1ziZexQCsQeyckmG+/cGEO+W7zvwy1PR8R5DVFOiVeWdqST6mc4vDW38hRgWePAlF2kUJgW32HpWchbg50MLDHw2aI5sZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVerkWbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6504C4CEF4;
	Tue, 29 Jul 2025 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753802065;
	bh=TJSTMQs8WGJ2sZYgigFhRCFiMDkqXDx9NeynkCg4beM=;
	h=Date:From:To:Cc:Subject:From;
	b=JVerkWbIgzusDjCsFkJsUUd18QtPq9rsASZDzrVIIGl7AZ0v6Mp96M0ab+MbKGwhm
	 RePG4S6ESDAUG/cThyN7iNINFagvDMXL6kRfyI2b21Fp+IBtzj29xP9YCC0JPQG4zV
	 sqycNfTeg3AYSF+4TSoVYI9uzHH4FiqICLoFjVHp2C04R807tGVD/sdIxh8n7apcfW
	 ANs7sgIUfDQYTz8hG1m2oUiuBIoEanUD5sU93K0LjuiLXA2DVeI1trGw1uQwcIOF2e
	 g8CZ1NfNCy6a0DlKm5iMTvhKWjqX3LIlV3bQF/QvFTO2CF/NxuBfIKszY3UraiyA0N
	 7Btn3vzqAQa+w==
Date: Wed, 30 Jul 2025 00:14:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ben Hutchings <benh@debian.org>, Bhaskar Chowdhury
 <unixbhaskar@gmail.com>, Masami Hiramatsu (Google) <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] bootconfig: Updates for v6.16
Message-Id: <20250730001421.dd070b79c120e9f6e9bd6b27@kernel.org>
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

Bootconfig updates for v6.16:

 - tools/bootconfig:
   - Fix unaligned access when building footer to avoid SIGBUS
   - Cleanup bootconfig footer size calculations

 - test scripts:
   - Fix to add shebang for a test script
   - Improve script portability using portable commands
   - Improve script portability using printf instead of echo
   - Enclose regex with quotes for syntax highlighter


Please pull the latest bootconfig-v6.16-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
bootconfig-v6.16-2

Tag SHA1: bf716884a5d3afcc0be679239ae07a1ae7cee4a2
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

