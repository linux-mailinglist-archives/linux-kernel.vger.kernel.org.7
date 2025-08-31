Return-Path: <linux-kernel+bounces-793535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315E8B3D4E0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6515E189A9B0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960F7279782;
	Sun, 31 Aug 2025 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="lV8wR3Z/";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="fF+S5Ouu"
Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C31F5413
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756667894; cv=none; b=OihNucUFqDNWCR01g6B683CJt7Ew+ratu/WwZvO3sQgyT7NVcfIM1ZPGPlphV7/mlaBctKTwirMVNxrCW9NU+LBFGz4bKE5tPwOGBZAin5qOp9EaBgHtCoaAbGBOxoOU2zmE5fJu93cuNTmZ5rxndypJyIXQW35F+/mNk7jdhjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756667894; c=relaxed/simple;
	bh=ABm7sCuXnVGTUvJ3oYj/x/myV+euHTB1ShT8xKihbqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0gsoz23juiUK73q05BVmtpg9JSIYg5XWnFTipoT6jQlcdCfKS2dNnxT27udVhsfn5y0ZajnL2mVGRwuW0zElnYgaEtT6J3K8YVIIQSklBwnSjadJ/C0LptlaZznl36L6SU5BSn1vIJ7gFOHPfMgx+QLiyZ95nYLpaJypGwR8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=lV8wR3Z/ reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=fF+S5Ouu; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756668792; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=ZQf10//JpnrdeYz7kQCzI/aqQ6NoOTIPSKaQVv4vqlM=; b=lV8wR3Z/3CkZ3RuWrtn193wR5R
	ky7A5bZblEHL1jLnYtEdREgDDoPoxTmAehrffZl7V3/OXfGlsMH7cXdzSOTb/iLjFMSlOSe4OCNyc
	3JGWz1b4sTRE9slRoEN5RHJOzOl0TJT2wYuQKWIFkzfcLlk0sgy+BLpS8vFqprWLRC/3+IED1Ggvv
	vJIlg/1fl87uAI9PHDExarOiVFGJZ6rRCwhOLHbP/eZn+Pa9nQaLkryLKdwtFCA+EzSnszZVjpkay
	bhYn5s2uPCBahk6LbqE3/rQQqtELRUF78l91hcqoGs5JZWcqt4kdCWA5tLxC0yah7HWfTPO2PZnqA
	QWEygt0Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756667892; h=from : subject
 : to : message-id : date;
 bh=ZQf10//JpnrdeYz7kQCzI/aqQ6NoOTIPSKaQVv4vqlM=;
 b=fF+S5OuuZBQe/HuSW61M0rqHK87SgUx0TySImf4Ey7PHuCX6gSGdKIzgkLJixnNZ0YJEU
 fudQPtPNboWkn4JI502qMX1VboXE/uf3cM9Ipm3/olOLA+v5pcg0pVSDxLxunGjcWQYaH1r
 cZSontJAkvFcJHJBGq4nQChdCKoyfx2qY1eVvIio9q1986d8Ut9EFd/N2EpWmYMI4z0IUTh
 CSyuSWQV6XCXjkrihSU/U/ytLGCAoBKYqcuPNkRNf1CCLZ6HK3+BNnxfwGtQ8zg/mKpcWUQ
 EkFnwbyFD7DkGHK64NK7xWsfaCIfu4y+L9OKaU6Ld/8M6yriLGcrT+CiHYCA==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYt-TRk4VS-H5; Sun, 31 Aug 2025 19:17:59 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYt-4o5NDgrprk4-pPNu; Sun, 31 Aug 2025 19:17:59 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 4/5] wait: Introduce io_wait_event_killable()
Date: Sun, 31 Aug 2025 21:03:42 +0200
Message-ID: <370180ef235d9e183c93bfb9677e8a35e4ca27f2.1756635044.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756635044.git.repk@triplefau.lt>
References: <cover.1756635044.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: cWjWg_oTebCA.D3ajaYoA8Yn8.cP3ilwdJEdI
Feedback-ID: 510616m:510616apGKSTK:510616s1xwnvTvE6
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Add io_wait_event_killable(), a variant of wait_event_killable() that
uses io_schedule() instead of schedule(). This is to be used in
situation where waiting time is to be accounted as IO wait time.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 include/linux/wait.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 09855d819418..cfeb1adee973 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -937,6 +937,21 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
 	__ret;									\
 })
 
+#define __io_wait_event_killable(wq, condition)					\
+	___wait_event(wq, condition, TASK_KILLABLE, 0, 0, io_schedule())
+
+/*
+ * wait_event_killable() - link wait_event_killable but with io_schedule()
+ */
+#define io_wait_event_killable(wq_head, condition)				\
+({										\
+	int __ret = 0;								\
+	might_sleep();								\
+	if (!(condition))							\
+		__ret = __io_wait_event_killable(wq_head, condition);		\
+	__ret;									\
+})
+
 #define __wait_event_state(wq, condition, state)				\
 	___wait_event(wq, condition, state, 0, 0, schedule())
 
-- 
2.50.1


