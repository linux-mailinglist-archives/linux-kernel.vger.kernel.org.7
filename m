Return-Path: <linux-kernel+bounces-735164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC97B08BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF181A6762B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0F029A9FE;
	Thu, 17 Jul 2025 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giWjQE7V"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF457145B27
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751481; cv=none; b=WD4Kg0yHoWMPdnwQFDmzEaHouZ2bpr83J7kgdFac/Lc1Zw4thMTg27vqN5mtsU9jBCIhklbYpPNB/IzKYOzxpFOH9YuhI6YM8paGLDkUoNV3+1dfWG3kvnAcE6HT0GojIgb3YAgiJz8/q7J1cA0+JeYPGv9MYO0ZlgBI9aYG/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751481; c=relaxed/simple;
	bh=JZLoL6im+FfnP6snePEDbPfXojxZicUmJZ1V3PbV2O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUnZnXsBCwSOuiYQ1waMtLPbYLJ8v+8jfGsJwSR8iubnh7ByMXHocG1wIU+JhTr19GfsCWNWErLxdO5w0d076v4DEjtjE2jKjpnLB2WGSxytrSSTfbid4TdZKaFmkzbIgoeRRuVd1bsUmmWNiqAfY8V6zTq23kYlQyfVkX8vA/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giWjQE7V; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so658796a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752751479; x=1753356279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSXrEo1TucinWyKyEWU0me4ky3C8hcqLGnoPGawQljI=;
        b=giWjQE7VxXAVTRDHXKyqoFTbtlQoS93pIOGFtmKPf4qGQIJ0CfYG2//G6l2rkkC2eF
         seoch52KWYH/O/nJlGuj3zvP61AI/igA9kD6Ajd2UZT5pCbiT3iWfpzJdEKpEu0S7dmC
         GBD/QrRKpE98MPihBuWJx0yuUCGrlbj3dXuq55dvJhOu6u9E0qGP59irOqgSmUdz7GJQ
         9ce4ygvvH4whG/ns9wRcHW1qZ7i5Vt3POa6Gu8sXgbOucWiYMfw23UcvXF0vay5hvhgB
         9yaNsxwZUotFBZvRVyZhvtmgFg8PI1B3IZSwmjxQynX40+3FvKJZYNpHVjl545IBPJ+H
         Kxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752751479; x=1753356279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSXrEo1TucinWyKyEWU0me4ky3C8hcqLGnoPGawQljI=;
        b=IBLsxP8dVMhTW/ABODHd1bXeqhXXGpxd8ChlW0dsk0GQQDm0tPIdx00R9z2woyQ7WX
         2PpviaqbA5Yl/+Dww8SmP5A0EAXGlkt5tDzv8gRpEcrk836gVMBPOMsAMhygPUNS0dZa
         q9FSSuMVWiGWBi++FvEqHVJV4oH9sbKmpBkYR7FK4oXRGTereN5aDCM5WTmmo9jpHHC0
         QZJvtNXXAFrFEewLqrIaHp4ZY+R1uyfapMV1v6SXQ6jjL7s/BsSvfEF+1E5w/7pYuN7J
         oLicsGcDxjb0NrMdhD0MrTGpVf2lGbtw02EOn8miugCJp+x8JQvDQSoBn6T8zC2z2Nrk
         yOyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkRL0J5lhUavum9uJKXHjm5OTL5lD/TPN9Y6pubV5NI+jEEmSvp+0G1WO7EdcdD/ksaz2PmufU4NCeI4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBru/Jq4sFGifh57gf6zDuhMgo42Dot0h9ZalJGWO92AOaZm0
	F49WGkGT3v4H41/efqRYhfpMCcI2K8BWnprYZBCuVQc8uziO1OmC/KmZ
X-Gm-Gg: ASbGnctQOAm9WCANCvWdOr3iPZVpCnh8OULJOutlBVseNvkZ0MF+8/bXpvkIo3TI1ac
	gihgkL+bTlqPKzSFnevZaqiP7Oh9WOzs5ORrXb0RtLiyLMISPhaKDVQAiw4XAdri31J1z2x9Mwq
	j/GC8hlpD9O060Y+Jgpx3VPoXvGFWTPaG1qOVgeugzLOkKVG2ItgjOp+gULgMg/GUrLt2DLkvWB
	za1vnzgcMuqHnJ2uDiRrodveQcvEMd0FJs3Vxu2KbUcTMjXkWO2H9LX9y6tFsIERdNTCiGcBRuI
	h+btWZHlowax1IpcwxjQqOmQ1sRege2kr8wJwCrskWmBuyUBduiH/2/zX9+AC43uMXDjKzanTiP
	83YgoaF5Hdqeb7omPg7C5KmHpO+xhKiWos7a498R23eMn
X-Google-Smtp-Source: AGHT+IEx79SAT8TYrkyQ6dT5a1IiGpG0QMHLNIGZb1VKFonFZmd+U+rkMC3WLql1NluSXeSazvPYXQ==
X-Received: by 2002:a17:90b:51c3:b0:311:e731:523a with SMTP id 98e67ed59e1d1-31c9f44b9cemr9416779a91.11.1752751478786;
        Thu, 17 Jul 2025 04:24:38 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9153803esm2530794a91.0.2025.07.17.04.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:24:38 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: akpm@linux-foundation.org,
	broonie@kernel.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	sj@kernel.org,
	ziy@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: brauner@kernel.org,
	gkwang@linx-info.com,
	jannh@google.com,
	Liam.Howlett@oracle.com,
	lianux.mm@gmail.com,
	ludovico.zy.wu@gmail.com,
	p1ucky0923@gmail.com,
	richard.weiyang@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me
Subject: [PATCH v2 0/2] selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r" (XXX));"
Date: Thu, 17 Jul 2025 19:24:05 +0800
Message-ID: <20250717112407.13507-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a common FORCE_READ() macro to replace 
the cryptic asm volatile("" : "+r" (variable)); 
construct used in several mm selftests. This improves code readability and 
maintainability by removing duplicated, hard-to-understand code.

I previously sent the refactoring patch [1] as a standalone change, following a suggestion from David. 
As Andrew Morton and Wei Yang correctly pointed out, 
that patch was incomplete as it was missing the macro definition itself, 
causing build warnings. My apologies for the noise.

[1] https://lore.kernel.org/lkml/20250716123126.3851-1-lianux.mm@gmail.com/

This v2 series corrects that mistake by properly structuring the changes:
- The first patch introduces the FORCE_READ() macro into the shared vm_util.h header 
  and includes a minor cleanup for another test.
- The second patch then uses this new macro to refactor the selftests.

changes to v2:
- collected Acked-by and Reviewed-by from  David and Lorenzo Stoakes.

wang lian (2):
  selftests/mm: refactor common code and improve test skipping in
    guard_region
  selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r"
    (XXX));"

 tools/testing/selftests/mm/cow.c              | 30 +++++++++----------
 tools/testing/selftests/mm/guard-regions.c    |  9 +-----
 tools/testing/selftests/mm/hugetlb-madvise.c  |  5 +---
 tools/testing/selftests/mm/migration.c        | 13 ++++----
 tools/testing/selftests/mm/pagemap_ioctl.c    |  4 +--
 .../selftests/mm/split_huge_page_test.c       |  4 +--
 tools/testing/selftests/mm/vm_util.h          |  7 +++++
 7 files changed, 32 insertions(+), 40 deletions(-)

-- 
2.43.0


