Return-Path: <linux-kernel+bounces-821321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F0FB80F79
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083B31C83260
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFD42FB0BA;
	Wed, 17 Sep 2025 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+gKH5MA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A134BA49
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126046; cv=none; b=cUaDx5sWmdGLuiq+L5UDF8Iodo1YaIQ0ho0ZwgPsEFfEVFd9FD7PBZxv4plQSP5JuOcKVlHkXTcWUu045AV4ijn3lZMOmK94G2hvn1A+5bP+7fvzbndXAXyJmMebROcO5rD6gUEf6tmqylYXmo1GlcgeRQRx2x+4qsBBHij0Nrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126046; c=relaxed/simple;
	bh=n6LMEIcuoolJpth7pN4hIkhLamDQXi/2VrINutz5cUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFL/l10jqS44OFLUO6E02PdEgx4FDLlHmI3iINWVwAO/lsuXzxGKH+idOlLVOzd5gUMICyomROx9at4Pbz+gVA2jsRcX6W0uy7oCgshQ+ErTOmrhb7e4DZ9IpWSCKeil2RqNiNPUj5EIJgPiJgoUAC27SgHrDCKYlz0TawmBca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+gKH5MA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758126043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QZCuuO1uxqVkvMcW4eNgitUnGt7YSRGNgF2/LsKi88=;
	b=B+gKH5MAplsB+1IZIWoOv8oENIb4PTVuiN9UUa96WjrHAllCs4pf+eLyEeeIVVE3nWhB7i
	7ojUNAiB9gvF3hJ1HswdProLRw/sL4UM7UbQo+ji5MtBvQh0Vy20B2wftKfo01g2elc0zz
	XlZFSGqJeaP5FGyHIL7r23ebTGf+WNQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-zbGcU_XqNk6hAKDblkbKZg-1; Wed,
 17 Sep 2025 12:20:36 -0400
X-MC-Unique: zbGcU_XqNk6hAKDblkbKZg-1
X-Mimecast-MFC-AGG-ID: zbGcU_XqNk6hAKDblkbKZg_1758126035
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4871718002C1;
	Wed, 17 Sep 2025 16:20:35 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.34.168])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1982E1800446;
	Wed, 17 Sep 2025 16:20:31 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v13 8/9] cpumask: Add initialiser to use cleanup helpers
Date: Wed, 17 Sep 2025 18:19:57 +0200
Message-ID: <20250917161958.178925-9-gmonaco@redhat.com>
In-Reply-To: <20250917161958.178925-1-gmonaco@redhat.com>
References: <20250917161958.178925-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
no-op when CPUMASK_OFFSTACK is disabled.

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


