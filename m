Return-Path: <linux-kernel+bounces-748575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C521B142F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E157A1FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393AD27CCC7;
	Mon, 28 Jul 2025 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7vC3+tD"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE827990D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734427; cv=none; b=hTQk/DQNVIb44fo31DQt6W675TiziuqoJkQ2LQlbf1NFphYdJtaMCNUH/gmZdedQc0gTa33eHnd3+NlQkOojWekohbTeqKCc8B7RISvfRGk2r+Zl6atK2VifdFnnlD1E8i60nXlSKR9SYfQ/fQdhIw2oMOmQ0L4V8WEvyEa62go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734427; c=relaxed/simple;
	bh=ktAlH1M1bwslpXGeLgOgITzIdzrVmjtd8hLrz38oqVA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ol6sMR0cFVO4/fFRTeuVsyT5+L3NEQ/4cVpe6iZHk+1BDKrOjqa8r/RsOmc1vfuASdB6lwggwoxu6vEglw1TO0eaE3WbU6m+e1UcwQZx6DHcsgVY8ii7WbYcQWUL4c0GgF+6KGtPE1amG5UJVSu3mjSDTtCwCeJlrF83pzvghVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7vC3+tD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3f38d3cabeso3473057a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753734425; x=1754339225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I15NAgyj4G+O2vviAcC/bqIuOaat3gPUhwCYB7reS1M=;
        b=v7vC3+tDqjWKK7n9f+ZYR6n8z2rv4hMWeWWn5cqALBpWIeyDFnqAEXTED1TLHLh+hQ
         dt/YYsiFJNTzA3RKPixhgBCItLX7LYSavlArkkY8c8zUKAlr9OtetWwfIh7cFm1AzM3A
         zP5GAigWR8bdA0xxGg2t4dVgMN0HATpnLOfO9/3WWq5o3XDydDb6f9piO2WWqp0PO6DF
         kHe5v8tB5nSdtIqBefnT1AmUV0nOAz3D+S0rxexrY0vYUnQHcsoer5DpaRbq4BQGOFb6
         2H/UxvyfluH70/GNci8m7ySKt2oqDZ5VXFbMEq4Flr+bezQwAuiupdmYn39HwGxTNXQk
         ESfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734425; x=1754339225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I15NAgyj4G+O2vviAcC/bqIuOaat3gPUhwCYB7reS1M=;
        b=GhYAueFUjTxe4D+KYVIjJZoxvCq/TvinQqFwUp7TtwqiAVpw0M7rKIJ/Y7i8pU8UU8
         fnfXuKjPLtVivd28sY4yy+LDjenbUJ6beg7R7omQDVJ7+gOXo27qRuWIDIFvqTVmyBSh
         BxJFmjjWncRl8Mnf1X0iDpgsn3mViFxN6cN85MQ1pLfRz7FAQcUph3j1ysvhElPfZTPt
         Z5syGorslULYjaflP9yzEMYer27pUl3tXEeKr18FpHzHetGnK9iMx9k4LqEYOrTq4lnf
         AYawOJBqOuoxwrEQDi0sKTWEozHvjPq4RhQmAmbgYzhuxddXZHBsXTGF5EXqH8QzqpBh
         jSgg==
X-Forwarded-Encrypted: i=1; AJvYcCX4sKCZ7r25PhmGW6+0YU4gz3ulqDk5ja4RRbZMXE635tsFUouKLXRBKPZILLtWPiV61ArsdTnU6Xv/9C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8z/vyUxn8VdgEeI/yxV4h4QsxFpvyLHKo7wbyafdRLJTPm+s
	SRVgQ1fA5X2Y3BX5jAj/zUnXuwltJZrFHKE5a693RUiel/xSiR3HkMqtG8eIhmMo2/pHxQQq6Fe
	TJlLuGk6BUBpMmL0A44d31kYQUy8CJw==
X-Google-Smtp-Source: AGHT+IE9oi+ffPcXx6AWpN5iqCz37jlrkj8cFjHkHGI/j9wSGEXIJvDh1Xjdzq2liHFVloQZS+o9kxScpZhIDXhx+WI=
X-Received: from pflc4.prod.google.com ([2002:a05:6a00:ac4:b0:747:af58:72ca])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a49:b0:23d:798b:d290 with SMTP id adf61e73a8af0-23d798bd3e6mr16913294637.29.1753734425520;
 Mon, 28 Jul 2025 13:27:05 -0700 (PDT)
Date: Mon, 28 Jul 2025 20:26:59 +0000
In-Reply-To: <20250728202656.559071-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728202656.559071-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; i=samitolvanen@google.com;
 h=from:subject; bh=ktAlH1M1bwslpXGeLgOgITzIdzrVmjtd8hLrz38oqVA=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBntd4Ukn0y/9qCzwGzzswmJXyTyGp7qBx66Ism8R+D7X
 6+HLkk/O0pZGMS4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBEAiYyMjxi9JgdvK3x4tZb
 ++ZNeqSj+437kfkqzf8NColvf7v+XL+a4b/3WlNt3vIFcjNKeFktr7Xaf9Gf/k7nunm5ROKrrVO cOHgB
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728202656.559071-8-samitolvanen@google.com>
Subject: [PATCH bpf-next v3 2/4] bpf: net_sched: Use the correct destructor
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
indirect function calls use a function pointer type that matches
the target function. As bpf_kfree_skb() signature differs from the
btf_dtor_kfunc_t pointer type used for the destructor calls in
bpf_obj_free_fields(), add a stub function with the correct type to
fix the type mismatch.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 net/sched/bpf_qdisc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index adcb618a2bfc..e9bea9890777 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -202,6 +202,12 @@ __bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+__bpf_kfunc void bpf_kfree_skb_dtor(void *skb)
+{
+	bpf_kfree_skb(skb);
+}
+CFI_NOSEAL(bpf_kfree_skb_dtor);
+
 /* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free list.
  * @skb: The skb whose reference to be released and dropped.
  * @to_free_list: The list of skbs to be dropped.
@@ -449,7 +455,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.owner = THIS_MODULE,
 };
 
-BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, bpf_kfree_skb)
+BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, bpf_kfree_skb_dtor)
 
 static int __init bpf_qdisc_kfunc_init(void)
 {
-- 
2.50.1.552.g942d659e1b-goog


