Return-Path: <linux-kernel+bounces-870399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDC3C0AA3B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4DD3ABF30
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175031FF1C7;
	Sun, 26 Oct 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOujKYKO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38FB125A0
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761489190; cv=none; b=W/c/lxwzyivNzhaET/osdTGkMxb233SHYkDmvb3CHGhqVGe/Hmg26qXm/yNlzEcZriLIz+Z53qalxp+xcwouYZcBRhbLJEmkSnORXl9GWxMEJ/YREz3qwZdR/UyrmlL84dMe76GJl34vysavpbteX19nhTYJN4uzPv1rfRvyMvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761489190; c=relaxed/simple;
	bh=kyPszRFTtVkijKqZ+MBtEbNQpDio20V+TtpbIVtBxbY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ngDdjxXh0QqH/WDkti6m5FTickL0/V6n0O3r/ndhuwVkIW5uMBbkIIup6Mkq/gEl1xjeicDtXtGnjowznU0GPyCpfbRdeX/vBO5nKCdUmtrtMpgJdS/ZkOQjr2cMfrPoPNOiLEHWF4kSoXaZLiYauf1/YbaSsB6rQsNh6pf3kLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOujKYKO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761489187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=aiQn/c7MdROHcxE7i1h+oHIwSHYLRD/1dsdhp01RzO4=;
	b=SOujKYKObBCPl1PejoSGiJvq2cAEFRDrNpR7B/qeQhq46NarMtsqZTpnmTMP722XQmN7pA
	aaJW7D9lZptSzvNpIMnR4XjooYh0s7ZrHvWIP1QrV3hY6/ljQyvEvIpq5Ue73CXQ/B2+qX
	bw5tn1Y79ByTxGg4mF48zyInJ2gE1lw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-w6GqwkfENrKyeBHsCZ9bVw-1; Sun,
 26 Oct 2025 10:33:03 -0400
X-MC-Unique: w6GqwkfENrKyeBHsCZ9bVw-1
X-Mimecast-MFC-AGG-ID: w6GqwkfENrKyeBHsCZ9bVw_1761489182
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BB35180A23D;
	Sun, 26 Oct 2025 14:33:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C0293180057D;
	Sun, 26 Oct 2025 14:32:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 26 Oct 2025 15:31:44 +0100 (CET)
Date: Sun, 26 Oct 2025 15:31:40 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alexey Gladkov <legion@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] release_task: kill unnecessary rcu_read_lock() around
 dec_rlimit_ucounts()
Message-ID: <20251026143140.GA22463@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

rcu_read_lock() was added to shut RCU-lockdep up when this code used
__task_cred()->rcu_dereference(), but after the commit 21d1c5e386bc
("Reimplement RLIMIT_NPROC on top of ucounts") it is no longer needed:
task_ucounts()->task_cred_xxx() takes rcu_read_lock() itself.

NOTE: task_ucounts() returns the pointer to another rcu-protected data,
struct ucounts. So it should either be used when task->real_cred and thus
task->real_cred->ucounts is stable (release_task, copy_process, copy_creds),
or it should be called under rcu_read_lock(). In both cases it is pointless
to take rcu_read_lock() to read the cred->ucounts pointer.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/exit.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 9f74e8f1c431..f041f0c05ebb 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -251,10 +251,8 @@ void release_task(struct task_struct *p)
 	memset(&post, 0, sizeof(post));
 
 	/* don't need to get the RCU readlock here - the process is dead and
-	 * can't be modifying its own credentials. But shut RCU-lockdep up */
-	rcu_read_lock();
+	 * can't be modifying its own credentials. */
 	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
-	rcu_read_unlock();
 
 	pidfs_exit(p);
 	cgroup_release(p);
-- 
2.25.1.362.g51ebf55



