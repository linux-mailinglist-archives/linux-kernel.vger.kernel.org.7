Return-Path: <linux-kernel+bounces-778703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFF4B2E918
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BA37BBE95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B7B1E47CC;
	Thu, 21 Aug 2025 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIz7akjk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26FF1D6AA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734411; cv=none; b=qui5rRfFNjPbltZSeqLPPyF+43P09cU8sy92+XCNGcHwaLHOiiMRMhXD7yfnA1BP2qIll5Ee8VrI32in7G/FZ9dQcHJXrusmcj8ezMOUw+tL/WtESanbuLU4Fb5D82PoLMi06Q/5NqUn8nt58vIuQE8kMbfExJxC9w4g7Dm1Vmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734411; c=relaxed/simple;
	bh=I+PodtOuCXjwGq7xmfuORZTJZ5SmG6Oq6SFUXChaQbY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rB94C8va4XBGdrx2iLjvP89MprnpSax5JmtPr+50DNOe2iuXxGuSMK+ssESJ8S+0wwxNrGyFgqbgX1EL/vU3Rnt9O767ZEsTCDEyNDE/mcYHu9AFW/IOR7WE+4WaE4OvrFfV4v2c5oLDf+lECv8yFeDtvhV38Umvx7CQlS+bZ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIz7akjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A20C116D0;
	Thu, 21 Aug 2025 00:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755734411;
	bh=I+PodtOuCXjwGq7xmfuORZTJZ5SmG6Oq6SFUXChaQbY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=LIz7akjkVhArnNtfy32J/Iaiw3jRsKFxfhuhBj93mw7QDH1ucM/LO/9E8zrrwWiG+
	 ujXdYi+e67odtFCBRsHRARHcppskKicAUTbgDfNdkJD1qOTlqXaSrx1upE1oNX+8Xk
	 f12jv5Q7AFQgz96l48acsfk8QyQcyvdDykonDAs5VcJlkuPCVe3IlzBUVbyrkgEaKk
	 GmG7oaxhFKjX0B9uP4DHH44DyaZBfGupD+wbnVkivBXaYLhWyA8SYSXLyL5WTKoAql
	 3BAlH0+pe/cPihlzKwgXVaMhwMPEmsw+9Q/2SbY0TGOrdXi53pgJ4PNCATzxx4NhZV
	 /ln6YJKmK8tzA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uosj0-000000013eE-42AN;
	Wed, 20 Aug 2025 20:00:14 -0400
Message-ID: <20250821000014.815252249@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 20:00:04 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [for-linus][PATCH 4/6] ring-buffer: Remove redundant semicolons
References: <20250821000000.210778097@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Liao Yuanhong <liaoyuanhong@vivo.com>

Remove unnecessary semicolons.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250813095114.559530-1-liaoyuanhong@vivo.com
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bb71a0dc9d69..43460949ad3f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7666,7 +7666,7 @@ static __init int test_ringbuffer(void)
 	rb_test_started = true;
 
 	set_current_state(TASK_INTERRUPTIBLE);
-	/* Just run for 10 seconds */;
+	/* Just run for 10 seconds */
 	schedule_timeout(10 * HZ);
 
 	kthread_stop(rb_hammer);
-- 
2.50.1



