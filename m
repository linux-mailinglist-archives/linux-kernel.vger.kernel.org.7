Return-Path: <linux-kernel+bounces-746397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646F7B12630
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1543A3BD426
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560022580CB;
	Fri, 25 Jul 2025 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFRZ3ln3"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49673253B71
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753479860; cv=none; b=SJ+1QYEzTSyKK8+2YkTBhGES23iAFKAprBO9NOVcgwZGAv2g713qE1VZeYUWT+KiAHRjK7LmkqRvPxKJtHKDT0BSS4f7DRRfLaELWbpiWQE1KFSBqUBa+NvVBXm20Wl5ImSOczHFefFCRTLS+ZJ4o773QeDEVeFlDzDkPaxmTxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753479860; c=relaxed/simple;
	bh=/A9wG5u0kN1kFNpHvLIRowYQicJ4cQnWyWf+Gqas87Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q8GEsbvAioodtjDUI5Y9ctazb7+639JLdzWg/JA7H2B+8z4NsexbYc2sRhZZQh3hVVl8aAaoxfm8d8oraWEtRpgKPByQxXkqX1oBui/1LnA9t+kb8jdi84yN0FSg4aHkDObYFw72WGR2B+UGP9tQWr6PAPkkOzxgebGJAt1401Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFRZ3ln3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-315af08594fso2346772a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753479858; x=1754084658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXmhNHF/XxQXrapxuBtt3P4+K0RyfYESVL4h3doBb8s=;
        b=KFRZ3ln3GhH9qxGTT6I9zZyYhdjuG6adKRvks9gbi7jcJ4fxAy67yBGSStJ+eUYQ83
         fu5zArQEu4+nytAXdJX4G981yJTkmc5JcsEkUmVENoMwKyulIMZsZnPZKS0RfQbeLtV1
         /8VeCJkmQWPkczQLjFw1pX/p6a5H687VapCmMwlXiTkufE177HxuJLqpN00wMDkM+HLJ
         l9CaJ8Je+3LFN0KNAGTjh+2YkrNARlDbmubaG0wGGk/JmxS2/cH5zssuwrL5gTkWTBAS
         uKJ+31iE88/z2cuB4WJ2y8lHx+YlRDYUynbfNQkHLwdvT11Vl6uc6q8UYvhEktDE4Cti
         OftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753479858; x=1754084658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXmhNHF/XxQXrapxuBtt3P4+K0RyfYESVL4h3doBb8s=;
        b=ugQV5eGOzw1a7Iocngd/quFvvgJNiS1eAUYLgtlO0dQ6aSjRUmwFNFeolX9hlEQBCs
         BtwjhfYIe/nYZGc4YSkA8FoSEm4bN21pfOLwLTItQ8nd6hck//r+cKl63oUIMa2blYUB
         mAlypotCf5FX/rG6zImPstUOZ1bQW7zpMQNpOiT3bnToaLwA3HhdyV0uK9aZaaeCK8Sq
         Ywgn9uo5jhUBV+qIpABhkbQ0Qqu5sPTjYK2Cvbvqt+pVX8QEx4/AE614BL4B/jnpIsUW
         l9PfcJc+uRKyz0D9M5zJBpudF9y/lxIdL7uY7nKXUt1DL0q/UwM05ay5o/+8zx2VncTj
         d7lw==
X-Forwarded-Encrypted: i=1; AJvYcCW9zTAwwX+1ag7GiwXXgFKTWnXGs4pwvEVimmVDpqwTN3Wt9xPVAbYMqkNPYZ7HIEAHUratMZ+KbSFq+00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgmzysUHh0DJAmDGuI72Gn/OwzriC9EV+QCfBzMqZZuh9BovYN
	Bd2juV+h9HoxQfP1QwjhRj8KS8Ere9rdZHvGIBDRzgxjOvD1QKTFZOgAqHVxpRp83N1r5TgzJDm
	UiDl52FBZIvc47yOGmqM4oTZL3I/sBw==
X-Google-Smtp-Source: AGHT+IGJSKHfvsMhUvwjPqGK+Eik+DHwhsGpiGIzc8eEiZwbL/O67mZPRslNsIVgWsFhnS6aB8xtiuFZttwOvoa/sdk=
X-Received: from pjbsu16.prod.google.com ([2002:a17:90b:5350:b0:301:1bf5:2f07])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:57c5:b0:312:ffdc:42b2 with SMTP id 98e67ed59e1d1-31e77a20229mr4261408a91.23.1753479858629;
 Fri, 25 Jul 2025 14:44:18 -0700 (PDT)
Date: Fri, 25 Jul 2025 21:44:03 +0000
In-Reply-To: <20250725214401.1475224-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725214401.1475224-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=samitolvanen@google.com;
 h=from:subject; bh=/A9wG5u0kN1kFNpHvLIRowYQicJ4cQnWyWf+Gqas87Y=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBnNvxZuVG7oqeZ+yGIupruXYYeB7uLwh/+fZn/u5/zVt
 /r0rn/XOkpZGMS4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBE7hxj+CvpvH+tzcfjSXdN
 6j97Ha/kbexLfRVxnUPjUY5C4L03P2sY/ilZPsh1PCcaMftW0wKmy2kvZ3d/nf3mb0bmWZ1z9T+ /arIBAA==
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725214401.1475224-7-samitolvanen@google.com>
Subject: [PATCH bpf-next v2 1/4] bpf: crypto: Use the correct destructor kfunc type
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
target function. I ran into the following type mismatch when running
BPF self-tests:

  CFI failure at bpf_obj_free_fields+0x190/0x238 (target:
    bpf_crypto_ctx_release+0x0/0x94; expected type: 0xa488ebfc)
  Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
  ...

As bpf_crypto_ctx_release() is also used in BPF programs and using
a void pointer as the argument would make the verifier unhappy, add
a simple stub function with the correct type and register it as the
destructor kfunc instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/bpf/crypto.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 94854cd9c4cc..f44aa454826b 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -261,6 +261,13 @@ __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
 		call_rcu(&ctx->rcu, crypto_free_cb);
 }
 
+__used __retain void __bpf_crypto_ctx_release(void *ctx)
+{
+	bpf_crypto_ctx_release(ctx);
+}
+
+CFI_NOSEAL(__bpf_crypto_ctx_release);
+
 static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
 			    const struct bpf_dynptr_kern *src,
 			    const struct bpf_dynptr_kern *dst,
@@ -368,7 +375,7 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
 
 BTF_ID_LIST(bpf_crypto_dtor_ids)
 BTF_ID(struct, bpf_crypto_ctx)
-BTF_ID(func, bpf_crypto_ctx_release)
+BTF_ID(func, __bpf_crypto_ctx_release)
 
 static int __init crypto_kfunc_init(void)
 {
-- 
2.50.1.470.g6ba607880d-goog


