Return-Path: <linux-kernel+bounces-779241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 428F7B2F0C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 399CB4E2F48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEA62EA498;
	Thu, 21 Aug 2025 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SySG2Njy"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8F72EAD13
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764071; cv=none; b=nCQcMkzVQzwgMSOuUoCNZzoP01vuBAcKfRWHe7pDZRpwMrj/yuzWezilsrsqX+UC2KckF5Pfks5FvxbTMwPsK2a+zWzyMhXIaMkv7RJdHlATNFfKK5NfMBDba7Y9LMvOe9LRJ4Dq40QcBgF0M6muwcxky6EaY7ejkCCSwyVqzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764071; c=relaxed/simple;
	bh=MJnXwlr6sqtBLAgWRkDhxOXeIwiyUFY3sKB4i+iHGHs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LIH0WYKDy9uLmksUFFRwxdmYjmXjXoRM2WjHILsyvsDAZzaaDYdtw8lhBEXgkgPf+YfWLvemG1fLh4h1hTTEHbmBn4YD/cKOvNcCUdjIUBvkhCeM8W7E9rVJh4/8nca0z6WX23/32ijoj4EtvI+C5jn3bErVaRvI+z/Xr3gUMvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SySG2Njy; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9dc56225aso450864f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764068; x=1756368868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UeiQbqfd+7HFGphDDhTnjWkKTWOQraz9qW3YNATpZfI=;
        b=SySG2NjyTm92/ixhZeUPxPL+8jOoVevAYmrdJoyVXieOB33cTqQn9FEytN04pcFNRI
         CsTTSdWmqhHNapeH+nmmbdlzqVtAL9lCs26GY+lMiBF9Qyavxb2z4wtUU8VBejraOQoG
         JWnhK7bWCbpONh4CWoANVLiP8qDYI7pR7Y578fYJ66CEDhvAjfrfNR4q44r7lPOkTb7Q
         VaDq5AVx7fCFDFIyiDnYHqiP5piamyxMkJadLxEjblNMCTcSa8kOOmPd2mgu1ouxozuH
         xXT8e/FpHbNXN5qNN+p36YmHsWi1U9y46aqT0sIWVhxqM2xiVOhul4d6GOOLQdUF4/Hr
         L4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764068; x=1756368868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UeiQbqfd+7HFGphDDhTnjWkKTWOQraz9qW3YNATpZfI=;
        b=BWpNtAVJoxmZN2GDtOFrsUaOvh6x2fL8kfvZD9HHUyov0FHmgr3ixOep6WbU859JcG
         4V0rNJc0z4OEVMLfidOTIBR99DQ6dF6bPloKrQqZODFXxFyM+2wkl9QrOPTcN1KH/V7l
         jEgKZYMHw2tgtXl9tlVj0C09m1+NFv2JZqy6TEeZAl8wqyj77CYq3vYncdHD1dlrcDgT
         9xKSmYs1X8/nXIw69oamh9NqhOYExbBzSHS+fnXtNVZmDChcXw/3IngUWiQ5zf3661G4
         +qc68fAjwNIYLYC0qN7L+ZOM1CUKxtj6lwcAicdN4F2TITjrsClgB37YKARoPCaa7/dX
         jl5A==
X-Forwarded-Encrypted: i=1; AJvYcCUFBsiW3uv1jk9dSz2FnEKCJrrNYXdg6aPA+AhpOce6Ad4/Lwh8qMfy7widjptFpb+ss1zYDTBdlXn9qsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpgJc8RTIZcaNz3JYWreKJ7LozZpF3fK6bxLmMg31w4AfrClBv
	nvIlzsmuE0v75g+1+EmTMnboK4cVXNPHhcm+0Xcf/Xmnnoiz3YiXcZNScmrrQ8SqYV9BGgjrpiV
	aYOZOHOjSDvUXw3ewDJZp5Q==
X-Google-Smtp-Source: AGHT+IGPZ/UWfrK0SR54G2w2/hGND79Jxl9Aw93toJ+uqNkdy6qzcC80bA5lVYDqpW5CNdXw1Cx3m0UW7vJbU9iY
X-Received: from wmqc21.prod.google.com ([2002:a05:600c:a55:b0:459:dbaa:93aa])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2f86:b0:3b5:e714:9c1e with SMTP id ffacd0b85a97d-3c494fc5dbemr1259176f8f.12.1755764067796;
 Thu, 21 Aug 2025 01:14:27 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:13:53 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-6-vdonnefort@google.com>
Subject: [PATCH v6 05/24] tracing: Add init callback to trace remotes
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
index 1aa99da3c96a..82d26d97a536 100644
--- a/include/linux/trace_remote.h
+++ b/include/linux/trace_remote.h
@@ -3,9 +3,11 @@
 #ifndef _LINUX_TRACE_REMOTE_H
 #define _LINUX_TRACE_REMOTE_H
 
+#include <linux/dcache.h>
 #include <linux/ring_buffer.h>
 
 struct trace_remote_callbacks {
+	int	(*init)(struct dentry *d, void *priv);
 	struct trace_buffer_desc *
 		(*load_trace_buffer)(unsigned long size, void *priv);
 	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 18b2930186cc..8f8eb1f1e889 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -482,6 +482,7 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv)
 {
 	struct trace_remote *remote;
+	int ret;
 
 	remote = kzalloc(sizeof(*remote), GFP_KERNEL);
 	if (!remote)
@@ -498,7 +499,11 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 		return -ENOMEM;
 	}
 
-	return 0;
+	ret = cbs->init ? cbs->init(remote->dentry, priv) : 0;
+	if (ret)
+		pr_err("Init failed for trace remote '%s' (%d)\n", name, ret);
+
+	return ret;
 }
 
 void trace_remote_free_buffer(struct trace_buffer_desc *desc)
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


