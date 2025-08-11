Return-Path: <linux-kernel+bounces-762833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C1B20B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181CC2A3DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D2120CCE5;
	Mon, 11 Aug 2025 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjlkA7X8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DEB1DC9B8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921137; cv=none; b=YI9bGpZ90lbWqDKiNZRFGYd2kbV4etPanPlFWTmbH+poBALSJIFKe2HtthvnuVsYHcVYVPL+Uq8C6qTh5VIiT48m8yXidT+mHKlMsTFY8IJUP0Uw/+yPaShQIsVUcqSGXFKS8qTuLZgDvmYOHEh9GhYslwYmX3/Wbgw/zp4MW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921137; c=relaxed/simple;
	bh=tY3GvRfU+ZbC5r18UWr26Sk5eER0Z1yHXOrsLc2TgUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DL6Bk1TxozYu45i1h2qHy3X9tj40STz9sTToCWlC3OVGVNK8cryba6wosYNnl2a9+KmpRbXQVlV9ZV3V2oiIfLdXXTnUXejwqH9jH5LQkNJHRl5jEbIacvA8csQ9o2U5E1euDyBJgFSakrxvZSHzcqw4WGYyFlJ347RXmUwWiVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjlkA7X8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754921133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xnw1x9It7MHX1ft7a9iEuo8H6z86r7iWayv7jAKJfN4=;
	b=GjlkA7X87x3nstY7l/ytgc6j7nRcror6RDOEjbukm/gqrtoWt2uLjpRR8f5XH7bxYdRqV5
	hNMkwiCdduEsQl7xIufClpw47oOFv+3vsKXBxmbxlCzgYQ7u4p1R5UTsXCnl/kdJ350zAT
	YNuxC2X919lRpJTrTAb8XiY3HxF3l/0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-C_URpHXMMPiN2Bp2WfYQbQ-1; Mon,
 11 Aug 2025 10:05:27 -0400
X-MC-Unique: C_URpHXMMPiN2Bp2WfYQbQ-1
X-Mimecast-MFC-AGG-ID: C_URpHXMMPiN2Bp2WfYQbQ_1754921124
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEEFF1869ADD;
	Mon, 11 Aug 2025 14:03:35 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.185])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CBAC19560AB;
	Mon, 11 Aug 2025 14:03:32 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] futex: Use user_write_access_begin/_end() in futex_put_value()
Date: Mon, 11 Aug 2025 10:03:24 -0400
Message-ID: <20250811140324.321751-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Commit cec199c5e39b ("futex: Implement FUTEX2_NUMA") introduces a new
futex_put_value() helper function to write a value to the given user
address. However, it uses user_read_access_begin() before the write.
For arches that differentiate between read and write accesses, like
powerpc, futex_put_value() fails with a -EFAULT return value.  Fix that
by using the user_write_access_begin/user_write_access_end() pair.

Fixes: cec199c5e39b ("futex: Implement FUTEX2_NUMA")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/futex/futex.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index c74eac572acd..ebe9e755b3b5 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -319,10 +319,10 @@ static __always_inline int futex_put_value(u32 val, u32 __user *to)
 {
 	if (can_do_masked_user_access())
 		to = masked_user_access_begin(to);
-	else if (!user_read_access_begin(to, sizeof(*to)))
+	else if (!user_write_access_begin(to, sizeof(*to)))
 		return -EFAULT;
 	unsafe_put_user(val, to, Efault);
-	user_read_access_end();
+	user_write_access_end();
 	return 0;
 Efault:
 	user_read_access_end();
-- 
2.50.1


