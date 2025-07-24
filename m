Return-Path: <linux-kernel+bounces-745038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDEFB113F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F571CE6800
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F3242D80;
	Thu, 24 Jul 2025 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1qurIDdg"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676E23C8A3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396356; cv=none; b=KuPOCdk0TCP8reaZb/REtXk6XxbwWNI8JRlVn6VM3gxKsZ+9RVk1EYXIKxCN4SZbAXUwTxqFSMFXjXIRV2x1rP5qtpPvxqUhATDJX6sQ8HOxKbT8rXvXnB0Vgn9vm0AZ/tmRHD2nmbroOP/PkPHx7XxMZtcMOwv1XNbLHWUI3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396356; c=relaxed/simple;
	bh=HdyMAFjZbu02whUTePCpE5p+N23Zl14tyqBKb8V/jYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PV4m88kDk2jZIW9nGeDjFolCnjo7W3JuMvvKWU1/qpmAHRWfNwmGPlSd3mBOO+X6hB0v81lmI9reB5+LLyfz/nvoH4u4d8qgHoQjo0XOsqYaqufFivaEmS9cexX3SQS8mwePNOvuVAXtpH8zJsNvjKTbTVYaVwuNpafW+q6GKUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1qurIDdg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235dd77d11fso14783335ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753396354; x=1754001154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oLn0DiL3hOFcQhckESIdE+NOImyGoMwrsGYgAXL6v7w=;
        b=1qurIDdgzjK6wVts9X7KFmDYYx3sGOiCIa3xcPbEU02UgLwo/e69nY4ZN74ST9NEZZ
         XZlMhefHrw7iOTuSddSxYM4BTUVN71r6abgSIBGcNO2aFW3k5XPho1ZZr1AlY48A1u1e
         +ykwX/MWr2TFzJrxXq0iRgY7ZfC7GsvjCiGpWTQN06vTVheY2v276VQB10JIOyvoSL5N
         NemMvmjiRArkOAe/FT2nBwwDeLFS9/DYsi+CyZUGwZqXRDaHLqmMmVqYjBbjtG10uOso
         Ms1lWv53RF8oVInA1qkpe6tMOv6Sy52k2KXmy/ZKSLp3j1WoOF5KErv8uD+qS5WMZsVD
         B/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753396354; x=1754001154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLn0DiL3hOFcQhckESIdE+NOImyGoMwrsGYgAXL6v7w=;
        b=UfCFGdU2/OhtOVzybtm512P+RAhYjpqSk7pkIxgyC1abNgmy5RnyYSPC5GOwPob5Jz
         tUQYx8UhX6LGR5W/l0dUkkLm9BUys1ZMFR63qhW8Y4BnIqn9uwCsVF4rmU0ZvoCCuQXh
         tGF1AR5dGVAd1okSxq9if3mMWLMzGN5WfsgTlM8jLP07DTd/HJGgz/J1nd0DHtR3PO5/
         T8REJmBgkEDBBaXQJz2m8ZuWef6v6GmnBAJNrPVMKXqMnsewJIgdMPJByat+jRsL/YNU
         3WJPD0fynGoHO3tfsjdWQPEr5eI0IyyyraLZW/c5PPbCJ2t9r0i9JrdzExr5ZaprneI6
         3MAA==
X-Forwarded-Encrypted: i=1; AJvYcCUL0knZYWKDva7Flfn7EkiRCEcJ+EcHOWv37oFXcXRQeDewkqcMzpJOV3Cxc6ehckbXAPRY9aLJC+kyIKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6c1aWarRBlVe3sv3FjR/d6kfXj1lbZN46IPi+cidnaTaapJ5e
	J1Cs+kYghALXk9LNEFOIwrMh84IHC8VJwvZnFU+cThKstDFQIo5zcz9ToAdOaLMhJSlhVqYI+RC
	k49TeOmvZLKzZhP7IiiaY5S7Qsa4DaA==
X-Google-Smtp-Source: AGHT+IE/QhfK7fSPgf6hdUxRmb8vKHKetBGCtQfilh+Wr3qz/NoJP6cIGl1MPxzdX5KENkA2B5R5VHLZrK0UZU3hIFw=
X-Received: from pjtu6.prod.google.com ([2002:a17:90a:c886:b0:311:d79d:e432])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c409:b0:234:c8f6:1b05 with SMTP id d9443c01a7336-23f9824cb15mr100337625ad.52.1753396354017;
 Thu, 24 Jul 2025 15:32:34 -0700 (PDT)
Date: Thu, 24 Jul 2025 22:32:28 +0000
In-Reply-To: <20250724223225.1481960-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724223225.1481960-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=samitolvanen@google.com;
 h=from:subject; bh=HdyMAFjZbu02whUTePCpE5p+N23Zl14tyqBKb8V/jYA=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBlNW6rOiG77U+Q9PzPkhfjcr1Hn7wj82L5m+XXflWq5j
 omxuy6s6yhlYRDjYpAVU2Rp+bp66+7vTqmvPhdJwMxhZQIZwsDFKQATcexk+J9+jq/5nuOKW/N4
 pq9cNNmp3ffeizPy/2vy9fYfUOZ+0PeKkWGmiPvGYntji0k8U093njbInM8oeOolo9ypeYwl+ov Dz3EDAA==
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724223225.1481960-8-samitolvanen@google.com>
Subject: [PATCH bpf-next 2/4] bpf: net_sched: Use the correct destructor kfunc type
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
indirect function calls use a function pointer type that matches
the target function. As bpf_kfree_skb() signature differs from the
btf_dtor_kfunc_t pointer type used for the destructor calls in
bpf_obj_free_fields(), add a stub function with the correct type to
fix the type mismatch.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 net/sched/bpf_qdisc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index adcb618a2bfc..4558f5c01ed5 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -202,6 +202,11 @@ __bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+__bpf_kfunc void __bpf_kfree_skb(void *skb)
+{
+	bpf_kfree_skb(skb);
+}
+
 /* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free list.
  * @skb: The skb whose reference to be released and dropped.
  * @to_free_list: The list of skbs to be dropped.
@@ -449,7 +454,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.owner = THIS_MODULE,
 };
 
-BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, bpf_kfree_skb)
+BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, __bpf_kfree_skb)
 
 static int __init bpf_qdisc_kfunc_init(void)
 {
-- 
2.50.1.470.g6ba607880d-goog


