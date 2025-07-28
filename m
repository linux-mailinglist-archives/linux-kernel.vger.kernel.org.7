Return-Path: <linux-kernel+bounces-748534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23389B14258
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAE03BEBD9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C49277011;
	Mon, 28 Jul 2025 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXODDJhN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A3A20FAAB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729402; cv=none; b=iPN8SRrvrZiJCXvLQcYAnrtHgoU6PqVud/FC8cFvOfVLrrfHzk6cMTI+79Frg8ov2IctDL7fcYCyM2ZdGLf4+9KzYZpc1VGHm/7+MXYyexTkVuFVLAKcS0FpPlZSQP5KtdbRaNb1564jcbjS4QlBAw/H+2MfHXRZoBxW6a6gD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729402; c=relaxed/simple;
	bh=K/vpleOwo0xbWOIO6pp9cSE9UAy6Q+60HYzKJZmEMGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+RRzohSOn7xOWh6sxWlyusiQ15B00KJeX0WJwivGVoyiNVTzmK27B4fYYzk1PqPh0cUl98FwjFwbgHaV79+V0vqSwlYv7rYGrpgl+f2FYSh3E9Zr/0VRlSDE2pug6kyY9CRbRaFo1rkFgdzGjq1YLrgCHou/X62sofVMB2uvis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXODDJhN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753729399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o8KYtns/52WNChA2OdVFuhj45qhIjxevu6bRzkjJVdU=;
	b=DXODDJhNe7x0mIPtqvUAChoHKMzghG4WuIXQnnvRYI2ZX/VpvSLeuku0mivw99lTMluXBb
	RCFaczfuvXGwxkFZ+8HcetY7TfuPb02BDdUTXwnzTYuPJ8GkOPUd4WfXNCHpyweMgz1R5h
	v0+dav9ANxpry4ueKuXQ6A5PI2HniBM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-x4zQ7z2HNrONl-LZxjCPUQ-1; Mon,
 28 Jul 2025 15:03:15 -0400
X-MC-Unique: x4zQ7z2HNrONl-LZxjCPUQ-1
X-Mimecast-MFC-AGG-ID: x4zQ7z2HNrONl-LZxjCPUQ_1753729394
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A292195609E;
	Mon, 28 Jul 2025 19:03:13 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.41])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14EBF1955F16;
	Mon, 28 Jul 2025 19:03:11 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/kmemleak: Avoid soft lockup in __kmemleak_do_cleanup()
Date: Mon, 28 Jul 2025 15:02:48 -0400
Message-ID: <20250728190248.605750-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A soft lockup warning was observed on a relative small system x86-64
system with 16 GB of memory when running a debug kernel with kmemleak
enabled.

  watchdog: BUG: soft lockup - CPU#8 stuck for 33s! [kworker/8:1:134]

The test system was running a workload with hot unplug happening
in parallel. Then kemleak decided to disable itself due to its
inability to allocate more kmemleak objects. The debug kernel has its
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE set to 40,000.

The soft lockup happened in kmemleak_do_cleanup() when the existing
kmemleak objects were being removed and deleted one-by-one in a loop
via a workqueue. In this particular case, there are at least 40,000
objects that need to be processed and given the slowness of a debug
kernel and the fact that a raw_spinlock has to be acquired and released
in __delete_object(), it could take a while to properly handle all
these objects.

As kmemleak has been disabled in this case, the object removal and
deletion process can be further optimized as locking isn't really
needed. However, it is probably not worth the effort to optimize for
such an edge case that should rarely happen. So the simple solution is
to call cond_resched() at periodic interval in the iteration loop to
avoid soft lockup.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kmemleak.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 8d588e685311..620abd95e680 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -2181,6 +2181,7 @@ static const struct file_operations kmemleak_fops = {
 static void __kmemleak_do_cleanup(void)
 {
 	struct kmemleak_object *object, *tmp;
+	unsigned int cnt = 0;
 
 	/*
 	 * Kmemleak has already been disabled, no need for RCU list traversal
@@ -2189,6 +2190,10 @@ static void __kmemleak_do_cleanup(void)
 	list_for_each_entry_safe(object, tmp, &object_list, object_list) {
 		__remove_object(object);
 		__delete_object(object);
+
+		/* Call cond_resched() once per 64 iterations to avoid soft lockup */
+		if (!(++cnt & 0x3f))
+			cond_resched();
 	}
 }
 
-- 
2.50.0


