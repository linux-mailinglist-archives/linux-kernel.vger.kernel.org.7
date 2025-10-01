Return-Path: <linux-kernel+bounces-839078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135BCBB0C35
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BF84A1FA6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F7267F58;
	Wed,  1 Oct 2025 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMsJDUcB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF226056E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329887; cv=none; b=kFe6sqDWnFNTWuEWzQeuiTEb5su6E4F3uyDKWkFcyO3nAUlaEpttn/rMegjZKFfDsz0PO5P/tuSGNwIb8jXPR8+opeqD+NVRAI4mWNWQHQKUa7T/xciCBgnoT55DNnAswlXJ1biGcmqQ4a9+mrRbQkhHmss5ZzHRtC6yRzoenSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329887; c=relaxed/simple;
	bh=gJwAC0Z43K6okq+Vy24UVKtqK2iCFO8dnqoBQpWWlok=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ibbocblFHZTe6XuedRlm4NRNWVNfuMnGHKiYoY1go6WFxVLdjAW5943ysgHEPC0JLqkZkwQnXgSxe8KJrc1ZOTREo9EpV016nILP4XgeenIQN9rlCQvYtUXear88fawq73XF2uLpT0y7bwmuRmCt/ogXscySag3WU6MLDBJUDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMsJDUcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC5CC4CEFC;
	Wed,  1 Oct 2025 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759329887;
	bh=gJwAC0Z43K6okq+Vy24UVKtqK2iCFO8dnqoBQpWWlok=;
	h=Date:From:To:Cc:Subject:References:From;
	b=XMsJDUcBgDxM2HmyHh8/FaxqIQ2vw4ITQQ2lmoZesC4cIErp5Rj1GAKuus5iImnE5
	 WtPaJ52ZWkUjMFlS484LKPlCexXi5QGLRtEbutbDvAtBa9KfZZVW8shkbr1s33OwYD
	 e+9mxfL0TEPKRsnBVwgs5DzTdlUaYXBSVxniBteIp3y4pdmLweCPPL/cC/DtkI1o2y
	 d5Fp0zrLf752zDHNN19RKJ8mlFGkIMLIlLYUdWcuDgXT+GE0pxHq8fQsVKKC5X3ATN
	 nKj18Obbs/E2AFWflAios9bbpTrWgiJQj4d8d7yIhMRSerbyDO6uebCpQeEQgsBU17
	 931fUyUKZnipQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3y65-0000000Eb1K-0ni6;
	Wed, 01 Oct 2025 10:46:25 -0400
Message-ID: <20251001144625.041876798@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 01 Oct 2025 10:46:07 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter Chen <peter.chen@kernel.org>
Subject: [for-next][PATCH 2/4] cdns3: Remove unused tracepoints
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

Remove the unused tracepoints of the cdns3 subsystem. They are:
cdns3_mapped_request
cdns3_map_request
cdns3_stream_transfer_split
cdns3_stream_transfer_split_next_part

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/20250829015650.053498355@kernel.org
Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/usb/cdns3/cdns3-trace.h | 61 ---------------------------------
 1 file changed, 61 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-trace.h b/drivers/usb/cdns3/cdns3-trace.h
index c4e542f1b9b7..21a6a2ce7a3d 100644
--- a/drivers/usb/cdns3/cdns3-trace.h
+++ b/drivers/usb/cdns3/cdns3-trace.h
@@ -283,39 +283,6 @@ TRACE_EVENT(cdns3_ep0_queue,
 		  __entry->length)
 );
 
-DECLARE_EVENT_CLASS(cdns3_stream_split_transfer_len,
-	TP_PROTO(struct cdns3_request *req),
-	TP_ARGS(req),
-	TP_STRUCT__entry(
-		__string(name, req->priv_ep->name)
-		__field(struct cdns3_request *, req)
-		__field(unsigned int, length)
-		__field(unsigned int, actual)
-		__field(unsigned int, stream_id)
-	),
-	TP_fast_assign(
-		__assign_str(name);
-		__entry->req = req;
-		__entry->actual = req->request.length;
-		__entry->length = req->request.actual;
-		__entry->stream_id = req->request.stream_id;
-	),
-	TP_printk("%s: req: %p,request length: %u actual length: %u  SID: %u",
-		  __get_str(name), __entry->req, __entry->length,
-		  __entry->actual, __entry->stream_id)
-);
-
-DEFINE_EVENT(cdns3_stream_split_transfer_len, cdns3_stream_transfer_split,
-	     TP_PROTO(struct cdns3_request *req),
-	     TP_ARGS(req)
-);
-
-DEFINE_EVENT(cdns3_stream_split_transfer_len,
-	     cdns3_stream_transfer_split_next_part,
-	     TP_PROTO(struct cdns3_request *req),
-	     TP_ARGS(req)
-);
-
 DECLARE_EVENT_CLASS(cdns3_log_aligned_request,
 	TP_PROTO(struct cdns3_request *priv_req),
 	TP_ARGS(priv_req),
@@ -354,34 +321,6 @@ DEFINE_EVENT(cdns3_log_aligned_request, cdns3_prepare_aligned_request,
 	TP_ARGS(req)
 );
 
-DECLARE_EVENT_CLASS(cdns3_log_map_request,
-	TP_PROTO(struct cdns3_request *priv_req),
-	TP_ARGS(priv_req),
-	TP_STRUCT__entry(
-		__string(name, priv_req->priv_ep->name)
-		__field(struct usb_request *, req)
-		__field(void *, buf)
-		__field(dma_addr_t, dma)
-	),
-	TP_fast_assign(
-		__assign_str(name);
-		__entry->req = &priv_req->request;
-		__entry->buf = priv_req->request.buf;
-		__entry->dma = priv_req->request.dma;
-	),
-	TP_printk("%s: req: %p, req buf %p, dma %p",
-		  __get_str(name), __entry->req, __entry->buf, &__entry->dma
-	)
-);
-DEFINE_EVENT(cdns3_log_map_request, cdns3_map_request,
-	     TP_PROTO(struct cdns3_request *req),
-	     TP_ARGS(req)
-);
-DEFINE_EVENT(cdns3_log_map_request, cdns3_mapped_request,
-	     TP_PROTO(struct cdns3_request *req),
-	     TP_ARGS(req)
-);
-
 DECLARE_EVENT_CLASS(cdns3_log_trb,
 	TP_PROTO(struct cdns3_endpoint *priv_ep, struct cdns3_trb *trb),
 	TP_ARGS(priv_ep, trb),
-- 
2.50.1



