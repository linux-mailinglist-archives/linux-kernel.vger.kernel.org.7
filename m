Return-Path: <linux-kernel+bounces-837955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE96BAE1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73748327D56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3E330E0CC;
	Tue, 30 Sep 2025 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dprBt8vE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D106B30C0E9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251686; cv=none; b=XnklRz3ZuakgOzXOkGQcyU+QruEobyL7tv9M6zunyCgF4FLQ0HidcIBhp+qIZUjMz9YkFia+vTj7thuW3VKayJfnI/pu7m/xd0X4x0oZ4TjKsbeE7eMIrR4AJ/Zrw43c29nTkKmm6gE5CguWemRY2EbFjlElsrUVnz+nxf4bkdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251686; c=relaxed/simple;
	bh=IN3hHRIELFdM8Dk+oCOkHs+mCOpaPtH6nsw/3sTxNZU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kxg5CGmN5WWjAGedlaatJgWplMeA5VLAHTuSHG7wQdEqBuVJJvdp5TXDRJznGq6RVsRnYHcDE26sTd3EGmQrNhUquRiuMEzIQ2gj9djll6CAEBuvdEDyTGvXHtTDcLTEnjyTU6uNWktcwiGO4epZNGi3fT4ljfX4IxQnp2/+PN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dprBt8vE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B70C4AF0C;
	Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251686;
	bh=IN3hHRIELFdM8Dk+oCOkHs+mCOpaPtH6nsw/3sTxNZU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=dprBt8vEGrwrsl8vdOX/WPli9GGMnO2Vsb/Kkx0rhIX4ZdEBcPgGMkhhWuiCzmpfj
	 VhE0a3NforV1hYtRHC32TRX3gPiklv2kOca66RtX30TVFfOWBpNOYdSzLcswqXgDJF
	 4dTqEeSJdvhQKgtcuGCyBC2tZ7q3ox41UM70aFlcXqw35PPtTTGb6rfa9Kx8/EnlKI
	 yEkyoHfdix3qICkVXc/pAzQI1eplAkxAVVYtsbt3V4saPe90zqIigYvcody3Eq1Ag7
	 djzsDltWCCUCnsUfreIRzcbJ3AJF/WEUGpmdcwNpTNOLZ98beX/ioiZfYNF6pMic7J
	 dagBZTMyT8Tig==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3dkk-0000000DIJo-3bSd;
	Tue, 30 Sep 2025 13:03:02 -0400
Message-ID: <20250930170302.709162951@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 13:01:44 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vladimir Riabchun <ferr.lambarginio@gmail.com>
Subject: [for-next][PATCH 09/11] ftrace: Fix softlockup in ftrace_module_enable
References: <20250930170135.285740909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vladimir Riabchun <ferr.lambarginio@gmail.com>

A soft lockup was observed when loading amdgpu module.
If a module has a lot of tracable functions, multiple calls
to kallsyms_lookup can spend too much time in RCU critical
section and with disabled preemption, causing kernel panic.
This is the same issue that was fixed in
commit d0b24b4e91fc ("ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY
kernels") and commit 42ea22e754ba ("ftrace: Add cond_resched() to
ftrace_graph_set_hash()").

Fix it the same way by adding cond_resched() in ftrace_module_enable.

Link: https://lore.kernel.org/aMQD9_lxYmphT-up@vova-pc
Signed-off-by: Vladimir Riabchun <ferr.lambarginio@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a69067367c29..42bd2ba68a82 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7535,6 +7535,8 @@ void ftrace_module_enable(struct module *mod)
 		if (!within_module(rec->ip, mod))
 			break;
 
+		cond_resched();
+
 		/* Weak functions should still be ignored */
 		if (!test_for_valid_rec(rec)) {
 			/* Clear all other flags. Should not be enabled anyway */
-- 
2.50.1



