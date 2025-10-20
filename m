Return-Path: <linux-kernel+bounces-859985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F0BBEF15E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AC514E1801
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6832820DB;
	Mon, 20 Oct 2025 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDUIYoFd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C15027B34F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760927554; cv=none; b=pwQTdvCXyUt4T2/Nq62ULHT7FCpE/TUIm25FtMd3FC1qySBXI/XsgEh3EW92BkpEj+hoaKjA8ggkGtQ6Rhf5yePdhcgpONyHOoJWAH0hVvrgvK8KcEaY0gN4GSXQ1KrYjyyz53RzNc2HQgth1lhioDfREtSlUeWl92kJ2GOwMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760927554; c=relaxed/simple;
	bh=u8VOcgH+QQkYFELsPAhwRJ4nVJeKgT1D0WkzUNQU+G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SO9E6k8v/s7v1knp93uQTQMymk2hIEogHjkifOba+T7mx7npatiKQ8JL6qVLheoKNKP90CBNCkV5Qm45VbzKcWhh3TY0mTnRgaEfvoJXMQf35x0JHM7CAsp647MWdyXflKqrqskR77Zuh3UagIpE9mitDVaGh6/DV28YJL6xrjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDUIYoFd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760927552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qknYiUYKLY1B4Vr4Gv9pGbuP3Oa4IyYzSf6kkFP2K8g=;
	b=fDUIYoFdEq3ZxcUxlkV6i8NsyF99RTz8PopAt9S97IAhrmZp2gnM+ZWOCP7emXThIwi/z0
	BGwlJdS7Vdg8BgCzvsCvx2oBwDH5boZpUzi/WJPXuNd4OLI9z14cLCDJRuHDXhGnsF9zx2
	5CiI1YF5NDPMtgG3WsIyodiAQfqMYlY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-MD1iL4U9O9adjoJivHYRIg-1; Sun,
 19 Oct 2025 22:32:28 -0400
X-MC-Unique: MD1iL4U9O9adjoJivHYRIg-1
X-Mimecast-MFC-AGG-ID: MD1iL4U9O9adjoJivHYRIg_1760927547
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 260B71956054;
	Mon, 20 Oct 2025 02:32:27 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9764C1800586;
	Mon, 20 Oct 2025 02:32:24 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] cgroup/cpuset: Miscellaneous cleanup
Date: Sun, 19 Oct 2025 22:32:05 -0400
Message-ID: <20251020023207.177809-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series consists of 2 independent cleanup patches. The first one
eliminates the tracking of the number of child partitions as that value
isn't that useful anymore simplifying the code. The second one change
callback_lock into raw_spinlock_t to reduce cpuset operation overhead in
a PREEMPT_RT setting.

Waiman Long (2):
  cgroup/cpuset: Don't track # of local child partitions
  cgroup/cpuset: Change callback_lock to raw_spinlock_t

 kernel/cgroup/cpuset-internal.h |   3 -
 kernel/cgroup/cpuset.c          | 135 ++++++++++++++------------------
 2 files changed, 60 insertions(+), 78 deletions(-)

-- 
2.51.0


