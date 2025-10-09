Return-Path: <linux-kernel+bounces-847111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 103DFBC9E10
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE30F353E67
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD912E091C;
	Thu,  9 Oct 2025 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNkF6Q1c"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A7F21C17D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025258; cv=none; b=aiLWlFo1xTHbnw3L0WYdfZQuwac2tKgRtyrNWAeX1VUMXjfKdJab7YLEHpiwq7jLDpFqXAKqu4Oxv0bGcuhhNwxbp1/OWnkAVxvSCVdLmu12Io9Owr0WymUHGyLu5JIEmkONDA66gJ2mcVlXPWbDsoWVs5X7JP/6M4nrsxC5I28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025258; c=relaxed/simple;
	bh=QVXQNO5yQm7MLoOJa2+bYyPZSTNN4pZKDeTjR8UqV7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shvCcT2wkoxes7r7QIlvCGVMuF1fBb4Fs/9FMO4VVS0cTt9hh/WFewC0oOSssg8i2mqPToZUUjLHEJGi8i9zfg5Ov2IpdIAiqF1Tp3+xRYPYUK/GQUCGsJO91EaUKklbiFEMnODK0wazUtRMVHdn0FogzCQ1wyd5NuZc4wn0794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNkF6Q1c; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-373a1ab2081so9828821fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760025255; x=1760630055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Px/XhEZW45988TSsx9E9crCKXRf5VJBRglVwYyG7AFY=;
        b=hNkF6Q1cFnDAfDE6CRWXLGMOCuM9xiip/JNHyQ5h6zaUU1pGn9L8fleK0l8SNsA4cH
         LX0iCU1WA1zRlYh9GXyml6tHZvZoZyDNpGR/Ke8rGdTTgNRw9n9rlYJXfTMseJqjTlDw
         vUJbBPQHPso7aDtWvQXdSSj1VZV9/WQEHCNJfmsxB3bRO82pMIP2oFj7gEAW841LPSm2
         NYPArZeoIAOpfkcUmnb4+KfP+mJ643Sw6CRe0tgtVROs2JaR2f/0NI6Nd+Tm6K3cX6bP
         z3xsxSFW59cgKuzJazdBRzrFPPOfuC8m4y3R830ywgFFqDGUhMo0P78BmWK6me6L0zoM
         Tzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025255; x=1760630055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px/XhEZW45988TSsx9E9crCKXRf5VJBRglVwYyG7AFY=;
        b=RLfAmd+mPI7nuydQBBLYWVLK1NSNOzqAAM1WGDtKbOJaEJvvh/8jl93Xd3OP51/RVj
         tu/vxftdvA3fxPnX1uJEOoZ43sDB74bqnoVy68XnVEFlRW75vuS1zNp6mINjc+9o/W8U
         kRxSLLa5rtrksKN1qArrwFUYdFpQdJeXa/sNRYFb7UbL0NjcMzEPxLEF1tlzRVEhJGSe
         rJhm7uCoGrUir2blvP0+mz+OxnUyEtuyF9Aqyff1nTGQ9U5Flx021bqHi3bZW4uz+F18
         617NuzGr+0TVtdzMh51iicphYAV3RAWZpiEEAKNU4q1bpKryhUeJWQq/v+QkNgMnGR7F
         RHsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwkOIJTfOkDKwjQXO7BYf6z8SnBeId3ApGgthK14xEI8oBUaQBEAUxNjRShmpRT2P9tiWQ4cC4pxWEayE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1JXx+JlpyO/c44NTp0Yqr5xEkX+sd+vvFjBOfq7SiyX9B0v7
	pRNKw04F3IfFQRps0wMnAGtUhsGiK/NCnQcFLmnelpAwvwiCRQwosXs1
X-Gm-Gg: ASbGncuPrffU1d1Rn86toYzk6pPndz/Fe2SOn5XMXgqmuhUoATwIEagu12Kn2UYfln4
	vfY24d6O88hiTnsvFmjQV8QQ6KnAzzaouDuhTkpswEzFxL2VTyGvLAkadnZXxx+THzDfO/BIr65
	IgxMZWKRzKCbGJgaI6e50XEz+EYa5sjYgBxl5KEKQiWB/aHmPDJIsjdffrSVZyxiGxGxhPDgz79
	aSSKkKhXPIdRwAMmJxNprrjE+ISKnLU+MrHvQCW5B3G3cQhIsIHCvoURfENZaHxm9yANoOxdhm0
	1KEHdUt/GVBLDEMwDI5MxnPOl3RvTMWbQKfrrlMmZsFS/5UTx9cKuiyvhmKFUxDbZXEzXeBLPIs
	W9/NxP16EdERsgFC4Sj6eaC6YwSrIlFcN3cwaKFtv1INYEhxavTuqJKV1T3jvkIbRp19iMzKxkh
	WWbgTioedy
X-Google-Smtp-Source: AGHT+IHO/2jNu7B57uhcC5zlDJ+BqbuVqtg+u9NOxlnpU81ZaP1WebzhTXnQH2tcRcUqD/JALd/SOw==
X-Received: by 2002:a2e:9a12:0:b0:336:7c7c:5ba5 with SMTP id 38308e7fff4ca-37609e10855mr24041711fa.23.1760025254597;
        Thu, 09 Oct 2025 08:54:14 -0700 (PDT)
Received: from fedora (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-375f3bcd2a8sm29499831fa.55.2025.10.09.08.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:54:13 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	bhe@redhat.com
Cc: christophe.leroy@csgroup.eu,
	ritesh.list@gmail.com,
	snovitoll@gmail.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] kasan: cleanups for kasan_enabled() checks
Date: Thu,  9 Oct 2025 20:54:01 +0500
Message-ID: <20251009155403.1379150-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is the continuation of [1] the previous discussion
related to the KASAN internal refactoring.

Here we remove kasan_enabled() checks which are duplicated by higher callers.
These checks deduplication are also related to the separate patch series [2].

[1] https://lore.kernel.org/all/CA+fCnZce3AR+pUesbDkKMtMJ+iR8eDrcjFTbVpAcwjBoZ=gJnQ@mail.gmail.com/
[2] https://lore.kernel.org/all/aNTfPjS2buXMI46D@MiWiFi-R3L-srv/

* Altered functions:

check_page_allocation
	Delete the check because callers have it already in __wrappers in
	include/linux/kasan.h:
		__kasan_kfree_large
		__kasan_mempool_poison_pages
		__kasan_mempool_poison_object

kasan_populate_vmalloc, kasan_release_vmalloc
	Add __wrappers in include/linux/kasan.h.
	They are called externally in mm/vmalloc.c.

__kasan_unpoison_vmalloc, __kasan_poison_vmalloc
	Delete checks because there're already kasan_enabled() checks
	in respective __wrappers in include/linux/kasan.h.

release_free_meta -- Delete the check because the higher caller path
	has it already. See the stack trace:

	__kasan_slab_free -- has the check already
	__kasan_mempool_poison_object -- has the check already
		poison_slab_object
			kasan_save_free_info
				release_free_meta
					kasan_enabled() -- Delete here

* Other mm/kasan/* functions with kasan_enabled()
	where callers are defined in internal mm/kasan/kasan.h:

mm/kasan/generic.c:
	kasan_check_range
		check_region_inline
	kasan_byte_accessible

mm/kasan/shadow.c:
	kasan_poison
	kasan_poison_last_granule

mm/kasan/kasan_test_c.c:
	kasan_suite_init

== Tests:

* ARCH=um defconfig (-e KASAN, selects ARCH_DEFER_KASAN)
	Compiled and run ./linux with no issue

* ARCH=powerpc ppc64le_defconfig (-e KASAN, selects ARCH_DEFER_KASAN)
	Compiled and run qemu-system-ppc64 with no issue

* ARCH=arm64 defconfig (-e KASAN_GENERIC) and KUnit tests:

[    4.065375] # kasan: pass:61 fail:1 skip:14 total:76
[    4.065529] # Totals: pass:61 fail:1 skip:14 total:76
[    4.065682] not ok 1 kasan

1 test is failing:

[    3.772739]     # kasan_strings: EXPECTATION FAILED at mm/kasan/kasan_test_c.c:1700
[    3.772739]     KASAN failure expected in "strscpy(ptr, src + KASAN_GRANULE_SIZE, KASAN_GRANULE_SIZE)", but none occurred

which is also reproducable in the main tree.

Sabyrzhan Tasbolatov (2):
  kasan: remove __kasan_save_free_info wrapper
  kasan: cleanup of kasan_enabled() checks

 include/linux/kasan.h | 20 ++++++++++++++++++--
 mm/kasan/common.c     |  3 ---
 mm/kasan/generic.c    |  5 +----
 mm/kasan/kasan.h      |  7 +------
 mm/kasan/shadow.c     | 20 ++++----------------
 mm/kasan/tags.c       |  2 +-
 6 files changed, 25 insertions(+), 32 deletions(-)

-- 
2.34.1


