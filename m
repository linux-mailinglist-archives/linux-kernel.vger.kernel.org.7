Return-Path: <linux-kernel+bounces-839076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 603CDBB0C32
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3232189EA42
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C30265CC5;
	Wed,  1 Oct 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqh1FgOb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481125A2DA
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329887; cv=none; b=XOLZxgQs5PGW0KlEz04wEyak/R3q55ckWjUGddaidap0zS5U02WGhvOvRtzSqJZygZ4TtVGahE4mgU+GiX0xrlq3tucjWq9VXGIBwGhswvtdmdVqtCIsHpYjqquG7MjOi5dusI6l55wwm0lrpqo/1v95WzkcsCZPk2wntI3SXS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329887; c=relaxed/simple;
	bh=yoGmDx/v4nE8xibyMba8/+vzc91noL0eEzIdfq0Cjok=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oabX16cCycGSQDD4f5Y6jJ+ePWfYbxcTd9jNkWddMBhUovMQ+SmuxgItXiX61CCSpFBfchToxKVh8ox6J63wOU+EDBmza9xu2mwkImS0IVIvuK1F2p5LeZtHQ09tt9T3Mk5i/OcC8q5nldhAv4QpP/gZ/+lzvxgJNKI7ewj8Lj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqh1FgOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AADC4CEF9;
	Wed,  1 Oct 2025 14:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759329886;
	bh=yoGmDx/v4nE8xibyMba8/+vzc91noL0eEzIdfq0Cjok=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Nqh1FgObuv2Myiy1NXzfnoKssbxwgpQ6l9V7/8VBz6gL2oc+zn6ahlNBXPJ/6QYG8
	 qtkaMDFK26ZtipxhDTqUHnOoni3oTnMMFYlzoelobRsacW4W112cYMEH5XV+C/l5Z6
	 erc95zRKbludQPyseJpE/0wD3PvKT4ldLEdg3Pe79f17ybXccdCfjJJfdJBFurfHag
	 m5pzeakq4AJWatiKxGTH+bmEaeeZJQ1IeDZtwx8SAdXJM6WsNJpx4BIA2G+Ba/J3g+
	 CaGfNTii8wOBcIjoy5Xe9i48WxyRTFdfGe6GuAcBhfbJ1M+hU7f3OpPCMSswYXs839
	 0sJjO44oNSn3w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3y65-0000000Eb0p-05j5;
	Wed, 01 Oct 2025 10:46:25 -0400
Message-ID: <20251001144624.872816481@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 01 Oct 2025 10:46:06 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [for-next][PATCH 1/4] cdns2: Remove unused tracepoints
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

Remove the unused tracepoints of the cdns2 subsystem. They are:

cdns2_ep0_enqueue
cdns2_ep0_set_config
cdns2_ep_queue
cdns2_iso_out_ep_disable
cdns2_lpm
cdns2_mapped_request
cdns2_map_request
cdns2_may_wakeup

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Chen <peter.chen@kernel.org>
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/20250829015649.885512884@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/usb/gadget/udc/cdns2/cdns2-trace.h | 69 ----------------------
 1 file changed, 69 deletions(-)

diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-trace.h b/drivers/usb/gadget/udc/cdns2/cdns2-trace.h
index ade1752956b1..f4df0e2ff853 100644
--- a/drivers/usb/gadget/udc/cdns2/cdns2-trace.h
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-trace.h
@@ -47,16 +47,6 @@ DEFINE_EVENT(cdns2_log_enable_disable, cdns2_pullup,
 	TP_ARGS(set)
 );
 
-DEFINE_EVENT(cdns2_log_enable_disable, cdns2_lpm,
-	TP_PROTO(int set),
-	TP_ARGS(set)
-);
-
-DEFINE_EVENT(cdns2_log_enable_disable, cdns2_may_wakeup,
-	TP_PROTO(int set),
-	TP_ARGS(set)
-);
-
 DECLARE_EVENT_CLASS(cdns2_log_simple,
 	TP_PROTO(char *msg),
 	TP_ARGS(msg),
@@ -79,11 +69,6 @@ DEFINE_EVENT(cdns2_log_simple, cdns2_ep0_status_stage,
 	TP_ARGS(msg)
 );
 
-DEFINE_EVENT(cdns2_log_simple, cdns2_ep0_set_config,
-	TP_PROTO(char *msg),
-	TP_ARGS(msg)
-);
-
 DEFINE_EVENT(cdns2_log_simple, cdns2_ep0_setup,
 	TP_PROTO(char *msg),
 	TP_ARGS(msg)
@@ -340,11 +325,6 @@ DEFINE_EVENT(cdns2_log_request, cdns2_free_request,
 	TP_ARGS(preq)
 );
 
-DEFINE_EVENT(cdns2_log_request, cdns2_ep_queue,
-	TP_PROTO(struct cdns2_request *preq),
-	TP_ARGS(preq)
-);
-
 DEFINE_EVENT(cdns2_log_request, cdns2_request_dequeue,
 	TP_PROTO(struct cdns2_request *preq),
 	TP_ARGS(preq)
@@ -355,50 +335,6 @@ DEFINE_EVENT(cdns2_log_request, cdns2_request_giveback,
 	TP_ARGS(preq)
 );
 
-TRACE_EVENT(cdns2_ep0_enqueue,
-	TP_PROTO(struct cdns2_device *dev_priv, struct usb_request *request),
-	TP_ARGS(dev_priv, request),
-	TP_STRUCT__entry(
-		__field(int, dir)
-		__field(int, length)
-	),
-	TP_fast_assign(
-		__entry->dir = dev_priv->eps[0].dir;
-		__entry->length = request->length;
-	),
-	TP_printk("Queue to ep0%s length: %u", __entry->dir ? "in" : "out",
-		  __entry->length)
-);
-
-DECLARE_EVENT_CLASS(cdns2_log_map_request,
-	TP_PROTO(struct cdns2_request *priv_req),
-	TP_ARGS(priv_req),
-	TP_STRUCT__entry(
-		__string(name, priv_req->pep->name)
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
-
-DEFINE_EVENT(cdns2_log_map_request, cdns2_map_request,
-	     TP_PROTO(struct cdns2_request *req),
-	     TP_ARGS(req)
-);
-DEFINE_EVENT(cdns2_log_map_request, cdns2_mapped_request,
-	     TP_PROTO(struct cdns2_request *req),
-	     TP_ARGS(req)
-);
-
 DECLARE_EVENT_CLASS(cdns2_log_trb,
 	TP_PROTO(struct cdns2_endpoint *pep, struct cdns2_trb *trb),
 	TP_ARGS(pep, trb),
@@ -507,11 +443,6 @@ DEFINE_EVENT(cdns2_log_ep, cdns2_gadget_ep_disable,
 	TP_ARGS(pep)
 );
 
-DEFINE_EVENT(cdns2_log_ep, cdns2_iso_out_ep_disable,
-	TP_PROTO(struct cdns2_endpoint *pep),
-	TP_ARGS(pep)
-);
-
 DEFINE_EVENT(cdns2_log_ep, cdns2_ep_busy_try_halt_again,
 	TP_PROTO(struct cdns2_endpoint *pep),
 	TP_ARGS(pep)
-- 
2.50.1



