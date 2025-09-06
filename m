Return-Path: <linux-kernel+bounces-804497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CB0B477F4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 00:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133BA1C23805
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 22:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5942D836D;
	Sat,  6 Sep 2025 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Frc1MNwO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E982C3278
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757197051; cv=none; b=lasSZye2gm0dKb9z/8B5h7FlhWGl2uGjhDdYr7NHlccR3Wpg4kU73sxl3de4l3J9epzLEr7AhDe/fkkPoN3/UEoCly5wfvtmlq3W/ZGjhXJi8NEMn//halAU4fE6Cnq1QLfV1mpi4U3xLOY9Z/Mp5t91/YbWkvvxhhDAJNe8bMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757197051; c=relaxed/simple;
	bh=uxyBJmKu5Z7jyOGwW7QMY4WrNpM+wcyW7pVuNd8Nsqo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Qdwpe0Drg3anTTGjXZQBoEFiwNChuTSQw18rjkJkk4fQiRA8GoZvPStuHKogSmVUr5bVqAKS+o9HkIflYPyCTGBowxFAvY1eqgvZSCQTDwBNonxX2QN0GIhdt0ti3YI15S2fBlRZBj4Y7ySx/SlNxXrRhky8v9SDsl6iM65CLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Frc1MNwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F889C4CEFC;
	Sat,  6 Sep 2025 22:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757197051;
	bh=uxyBJmKu5Z7jyOGwW7QMY4WrNpM+wcyW7pVuNd8Nsqo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Frc1MNwOJTl7CDjhisJjkK+FfC7FCc0rssYMgnZ2kgVZYST6dzqQqRQYyU7Otk3kv
	 31wUE7RkxMip1M6dzsc4dSxBDdDaNmyiOEcXXTkqD7hkKMDFFI0iZxjqhswBTKi9Vm
	 HjpBRA/6/n5l7Y3lXc9/iJQkPkmXYrJRS++peTmz5swUNQrRDOG95uppfV+Mqnen1j
	 Mk9QvA428O7PhWA06Akfao03Qt1pIhvRM1tInNf7fosdM0j4vRAY8Lr6T4H6YML9gz
	 zBdT7BoVH0dE4tA+4V2m44X/aN7pG/whMekHvkfbn4Gtewa/utUEtxx93gwj90yyd3
	 57sYgKn94nUXw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uv1Ea-00000006UiB-44IT;
	Sat, 06 Sep 2025 18:18:12 -0400
Message-ID: <20250906221812.826443565@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 06 Sep 2025 18:17:54 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vladimir Riabchun <ferr.lambarginio@gmail.com>
Subject: [for-linus][PATCH 3/5] ftrace/samples: Fix function size computation
References: <20250906221751.054623340@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vladimir Riabchun <ferr.lambarginio@gmail.com>

In my_tramp1 function .size directive was placed above
ASM_RET instruction, leading to a wrong function size.

Link: https://lore.kernel.org/aK3d7vxNcO52kEmg@vova-pc
Fixes: 9d907f1ae80b ("samples/ftrace: Fix asm function ELF annotations")
Signed-off-by: Vladimir Riabchun <ferr.lambarginio@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 samples/ftrace/ftrace-direct-modify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index cfea7a38befb..da3a9f2091f5 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -75,8 +75,8 @@ asm (
 	CALL_DEPTH_ACCOUNT
 "	call my_direct_func1\n"
 "	leave\n"
-"	.size		my_tramp1, .-my_tramp1\n"
 	ASM_RET
+"	.size		my_tramp1, .-my_tramp1\n"
 
 "	.type		my_tramp2, @function\n"
 "	.globl		my_tramp2\n"
-- 
2.50.1



