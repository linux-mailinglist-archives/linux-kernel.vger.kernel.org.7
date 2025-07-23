Return-Path: <linux-kernel+bounces-742828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0DCB0F721
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF791690CD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF9E1F4CBB;
	Wed, 23 Jul 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUqciMYD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC301E8338
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284962; cv=none; b=nzQxamtJbrGWVKq7PQpnRbt1fuxHqZ8d/bTJOD59DUT4salYODhoFPlhpRy39SToS9TmKhy8Ibdn0SaaGbOtoUaU0G/0gWl/1ts/Hh9f5N2aO40AI5mFuDt3E/WOKNKW+xUVg9Drkg1nYP0NnAOgcA4faxUcTka157hQEJuWwyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284962; c=relaxed/simple;
	bh=2AJ3pnQjZ1aKTWM8TU5LnO0jhfi+rzvH5e3vxC/0WFY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Loe7KYvqQB9MjRaSOVzQkUulfA90W7TSI5LfUQ/ZEnXVrhfTMmKFMWhlxgkZceP64EkxJQMlA0NC1KLOVqGgqnWzsxW4cAC3wv2Fz9+8zD9Dd2WUHYTFO3KfXAU6vzEr4gT+ifYn4ApbBD27hzOL60OWdbjoq0zHIRZ8s5fb4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUqciMYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323E8C4CEE7;
	Wed, 23 Jul 2025 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753284962;
	bh=2AJ3pnQjZ1aKTWM8TU5LnO0jhfi+rzvH5e3vxC/0WFY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=CUqciMYDnWOV9PagnDvvC/P797z7s34XI3i4fAyUTv3KbUUC8/XhfvGN+kIs5QOvn
	 Wq7w/044qzsx/HW+lTZheTzi2oABFio3lCgROECWdNqrtdd8Ch/8pLLmgRFSIIkD2n
	 x7dPr+Br9Gc5wqXsdBOhnLCb4We/uoWM6cygDdOIkJ2gtYGBVgMyZLJEO18RIFE3Xf
	 nPUan2HHcy+1QuH0GX8n+gMHI4xxxbDCIRlXSjjFoaPL8+xfklkCaZiSND2ntmW5Bo
	 MEDO+2+EFOvImF/D0XIa+quOc1vcVCdBYacols4+Z6AYOvssqTkHOiQzGoeVet4ly1
	 ctvSE5wvt7KQw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ueamd-00000000LPF-2j1l;
	Wed, 23 Jul 2025 10:49:27 -0400
Message-ID: <20250723144927.507197150@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 10:49:08 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yury Norov <yury.norov@gmail.com>
Subject: [for-next][PATCH 1/8] tracing: Replace opencoded cpumask_next_wrap() in move_to_next_cpu()
References: <20250723144907.219256132@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Yury Norov <yury.norov@gmail.com>

The dedicated cpumask_next_wrap() is more verbose and effective than
cpumask_next() followed by cpumask_first().

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250605000651.45281-1-yury.norov@gmail.com
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_hwlat.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index b65353ec2837..2f7b94e98317 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -325,12 +325,9 @@ static void move_to_next_cpu(void)
 
 	cpus_read_lock();
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
-	next_cpu = cpumask_next(raw_smp_processor_id(), current_mask);
+	next_cpu = cpumask_next_wrap(raw_smp_processor_id(), current_mask);
 	cpus_read_unlock();
 
-	if (next_cpu >= nr_cpu_ids)
-		next_cpu = cpumask_first(current_mask);
-
 	if (next_cpu >= nr_cpu_ids) /* Shouldn't happen! */
 		goto change_mode;
 
-- 
2.47.2



