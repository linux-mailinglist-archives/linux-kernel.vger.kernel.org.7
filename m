Return-Path: <linux-kernel+bounces-762853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C151B20B74
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E534818C5E14
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08E720F098;
	Mon, 11 Aug 2025 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6t1LLVI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFAA1F91F6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921528; cv=none; b=cjGOcTYFdiYpw+hn5Fi+L6YijLVbr/FKzHXT+tpIImATYggDmpk5SSUMohcunNGxRsz72U61B0iLQX7RspsNN9SB6AsflJIzDnE7AZs/CvacKGs5m7wrDIQk04d4isIHZULE6xxFiUNfeLEkP/MTM3JHDwDTwxYdA4ZNlD+1a8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921528; c=relaxed/simple;
	bh=UujaOmf1m1mgcm9mErX3O/zVAg7OSbtBx6gU1smwV50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMBeJs+SccVZi+YN/44iJOJv7W71zCjApSldACm2LvuBOdrM/dQqo2Ew45DkVhcL7DgwQjve6Bm3rNGY78xMW/cbw/zosDcV0kqZ/6GoOeM+i6QIASrFBaa49S29PPp+uYTTLrbXrinE9bNfzeug49Qdm5D0jDQMUEx/3uQf2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6t1LLVI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754921525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QrOjc/XHDwlIzjWMUvhwYvsBLeqDMZ09ML2nGQi9p3E=;
	b=Q6t1LLVIYnG8Sk7MjGq5cHHC1Pip2gsLqgxlCvHI75NXd2CVplc0rf55ZE7PpwL7hSAjDL
	ZtW7t5G+AKwXHPgbUom9fociQ16WbmN1+xRXOjxUkYR+L8HX42YtFRB6sBn9hxBHgBpyyb
	AlhakUlmZ8RAUhAWT8Hz4JG3YkUUiX8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-bwyeiEcBN-KTIJw9vceV3Q-1; Mon,
 11 Aug 2025 10:12:02 -0400
X-MC-Unique: bwyeiEcBN-KTIJw9vceV3Q-1
X-Mimecast-MFC-AGG-ID: bwyeiEcBN-KTIJw9vceV3Q_1754921521
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95B7D1800290;
	Mon, 11 Aug 2025 14:12:00 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.185])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E9861800447;
	Mon, 11 Aug 2025 14:11:53 +0000 (UTC)
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
Subject: [PATCH v3] futex: Use user_write_access_begin/_end() in futex_put_value()
Date: Mon, 11 Aug 2025 10:11:47 -0400
Message-ID: <20250811141147.322261-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Commit cec199c5e39b ("futex: Implement FUTEX2_NUMA") introduces a new
futex_put_value() helper function to write a value to the given user
address. However, it uses user_read_access_begin() before the write.
For arches that differentiate between read and write accesses, like
powerpc, futex_put_value() fails with a -EFAULT return value.  Fix that
by using the user_write_access_begin/user_write_access_end() pair.

Fixes: cec199c5e39b ("futex: Implement FUTEX2_NUMA")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/futex/futex.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index c74eac572acd..2cd57096c38e 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -319,13 +319,13 @@ static __always_inline int futex_put_value(u32 val, u32 __user *to)
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
-	user_read_access_end();
+	user_write_access_end();
 	return -EFAULT;
 }
 
-- 
2.50.1


