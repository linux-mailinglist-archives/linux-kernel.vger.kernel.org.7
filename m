Return-Path: <linux-kernel+bounces-776151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C25EB2C940
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACD83AFF80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52D2C11DF;
	Tue, 19 Aug 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaUQu6qD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F6284B38
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619913; cv=none; b=LMhGczlbPi8xDaV8q9IHqF/NR3wTjyXPp/a07rPA7gOQhAwg3imQefjg+fiYWxrwzKNGMJh8aT/usJWYhopqUHqzovNCFKO0ePRSVcn+XicHcD62Szw4mkomjH97+YfJ2wcO/cdbWvPQJtaiVOC0dYAax1Essszwb4XTvypU4pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619913; c=relaxed/simple;
	bh=OqikgqTQZRNN8DIly2lUwxkGV2EJbmghjYOudB6m6W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eb2aCRZ4oeUYJ7Xufp0iKybHBQ4Eca/zGxcor0I2drGno4Uj4vQolTj4VUYNlsBoN5WZeMOKKOivgmuvkZqXARkgdYsbMtOtZ7+eJ/YarUW4C+dDAj8IEJebDVxBSQ2ZCbAX2fIK632iVo6P8dPcYxV9PoaEttUxTbeHLmBIxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QaUQu6qD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755619910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/3a3Z3L0HEIC3vaPkLm4MfWk/+SLSX3X+v7+5Ljf+M=;
	b=QaUQu6qD/lqSKV6FDV/prjTHbB8B+gPovtbuWusXv2vXkl0V4hk8v9SQWqAX+eObbCob/R
	K7USPD1RlzwKDk42eGikmk84PZaEYXeIIscX7D2IPxjOLJtnkTaTFLiEdgo6P/sIstu2RK
	Z3+ziEsR1XWtqTunluRU9CiuVAs3GfM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-tSTadv3EM7ahhzm854JzNA-1; Tue,
 19 Aug 2025 12:11:44 -0400
X-MC-Unique: tSTadv3EM7ahhzm854JzNA-1
X-Mimecast-MFC-AGG-ID: tSTadv3EM7ahhzm854JzNA_1755619902
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B112C19775B0;
	Tue, 19 Aug 2025 16:11:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.95])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D73F5180047F;
	Tue, 19 Aug 2025 16:11:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 19 Aug 2025 18:10:22 +0200 (CEST)
Date: Tue, 19 Aug 2025 18:10:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	syzbot <syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, dvyukov@google.com,
	elver@google.com, glider@google.com, jack@suse.cz,
	kasan-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	willy@infradead.org, v9fs@lists.linux.dev,
	David Howells <dhowells@redhat.com>
Subject: [PATCH] 9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN
Message-ID: <20250819161013.GB11345@redhat.com>
References: <68a2de8f.050a0220.e29e5.0097.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a2de8f.050a0220.e29e5.0097.GAE@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

p9_read_work() doesn't set Rworksched and doesn't do schedule_work(m->rq)
if list_empty(&m->req_list).

However, if the pipe is full, we need to read more data and this used to
work prior to commit aaec5a95d59615 ("pipe_read: don't wake up the writer
if the pipe is still full").

p9_read_work() does p9_fd_read() -> ... -> anon_pipe_read() which (before
the commit above) triggered the unnecessary wakeup. This wakeup calls
p9_pollwake() which kicks p9_poll_workfn() -> p9_poll_mux(), p9_poll_mux()
will notice EPOLLIN and schedule_work(&m->rq).

This no longer happens after the optimization above, change p9_fd_request()
to use p9_poll_mux() instead of only checking for EPOLLOUT.

Reported-by: syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com
Tested-by: syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68a2de8f.050a0220.e29e5.0097.GAE@google.com/
Link: https://lore.kernel.org/all/67dedd2f.050a0220.31a16b.003f.GAE@google.com/
Co-developed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 net/9p/trans_fd.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 339ec4e54778..474fe67f72ac 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -666,7 +666,6 @@ static void p9_poll_mux(struct p9_conn *m)
 
 static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 {
-	__poll_t n;
 	int err;
 	struct p9_trans_fd *ts = client->trans;
 	struct p9_conn *m = &ts->conn;
@@ -686,13 +685,7 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 	list_add_tail(&req->req_list, &m->unsent_req_list);
 	spin_unlock(&m->req_lock);
 
-	if (test_and_clear_bit(Wpending, &m->wsched))
-		n = EPOLLOUT;
-	else
-		n = p9_fd_poll(m->client, NULL, NULL);
-
-	if (n & EPOLLOUT && !test_and_set_bit(Wworksched, &m->wsched))
-		schedule_work(&m->wq);
+	p9_poll_mux(m);
 
 	return 0;
 }
-- 
2.25.1.362.g51ebf55



