Return-Path: <linux-kernel+bounces-746342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F38B125A0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8AA1CC3E82
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0520262FD1;
	Fri, 25 Jul 2025 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6YURAYo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93B25D216
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475660; cv=none; b=SvQ0QBXCsoQ2xBFM+ryY5Buoyc2aaWVo23bTVN9isT66ePRH46jErFo8enO0UND75Yg3hMs25FD4sKItS+T/W9z3pfKsbWMy/9bcZu24iEj8Z6VMS7pejgBZ5cDuqw/1h/yEeyttGFs/WxIM/u6McliBVDHJJ7l3M16t+3foVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475660; c=relaxed/simple;
	bh=jT6VsTh7t2bLtsbZyW2hkaBCthCsV0UlHy6KPrDqwxk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oPw/ziwVQ8TDzekM7H4wYtSRtiu1M8xuXR2fBnN5b2a1RivdyaYMpJmonBNTPo1d/HPpxySAFHhVAjE2qRoWUvJC8niUw25chYie2OsIpH8TZW6XlwDKjIZ9aRdCgasOxPW+w7f6lyIgZl/8HgUNK+C++wFSu3vJAHUSZ7ens5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6YURAYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489C3C4AF09;
	Fri, 25 Jul 2025 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475660;
	bh=jT6VsTh7t2bLtsbZyW2hkaBCthCsV0UlHy6KPrDqwxk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=f6YURAYoaTsgY6EPCB9gIELyi1biojaP/35Ybn5ZfJvi5FeieuG6U8Uejqc5b50la
	 bzsCeBg3XrknTtvpKcdsgERCvFCDcmwZyWwnrs/QGOMi3Xg0mvBgTm5c33rE4z4k5c
	 tAHtlaX4tMIShjQae0UofuyBElVmS3TRXnKrxc4Sgr+7uXFGvY7xl5lob0NEIGolaq
	 m7nvsvUVHilxHi2Epl2OP8LgXTojKyMUksinBntuERKEuRtkoN9hzSY9yahTSwmNsR
	 XINuVdAzUxmS9jDVqsQt6eJ6yERPeXUO16W5bTQ/BA6T9l99s5Gyyak3ya1A56Hi3H
	 7NzTdV14aBZfQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7a-00000001Qir-1ozP;
	Fri, 25 Jul 2025 16:34:26 -0400
Message-ID: <20250725203426.287986900@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:11 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 14/25] verification/rvgen: Generate each variable definition only once
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

If a variable appears multiple times in the specification, ltl2k generates
multiple variable definitions. This fails the build.

Make sure each variable is only defined once.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/107dcf0d0aa8482d5fbe0314c3138f61cd284e91.1752850449.git.namcao@linutronix.de
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/rvgen/rvgen/ltl2k.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
index 92e713861d86..59da351792ec 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -112,14 +112,16 @@ class ltl2k(generator.Monitor):
             if node.op.is_temporal():
                 continue
 
-            if isinstance(node.op, ltl2ba.Variable):
-                buf.append("\tbool %s = test_bit(LTL_%s, mon->atoms);" % (node, node.op.name))
-            elif isinstance(node.op, ltl2ba.AndOp):
+            if isinstance(node.op, ltl2ba.AndOp):
                 buf.append("\tbool %s = %s && %s;" % (node, node.op.left, node.op.right))
             elif isinstance(node.op, ltl2ba.OrOp):
                 buf.append("\tbool %s = %s || %s;" % (node, node.op.left, node.op.right))
             elif isinstance(node.op, ltl2ba.NotOp):
                 buf.append("\tbool %s = !%s;" % (node, node.op.child))
+
+        for atom in self.atoms:
+            buf.append("\tbool %s = test_bit(LTL_%s, mon->atoms);" % (atom.lower(), atom))
+
         buf.reverse()
 
         buf2 = []
-- 
2.47.2



