Return-Path: <linux-kernel+bounces-870579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7F9C0B2B4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2DE18A2BAC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F872EBDF4;
	Sun, 26 Oct 2025 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surgut.co.uk header.i=@surgut.co.uk header.b="bOW5E/Ds"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69D2FDC3F
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510066; cv=none; b=EagI548QsomtCRV0Er0utTclg6vBBi4xO9t6ZEDg0dABfMNMsnDXz0gQPdtxSO8fa2xpoketZOh6LmjJ+hDlO1pfRUWd1Azsi2BLE49d9ByhbsdahitB3914o9Qj2b4LIgm4iKbc5dyxuy1qrnMNlGGQsGf6S32bexSCNDL2lUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510066; c=relaxed/simple;
	bh=6cmkGw7ridHGA5Ra0Gam2hWHwDUIPtc7nwY9+savRes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVQ0oLdzzZKE+OCbwDUblBvatLjd899wNdJFZRWXybu1cLaTSDdUj7SvwkJDcqGjw05IoisWmDwFTl71/PT+JwU0Apcy2LO9XCsvxEcbhcw6VnVCeYDsMBj1KW6Kb8+hxu43LCiKhFZ7+/512qNCAhckVjX0FzXwrii5vBASvAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surgut.co.uk; spf=pass smtp.mailfrom=surgut.co.uk; dkim=pass (1024-bit key) header.d=surgut.co.uk header.i=@surgut.co.uk header.b=bOW5E/Ds; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surgut.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surgut.co.uk
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47118259fd8so27819565e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=surgut.co.uk; s=google; t=1761510062; x=1762114862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hc8hIMVlXblSUQKCczS0qplI2IZPcuMR2yk3IdKjDio=;
        b=bOW5E/Dsq5ajNQvpPTOuJBQQloZ8fFeBiyHmd+G+JEJXqSV8Km5Rbacw8AhA9h/uKH
         2YmvpI8uIUvZ++TQsHiOf5dY5CugEEHiRS3cSsBgjje0PcylXVV9FAH6xWsLYqUUDJHq
         BZ02yESLchOi7BAsegWQ9DsS3lnrZwjeOaou0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510062; x=1762114862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hc8hIMVlXblSUQKCczS0qplI2IZPcuMR2yk3IdKjDio=;
        b=wlnglsO9iqwsH6PgLREdcg4KtAmYY8Hl2VbGTsUh2GI1OcIG2KekRCDsGVjmRct/3g
         4boiQIyh+FF2Dql/h9f4PYCkJA3r7x69BKC4k7Zm7aXl8mFIqH3dDVHXrwqV5CG9aeVw
         TMXT6LkRWpCbnaZH2B6KfFqgj/8kpRssgvATF9MY/ubynny1JALLn6VyrkDWKygl7vYV
         E/ULxz7BOV7s0qT/iBl9aKjweMth6gmgrmYWfmyyQCfh68uZJkiJytRGCOat0lkshUQG
         eiKzx/Lq5/2zv/FmytbKJru8It9fwkg6DPxK8b1puv2NNcCbry9Ujefjbw6pLXloQbxt
         8Jeg==
X-Gm-Message-State: AOJu0YxfcoP+JlMh251cYSsuYph41jAfJ0at7dSbe3t8/JHz3gvkerj/
	iKeBmM5ebQywQhb3glIAZrX1b10EbfaVpbg2vDzF0kw7Qv/qkHtVSi2Nje9yIgH4ZaWAvgmzER7
	2iS0u2Ns=
X-Gm-Gg: ASbGncukSr0cvQqNGUWP5u3AXh1hWtxsntR9LTtbDRGYELayEfef+mSlKUoDWYCjlqt
	53tJ5kJgkhaQfOSGw6XF4oQ3OhvkbQy2F/j7mT++xOxnqlg2EZaWsQOonB7yM6GR2KK1n0FXCUs
	DvkQ0YTc7UcYevr6gPp59ayUzIgmAjv967YSZbQc0MTUpRPQGVkyjDtb5tCPfSqQCu44sefw0t1
	Cb8jo9TX1uEqPHbHyz5Ii/bl2E/BFWygv2oaHD8AuPStuvcM88odRCbztsO3tCIsrz801Shh37x
	pqUA6wYnGL7Xe1jEbCMxgOgllb0DhGbn542xvKJtpF8MKyGuqGf+jKo/b+OMBJ7xVrN4sqv37Pp
	Tb33FAU5yN0BroouVq4QqqEIhdr80c5B4Yyq05DlAso4bfyNPO+RwyBDMYmZuvWqV1OpoyM/6bU
	bIuAuYejBGIF7jOg==
X-Google-Smtp-Source: AGHT+IG8s5HQE3d4ses2cZsHHAgP37V3gTadPVocMJn0oepp1TxOzMppA7/tFk8b1MYo9yP7ey0bWQ==
X-Received: by 2002:a05:600c:3513:b0:471:1415:b545 with SMTP id 5b1f17b1804b1-4711786d625mr282847025e9.7.1761510061672;
        Sun, 26 Oct 2025 13:21:01 -0700 (PDT)
Received: from chainguard ([2a01:4b00:b911:bf00:459d:eae2:cf7e:1a5f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd035e05sm97042815e9.7.2025.10.26.13.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:21:01 -0700 (PDT)
From: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: masahiroy@kernel.org,
	arnd@arndb.de
Subject: [PATCH] kbuild: align modinfo section for Secureboot Authenticode EDK2 compat
Date: Sun, 26 Oct 2025 20:21:00 +0000
Message-ID: <20251026202100.679989-1-dimitri.ledkov@surgut.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously linker scripts would always generate vmlinuz that has sections
aligned. And thus padded (correct Authenticode calculation) and unpadded
calculation would be same. As in https://github.com/rhboot/pesign userspace
tool would produce the same authenticode digest for both of the following
commands:

    pesign --padding --hash --in ./arch/x86_64/boot/bzImage
    pesign --nopadding --hash --in ./arch/x86_64/boot/bzImage

The commit 3e86e4d74c04 ("kbuild: keep .modinfo section in
vmlinux.unstripped") added .modinfo section of variable length. Depending
on kernel configuration it may or may not be aligned.

All userspace signing tooling correctly pads such section to calculation
spec compliant authenticode digest.

However, if bzImage is not further processed and is attempted to be loaded
directly by EDK2 firmware, it calculates unpadded Authenticode digest and
fails to correct accept/reject such kernel builds even when propoer
Authenticode values are enrolled in db/dbx. One can say EDK2 requires
aligned/padded kernels in Secureboot.

Thus add ALIGN(8) to the .modinfo section, to esure kernels irrespective of
modinfo contents can be loaded by all existing EDK2 firmware builds.

Fixes: 3e86e4d74c04 ("kbuild: keep .modinfo section in vmlinux.unstripped")
Cc: stable@vger.kernel.org
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8a9a2e732a65b..e04d56a5332e6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -832,7 +832,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 
 /* Required sections not related to debugging. */
 #define ELF_DETAILS							\
-		.modinfo : { *(.modinfo) }				\
+		.modinfo : { *(.modinfo) . = ALIGN(8); }		\
 		.comment 0 : { *(.comment) }				\
 		.symtab 0 : { *(.symtab) }				\
 		.strtab 0 : { *(.strtab) }				\
-- 
2.51.0


