Return-Path: <linux-kernel+bounces-748574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA91B142F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E50918C2707
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E6427AC5A;
	Mon, 28 Jul 2025 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JL59oUP0"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984092798EA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734427; cv=none; b=LVVzzheQjMz3gWPCFliFhMOBA+g58bDvO61wQurodCQZimV9SQuL+YJt52so/r/LpS3JEcMEaiQQYxKQVHTP0mGIwFlE5u/XCO2ivDQAGEcRqqGnCRQ4X65rj/UgKrfioiaOdwkC7un7gKivTYVrqxik5BEXjCRsO4LhzgWwZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734427; c=relaxed/simple;
	bh=E9W3hDdjKqG0/Dcp7x3HPNh9f9/drXiGUgTBhKvyi4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jdRZQjj4ymA/Ru7/2zjZoeWvZkN7Bx4B9H8oEKGCEA98OvyxsQ6Gqm1EBcouVvlZTjnxZe1CtrVpmEeL2BgF4anLKG13IU+w0DzBEBzsgtVPQwRovMzab6wvq5uAP1x3mfJSGOP1x9uK87aM4ACVYF34cZxdnN7qohOGDoo8d1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JL59oUP0; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-754f57d3259so7714393b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753734424; x=1754339224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lLsarPvPIbFu1ICXlymwwoKbhdf3AVPS0/0vmdmjJ+s=;
        b=JL59oUP0nQ/qwImgEa2xD4spm/ix3JFZc+FnUPM5fmdXICjjiD78YxWU+5difsCWfl
         iiT38fJ+mFyRITevkBh4LIW1uDMpyXN+y+JMsSiwIgmzf07gyEB9rvop8TZ5h/JOgLkJ
         AFxqjC6XbggcFomDeMamx5JqOlmF3b2PN+hqZRUK0Rqk8GX98He5XllZglZu9SQ5DvZt
         7fF5zvCy4226PEEiDK4+599TBQ/gL5ubKNtGe8fOvXLzH5m6SITwZQeJzWtD3EKaR/Ht
         BZUeeb6zHwgjSbA0TuzOhdFjTiU+TF9SJ/FilVJzZ2kj8Anv58cl7DDrDdkqZQtXlbkk
         RzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734424; x=1754339224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLsarPvPIbFu1ICXlymwwoKbhdf3AVPS0/0vmdmjJ+s=;
        b=AV6UO3DRstL7h8WCNXxjghRDVGKvei3ph5uvtZbG3DtcEKO+fcYDNQrtugswLEPa2d
         Dg2C1fTRucVZjyGG6dwZ4eICTPFad/bopUdqZrmvUiiZIaJsCvBqyyfPZvtbWHs28wat
         fSIk79b0GmmfR3tbXksZeKpw5gdZ6jAUl5/ko+lgIj9v8XHnwAtIH8hhswQqkyJ/K+Hw
         x+fwbPhF9qE/WpjM/uRu3ozhf69cEvKFyi+1lystXsMjhC6BHZf6dhJZW02RRBEPRmGj
         oxkaMftBd7VeSgD7CiMqd1S0Y7zTMZh5RT5H5fcU2hrg7EX44f9JUlPu/My2NuVZ+Nyr
         DZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX9b/8iRjOKw7zrZcZh45PTBSUoZDSl7UOFQamPEBYJT8Z5vOrFb2H/SL2oo05+1cnctqMZELcy9fvikM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYInacj6GBR9I8YM+fI8JHcxNNMHeaFlJQaELoDdFhw0qop+I
	iwt7cIYTUgzD9PQlqUpzKFE4PbSMHbmrO4r1kfBJ0uRu5G88UcwyxmCm/HEFFZix5aaMN7m5JC/
	OhoGzbPKsi+Tw6XhoCL5QzUogl2LdbQ==
X-Google-Smtp-Source: AGHT+IFudBMyeFqioTrXVFHd7dr+LUtfkeYFvZh2ukfAkFHnY0iZGi5DHLUxmFcl+BBe9j6zrfFp4V3RN0/7Yz1RG0o=
X-Received: from pfba2.prod.google.com ([2002:a05:6a00:ac02:b0:746:1bf8:e16])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:99a:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-763349ba196mr19216523b3a.19.1753734423880;
 Mon, 28 Jul 2025 13:27:03 -0700 (PDT)
Date: Mon, 28 Jul 2025 20:26:58 +0000
In-Reply-To: <20250728202656.559071-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728202656.559071-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=samitolvanen@google.com;
 h=from:subject; bh=E9W3hDdjKqG0/Dcp7x3HPNh9f9/drXiGUgTBhKvyi4Y=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBntdwU9F3BPfC9rtCPfpHji+X/XJlz/vbmWibGm2azzm
 t+fntDOjlIWBjEuBlkxRZaWr6u37v7ulPrqc5EEzBxWJpAhDFycAjCR2HWMDDMerZi/uVh4jtj6
 e4+1yjMMdFk+Kay+N+GDObebxPT1NWsY/mctsPzI7ekzc8M+zZ7vhTe3l3btsk9T+3Gwrzf+wvE pFowA
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728202656.559071-7-samitolvanen@google.com>
Subject: [PATCH bpf-next v3 1/4] bpf: crypto: Use the correct destructor kfunc type
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
 kernel/bpf/crypto.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 94854cd9c4cc..a267d9087d40 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -261,6 +261,12 @@ __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
 		call_rcu(&ctx->rcu, crypto_free_cb);
 }
 
+__bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
+{
+	bpf_crypto_ctx_release(ctx);
+}
+CFI_NOSEAL(bpf_crypto_ctx_release_dtor);
+
 static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
 			    const struct bpf_dynptr_kern *src,
 			    const struct bpf_dynptr_kern *dst,
@@ -368,7 +374,7 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
 
 BTF_ID_LIST(bpf_crypto_dtor_ids)
 BTF_ID(struct, bpf_crypto_ctx)
-BTF_ID(func, bpf_crypto_ctx_release)
+BTF_ID(func, bpf_crypto_ctx_release_dtor)
 
 static int __init crypto_kfunc_init(void)
 {
-- 
2.50.1.552.g942d659e1b-goog


