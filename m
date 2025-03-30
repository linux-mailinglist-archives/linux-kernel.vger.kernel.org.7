Return-Path: <linux-kernel+bounces-581281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42572A75CE8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 23:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED41D167DDE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 21:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5D41DF25C;
	Sun, 30 Mar 2025 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HP5fKSlr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533F1E2823
	for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371645; cv=none; b=SPWMwSIYgNUEFmKVazPUJVeVooP1vLcbxDO9kBj/A7lEQ8AUTR8CkhYWHl/xC5qWnlGsTkZr8bv0xzTrsqRMV6EcLeqVAA3AGDKglaTaN8c9JsuLaI9lO/IFjWu+ktDBzz6OOfEJstfBAvjSxsZ1JK8kH1Q7/eeAtqfHQKBKTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371645; c=relaxed/simple;
	bh=stscICFifwoUqJQJWiTNHJ0+TBc9ug/dKZdkyIhs3j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezDSM+8Xoqb2Je+brI2WrDgKPdWIhbWvllTtXdmuCrv0LPL0JwIlX6UMKy6QH5z75sHdRgOF6i0gsW8d5rZDxftKMZEgSbzHByfLN96R/nBZOtsdo+BlRUZH+jXW+4DZs5/kqAUzZhd1WZX/qqZh6o32+V9iD89jsKUQJycBGxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HP5fKSlr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743371642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JwxzaAEp0Htb1fNzDI1GIEL1hkSI9BANp97CsqZ5jc=;
	b=HP5fKSlrx8g3j5comm2WDznN+VHnON4TKM4ZV3CNOlOmKTzd7AZCDD6F37nX4exuNm78s3
	9/hakpubt8xWue/enPx0VfqNfKmYXEKUPeekkFgy3Ok4NvB11Samz5/wy7SEIK7p6uPvbP
	r7pizUHMxuAt+4Jn4BH9MaAv7xCOkWU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-Rv4_vOknNpGPMAIzxA84Ew-1; Sun,
 30 Mar 2025 17:53:57 -0400
X-MC-Unique: Rv4_vOknNpGPMAIzxA84Ew-1
X-Mimecast-MFC-AGG-ID: Rv4_vOknNpGPMAIzxA84Ew_1743371635
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FAE2180034D;
	Sun, 30 Mar 2025 21:53:55 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DB831801750;
	Sun, 30 Mar 2025 21:53:53 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 07/10] cgroup/cpuset: Remove unneeded goto in sched_partition_write() and rename it
Date: Sun, 30 Mar 2025 17:52:45 -0400
Message-ID: <20250330215248.3620801-8-longman@redhat.com>
In-Reply-To: <20250330215248.3620801-1-longman@redhat.com>
References: <20250330215248.3620801-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The goto statement in sched_partition_write() is not needed. Remove
it and rename sched_partition_write()/sched_partition_show() to
cpuset_partition_write()/cpuset_partition_show().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index aa529b2dbf56..306b60430091 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3272,7 +3272,7 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	return ret;
 }
 
-static int sched_partition_show(struct seq_file *seq, void *v)
+static int cpuset_partition_show(struct seq_file *seq, void *v)
 {
 	struct cpuset *cs = css_cs(seq_css(seq));
 	const char *err, *type = NULL;
@@ -3303,7 +3303,7 @@ static int sched_partition_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
+static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
 				     size_t nbytes, loff_t off)
 {
 	struct cpuset *cs = css_cs(of_css(of));
@@ -3324,11 +3324,8 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 	css_get(&cs->css);
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
-	if (!is_cpuset_online(cs))
-		goto out_unlock;
-
-	retval = update_prstate(cs, val);
-out_unlock:
+	if (is_cpuset_online(cs))
+		retval = update_prstate(cs, val);
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	css_put(&cs->css);
@@ -3372,8 +3369,8 @@ static struct cftype dfl_files[] = {
 
 	{
 		.name = "cpus.partition",
-		.seq_show = sched_partition_show,
-		.write = sched_partition_write,
+		.seq_show = cpuset_partition_show,
+		.write = cpuset_partition_write,
 		.private = FILE_PARTITION_ROOT,
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.file_offset = offsetof(struct cpuset, partition_file),
-- 
2.48.1


