Return-Path: <linux-kernel+bounces-627319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98DBAA4EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 16:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46ADE189CFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627A214F121;
	Wed, 30 Apr 2025 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P09P+PND"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AD224FA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024473; cv=none; b=BCzqLuA6zLiGOkG71XIT87c+Yb5KchISptw45FTib7s7M8W/+qiyn4JyHyqCtMwyYWTbmv7bqoEk6AyeAes5EvjhM+hxShGy0swaHzA4g8nKqUaChTvzhjUu/JhR/HWaBhqsvaLLS2wRqUi3E75lFvR2FMNrNLI1MnU68kA6Pdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024473; c=relaxed/simple;
	bh=9FbI4iDnwTpTAY+YU9I/kKwfYtr8coFCU2EkaG4Geq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2/+ulIGXoTefy4ZADKnsNAhp5wsQWIH9RQdr01T0p6OwAcbVjIZbnS+DrM+ubWvQ4RHNi5Zj11kY7jD+kQrveDhpbqRsbsV1pu34wIHYsxtXs7IwGVTQ4CEh3VP7lasBYnWJmJDB8sAnEaB+EX9+CZ53BihtAcumj1ToGAtbFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P09P+PND; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746024470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A0Lp/l1XGF0IIqzu2ayeTTfaG0q1R1kxW5lgjOGrT9Q=;
	b=P09P+PNDgGM+KbX6QxRypscbxNPwn7s4qN4jD4fZLejqK1S9QfkIU5rnwjDAQf2poE4eZI
	xI37nuIPUTP9jetJ4zhAmqK0XVSkyiWEBpupsNkg4JhIsNXzs+4k/xHN7Tfqa8Q46tYCUw
	Ml/DM4mOhvuhGF9oPh/IV6xpRj1fS5E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-xCLWlHYYNmO5ljFxYElYrg-1; Wed,
 30 Apr 2025 10:47:49 -0400
X-MC-Unique: xCLWlHYYNmO5ljFxYElYrg-1
X-Mimecast-MFC-AGG-ID: xCLWlHYYNmO5ljFxYElYrg_1746024468
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 720431800373;
	Wed, 30 Apr 2025 14:47:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.167])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3784D1954B02;
	Wed, 30 Apr 2025 14:47:45 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rtla: Define _GNU_SOURCE in timerlat_bpf.c
Date: Wed, 30 Apr 2025 16:46:51 +0200
Message-ID: <20250430144651.621766-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Newer versions of glibc include a definition of struct sched_attr in
bits/sched.h (included through sched.h which is included by rtla).
Commit 0eecee340672 ("tools/rtla: fix collision with glibc
sched_attr/sched_set_attr") has modified the definition of struct
sched_attr in utils.h, so that it is only applied with older versions of
glibc that do not define it, in order to prevent build failure.

The definition in bits/sched.h depends on _GNU_SOURCE.
timerlat_bpf.c does not define _GNU_SOURCE, making it fall back to the
definition in utils.h. The latter has two fields less, leading to
shifted offsets of struct timerlat_params in timerlat_bpf_init.

Because of the shift, timerlat_bpf_init incorrectly reads
params->entries as 0 for timerlat-hist and disables the creation of
histogram maps, causing breakage in BPF sample collection mode:

$ rtla timerlat hist -d 1s
Error pulling BPF data

Fix the issue by also defining _GNU_SOURCE in timerlat_bpf.c.

Fixes: e34293ddcebd ("rtla/timerlat: Add BPF skeleton to collect samples")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 5abee884037a..0bc44ce5d69b 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #ifdef HAVE_BPF_SKEL
+#define _GNU_SOURCE
 #include "timerlat.h"
 #include "timerlat_bpf.h"
 #include "timerlat.skel.h"
-- 
2.49.0


