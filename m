Return-Path: <linux-kernel+bounces-827953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713FDB93845
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579FB7AD069
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DF630DED7;
	Mon, 22 Sep 2025 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYK3dyaX"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1D31A548
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581354; cv=none; b=jx4twNgrgYzEO/txTjtItT21oJYrfwJFAAUyAeKaTINbgVBntQ+wLPRLm/9zOvi+9+oqvtq2wn4og96RMEhEn0hHR9O+rI437E56k6UXaU02IGJD1fspIwAdustBjT1D4h28gfwR4pfcVJQSiG+V/VXktfb8zmr2CZwiCSd1n+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581354; c=relaxed/simple;
	bh=5QNyl6HSB4ZmEtWfJZ+xy37nKYlUmhxWx4mCsLt2NOo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L2jQ/f5gAQ3y7B05vJf5tcu0cyksvmfFDbYDLiL14dRUuEGNob3fchUi0kXQnGVD++PY+tQg2lBn6vOmLg+yUkkTzPsk5GBI1JARgzim02Bnfmy/0OuZQ54k7lWHDXunEKJXvXvvYIlziG0ZV59QF9jERmcOYy8ZdvPu56FxL3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYK3dyaX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso6701049a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758581352; x=1759186152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tg+cfyJ8iHTctEj7ru5BA/5vFiRl/ZrC7hQcrJdFfGA=;
        b=nYK3dyaXhNNHyKYGvn2tubl8KaMcRKcYNd3Ye5NR5STCI6/O9wDM+/UaNPq0ja2qp5
         0AfiKYjExFdLDNhno34lwnlYY0qaVGeUhJWfT1406damWSlLu9o9M9RTp6NaPrMM7lsU
         va7nEa8co2dLX0GvVZBM7YbhEY2MwvaRPr9DbkOoa9UYkzh8hQ0XQg9VCzxX5M4zCm9g
         ++Zeg9ijHqubYfyM9lLm7saKDhrrhmrpvNqMLu06m4HG9OzCLk8L1820zN1+FAfvHZiM
         d2uleQgcyIoZP/B6fY2+FBsbB9eMLpzKbogCfYzOJq/VUwOAYKvFrVjtNr/GpZXcc3D8
         Pv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581352; x=1759186152;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tg+cfyJ8iHTctEj7ru5BA/5vFiRl/ZrC7hQcrJdFfGA=;
        b=FP+h3r8+fHMHmD8FFyQOWkPpOZ6fkGbh5SMgOZG/iXPfGH2+mJV6da2VGmei+o3uOa
         cOc7Zdyc/itqmQ77UYeEI57rMtqrLDngqPjV5i1DdaG4GESicHB/vRgsHBUuETEXTS4n
         QeqicuZrD8/1s994vBGb/zDl1UyWEwZRP9U2iyde1JTom2PoU3yRqe3SFQ/0CwOzH840
         2Tmj1txyPp19FY3PYPk8EvF6vhtipCHbDxtEhtdX6IG8tgIuGhzxtMnzHd1PRyujAlgR
         5Hhmy3Kw3pY7gIwgWzOvPHX4FCStnyptvZ539yL52N2B9454XRFMAE1p7oLRhqAv+0mC
         TtyA==
X-Forwarded-Encrypted: i=1; AJvYcCUb0K1xyldmH5k207AfnX7nwYfh3QevRWEuFKOTt3auoortAw9rtjQ4tKhzBuCEBBUY2UnxuESZOi0S9ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9/W+ibK+hbgEeDyvjKyfcOL4XwrXs8H3pbelWU/3Xgc0hB6YM
	Y0yBhZ5hAqn+IiwOQsq0vBc+ENc8+gdLkNln/sDYI3kLENKj820xITn2LgbeNKlycA4YzZIz4Ct
	ZYQD9OF/4B9/QOg==
X-Google-Smtp-Source: AGHT+IGjxw6fs9lVd3Db6O2V15gm5vIsTH02Zn0TJdHjDmTLj28al1yn0EUqz0lmxJAOfsqMXRMLoQm1Kcspew==
X-Received: from pjbsv5.prod.google.com ([2002:a17:90b:5385:b0:32d:a0b1:2b14])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3ec6:b0:32e:1b03:6e12 with SMTP id 98e67ed59e1d1-332a9546a9dmr614277a91.13.1758581352286;
 Mon, 22 Sep 2025 15:49:12 -0700 (PDT)
Date: Mon, 22 Sep 2025 22:48:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250922224857.2528737-1-dmatlack@google.com>
Subject: [PATCH] vfio: selftests: Store libvfio build outputs in $(OUTPUT)/libvfio
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, Vinicius Costa Gomes <vinicius.gomes@intel.com>
Content-Type: text/plain; charset="UTF-8"

Store the tools/testing/selftests/vfio/lib outputs (e.g. object files)
in $(OUTPUT)/libvfio rather than in $(OUTPUT)/lib. This is in
preparation for building the VFIO selftests library into the KVM
selftests (see Link below).

Specifically this will avoid name conflicts between
tools/testing/selftests/{vfio,kvm/lib and also avoid leaving behind
empty directories under tools/testing/selftests/kvm after a make clean.

Link: https://lore.kernel.org/kvm/20250912222525.2515416-2-dmatlack@google.com/
Signed-off-by: David Matlack <dmatlack@google.com>
---

Note: This patch applies on top of vfio/next.

https://github.com/awilliam/linux-vfio/tree/next

 tools/testing/selftests/vfio/lib/libvfio.mk | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index 5d11c3a89a28..3c0cdac30cb6 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -1,24 +1,26 @@
 include $(top_srcdir)/scripts/subarch.include
 ARCH ?= $(SUBARCH)
 
-VFIO_DIR := $(selfdir)/vfio
+LIBVFIO_SRCDIR := $(selfdir)/vfio/lib
 
-LIBVFIO_C := lib/vfio_pci_device.c
-LIBVFIO_C += lib/vfio_pci_driver.c
+LIBVFIO_C := vfio_pci_device.c
+LIBVFIO_C += vfio_pci_driver.c
 
 ifeq ($(ARCH:x86_64=x86),x86)
-LIBVFIO_C += lib/drivers/ioat/ioat.c
-LIBVFIO_C += lib/drivers/dsa/dsa.c
+LIBVFIO_C += drivers/ioat/ioat.c
+LIBVFIO_C += drivers/dsa/dsa.c
 endif
 
-LIBVFIO_O := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBVFIO_C))
+LIBVFIO_OUTPUT := $(OUTPUT)/libvfio
+
+LIBVFIO_O := $(patsubst %.c, $(LIBVFIO_OUTPUT)/%.o, $(LIBVFIO_C))
 
 LIBVFIO_O_DIRS := $(shell dirname $(LIBVFIO_O) | uniq)
 $(shell mkdir -p $(LIBVFIO_O_DIRS))
 
-CFLAGS += -I$(VFIO_DIR)/lib/include
+CFLAGS += -I$(LIBVFIO_SRCDIR)/include
 
-$(LIBVFIO_O): $(OUTPUT)/%.o : $(VFIO_DIR)/%.c
+$(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
-EXTRA_CLEAN += $(LIBVFIO_O)
+EXTRA_CLEAN += $(LIBVFIO_OUTPUT)

base-commit: acb59a4bb8ed34e738a4c3463127bf3f6b5e11a9
-- 
2.51.0.534.gc79095c0ca-goog


