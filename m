Return-Path: <linux-kernel+bounces-746333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36684B1259B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4ED581D07
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3FF25C6F9;
	Fri, 25 Jul 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I14vs8kN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57F25B1E0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475659; cv=none; b=KtrF3X/mMqR5+eqpGUbVZZLd9vUuTz9IVm7auryxgvGENoeWX+hTyKIwhVlxd10mHQjXPV/Nros2rwCDyvRRDyux/q0AedTjqQChThQoXLY1sSB0NoeNYLHXQ+pitIU7f+FSyaANcrTXaUVON0aAx+1WL40CIGfct9J/Os24tLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475659; c=relaxed/simple;
	bh=HEWgbF62D++gFU89ATiq9jPjAUKcvvzrEkAmBFR1mhY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eaEIHVGr4v1qp4gfQAfaUquQ7s2Ple42SA9mQ5et0dDIqrvvXn527TGfJcyeRNIrQbhFVetPRP+nrXLZgNejJsJ+pOSNeo/vDkmvi3NvVbZ3rlXZWckf4x2L/WjwEbVvQd+Qg2YWjM9ntLZ9pOzw1Hmbn+Mzx4hfH8ODUXQ5da4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I14vs8kN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86374C4CEFA;
	Fri, 25 Jul 2025 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475658;
	bh=HEWgbF62D++gFU89ATiq9jPjAUKcvvzrEkAmBFR1mhY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=I14vs8kNPy2w1Bze3lY9cExYdxXKJaayqRlubpRvXspeAldOMmsr8vrG65OhxrTZt
	 EQS9d2HPUhiPHK5KU6D8Sl2VWuf5cSa/n3sD7G9kHeSfhaLLFSSTB5dTd1kbY1r8Sy
	 wbDgLdQK/YYqRyleCdMa45RxNAiaGiC8lero5eAdurJ6Ma5zQRuNNQyWgwL9apabcL
	 l6sJCwBmE6eRMXZpoL+64vibklSoUnIW9f3E2042X0h6gkdprzCkFAlP5ohaFfLCY/
	 g4FoQpEHYfzmFZ7AXDqCRvZwVS/EUcPR5SuTeytTdasOK/+Rdo0d7PKy9N64hYbmdb
	 dGZi1FqMpjqBg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7Y-00000001QdM-2TdR;
	Fri, 25 Jul 2025 16:34:24 -0400
Message-ID: <20250725203424.446385917@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:00 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 John Ogness <john.ogness@linutronix.de>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 03/25] rv/ltl: Do not execute the Buchi automaton twice on start condition
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

On start condition of a Buchi automaton, the automaton is executed twice.

This is fine for now, as all the current LTL operators do not care about
this. But it would break the 'next' operator, which will be introduced in a
follow-up patch.

Prepare for the introduction of the 'next' operator, only execute the
automaton once on start condition.

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/9379f4e7b9c1c69a6dca3e20a22936c850a25ca7.1752239482.git.namcao@linutronix.de
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/rv/ltl_monitor.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 9a583125b566..67031a774e3d 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -167,8 +167,10 @@ static void ltl_atom_update(struct task_struct *task, enum ltl_atom atom, bool v
 	ltl_atom_set(mon, atom, value);
 	ltl_atoms_fetch(task, mon);
 
-	if (!rv_ltl_valid_state(mon))
+	if (!rv_ltl_valid_state(mon)) {
 		ltl_attempt_start(task, mon);
+		return;
+	}
 
 	ltl_validate(task, mon);
 }
-- 
2.47.2



