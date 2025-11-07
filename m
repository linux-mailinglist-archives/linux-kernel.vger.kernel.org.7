Return-Path: <linux-kernel+bounces-890077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 578D6C3F32C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E20A34D080
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008531195A;
	Fri,  7 Nov 2025 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNSl+/i9"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76656302CC3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508337; cv=none; b=n4S02O6EefEfl1N+f6+l5emzGK5wqENgMytlRAKE/Zf/Kx+Neiw9gBPNmw3UAxI5b81cYD3qzqlQVvha2jpPGXOE+RGt7ugQlmyWgcbIkY21UwXIa1ug9kWG7/eop6VJuVMMc5stfw03LJFRuBQFPe0fzLxYXcQEfgkTzX0AKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508337; c=relaxed/simple;
	bh=jEEXGy35HUpQAP9zQUnxHJyKz/LFgG7vcsNpQLwnFy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=chPH0zr4ptVnI8l63yLkwy4BhUBeFx/XemP8nHTisO1IRHmTrlCK1/3cBAG7T4UkDLfYqiSNmzq4pV+4wPTsxqRwI8KVBWDNffbll+qe/upDiONp76CwbBuRfd6PccJkVSdd2Kp74l8kX/pOVi02lz5l3S4Ov27Yykas1a+lsJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNSl+/i9; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b70a978cd51so72795266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508334; x=1763113134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7u3zBILwoXGQwoYC0Xq9BW4AZq6+iJ2od8CaDzzVgvE=;
        b=yNSl+/i9BCGw8Osel+srtRPavRqQvnrwCmdAVVwtoIF3P7dbBuOvrSyntpPz+7IcSl
         AmrQyjzUIk0QjpIVnyJrqKMbBKymWRLmiT/9MCh6hUkWHPP8jVIIAek/7e4YgIGHxTq6
         9H6NAA+VW0045lVv6BKr1lG48kSBSz+ZSAT0f3vhYxqmnZHKtClwbmv1lnDDNZ5fUdPV
         v24VRPAks/PNsQlypYOzyNZwIWZxpwM61ri+5TkxA67afUygCy9rjxbn4D5GsfufKMeX
         FlYk7bdnsqk2fJUrR/rlqY/Z7VA8AWbeTio8osqWiO+fH1IoeqwZXaHG2n0X3fDcE1dn
         rkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508334; x=1763113134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7u3zBILwoXGQwoYC0Xq9BW4AZq6+iJ2od8CaDzzVgvE=;
        b=PJUZAVrgrR3lSxENV+karvpbxvKk8JEMGbzxDeLhoOmLWz4BI5ccW2maJeotqNshpF
         nqCPqnfdISpYVlO64XbwwgcZQ4tMZjjyuLn6h9x6ZNwoQT/vi4TBXlr1RUsiywVbs3YQ
         bbr+mSnuQ3bRbkuQodwbx4W9F8dm2s8aXLn/P9nBoJO73splBxeOnXKN0wE76wQg/bIn
         RIMFephnsvpm/wjXPRhS4kYh7pVFcs+bKcKGalHkXdG5+qggmhcAnm/JF9/kHIGzMjsT
         fVdQi07kgsMXSXWh3Z3mGeb1XeSfRdr6f9dmbplpOZt4U/LpS+a/gLb6V/X+AQHQ/mtA
         wysg==
X-Forwarded-Encrypted: i=1; AJvYcCXWPX+AwuXGEvdnfBghhYSHtcR4VZlBsu3rS9DTAHrAaxQi07pLWFRum3iJQkczhK67bkcPf+dIXnB5pJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/ILdHvQE7fkft2YmcH77SZUKm+yibULy0myQMtUi0o+hY3CW
	Nhf8hV+kqMHFma58YoFw1ipHp4SVUMfjOVlLHdXaTfmvauO9Kx1R5O1M4x9qIhmYkezjPi5vXgy
	y5IxQaw75CV+YthS+t9qmHQ==
X-Google-Smtp-Source: AGHT+IHgDkuNncZlaLiNpLMu3aTitmPuR0CM9YTcGFIKOu+7HlV3Qva/fuAcZvKIOdIctQ4yRTHRz1pClFG3h2kI
X-Received: from ejcqo8.prod.google.com ([2002:a17:907:8748:b0:b72:41e4:751a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e28:b0:b72:b495:828c with SMTP id a640c23a62f3a-b72c090e60amr266298966b.30.1762508333943;
 Fri, 07 Nov 2025 01:38:53 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:18 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-7-vdonnefort@google.com>
Subject: [PATCH v8 06/28] tracing: Add reset to trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow to reset the trace remote buffer by writing to the Tracefs "trace"
file. This is similar to the regular Tracefs interface.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
index feb3433c2128..55754ef78104 100644
--- a/include/linux/trace_remote.h
+++ b/include/linux/trace_remote.h
@@ -18,6 +18,8 @@
  *			remote to allow writing.
  * @swap_reader_page:	Called when Tracefs consumes a new page from a
  *			ring-buffer. It is expected from the remote to isolate a
+ * @reset:		Called on `echo 0 > trace`. It is expected from the
+ *			remote to reset all ring-buffer pages.
  *			new reader-page from the @cpu ring-buffer.
  */
 struct trace_remote_callbacks {
@@ -25,6 +27,7 @@ struct trace_remote_callbacks {
 	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);
 	int	(*enable_tracing)(bool enable, void *priv);
 	int	(*swap_reader_page)(unsigned int cpu, void *priv);
+	int	(*reset)(unsigned int cpu, void *priv);
 };
 
 /**
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 3d80ff98fd90..49c4ae127533 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -63,6 +63,7 @@ static int trace_remote_load(struct trace_remote *remote)
 	rb_remote->desc = remote->trace_buffer_desc;
 	rb_remote->swap_reader_page = remote->cbs->swap_reader_page;
 	rb_remote->priv = remote->priv;
+	rb_remote->reset = remote->cbs->reset;
 	remote->trace_buffer = ring_buffer_alloc_remote(rb_remote);
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
@@ -410,6 +426,26 @@ static const struct file_operations trace_pipe_fops = {
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
@@ -440,7 +476,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	    !trace_create_file("buffer_size_kb", TRACEFS_MODE_WRITE, remote_d, remote,
 			       &buffer_size_kb_fops) ||
 	    !trace_create_file("trace_pipe", TRACEFS_MODE_READ, remote_d, remote,
-			       &trace_pipe_fops))
+			       &trace_pipe_fops) ||
+	    !trace_create_file("trace", TRACEFS_MODE_WRITE, remote_d, remote,
+			       &trace_fops))
 		goto err;
 
 	percpu_d = tracefs_create_dir("per_cpu", remote_d);
@@ -462,7 +500,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 		}
 
 		if (!trace_create_cpu_file("trace_pipe", TRACEFS_MODE_READ, cpu_d, remote, cpu,
-					   &trace_pipe_fops))
+					   &trace_pipe_fops) ||
+		    !trace_create_cpu_file("trace", TRACEFS_MODE_WRITE, cpu_d, remote, cpu,
+					   &trace_fops))
 			goto err;
 	}
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


