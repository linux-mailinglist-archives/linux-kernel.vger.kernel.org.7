Return-Path: <linux-kernel+bounces-640561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14432AB0679
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 01:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75216174208
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 23:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE93F22F17A;
	Thu,  8 May 2025 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYrcAFRI"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACAB28373
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746746818; cv=none; b=c32OFLfJZbar6zKDmUarXD4zcg5aMI2PtLzCKO7zU9NQyg7imHMeU60NyXi61TZyMUkjO6/WZy3cpLHGCXuBSDnx1rGPcTCO8ISo3p4i3743z+Uiw+OIAK3OEQACS0oC/M6vHqg+IpWmFdcKuD0++DoViUo1meXESZs7pKtKMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746746818; c=relaxed/simple;
	bh=N3A1RFAUxdb/zhCgZqzN++tEniUDnjZRESB/TMHQY0E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XTJ4uMM5FwfQH5hU8Y2CaBWCC5IVLj2VgI0qhgsyNW3/Zzh5zPyJhWoPaIT4yTmAIfuGXWBoHTOlToje8xHRRHQKgMuuDiX6beku/qEvL0frbyk91P1b/pUKal9JfB1++C47G/90fQGYgy3LeQBFuoZedE6f1uDYGJuKSgaGIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYrcAFRI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30abb33d1d2so2212439a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 16:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746746816; x=1747351616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rfYEy/9sSy/8XsGJmMn2Ylxn/3RsXCzZGABntdj6U60=;
        b=fYrcAFRIxGONzEdnrV493wPJ195Cfe7HwI6sjd1XfCZfcTsL178dk1ixtaLEmyxivw
         +HldsoQRfbuRGKHqev/Z7Wh9k5tWd2qpy3Vg7P7gUXxy5+9MnzjM/YIOhLq0yWh3EME0
         ZKRbheJMvymbk7P9rAhXUCT7AFRWh7ocGg75V1Mgiy4UTVm+CviexuhJ0Iy0pM60inq2
         qQYnmdYRJmNPfV9jGq0Yh3C8/igclMQiFcb0bEfs6ETzDJr/GLXlZddUiaP8XqsDu26L
         e3Yme9K6WmRwVyGO7fkZtYJRoKs81uNAhQEUN9JR2hGF81rmLVbwQC7hrOWMphBJTCCS
         SQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746746816; x=1747351616;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfYEy/9sSy/8XsGJmMn2Ylxn/3RsXCzZGABntdj6U60=;
        b=X45HbxK/jZNI5QoKq7UaBcGOX12YopxLm153bDR0nMP8GSEHGLIKkFDiiL5L3gMt0W
         z+/BpwNoYhclnSrUAjOFgj0G7d35vDd2BtOISZRx0eFltZAufW/NTN8ZIkgh7+cwtd/i
         Yw3Jt65Ecr0YH/aI31TO4w8E2u3/uW07KmddgKlIuxF3jgFBj3ROvgcq4Eytr9xzjW3+
         6kWMH1t3aMDE5SyDABhwAAtx2NbUgt5wEddsnzNlvlpnh2KTnKUG6n2vP9s1Y1mj06ch
         nSL88aVx4qe3AyfLTqEhqiRjflpvmpnz/8y2z7GUapXj3DOK3NR/hfdauqbxPGxajwxS
         zuHA==
X-Forwarded-Encrypted: i=1; AJvYcCV1cRWMIgZtWmWIFX5ZdLhBkHJnnqLjS2FGkvo+0xlfR9/d21a7Ll56pBm17zygghdcT4MPLTCjx+/VtjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXhivgkFxgl5EeJyuFoLLO9/OtYUT0Xe+7XzzZapYvAb0DloMG
	G39CMZvRdWcpEsKSEaR67qtfVAAJ1g35vy5EmH2SR1SrFyLJkiIogFKwS3Jqqg7poGdQWSXKq2x
	4
X-Google-Smtp-Source: AGHT+IG97FSz9yCXWd8j63Cw6gLHn4U28B3RdLV5MKzUOQOfQIsxT/Hlwd4/TrJ6C1SkwKVNQYtvAQqeplI=
X-Received: from pjbph5.prod.google.com ([2002:a17:90b:3bc5:b0:30a:7da4:f075])
 (user=yabinc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52c5:b0:2ff:72f8:3708
 with SMTP id 98e67ed59e1d1-30c3d3e87d2mr2693183a91.17.1746746805843; Thu, 08
 May 2025 16:26:45 -0700 (PDT)
Date: Thu,  8 May 2025 16:26:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508232642.148767-1-yabinc@google.com>
Subject: [PATCH v5] perf: Allocate non-contiguous AUX pages by default
From: Yabin Cui <yabinc@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Anshuman Khandual <anshuman.khandual@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

perf always allocates contiguous AUX pages based on aux_watermark.
However, this contiguous allocation doesn't benefit all PMUs. For
instance, ARM SPE and TRBE operate with virtual pages, and Coresight
ETR allocates a separate buffer. For these PMUs, allocating contiguous
AUX pages unnecessarily exacerbates memory fragmentation. This
fragmentation can prevent their use on long-running devices.

This patch modifies the perf driver to be memory-friendly by default,
by allocating non-contiguous AUX pages. For PMUs requiring contiguous
pages (Intel BTS and some Intel PT), the existing
PERF_PMU_CAP_AUX_NO_SG capability can be used. For PMUs that don't
require but can benefit from contiguous pages (some Intel PT), a new
capability, PERF_PMU_CAP_AUX_PREFER_LARGE, is added to maintain their
existing behavior.

Signed-off-by: Yabin Cui <yabinc@google.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Change since v4:
Fix typo. Remove too verbose comment. Add Reviewed-bys.

Changes since v3:
Add comments and a local variable to explain max_order value
changes in rb_alloc_aux().

Changes since v2:
Let NO_SG imply PREFER_LARGE. So PMUs don't need to set both flags.
Then the only place needing PREFER_LARGE is intel/pt.c.

Changes since v1:
In v1, default is preferring contiguous pages, and add a flag to
allocate non-contiguous pages. In v2, default is allocating
non-contiguous pages, and add a flag to prefer contiguous pages.

v1 patchset:
perf,coresight: Reduce fragmentation with non-contiguous AUX pages for
cs_etm

 arch/x86/events/intel/pt.c  |  2 ++
 include/linux/perf_event.h  |  1 +
 kernel/events/ring_buffer.c | 29 ++++++++++++++++++++---------
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fa37565f6418..25ead919fc48 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1863,6 +1863,8 @@ static __init int pt_init(void)
 
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
 		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_NO_SG;
+	else
+		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_PREFER_LARGE;
 
 	pt_pmu.pmu.capabilities		|= PERF_PMU_CAP_EXCLUSIVE |
 					   PERF_PMU_CAP_ITRACE |
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0069ba6866a4..56d77348c511 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -301,6 +301,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
 #define PERF_PMU_CAP_AUX_PAUSE			0x0200
+#define PERF_PMU_CAP_AUX_PREFER_LARGE		0x0400
 
 /**
  * pmu::scope
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5130b119d0ae..d2aef87c7e9f 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -679,7 +679,15 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 {
 	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
 	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
-	int ret = -ENOMEM, max_order;
+	bool use_contiguous_pages = event->pmu->capabilities & (
+		PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE);
+	/*
+	 * Initialize max_order to 0 for page allocation. This allocates single
+	 * pages to minimize memory fragmentation. This is overridden if the
+	 * PMU needs or prefers contiguous pages (use_contiguous_pages = true).
+	 */
+	int max_order = 0;
+	int ret = -ENOMEM;
 
 	if (!has_aux(event))
 		return -EOPNOTSUPP;
@@ -689,8 +697,8 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 
 	if (!overwrite) {
 		/*
-		 * Watermark defaults to half the buffer, and so does the
-		 * max_order, to aid PMU drivers in double buffering.
+		 * Watermark defaults to half the buffer, to aid PMU drivers
+		 * in double buffering.
 		 */
 		if (!watermark)
 			watermark = min_t(unsigned long,
@@ -698,16 +706,19 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 					  (unsigned long)nr_pages << (PAGE_SHIFT - 1));
 
 		/*
-		 * Use aux_watermark as the basis for chunking to
-		 * help PMU drivers honor the watermark.
+		 * If using contiguous pages, use aux_watermark as the basis
+		 * for chunking to help PMU drivers honor the watermark.
 		 */
-		max_order = get_order(watermark);
+		if (use_contiguous_pages)
+			max_order = get_order(watermark);
 	} else {
 		/*
-		 * We need to start with the max_order that fits in nr_pages,
-		 * not the other way around, hence ilog2() and not get_order.
+		 * If using contiguous pages, we need to start with the
+		 * max_order that fits in nr_pages, not the other way around,
+		 * hence ilog2() and not get_order.
 		 */
-		max_order = ilog2(nr_pages);
+		if (use_contiguous_pages)
+			max_order = ilog2(nr_pages);
 		watermark = 0;
 	}
 
-- 
2.49.0.1015.ga840276032-goog


