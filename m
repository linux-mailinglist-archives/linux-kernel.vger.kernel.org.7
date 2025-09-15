Return-Path: <linux-kernel+bounces-817594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4918AB58441
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8611AA2092
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4205528C5DE;
	Mon, 15 Sep 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5NJwL/E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F225F277CB6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959892; cv=none; b=DGg5WAfie+VJS5e1Ep34R9WCRp2pPs45WT9L8h1ug14Sbf44dROZx+b60cfkdhZuAX0K030u/Kcjih+mcXLmEvmYB4gELAIxz/gUNBNm21oxeiCwtP5SneYUeGuTxhxqSSI65uFqpkRNyjUszR12DFFlv+810Lg8iDCFI54RlvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959892; c=relaxed/simple;
	bh=6dFtb8yo/nR+HTajXe+JuuMFZObEuhhvoeynjMd7ric=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpcUgVFwY7JNAANT6vZTOCgJHZiPm9VFfaSCOf6ANpvtmf6JMDvG6fHWZcLgGSnLk1lAivLqbluBI+RTVwLpT4YE09AMyBc6zpITRXBvnfmPVP2GTP5ICoYNyItu8Opy1tQDFNXcNugDn3VkYl0TbAB1hkg4Bb7604Ml5YtrwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5NJwL/E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757959889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7fFNoSRHvuFMJms0AIALGkDq10Nure1Vnt0hWVWqrOQ=;
	b=g5NJwL/EhEZTbLlpeW+Cc3veqPa2UQ4N8bbDNmZda7LVjM61svt54zGtR5jhMa9oX/ykL7
	mDNDgkBwMmqCy584SI8TTJ4AtVhXTsWs+F7f1a0xYkSoPGT5Oltjb5SCSJtmvMv7yu5+KK
	ScSlntlMxyTugqZ5lIexJO6nj1H5Rkc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-vlJ8GwEINyauPTlGxzVjOg-1; Mon,
 15 Sep 2025 14:11:26 -0400
X-MC-Unique: vlJ8GwEINyauPTlGxzVjOg-1
X-Mimecast-MFC-AGG-ID: vlJ8GwEINyauPTlGxzVjOg_1757959885
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81C161955E9A;
	Mon, 15 Sep 2025 18:11:25 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.89])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCF4E18004D8;
	Mon, 15 Sep 2025 18:11:20 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list)
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v2] rtla/actions: Fix condition for buffer reallocation
Date: Mon, 15 Sep 2025 15:10:56 -0300
Message-ID: <20250915181101.52513-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The condition to check if the actions buffer needs to be resized was
incorrect. The check `self->size >= self->len` would evaluate to
true on almost every call to `actions_new()`, causing the buffer to
be reallocated unnecessarily each time an action was added.

Fix the condition to `self->len >= self.size`, ensuring
that the buffer is only resized when it is actually full.

Fixes: 6ea082b171e00 ("rtla/timerlat: Add action on threshold feature")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>

---
v1 -> v2
* Put the commit message in imperative language

---
 tools/tracing/rtla/src/actions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index aaf0808125d72..af5f76bd1821b 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -49,7 +49,7 @@ actions_destroy(struct actions *self)
 static struct action *
 actions_new(struct actions *self)
 {
-	if (self->size >= self->len) {
+	if (self->len >= self->size) {
 		self->size *= 2;
 		self->list = realloc(self->list, self->size * sizeof(struct action));
 	}
-- 
2.51.0


