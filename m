Return-Path: <linux-kernel+bounces-839079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEE4BB0C39
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B312A0EB0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621FA26E158;
	Wed,  1 Oct 2025 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUIMsjph"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D3B263C8F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329887; cv=none; b=kYwg5uTolMq7/Mk5AL1s8/432nH4e+WhHQwAL5VREJbxhle9LiI8CZhWeJMEwRuKDGZFeBA2ymYTnyceAUJB2ajflJZCUuCTt1SZnGOGPaHWCm2nb9kurcJOQkjyVsIwLeAIfXS1qEqiN4Dmv79GUThZ7WIqMjxgyVQdyAY1WP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329887; c=relaxed/simple;
	bh=jOPzT5I/kOpIi5ZDlNve+VUJwoXKhTghbF0PkthdSO0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CqtcBQ1R/mhB2jKoTlfqcTNKLZjNv728dRe858u0pfir9WPEfXg3TqBobNF0VVrDHuB369gekkOcEYXQoN7R1vUeCuQNyBh0adF8iJ8VJczhw/bItZGnYxiwlZI1H6JSW3fzqWUTy9+e8iWFEZNdUacXpSojRzLC9CVrlgFXcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUIMsjph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46670C4CEF5;
	Wed,  1 Oct 2025 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759329887;
	bh=jOPzT5I/kOpIi5ZDlNve+VUJwoXKhTghbF0PkthdSO0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=tUIMsjphkZNzHZW+KyQX92WWp76zbTsK4kB1DXEV/Yh7Hw6IkSaf3xOhEojzQmWTo
	 ZfHjV3B9jiLaL4Myv4mKczaLG+kNPBHTcccVuZKZ9wni5AAoh5CiV03tTRcFIJfIYp
	 1JYFt8YzzGG+66k2Lv1EADqKMzdmIFvhoSjA3zh+jgnjOxP4zFn3JXMgkcN8bUfuQE
	 4TlM7DQY/2lVPgqow7fiV4TPza0aGrNcl1T3n4kbIsdkQemKZaJO9Ki06fq4R7xW/n
	 sm1tuTceBQGthuhpMmMqsBvKjmPH6LYXKoJCG92OpSvylLbu5/fqh4RW1mXfwj18Y8
	 v+PEQTQ9fmRtQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3y65-0000000Eb1p-1UBo;
	Wed, 01 Oct 2025 10:46:25 -0400
Message-ID: <20251001144625.211170221@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 01 Oct 2025 10:46:08 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter Chen <peter.chen@kernel.org>
Subject: [for-next][PATCH 3/4] cdnsp: Remove unused tracepoints
References: <20251001144605.585204794@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Tracepoints that are defined take up around 5K each, even if they are not
used. If they are defined and not used, then they waste memory for unused
code. Soon unused tracepoints will cause warnings.

Remove the unused tracepoints of the cdnsp subsystem. They are:

cdnsp_defered_event
cdnsp_ep0_halted
cdnsp_free_priv_device
cdnsp_handle_cmd_flush_ep

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/20250829015650.224063821@kernel.org
Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/usb/cdns3/cdnsp-trace.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-trace.h b/drivers/usb/cdns3/cdnsp-trace.h
index f2bcf77a5d0a..9b33a736c3de 100644
--- a/drivers/usb/cdns3/cdnsp-trace.h
+++ b/drivers/usb/cdns3/cdnsp-trace.h
@@ -178,11 +178,6 @@ DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_set_config,
 	TP_ARGS(msg)
 );
 
-DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_halted,
-	TP_PROTO(char *msg),
-	TP_ARGS(msg)
-);
-
 DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep_halt,
 	TP_PROTO(char *msg),
 	TP_ARGS(msg)
@@ -399,11 +394,6 @@ DEFINE_EVENT(cdnsp_log_trb, cdnsp_cmd_timeout,
 	TP_ARGS(ring, trb)
 );
 
-DEFINE_EVENT(cdnsp_log_trb, cdnsp_defered_event,
-	TP_PROTO(struct cdnsp_ring *ring, struct cdnsp_generic_trb *trb),
-	TP_ARGS(ring, trb)
-);
-
 DECLARE_EVENT_CLASS(cdnsp_log_pdev,
 	TP_PROTO(struct cdnsp_device *pdev),
 	TP_ARGS(pdev),
@@ -433,16 +423,6 @@ DEFINE_EVENT(cdnsp_log_pdev, cdnsp_alloc_priv_device,
 	TP_ARGS(vdev)
 );
 
-DEFINE_EVENT(cdnsp_log_pdev, cdnsp_free_priv_device,
-	TP_PROTO(struct cdnsp_device *vdev),
-	TP_ARGS(vdev)
-);
-
-DEFINE_EVENT(cdnsp_log_pdev, cdnsp_setup_device,
-	TP_PROTO(struct cdnsp_device *vdev),
-	TP_ARGS(vdev)
-);
-
 DEFINE_EVENT(cdnsp_log_pdev, cdnsp_setup_addressable_priv_device,
 	TP_PROTO(struct cdnsp_device *vdev),
 	TP_ARGS(vdev)
@@ -575,11 +555,6 @@ DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_stop_ep,
 	TP_ARGS(ctx)
 );
 
-DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_flush_ep,
-	TP_PROTO(struct cdnsp_ep_ctx *ctx),
-	TP_ARGS(ctx)
-);
-
 DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_set_deq_ep,
 	TP_PROTO(struct cdnsp_ep_ctx *ctx),
 	TP_ARGS(ctx)
-- 
2.50.1



