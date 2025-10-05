Return-Path: <linux-kernel+bounces-842340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DBDBB989D
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 16:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C6D3B51FC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B0E28C86C;
	Sun,  5 Oct 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvLWnqb8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A250928B4F0
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759675935; cv=none; b=l3iwtzXNB2ILoTjFR3HlpoG6DooGLvZZjLzNFZKEvRGlRlyuND58XHwErwLhV7NJRcdfkLyBVJqEy6uBgyTZrM3Bk/BEPZIufb50lFcIBGmd6uZIK1AXYYrBvaI276T8ADm0nNPG7UEDg0yDDuG++XEtlKfc7Pg6/5iVGhaoFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759675935; c=relaxed/simple;
	bh=eNMb/LOH8STtC2n7cxPseKu/VPrmpdGzSGzzVQe6kFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pSpXQwGo85ggVRBoA93SvVrOOYueRzJKyj0cu22tQE4IRgqrXJHg3Il44PTFkwxq8aLehLAO8OtwLX/aBgEU9oEFJ/l3/jhX5xgco2EcEEJafKI/Tz838iZksK/BfVW5F2JQnNcI32ug3gYni8wlD3n9gJQkT6JFOhCSKi3EUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZvLWnqb8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759675932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=ttN0gc8Al1vCK63h1373HhrrlY+8UEv8GvNSaU8FRRE=;
	b=ZvLWnqb8Ejml9yLFs6ryuyJcTQCru7eHnUPFzU82tmCxHVAd5W9XXrsRB0vQIAOUu12pCo
	0Usc7FK3lIx7hPRh+r2HkXdktEQx/KW/Cb8leOi7XV+TUbo8jcmlTBlCMTI0igRADna2Bf
	Fc9RVjVkOr+Gi6KcvzGWLalZfYJaZus=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-t5Jw6-0hPfKxeJPQOQC4Yw-1; Sun,
 05 Oct 2025 10:52:09 -0400
X-MC-Unique: t5Jw6-0hPfKxeJPQOQC4Yw-1
X-Mimecast-MFC-AGG-ID: t5Jw6-0hPfKxeJPQOQC4Yw_1759675928
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5B5B1956087;
	Sun,  5 Oct 2025 14:52:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 894EB1956056;
	Sun,  5 Oct 2025 14:52:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  5 Oct 2025 16:50:46 +0200 (CEST)
Date: Sun, 5 Oct 2025 16:50:41 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] seqlock: change __dentry_path() to use
 __SEQLOCK_READ_SECTION()
Message-ID: <20251005145041.GA1266@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005144929.GB1188@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

To simplify the code and make it more readable.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/d_path.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index bb365511066b..0dab1ab1e78d 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -332,28 +332,23 @@ static char *__dentry_path(const struct dentry *d, struct prepend_buffer *p)
 {
 	const struct dentry *dentry;
 	struct prepend_buffer b;
-	int seq = 0;
 
 	rcu_read_lock();
-restart:
-	dentry = d;
-	b = *p;
-	read_seqbegin_or_lock(&rename_lock, &seq);
-	while (!IS_ROOT(dentry)) {
-		const struct dentry *parent = dentry->d_parent;
+	__SEQLOCK_READ_SECTION(&rename_lock, lockless, seq, NULL) {
+		dentry = d;
+		b = *p;
+		while (!IS_ROOT(dentry)) {
+			const struct dentry *parent = dentry->d_parent;
 
-		prefetch(parent);
-		if (!prepend_name(&b, &dentry->d_name))
-			break;
-		dentry = parent;
-	}
-	if (!(seq & 1))
-		rcu_read_unlock();
-	if (need_seqretry(&rename_lock, seq)) {
-		seq = 1;
-		goto restart;
+			prefetch(parent);
+			if (!prepend_name(&b, &dentry->d_name))
+				break;
+			dentry = parent;
+		}
+		if (lockless)
+			rcu_read_unlock();
 	}
-	done_seqretry(&rename_lock, seq);
+
 	if (b.len == p->len)
 		prepend_char(&b, '/');
 	return extract_string(&b);
-- 
2.25.1.362.g51ebf55


