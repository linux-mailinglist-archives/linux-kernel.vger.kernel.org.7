Return-Path: <linux-kernel+bounces-890078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A359C3F335
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24CA44ECFD3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0AB3191BD;
	Fri,  7 Nov 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bW2p+G1o"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80C305063
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508339; cv=none; b=fHxl1OiHX807j5nfJkq12cB69kk9WNIvUzWA2o0cuQ1q9HOdMeY5LF/NSDZRofoAypz2axTPhZ1O17+2ai/42UO0ej5PAP7AgIZCBUv2VfiELd/jHL3jGb1vzgMZ92bLumLgUyy9mhW1J8npTSqicWMH0b+7n22v9BvPspmOSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508339; c=relaxed/simple;
	bh=pJYarinG64QGYNoerysou4U26mZrLZEoLM99oNZSxKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D/LxBy/UkAjOWOAamrlbJqtfZoMwkAqkqbXlLJpQ8wxdBJAs/6HR7V79hCMttjvayRgNS9S7VKdwOMJTWAw/b8lwYldYqe/3K8x84SM2hXRcnd76ej5+4qB8pu6THtWgGRfA9mKzbm9KqLCBz6vbE6VgSsY7eYyuqvZRtsHYzXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bW2p+G1o; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47769a0a13bso5373855e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508336; x=1763113136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=suZEunh3pTtEBOLilYte+fuuSjgEk7HCDOkHWJLiaf8=;
        b=bW2p+G1ok59IdElag+xAILrnlaP9sSSM61TerGcjVH0aEwWcHVGnM8Kld0qo/4j/Ev
         02ZzkzT5jsxp1GDYF9DQzY88w6sHOtHaWEQXbbN2UP9rBwUWEdMdv79/qAzD5ywjXk1E
         GMmnUhDEJeKJRSdq9S0uULDHejy3EBmmm5OY7m9ZmqEA2af1i0fN9NDMrTaNJuaiTICT
         8KUG9g4VLxk9wSRlUIo+l3/zeBVhVIFgbgfeisjAa0htrnXrTMd8DTdsFy6d3Ug3nsHj
         jg4DkU8p1IRUAznH6/QUJ0CCvQ72QP/5v+JRcrTOwlPh36IQYohk6vFx5kuBSpnK/zU9
         eXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508336; x=1763113136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suZEunh3pTtEBOLilYte+fuuSjgEk7HCDOkHWJLiaf8=;
        b=QZFbeOGMCtmoqZH7nLJD+TszP3KbMq8ncM6iwFUAIVyqf8NoSiwXhbuGAbB76DcxtF
         rYFEnlCLEHjloUGtaZ8t+YiOQrxveDukY1z8JF0jmArHZDbrZ1WP+opjLNxa/usm0AYx
         6j9DltcQxIc4B5zqmymCQYp6aw0ct8W240LSV3RWFTybNcMMV13XOJHnBeY2stKC/L6m
         liprCcoqKzariObOjYOkGEAGnEx8qeNTbzTpm1zhTvnK4UxMGOxBRAqJ9xm9Bdx8/jEQ
         KwXTaCCRzaLKBnODkeBrwugPCIFUtJecP3mCfyjPAt3kBDnZ5P3Q0sD8sdmqkPoVf6CL
         cWMA==
X-Forwarded-Encrypted: i=1; AJvYcCUCkudoen7jsm2vIiiZmbGANQ7skS/q4mMlOEjCTfJ7P8mvk+N7ZYghRhz7lSlg8Mt/eTg+zwRAsznpnvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNwXeqSxWDZkEQMMaoricKYhbeStqVj6FHzlHQEpwEVGEseon
	/Pl40SX3KaSfuJhfejehTW5w08zFzWE1H92ZvRIUpNkgxctxK+UBnRn9nRiCKb5ouRe5aXSHRMh
	tsM3jsheyR7biN+Cf91QdLA==
X-Google-Smtp-Source: AGHT+IFHffzR9bK7OBL/WwnulG3E8M/4OTfY/jrO+spwvfaNmVGfgI9sjXyGDvIOLNbKB7bUdo0nTOhEXUw06yoY
X-Received: from wmtf12.prod.google.com ([2002:a05:600c:8b4c:b0:475:c1fc:f10a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b38:b0:475:da13:256b with SMTP id 5b1f17b1804b1-4776bcca1ddmr18536495e9.38.1762508335761;
 Fri, 07 Nov 2025 01:38:55 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:20 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-9-vdonnefort@google.com>
Subject: [PATCH v8 08/28] tracing: Add init callback to trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a .init call back so the trace remote callers can add entries to the
tracefs directory.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
index 55754ef78104..15a579633123 100644
--- a/include/linux/trace_remote.h
+++ b/include/linux/trace_remote.h
@@ -3,11 +3,14 @@
 #ifndef _LINUX_TRACE_REMOTE_H
 #define _LINUX_TRACE_REMOTE_H
 
+#include <linux/dcache.h>
 #include <linux/ring_buffer.h>
 
 /**
  * struct trace_remote_callbacks - Callbacks used by Tracefs to control the remote
  *
+ * @init:		Called once the remote has been registered. Allows the
+ *			caller to extend the Tracefs remote directory
  * @load_trace_buffer:  Called before Tracefs accesses the trace buffer for the first
  *			time. Must return a &trace_buffer_desc
  *			(most likely filled with trace_remote_alloc_buffer())
@@ -23,6 +26,7 @@
  *			new reader-page from the @cpu ring-buffer.
  */
 struct trace_remote_callbacks {
+	int	(*init)(struct dentry *d, void *priv);
 	struct trace_buffer_desc *(*load_trace_buffer)(unsigned long size, void *priv);
 	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);
 	int	(*enable_tracing)(bool enable, void *priv);
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index a744bbf48e88..924e3f3ec6d2 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -837,6 +837,7 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv)
 {
 	struct trace_remote *remote;
+	int ret;
 
 	remote = kzalloc(sizeof(*remote), GFP_KERNEL);
 	if (!remote)
@@ -854,7 +855,11 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 		return -ENOMEM;
 	}
 
-	return 0;
+	ret = cbs->init ? cbs->init(remote->dentry, priv) : 0;
+	if (ret)
+		pr_err("Init failed for trace remote '%s' (%d)\n", name, ret);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(trace_remote_register);
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


