Return-Path: <linux-kernel+bounces-817805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3701BB586C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30274C296E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7522C11D6;
	Mon, 15 Sep 2025 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgBXY5Ny"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FDA2C0F91
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971686; cv=none; b=lLBrB2HDZX8EMZbJxyaMRRzYd0EpdZQyQAIKyJtBDpw6gcFGNW2IgKbW4mXmSSU9z3usUZenNQwvR6WGvcBrc8FbMdOYlKlqQdD2lemw3TpyLQ/m1taupPWuMw5Z89ik+/lREdbNkv5MGtM/XQAjgYRAIbWrahyQeSDBf5CbZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971686; c=relaxed/simple;
	bh=ZYjsZu5y682FqE+uKVWDmTrQoUxx9+iRbsMKxGzoJxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WGbXtpbGUj2QDHJEX4hin627pzYmI6sRJRZx4I4mxR66m7yqzp07tpolw5HQpUHhRi1Oa9H7X7oyMFFgSTm+pv3dCvBOe6A6uFMtL9UpCKd7DkKg2bNet0KPq3tT0/MVqwVOi3S3hiLoismJOgtSRh4XnUrAa8cAOu18AVqhAYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgBXY5Ny; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32e0b0014d9so2178778a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757971684; x=1758576484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3medVd2qOWPEhfNfxl2kAO69G86t9hZitkKMHzJnpo=;
        b=cgBXY5Nyf58ycQjJm78UPyMep7EvbdcviX/FSjiQm5LXqbqVraLtk2qg4ssMBrOthA
         BhG3C83dN5HE0jg/ycbpD7TybL5/1Oitz7LBazXT44HuU//UINT+SeQy6JGKKxEFv0Wi
         PRuIPOyyy84/8QVfWXFeavZLEwiqbFCCOthoBIZvo1aoA0IpdkQDJbfrXfn9faVLqjxZ
         rz6n5BaVzzzw/eUGWQsRjNjZ46/u0ZCRZ+FylQAaxZMnP4Gb5Iuo/umTe4cvZl7muMWN
         u5j21jy4eVCfXqQ/addj5irfv5K5sLxtu/RGgFucDCF+6zU7NYMltJdLSuqF+zQkHuWD
         Sayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757971684; x=1758576484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3medVd2qOWPEhfNfxl2kAO69G86t9hZitkKMHzJnpo=;
        b=VhrM2ZicB8ox5/ChLUTD3p+U/hVCwwnvganASoBSVz8OnYnrxDn0dw3kd4b0uR4hZ3
         dKeDTFFVNfXJEI42IM2eEtrPQurN0lfvHfYk2MOfHjgvaOS3pz8JLPukc8udnA57Dhku
         /vPaKSsqFSM14Cg1cd+VkiImP+v44fliMojI+jBy1Z9o9Ji/wP7fUP8er5+NFuq5/2/l
         X+GRvqH6AC62GuHr058ltDmUYshNSyvmgQTFujjflmyYVA00/DXkOIHmZ/1V0nv0weQU
         H/IPDGxhJvIQSYmWUP659R73VvQR3rsb9eBgoj711VcmArTiSm7SviqKa/xyYNizXnoJ
         cUfA==
X-Forwarded-Encrypted: i=1; AJvYcCWo0cRuQX66MCHfWdtS5sakTd0mv5BpnUesH1BVU0IoAytRfg6OadrRTuWzL8smW+YefSwySIYxXy0WrHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBDKLWm2OJUgq0a4WqUuCrGMx5/1m/myT4TYV3hLLKdBK4Z1CP
	HJYsfZv+9cb1qmyevyMpDgXbYGbiI/g/uvp0Q/XoL1oDO/nUcrYkMHIQLM6408b2SGhChuOX6mh
	IYIqKCA==
X-Google-Smtp-Source: AGHT+IG0byYP3KTrWemnIN9/oKJgT5zEjyVGWK/0nxIQCBnj0mlAmsfNkBFjneyG7fIPiFxNWh348vRy8yI=
X-Received: from pleb12.prod.google.com ([2002:a17:902:d40c:b0:264:6a57:a799])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b88:b0:246:eb4d:80c8
 with SMTP id d9443c01a7336-25d2675de07mr140073345ad.34.1757971683955; Mon, 15
 Sep 2025 14:28:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:27:55 -0700
In-Reply-To: <20250915212756.3998938-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915212756.3998938-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915212756.3998938-3-surenb@google.com>
Subject: [PATCH v2 2/3] alloc_tag: prevent enabling memory profiling if it was
 shut down
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Memory profiling can be shut down due to reasons like a failure during
initialization. When this happens, the user should not be able to
re-enable it. Current sysctrl interface does not handle this properly
and will allow re-enabling memory profiling. Fix this by checking for
this condition during sysctrl write operation.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Usama Arif <usamaarif642@gmail.com>
---
 lib/alloc_tag.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 715315f5d9ba..f79217427d81 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -766,6 +766,20 @@ struct page_ext_operations page_alloc_tagging_ops = {
 EXPORT_SYMBOL(page_alloc_tagging_ops);
 
 #ifdef CONFIG_SYSCTL
+/*
+ * Not using proc_do_static_key() directly to prevent enabling profiling
+ * after it was shut down.
+ */
+static int proc_mem_profiling_handler(const struct ctl_table *table, int write,
+				      void *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (!mem_profiling_support && write)
+		return -EINVAL;
+
+	return proc_do_static_key(table, write, buffer, lenp, ppos);
+}
+
+
 static struct ctl_table memory_allocation_profiling_sysctls[] = {
 	{
 		.procname	= "mem_profiling",
@@ -775,7 +789,7 @@ static struct ctl_table memory_allocation_profiling_sysctls[] = {
 #else
 		.mode		= 0644,
 #endif
-		.proc_handler	= proc_do_static_key,
+		.proc_handler	= proc_mem_profiling_handler,
 	},
 };
 
-- 
2.51.0.384.g4c02a37b29-goog


