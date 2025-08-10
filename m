Return-Path: <linux-kernel+bounces-761525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88876B1FB67
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 19:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7031897B86
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 17:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE6926E6E7;
	Sun, 10 Aug 2025 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiaMg0Vd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654070830
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754847456; cv=none; b=sXgqoW8pX+Pv97muArMO52ch3wZh/psliEGY1kRnyMeCqyqDmM29QuyE+VMHNfTEbUUsht0g0spLxyiAT4rlXl+a0AA1n0xeYzLu4DEXti02Uu8IsqXkoAG/fJ26fhyiBw79iYZjGeCQu0IOIT30xwf4roEqeURH8YhYudF7VPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754847456; c=relaxed/simple;
	bh=VueknQPBG8x+EDrmXDAxwG6UeQCNQWSg4jJz1dqcJbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dDgfH9vNM3+GFSqNmbxBK7DSA7xcJiC0th3aDKHtXyPL9TGfq1o/aB82qzrJRRm4ubfiplQ8Ribx2APGx01Tjb0zmALhyjgGHfwsRM7ZBefTW11cLxg2jNQ3Jka4BGk1tGexwybiRXa/KfqDWkLYaZrMQgmAa6pr59zf9gSoojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiaMg0Vd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754847453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=QCLTOiAUkxDyuOBOpSXi034x+ePyGMlPi8uIABQ8x2k=;
	b=OiaMg0VdBXNOY3FsPlw1kKZwIGZIWvMeTN9c/5RUlWj13IbAPlp6jX7VYDR2dPTk6BZjpa
	8WoKwzopmnIlYZy/6Lk+snzkLvnQbxpkKl+tUZM63q+RI4/LUkT8bi7yOxTINeMM3TqmHE
	835UdNuvbiyjCvuquGO/l8AlL+wjpMI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-8_G5SBLPN5-0rrf3EdEvLA-1; Sun,
 10 Aug 2025 13:37:27 -0400
X-MC-Unique: 8_G5SBLPN5-0rrf3EdEvLA-1
X-Mimecast-MFC-AGG-ID: 8_G5SBLPN5-0rrf3EdEvLA_1754847446
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7E5F1956080;
	Sun, 10 Aug 2025 17:37:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D0D343001455;
	Sun, 10 Aug 2025 17:37:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 10 Aug 2025 19:36:14 +0200 (CEST)
Date: Sun, 10 Aug 2025 19:36:10 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>,
	Xiang Gao <gxxa03070307@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] pid: introduce task_ppid_vnr()
Message-ID: <20250810173610.GA19995@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802022123.3536934-1-gxxa03070307@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

for consistency with other task_xid_vnr() helpers.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/pidfs.c          | 2 +-
 include/linux/pid.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 4625e097e3a0..de5e71c2b49b 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -361,7 +361,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	 * the fields are set correctly, or return ESRCH to avoid providing
 	 * incomplete information. */
 
-	kinfo.ppid = task_ppid_nr_ns(task, NULL);
+	kinfo.ppid = task_ppid_vnr(task);
 	kinfo.tgid = task_tgid_vnr(task);
 	kinfo.pid = task_pid_vnr(task);
 	kinfo.mask |= PIDFD_INFO_PID;
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 453ae6d8a68d..4a733634c556 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -306,6 +306,11 @@ static inline pid_t task_ppid_nr_ns(const struct task_struct *tsk, struct pid_na
 	return pid;
 }
 
+static inline pid_t task_ppid_vnr(const struct task_struct *tsk)
+{
+	return task_ppid_nr_ns(tsk, NULL);
+}
+
 static inline pid_t task_ppid_nr(const struct task_struct *tsk)
 {
 	return task_ppid_nr_ns(tsk, &init_pid_ns);
-- 
2.25.1.362.g51ebf55


