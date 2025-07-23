Return-Path: <linux-kernel+bounces-742646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D50B0F4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76473A4643
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3F72E7F03;
	Wed, 23 Jul 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlxylxgS"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239C1BF33F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279394; cv=none; b=u2TLxWl+C4jgOBFSvj0OVSXfiAuC3LC8lXU1DOGIDHYZPHN8fLu/VE2VlZPT8ROJrfhmT8WbF2Iyg4/jCyCpk7C5G1md8S6JPW8ZPTk7z1NsKEg0F/xh3LINHKHSMBUyr5klemsaM6l/HiHN754T1nz+TjG9fSGATqAIUwNNv6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279394; c=relaxed/simple;
	bh=OCbn08Kk5w+AIMjiGxvT4u5Vecs3QUkPqMwYsziLWLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXbhzFk2bsUzxL95VIRQNkxSvv7BkoLVQoceelax6xDanL3mCrlAmQ5B0Kq5BiW9tHUW0lQ6sgXjBfronolpAwJfai+Ibusl1ysFrbA987Z4Oqaq+r2PEYcg5P9keovSMhxnG33pZx24psbbVZQ8SQtgzS2ejO8RcOTEFsFdcGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlxylxgS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45600581226so69426185e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753279391; x=1753884191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjPnoc8Hdx+l/xUpNm59DpYUNziDBJENJsPNal+ymv4=;
        b=TlxylxgShW5Ox2bpypU3Hr20u+/SdbYDJdAi0JKvrUx9SrWwmwycg/r5JYx3qbbNYK
         TDQmwloylILtgaFo5tXM9FBW8oaYpAYraLQCg/eURLca8GiWmiF4k/NobvmeSx5ivZUj
         2dYVU5FCN9n6vWjVRcTpBMDhAefXCzXBlHAoxAFKAG8tpjKA86OQIrVAVqB0e03j1O97
         LjHcdfvKsgeHrrWSsl6wkyRcolEKSoiotkl0p4HQqqSM3IiJVPNbZXOH3yyxKJjyyfLO
         gCWQpfw6vfsC8HXjpFvhhwbbjdnyAiXIRRxZe7PM7HvvAPDH0w4uyWxonC7chRUsqIYT
         C+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753279391; x=1753884191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjPnoc8Hdx+l/xUpNm59DpYUNziDBJENJsPNal+ymv4=;
        b=nGgDz1tS7VTmzXvnTbT3owH6F0wxpYbn00Lhq5guQU7gWRMQBAgwZvvPz5RXyzEWgK
         BhanVHRnfZ5AHTVrlHIKm7ng5zTki0HTk7RvmA6byWzLCJ+bWxMLRADg8Cf6L5U+Z3dg
         44A/tlGWiOKtwjUOHbc2PPzW4QcyJ463VJN1KOHUZ1KCyIufOuJTRvEWDG0j3wPJodPb
         K+rncgHj6OPeM8KW9Ky/kzF0SvEGEuG/EJZG9FkQJTm5Wpd1XJ/3vv3bhYcYzpAyXy8U
         VtaRMPiNluahS34vSZmjkZXLKd4nRjGQwp7GN+biwkvBI8ECK+d5FUFg/VAXZo0ISKhd
         EMbw==
X-Gm-Message-State: AOJu0YxRhVM+FcFbAA+xCts/E0CcDe4cytelNqgldmpcSAz92K7LxwYZ
	d2b6th3gqU2cM0TnL2/JxVLROjbtk1pbFVbckfkPgRMYYJMmSJdfoNEkqGEk+b1/
X-Gm-Gg: ASbGnctppgm6MXzwQ8zy8XcCbvwyZjpj5vCQe+9vveqoKDl80wDGPsy5sl5jYHtCT1y
	7YoEAILmdy38XxnRd5qIZbc7hbNhSvT9PQ2jc9T5ETymeLH7fIGBuhVOnu5sEy3OMG8nR4jfAzu
	gzpdHCvc4HD8DITt2JcPjv+AFJbU/Eou459XqRqz9Tdh5BnxbzLnUcaa+uJLU+T+c6Lyi8E4IRN
	95Pel0wl34t7Png7ByoUmJLYldbNTUZ6gxt4TWrhrb+HQK6bEcP+/wXeJnH0ejp4qpFyoJ4xLGq
	F0boSWcZmo/ZLjiQeKBXcU/zXPGfoMzgk/C+xVj480oAhd7CcOhHedEwHOOD+tsPi6VEurxrhIa
	IziObSKo+i/fwuiAr35H1suqXv2iELJwRFxIGGscc+rjesAFFXsF8OcJP4T6g
X-Google-Smtp-Source: AGHT+IFgYaUtmq9HyBhGzBw1D0ph+vnjMB+zxr+m/ArLE5t0Y2/I9OpPLOYUhzACemmr3zcFwqU1xQ==
X-Received: by 2002:a05:600c:34d0:b0:456:2397:817 with SMTP id 5b1f17b1804b1-45868c97ac1mr24826255e9.13.1753279388853;
        Wed, 23 Jul 2025 07:03:08 -0700 (PDT)
Received: from ABZPC-86BPZX2.aberdeen.dnoheather.co.uk ([4.234.100.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586918b65dsm24243325e9.10.2025.07.23.07.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:03:08 -0700 (PDT)
From: Raka Gunarto <rakagunarto@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Raka Gunarto <rakagunarto@gmail.com>
Subject: [RFC PATCH 1/1] compiler_types.h: introduce ASSUME_NONNULL macro for static analysis
Date: Wed, 23 Jul 2025 15:03:01 +0100
Message-ID: <20250723140301.277089-1-rakagunarto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723140129.276874-1-rakagunarto@gmail.com>
References: <20250723140129.276874-1-rakagunarto@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This macro suppresses false positives for Clang's static analyzer
by asserting a pointer is invariably non-null. It has no side-effects
in normal conditions by including a guard to check for the
analyzer's presence.

Signed-off-by: Raka Gunarto <rakagunarto@gmail.com>
---
 include/linux/compiler-clang.h | 10 ++++++++++
 include/linux/compiler_types.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 4fc8e26914ad..c25bb1a855c4 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -136,3 +136,13 @@
  * rely on the auto-detected CONFIG_CC_HAS_TYPEOF_UNQUAL.
  */
 #define CC_HAS_TYPEOF_UNQUAL (__clang_major__ >= 19)
+
+/*
+ * Tell static code analysis tools that this pointer is
+ * invariably non-null
+ */
+#if defined(__clang_analyzer__) && __has_builtin(__builtin_assume)
+  #define ASSUME_NONNULL(ptr) do { __builtin_assume((ptr) != NULL); } while (0)
+#else
+  #define ASSUME_NONNULL(ptr) do { } while (0)
+#endif
\ No newline at end of file
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 2b77d12e07b2..26126fd915be 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -594,4 +594,9 @@ struct ftrace_likely_data {
 #define __diag_ignore_all(option, comment)
 #endif

+/* Provide no-op for non-null static code analysis hint if unsupported */
+#ifndef ASSUME_NONNULL
+# define ASSUME_NONNULL(ptr) do { } while (0)
+#endif
+
 #endif /* __LINUX_COMPILER_TYPES_H */
--
2.43.0


