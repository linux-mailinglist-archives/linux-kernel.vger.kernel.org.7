Return-Path: <linux-kernel+bounces-804494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D03CB477F3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 00:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51BDA403C8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 22:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2762D7DF0;
	Sat,  6 Sep 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svm3i5FN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A44315D25
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757197051; cv=none; b=s56hQbbccDnThDqwQOKW92Ku5Jdzcv5zY1GlGp8dCBIYGWdhqKJmK6RicqTvJvbojC4uVOZ5lKB3GT0GMeqceSFcwpEuk+BsC4P+R02j7veTlOFwLYPIIQx0SC2mLR0lGegzB2uC+QYR88q+J+zO/M6A3HAVIRZvvfSEoZT31CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757197051; c=relaxed/simple;
	bh=GZ+SRovi3TbpnskH+xH5IP4NZZBwjh/8aZAcAf6WFSs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oLvAxdWIRoNIoLZy8AOI/D6g6e2VnaJezuq75+d6pRpLez7TGzM7So7FvYu0K69WNd4SwF42lmbSS72p9Bn+Dj5WO+9aMqFUwWDr6vx1Zvd4wvcfWxrGRe5quTd29yO9MCCH1HzFR5QuYruATTTnPtDMB/BFB0u4gL+PXsg1R/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svm3i5FN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52D3C4CEE7;
	Sat,  6 Sep 2025 22:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757197051;
	bh=GZ+SRovi3TbpnskH+xH5IP4NZZBwjh/8aZAcAf6WFSs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Svm3i5FNpmcw3VIF3ot8F7wsJFTUI8qtsmZBm0bSGM5BejFgikE32OVdUK9WuLIyv
	 8uRVkNO6MAQXrzwfpI1mYGmSm+hrxrk/1TTkjfsHOnrNFfSmQ18t2Rkd8y5dq9wLau
	 hhroAqwaWbNgGAKFtF81fDlHlatzzI4ece14Fs8C7JvWR47zJS4loSox27Bz9zwIRr
	 gxol6jHQxVzV74qDWX/jJICEbJkYIS2zo66aXnePFtv1HWL37dWDexX3MFvufJ0Vt8
	 12gyFjoujYE/se8FouUTg/Q+zw5xa0Bq+X/9owWThb8eQ/8PfpmA2vqUmFZNXJ3trR
	 n3MylbJ6sfWwQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uv1Ea-00000006UhB-2gz3;
	Sat, 06 Sep 2025 18:18:12 -0400
Message-ID: <20250906221812.496673112@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 06 Sep 2025 18:17:52 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [for-linus][PATCH 1/5] trace: Remove redundant __GFP_NOWARN
References: <20250906221751.054623340@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Qianfeng Rong <rongqianfeng@vivo.com>

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
made GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
(e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
up these redundant flags across subsystems.

No functional changes.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250805023630.335719-1-rongqianfeng@vivo.com
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index af42aaa3d172..2ab283fd3032 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -496,7 +496,7 @@ static bool user_event_enabler_queue_fault(struct user_event_mm *mm,
 {
 	struct user_event_enabler_fault *fault;
 
-	fault = kmem_cache_zalloc(fault_cache, GFP_NOWAIT | __GFP_NOWARN);
+	fault = kmem_cache_zalloc(fault_cache, GFP_NOWAIT);
 
 	if (!fault)
 		return false;
-- 
2.50.1



