Return-Path: <linux-kernel+bounces-746331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 944F0B12599
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BE11CC01B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9B125B692;
	Fri, 25 Jul 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxDYlbmc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07BA25A352
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475658; cv=none; b=J6b7N59xsSu2dd8Y3pQOxKw5M+ppOdY8S71VzYTMQc3zMlclGXxE1rWE7kFITO78SvImoJpMKmsKl5iIUNh6+C/phCspQqVVor7Bt0ybQPiMz/r6oIxbyBO55iOhX0clpGLlcgENkpxa6khrFXrTVmGQXbgDNCyGB8yQhAerhoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475658; c=relaxed/simple;
	bh=vLVShok0cMXltuEHQ/ZOFR7qvRYl1xl7zH6FxAy5Phc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kJ11BiCE6hRo0jB02FrFgu1RjRo4SIAqhW65/gUrv4lqH8qUBoHVXcLNGu8R+xktHh449HOhYuDKNW7SBgXZfwOM/BnxRDaS215H2Z9jH9S5Qfpi+E5LZjuXdvOkvEILKk4VyZZTIODfst8PuU5Yf3gYZtjn/VWCsjv1+vSPcfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxDYlbmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3CDC4CEF8;
	Fri, 25 Jul 2025 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475658;
	bh=vLVShok0cMXltuEHQ/ZOFR7qvRYl1xl7zH6FxAy5Phc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=LxDYlbmcM3QpRznRHmDlcxRlkQZDbbvufapeqa7H2jS/kAoeFNBah9kP4mSazIUif
	 KpX3nY433mdLcCLr82Gc3NMbB8xs1tnYBH6Xp2P3oj/Owm3qE/u/EnLIckMat4vUXT
	 /t14/rgpiM8Ng/6z9o36wW+S+fBDIcUgruH9t5VqST5UrxTW4lLEO//COPumN5j5xy
	 ree8/nT4ERhbmHAt/fhT4EQA+CrcutcXr2SWrEN9ND4EUR+4C1uHfaua1ir8Tqf+sL
	 5HhjS6XwCfwGyDKphiq97oh5LB9uJnRs1iJBzmmULdZNz8RI3javTxMpHJydAHYhli
	 EHsoR3MHhz+Qg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7Y-00000001Qcs-1mjn;
	Fri, 25 Jul 2025 16:34:24 -0400
Message-ID: <20250725203424.278638879@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:33:59 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 John Ogness <john.ogness@linutronix.de>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Petr Mladek <pmladek@suse.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 02/25] panic: Fix up description of vpanic()
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

The description above vpanic() has the wrong function name. Fix it up.

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/23a7e8add6546b155371b7e0fbb37bb1def13d6e.1752232374.git.namcao@linutronix.de
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20250711183802.2d8c124d@canb.auug.org.au/
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 6a1823c383d0..2a499facde13 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -307,7 +307,7 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 }
 
 /**
- * panic - halt the system
+ * vpanic - halt the system
  * @fmt: The text string to print
  * @args: Arguments for the format string
  *
-- 
2.47.2



