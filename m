Return-Path: <linux-kernel+bounces-844073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A8ABC0EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A7144F4137
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77AB2528FD;
	Tue,  7 Oct 2025 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0+q1y1n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608C2D838C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830845; cv=none; b=Vn3xQHkAIEibAnNTWIYYdJSvXK7uncOQfzrN2ZJnTU+1WlwWKKmMTNzfkFEKqysUXG/JG1AOF3oNb+2b/Wjrqj5iZ+yXLWwNbZkKLlyltFL+98mWrQBCRXHylMuQvG2TuJfWLDv09+L6kkMa0wHSFaGgpzsJNLZQIg5lyTSl8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830845; c=relaxed/simple;
	bh=MJiuNRpPHLVD29a/ZcdGzFuf+NDAS2lVUWVisl/IK/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ND8tQNttbT8ffkSuRZGjKspkDH+w67tM2NjWU0slhaxv/ooG+hvTAyHaMzZlVcU9XzstvUdya3UIb0j3XPU8/zM7zBMTLzoZ69VdKJ2X0XgXyu24klfNlbvAPXrOoEMsOhLUpUFcFWv6DmiFqhupHmMZRgfHxgttypwPV+vML4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D0+q1y1n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759830841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyxW+zClT1XHyW3+zcVLZBqxnXXOR3cakLg9SrnqEpo=;
	b=D0+q1y1nt9j1P8ww2u8XfgNoEBMPFuIetFi/PUnd9tTwYznY+Nz3dP/K8NJLaGQlQqrHuh
	QZ82HLxFhmmdHj1rzsE2YHtqGgvkxnSXeO94T2BQK1s1a+bDUov/XRLSCeb5zpjfr5M3YE
	1D41CdJRgH1yzma2mct5s8bC6Vsm2VQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-FXICk_v-NMulref1Pm6AFg-1; Tue,
 07 Oct 2025 05:53:57 -0400
X-MC-Unique: FXICk_v-NMulref1Pm6AFg-1
X-Mimecast-MFC-AGG-ID: FXICk_v-NMulref1Pm6AFg_1759830836
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80BA218004D4;
	Tue,  7 Oct 2025 09:53:56 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.244])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2B11180057B;
	Tue,  7 Oct 2025 09:53:53 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 3/3] rtla/tests: Fix osnoise test calling timerlat
Date: Tue,  7 Oct 2025 11:53:41 +0200
Message-ID: <20251007095341.186923-3-tglozar@redhat.com>
In-Reply-To: <20251007095341.186923-1-tglozar@redhat.com>
References: <20251007095341.186923-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

osnoise test "top stop at failed action" is calling timerlat instead of
osnoise by mistake.

Fix it so that it calls the correct RTLA subcommand.

Fixes: 05b7e10687c ("tools/rtla: Add remaining support for osnoise actions")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/osnoise.t | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 08196443fef1..396334608920 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -37,7 +37,7 @@ check "multiple actions" \
 check "hist stop at failed action" \
 	"osnoise hist -S 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1# RTLA osnoise histogram$"
 check "top stop at failed action" \
-	"timerlat top -T 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
+	"osnoise top -S 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
 check "hist with continue" \
 	"osnoise hist -S 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
 check "top with continue" \
-- 
2.51.0


