Return-Path: <linux-kernel+bounces-636438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83881AACB9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 18:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA32A9823D5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5832288CB7;
	Tue,  6 May 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bR9JYyrv"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA769288C3D
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550127; cv=none; b=cHcgECQctCMw0FZgYVPrkEbS38/LtDFrx/+1h5WCpG0wxPc+j57cIYjU97Nj0zPyUWn8ETSp3FANTa4hpXQn7Yuae1S/Gl5bgSP/pH0SjbLzYfbRHP0wIrz0W4nmacwIu5SD5yRMuhwX21qfmL6IkRW350chV/flBlJQUiQW/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550127; c=relaxed/simple;
	bh=wQBFYyELFNvHLzXQ+9NDItNJua1krR5kq62o/pGyp00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rBSpKA12XjJhGJybNhaYYFkq7a58LG9MykML5UBPHCYxSpwSWoRNQ+ghKbQF2xR4uUjKUg3szcaOFcoVba9hwQiT4FbVDDqODkoo7Or+XWMkcw+8mk4yhBo52ZAtOgG9YdD5Z8MkewRf0HN05sqv3DSiupu2zugRRrX3Gsh+qXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bR9JYyrv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d00017e9dso31813995e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746550123; x=1747154923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BsA8D4HjHlecCQdG9p+xY7qsrnVwx8gbv9XN30ZeOP4=;
        b=bR9JYyrvUSRjjHakZMmh4XDVWz2izyU7VdR5W3vueye2bDCYALbv2nw0QYjuu8OpJT
         qjgWNs5PLPntopdZhqh1UqRLj38h4IcI77ELmS31x89IUrFfmXqwVUm6sPXgK2/Q/iO0
         5zj9zLDCTKdhF+4zQg9q+r+rJuP5+kpn2KJigVkIa0Bl3g0ngNdVkWEZ2Claaxu+NS6v
         LPR/LnX9OCqVPB+ve/CvYvwwe07rPQ0Z9mwDgRLhyPHeDyKW5IGDChuVDZSS27AujT7C
         0fjUbWpXKFtgJOFYahEDkbuWtTJN1SBZxIt0IbgKxwDoC/mF5U02Ns/HeHH4BXBzRCIR
         /LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550123; x=1747154923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsA8D4HjHlecCQdG9p+xY7qsrnVwx8gbv9XN30ZeOP4=;
        b=V76wVvekTYm2qnw/3KO5hMNA6TFZZhsl1T/Dqv/rZaTWW+5c8hbV+rX7zBc6U1ckv3
         XHB49w/7k8JrGSoQ3jXJ/noJCLjyK9CI6tq7OYshBBL1uxOTdzGS/kNHrCfiv7kDgwXL
         xVfAgCF3fF+jBrP7DoRqjqPTzahajjOKc6eRiCVEZYDMtuOP3zkq/cZE1HrCh+0ry1tj
         MmKVSRI/jonGhsMWmCEpRM+EG4tXOQK/0PyXtNSkxytD6MXcmUWNBkL7ZphalB1rFP4D
         CS5yHnnSqVnwaJbtdDhuwZDy+168tQZps12nEwauIbz/F4eM7kQOTqZyE6mAZ3CaMvHL
         p6Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUMqRNSx2Y5kOOqVPTvBKZLlg/8F+kXE2Bar9yRhedEKFLgqJ8tyRd0loHRMmA1NMhLg+rMulwBAAICr0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvy1+JAe0Xe/C1cabc0vGxCj6JNHdm1pmDiyrRBf9ghAQICUn
	pc8fubHoyURbanjMof32EVSasHr3HAp4aGJocEZv3zIOW5t1YVqeiVzWns+9e/urATgIIoxMUpb
	BqIFSLh5sLJKkLaNoTw==
X-Google-Smtp-Source: AGHT+IF5PMMWTS3cwH1oB8k42s2Xq6vSAGn672jUyunHJnJQKljjoLiBSvKPyhszSFei8WE+2z41aT3Hv72Lx/Nf
X-Received: from wmbay23.prod.google.com ([2002:a05:600c:1e17:b0:43d:522a:45e8])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5105:b0:43d:1840:a13f with SMTP id 5b1f17b1804b1-441d100a9edmr34417665e9.25.1746550123251;
 Tue, 06 May 2025 09:48:43 -0700 (PDT)
Date: Tue,  6 May 2025 17:47:59 +0100
In-Reply-To: <20250506164820.515876-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250506164820.515876-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250506164820.515876-4-vdonnefort@google.com>
Subject: [PATCH v4 03/24] tracing: Add reset to trace remotes
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
index 462c2d085a08..2221705f65f4 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -70,6 +70,7 @@ static int trace_remote_load(struct trace_remote *remote)
 	rb_remote->desc = remote->trace_buffer_desc;
 	rb_remote->swap_reader_page = remote->cbs->swap_reader_page;
 	rb_remote->priv = remote->priv;
+	rb_remote->reset = remote->cbs->reset;
 	remote->trace_buffer = ring_buffer_remote(rb_remote);
 	if (!remote->trace_buffer) {
 		remote->cbs->unload_trace_buffer(remote->trace_buffer_desc, remote->priv);
@@ -135,6 +136,19 @@ static int trace_remote_stop(struct trace_remote *remote)
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
+}
+
 static ssize_t
 tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -369,6 +383,26 @@ static const struct file_operations trace_pipe_fops = {
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
@@ -399,7 +433,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	    !trace_create_file("buffer_size_kb", TRACEFS_MODE_WRITE, remote_d, remote,
 			       &buffer_size_kb_fops) ||
 	    !trace_create_file("trace_pipe", TRACEFS_MODE_READ, remote_d, remote,
-			       &trace_pipe_fops))
+			       &trace_pipe_fops) ||
+	    !trace_create_file("trace", 0200, remote_d, remote,
+			       &trace_fops))
 		goto err;
 
 	percpu_d = tracefs_create_dir("per_cpu", remote_d);
@@ -421,7 +457,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 		}
 
 		if (!trace_create_cpu_file("trace_pipe", TRACEFS_MODE_READ, cpu_d, remote, cpu,
-					   &trace_pipe_fops))
+					   &trace_pipe_fops) ||
+		    !trace_create_cpu_file("trace", 0200, cpu_d, remote, cpu,
+					   &trace_fops))
 			goto err;
 	}
 
-- 
2.49.0.967.g6a0df3ecc3-goog


