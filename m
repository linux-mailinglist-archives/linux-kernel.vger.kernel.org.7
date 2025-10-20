Return-Path: <linux-kernel+bounces-860747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80740BF0D62
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 596064F42C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD872FD7A5;
	Mon, 20 Oct 2025 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvXk5yyN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DABE2FCBF5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959720; cv=none; b=XHV5mlfpStsLwadyAWG+v716veHHaDC6d2OkcjPuwUjFlvWn1d1LYtEARIHqsavKJxLpBBiODfqm58z/bPxYbWni3DmZy5i6hz67qGb6YV0oFP2/CrQhJPKlC/Tkrm38knu4jqYm4o3ezNKUIXXO4Rpkl1PEeHdW9cwt2bf9CwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959720; c=relaxed/simple;
	bh=qm8Yt90bC4+rDVjNlCcJoEoXEiUNYFkTmoFYDaEmCdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Btd7HCEyjShnaPpq1jV5pK0ojlIcSHfHqZu3KfW92b84SOR2L4Cn1OEdh9sG3g54/f/0VcwAbQP245HZ/sMIyxRTYfKeVM4T25V6uWjOlUE2DIqn+Hw8s3P0SgLYTNp1a0poW+S1K66AWFrpZH7NCpOIZKdqpCqW4OgLh1TcFmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvXk5yyN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760959718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbNOrNjTFyIKoCZd27FoUXKJCuJbHmbcHVH50vwCeB0=;
	b=YvXk5yyNzTI1yuP/Sxr7lMSdCPQqd7+jJcAIYwOQJnxsbcEDKOTdx4uSaChM+goZfmMJ6W
	oDO3VyFTv0OxzyOOoBji6w1/lmu1Wci2of89pKQkmUXMcqcgLXTw0jfbuzrMdF5cABAu08
	zJLsRJScRLH3E3het8mbVN5aKRMp9fc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-JsobMn85PXCKaGkqFS2HpQ-1; Mon,
 20 Oct 2025 07:28:35 -0400
X-MC-Unique: JsobMn85PXCKaGkqFS2HpQ-1
X-Mimecast-MFC-AGG-ID: JsobMn85PXCKaGkqFS2HpQ_1760959713
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB77B195609D;
	Mon, 20 Oct 2025 11:28:33 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF2E31955F1B;
	Mon, 20 Oct 2025 11:28:30 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [RESEND PATCH v13 8/9] cpumask: Add initialiser to use cleanup helpers
Date: Mon, 20 Oct 2025 13:28:01 +0200
Message-ID: <20251020112802.102451-9-gmonaco@redhat.com>
In-Reply-To: <20251020112802.102451-1-gmonaco@redhat.com>
References: <20251020112802.102451-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Yury Norov <yury.norov@gmail.com>

Now we can simplify a code that allocates cpumasks for local needs.

Automatic variables have to be initialized at declaration, or at least
before any possibility for the logic to return, so that compiler
wouldn't try to call an associate destructor function on a random stack
number.

Because cpumask_var_t, depending on the CPUMASK_OFFSTACK config, is
either a pointer or an array, we have to have a macro for initialization.

So define a CPUMASK_VAR_NULL macro, which allows to init struct cpumask
pointer with NULL when CPUMASK_OFFSTACK is enabled, and effectively a
no-op when CPUMASK_OFFSTACK is disabled (initialisation optimised out
with -O2).

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/cpumask.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index ff8f41ab7ce6..68be522449ec 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1005,6 +1005,7 @@ static __always_inline unsigned int cpumask_size(void)
 
 #define this_cpu_cpumask_var_ptr(x)	this_cpu_read(x)
 #define __cpumask_var_read_mostly	__read_mostly
+#define CPUMASK_VAR_NULL		NULL
 
 bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node);
 
@@ -1051,6 +1052,7 @@ static __always_inline bool cpumask_available(cpumask_var_t mask)
 
 #define this_cpu_cpumask_var_ptr(x) this_cpu_ptr(x)
 #define __cpumask_var_read_mostly
+#define CPUMASK_VAR_NULL {}
 
 static __always_inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 {
-- 
2.51.0


