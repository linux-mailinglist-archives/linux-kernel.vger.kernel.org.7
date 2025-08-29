Return-Path: <linux-kernel+bounces-790892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A919B3AEEF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F619864D6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F8125393E;
	Fri, 29 Aug 2025 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qctSZMWs"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF7246BA5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426010; cv=none; b=PZVZQPAcKq16qQ9Zi+vV9olg34Asvbi03Zn9YZb5WaJkEOplj7Il6YP5fpLRW97WjI89A+VsN3crWMuoLNxW86EH21nx++5njdKYxAoSknJQeCI2N+P/ZUIAPH3L67QVZxqFXBzBnLpmCRlhRSNsldTqExsjpKkdXi9xegEp9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426010; c=relaxed/simple;
	bh=Tp7vZw/4x7cT5P0MVANvtyH0Aos8EMa3Yb5qw1+gtSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OlKSP2K/XqZX9tNhm//Xh7fSJcGjkKqKNalsxBWmBReiaDlc3x6XqSb9UB/pX6pdhvPqKkEN5vpIy8a6pcvDolxC+ZyuVWxSGWAVkTH5rEdrQcjDOXcyAtSA3FBVXZb3YL1Aa9NZ4cZDqLTQLbuBgOTK2ICa+b0T+9F/3T8EQk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qctSZMWs; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-772178f07f8so1238478b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756426009; x=1757030809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lGptiAZO7CmFsu6Op41QCgd3wduY0PZh1ZBQnGfhN3g=;
        b=qctSZMWszcdwOcWJ2u9i6YGxcZLzgIN/zYdVV6uBZvst+q8RCAyf7DvefMwwRTLNQo
         D8t8qMn/17YrT0xVoH6dVpbEQbXitGrvEhmyCN6dYY+kMHQkt+oR8BTzUE7+g5EG17no
         EmsOq9euS07LahNd1uLJRw+J2ZTO3Dodl7n1wOp3znSFiiysvA8ho97+jCVMf4d+ngkz
         3QWwJW0mxtwPkldtwQU9JTsbKGpgW4mvo3lWun51zZLXY+RhKzq4oWk24f98LLz8pM5F
         qAzNiiaH4PpLw/z0pqeEe+HAdn8V2uAUe6aiGVaFhObyRkKEeJ4ZF6wzK598ByJ2NipD
         uPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756426009; x=1757030809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGptiAZO7CmFsu6Op41QCgd3wduY0PZh1ZBQnGfhN3g=;
        b=b5mY4Vi39m/kEBX/L7+WVfYX8U4JtXlMtzOcOuJ563gY1lRukUaLoxnujtVDJGZ4Y7
         CZ1FEjQoelfxfR5oTEoIsdzGgE69i9rfxQQX+SXbl/SEGN5zSem6bWp0rcSfY5dZLbr6
         XBS/ZNSeE1aPghGV3j76D2aXFpLqoPn9sQT9ilTXCepU1UyqkmgKQZEsFGWyrYzdQrYZ
         eXkOkMNmQwolWNc0C/uyvaLK8c2yboQohSQ6i4QNgHK+Mxun3l2Mh8gL+t8uE2DTZmMG
         y48DYs8TbDkVXFl+QchRxSLBGgkZ4EQ/qcPLPw8MqSDg0igh9mWO++Fofb12NQKUx2e7
         Ce4g==
X-Forwarded-Encrypted: i=1; AJvYcCVrPcEHvO+k2tx63/GBkJ59pBSBadhNJOx5kDS/oqFKfwDk6Hc+JWAd/g7g0hvMZM4NraWJN6PM6zEEM+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzxn0nUi5W6ZSQE6QZSSCd2ZLX5rFAtUVaWeS565leCnHAUbPW
	xxuyVc49T+ZlNNyFhTaJ+1hkVq8vK6Qh2QVvQGj2lAi/M3YMModP+uovUerhhlRA0YZNSIu/YYW
	1QImegQ==
X-Google-Smtp-Source: AGHT+IGPnFjJJcAxcfWGqx+FCTkwrZqqa6fjukRalr0DOQARC9pSx1FQL9VEBdTmVjF2hDXjOKUOxbz2eFY=
X-Received: from pgbdp2.prod.google.com ([2002:a05:6a02:f02:b0:b42:da4:ef4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a109:b0:243:c315:5122
 with SMTP id adf61e73a8af0-243c3155335mr548500637.10.1756426008991; Thu, 28
 Aug 2025 17:06:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 Aug 2025 17:06:16 -0700
In-Reply-To: <20250829000618.351013-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829000618.351013-17-seanjc@google.com>
Subject: [RFC PATCH v2 16/18] KVM: TDX: Derive error argument names from the
 local variable names
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

When printing SEAMCALL errors, use the name of the variable holding an
error parameter instead of the register from whence it came, so that flows
which use descriptive variable names will similarly print descriptive
error messages.

Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index df9b4496cd01..b73f260a55fd 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -41,14 +41,15 @@
 #define TDX_BUG_ON(__err, __fn, __kvm)				\
 	__TDX_BUG_ON(__err, #__fn, __kvm, "%s", "")
 
-#define TDX_BUG_ON_1(__err, __fn, __rcx, __kvm)			\
-	__TDX_BUG_ON(__err, #__fn, __kvm, ", rcx 0x%llx", __rcx)
+#define TDX_BUG_ON_1(__err, __fn, a1, __kvm)			\
+	__TDX_BUG_ON(__err, #__fn, __kvm, ", " #a1 " 0x%llx", a1)
 
-#define TDX_BUG_ON_2(__err, __fn, __rcx, __rdx, __kvm)		\
-	__TDX_BUG_ON(__err, #__fn, __kvm, ", rcx 0x%llx, rdx 0x%llx", __rcx, __rdx)
+#define TDX_BUG_ON_2(__err, __fn, a1, a2, __kvm)	\
+	__TDX_BUG_ON(__err, #__fn, __kvm, ", " #a1 " 0x%llx, " #a2 " 0x%llx", a1, a2)
 
-#define TDX_BUG_ON_3(__err, __fn, __rcx, __rdx, __r8, __kvm)	\
-	__TDX_BUG_ON(__err, #__fn, __kvm, ", rcx 0x%llx, rdx 0x%llx, r8 0x%llx", __rcx, __rdx, __r8)
+#define TDX_BUG_ON_3(__err, __fn, a1, a2, a3, __kvm)	\
+	__TDX_BUG_ON(__err, #__fn, __kvm, ", " #a1 " 0x%llx, " #a2 ", 0x%llx, " #a3 " 0x%llx", \
+		     a1, a2, a3)
 
 
 bool enable_tdx __ro_after_init;
-- 
2.51.0.318.gd7df087d1a-goog


