Return-Path: <linux-kernel+bounces-761266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75DBB1F6CA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 23:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E830916727A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 21:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8686927BF95;
	Sat,  9 Aug 2025 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvrbQ7jS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD11F8725
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754774709; cv=none; b=ajqo0T9jlSSRLPnjCw8Bhm2wp4//2893PBHuRYQR+InagmnX7umx0EMyvbDO4hh7N5IriE9hsgi5fPWNsZ3yVPtPcyiACeBXr80gnbjjQ/7RylhWwOBEKbs2KjPpmJizsoUwInuAlrDnkfKfjvgwPboUSXGiPBVqoXJTpQ4Lsk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754774709; c=relaxed/simple;
	bh=cu43oJZJDSYTPewA1ytVKt7gwF23fVix0wRgHoCaITU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7wqQPW7Be/FSf4N5xn/hicklqr+jmBWw1rNUcWzJg4zm3PLxI/mQcv0T8KOUapAka1rZY6/DFqO0pPdpJUeOA/QS1hHiOQbZF2WvgKVpLX/GtGLt1sJuRhPWIig5SnMDfA/+1EjAskrGw6rujfaRRxN0/QWnMiULxzRHFXGbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvrbQ7jS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754774706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LDoKRMJSPm4TxBi0UG7O3F8vhPw8DnuxBqFoCagKhtg=;
	b=dvrbQ7jSlmAq39VBbdJpo4lwyGjmCb7jMd1i+Mg6djEJV5uiUVfPFIjPjOENUEK23SkUGE
	wMJRq5AssCqtZPD/8Ib/kwx34KTNT6VHL7y4b1WpKv/oXCYdub3sVjKDDEqe/mLJcILKc1
	Pv+VzXkIDn06nnZfpb0NgKMuW0rN+wE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-JDeaz4bNNmyjE8rlcJhsrg-1; Sat,
 09 Aug 2025 17:25:00 -0400
X-MC-Unique: JDeaz4bNNmyjE8rlcJhsrg-1
X-Mimecast-MFC-AGG-ID: JDeaz4bNNmyjE8rlcJhsrg_1754774699
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D394A1956088;
	Sat,  9 Aug 2025 21:24:58 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.79])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 921D11800446;
	Sat,  9 Aug 2025 21:24:56 +0000 (UTC)
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
Subject: [PATCH] futex: Use user_write_access_begin() in futex_put_value()
Date: Sat,  9 Aug 2025 17:24:42 -0400
Message-ID: <20250809212442.240540-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Commit cec199c5e39b ("futex: Implement FUTEX2_NUMA") introduces a new
futex_put_value() helper function to write a value to the given user
address. However, it uses user_read_access_begin() before the write.
For arches that differentiate between read and write accesses, like
powerpc, futex_put_value() fails with a -EFAULT return value.  Fix that
by using user_write_access_begin().

Fixes: cec199c5e39b ("futex: Implement FUTEX2_NUMA")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/futex/futex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index c74eac572acd..2b6ae6a2b2a2 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -319,7 +319,7 @@ static __always_inline int futex_put_value(u32 val, u32 __user *to)
 {
 	if (can_do_masked_user_access())
 		to = masked_user_access_begin(to);
-	else if (!user_read_access_begin(to, sizeof(*to)))
+	else if (!user_write_access_begin(to, sizeof(*to)))
 		return -EFAULT;
 	unsafe_put_user(val, to, Efault);
 	user_read_access_end();
-- 
2.50.1


