Return-Path: <linux-kernel+bounces-889395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B77C3D737
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4055B4E7D78
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7843D305E05;
	Thu,  6 Nov 2025 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ua1DRkgw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AF3043A4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463038; cv=none; b=Q8MYUq9JPWdtDPtJtqsU3+cCAcVT5+GioVREmwLy8XIzxDBR2BHZoSpevbrZ7LeeP1ieK14u4Wf2XUbim6FZ/ONuTVhAFmZLk9k4zcEtI/dtUZ19kDlLkLjjoD7uBs6b16eqLmn3qSjLdCqF85wF5MFpQTEv74RVQ9j1timNNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463038; c=relaxed/simple;
	bh=kxKIMXudkZCzlyuZLzwoFaEjX0gvyg5owrHhnIlfGU8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uQnv8cdYMgQdnJgAh7PFTNsPUE0C/2peRAMC6eOp21ZMI2G/fJh5RVkxZnInHh/RQk8inAms3qVFzj+9hpAvU+2CQsEqFDPU1VcEGRWLR/pmxqyXhKgaXt2PTJ+0JupJZytJIyipKlePO373/Dm0PFmCB4cmfsw6p4v5BmVNDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ua1DRkgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B260C4CEF7;
	Thu,  6 Nov 2025 21:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762463038;
	bh=kxKIMXudkZCzlyuZLzwoFaEjX0gvyg5owrHhnIlfGU8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ua1DRkgw5DivVxn9EMW56PtLWgParjmu3I/EEQebC0Is2Tn0hV5s+iuVktd59fOYD
	 APFKJzu6vlmnwGGDkvreQyivPYPVmLXmMb+YUxD28k8cDpcVJZsd7j8yr8Ps+UVaQQ
	 xr9Fm0GM+2zi9q4CPhOBNDKXPMIP2t77Yh/muyLtEPgIHstVklqJV7qQW5cZoRoCBu
	 cWww9gGsSGbPuzB+L3l/IKGcxnbM8CwNxafYvIFZFoGH0Bz1x6RPppfvFyRc8YBAy4
	 clrIkK5+IPjWrI9gomVpcqllGqg9eC25/yqO0eNUJ1q4XbZZKAGifP+ZWIPHQyS0cE
	 YY5vu4axwuqmw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vH79B-000000008Do-45rj;
	Thu, 06 Nov 2025 16:03:57 -0500
Message-ID: <20251106210357.828237507@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 06 Nov 2025 16:03:37 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 6/7] tracing: Exit out immediately after update_marker_trace()
References: <20251106210331.537317097@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The call to update_marker_trace() in set_tracer_flag() performs the update
to the tr->trace_flags. There's no reason to perform it again after it is
called. Return immediately instead.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://patch.msgid.link/20251106003501.726406870@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ed929d331e1d..88234b541b09 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5254,8 +5254,11 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 		}
 	}
 
-	if (mask == TRACE_ITER(COPY_MARKER))
+	if (mask == TRACE_ITER(COPY_MARKER)) {
 		update_marker_trace(tr, enabled);
+		/* update_marker_trace updates the tr->trace_flags */
+		return 0;
+	}
 
 	if (enabled)
 		tr->trace_flags |= mask;
-- 
2.51.0



