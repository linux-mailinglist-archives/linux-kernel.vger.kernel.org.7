Return-Path: <linux-kernel+bounces-745039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4F2B113FB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1BD1CE5313
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9F244671;
	Thu, 24 Jul 2025 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kW1fiaog"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB02242D6C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396357; cv=none; b=Z7ZE17SkLaHXLMjREIfheLGOlfrhDfymCf/EFQs2Ln/iuY/fpWpC3VMoPKA8dxVkvRIZOoAxAU94V8A9w7yOucpkGbClcSVwO5yMb2rrMyyTGg8H3iSaeDM5NT7VJaGhW/dpQayMzP3Sul9C5me33CwUuwELf/6Xli4vSGooyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396357; c=relaxed/simple;
	bh=Te5ncN9qqZn2upvGFqeV8Uur3LqS/b0o/rw16rHKk60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ev202hD9WRD3wYmHtFMfiZnVhpnACt7ut4j0rPtTU9Gx7iaQBt25wKLW6BYB0FhW9oR/rXbXDAbKBfZpESC8AIXGeayNFvHwkGhoZOeAdtUkujENNOWd8DyU6j3ldJARy8DyCgDk73VALTr3KfiPnuRvR4eqH01JTa3eFn4r0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kW1fiaog; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso2592292b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753396356; x=1754001156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNYfwAxqd7I2x0nMz51JmjiHwnxOLAwCMiMi5aEmTUc=;
        b=kW1fiaogDZi+5GuC2HzqXepHggblg3w8CPafaEpOWtc9NTDr4M/AxtDA41Reyuf56q
         N2/7BzjOaW5i6efxsNRAL6z7ccVM3YZYsZPKQXxK9SUly7zmKPTLyYwS1t6x/lFe3WHU
         JzMg6EJN1IDkOJ27Kuu9SGNYzGOLVlIPv+fzikKqTddBklICfzO5Ms5+dkv/6uietmYr
         RCiTBilZkMgVuaM4PjKHabG5noU8RwT0F1wktma3Smuj9L4u1t9hoLjyWixxmbu/KiQv
         aYBpP2PN8evyVpeEnfflIPtf7LQxi8FJsUKqdlwyFT5vkc4Ig+aSN/batm4ExGSM4IcQ
         mdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753396356; x=1754001156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNYfwAxqd7I2x0nMz51JmjiHwnxOLAwCMiMi5aEmTUc=;
        b=ukmaZbgCHbPp9r8cObtbqqRla6B1bRD9BWnf9BIbTCXUgG8xe7WlATEtcvMJzDKgEz
         /3FH4oklooB5RFnW8YD18pKJGrvW+1dsHtQP77lxZVlSHHPR14J3tQRbMEXtmDL1ZbdL
         Rkr3dNQ2uVPqeXwhpB64Bm2WZ9n/a1ngw8o/kChi5DnUIKGZjZe0sd4uKYLHVVEGWyLi
         iKftgmIxmfBrqF759PlGjplTZRmY19WhWy47yjYCzh/Ce9mqXJK8gUdK34ml8b2wgztn
         R/3tSpzJCPR++CuJ5D/hYQLJ74jgIjAj0rsepUFULZ6s4gDF7DY69VWBbLnOYotQ5h3C
         XYZw==
X-Forwarded-Encrypted: i=1; AJvYcCVu5GKcC0LJa0cSAEdljP26u5EPBxl+y3zZDANld36va8wOOVWoagXEMkeZnGR4OVaG44zxn1qd9plXOBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZtJ3lui63zL0OU3xuh+soYmqM+wjmvy7z6Fc2KLjM54sn4xY
	95nofUq2/8SyHp97BDlpouNSlQA8i/2wp8kjnwyUM8mEq6aM7IAG0eih8qIQ9R1DK/nHGyrfHz2
	zzaY3QX9Gx2COuFGingoBsWHtyCfKCQ==
X-Google-Smtp-Source: AGHT+IHl2FsekGmmMkPb5Lkwpl2L6PcannsxEfE7R5Ah7fvhaheXO+MosnNohdRUZsY8h9CbPwKVJbwWDMBsZWMF4io=
X-Received: from pfbif3.prod.google.com ([2002:a05:6a00:8b03:b0:747:bd3b:4b63])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1141:b0:742:b3a6:db16 with SMTP id d2e1a72fcca58-760356fdcf8mr11431105b3a.20.1753396355585;
 Thu, 24 Jul 2025 15:32:35 -0700 (PDT)
Date: Thu, 24 Jul 2025 22:32:29 +0000
In-Reply-To: <20250724223225.1481960-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724223225.1481960-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=samitolvanen@google.com;
 h=from:subject; bh=Te5ncN9qqZn2upvGFqeV8Uur3LqS/b0o/rw16rHKk60=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBlNW6oFj+X9La2LELl3VXbZsb/eLUs2Z/NfWR977rkzf
 9nNSVtYOkpZGMS4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBEtn9m+GdwPOLhhjV2R5iE
 nuwq5+J+26t+b7fkFoPgfv1onW5WnxqGf0YbHvIzfbvcIm0gd2iOWT1z0uGH7Vezumct2ZKRmvB PgR0A
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724223225.1481960-9-samitolvanen@google.com>
Subject: [PATCH bpf-next 3/4] selftests/bpf: Use the correct destructor kfunc type
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
indirect function calls use a function pointer type that matches the
target function. As bpf_testmod_ctx_release() signature differs from
the btf_dtor_kfunc_t pointer type used for the destructor calls in
bpf_obj_free_fields(), add a stub function with the correct type to
fix the type mismatch.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e9e918cdf31f..8404d62ae524 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -249,6 +249,11 @@ __bpf_kfunc void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx)
 		call_rcu(&ctx->rcu, testmod_free_cb);
 }
 
+__bpf_kfunc void __bpf_testmod_ctx_release(void *ctx)
+{
+	bpf_testmod_ctx_release(ctx);
+}
+
 static struct bpf_testmod_ops3 *st_ops3;
 
 static int bpf_testmod_test_3(void)
@@ -631,7 +636,7 @@ BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 
 BTF_ID_LIST(bpf_testmod_dtor_ids)
 BTF_ID(struct, bpf_testmod_ctx)
-BTF_ID(func, bpf_testmod_ctx_release)
+BTF_ID(func, __bpf_testmod_ctx_release)
 
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
 	.owner = THIS_MODULE,
-- 
2.50.1.470.g6ba607880d-goog


