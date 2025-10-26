Return-Path: <linux-kernel+bounces-870401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B7C0AA5F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68343189D7AB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0698320E029;
	Sun, 26 Oct 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMD/Kwi8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C5917A2EC
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761489392; cv=none; b=Xp0RESQlqvSaTd4AqXblUYHpyb/TKRuYJVKEQ1x74Yq3HyVZHKj/++XIHrdO9ubO5z9DCCBqoElsSYjxrgiR1kvedAztECLz1NHFjj9uWhJXkCd30ywoWiWEwZyPKkamjvVZVpFYp6+sKU7OY/8qltl3Q08t4QYkPf6XrXPng3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761489392; c=relaxed/simple;
	bh=rNpKmklyF3Cn5rIFXlhNr5c+/0zwwQ6rP8m264276DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz/R/IhuOAAnwlXsm7Uvn2eYGx2R6JuzLZqlHexrsK0GtFWHSnuvm++9cvPdEhqGpqil6dkJybDLClclL8GVeaaFeW7M6kVn/SmY+WPx5TVo3uOHGgaJZ7lhj8YFzZZ9RhNBKmjaaIO5687IejkQ+aei51rTjyGqGqRhWizZcL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMD/Kwi8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761489389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OSCfgCliiKA8rExosXI2alPxy9DLwBPbxPmCr1IMwno=;
	b=NMD/Kwi8V4gYe2Q9Pn3Gi9hCOoGJlPjtTM+UvEIVQB4aubFSXRxphbKWxcKIt3D4Vf+LMY
	GOp+uBn2qHvEZGhEUVTtuS0OMp4q3GSZ594bGEpSoitYeiOlyrrgKDPGutPITAnMfoQzN8
	L9GiLGbdiUV6v8RfxgMyBOwAKVfdIDo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-CefMQqsxPu-sSGsDTm6FLw-1; Sun,
 26 Oct 2025 10:36:24 -0400
X-MC-Unique: CefMQqsxPu-sSGsDTm6FLw-1
X-Mimecast-MFC-AGG-ID: CefMQqsxPu-sSGsDTm6FLw_1761489383
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F3121955EE1;
	Sun, 26 Oct 2025 14:36:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 01D9730002DB;
	Sun, 26 Oct 2025 14:36:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 26 Oct 2025 15:35:05 +0100 (CET)
Date: Sun, 26 Oct 2025 15:35:01 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alexey Gladkov <legion@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC 2/1] kill task_ucounts()->rcu_read_lock(), add __task_ucounts()
Message-ID: <20251026143501.GA22472@redhat.com>
References: <20251026143140.GA22463@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026143140.GA22463@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/26, Oleg Nesterov wrote:
>
> NOTE: task_ucounts() returns the pointer to another rcu-protected data,
> struct ucounts. So it should either be used when task->real_cred and thus
> task->real_cred->ucounts is stable (release_task, copy_process, copy_creds),
> or it should be called under rcu_read_lock(). In both cases it is pointless
> to take rcu_read_lock() to read the cred->ucounts pointer.

So I think task_ucounts() can just do

	/* The caller must ensure that ->real_cred is stable or take rcu_read_lock() */
	#define task_ucounts(task)	\
		rcu_dereference_check((task)->real_cred, 1)->ucounts

but this removes the lockdep checks altogether.

But, otoh, task_cred_xxx(t, ucounts) (or, say, task_cred_xxx(task, user_ns)) can
hide the problem. Lockdep won't complain if, for example, we remove rcu_read_lock()
in task_sig() around get_rlimit_value(task_ucounts(p)). So perhaps something like
below makes any sense?


diff --git a/include/linux/cred.h b/include/linux/cred.h
index 89ae50ad2ace..7078159486f0 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -347,7 +347,14 @@ DEFINE_FREE(put_cred, struct cred *, if (!IS_ERR_OR_NULL(_T)) put_cred(_T))
 
 #define task_uid(task)		(task_cred_xxx((task), uid))
 #define task_euid(task)		(task_cred_xxx((task), euid))
-#define task_ucounts(task)	(task_cred_xxx((task), ucounts))
+
+// ->real_cred must be stable
+#define __task_ucounts(task)	\
+	rcu_dereference_protected((task)->real_cred, 1)->ucounts
+
+// needs rcu_read_lock()
+#define task_ucounts(task)	\
+	rcu_dereference((task)->real_cred)->ucounts
 
 #define current_cred_xxx(xxx)			\
 ({						\
diff --git a/kernel/cred.c b/kernel/cred.c
index dbf6b687dc5c..edddecec82e5 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -305,7 +305,7 @@ int copy_creds(struct task_struct *p, u64 clone_flags)
 		p->real_cred = get_cred_many(p->cred, 2);
 		kdebug("share_creds(%p{%ld})",
 		       p->cred, atomic_long_read(&p->cred->usage));
-		inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
+		inc_rlimit_ucounts(__task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 		return 0;
 	}
 
@@ -342,7 +342,7 @@ int copy_creds(struct task_struct *p, u64 clone_flags)
 #endif
 
 	p->cred = p->real_cred = get_cred(new);
-	inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
+	inc_rlimit_ucounts(__task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 	return 0;
 
 error_put:
diff --git a/kernel/exit.c b/kernel/exit.c
index f041f0c05ebb..80b0f1114bd3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -252,7 +252,7 @@ void release_task(struct task_struct *p)
 
 	/* don't need to get the RCU readlock here - the process is dead and
 	 * can't be modifying its own credentials. */
-	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
+	dec_rlimit_ucounts(__task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 
 	pidfs_exit(p);
 	cgroup_release(p);
diff --git a/kernel/fork.c b/kernel/fork.c
index 3da0f08615a9..f2a6a3cd14ef 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2048,7 +2048,7 @@ __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_free;
 
 	retval = -EAGAIN;
-	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
+	if (is_rlimit_overlimit(__task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
 		if (p->real_cred->user != INIT_USER &&
 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
 			goto bad_fork_cleanup_count;
@@ -2486,7 +2486,7 @@ __latent_entropy struct task_struct *copy_process(
 bad_fork_cleanup_delayacct:
 	delayacct_tsk_free(p);
 bad_fork_cleanup_count:
-	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
+	dec_rlimit_ucounts(__task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 	exit_creds(p);
 bad_fork_free:
 	WRITE_ONCE(p->__state, TASK_DEAD);


