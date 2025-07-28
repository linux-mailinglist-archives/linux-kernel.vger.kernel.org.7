Return-Path: <linux-kernel+bounces-748576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE55B142FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5546F4E597C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F26F27FD54;
	Mon, 28 Jul 2025 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bN/k22w/"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB80627C154
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734429; cv=none; b=HTr2HKepSen0R84w6drLyRoK70bdSGtzPrdORewtb6yApJAjzzsimLDWrS9TkVSVYHvxh8kNhExrhfirO/8iBrUVO1F2OMnMUJP82+SrDPu8451jdCTNpjvAmJh3Tf/i9VLCNxtv/bSXIRYN/O4qiTW7faf3eJmn7C4rC+D2o4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734429; c=relaxed/simple;
	bh=g0N5jPV0NJVbr+uE4KyzNHSLwLqm3nr/w2I6IcG52p0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W1AIzs6VDtTWWDvsdSY2YgaT6WMO1HUeAI4I5XxB8U11hLM84RspM3xhKsahTazE0BUQ42f+3G+8n8HKOta7M9cRv7ts3O0bxPpPDos0OTSnGlosmNwA4vKui/7wfrjxohU/Q/UnQkkG64FF9H8A2oBhFMbp/hMF0FYSrziYYTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bN/k22w/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748d96b974cso4375155b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753734427; x=1754339227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6DeVgk8XdY332rGP8e1Y9P9nqTYTkslVRnaqoYpg6g=;
        b=bN/k22w/oDorOExKpBkoGXHGjgyNQ93q6vG0dDptzhE+tLPVINoXtLcVOh3+IJ8b+C
         4yNY2hQQU40QmcXM+kWBPPi7My4Pqj+KvcISlgAT/3ML6UtsqOPHh41WmqrZE3QttGGh
         qogZwVHpRm1ZnpMmw+sbsBleo2b2j4+6dSKbA5rEyoDNviERqZiF6Cy8kS9eE5WaLBiY
         ftEz7WgKA1z7pwFxJFNQGSASEHTCmzY1xwmGAWNHY4xaDJ0sZHzUtv1eunL43gquYfm4
         sZFXyCe8Um3vtMMsd3VgzaAFunoYr64YMQpUO2sTRGmuaa3+KZzun3XEydTB5mB4+TQv
         yEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734427; x=1754339227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6DeVgk8XdY332rGP8e1Y9P9nqTYTkslVRnaqoYpg6g=;
        b=HiW9qk+v65ZczVi09rBBYdP6SL34zuA0hAkb/587iXI9o5LTg4+skRBUx4Qi4pyndo
         uaRuq2wyc0peTUABNBsOs4PEz+mSYJli8ARJ4uivuIeHeMOZuw5T3Z8zRZ0RyHaTQsiX
         8gGOMaUFhjNvtIB81wlwGsVyfTncqHF3JV9gxIkIeXgMlg7iSBlXS15kRbNC4Wgm7OLN
         rlbFDt1a6C6EzXvUmsl/OHqW40+lBqt38J6puIcChV6jRkdOoq5WpW2cyBM1wtuo5RpJ
         INQacjnh2hRt19to+e9A77agUrukvGnla2N9pFSHOPiKHhFw1iqo+yf3JeK8otGkK/09
         6MAA==
X-Forwarded-Encrypted: i=1; AJvYcCURGd+QPqgtARQxRGfX9cNwsDnPG0DEDT1BSuCXigawopg/gqFFEy06aXcxyx90NoylsLy0ox8M1qa2KKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhjNUh+22prba/wOP72zp5ZEAv2vX8lbUrP8GpPwYcI6tQROLK
	jcV8dYWClOyjH5wDfy8vOOmDTUa8jnX7Cv3tfhih4Tg0QrZHPh8fGMlRKDdgNc2jgf+IBIbawyt
	CXy6JzX1gOvm/E2Sx4Eaq7AbV2oeO0g==
X-Google-Smtp-Source: AGHT+IG/t5P9kZcHgHJSbj19h/IqqeeGVkrHfZnsCeG+9fS5N/t5WIwejUn4Q4H8iD8vGQPDyTcO7ribxwwn/Gq1TCg=
X-Received: from pfbmb21.prod.google.com ([2002:a05:6a00:7615:b0:748:e276:8454])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4fcf:b0:75f:913e:aaf9 with SMTP id d2e1a72fcca58-763340dd322mr16222303b3a.13.1753734427408;
 Mon, 28 Jul 2025 13:27:07 -0700 (PDT)
Date: Mon, 28 Jul 2025 20:27:00 +0000
In-Reply-To: <20250728202656.559071-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728202656.559071-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=samitolvanen@google.com;
 h=from:subject; bh=g0N5jPV0NJVbr+uE4KyzNHSLwLqm3nr/w2I6IcG52p0=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBntd4XyUpfd6tissKzNWouT5bbUnwNP+Z2msOyK6RTWZ
 Zyg8Ti7o5SFQYyLQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAExEL5vhf5pEbcJCg/qWRxHl
 feHRro1vmZger1FKfRe15MTJ/kPCfxgZblquf86lvEA75WqiT3q4b8S5XZu8/Waqiuy3aPS9JJb HAAA=
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728202656.559071-9-samitolvanen@google.com>
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Use the correct destructor
 kfunc type
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
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e9e918cdf31f..7f8cd8637a7b 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -249,6 +249,12 @@ __bpf_kfunc void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx)
 		call_rcu(&ctx->rcu, testmod_free_cb);
 }
 
+__bpf_kfunc void bpf_testmod_ctx_release_dtor(void *ctx)
+{
+	bpf_testmod_ctx_release(ctx);
+}
+CFI_NOSEAL(bpf_testmod_ctx_release_dtor);
+
 static struct bpf_testmod_ops3 *st_ops3;
 
 static int bpf_testmod_test_3(void)
@@ -631,7 +637,7 @@ BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 
 BTF_ID_LIST(bpf_testmod_dtor_ids)
 BTF_ID(struct, bpf_testmod_ctx)
-BTF_ID(func, bpf_testmod_ctx_release)
+BTF_ID(func, bpf_testmod_ctx_release_dtor)
 
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
 	.owner = THIS_MODULE,
-- 
2.50.1.552.g942d659e1b-goog


