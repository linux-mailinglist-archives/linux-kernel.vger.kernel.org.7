Return-Path: <linux-kernel+bounces-841339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4EABB70C3
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6219E4EC286
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CA326658A;
	Fri,  3 Oct 2025 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ju3Si6Hu"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C6023B616
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498757; cv=none; b=OxaxnYN/wXDYkMyETyAycxJc8p4TMH+mefEmb3zRK+q7wKSTSEuk00lF5idsDHfuuRHomA0Qalazl5a7agBpCodJbXyCpjvPq+nbZ5xFUcaIpXIF2M75zlrF9qhc4+2Ay2qN9Tp40b5d4Ztb8v8QPGLiZmynxuwqFa4m9QHgp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498757; c=relaxed/simple;
	bh=8Cw2K0IyrMbYYLIH+BNRbrAbypKpGcwbo42Tv7az5a8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DpxwyW+MKebCUbWCAVi4hMtJB7lRUlYbSs6gCV9FDN2oOxpxAlkKULrRRcHsVRaI1t4vv0lnX4UeGt9BGsKSkTgeBYI7fPjSk9YMDjkYXyNE7NmKTiZGwUgILu4icDPOKWoj9IqTQzDLvWxb9jQo15YTNhT3tImUz9W3EPwfu3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ju3Si6Hu; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-634ad8328fdso2602387a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498752; x=1760103552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ptOXAsK02KET+nuGM2NvZr5tn+Cruj7KUoPt2v9bC4=;
        b=ju3Si6Hub/YGk4CJyg/z+pCJuu89YaAfXRbf3VdC+TkuwMNIR++OOu4jHwIgQeaZG/
         JCC5yE7CpPD+oMPCvRo09TAHFSlbyCREDe10Qq/ORaTJqp3KqfG9Fbbxa3c1jGvmToEC
         XP8s2QMICsw+i8XWuHSLoGKS01lkbv2WWAqUgDwuYT9H+WLkymnlHT3A3oY+IrQV0/ri
         jd3JG/mm+iz+3D7C6OZJ6zsk+J4H+Hog7GVJ6DgUxElnEtJk5/6Ro8nA0pJJ0jivMg23
         aB+3PGpOwJ83c2xB2XbNB+cJ8z5a7u07bEQX4wrr5/TJhSW24BDGlRU/wvIyxaWDKQyU
         excA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498752; x=1760103552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ptOXAsK02KET+nuGM2NvZr5tn+Cruj7KUoPt2v9bC4=;
        b=f5FtIBSFO0Uhe4on9XlvwivbGNmLc4kO0EXeb6TmzA3TrdrV2EQawHNCRw/n1VlsIH
         6Tf0n0kzSwUVBVf3fyC54hbQjFRyycjHhgeFs0t/Zm2EcklZQVkYDnfFLHeBMRTc8CmJ
         ALe6pDyw8wyK257xWEV565+cTPi6hlXHS0MSPkbTEUNSg6mgitd8MkgwO1k7P2xyAZ6i
         Il+Yk7bx8R8A4FWzItc9XYwOIQuibxc/EdkgdTxRA93YnDIiUI70noCGZG8ZOc9Z4r51
         /hTWUZzQk3TFISevR2Bh8kvjhCi6EDOWelNlVsSKWTUFaATcZbcYRhREShTbYyb3ikWU
         Kd9A==
X-Forwarded-Encrypted: i=1; AJvYcCXKQwGgnxxmBo0hlaqHdIDJfbDR9p043xUdreGxtoF7zfljYjA8Oo3/uNSeNebK8UbiARLgnC2IJPJAAG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCH35+2cR+krC+hY5XDZZloYuoYmryMlXVG6Yo+KiDEoIO6brT
	kl7FZ99iWxgwxlzV916Hdskp5Z201WJrHhtOKVXVVvDLHNShwyVRl21t/D5LytBOGiT/ZoWVrjX
	cI8U16F7xoTNpn7Z6UsF/BQ==
X-Google-Smtp-Source: AGHT+IH1xhwr98a1KjzKNYHcZRC7sH0MEyc8VNAbl5gX0uevl9b95kinJk1XW3eUNT+SGJ+58Lgd/woZKqcy9o+d
X-Received: from edwr6.prod.google.com ([2002:a05:6402:346:b0:636:640b:3c66])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:50c7:b0:637:e17e:1a9a with SMTP id 4fb4d7f45d1cf-63939c2df6dmr3356826a12.26.1759498752381;
 Fri, 03 Oct 2025 06:39:12 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:13 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-17-vdonnefort@google.com>
Subject: [PATCH v7 16/28] Documentation: tracing: Add tracing remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add documentation about the newly introduced tracing remotes framework.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index b4a429dc4f7a..d77ffb7e2d08 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -90,6 +90,17 @@ interactions.
    user_events
    uprobetracer
 
+Remote Tracing
+--------------
+
+This section covers the framework to read compatible ring-buffers, written by
+entities outside of the kernel (most likely firmware or hypervisor)
+
+.. toctree::
+   :maxdepth: 1
+
+   remotes
+
 Additional Resources
 --------------------
 
diff --git a/Documentation/trace/remotes.rst b/Documentation/trace/remotes.rst
new file mode 100644
index 000000000000..e7fb3ee96c30
--- /dev/null
+++ b/Documentation/trace/remotes.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Tracing Remotes
+===============
+
+:Author: Vincent Donnefort <vdonnefort@google.com>
+
+Overview
+========
+A trace remote relies on ring-buffer remotes to read and control compatible
+tracing buffers, written by entity such as firmware or hypervisor.
+
+Once registered, a tracefs instance will appear for this remote in the Tracefs
+directory **remotes/**. This remote can be read and controlled using the same
+files as regular Tracefs instances such as **trace_pipe**, **tracing_on** or
+**trace**.
+
+Register a remote
+=================
+A remote must provide a set of callbacks `struct trace_remote_callbacks` whom
+description can be found below. Those callbacks allows Tracefs to enable and
+disable tracing and events, to load and unload a tracing buffer (a set of
+ring-buffers) and to swap a reader page with the head page, which enables
+consuming reading.
+
+.. kernel-doc:: include/linux/trace_remote.h
+
+Declare a remote event
+======================
+Macros are provided to ease the declaration of remote events, in a similar
+fashion to in-kernel events. A declaration must provide an ID, a description of
+the event arguments and how to print the event:
+
+.. code-block:: c
+
+	REMOTE_EVENT(foo, EVENT_FOO_ID,
+		RE_STRUCT(
+			re_field(u64, bar)
+		),
+		RE_PRINTK("bar=%lld", __entry->bar)
+	);
+
+Then those events must be declared in a C file with the following:
+
+.. code-block:: c
+
+	#define REMOTE_EVENT_INCLUDE_FILE foo_events.h
+	#include <trace/define_remote_events.h>
+
+This will provide a `struct remote_event remote_event_foo` that can be given to
+`trace_remote_register`.
+
+Simple ring-buffer
+==================
+A simple implementation for a ring-buffer writer can be found in
+kernel/trace/simple_ring_buffer.c.
+
+.. kernel-doc:: include/linux/simple_ring_buffer.h
-- 
2.51.0.618.g983fd99d29-goog


