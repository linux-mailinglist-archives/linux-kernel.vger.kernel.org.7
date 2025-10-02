Return-Path: <linux-kernel+bounces-840432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D3ABB4684
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FCD17A33A2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312122356C6;
	Thu,  2 Oct 2025 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfiNzhNC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCD1DED63
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420477; cv=none; b=WWe7/diaJPRyhxHmtThHd5nNtEZQm/ZU9T2957NhLdrI5OwoRXzDnU1pISlgCQhrMF+7IjDH+cZDz3V5ZtTCXDbnZVZvM3UT56c2mB2FEuAyf5K1tg+EGXgejluGq6itLPcps6K/L4ktP9HrcwtCphjW1btF4mO9Sk0KNQe6yLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420477; c=relaxed/simple;
	bh=I7Y+Mjnls8k0ABWDnwpu1wtXQPHjQ8esyz8RTghTA6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pn9D6x2epPBTyBDB+XZkSG9QwMzDUrNG3D4ek4l6TnelFKJepVKV6kL6GGaqGlbdss+bcl7NqH9NzVTFbAYroe6H6i9AzVaANGEZb6IjuBzE4x0kzU+x8HYXajq5g0Jr0bnK8OM5fxnIeTo4Ea4fIfL659E1y/JhjWLacgCBpoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TfiNzhNC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759420474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=obRbji6GklroAykeBLLoI0W4RXQ2A2jgpCxrAePKjvU=;
	b=TfiNzhNCOgOTNotoyLBwpzrb95MjS8D/cox3mXcPHGonK+S1dqYFXnmHjuCg5oLrItUE/p
	Pq+4GWBaWE1BKZuBbxPT7LT5pWciob54tLr5zpw05CZTcOuEM+RHokicC5h4ILUzMPeDpe
	UJAW69UYiP1E7kvrRVvbSkO28uLHCkU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-1br6Ph0oNCufNEXaDUYfmA-1; Thu,
 02 Oct 2025 11:54:31 -0400
X-MC-Unique: 1br6Ph0oNCufNEXaDUYfmA-1
X-Mimecast-MFC-AGG-ID: 1br6Ph0oNCufNEXaDUYfmA_1759420469
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5039180048E;
	Thu,  2 Oct 2025 15:54:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 55005300018D;
	Thu,  2 Oct 2025 15:54:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: freude@linux.ibm.com,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/uv: Fix the comment of the uv_find_secret() function
Date: Thu,  2 Oct 2025 17:54:23 +0200
Message-ID: <20251002155423.466142-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Thomas Huth <thuth@redhat.com>

The uv_get_secret_metadata() function has been removed some
months ago, so we should not mention it in the comment anymore.

Fixes: a42831f0b74dc ("s390/uv: Remove uv_get_secret_metadata function")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/kernel/uv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 47f574cd1728a..324cd549807a5 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -866,8 +866,8 @@ static int find_secret_in_page(const u8 secret_id[UV_SECRET_ID_LEN],
 	return -ENOENT;
 }
 
-/*
- * Do the actual search for `uv_get_secret_metadata`.
+/**
+ * uv_find_secret() - search secret metadata for a given secret id.
  * @secret_id: search pattern.
  * @list: ephemeral buffer space
  * @secret: output data, containing the secret's metadata.
-- 
2.51.0


