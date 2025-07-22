Return-Path: <linux-kernel+bounces-741652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE743B0E74B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021A13AF83D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731BA28C032;
	Tue, 22 Jul 2025 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lmcvv86+"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531C28C2BE
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753227921; cv=none; b=DQlQnaMzKUHn5Xa+3WBb5AZ4YXIXfdEI0URO9FHkLOZ30n1nrQctXVIIR7Q9iODdGNec0qAErtoj2CKd3O1X9ah/hyOD0ltRVCqmqwnZ9uKmAIi7FGBPDd4DUWnm7raNKqGW+co3b3aC9bP6Q5jNSxQFLFQ6oKb/rjvnfT+bHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753227921; c=relaxed/simple;
	bh=wKItO+g8xJ9nYcQ9o9ej5OT0785WfI2medOlAaevYlg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NVAudOB/ZjMXPYPsFPr94XYunahD/q1CLg8yD3k3AIZ/IroeuJ3Ch8NiZvGMa4n4UGguitD7/UAI1bKT1H4HVcFNdXJnPPDlw07BxQgSBwDKkB4KifYxAHEF1NkTd8+JEMYWeJaxMmcReQAkUAIYFs/uKVa5kd4mOeSlSbYu5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lmcvv86+; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2f3b9f042a6so6207181fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753227919; x=1753832719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymOJFkk9cAqxbyOq2CFl3E1omI8ig1iTY04bOmR9Mog=;
        b=Lmcvv86+47ynWUKImStsf/eqZV6SY2dGiTRci/ll5CITmGrEs2ilgHOHupJcbaiycT
         2H1DuvFZQwgBjl6A6n/UYay8IodkEJwRdnfvgbIHeq43CWD4AFQ2420W2Nad6PoO20v7
         MCB5rdP1Pn7OiXJzArZ9gSbJEZPsHFkLFvOJ08hbPDzPxpJgfFsKWr1iGBVaXGoa8Yez
         jwhl2Y6JydYQDVMipq43VT4FJTn+gLmwUlf68ZoKLKLwyWnSP/uoQtIxcrwOn1lW+T9J
         zzmKLAMXe0sWni85S40iS+gJHXO03I29fMZHs0gs15FL10sipdjAyVlfmWoxiTik2KVy
         aorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753227919; x=1753832719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymOJFkk9cAqxbyOq2CFl3E1omI8ig1iTY04bOmR9Mog=;
        b=B2d2FHDJcz3Ss8H70pWMV7oML9kkWgG8bp9LLuyqIg+lPjx+Qcc3VCKoxHjI+TWBoN
         ANIaNmHJrFH4pITp1+9q/JsB5uVQOchRG53yoVRxt5CXXa4Eb93wjPxFFX25oV3qIVTC
         ToJEKv0E3izfPs6Uno0IFx1R6/WjQGSBZ2owaz1adoP884UlfTQBlid1BLFlFE7TUrwp
         rZeDjPPiN4wDuOzPeWZ1hOJrjIYu9g09ujV6wTcxreM3CeESy6RVVUEvjMIIRCNMK/oM
         JoH8qSVLly/npaMYXTkGkKeSBWKwnYyqPDuT+FdzwrOrMnMJYzA52vP+DFo61/zV9PHx
         Hedg==
X-Gm-Message-State: AOJu0YxQellvO5BmKu2vil+lZ8ELalbNclMTTzOIOjq0CmLuL5ihkfWd
	ZOLe9GbRayKPVXEEThOcgH/S1HCKwLjTR4+08HRDsJfM1BVcCDPwyP7tQnbtjiFcXAQ8UXOj3UQ
	KFv/Is7IO2g5sNGyxdZwAOSKNUbEdkCG9Qbc4Sld9srICzRsxbmjuaf++1gDy/8LP6AHXdfKiBT
	u+c0agoi1RZQsPtwWENYHJ22wcavJkJa4BnE4AbTMceN9s9clKRA==
X-Google-Smtp-Source: AGHT+IHnqAj8P5CO/OXhRB0OUthRBxdYC/P1oqIRfraQc8gklY9NaxsaPXadOGjupc7H0glTXMG8rmUyZ7ui
X-Received: from oabwh20.prod.google.com ([2002:a05:6871:a694:b0:2ff:a390:4466])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:2113:b0:2ff:8ad9:f12
 with SMTP id 586e51a60fabf-306c725055amr659320fac.22.1753227919146; Tue, 22
 Jul 2025 16:45:19 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:45:07 -0700
In-Reply-To: <20250722234508.232228-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722234508.232228-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722234508.232228-2-ynaffit@google.com>
Subject: [PATCH v2 2/2] binder: Use seq_buf in binder_alloc kunit tests
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Christian Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Replace instances of snprintf with seq_buf functions, as suggested by
Kees [1].

[1] https://lore.kernel.org/all/202507160743.15E8044@keescook/

Fixes: d1934ed9803c ("binder: encapsulate individual alloc test cases")
Suggested-by: Kees Cook <kees@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
This patch is based on top of char-misc-next.
---
 drivers/android/tests/binder_alloc_kunit.c | 46 ++++++++++------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/android/tests/binder_alloc_kunit.c b/drivers/android/tests/binder_alloc_kunit.c
index f8c05bf15c2d..9b884d977f76 100644
--- a/drivers/android/tests/binder_alloc_kunit.c
+++ b/drivers/android/tests/binder_alloc_kunit.c
@@ -15,6 +15,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/seq_buf.h>
 #include <linux/sizes.h>
 
 #include "../binder_alloc.h"
@@ -107,40 +108,33 @@ static const char *const buf_end_align_type_strs[LOOP_END] = {
 };
 
 struct binder_alloc_test_case_info {
+	char alignments[ALIGNMENTS_BUFLEN];
+	struct seq_buf alignments_sb;
 	size_t *buffer_sizes;
 	int *free_sequence;
-	char alignments[ALIGNMENTS_BUFLEN];
 	bool front_pages;
 };
 
-static void stringify_free_seq(struct kunit *test, int *seq, char *buf,
-			       size_t buf_len)
+static void stringify_free_seq(struct kunit *test, int *seq, struct seq_buf *sb)
 {
-	size_t bytes = 0;
 	int i;
 
-	for (i = 0; i < BUFFER_NUM; i++) {
-		bytes += snprintf(buf + bytes, buf_len - bytes, "[%d]", seq[i]);
-		if (bytes >= buf_len)
-			break;
-	}
-	KUNIT_EXPECT_LT(test, bytes, buf_len);
+	for (i = 0; i < BUFFER_NUM; i++)
+		seq_buf_printf(sb, "[%d]", seq[i]);
+
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(sb));
 }
 
 static void stringify_alignments(struct kunit *test, int *alignments,
-				 char *buf, size_t buf_len)
+				 struct seq_buf *sb)
 {
-	size_t bytes = 0;
 	int i;
 
-	for (i = 0; i < BUFFER_NUM; i++) {
-		bytes += snprintf(buf + bytes, buf_len - bytes, "[ %d:%s ]", i,
-				  buf_end_align_type_strs[alignments[i]]);
-		if (bytes >= buf_len)
-			break;
-	}
+	for (i = 0; i < BUFFER_NUM; i++)
+		seq_buf_printf(sb, "[ %d:%s ]", i,
+			       buf_end_align_type_strs[alignments[i]]);
 
-	KUNIT_EXPECT_LT(test, bytes, buf_len);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(sb));
 }
 
 static bool check_buffer_pages_allocated(struct kunit *test,
@@ -311,19 +305,20 @@ static void permute_frees(struct kunit *test, struct binder_alloc *alloc,
 	int i;
 
 	if (index == BUFFER_NUM) {
-		char freeseq_buf[FREESEQ_BUFLEN];
+		DECLARE_SEQ_BUF(freeseq_sb, FREESEQ_BUFLEN);
 
 		case_failed = binder_alloc_test_alloc_free(test, alloc, tc, end);
 		*runs += 1;
 		*failures += case_failed;
 
 		if (case_failed || PRINT_ALL_CASES) {
-			stringify_free_seq(test, tc->free_sequence, freeseq_buf,
-					   FREESEQ_BUFLEN);
+			stringify_free_seq(test, tc->free_sequence,
+					   &freeseq_sb);
 			kunit_err(test, "case %lu: [%s] | %s - %s - %s", *runs,
 				  case_failed ? "FAILED" : "PASSED",
 				  tc->front_pages ? "front" : "back ",
-				  tc->alignments, freeseq_buf);
+				  seq_buf_str(&tc->alignments_sb),
+				  seq_buf_str(&freeseq_sb));
 		}
 
 		return;
@@ -383,8 +378,9 @@ static void gen_buf_offsets(struct kunit *test, struct binder_alloc *alloc,
 	if (index == BUFFER_NUM) {
 		struct binder_alloc_test_case_info tc = {0};
 
-		stringify_alignments(test, alignments, tc.alignments,
-				     ALIGNMENTS_BUFLEN);
+		seq_buf_init(&tc.alignments_sb, tc.alignments,
+			     ALIGNMENTS_BUFLEN);
+		stringify_alignments(test, alignments, &tc.alignments_sb);
 
 		gen_buf_sizes(test, alloc, &tc, end_offset, runs, failures);
 		return;
-- 
2.50.0.727.gbf7dc18ff4-goog


