Return-Path: <linux-kernel+bounces-675354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3360CACFC44
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 07:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00444174D5C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 05:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F421E5B69;
	Fri,  6 Jun 2025 05:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxOvmFZm"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE111DD9AD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 05:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749188293; cv=none; b=bmrRLp8L/YbA6szPdzqtdxIuE3H0lglt2nuIrG3xww3/ItqJb/SKx1YXOx31N9avgKmRY+UxquMSrmnbEhaJv4o0Xm6qsOB/JrzwHWsBMtWLf9ZytJBZKa1eptWZFtuPdOVILNByq74rckh4jJg1/Ey2lBqx2iFvNVQGypvsO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749188293; c=relaxed/simple;
	bh=D1qVR2rPayReMgS7NuJBE2UqOfY1+vud49wAOQyN/PM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=pIvXnD9lNL+W05euu4sZWE4R4aSpmMuOXh3sMSH86iHg5KDx4apHJNXVUAShXW12wOAht3bENMcp8t2PkcnKQcGonPpbjHwev2A4DGIPrh+PFrLeZO7hSL32wtVlIyPoqPSzuk3Vve4ULgjobRQH/P/AE63Tm9dbPBPdrc59NU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XxOvmFZm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-70e5e6ab756so26038507b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 22:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749188289; x=1749793089; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6e8z1Y0PM6ePVKE7akB6cAIu/1nUvlhiiiW5g/fTl7g=;
        b=XxOvmFZmkyvXXM5HPZVYYOZOigbgPLy0WvllSrC1no/0ls2nPRqoBIYeQdIfHheQiT
         ufHOma0j6SWjHeZPRGCYaNl8rdNzek5PpLBSmx4Gu22I+Plxd3AveP0q2RlQG7hDzVHD
         2nZLkTiJDd5PjZAkqeV+abNhRScSlAu+wSFrMbJ/wasgVUna7EYP2GeCEEYzk3IaO5N8
         yG0iFXolvH6NTtxX/+SbPYWHDHJ2hneLJjaXKwWvgnH9Sk6/tUx5G/Hr3de4mqkE6Jj2
         rQYmez+B02HFI1K4qStzk5seSLJz5rOtoLKZ1SCaIAIVxTcmGBxjPe3cuLljZR4NLdLo
         NZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749188289; x=1749793089;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6e8z1Y0PM6ePVKE7akB6cAIu/1nUvlhiiiW5g/fTl7g=;
        b=X2Mw5ue4igmfrzkYoZie+O0xh0ZDSriVUY6NOqw/5MuFs+UzAw+eAeIZNGyft3a5Ey
         x2VhQpF3Qh4R0JgeqT/mClenVKHGlGRQx/4z6SiQuo0eeaRLsu5NkEWSxvEryM6shm9d
         WJ7GSIYoehCzZ30RxQ0O86bojwbfXOWyg4sA8O7qoeq5xpPT8IvLtSn0/7csVScBuVDC
         IqpGl+9GWFOHv8KOrFpxmrykwcMIU6biJruJvUVxTwzOQPP6jcsI6/pAHfYFlAYJIFLg
         8eTbp8ijM8a0j1MFHZdnRhxdgovp2TwT2hn9VHTL8yX1js6P7q4Hztt6vd190JUQBLoV
         ZTIg==
X-Forwarded-Encrypted: i=1; AJvYcCWGk4zWN9V4NyHnPn/R97T7wm/1MYHHVQrNl6NDeqQ/x2IcoBWsob9h08b9CdnSSgQ83Bk+5va9rQZQE74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2XTiR2ayZik5xyPJInLsFmYkJ5fThU0yYtd6VNWyKKcwtiON
	FiVq532+NJZ1uTL+KIiWjvIjC3v0t83GgNuJLVc/Xq9WOPimVGlOlJsHDeI6V/FRYPQN2NgPtYl
	VL0QUFDXv1dcuig==
X-Google-Smtp-Source: AGHT+IFS+GD65k0hSub3v9ULn9x30VGz/G+3YfG6wahC/QEoNt85ySmK2qp8MyMrEf3ggnp2Rl7EW06pkn5awA==
X-Received: from suleiman1.tok.corp.google.com ([2401:fa00:8f:203:b09c:3d84:6735:a65])
 (user=suleiman job=sendgmr) by 2002:a25:a44:0:b0:e7d:c44b:a4a6 with SMTP id
 3f1490d57ef6-e81a25deabbmr3028276.8.1749188289448; Thu, 05 Jun 2025 22:38:09
 -0700 (PDT)
Date: Fri,  6 Jun 2025 14:36:50 +0900
In-Reply-To: <20250606052301.810338-1-suleiman@google.com>
Message-Id: <20250606053650.863215-1-suleiman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250606052301.810338-1-suleiman@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Subject: [RESEND][PATCH] tools/resolve_btfids: Fix build when cross compiling
 kernel with clang.
From: Suleiman Souhlal <suleiman@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Ian Rogers <irogers@google.com>, 
	ssouhlal@freebsd.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Suleiman Souhlal <suleiman@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When cross compiling the kernel with clang, we need to override
CLANG_CROSS_FLAGS when preparing the step libraries for
resolve_btfids.

Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." logs
when building tools in parallel"), MAKEFLAGS would have been set to a
value that wouldn't set a value for CLANG_CROSS_FLAGS, hiding the
fact that we weren't properly overriding it.

Cc: stable@vger.kernel.org
Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
Signed-off-by: Suleiman Souhlal <suleiman@google.com>
---
 tools/bpf/resolve_btfids/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index afbddea3a39c..ce1b556dfa90 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -17,7 +17,7 @@ endif
 
 # Overrides for the prepare step libraries.
 HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
-		  CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
+		  CROSS_COMPILE="" CLANG_CROSS_FLAGS="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
 
 RM      ?= rm
 HOSTCC  ?= gcc
-- 
2.50.0.rc0.642.g800a2b2222-goog


