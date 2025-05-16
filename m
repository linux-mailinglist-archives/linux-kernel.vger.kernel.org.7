Return-Path: <linux-kernel+bounces-651356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBFDAB9DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 15:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AEE3AFFEA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26B874C08;
	Fri, 16 May 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTYxpKlN"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C2155725
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402845; cv=none; b=Hlv7DJtw3QMFNeJjV1/DVSUqVv2ELJVRobG0qxaUjCw4CYU1J7cWgW+U+SLRMJP5pQ925QmB4pkcaMAQnEK6eYoMD3Ka0B0DfG9SlIk8N50qH7r1lfeHvBeMOZqMxUU7HHlFDOk9YPJkf6J6csDgsTHo1CykUaaAiOcPcRi3P3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402845; c=relaxed/simple;
	bh=YFkzXccah27/yG/QJUAXKmAFqo/R3OMiygNwFMlOMH0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=psoRwaFaZfeA2HOsJd2+Yi2vDLUTFXKjrlQ6T/iJw23MSBql24upCB1SbiVr7kNZuxII+tPuNLMcfg3wDiA+gn9eZ1hlIBa1hutPoL4Zw653WD5cuJuLT7KGsK9kjE4rYvlAmc9VhrLCSHjWRJG5KdZwPtTdvq0DjOq2gS4nCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTYxpKlN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cec217977so12543745e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402842; x=1748007642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qN1qLB688cXUuZ/HXgT/LV4b04RQzcH3V2EM2BOQMbg=;
        b=RTYxpKlNGamyosF7u7fGYxhfu+dKQEZJpk8JTJVLB619Ne3p2CgA0rVcE0PB+q16MH
         FtXCLrQyU5lQsYOHxLKrteNHliU+sW28OL2h+m5EdN/JwoTgpWFEx7u6P4nk4aNBD87d
         yHzjEUOu0+S8e6ozBcfF9S4PXItuiBiWZ/lPE0RMQ8x9MyOrOCg2Y7i8gDwekNXSS9xU
         WvTKVng0eVUTSygtgn+jaQNDnquiQdNE/aPKbMjhQxnQFqvRHUX4BemjhE5wbMjtr8y7
         ywL6GDC1V511z0QosKCd53/Uxz7E1HSQfX2ghuxmzV/KGMpDd0ZQy4/U4Y0V1TS2z/Ap
         Qklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402842; x=1748007642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qN1qLB688cXUuZ/HXgT/LV4b04RQzcH3V2EM2BOQMbg=;
        b=XcSJ+2QLBVz0wRnV24QA25OPlDxuFIFWddJNy9sBW39RsZOxClupeLDDyi0NOPl/kC
         kVlsDJQfd0gz22h2zrjafnFBt0htds7EIIZABKVStZoZJqX77w5yOpdXG92YwsBG92Eg
         2UR9eAXVs0a+vrlSTvBBTT8bFX0s2Fzivh4A2GVKubkhL1tJO+dcCliCdVWP3nQgeAWr
         42wUqZfRRciceDyh6KpBZ5LiUAKRxt7SfCwhmIVMq03STN2G8yMypZ3OR+PQcFKmcURd
         urh8xHfS1Z1GBMT67Sv1+r4eAVg+/FEGnS5+RN9mfv5gOf1xmmJ2YOIsUHaJfr8RPW7J
         +/LA==
X-Forwarded-Encrypted: i=1; AJvYcCUBbUKW69Eg8MV+ySTaNzrhgTIGDaAtzYzeyhLXSKD4+hMJOTYs+36wW0crao3bMBGAl2/qTJPfkoAwkKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW6CCgCoIgQEtB86HyZppQpKVv8U3g9POjuBq3ra2PlBVX4SsZ
	Trm8G34bJEa+/qr6GTUhxMhgwDPeaGfvwepHSUBBoVoPT/Y2e8MUjhY4pFzgGJB7yidm9ZcdQXs
	ATPuWCWWdxy225O5K9j+x9g==
X-Google-Smtp-Source: AGHT+IFb0Ij3JAOsUyjNFzFS5ss/HuZjvc5vWhAsggz5dTMhe7SD0zTpYBX4PqyTUjGk2jMHuKx1WSKXkXFzSm0+
X-Received: from wmbbh10.prod.google.com ([2002:a05:600c:3d0a:b0:43e:9aac:5a49])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d28:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-442fefee236mr24868925e9.14.1747402841965;
 Fri, 16 May 2025 06:40:41 -0700 (PDT)
Date: Fri, 16 May 2025 14:40:10 +0100
In-Reply-To: <20250516134031.661124-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516134031.661124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516134031.661124-5-vdonnefort@google.com>
Subject: [PATCH v5 04/25] tracing: Add reset to trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

For standard trace instance, "trace" files allow to do non-consuming
read of the ring-buffers. This is however not applicable to ring-buffer
remotes due to the lack of support in the meta-page. Nonetheless this
file is still useful to reset a ring-buffer so let's add a write-only
version.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
index de043a6f2fe0..1aa99da3c96a 100644
--- a/include/linux/trace_remote.h
+++ b/include/linux/trace_remote.h
@@ -11,6 +11,7 @@ struct trace_remote_callbacks {
 	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);
 	int	(*enable_tracing)(bool enable, void *priv);
 	int	(*swap_reader_page)(unsigned int cpu, void *priv);
+	int	(*reset)(unsigned int cpu, void *priv);
 };
 
 int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv);
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 1a4786b7970c..18b2930186cc 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -63,6 +63,7 @@ static int trace_remote_load(struct trace_remote *remote)
 	rb_remote->desc = remote->trace_buffer_desc;
 	rb_remote->swap_reader_page = remote->cbs->swap_reader_page;
 	rb_remote->priv = remote->priv;
+	rb_remote->reset = remote->cbs->reset;
 	remote->trace_buffer = ring_buffer_remote(rb_remote);
 	if (!remote->trace_buffer) {
 		remote->cbs->unload_trace_buffer(remote->trace_buffer_desc, remote->priv);
@@ -136,6 +137,21 @@ static int trace_remote_disable_tracing(struct trace_remote *remote)
 	return 0;
 }
 
+static void trace_remote_reset(struct trace_remote *remote, int cpu)
+{
+	lockdep_assert_held(&remote->lock);
+
+	if (!trace_remote_loaded(remote))
+		return;
+
+	if (cpu == RING_BUFFER_ALL_CPUS)
+		ring_buffer_reset(remote->trace_buffer);
+	else
+		ring_buffer_reset_cpu(remote->trace_buffer, cpu);
+
+	trace_remote_try_unload(remote);
+}
+
 static ssize_t
 tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -370,6 +386,26 @@ static const struct file_operations trace_pipe_fops = {
 	.release	= trace_pipe_release,
 };
 
+static ssize_t trace_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct inode *inode = file_inode(filp);
+	struct trace_remote *remote = inode->i_private;
+	int cpu = RING_BUFFER_ALL_CPUS;
+
+	if (inode->i_cdev)
+		cpu = (long)inode->i_cdev - 1;
+
+	guard(mutex)(&remote->lock);
+
+	trace_remote_reset(remote, cpu);
+
+	return cnt;
+}
+
+static const struct file_operations trace_fops = {
+	.write		= trace_write,
+};
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d;
@@ -400,7 +436,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	    !trace_create_file("buffer_size_kb", TRACEFS_MODE_WRITE, remote_d, remote,
 			       &buffer_size_kb_fops) ||
 	    !trace_create_file("trace_pipe", TRACEFS_MODE_READ, remote_d, remote,
-			       &trace_pipe_fops))
+			       &trace_pipe_fops) ||
+	    !trace_create_file("trace", 0200, remote_d, remote,
+			       &trace_fops))
 		goto err;
 
 	percpu_d = tracefs_create_dir("per_cpu", remote_d);
@@ -422,7 +460,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 		}
 
 		if (!trace_create_cpu_file("trace_pipe", TRACEFS_MODE_READ, cpu_d, remote, cpu,
-					   &trace_pipe_fops))
+					   &trace_pipe_fops) ||
+		    !trace_create_cpu_file("trace", 0200, cpu_d, remote, cpu,
+					   &trace_fops))
 			goto err;
 	}
 
-- 
2.49.0.1101.gccaa498523-goog


