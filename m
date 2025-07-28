Return-Path: <linux-kernel+bounces-748242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A32B13E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789554E1206
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FC3275AE2;
	Mon, 28 Jul 2025 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CtbHK615"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B327586E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716386; cv=none; b=olajJWwPA6VEiITM8tywu6+Io78rkY64bsFU5dEgzyM+wS218+KOeG/+KDXYXvjob0zuOhog8wPjVc8WjlnxPcB/hA06FvkSB4gqv64G6SNY47ahh1tKoDnSLXoU0ZPVNwPgw+trUxIiPUS51Tut60xKOV4Wb4j+k3aOLWDyFCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716386; c=relaxed/simple;
	bh=gcFdg60wQIJoUwDRf0ghpUkI0GsFS2FwORXI/aIkLP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m98NVsyMgP8TdGELRqx2J+yS8EgVf1FuTji0KtJm8d3waDSU3N2Bi/ImQDFFPspOk4LJ3LlFE21SuvZMAWC5BPEA5c9ZLxUe0+T/WGd9MPRa8rbx2V+DBqgAMeheQ8mxkwygl0O5L781LIs8sOC9AI1vR0br7+87KL0g+QsjhIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CtbHK615; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b7865dc367so905519f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753716383; x=1754321183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hykQKzruNCv5r2lQ9UgjaMRVHwcJ9+lJEhAaVBLVSIs=;
        b=CtbHK615St/W1JOJpINMPK80a6JABoYa21wx933OQyxh5Zj6w+m93LADxlW+aR14OD
         WFoj/oTHTj7pPW/Xbw2ETrR4HsN5kbMxEfHI/etAu1SI+jdNtNrwAZ+mi7ynUoVH57Nk
         Y8I0Dar+z7wrieYU/ev6nq2Qq8PcpQOApGuYUfPMgTq2p5dWYoeu7i0V8v5QQRMDHbap
         6GGuNi+5zVPKhyYY4A7Sbd5bT6GNFsvL0GQDR2lhnVZJSGiiq8TTa11XpjG8JOEyl8KT
         4apiJqkVzVtztClB+8OCt6bdmIhWSLLxcXrhinmjYvoaF5+Hw/9tBSm0hSVR/9ACFEc4
         ZCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753716383; x=1754321183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hykQKzruNCv5r2lQ9UgjaMRVHwcJ9+lJEhAaVBLVSIs=;
        b=mau6kpx8WpYq7eBiuToyLbpjt1Y7G4w+b86qxPO04dKQGQAL83Nzk8p5ff3m27BCXq
         cPM9zAxpoGr94J0mgNCV5HnArZiep5n6slPT/5olJXi2Y5a7nJJPAgzi3Wqy73sqjclQ
         1A749Ql4Yboo01hCjjJkO27hYnyKxobeLHeGgtuQNA5J2NbawDcc5ywBxoiZflSsLVRl
         EcITEcalQLA+2njj4unGn5FJl/0STUpbPSpB3liUzNAy1Nr63A4AVJNfDP6g2uf531pm
         JkQrClHPo9JQPZl+kdlvwQZt2thRFW7/fkbeauyAoZA2Kh3mwJLQLGyDfH01xi5zOWHq
         fOzw==
X-Forwarded-Encrypted: i=1; AJvYcCVrcBF2H3NfuiQdJa2+Ut3BzhrvPM2AQJBziGB3sAgtSmRUhRjwKSifhvI/KdNqajTaWBhscX0j8T+4XGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKJEw/u+RYoIFobpOInqjO1lVpQ1H3NxjMn2XHariKLYL4tfA
	WfP/EpslmAv4QzCFbAu7Y1OEu4QJQT1aPLbtUJG4ojjGsiTOOBacba3mlus2GsQA1wLONGk90DW
	zWMhw0A==
X-Google-Smtp-Source: AGHT+IHQIsWJFSACJdbsfEOnTkjKDpo0gsN3yoE4tAbV8g2x7pI85GfO9OZIH4sQMnQLtn9vJ1p105jcddA=
X-Received: from wrmc6.prod.google.com ([2002:adf:e706:0:b0:3b7:828a:15fa])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:3110:b0:3a4:d4cd:b06
 with SMTP id ffacd0b85a97d-3b776776423mr8151840f8f.34.1753716382935; Mon, 28
 Jul 2025 08:26:22 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:25:48 +0200
In-Reply-To: <20250728152548.3969143-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250728152548.3969143-11-glider@google.com>
Subject: [PATCH v3 10/10] kcov: use enum kcov_mode in kcov_mode_enabled()
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Replace the remaining declarations of `unsigned int mode` with
`enum kcov_mode mode`. No functional change.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I739b293c1f689cc99ef4adbe38bdac5813802efe
---
 kernel/kcov.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 82ed4c6150c54..6b7c21280fcd5 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -949,7 +949,7 @@ static const struct file_operations kcov_fops = {
  * collecting coverage and copies all collected coverage into the kcov area.
  */
 
-static inline bool kcov_mode_enabled(unsigned int mode)
+static inline bool kcov_mode_enabled(enum kcov_mode mode)
 {
 	return (mode & ~KCOV_IN_CTXSW) != KCOV_MODE_DISABLED;
 }
@@ -957,7 +957,7 @@ static inline bool kcov_mode_enabled(unsigned int mode)
 static void kcov_remote_softirq_start(struct task_struct *t)
 {
 	struct kcov_percpu_data *data = this_cpu_ptr(&kcov_percpu_data);
-	unsigned int mode;
+	enum kcov_mode mode;
 
 	mode = READ_ONCE(t->kcov_mode);
 	barrier();
@@ -1134,7 +1134,7 @@ void kcov_remote_stop(void)
 {
 	struct task_struct *t = current;
 	struct kcov *kcov;
-	unsigned int mode;
+	enum kcov_mode mode;
 	void *area;
 	unsigned int size;
 	int sequence;
-- 
2.50.1.470.g6ba607880d-goog


