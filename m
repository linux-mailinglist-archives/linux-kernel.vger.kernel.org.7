Return-Path: <linux-kernel+bounces-801944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB26EB44BED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7389C5A32DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098C222FF37;
	Fri,  5 Sep 2025 02:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y7cg+uXL"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D3221DBD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 02:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040885; cv=none; b=qhLTuWZ5U1/AtJCcG2xwChPrM1hjp8F9OijBQ7VzW54j/GmKRk9eC19SFsZRp/uZF18bWM8WZfmPdCGMfVBPLcgoH32EpL4u8M4419W9C8/WV8B4x2RP/QMsYJyUJD6a5kAcBt3uherIVWZT8Yx6hTQSFRNQ7Zsn2fBsm9+pmnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040885; c=relaxed/simple;
	bh=ROxDYlDbZdUxv6mle6mrNjV7kimAUJqp2gftch85SgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnRZXgpQws+mCAr1VBVhxn+QKKJBwP1XojDhOoW+fRJsytboRrbv9WuCqbpY31vYZ15PEKDVZr3gXT4kZ3xJy4HuhI5SchAd/p6MRy4XO2VRfnNLKeLhqIvI/oNy7n9PsrG7qA/BR39nKd1cbmwCikt1Np5gIy7/8rm5fqfyB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y7cg+uXL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e07ffffb87so671689f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 19:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757040881; x=1757645681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPgXy/JSV/thOQffLkJ+mMtDrYm8eOUlc8683wpwWUY=;
        b=Y7cg+uXLeSQhXai6GiAnFgwnkuHImA/7FQ1Li1bg91qW2/XVevS5snWXL9CsGeq2zU
         5yI3jgRmRrIJrFnKl4djerEXY/RWrdUqAxXIhO0kGZMCBqyFXpWLS2yLTrAJcvctsenB
         M4fZC/L1U67lcwNJMznn/HCvcb/j8I6bOoWdYagS6uWXpgUlKIi07NppgbHef6hZbM+n
         JT95cjcYfl1AhfUzBC7os3wgLofx5BynVyPXRq50fhc5c+mY7qc7/2ZEVzp2JGSza/6T
         s8bpr5wlE2T1va701HTBZnnI/zcr5i5ADPPERFtvJKYaQcYDVx2UTDv9kLBc5lw2eMXc
         SFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040881; x=1757645681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPgXy/JSV/thOQffLkJ+mMtDrYm8eOUlc8683wpwWUY=;
        b=r81mEJ7v97/GSh84Mz7vmKSn17VXn64PydhXdCf5ri9910SYo204qOFJckSDNEczZC
         q4hMMN0BWPx2xXdtlz/5T3aB/kQV9aNi4ngEEH/BQ4w2lA+z1omy8A+BfNeXa0zTBOS7
         Dle7UOR7sS1vJQl8Xh7fm3V0yw+lZ57IPN6CYR0tmAYRDU9g+q86jhK+6PLllWnyhcF8
         v8knNsaLkvDquKDuH47aJUQnbM2W4+6uqseJje0u5NVMasMY1nc5Pq1EEA57UTtqsBAI
         sAT+BTl4CHJDQzEjUs0HdV/7XhFzLQrwWonSJ4RFQzAM7jscoFOBcCrwJ4BZxyi04JCP
         nsXg==
X-Forwarded-Encrypted: i=1; AJvYcCX0oFNoTdnp2K8DpmgoyASpGr3EvDBrF5N7+RQcAWiW40fJprCSiw2BkjCeHcMzulBlLT58d2bEnP78D/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjl3easV942URx9d9bUD43Uwhsr5NHVWO699h+6sapDLUoU6BK
	ucF50tUXSZr8BK9fWTBGB5yVKapBfCPsj7mMkeqpr+Ki7WZrkQBmz4PKhc8/5i93t7k=
X-Gm-Gg: ASbGnct5R5qtmwAR7Ze9uh+4ITk9NLTevpBKfr8u5s25/tQORgXYxB/ALKdMoNnPpfk
	4iH8BQYrs1K71tamGHueEBs76j5DiRENyJUhMsP5k1GFFUE8o3XIwM/rzZYmexUWHpxf6/4F/J9
	nfwHiMwgsjED6Z93Wa9LBApa9R6OfDdq2OGF/WEAYR43UlEB12Q1yj7he8T0DQ+FFjMY18TJA73
	nwD7SY4FMpjD41QxqmCcmc9BFfCgGyCcnB+qlKZAic8c2BS7KM9VamTeO8hxXEFPhdr86T3hZoS
	MyDmad2e0ksH4AhqmEGQ0mNJcSF8w0JGVloJG7JPa7kVZrbuAffFgQ9zUOTVZ1jGVOpc52c99cL
	pAmYh9/hPlxL1PG9fdexbn3JyMyRaqjA/L/r9iA==
X-Google-Smtp-Source: AGHT+IEOg5/gh0SzZXGK8iRIkbBd3Bbh7F26L+S9OdjDBKceU62A4KxoMCAcN4H0X+hecav625Lmmw==
X-Received: by 2002:a05:6000:25c7:b0:3c7:36f3:c358 with SMTP id ffacd0b85a97d-3d1dfb11164mr16205970f8f.32.1757040881025;
        Thu, 04 Sep 2025 19:54:41 -0700 (PDT)
Received: from F5.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b520b545a96sm457225a12.20.2025.09.04.19.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:54:40 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: 
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf)),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [RFC bpf-next 1/1] libbpf: add compile-time OOB warning to bpf_tail_call_static
Date: Fri,  5 Sep 2025 11:53:11 +0900
Message-ID: <20250905025314.245650-2-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905025314.245650-1-hoyeon.lee@suse.com>
References: <20250905025314.245650-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compile-time check to bpf_tail_call_static() to warn when a
constant slot(index) is >= map->max_entries. This uses a small
BPF_MAP_ENTRIES() macro together with Clang's diagnose_if attribute.

Clang front-end keeps the map type with a '(*max_entries)[N]' field,
so the expression

    sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)

is resolved to N entirely at compile time. This allows diagnose_if()
to emit a warning when a constant slot index is out of range.

Out-of-bounds tail call checkup is no-ops at runtime. Emitting a
compile-time warning can help developers detect mistakes earlier. The
check is currently limited to Clang (due to diagnose_if) and constant
indices, but should catch common errors.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 tools/lib/bpf/bpf_helpers.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 80c028540656..0d9551bb90c0 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -173,6 +173,26 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 		     :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
 		     : "r0", "r1", "r2", "r3", "r4", "r5");
 }
+
+#if __has_attribute(diagnose_if)
+static __always_inline void __bpf_tail_call_warn(int oob)
+	__attribute__((diagnose_if(oob, "bpf_tail_call: slot >= max_entries", "warning")));
+
+#define BPF_MAP_ENTRIES(m) \
+	((__u32)(sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)))
+
+#ifndef bpf_tail_call_static
+#define bpf_tail_call_static(ctx, map, slot)				      \
+({									      \
+	/* wrapped to avoid double evaluation. */                             \
+	const __u32 __slot = (slot);                                          \
+	__bpf_tail_call_warn(__slot >= BPF_MAP_ENTRIES(map));                 \
+	/* Avoid re-expand & invoke original as (bpf_tail_call_static)(..) */ \
+	(bpf_tail_call_static)(ctx, map, __slot);                             \
+})
+#endif /* bpf_tail_call_static */
+#endif
+
 #endif
 #endif

--
2.51.0

