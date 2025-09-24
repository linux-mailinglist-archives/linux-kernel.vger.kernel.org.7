Return-Path: <linux-kernel+bounces-830095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD89B98BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2AC19C7A03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7B3280CD5;
	Wed, 24 Sep 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LTBbQHBa"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA726E6FA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701017; cv=none; b=PrmNAOqfQf0l+dmI/0SiVuQdDK8NDWd75tz2BFfLAankVeiHO0bNS3ifBpPMImnvjNSuZw6Nv/tTckQC+llbkXKNajGuMlu4y8SX5HHdYqTsEfDW/5qx5YuP/gnbqnyMrIa8eO2tjqkldOSN/6+YTMqpAyhnw6svP9sYpbDtnXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701017; c=relaxed/simple;
	bh=uugCYR/RyKJ2k19QOGAnWn+PMaQlWlHjUIns+kfsIpI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=miH2ixQWB23G5JL6/Uo11zKB2Bk01tA07WqaJy6UwJJnXg8PkprGZ04N8lNsZCBsL3JaV7VB9rFF0wJEygJ5BMO9qHR/GVYcmPsd/n4DiGs8BoQCQHgnXprw+2cadreSdJvbi/lTtY40CftrDAxI3zpE5JGoczztW56onKeKgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LTBbQHBa; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=pxgFIlR99iKm/nP/htLTylf5qVEen9HVPfiXmpXzK2U=; b=LTBbQHBajmiQjw5RZvYIj5FwKY
	HBXs5IJ69wMbipt/tzIzQet+2tQH4Hx690q8azASZAavzMRqsQIeKyZIMSNOhGnrLfiyz4m5WvVoP
	mSV49PXmkNZg9qFUU+yNOGwf94t1a2zWioC89RgciRFrlz+hxcNann5MO0QVdDGN9rUKNc4tQbOIN
	b7SIMTmdQ7m/m0j8VRMn2GhzbiwDY7x1qIJvuXIk679ho5hDJOp7BI4FzGdA9RVspFNfgnfXLU69d
	UpnjJ0ibMVwi8T9aqwAzd8buyyoTjFx+a7Dsyk8r2WPucF6ROeSAasbQuEjSsaMX0SNDel6jR3uBU
	orrBoHew==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KTN-00000008iAz-1yRB;
	Wed, 24 Sep 2025 08:03:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 05DFD302D64; Wed, 24 Sep 2025 10:03:33 +0200 (CEST)
Message-ID: <20250924080118.545274393@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 09:59:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 rostedt@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 02/12] unwind: Shorten lines
References: <20250924075948.579302904@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

There are some exceptionally long lines that cause ugly wrapping.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/unwind_deferred.h |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -8,7 +8,9 @@
 
 struct unwind_work;
 
-typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 cookie);
+typedef void (*unwind_callback_t)(struct unwind_work *work,
+				  struct unwind_stacktrace *trace,
+				  u64 cookie);
 
 struct unwind_work {
 	struct list_head		list;
@@ -68,9 +70,17 @@ static __always_inline void unwind_reset
 static inline void unwind_task_init(struct task_struct *task) {}
 static inline void unwind_task_free(struct task_struct *task) {}
 
-static inline int unwind_user_faultable(struct unwind_stacktrace *trace) { return -ENOSYS; }
-static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) { return -ENOSYS; }
-static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp) { return -ENOSYS; }
+static inline int unwind_user_faultable(struct unwind_stacktrace *trace)
+{ return -ENOSYS; }
+
+static inline int
+unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
+{ return -ENOSYS; }
+
+static inline int
+unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
+{ return -ENOSYS; }
+
 static inline void unwind_deferred_cancel(struct unwind_work *work) {}
 
 static inline void unwind_deferred_task_exit(struct task_struct *task) {}



