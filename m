Return-Path: <linux-kernel+bounces-734462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4801DB0821E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADEE1A6016B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8B1E5215;
	Thu, 17 Jul 2025 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjQcVzBN"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8641E260A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714630; cv=none; b=TGMrfdxMloS+Rwlg5diCFvLV/P9lMl3/UGJ5Hmpr1f1v6f45bP7FXldIFdeUhrMk3IFJyDgx8bJNSUndK0zc04gRJp7rVF5QyU9GV+3budVrxfyzOzy+lN3nnXC+WfGhjupWV7Cz5iqLDTQFB3Eh5vLH2of4I8FcU19egZk8JsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714630; c=relaxed/simple;
	bh=UCTY/ToR6H/kxtSRZLCamKknTXWIZQ+jo/lnUBZnojc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e2USpQcTvlpMrN6MzixDWd03aKktioPTJpZdYE0aFw/frk0bhib4PJVfN4LuL1WTAYmNhiXCwIQQuUDVv6cI5/eoALVYC7JirnUwNr18Zv9mga4gwdd3UDV5+Few+Va4UggliZ6ad1DLihs5NDovZYakyKFHro5mpoX1ZMes35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YjQcVzBN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132e7266d3so445137a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752714628; x=1753319428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNFQfALT87iSSNOUBXVFi9G5jROQeOXrFq606md2L0U=;
        b=YjQcVzBNdGQ8OdMDkIk2NLd3hhO/j+XT6DSylT1kY/LK+cXkrn2AmEYrxjQuzvkD8m
         35TzHgTRCrp/AGj0JybXQ+b+UF5TiC2bobx5NQ7Ivlhs2x2yhQbWjCIqN6E1L9REZlXj
         1FgBSccdvsoRdbOyVRXc9E6uZzcyfGikiyyopNjIxVO7E34ZEoe78c8hXOg6dU8EYSQU
         2FFhtV+GKrMPsAv3ogVHovNq67ADjv8xLlnsFdDsovv4kMldszIrl4FdnWhMMaYJgAZ3
         0dmQM3aIQk4O+KOMwANNM9+lSeSgwbHBUtczGRl1d5ku4Q8c+TG/4WrEPQ6/+jQ7p1fp
         0lxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752714628; x=1753319428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNFQfALT87iSSNOUBXVFi9G5jROQeOXrFq606md2L0U=;
        b=wgszAg83Ucyo5ItWfy+abXUsUdiWiAsg0PcTX0lJx6Ku84uCMoItYI+KEwP+FnCH0W
         b8u9XE/ujBgjbi67XgwI3U0jwIgvx53XAb9TrLm95wdFjhijFJ0f+awnRjnSphxj0z5n
         dp8UJ8GFyf4T9iL5XDiLNeJi/gaSrIfx3luWHBBQM97h2vW5KYQ1wQ4BtMe5U/Y89dXs
         fqvubeNyl7Hgfq7ZsaIimZ3IRIzW+rG1Hyv9kjgR56q+BQjfi8HICgJctnUJBrUCc3ac
         H4cyicNUPIZGf9A42Uysnzpai9wCWl7TqC7Uo3ovHQpYj/O1izVNi4deu+XW5en1qi6w
         yr2w==
X-Gm-Message-State: AOJu0YwwIg//dDtZ1f7bbYqhmVJpRm4iO9HdGx2ERjRAGslUtrZzYuU2
	J6yRa6GHVYYbi8RIo8/bcf/WVG4ebHencNSlkVPonbz8E1vwdKHnRFSlFdTrj6jqKsDLEyWeQ3v
	Otu2Mf8fwcFzaX5gR/VLirKlok2AOlZY/6O0SzQEyfdA5ocJSb7e8nfcGFMJEtRBXWmRAtmXUZM
	7m6Dl1kYdGhdWN8Wg8Aj6f+kfYwxM1gFuv+9ExbeGAmudmdc78rQ==
X-Google-Smtp-Source: AGHT+IGx3MVGA6pUSyhH2gNBdLEyBdBSFdOnzz7ucaK+tES6SS4pU+iQWEiBeVIiVovBOQr7Ppuekyg5+XSe
X-Received: from pjg13.prod.google.com ([2002:a17:90b:3f4d:b0:31c:2fe4:33b9])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39cf:b0:312:959:dc3e
 with SMTP id 98e67ed59e1d1-31c9f47c3d8mr7023956a91.10.1752714628497; Wed, 16
 Jul 2025 18:10:28 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:10:06 -0700
In-Reply-To: <20250717011011.3365074-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717011011.3365074-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717011011.3365074-4-ynaffit@google.com>
Subject: [PATCH v4 3/6] kunit: test: Export kunit_attach_mm()
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Tests can allocate from virtual memory using kunit_vm_mmap(), which
transparently creates and attaches an mm_struct to the test runner if
one is not already attached. This is suitable for most cases, except for
when the code under test must access a task's mm before performing an
mmap. Expose kunit_attach_mm() as part of the interface for those
cases. This does not change the existing behavior.

Cc: David Gow <davidgow@google.com>
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
v4:
* Collected tags
---
 include/kunit/test.h   | 12 ++++++++++++
 lib/kunit/user_alloc.c |  4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 39c768f87dc9..d958ee53050e 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -531,6 +531,18 @@ static inline char *kunit_kstrdup(struct kunit *test, const char *str, gfp_t gfp
  */
 const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp);
 
+/**
+ * kunit_attach_mm() - Create and attach a new mm if it doesn't already exist.
+ *
+ * Allocates a &struct mm_struct and attaches it to @current. In most cases, call
+ * kunit_vm_mmap() without calling kunit_attach_mm() directly. Only necessary when
+ * code under test accesses the mm before executing the mmap (e.g., to perform
+ * additional initialization beforehand).
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int kunit_attach_mm(void);
+
 /**
  * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
  * @test: The test context object.
diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
index 46951be018be..b8cac765e620 100644
--- a/lib/kunit/user_alloc.c
+++ b/lib/kunit/user_alloc.c
@@ -22,8 +22,7 @@ struct kunit_vm_mmap_params {
 	unsigned long offset;
 };
 
-/* Create and attach a new mm if it doesn't already exist. */
-static int kunit_attach_mm(void)
+int kunit_attach_mm(void)
 {
 	struct mm_struct *mm;
 
@@ -49,6 +48,7 @@ static int kunit_attach_mm(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kunit_attach_mm);
 
 static int kunit_vm_mmap_init(struct kunit_resource *res, void *context)
 {
-- 
2.50.0.727.gbf7dc18ff4-goog


