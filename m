Return-Path: <linux-kernel+bounces-742833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB5B0F729
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C789674B5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E62F50B7;
	Wed, 23 Jul 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST2hgEZi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ECB1FDA82
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284963; cv=none; b=um7vX8mS8VotrPuW7WHGOqn9KG1cjJ+OUvP/e0cKCVSNypcBvYKe0X9dLvtDou9Q7NoXPVMjvz8QAQ9YJvynPld8DSjehhPkU693Q0OOJ5+Qu3YSFTJQyUjRfwie9JX3ov+Z5yNZecA3oAiGZB5gsu8ddZExPsnmTASzaJLbI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284963; c=relaxed/simple;
	bh=1ZYm2iX/5igYMVfe4wwokyCMPT4ImHaWCrh+ggIYA/o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pILVy08PCmm7clBJm8OrylZMN4sPG7BdLMVbeK9f0RJKDYV6t2oV9u9odIarZ6JbmIAK3Ial2TPIeAa9HCULJqv0RUkqv/2xT1FuYqyPtsrnkpWQWkrD+fp+BF+QXr6pTnAsK6QUwZ1/Z24eEmoFi4Lt4KUxJlFyHugNLy1Ys24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST2hgEZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A077AC4CEEF;
	Wed, 23 Jul 2025 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753284963;
	bh=1ZYm2iX/5igYMVfe4wwokyCMPT4ImHaWCrh+ggIYA/o=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ST2hgEZih1qXqc9S0u+iT24ZB/cgD8iTtF5bOFRXdnC1Ku6zvMKNXgIIK6vjCFRG+
	 H9FTkr6hUFoJGbjdnBCPHzyMbuQYpTB9twAeHQhBPnnl4JUzrU18FXPQyWROwRdo2w
	 8Q32hW4ECC1c1ns+YHqn6oY814W9eC05ztSF1SEMiAmB7IVWtwpQqo4uupt1n336lY
	 toaTSMpeyqOXsKmFU1Qg7x9N98iLIuq2PHXb8gQTU2Z38y70FzkT1p+NTwywX9ZDh+
	 vlqrsbQa/t8gpE3knZ3NpU3GHvYmWFDYOv2WqHldzzVGThJBU6Uo1Wo77moyFsU8b6
	 47nbT/CDiNCvg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ueame-00000000LQj-0dBj;
	Wed, 23 Jul 2025 10:49:28 -0400
Message-ID: <20250723144928.003886193@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 10:49:11 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ricardo Neri <ricardo.neri@intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [for-next][PATCH 4/8] tracing/sched: Remove obsolete comment on suffixes
References: <20250723144907.219256132@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Commit ac01fa73f530 ("tracepoint: Have tracepoints created with DECLARE_
TRACE() have _tp suffix") makes it unnecessary to manually add a suffix.

Remove a now obsolete comment.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Link: https://lore.kernel.org/20250620-rneri-tp-comment-fix-v1-1-e0f6495ac33c@linux.intel.com
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 4e6b2910cec3..f24c373bcc44 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -829,8 +829,6 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
 /*
  * Following tracepoints are not exported in tracefs and provide hooking
  * mechanisms only for testing and debugging purposes.
- *
- * Postfixed with _tp to make them easily identifiable in the code.
  */
 DECLARE_TRACE(pelt_cfs,
 	TP_PROTO(struct cfs_rq *cfs_rq),
-- 
2.47.2



