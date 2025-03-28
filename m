Return-Path: <linux-kernel+bounces-579871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98151A74A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 14:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F423A94AA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E9416BE3A;
	Fri, 28 Mar 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgKlP7rG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FA51BF58
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743168411; cv=none; b=FuhzbFSI/so9TzuIxyg2Cdh1p0qXzxSJfBbiVzcLOiXs46vfKMuVT5p4Rr5/DSCRY1VB6w2OCpy4jgUM5YxzhIxHvAJkJdOZLlR7nFHyTSKkiLJa4WBwrnVyyL/A1+wvwm0l+Wwlk5jphZUJbdS4LrYnW1oE5o3OnU/KQhGVv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743168411; c=relaxed/simple;
	bh=b3S/nzeF4iUi/K7suqqr7ZsBxzyPxd1gpdXP4/kcoyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOPv3qahevQfYNdTOh7Td0gs7TyQFFQAT+54OUGI0RzZg0xfoxUzwmZNp/ZokeYCrsdGLK59RdY8VWGgECmp/7ZRShGj0QMPxfJ2bKW5Cu5PB8q9txD2zIvaxOr99p49NJO06HIVmGe5EfRVXJIftzxL0uHU52iNm9XrzCuB2a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgKlP7rG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743168408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AnrzPvKl3sLQiFPBdijNOio/KW8lHT+XOZh1AR7FuU0=;
	b=HgKlP7rGKYnGv7q/phYkQCVzDm+eeJMjAy66cdVLbiaf7BfAbZiSHSCaJ8S8xmqDj+ZiuF
	knepb118Avqdl47LmmdIBgvz5TpIWk7U6bogjXDJBo/nWRxmhVl+dC0UV1ny2XNaZtO9wY
	LNv1dtxeQQfjWhUsTVYK6WBT6NDOcBQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-zwSaCNGoPTO3Nosj5NuWnQ-1; Fri,
 28 Mar 2025 09:26:42 -0400
X-MC-Unique: zwSaCNGoPTO3Nosj5NuWnQ-1
X-Mimecast-MFC-AGG-ID: zwSaCNGoPTO3Nosj5NuWnQ_1743168400
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 453F418EBE88;
	Fri, 28 Mar 2025 13:26:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.25])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 802361828A92;
	Fri, 28 Mar 2025 13:26:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 28 Mar 2025 14:26:05 +0100 (CET)
Date: Fri, 28 Mar 2025 14:25:57 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
Cc: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com,
	ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org,
	kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
	lucho@ionkov.net, mjguzik@gmail.com, netfs@lists.linux.dev,
	swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com,
	v9fs@lists.linux.dev, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250328132557.GB29527@redhat.com>
References: <20250328130625.GA29527@redhat.com>
 <67e69f04.050a0220.2f068f.0076.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e69f04.050a0220.2f068f.0076.GAE@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/28, syzbot wrote:
>
> > #syz test: upstream
>
> want either no args or 2 args (repo, branch), got 5

#syz test

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 56e62978e502..aa9cd248a243 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -669,7 +669,6 @@ static void p9_poll_mux(struct p9_conn *m)
 
 static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 {
-	__poll_t n;
 	struct p9_trans_fd *ts = client->trans;
 	struct p9_conn *m = &ts->conn;
 
@@ -687,13 +686,7 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
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


