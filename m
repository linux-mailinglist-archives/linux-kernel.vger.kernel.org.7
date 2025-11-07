Return-Path: <linux-kernel+bounces-890087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 64361C3F34A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF50E34D2B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB3831CA46;
	Fri,  7 Nov 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vDOEpK/r"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18DC31A80E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508348; cv=none; b=cPJNYHPVmnGlfDmw0l4TXlqhC0/8QJ6eEAjH3iZcprn4SS8ZwH2n+46ll7URtOFMrAqtNlRik/Lh2BLL/gwbuJf8pcaan+62Qms2csOyrknZ9r7VPc8RHhiIruMm8rzULp1TjwZj2l/F0DRs7YFfFg4oeAsaXDt/H0VC5XVFkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508348; c=relaxed/simple;
	bh=CmU8EOoIXeOpPKTbeCTS+hID6SD1cywW2QdIbLFLlKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lOpMpJGIyQYqTfXLngbzM04pJ39YHaX2P0ODXs+60Q80nD9YpkJf6yRLNYFwXx+YndteZHaCAVDytoW+iv0FSAkDav9C1j58xZ6Aa/8DyV4JUBEsmS8Ev/h9auNbCrghooiB70RaA6JpVchpLtfom7MkBYmjOpkA7W+K4QLpBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vDOEpK/r; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429f0907e13so440034f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508344; x=1763113144; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPcBk3Jg2LwlT5ByMzu9UsOIiesB4Ql1GztQ2+qvXy8=;
        b=vDOEpK/r+Xj4oKk75w/59mpdbCcz4bB6j8IcOX9dwiIFpOSAUAuP6gAGD3psjwUDsD
         fVPHqqcq3HjO+YxBP0vn37aSt+kmK1S5+c/2h7rbnvJNRkhTwpo/AOJ62thwIjUJMfUg
         loPftKShAyRNsSV8/nYhGjK2eATWkfBTT0dBCPdFkddoTdPBnxIgmICylA9O2t1eN1Mh
         BrbobMFSjy0epVMz+gR20lpaHWNWTBfAszeCqGkcbCzvCKa3FtFvduus73A9Fy/yKTks
         Nt56G5/gAk1NtoLa8nRKA98bCuDztoe+SwuLpnmGyT6eo8D9+YyLarjqXdXqclaW8GRT
         1ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508344; x=1763113144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPcBk3Jg2LwlT5ByMzu9UsOIiesB4Ql1GztQ2+qvXy8=;
        b=Sj6lZcksMkThKhh4ZHL8ggC/kzTJ2IFhrxtitaiXqDgiN1gw+0FrjrRvpb5HJsLw5Z
         A8nQqJxzgW0UmaKS3xrfcYR6NO6B6DhKCRxKN4lchBEPcu8ADkH3wBGEPt3ivbzKmfcU
         I01298YnIyVXggj+X3J8yl3i7AhamWUO6gVwdB+kFyoXA1xg471MUosKN+o1h38SEgoP
         Z2yzMmC3+blWfDJ0UIndK0w2IuyT2t7hNTti2zJLBIRXQTkduOLnTiKfsDv5Gjlb0njE
         iznsKOQ4Ad93e0zd9G54emN7s9oXA+i8GyKuMmQJp7jfO4ktj9zjqo1WsXtL1cXl3wzj
         Vbog==
X-Forwarded-Encrypted: i=1; AJvYcCXGyjcyO9J+UAl6sJtee0emP+7XRAKWPqC8fT9NpgFXp5UHVzWWRifEgJ87LfBJpHzeJI1I4ZBch17XgSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XSYWTO/0FkCTXCNpzoMsVulHoWcBynm15Lrj71Y2cWGOT+In
	wC6/nGPO8i9+yiUR6mnkaPxl6TyVXtahreTy6HT5IbUjUGebf1YaGTw9TU6DiDcpvZkml/eRxON
	Y6zlK/eDa3SPHnAYQRocv9w==
X-Google-Smtp-Source: AGHT+IGwE9ip6WqJGodYFNUEr25D59pPNmkTX5hMRAWuWBgUwmxO8l/KAXALHLOnFBHa62U4s3AVgtYL5Uhey6Tp
X-Received: from wrad4.prod.google.com ([2002:adf:a404:0:b0:429:d9e5:878a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:22ca:b0:429:8b47:2f35 with SMTP id ffacd0b85a97d-42ae58d038cmr2260717f8f.26.1762508343746;
 Fri, 07 Nov 2025 01:39:03 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:28 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-17-vdonnefort@google.com>
Subject: [PATCH v8 16/28] Documentation: tracing: Add tracing remotes
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
2.51.2.1041.gc1ab5b90ca-goog


