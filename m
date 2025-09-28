Return-Path: <linux-kernel+bounces-835493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67296BA7490
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 18:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9EA7A7F32
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928C8236435;
	Sun, 28 Sep 2025 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgmadUqW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F11D9A5F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759076526; cv=none; b=bthmsHz9yk3QIVlx+m6pcCXvUHjVBEsr+Vy9cdhThaSr0lJCAyO51MTfzo1JYXqqkSDqFWncGlPxoYXBIsfvaHZd6LYg07FPa0+E1S4xkUsq6ytCvQlK6SKY15v4FIYXXmk8BHf9bPZ0JgAvvBgWFt6SfZ9QcqiW2uptoKS3wcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759076526; c=relaxed/simple;
	bh=P8B6Xe02csXMcRjcPJCFXvKsOScV6C8Gj7AQe1xT0GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdbLEFpiYsRBu35794+zpDLSr1Ygx/DZEuNx1fB/Dojnk2OZBqDKovKX5Pec+/aUIy/vQ7zZPMGCpxUfjHxD9hBkYqgJDivez1sPKgn0GZJ5MktECw/TjnIPcF9sQspdJDBlqjufOtMSKLr/rtrCXVM+r6NfscyobnBEBQ1TKgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgmadUqW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759076523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+EhSALO7xMrj0oS9cmQfIDYBIiNse1+0LkNgFR6ge0=;
	b=VgmadUqWhd8yUedxNWacYhSKoAibfVdev1WbpCiOuf/cxTvYXlFSACLTjZA+6KaVBE8R7N
	blNXsvckWE+yDQ9fj+KzRubYAJzdQmvDenXGud9YGpNHhi5ZeReIH/jars2eH75/k/OkyF
	9GKACsyoCs7jK7vvbl2QXGCvykSp1w4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-P3QTowJlPT-LMyb-8Xh7Eg-1; Sun,
 28 Sep 2025 12:21:59 -0400
X-MC-Unique: P3QTowJlPT-LMyb-8Xh7Eg-1
X-Mimecast-MFC-AGG-ID: P3QTowJlPT-LMyb-8Xh7Eg_1759076518
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D1D419560B5;
	Sun, 28 Sep 2025 16:21:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B6103195608E;
	Sun, 28 Sep 2025 16:21:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 28 Sep 2025 18:20:35 +0200 (CEST)
Date: Sun, 28 Sep 2025 18:20:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] documentation: seqlock: fix the wrong documentation of
 read_seqbegin_or_lock/need_seqretry
Message-ID: <20250928162029.GA3121@redhat.com>
References: <20250928161953.GA3112@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928161953.GA3112@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The comments and pseudo code in Documentation/locking/seqlock.rst are wrong:

	int seq = 0;
	do {
		read_seqbegin_or_lock(&foo_seqlock, &seq);

		/* ... [[read-side critical section]] ... */

	} while (need_seqretry(&foo_seqlock, seq));

read_seqbegin_or_lock() always returns with an even "seq" and need_seqretry()
doesn't change this counter. This means that seq is always even and thus the
locking pass is simply impossible.

IOW, "_or_lock" has no effect and this code doesn't differ from

	do {
		seq = read_seqbegin(&foo_seqlock);

		/* ... [[read-side critical section]] ... */

	} while (read_seqretry(&foo_seqlock, seq));

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 Documentation/locking/seqlock.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index ec6411d02ac8..167d442d3c7f 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -218,13 +218,14 @@ Read path, three categories:
    according to a passed marker. This is used to avoid lockless readers
    starvation (too much retry loops) in case of a sharp spike in write
    activity. First, a lockless read is tried (even marker passed). If
-   that trial fails (odd sequence counter is returned, which is used as
-   the next iteration marker), the lockless read is transformed to a
-   full locking read and no retry loop is necessary::
+   that trial fails (sequence counter doesn't match), make the marker
+   odd for the next iteration, the lockless read is transformed to a
+   full locking read and no retry loop is necessary, for example::
 
 	/* marker; even initialization */
-	int seq = 0;
+	int seq = 1;
 	do {
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&foo_seqlock, &seq);
 
 		/* ... [[read-side critical section]] ... */
-- 
2.25.1.362.g51ebf55



