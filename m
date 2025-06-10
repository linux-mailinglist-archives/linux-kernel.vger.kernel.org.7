Return-Path: <linux-kernel+bounces-679044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A264DAD31B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 11:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9631731B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AC728B41D;
	Tue, 10 Jun 2025 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyznDC6i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29BE28B3FF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547190; cv=none; b=jnJTDIwe3eacCLmz9I34ke8BByROHRRNlZ2dCkdv5ST919jINRRlymI1FUrSC91tACzVylMnj26moThNTczdMKcnqTce0cD2SRbLwVsZOxpDkXK2J/NQm6rZXl0x5MpBtIRZliHfwJfjxp7pb6/W7svb+Vf48UqNnjE1GYRwpyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547190; c=relaxed/simple;
	bh=ltjpKWi1t7lbiS/wQUL0JGtR6xxe81f0cE/kMQ+SMZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leu8x+I21fbmJmHyHGOqVTPFzJ0Gmnj/F7G/8iYY9dl7QUTA0J2JhL4wQdhHsm4NR8Q4VzML00zbghImlI1qp0IRvuNZOttcaGjjAMZ9SZbd9BN9nlxYobw0QRQeqKJSXXP1y+fdEJCOvhCmEDlzgIq3lhZ0slImM7whr1JJn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyznDC6i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749547187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIyeiHyJh2LLkv/UD+/4q8cYY7zOw5NP6NFKW3iCjws=;
	b=XyznDC6i9VP8+T+daLm6yOZmNOojQYOhQjbei1Q1/HQeVRnRobSRjnanTfVKkFKGhFal/S
	hPq973EwVtMIpcq7x4Ms43lmu880YFkL6StDzngXif0bULZRJkgo45a4zb2Zx3duQGOJHc
	T5TNr7PtY0VCYL2JsG3Joj+WNFX/cDc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-h22P7FUaMCq4i0r-ayQMAQ-1; Tue,
 10 Jun 2025 05:19:44 -0400
X-MC-Unique: h22P7FUaMCq4i0r-ayQMAQ-1
X-Mimecast-MFC-AGG-ID: h22P7FUaMCq4i0r-ayQMAQ_1749547183
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F393818002EC;
	Tue, 10 Jun 2025 09:19:42 +0000 (UTC)
Received: from fedora (unknown [10.45.225.84])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7E3C530001B1;
	Tue, 10 Jun 2025 09:19:39 +0000 (UTC)
Received: by fedora (sSMTP sendmail emulation); Tue, 10 Jun 2025 11:19:38 +0200
From: "Jerome Marchand" <jmarchan@redhat.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [PATCH v2 1/2] bpf: Specify access type of bpf_sysctl_get_name args
Date: Tue, 10 Jun 2025 11:19:32 +0200
Message-ID: <20250610091933.717824-2-jmarchan@redhat.com>
In-Reply-To: <20250610091933.717824-1-jmarchan@redhat.com>
References: <20250527165412.533335-1-jmarchan@redhat.com>
 <20250610091933.717824-1-jmarchan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The second argument of bpf_sysctl_get_name() helper is a pointer to a
buffer that is being written to. However that isn't specify in the
prototype.

Until commit 37cce22dbd51a ("bpf: verifier: Refactor helper access
type tracking"), all helper accesses were considered as a possible
write access by the verifier, so no big harm was done. However, since
then, the verifier might make wrong asssumption about the content of
that address which might lead it to make faulty optimizations (such as
removing code that was wrongly labeled dead). This is what happens in
test_sysctl selftest to the tests related to sysctl_get_name.

Add MEM_WRITE flag the second argument of bpf_sysctl_get_name().

Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 kernel/bpf/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 84f58f3d028a3..76994c204b503 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2104,7 +2104,7 @@ static const struct bpf_func_proto bpf_sysctl_get_name_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
-- 
2.49.0


