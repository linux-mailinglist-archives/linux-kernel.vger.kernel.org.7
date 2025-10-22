Return-Path: <linux-kernel+bounces-865938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0233CBFE5FB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A048F4E5DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B4330595A;
	Wed, 22 Oct 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfbhPeEy"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB545038
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170894; cv=none; b=XU9qKjL2U29IoYBCezzbKkCFLIa1W/BmU9RheLMx2jkxDrPRnoG9M9p0rCV9VFeqMOKc79vLu6zD/LJa+brepcOcVyyL6WxyY8VK3r/89RkMRgJf3TvQ4ocwX/YN1RR/gq7/nJxJl4GEDl8qdEZu1JQV5w+Fit8zhboZp9ibbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170894; c=relaxed/simple;
	bh=94Qlr/Rj9e3g/GYu+xAfDE8dPghucJMHFBk4t2pKjvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uh0ruue5xgc5U186eA5+Rhhpat5+mLpnJHEVG51VEQLdQPmlI7H3pkl5N/NIRadCvf3dpgyIrgl2UipgJMBY2aAZ5YgbxhiR2baCvp6N3DuzmQEpJ9d2U7UlabsGYjpOIDvJTgBF2TbNP+QoWPRWQHVvpTwmTQnHtIHftG7izsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfbhPeEy; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78487b0960bso986447b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761170891; x=1761775691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XYPBLl8lEjNb2771iKm9ddg/BP0hYG7IxkPUeJF/g00=;
        b=WfbhPeEyqEVXoOBN4c0CjaaCwtQ8nfMQuAnF7JTU3ApxHkaUYt8s061CgycZl0Ml/9
         tHkqyVvELd58pKSafy5cVdCto15NI0+adzgyfo0p8W9pkk8OvairLkat3YMa5MuUexYc
         uNY5alv6xsk+fbhXwWlVKh+5z5r3fdveGKeDhlh6vgaLgm7wJno7lH8q2S3PgI30ROoT
         TNX9lJaI13T6gXemoYWRzWkjg83QQ0l0J9lWWTYydVjizm1xhEAY0OxCYkore3BbjLfv
         lIfGECwkM+B33nQrDcpatLe/4L4NOoqgMEXmx/GcWpdLk3I2omp4J2vcGfob9iFCFNic
         ke2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761170891; x=1761775691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYPBLl8lEjNb2771iKm9ddg/BP0hYG7IxkPUeJF/g00=;
        b=lG8ucR7qiQRpRRYTWojrITd/kbeU6UhYB5haazYx5vIdn3fldTU0+mEJA1vN3jJBqW
         IWdZ8F7MvbY4KEUZmIlRwUpRXGvY8Jg/zB6ywxLneJeEnzfv8JqUAxu0Zm1gkHpyXJQH
         fTivV8rXU0lO2A5Lqak9VXyVSaw+kjOf+QAr3RW+Z6t+VbGddopuvYVewfOOGUAlvI8p
         Fj+lQXLGEECesxVRDPHqtvVm991hp69ENrqf3lSUaI19B4IocqTzp70q0gf28cmgb8BB
         Q1FX3XLfVw0dWSDCYW6DbBubT+HKiHVjEgdmzegKTSVLjb/P+ZNj6IzcVmbO+1TQwcHk
         WjeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyYcEIkJrBtaDUNTtfCAhE9nYbD4zHSM44W1Jvu6Krpi7amqKRdY/1GJXp4aAS4tvgtHfsZ0zhDUU54Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YylA5QRGBUSxbfNjgj3thZNXQES2gDpg2OCWd8Tgoy8Jt4y7Wet
	YGTI8WeQEhkjBpL6yyM7oNiODfTu3ljTzb260WVasFryPM/f7MEwc8wO
X-Gm-Gg: ASbGncsIIfEkwtexOoqJrNVSYb5K/71Ozd42Ft3Udvc9JkCMLAaL8E2Wywm+qij/VKX
	C8n/36DNDRal9dg5Dy+ZY/X0KQFXSD/rGOPbDpHsI40YrAddIkeqMKKmIJto126wGuCKI1xbiyJ
	69T+WCOFwgEaitBw+N58+lCH4eeCXVrtZKHtmwfXLPWZu5v6cG3KaASr/tcoSKJA0EbBugOaCUc
	epAz0F6n4dn2m+mtMqApd+7yox53yIvNc8tdRH4armDEMVzRsc79RiBjVVnZ2pCMH88ryayHoF8
	RlBYofL81tj3uKZw/dvw4iWZDhgxx+jro/gRV3OvmAefE6cCFAoLcTN7oALBQxwEX5QSDA41hZb
	0Xx7xJB7uTz0FcaWiK8/J4doSt4pjIovb7WH+oRyhpsP5CXOdiNVALix6S6JijblS+Jyi2sPYdF
	8XblgRgQ5wLf3Nm8SPKx4=
X-Google-Smtp-Source: AGHT+IFu4hN4ipSSzPrzhwFT7gQ83AT90It480qBPOB8KCTNDJfSxNZBI5oOkdrpgpWQnaZvr+WVow==
X-Received: by 2002:a05:690c:9c0e:b0:77e:dc10:1b29 with SMTP id 00721157ae682-785cda64315mr4655617b3.24.1761170890635;
        Wed, 22 Oct 2025 15:08:10 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd4584casm1358607b3.0.2025.10.22.15.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:08:09 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: dwmw@amazon.co.uk,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	hpa@zytor.com
Cc: x86@kernel.org,
	apopple@nvidia.com,
	thuth@redhat.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: [PATCH 0/3] x86: Fix kexec 5-level to 4-level paging transition
Date: Wed, 22 Oct 2025 23:06:24 +0100
Message-ID: <20251022220755.1026144-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses critical bugs in the kexec path when transitioning
from a kernel using 5-level page tables to one using 4-level page tables.

The root cause is improper handling of PGD entry value during the page level
transition. Specifically p4d value is masked with PAGE_MASK instead of
PTE_PFN_MASK, failing to account for high-order software bits like
_PAGE_BIT_NOPTISHADOW (bit 58).

When bit 58 (_PAGE_BIT_NOPTISHADOW) is set in the source kernel, the target
4-level kernel doesn't recognize it and fails to mask it properly, leading
to kexec failure.

This series fixes the issue in three parts:

Patch 1: Fixes the x86 boot compressed code path by replacing direct CR3
dereferencing with read_cr3_pa() and using PTE_PFN_MASK instead
of PAGE_MASK.

Patch 2: Applies the same fix to the EFI stub code path. (Done in a
separate patch as Fixes tag is different).

Patch 3: Moves _PAGE_BIT_NOPTISHADOW from bit 58 (_PAGE_BIT_SOFTW5) to
bit 9 (_PAGE_BIT_SOFTW1), which is already properly masked by
older kernels. This provides backward compatibility without
requiring patches 1 and 2 to be applied to all existing kernel versions,
which is not feasible for production systems or live patching.

Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>

The patches are based on aaa9c3550b60d6259d6ea8b1175ade8d1242444e (next-20251022)
 
Usama Arif (3):
  x86/boot: Fix page table access in 5-level to 4-level paging
    transition
  efi/libstub: Fix page table access in 5-level to 4-level paging
    transition
  x86/mm: Move _PAGE_BIT_NOPTISHADOW from bit 58 to bit 9

 arch/x86/boot/compressed/pgtable_64.c   | 8 +++++---
 arch/x86/include/asm/pgtable_types.h    | 4 ++--
 drivers/firmware/efi/libstub/x86-5lvl.c | 5 ++++-
 3 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.47.3


