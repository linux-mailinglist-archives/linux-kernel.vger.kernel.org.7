Return-Path: <linux-kernel+bounces-758085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85614B1CAA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1365118C4865
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948FB2BCF5C;
	Wed,  6 Aug 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+hzPkmO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275229E0EC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501100; cv=none; b=FdkNvuB1ExXyfBP1icMxKmEwYd7rlSatabohoDanBUU4+Fi5ZlUkoxJaAxVx/NjnC0zDwjpnk2VhvuQsuNhAEkyZ5AGCZD0wh8T3IgH2hIGgWosWbDVQwasx9ne+mcJsdxydpY9b2vx14Ckhdaf+JsqW9myonuAG/LbJkqclef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501100; c=relaxed/simple;
	bh=0Wm3Xoa5XLpfnubHs0aZbiFooFp3j7Dx1L7hNmkFDnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9xkNuQA6JOTeiYXh95L0H9E7eDCRZq5I/CYQEvQojThl6SMnZC1+NpsnSUdILqFmi47ZkmwWI99jyk0sCjwZwhlW7QP7Q68CWuvZMgHcG/vbCXOAcWN1tI+Gen8MgKxpGEZ/Xndlik+BRJrE5wdAHNCLVHLfsBkVPEVQlNt6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+hzPkmO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754501097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbFZQJRVLoxgj3cfMwEHUAeK89Crfm/u3SMh3N/Z9KU=;
	b=W+hzPkmO4dktOS0/fBiWcGfzeNZvmeBUHk/GOOtTLQoA++lqf9MW8vC8iQHnALqxRaXymY
	gN1ooa/kTqQoGwb89EEwdHwo57axBZbKvSCjZdY76wChxInJ2HCqLkHttN5KAvTiar552N
	nZ9SPgK/qNi3A+Ru/levAQVCbCg1Pas=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-QyY7T9WjNmea-5KmOlD25w-1; Wed,
 06 Aug 2025 13:24:54 -0400
X-MC-Unique: QyY7T9WjNmea-5KmOlD25w-1
X-Mimecast-MFC-AGG-ID: QyY7T9WjNmea-5KmOlD25w_1754501093
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B187218002C6;
	Wed,  6 Aug 2025 17:24:52 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E329B30001A6;
	Wed,  6 Aug 2025 17:24:50 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 3/3] cgroup/cpuset: Remove the unnecessary css_get/put() in cpuset_partition_write()
Date: Wed,  6 Aug 2025 13:24:30 -0400
Message-ID: <20250806172430.1155133-4-longman@redhat.com>
In-Reply-To: <20250806172430.1155133-1-longman@redhat.com>
References: <20250806172430.1155133-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The css_get/put() calls in cpuset_partition_write() are unnecessary as
an active reference of the kernfs node will be taken which will prevent
its removal and guarantee the existence of the css. Only the online
check is needed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d993e058a663..27adb04df675 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3358,14 +3358,12 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
 	else
 		return -EINVAL;
 
-	css_get(&cs->css);
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
 	if (is_cpuset_online(cs))
 		retval = update_prstate(cs, val);
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
-	css_put(&cs->css);
 	return retval ?: nbytes;
 }
 
-- 
2.50.0


