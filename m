Return-Path: <linux-kernel+bounces-734458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0772AB08217
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79547189AE85
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8CD1A8F84;
	Thu, 17 Jul 2025 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecDF4xZt"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5B31A239D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714618; cv=none; b=m/XdoHs9obgTCjSP3Xhv54+PHppBzos3Iup0U50rtYcjbL9ESnDCBMmXZoxZW0K/ynoVZB1VkMf9fHdTDMWMrT1Qw4BOs9WlOyUhga6D0G1/L5kfUIE1sOdnMjsvptRDHu50YlwxCo/bP0lmUKpeoBDYwC3OZyezo22+MiFqbHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714618; c=relaxed/simple;
	bh=ozo5eYb3YU7H8t4et3HK2fH+WMpaGapOeIfG0NbD4mg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rwNNV9W8RMijlVwIH0LG6hJ6Su45CsWARNj5qyBHNVKNGevbpkIMM6vOe+k8jV6sdOMX8io1Gozw0rEHJdK1mB1ZHvsf+vx9wB2tDKw2vj4pgNhbb7kr0pgYqC/Cco0889qLNx3/a0FUE2l3fwlN4/Yz9z6O085QlxH+C4Pjj6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecDF4xZt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74ea5d9982cso321988b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752714616; x=1753319416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gUTYXc26UxSuX2Bn6XGfKAUwzEOqqIS18eTa4THYyYg=;
        b=ecDF4xZtDqdG90mojbtbab+5UtKve9GUiJvRhe8WHA1IB3iH7qvDLzXNStYAq4KKOX
         IBMahwmM8VBwG4ZJfn27HxFyWUBvHXfPVkz/uP3KStCvhRXN1hd//H0QPsq6eMrEy5xW
         yHojqdtV/W9iF/5dsXN193tMao64UXj7VT2VUe/4CF4xtIEb8q9qjQ8Z1X2QaP7LZG05
         H7m124tWLfngCyEWKQXtDXHZ7Qgu50bfrLh7WaToDoNTOPBwsbJQiLeFR/VaxFQKlj3m
         kohVXyRpNp+jLByr1WQCRuD1/YdEfzMX1neHrEayitO1SR31GGnjnpFcmBOG3YbPWlcR
         FyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752714616; x=1753319416;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUTYXc26UxSuX2Bn6XGfKAUwzEOqqIS18eTa4THYyYg=;
        b=KsfqfgER66ZXHI+NUx5TWuBM71GQyt2656v2KJi3Qy9Kq/wiNIU4B4rdIagprXRVT3
         BwlARuu0IaF4JpkK1WF2DQhdoCPHAlsapMRZnHB/g6poXGFQ/jz1SeLs9DmE0QCknnBM
         rtlMhG8S31Br7YKLIeOgVGPxCiDF3LlkIqcw4YouXxNaSqoU4QnB6Y68ijEGVerzMKH0
         2oT12RUEm5C3w1XoRNWApOsmBXXYlDzkMYtez1Rrs2S4h8LuUOuHnXcuU2v8cJZpSZvy
         TkFNlx6vIOQ5RaN2Y4sM92xh6hMZQJETDWKbFraZFK7UUHLrmXQ5NQhULNDKPJzLsAAr
         2ceA==
X-Gm-Message-State: AOJu0Yy3eJW/HFuyhbQaHGvL4R1k9sjwKjdWve7YtUTtQ7lmAFGxvQOJ
	Gn/nXRkP0HLz8F9uKTeEw64WY3sIajK6ebKa2nGxVwtAMFZKoOrfVUvXtE8OBOPH22nnNmLa6oi
	i3F5EC9z5GV8zwP4zokLp2ZcBsbshtwW0jwbKFQFVlxWS2apnJAk1gV2K31tsxSMkWHePz/gScO
	3StYGUfjzXVEYNMHe0D5pJPLR54+1FvmVi0yEQ26UBU42oY7qNmg==
X-Google-Smtp-Source: AGHT+IGO7wjMp0KfaKbLnIeQlDuZ8P0WlskU3pVAlzlM1+n4aG1Rf4SRiFBiSCRMYb8Wu1BLYQy3iuX62Gwc
X-Received: from pfoo3.prod.google.com ([2002:a05:6a00:1a03:b0:748:8e9:968e])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a14:b0:749:421:efcc
 with SMTP id d2e1a72fcca58-756e7faa901mr6472941b3a.5.1752714615759; Wed, 16
 Jul 2025 18:10:15 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:10:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717011011.3365074-1-ynaffit@google.com>
Subject: [PATCH v4 0/6] binder: Set up KUnit tests for alloc
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

binder_alloc_selftest provides a robust set of checks for the binder
allocator, but it rarely runs because it must hook into a running binder
process and block all other binder threads until it completes. The test
itself is a good candidate for conversion to KUnit, and it can be
further isolated from user processes by using a test-specific lru
freelist instead of the global one. This series converts the selftest
to KUnit to make it less burdensome to run and to set up a foundation
for unit testing future binder_alloc changes.

Thanks,
Tiffany

Tiffany Yang (6):
  binder: Fix selftest page indexing
  binder: Store lru freelist in binder_alloc
  kunit: test: Export kunit_attach_mm()
  binder: Scaffolding for binder_alloc KUnit tests
  binder: Convert binder_alloc selftests to KUnit
  binder: encapsulate individual alloc test cases

 drivers/android/Kconfig                    |  15 +-
 drivers/android/Makefile                   |   2 +-
 drivers/android/binder.c                   |  10 +-
 drivers/android/binder_alloc.c             |  39 +-
 drivers/android/binder_alloc.h             |  14 +-
 drivers/android/binder_alloc_selftest.c    | 306 -----------
 drivers/android/binder_internal.h          |   4 +
 drivers/android/tests/.kunitconfig         |   7 +
 drivers/android/tests/Makefile             |   6 +
 drivers/android/tests/binder_alloc_kunit.c | 572 +++++++++++++++++++++
 include/kunit/test.h                       |  12 +
 lib/kunit/user_alloc.c                     |   4 +-
 12 files changed, 651 insertions(+), 340 deletions(-)
 delete mode 100644 drivers/android/binder_alloc_selftest.c
 create mode 100644 drivers/android/tests/.kunitconfig
 create mode 100644 drivers/android/tests/Makefile
 create mode 100644 drivers/android/tests/binder_alloc_kunit.c

-- 
2.50.0.727.gbf7dc18ff4-goog


