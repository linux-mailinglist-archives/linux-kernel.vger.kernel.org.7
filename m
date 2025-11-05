Return-Path: <linux-kernel+bounces-885797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECEFC33EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 05:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 715634E3214
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 04:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC133252900;
	Wed,  5 Nov 2025 04:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGjX0dwB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E01E21322F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 04:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762317556; cv=none; b=IN2PjXxAuuS0y9S8jIftu2NFqxYEyPecw4o9f9z85RPsvhT87W4IqXedrQ9xdMEnPJ3W+Uxwx3D8c7/9EwjEVaY2KwJesF6yz82BmU6riqb8D/ekxToZM/p/fmJD70kJ3Xk4ePPOEl5QGXHm2OkxnUnIoi8sj4BsVNU06kbmVfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762317556; c=relaxed/simple;
	bh=jBdpfUjY5oVJm/R/rr6Pkcxtd7obQ3s7W5lao2UczOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=owMDBmJ8qZkNpTnjWc56W8UUK8V2kzu1ofc36zD3tTUuyk3jF8lEAsVvcLo2IUl0nuSmkrTrGBp36DhMMyHWNCvu93u31T9G537wHZ/h/edKAtyxQXLb93MG4K6K5QaNeVnb5UpYrtPqgwXie9VcJjeJmFzvE6aDQyInxkWXnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGjX0dwB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762317549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hXqdp8IG/lo25QTOE3OH+t5hMdJRJkoQ3YkWCCVcabk=;
	b=DGjX0dwBtX3ebGKXJtxBe+ECvJY+cgYq7ctajN5cNFrWjTSnJ5kDNOYt73eUpw5EZOgrMj
	YN8CVPFTo6LVbOCMQAWZqj4GB3rWsbU0iBnD2bbiAtSf9dtx4/9RgG9BqFYaRp2P4/EgLQ
	3I66PliJ2JTmnT/Jz4T7eYKhjrp4E78=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-ro_9gL54OtKlrSTIdBuURA-1; Tue,
 04 Nov 2025 23:39:08 -0500
X-MC-Unique: ro_9gL54OtKlrSTIdBuURA-1
X-Mimecast-MFC-AGG-ID: ro_9gL54OtKlrSTIdBuURA_1762317546
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A64D1800357;
	Wed,  5 Nov 2025 04:39:06 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.34])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E22BF195608E;
	Wed,  5 Nov 2025 04:39:03 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [cgroup/for-6.19 PATCH v3 0/5] cgroup/cpuset: Additional housekeeping check & cleanup
Date: Tue,  4 Nov 2025 23:38:43 -0500
Message-ID: <20251105043848.382703-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

 v3: Break out the prstate_housekeeping_conflict() change into 2
     new patches with some testing result included.

 v2: Update patch 2 to correct some of the checking code and add
     prstate_housekeeping_conflict() as suggested by Chen Ridong.

The first two patches are based on the two cpuset patches from the
"timers: Exclude isolated cpus from timer migration" patch series [1]
with some modifications. They add additional nohz_full housekeeping
mask check to ensure that there is at least one common housekeeping
CPU that is not domain and nohz_full isolated.

Patches 3 & 4 fix another housekeeping CPU conflict issue reported by
Chen Ridong.

The last patch is another cleanup patch to simplify the current
partition code.

[1] https://lore.kernel.org/lkml/20251020112802.102451-1-gmonaco@redhat.com/

Gabriele Monaco (1):
  cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to
    update_isolation_cpumasks()

Waiman Long (4):
  cgroup/cpuset: Fail if isolated and nohz_full don't leave any
    housekeeping
  cgroup/cpuset: Move up prstate_housekeeping_conflict() helper
  cgroup/cpuset: Ensure domain isolated CPUs stay in root or isolated
    partition
  cgroup/cpuset: Globally track isolated_cpus update

 kernel/cgroup/cpuset.c | 189 ++++++++++++++++++++++++++++-------------
 1 file changed, 130 insertions(+), 59 deletions(-)

-- 
2.51.1


