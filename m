Return-Path: <linux-kernel+bounces-789952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 397D6B39D47
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE58189AC77
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B48430F932;
	Thu, 28 Aug 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TaFMVa6q"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE0A1DDF7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384089; cv=none; b=Nm9jvGRGm03rvktvJS+MukN9xmbq2LuQG0I+69xFI/rldnGuPivCfZ8HKxXKbUL+MpCUVvBh+V2SW+xQhZW1qdg+nbol+JMlbyrDLaUe64dIkFOWMLPQvUu0NtFPFZwPcp+pcSQEp8r4+iRTkL03xSi1hkUprCSMeqrA0HlabcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384089; c=relaxed/simple;
	bh=GBInbJAJRj5ONLa1gt+nD49xcbsKA8ganwjzvi5pg4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j7XNpa4pc8+6B0pKL62Ehutze6pFCys4SmmoTvPXjfxEUHe7eyk0sSkQzdMS2oj/CW4uwd9tHwTzbyDB3fcNI0DMivaLQtrz3YdH1o5H0QPQ+0v4dupssNNagKIsW8cfF/XLXRZ8QGnVwuenv7uQRUBeUwXpgZ6vleGdBvVTJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TaFMVa6q; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3c584459d02so627173f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756384086; x=1756988886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NT5ndZiyJJqWCgiYx08dUhX4e7n0TWvqf6AS15EwVrA=;
        b=TaFMVa6qC3s0EPnSfEx/WJyzKAquVDgPozdbA4YkCNTad4TpgnnmM+4fJ3AHS/22Z6
         0jpGFDXCY1crd+rrPzs8FiVK6aXo1cSR2fq1iAuo5OJ3K5qjY9iUVx3/G5T/CpgYKGCu
         oXKiCRxuQVZOy36b+U2VB+YVYGq5LE8GdjEl++OKo1ZuoTbnDErbK3UyP+sZYL0SYawB
         PmFR609Fff3w9jBGms+yf/29meuBKyzxuCPJA7p8lDPx/ubRXc0xdnrys0D40eq9xH/s
         uKjaavi4AT/acd85ztoBu+3PlY7ZklbuowtEiQ6i18XmH66KJSvqxWrqm+9bbdAsDxZs
         rpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756384086; x=1756988886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NT5ndZiyJJqWCgiYx08dUhX4e7n0TWvqf6AS15EwVrA=;
        b=b39MsUmqTnpeXKT3Rc2Qc4KnQ5hZmaATyR+KA567BlXQuiYOuSTJUhnJNOOqjBslAm
         PSgtcKLW1g28/AOdO2BFkXlJ84dW4U4MhDVFpDhNO9GyWQ54XCmmhOOC11ygCs1P3+OM
         C/CpTa5xnKQKnnwrKRR/YrM68PoDXhlaQxyXTZRupJfVPW99XQvm33sjfMY0b1y3pDsi
         PGenK4iT480UhHl+5VSwaGFgNMfJzGBGIV/BQVod1bS//UBXWPixk8VwqqvgPtpK12L2
         0BGxS66903dBlPilY4RhGCMusCEMYGrPfrI+vbGNVa+MZMCmvwnWNehwhnWzAWqTcNo9
         K/kw==
X-Gm-Message-State: AOJu0YwFLL4antSJg9Q2fAcmz2DSugNJp9qmvsbkGaY/5+oSWbtiSz8a
	noOco0gB1OzSKRyM4QEABKF0iQpl+jnfwYU+Jb50/wLQA4caYB/kRp8kz1xiTnxGJC2gZFNJtC8
	pB+h3fTKx4501OA==
X-Google-Smtp-Source: AGHT+IGJWI0ZFUz+7Oag9wdtFaUSV6+VfGrApOEbus6AYfztggP4vFm0mvCRRgVub8dgHHObAbgpSPShD8KaaQ==
X-Received: from wmbel18.prod.google.com ([2002:a05:600c:3e12:b0:45b:732e:5a16])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1881:b0:3c9:24f5:470c with SMTP id ffacd0b85a97d-3c924f54bfemr12451964f8f.42.1756384086018;
 Thu, 28 Aug 2025 05:28:06 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:27:58 +0000
In-Reply-To: <20250828-b4-vma-no-atomic-h-v2-0-02d146a58ed2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828-b4-vma-no-atomic-h-v2-0-02d146a58ed2@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250828-b4-vma-no-atomic-h-v2-1-02d146a58ed2@google.com>
Subject: [PATCH v2 1/4] tools/include: Implement a couple of atomic_t ops
From: Brendan Jackman <jackmanb@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

The VMA tests need an operation equivalent to
atomic_inc_unless_negative() to implement a fake mapping_map_writable().
Adding it will enable them to switch to the shared atomic headers and
simplify that fake implementation.

In order to add that, also add atomic_try_cmpxchg() which can be used to
implement it. This is copied from Documentation/atomic_t.txt. Then,
implement atomic_inc_unless_negative() itself based on the
raw_atomic_dec_unless_positive() in
include/linux/atomic/atomic-arch-fallback.h.

There's no present need for a highly-optimised version of this (nor any
reason to think this implementation is sub-optimal on x86) so just
implement this with generic C, no x86-specifics.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/include/linux/atomic.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/include/linux/atomic.h b/tools/include/linux/atomic.h
index 01907b33537e04c5e860dd2cd61a61dfab6ea8f1..50c66ba9ada58cf05125e2e2472734bf3b0f8595 100644
--- a/tools/include/linux/atomic.h
+++ b/tools/include/linux/atomic.h
@@ -12,4 +12,26 @@ void atomic_long_set(atomic_long_t *v, long i);
 #define  atomic_cmpxchg_release         atomic_cmpxchg
 #endif /* atomic_cmpxchg_relaxed */
 
+static inline bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new)
+{
+	int ret, old = *oldp;
+
+	ret = atomic_cmpxchg(ptr, old, new);
+	if (ret != old)
+		*oldp = ret;
+	return ret == old;
+}
+
+static inline bool atomic_inc_unless_negative(atomic_t *v)
+{
+	int c = atomic_read(v);
+
+	do {
+		if (unlikely(c < 0))
+			return false;
+	} while (!atomic_try_cmpxchg(v, &c, c + 1));
+
+	return true;
+}
+
 #endif /* __TOOLS_LINUX_ATOMIC_H */

-- 
2.50.1


