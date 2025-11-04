Return-Path: <linux-kernel+bounces-884616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1711BC309AA
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9C974F5DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EBC2DFF0D;
	Tue,  4 Nov 2025 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLM8IlwG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A212DF12B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253313; cv=none; b=BXkmeFtlD8DQievnxMgGg0IFFVi67GqXcys4zPsvWNrFFeC/vcKcix+stynTE2GMSGkQ68bXBZWxwXlJYHtiqlvHhH2TMTF7/H1VdMMnxqx01m5hW1tcxsAjfORRJ6CUkBKqJEvLcHXNv55kxzxgoBFdiYYwLC8PkI1sNzLmreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253313; c=relaxed/simple;
	bh=TgcaamcYFlNYP3j2I7YVDqzHAy8sV2FdiA8R/ossKSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hfapikeie5QgmaKReqyxShv/pNJpJgWMQw79xRBSr8QMxCRc9a2AG10ldiUw8NyRA6y7+QAT2e1ITH7iTJvtym9TllV9HiyIQ8r+1e8hSOMfgt9CRqvLtSitpwjWiEetLwGHNrfghAeKXW9xDqS0N6dkNgUAehwGahWSxwdeLKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLM8IlwG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762253310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csCqVvvzWICBoORejGRY5waG68B86YeG6BhiVdHImg0=;
	b=WLM8IlwGhW4CPkSZbxhxeHh8ygRnu+XaVFVzHMk7A/cCpLgIFPg0ciMWTC/LiX6Wo0ugLe
	TFR5tbMEHwksbqaIYHYCoRbw3hvTGEF3EnTEjdjrJN6V+izt/JmDmR49qw95+6EwDFCuCm
	dFoOFtSLVhnf0b0WnzgCwBv5z+JfWSk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-tBF6BuxjMJWUr9Ud3jg8jQ-1; Tue,
 04 Nov 2025 05:48:29 -0500
X-MC-Unique: tBF6BuxjMJWUr9Ud3jg8jQ-1
X-Mimecast-MFC-AGG-ID: tBF6BuxjMJWUr9Ud3jg8jQ_1762253308
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F0521800592;
	Tue,  4 Nov 2025 10:48:28 +0000 (UTC)
Received: from eda-pc.redhat.com (unknown [10.45.224.83])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EA7A1800451;
	Tue,  4 Nov 2025 10:48:25 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <llong@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v14 6/7] cpumask: Add initialiser to use cleanup helpers
Date: Tue,  4 Nov 2025 11:47:38 +0100
Message-ID: <20251104104740.70512-7-gmonaco@redhat.com>
In-Reply-To: <20251104104740.70512-1-gmonaco@redhat.com>
References: <20251104104740.70512-1-gmonaco@redhat.com>
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
no-op when CPUMASK_OFFSTACK is disabled (initialisation optimised out
with -O2).

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/cpumask.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index ff8f41ab7ce63..68be522449ec5 100644
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
2.43.0


