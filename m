Return-Path: <linux-kernel+bounces-752380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D68B174D2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74A01C24C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B027C21C19D;
	Thu, 31 Jul 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OPz1znPA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KGFQE5cs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OPz1znPA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KGFQE5cs"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695D217C224
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978727; cv=none; b=RskdXXGMlTC2BR5u6sm+RBEX2NwQ+cj86660G/QudF4PmQiQrk2y0iFkQQ77YAaYHKTjSxNXWPTKxon5CwgnSNPVvDgCQThh23ykIHV3S0v68xo3SFJURx8WK4AMkWJdmucpV6Aw3XVYJe846E+J3sSaVannfKQGw4E+e8/fZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978727; c=relaxed/simple;
	bh=lHikoxUjcjMrp68bQtQ12G0SPYVvZFsiAt+7SwJG1Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g+gC5BkQZ/spP41436Er39fzJqKGSfuVnDteoX2FYt2dfI0EyxT+7jy1BkpZLACuup9RYBZ9weIGqkXnH5zYOLDY4Ay0bPDM9kOvw7Tmna50209uFOU1l2XNAawz0lJe7y4XigWL3K0Sv6xKYbogFOP5JbYy66asS/0cBa4IRQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OPz1znPA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KGFQE5cs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OPz1znPA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KGFQE5cs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 681D521A9F;
	Thu, 31 Jul 2025 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753978722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xWJLcUVxV+vWt0myEmYah2yHxPs7UTYwRvpNlyn90EA=;
	b=OPz1znPAqaFmVsaSyD20MC9V0T7aZH4/FOblMlCKFfhOtSSa+LHAkOs4rf37gRxQu9kmBr
	yckfRkRoj4YqNrSxu4pRkDB5amsnkExZwDpLSHr52XI/i57wYydo57mqLNq+qL1/iRt+A7
	PF06HNG5O57A2D/GzDUyf+N6acI8ncE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753978722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xWJLcUVxV+vWt0myEmYah2yHxPs7UTYwRvpNlyn90EA=;
	b=KGFQE5csu3chqC7QseNQ9s2mEVsKY77YE43r7UwiVWLf6umotaFCdvYTDqb+IzTzaLY6Y/
	kMCH4+FbA3kM7GAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OPz1znPA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KGFQE5cs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753978722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xWJLcUVxV+vWt0myEmYah2yHxPs7UTYwRvpNlyn90EA=;
	b=OPz1znPAqaFmVsaSyD20MC9V0T7aZH4/FOblMlCKFfhOtSSa+LHAkOs4rf37gRxQu9kmBr
	yckfRkRoj4YqNrSxu4pRkDB5amsnkExZwDpLSHr52XI/i57wYydo57mqLNq+qL1/iRt+A7
	PF06HNG5O57A2D/GzDUyf+N6acI8ncE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753978722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xWJLcUVxV+vWt0myEmYah2yHxPs7UTYwRvpNlyn90EA=;
	b=KGFQE5csu3chqC7QseNQ9s2mEVsKY77YE43r7UwiVWLf6umotaFCdvYTDqb+IzTzaLY6Y/
	kMCH4+FbA3kM7GAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DC7F13A43;
	Thu, 31 Jul 2025 16:18:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r9HeFmKXi2h0IwAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Thu, 31 Jul 2025 16:18:42 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 113DDD43F2; Thu, 31 Jul 2025 18:18:38 +0200 (CEST)
Date: Thu, 31 Jul 2025 18:18:37 +0200
From: Jiri Wiesner <jwiesner@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH] clocksource: Print durations for sync check unconditionally
Message-ID: <aIuXXfdITXdI0lLp@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 681D521A9F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

A typical set of messages that gets printed as a result of the clocksource
watchdog finding the TSC unstable usually does not contain messages
indicating CPUs being ahead of or behind the CPU from which the check is
carried out. That fact suggests that the TSC does not experience time skew
between CPUs (if the clocksource.verify_n_cpus parameter is set to a
negative value) but quantitative information is missing.

The cs_nsec_max value printed by the "CPU %d check durations" message
actually provides a worst case estimate of the time skew. If all CPUs have
been checked, the cs_nsec_max value multiplied by 2 is the maximum
possible time skew between the TSCs of any two CPUs on the system. The
worst case estimate is derived from two boundary cases:

1. No time is consumed to execute instructions between csnow_begin and
csnow_mid while all the cs_nsec_max time is consumed by the code between
csnow_mid and csnow_end. In this case, the maximum undetectable time skew
of a CPU being ahead would be cs_nsec_max.

2. All the cs_nsec_max time is consumed to execute instructions between
csnow_begin and csnow_mid while no time is consumed by the code between
csnow_mid and csnow_end. In this case, the maximum undetectable time skew
of a CPU being behind would be cs_nsec_max.

The worst case estimate assumes a system experiencing a corner case
consisting of the two boundary cases.

Always print the "CPU %d check durations" message so that the maximum
possible time skew measured by the TSC sync check can be compared to the
time skew measured by the clocksource watchdog.

Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
---
 kernel/time/clocksource.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index e400fe150f9d..3eeb18233a6b 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -410,9 +410,8 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	if (!cpumask_empty(&cpus_behind))
 		pr_warn("        CPUs %*pbl behind CPU %d for clocksource %s.\n",
 			cpumask_pr_args(&cpus_behind), testcpu, cs->name);
-	if (!cpumask_empty(&cpus_ahead) || !cpumask_empty(&cpus_behind))
-		pr_warn("        CPU %d check durations %lldns - %lldns for clocksource %s.\n",
-			testcpu, cs_nsec_min, cs_nsec_max, cs->name);
+	pr_info("        CPU %d check durations %lldns - %lldns for clocksource %s.\n",
+		testcpu, cs_nsec_min, cs_nsec_max, cs->name);
 }
 EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
 
-- 
2.43.0


-- 
Jiri Wiesner
SUSE Labs

