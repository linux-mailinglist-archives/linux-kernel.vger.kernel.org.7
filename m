Return-Path: <linux-kernel+bounces-816887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A7BB57A02
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82EA16700F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1F0302CCD;
	Mon, 15 Sep 2025 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjV6dXlk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F113002A0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938251; cv=none; b=p+fbTZPElLzgqhmamapvy/xS6PWU/uUJ++oyiA+CsBcNLpuieb67RLTEtWIdK1315OjaCRedgDH+UUI3i9zFo4x6RvJ6bMQVFDLTMirPIl1YpWamNRL5jWh/PBrPHRQTS+Ru5SAbctei4TTSu5qtEoubOsbg/qAcxKbPDWuO8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938251; c=relaxed/simple;
	bh=zfBMW9Wry9FFlM4ynsgMpWJYaz8r0IYmfbQDpxHEN0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDPanyHkW6I0pK71y5TXk1aJwurYPZLxlZt1448a46zuZ3VokDiq25AecUp8gIjVYb6eXYVLjobUf9OS94Bx4O3mI81lKoYUGm1q2fJIGwHpgHSg+Nw70hPAkZ7lQTKaP0y0xDMHIP4A4xd/OlwarAqYxPkjhyWG61TT065KVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjV6dXlk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757938249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VWtTSMlxJRQGC3FcFieZ8tT1OlyU8gkHxlUHQErqXnU=;
	b=BjV6dXlkBu4sqF7Cs//g3K4GzbZhllDsiQG7DUo+X64AZmovcg3uE1VBGo/fSBOZqFdUub
	/L2XrD8ktBWUR1vFJFgHaJQqkZN8oWUCcvozrWfiNVjRAeJezwZp18Uf1IclaOoFnK+/uU
	hSb+/afJyHelvc2HBcFU4bs0GZGN4t8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-sIIVRUQyNdGlUvtsxFtKrA-1; Mon,
 15 Sep 2025 08:10:46 -0400
X-MC-Unique: sIIVRUQyNdGlUvtsxFtKrA-1
X-Mimecast-MFC-AGG-ID: sIIVRUQyNdGlUvtsxFtKrA_1757938245
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64EFC19107D4;
	Mon, 15 Sep 2025 12:10:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E2BC519560B4;
	Mon, 15 Sep 2025 12:10:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 15 Sep 2025 14:09:21 +0200 (CEST)
Date: Mon, 15 Sep 2025 14:09:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
	Barret Rhoden <brho@google.com>
Subject: [PATCH v2 2/2] fix the racy usage of task_lock(tsk->group_leader) in
 sys_prlimit64() paths
Message-ID: <20250915120917.GA27702@redhat.com>
References: <20250914110908.GA18769@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914110908.GA18769@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The usage of task_lock(tsk->group_leader) in sys_prlimit64()->do_prlimit()
path is very broken.

sys_prlimit64() does get_task_struct(tsk) but this only protects task_struct
itself. If tsk != current and tsk is not a leader, this process can exit/exec
and task_lock(tsk->group_leader) may use the already freed task_struct.

Another problem is that sys_prlimit64() can race with mt-exec which changes
->group_leader. In this case do_prlimit() may take the wrong lock, or (worse)
->group_leader may change between task_lock() and task_unlock().

Change sys_prlimit64() to take tasklist_lock when necessary. This is not
nice, but I don't see a better fix for -stable.

Cc: stable@vger.kernel.org
Fixes: 18c91bb2d872 ("prlimit: do not grab the tasklist_lock")
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/sys.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 1e28b40053ce..36d66ff41611 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1734,6 +1734,7 @@ SYSCALL_DEFINE4(prlimit64, pid_t, pid, unsigned int, resource,
 	struct rlimit old, new;
 	struct task_struct *tsk;
 	unsigned int checkflags = 0;
+	bool need_tasklist;
 	int ret;
 
 	if (old_rlim)
@@ -1760,8 +1761,25 @@ SYSCALL_DEFINE4(prlimit64, pid_t, pid, unsigned int, resource,
 	get_task_struct(tsk);
 	rcu_read_unlock();
 
-	ret = do_prlimit(tsk, resource, new_rlim ? &new : NULL,
-			old_rlim ? &old : NULL);
+	need_tasklist = !same_thread_group(tsk, current);
+	if (need_tasklist) {
+		/*
+		 * Ensure we can't race with group exit or de_thread(),
+		 * so tsk->group_leader can't be freed or changed until
+		 * read_unlock(tasklist_lock) below.
+		 */
+		read_lock(&tasklist_lock);
+		if (!pid_alive(tsk))
+			ret = -ESRCH;
+	}
+
+	if (!ret) {
+		ret = do_prlimit(tsk, resource, new_rlim ? &new : NULL,
+				old_rlim ? &old : NULL);
+	}
+
+	if (need_tasklist)
+		read_unlock(&tasklist_lock);
 
 	if (!ret && old_rlim) {
 		rlim_to_rlim64(&old, &old64);
-- 
2.25.1.362.g51ebf55



