Return-Path: <linux-kernel+bounces-742832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE2FB0F725
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB1616EF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C0A20297B;
	Wed, 23 Jul 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaIWUlqI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB101F873B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284963; cv=none; b=ZlgkiOMz7n770HHDYWtFcnA/o2PUH7CN2rPS8ysiH5A9sgKMKJ3FnVAxuv/CRyqlDtPOD/jEcEi1PeHOHERz5ttH40XJkjJ/K+GCZd9FrA9G5zQaBYQCXJ/xApYcmbDrAm/mk/qzaLz0tch5KqyX+ZukIA/iRM3YWBhNDN8XSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284963; c=relaxed/simple;
	bh=yVIOa+DTn1e/7d+LPldgDm3WHR6HDvflPpU5M2yKt1s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Z2LZaZ4Tu5eJqZ8M1zogP7SWDhXFfd0WvMOTwHT5+jhrhtRj3bSybZq+5y4Wi1OP+KA++i57Fu8vM0DDqFclajQMPyjlHSyrLGN8f6pDmy8rfMi8QY8ULxZ1hjTFbCEK5CT4voeMIeF5Bo3we0FEqSAclMHbFEnAlvPy5vmLI50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaIWUlqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D78C4CEEF;
	Wed, 23 Jul 2025 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753284963;
	bh=yVIOa+DTn1e/7d+LPldgDm3WHR6HDvflPpU5M2yKt1s=;
	h=Date:From:To:Cc:Subject:References:From;
	b=uaIWUlqIlQewAo9PqeT45+fepsMLfyppNbXVqfsUieGaBFsWoA8HvdZ1D4kVKxoNB
	 WsCGP3tEHh4vbl0Kt8RCPXJ3b+lrdYjnB1DTG1sQDW0pJLReCSFir4QNkMnLOtvAB/
	 JCnxWpK1IsHjV6azeoLEFT7470DYZWnRw9Hi4FmNC7VJrnr25xVEvSwO7tDTD5YkKS
	 qYSQYQerfSRqJeT2vsIcShqM+qDwtl/ujo9P3gE/VmK9fET4kvjXvtOOuU8t3Xso+s
	 XX231RluW/AYKY8251oDzY4OfQZPdmJZ+r8uL1QA55SHhBt+Vq+23z93DDxnujfp2w
	 005iVM6vTPrxg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ueame-00000000LSC-2iqC;
	Wed, 23 Jul 2025 10:49:28 -0400
Message-ID: <20250723144928.504865336@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 10:49:14 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 7/8] tracing: Fix comment in trace_module_remove_events()
References: <20250723144907.219256132@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Fix typo "allocade" -> "allocated".

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250710095628.42ed6b06@batman.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0980f4def360..6c0783fc4c2c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3695,7 +3695,7 @@ static void trace_module_remove_events(struct module *mod)
 		if (call->module == mod)
 			__trace_remove_event_call(call);
 	}
-	/* Check for any strings allocade for this module */
+	/* Check for any strings allocated for this module */
 	list_for_each_entry_safe(modstr, m, &module_strings, next) {
 		if (modstr->module != mod)
 			continue;
-- 
2.47.2



