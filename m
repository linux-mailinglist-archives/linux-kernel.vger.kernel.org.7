Return-Path: <linux-kernel+bounces-784715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BEAB34036
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFE5189D340
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CF523E359;
	Mon, 25 Aug 2025 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIeiA0dD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9576B1E6DC5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126789; cv=none; b=Qhr2WzGO/aF3/xI/svCnM7wsQu2I4M4ah8HTqiKR/F5Zh2oh++akFrSfmWUYE4LeAFPplwT1e0CmyQQ4F8fk8p0Hdau3Xf3CJHugfcs9XMc5DyJN+spl7/YTuYo+PNSkvyRTs92yQAg9GsZcNt9sBdoLaMuHkFH+5CiOJg+7x9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126789; c=relaxed/simple;
	bh=iGF3Ty+r7ofrqLuDIz+M4/R+aLKluW2Zd4ZasASSJss=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WTHFaFxYdKBFXBy6RITzWCQZdYUv+QUaJmUDhTByY5UE77cv8Js90q8fVC4dQw78vFakqKotrpFD/Jb3bHKZJ7JLP6sc3ZybkSnnd7CLWqWKmXJQiCivh9UOWcvcAn9t1A67kHScOPX2QNDS+Sy4CUxqwRS1UFCK5f1LaHvd0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIeiA0dD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756126786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jJKCjDL06Zvlad/zq74VP/8/pkLusWhDPD7bZSNNC80=;
	b=JIeiA0dDGRsDF6R26o+66ldnzS4kr2X3x7oxZmXK7g0QHhG5d6VpEol026LBmQBsvC901D
	qcltQD9hyP8wZETx3HKSH3Ks3GMjfYTo4zHwN53SZ9hpHfIW+CXqeEhc+Irj8SqtiXVQ89
	mvtmZv6vKIdTN2SYnNRSBojqqaWFHgo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-UWYJL6GsMfavtmYJJV1Lgg-1; Mon,
 25 Aug 2025 08:59:41 -0400
X-MC-Unique: UWYJL6GsMfavtmYJJV1Lgg-1
X-Mimecast-MFC-AGG-ID: UWYJL6GsMfavtmYJJV1Lgg_1756126780
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1C30180036E;
	Mon, 25 Aug 2025 12:59:39 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.151])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66C951955F24;
	Mon, 25 Aug 2025 12:59:35 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [RESEND PATCH] kmem/tracing: Add kmem name to kmem_cache_alloc tracepoint
Date: Mon, 25 Aug 2025 09:59:26 -0300
Message-ID: <20250825125927.59816-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The kmem_cache_free tracepoint includes a "name" field, which allows
for easy identification and filtering of specific kmem's. However, the
kmem_cache_alloc tracepoint lacks this field, making it difficult to
pair corresponding alloc and free events for analysis.

Add the "name" field to kmem_cache_alloc to enable consistent tracking
and correlation of kmem alloc and free events.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 include/trace/events/kmem.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 474358773abe..7f93e754da5c 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -22,6 +22,7 @@ TRACE_EVENT(kmem_cache_alloc,
 	TP_STRUCT__entry(
 		__field(	unsigned long,	call_site	)
 		__field(	const void *,	ptr		)
+		__string(	name,		s->name		)
 		__field(	size_t,		bytes_req	)
 		__field(	size_t,		bytes_alloc	)
 		__field(	unsigned long,	gfp_flags	)
@@ -32,6 +33,7 @@ TRACE_EVENT(kmem_cache_alloc,
 	TP_fast_assign(
 		__entry->call_site	= call_site;
 		__entry->ptr		= ptr;
+		__assign_str(name);
 		__entry->bytes_req	= s->object_size;
 		__entry->bytes_alloc	= s->size;
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
@@ -41,9 +43,10 @@ TRACE_EVENT(kmem_cache_alloc,
 					  (s->flags & SLAB_ACCOUNT)) : false;
 	),
 
-	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
+	TP_printk("call_site=%pS ptr=%p name=%s bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
 		(void *)__entry->call_site,
 		__entry->ptr,
+		__get_str(name),
 		__entry->bytes_req,
 		__entry->bytes_alloc,
 		show_gfp_flags(__entry->gfp_flags),
-- 
2.51.0


