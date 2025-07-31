Return-Path: <linux-kernel+bounces-752178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA3CB1722A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9BC7B6E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4092C3273;
	Thu, 31 Jul 2025 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AITydUwT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76F2C08C5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968969; cv=none; b=jmtn20wQC75N2EIS26Dx1xjfUUmuxAHSxk9l7nYI2thXn7jFnidfu1YFUiM7h3PvCNdFGnqLHK4KSNgXaZXAFvheXyH7FqiGm2JS3Kgmpkx94HszEm4ejSXkGdlVaMOejKCxSSEcJ9BW/tZG4BwhtV7A7vwcVSI1uKk++0/akto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968969; c=relaxed/simple;
	bh=ixqrUzSgSgB88DT37q7pYqswDV/3KB+F/Vetrvz2sWo=;
	h=Message-ID:Date:From:To:Cc:Subject; b=JskC61b9DcGabakFYoBxuae8ORMEzwUS06jnupW/q9bxqTGSu7rVLeP+YNhBu0AnRCBaPuqO5316bZxCoXucgS7fRS9L05AbeQ38G5UtP+QBfQD3RlmV7OK0JQ+mdMHwqyJ/2M8+JZM7eX051cdVTxds8cB96fT6j5SPq2DqwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AITydUwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A203AC4CEF9;
	Thu, 31 Jul 2025 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753968968;
	bh=ixqrUzSgSgB88DT37q7pYqswDV/3KB+F/Vetrvz2sWo=;
	h=Date:From:To:Cc:Subject:From;
	b=AITydUwTY4C7qg9yg9dW/cg5GX9N11fTaCapUq1zQm8eaD0svh3r5E/plnh0IUzDV
	 2xBZyBpvxhLFIOLPjRVGHP1pN4iHNSzP8YkB6pNECbwrV8w85bDx+Ll2E2fDgesx5I
	 pIfLG1hhc68jm0ZsVkHlT+YQQ/+zp1vXkLiXpBuwXbDd7379VZbOcfNgCini3i50/V
	 LxC1tkVOUG8qiuEv1LAiF5WqDh/+8mrpGxMvqCtIQe3CxHSv14D6GMkpRaUbEBQjb+
	 d5yh9aDRwGo72WqWaFkqYll5Fz0Je+qdhSWU6bp+9//mrWtcQWiNTLp4Hi87c5NKBx
	 +ELGJRlE+jxuw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uhTSN-00000006kil-0WTz;
	Thu, 31 Jul 2025 09:36:27 -0400
Message-ID: <20250731133613.889948523@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 31 Jul 2025 09:36:13 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] tracing: Final updates for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 623526ba8984cafdffa0eba7ee424f2e40c8a219


Steven Rostedt (2):
      tracing: Have eprobes have their own config option
      Documentation: tracing: Add documentation about eprobes

----
 Documentation/trace/eprobetrace.rst | 269 ++++++++++++++++++++++++++++++++++++
 Documentation/trace/index.rst       |   1 +
 kernel/trace/Kconfig                |  14 ++
 kernel/trace/Makefile               |   2 +-
 4 files changed, 285 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/trace/eprobetrace.rst

