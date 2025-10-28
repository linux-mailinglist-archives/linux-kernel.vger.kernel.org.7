Return-Path: <linux-kernel+bounces-873616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2BC1442B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAD9C568571
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C69302168;
	Tue, 28 Oct 2025 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfPJFzVZ"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9435C26C3A7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649055; cv=none; b=MRojdM1XIrcjAxb5Zgja8HhqJSCqJMV+SGby4+eWagK0+JsSKI2ggJ24Z7HB5c4WbwCdVuvBGU3YR4JbQwMRDfD/TJyXejjCxw5ncn96a8x6JydhGq6/EgPweSO+px9Z/mSKexD1lVXBOov86wS+SXtProg4uGxvu2XMkK9LBOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649055; c=relaxed/simple;
	bh=RdFi9B1xaFI5S7ACFIioFSiqRWi0o5djZe42hthAnQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BudyTUrQtGYrXUjH5LF0xIAZUN1jPV2vBHzeSHwaMO7NPpE1YyvqrmFmV3jkMrklJpEW51HYus2Om//j3nrSGAwc3AIyJYrpAMq4d1PTCzsOLJOGDQ2zlKM+Gi1QqQJGgP6vupc63w/jjyNDUBUXuqMSSzXG4JlZsaytqpSl4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfPJFzVZ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7815092cd22so75245747b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761649052; x=1762253852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sCicNmBtkxf7RoTr6oW3I01/BO6dQKtL8u3BkddbZOQ=;
        b=gfPJFzVZXCFs0hA3CHarGNhm2BbnVViLYjS8h8U3Qo3rhfEyf3Xia4woVDlOTaFI2T
         OxSsivKOuOVl3X1wCXRZ0JyXIIy/KLgcydn/VwMJJ9llfxGmc9za3aZQkkTp+hGdLsE9
         Fwnlq1yCQVPa7xp3hTJ1Lripnmw1zH/PddN2vdouaj0+4wMDhKUh49H5k28j5k/jvBED
         92WlR2g84f82rUHJ537XP8yV5xyq2tJDa/mwSN+YkYD/I/Wa39xwkcJ8CP/1hCabxIES
         AZGquoqse5GDW5Y9KKokyMXRYAAyuoFP6DMnPJL9+wPrCYDp4++zEwV9Rd4zOehkNwvz
         YSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761649052; x=1762253852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCicNmBtkxf7RoTr6oW3I01/BO6dQKtL8u3BkddbZOQ=;
        b=LQYy0+Qr7zB/Op5O4XtaIBQyZusH0U/DzhZ3vHEYD4U1IF6VAa+e8TQg5/qAuVsjZn
         Rii0n8LJe+LtbG8wDX7hDN9n/drrohkbKF+EEy9sZiu2camOd9i2HV5Fmd7uEBflPZm3
         6dGhYOq3edd8kxPHtWzKfzWLFQgCKHGN9VAIuWjsPhb1zihy3R6bDFQEpDm/ppKNhE+H
         RngWpuTAGsijj7xcFtCqzogZJkdRVbiVZP9DXsfI/QDT7xrAus/iT/5MZzptoeCHY98L
         gT2g8EZLFK7MI5wbW7wE3UbfFSdmoC0t1ZHjuD2dYwN6rvu2bryEc1jDMWsoSG1uGacX
         qcNw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Dc1I6Tn7En3Hdwudo5khOelPWepomZ5P409/tbE8IOrqM4CBL9i7ekYAmvrEkmU5Ln5GJk5I9HhpcOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4c3WtgYTjn7jsLmw70cv8e7TaUutTsiapSO02+4aoh2m9aDRu
	dtR0F3U+AJzvxhrx0i/PoCt/zF7RIslIO2GBsps0ND1n+UUjaBZNO7TV
X-Gm-Gg: ASbGncs8QZrp/VaIKYk1oeap/b8p4/XERBWggZ0xSFAhp2bwNEqK7ZBiftvWLqcKBm/
	kqGXzfPJzdO+eeu+e97yjJHEuN8rh+BDg6PFExTbBHUgJL5Erozdzy2AufmWlczlR5FJQCB2nkc
	7xRw+ce6AIF45OBIJu0MkIsIsn5mVUTxtHpyk+Y3lHATF7NWxAwThMf5HLC+fEj9q+iG+fWJCA1
	gcfDxuS/XFs/oU6/fHuPvCReROgQD6Rm9wD4/lbGe6Y6vup/8lrX3cgn4AZq75qvzA7f7/2ajU4
	tgrvoIbBYVKFZgXPH+6o263PgipSkSeek6glLtQdy/7WymM1pEt6dKdQBlxs5eElqboNEubujFL
	AwrBIJmhVhQux5LgSyFUlEPMDOnxe5y6G4spXxjtUWHnBa9dzbQCxKDA6cb9xM+Y0tgOVanm/ZV
	BtRpS/P9WGQg==
X-Google-Smtp-Source: AGHT+IEi2f0dgYE9Vk92a9SmD0HH1iyYIXi0n9OL2O+HDNZl+ryMSfq/CMdNRR9eXmOYCxlxyZ85ag==
X-Received: by 2002:a05:690c:6d0d:b0:783:796c:c1a9 with SMTP id 00721157ae682-78617f61d33mr29339177b3.37.1761649052434;
        Tue, 28 Oct 2025 03:57:32 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed196a0dsm26357697b3.27.2025.10.28.03.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 03:57:31 -0700 (PDT)
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
Subject: [PATCH v2 0/2] x86: Fix kexec 5-level to 4-level paging transition
Date: Tue, 28 Oct 2025 10:55:55 +0000
Message-ID: <20251028105637.769470-1-usamaarif642@gmail.com>
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
transition. Specifically PGD entry value is masked with PAGE_MASK instead of
PTE_PFN_MASK, failing to account for high-order software bits like
_PAGE_BIT_NOPTISHADOW (bit 58).

When bit 58 (_PAGE_BIT_NOPTISHADOW) is set in the source kernel, the target
4-level kernel doesn't recognize it and fails to mask it properly, leading
to kexec failure.

Patch 1: Fixes the x86 boot compressed code path by replacing direct CR3
dereferencing with read_cr3_pa() and using PTE_PFN_MASK instead
of PAGE_MASK.

Patch 2: Applies the same fix to the EFI stub code path. (Done in a
separate patch as Fixes tag is different).


Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>

The patches are based on aaa9c3550b60d6259d6ea8b1175ade8d1242444e (next-20251022)

v1 -> v2:
- Remove patch 3 from v1 to fix kexec for source kernel in 5-level to 4-level
  transition where the 4 level kernel doesnt have patch 1 and 2 (Dave Hansen)
- Add include for asm/pgtable.h to fix build for x86_64-allnoconfig (kernel test bot)
- Use native_read_cr3_pa and for both paths (Ard Biesheuvel)
 
Usama Arif (2):
  x86/boot: Fix page table access in 5-level to 4-level paging
    transition
  efi/libstub: Fix page table access in 5-level to 4-level paging
    transition

 arch/x86/boot/compressed/pgtable_64.c   | 11 +++++++----
 drivers/firmware/efi/libstub/x86-5lvl.c |  4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.47.3


