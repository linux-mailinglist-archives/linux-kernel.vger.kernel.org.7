Return-Path: <linux-kernel+bounces-751105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7811B16550
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDAC3A83A1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098DC2DECD8;
	Wed, 30 Jul 2025 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX2QdmIQ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0E32DCBF1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896003; cv=none; b=ixTbDojpUaMs3ADGhvLTzLPAPlPB2QaAXj/RfvNgKc/rpIKysBLCxA4pPoWeXpin7w2JmM6r6MReXEm/KSxC4DqgsEsqnP62iXLSkxlqXqkkpC1NzXPiFQBkaR/3y9z7+XYXhKpSYtm3Jh7X2JslgXFKPMdhaKJKNWtuXnCAbLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896003; c=relaxed/simple;
	bh=AcAhv9q5vTu1g4k0gz+3jIhEurYESvb07bGDGjZaNeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bW0coas6iar6PjAiYLyBJ+UpQYYHiDmQ5nB+UY4Nw0XzOm41gDLInVXTegv7aqWSBx0L1SJG42PoKPKrjZ2LFtZxcnFDDZFxOOxJBD14J37r8seZO+/OVMKXrT2OrUrymUbGThDmm/EOp/fWrWtM4nTjeXa8ZLgTcTaGEMHqdWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX2QdmIQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b78d729bb8so47178f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753895999; x=1754500799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6LSHcQ0idAwPKDvX8EE25U8/JSS0uYFnXe2HDNHqMNY=;
        b=FX2QdmIQ+KIlzXvKeXeB9Epx47QvU3Vq+mn83fs0jUAHPE6u6v30YhNUPpCix0On5q
         tqBFIk+HbiZfes0DSdwoooSB1KfbklcHM6FMyywB/OrwM3jp0CXIKKjrbMERS72QJgR1
         cNvvqn6kWczoTwU9bAGQP/ZFnC+LgggAUbwDuAyRzn+Q+t8u/B9j+sPnUVfELuslwYOC
         OgjSBBROexS8wzb6Ym522Ed3BZ1aVFWx+p8GD67TQryqruwndm1rB38Z7tbev0RF5t8Y
         u5/Gnuz91+BPjyi7GpnEtBi0s0HaI0rLEDpj+vkYiIXhZMtixwGLXh05SNhYB8ZoLMu+
         QpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753895999; x=1754500799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LSHcQ0idAwPKDvX8EE25U8/JSS0uYFnXe2HDNHqMNY=;
        b=hMTwsNoM6oe/wpzs69i3jr6xRz9ltFeulY85FeeG/bDznyEnEnghXNu25rj4wV1WjL
         Pe33QXJITUO5g0ilgxAsWKi9juJXsDrM8ZnQWStoTuqnz+Axg0gfw7bgxX0o+M6mMC82
         IxxAKayEBoZizWrCLR/gmy5a3EfywYCOyYUQ1ZZRJdkRBEqCusvbrNNIXuu5adNJGDv2
         c5TcWOLr4CvvLnOvQpBBgAriSzTXcSaQYp9ZjLIHz4lsYCB5oPGsSAy4WTcebGS72+J1
         Oxk+PAADHsmBrwUILzb8qhV8qtUXGGXLFn5PtZob05Datysk2nPTI0AfcZRnRYuQp4o+
         SKGw==
X-Forwarded-Encrypted: i=1; AJvYcCWW5COe/Svc4e88qGHdBgXMCNVOkK2sC0TCfkeHc1n/EZd38wooP6wDQVDPv/BRFp4QiQuRcCCFURLhlgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDGFXJwn2b8ZrTyFzc8zJo6ZSp6B+57n2EJwfiH+LfVnTmxaiX
	2CbwABnu/Ziq2uS34dzLOL+jsI75KI1M5gXnlweRnHCEoSuUjdU97Bwj
X-Gm-Gg: ASbGncvCCnpuvS2ONVviyV0wDgB/JkCtFKhm2jm7tzbCsbfjh7W9FPfZYrMPEPrLS3J
	8uZxWMln6BpHjhTGe/fupDaX430Nxw5oxKhehQEypw1HFIxDixDHwPktdR802oI/ctsDiwkyxMy
	1rbrDBLu3FoViSzyWLTL25GSmBlYZuORvnkRIvAbXhwVcz93RUv6QjCzgAuYpb0FAQo4ZSMc0eg
	qQHQhSXu1P1HuY//Tr+7YctsPTJyiRdYazZ/nsYqeVosEnFDf3Z/LKKgjtZBmrWr2x+kXsRQnDS
	+SYjvdG4/m9z5aXy/07lQJNi18pTSlWTUKeWmMWlHUW6s1Jzl4xz+pSOwBRZ+v+LE4m+1iIN6PD
	r7C0bckMZ6J9+Fo4=
X-Google-Smtp-Source: AGHT+IHHpOLorxoYWXm9QIh1oiahYntiaztlH+OhrVoWzA0q4E4cWgVlDniRm+8G6MBU9hzMPBToCQ==
X-Received: by 2002:a05:6000:3107:b0:3b7:8af8:b922 with SMTP id ffacd0b85a97d-3b794ffd8d8mr3068673f8f.34.1753895999181;
        Wed, 30 Jul 2025 10:19:59 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589aefaa44sm26603385e9.20.2025.07.30.10.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:19:58 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm/damon: Add damos_stat support for vaddr
Date: Wed, 30 Jul 2025 10:19:54 -0700
Message-ID: <cover.1753895066.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously damos_stat only supoort paddr. This patch set adds support 
for damos_stat for vaddr. Also all different types of filters are 
supported. 

Functionality Test
==================
I wrote a small test program which allocates 10GB of DRAM, use 
madvise(MADV_HUGEPAGE) to convert the base pages to 2MB huge pages
Then my program does the following things in order:
1. Write sequentially to the whole 10GB region
2. Read the first 5GB region sequentially for 10 times
3. Sleep 5s
4. Read the second 5GB region sequentially for 10 times

With a proper damon setting, we are expected to see df-passed to be 10GB
and hot region move around with the read

$ # Start damon record
$sudo ./damo/damo start "./my_test/test" --monitoring_intervals 100ms\
1s 2s

$ # damon report
$sudo ./damo/damo report access --snapshot_damos_filter allow \
hugepage_size 2MiB 2MiB
    heatmap:
    # min/max temperatures: -600,000,000, 100,001,000, column size: 137.352 MiB
    intervals: sample 100 ms aggr 1 s (max access hz 10)
    # damos filters (df): reject none hugepage_size [2.000 MiB, 2.000 MiB]
    df-pass:
    # min/max temperatures: -400,000,000, 100,001,000, column size: 128.031 MiB
    0   addr 85.373 TiB   size 745.555 MiB access 0 hz   age 6 s           df-passed 0 B
    1   addr 127.608 TiB  size 877.664 MiB access 3.000 hz age 0 ns          df-passed 878.000 MiB
    2   addr 127.609 TiB  size 219.418 MiB access 2.000 hz age 0 ns          df-passed 220.000 MiB
    3   addr 127.609 TiB  size 316.613 MiB access 1.000 hz age 1 s           df-passed 316.000 MiB
    4   addr 127.609 TiB  size 474.922 MiB access 1.000 hz age 1 s           df-passed 476.000 MiB
    5   addr 127.610 TiB  size 407.188 MiB access 1.000 hz age 0 ns          df-passed 406.000 MiB
    6   addr 127.610 TiB  size 610.781 MiB access 1.000 hz age 0 ns          df-passed 612.000 MiB
    7   addr 127.611 TiB  size 697.309 MiB access 0 hz   age 0 ns          df-passed 696.000 MiB
    8   addr 127.611 TiB  size 77.480 MiB  access 1.000 hz age 0 ns          df-passed 78.000 MiB
    9   addr 127.611 TiB  size 573.102 MiB access 1.000 hz age 0 ns          df-passed 574.000 MiB
    10  addr 127.612 TiB  size 245.617 MiB access 2.000 hz age 0 ns          df-passed 246.000 MiB
    11  addr 127.612 TiB  size 295.102 MiB access 1.000 hz age 1 s           df-passed 294.000 MiB
    12  addr 127.612 TiB  size 295.105 MiB access 1.000 hz age 1 s           df-passed 296.000 MiB
    13  addr 127.613 TiB  size 67.172 MiB  access 1.000 hz age 1 s           df-passed 66.000 MiB
    14  addr 127.613 TiB  size 604.570 MiB access 0 hz   age 1 s           df-passed 606.000 MiB
    15  addr 127.613 TiB  size 389.578 MiB access 0 hz   age 4 s           df-passed 388.000 MiB
    16  addr 127.614 TiB  size 259.719 MiB access 0 hz   age 4 s           df-passed 260.000 MiB
    17  addr 127.614 TiB  size 817.941 MiB access 0 hz   age 4 s           df-passed 818.000 MiB
    18  addr 127.615 TiB  size 204.488 MiB access 0 hz   age 4 s           df-passed 204.000 MiB
    19  addr 127.615 TiB  size 730.902 MiB access 0 hz   age 4 s           df-passed 732.000 MiB
    20  addr 127.616 TiB  size 182.727 MiB access 0 hz   age 4 s           df-passed 182.000 MiB
    21  addr 127.616 TiB  size 926.824 MiB access 0 hz   age 2 s           df-passed 928.000 MiB
    22  addr 127.617 TiB  size 102.984 MiB access 0 hz   age 2 s           df-passed 102.000 MiB
    23  addr 127.617 TiB  size 86.527 MiB  access 0 hz   age 2 s           df-passed 86.000 MiB
    24  addr 127.617 TiB  size 778.777 MiB access 0 hz   age 2 s           df-passed 776.000 MiB
    25  addr 127.999 TiB  size 132.000 KiB access 0 hz   age 6 s           df-passed 0 B
    memory bw estimate: 6.524 GiB per second  df-passed: 6.527 GiB per second
    total size: 10.731 GiB  df-passed 10.000 GiB
    record DAMON intervals: sample 100 ms, aggr 1 s


$ # damon report again
$sudo ./damo/damo report access --snapshot_damos_filter allow \
hugepage_size 2MiB 2MiB
    heatmap:
    # min/max temperatures: -1,100,000,000, 2,000, column size: 137.352 MiB
    intervals: sample 100 ms aggr 1 s (max access hz 10)
    # damos filters (df): reject none hugepage_size [2.000 MiB, 2.000 MiB]
    df-pass:
    # min/max temperatures: -900,000,000, 2,000, column size: 128.031 MiB
    0   addr 85.373 TiB   size 745.555 MiB access 0 hz   age 11 s          df-passed 0 B
    1   addr 127.608 TiB  size 579.715 MiB access 2.000 hz age 0 ns          df-passed 580.000 MiB
    2   addr 127.608 TiB  size 144.930 MiB access 2.000 hz age 0 ns          df-passed 146.000 MiB
    3   addr 127.608 TiB  size 452.453 MiB access 2.000 hz age 0 ns          df-passed 452.000 MiB
    4   addr 127.609 TiB  size 113.117 MiB access 1.000 hz age 0 ns          df-passed 114.000 MiB
    5   addr 127.609 TiB  size 182.367 MiB access 2.000 hz age 0 ns          df-passed 182.000 MiB
    6   addr 127.609 TiB  size 182.371 MiB access 2.000 hz age 0 ns          df-passed 182.000 MiB
    7   addr 127.609 TiB  size 350.488 MiB access 1.000 hz age 0 ns          df-passed 350.000 MiB
    8   addr 127.610 TiB  size 525.738 MiB access 1.000 hz age 0 ns          df-passed 526.000 MiB
    9   addr 127.610 TiB  size 401.352 MiB access 1.000 hz age 0 ns          df-passed 402.000 MiB
    10  addr 127.611 TiB  size 100.340 MiB access 1.000 hz age 0 ns          df-passed 100.000 MiB
    11  addr 127.611 TiB  size 19.523 MiB  access 0 hz   age 0 ns          df-passed 20.000 MiB
    12  addr 127.611 TiB  size 175.727 MiB access 0 hz   age 0 ns          df-passed 176.000 MiB
    13  addr 127.611 TiB  size 106.629 MiB access 0 hz   age 0 ns          df-passed 106.000 MiB
    14  addr 127.611 TiB  size 959.676 MiB access 0 hz   age 0 ns          df-passed 960.000 MiB
    15  addr 127.612 TiB  size 424.469 MiB access 1.000 hz age 0 ns          df-passed 424.000 MiB
    16  addr 127.612 TiB  size 424.469 MiB access 1.000 hz age 0 ns          df-passed 424.000 MiB
    17  addr 127.613 TiB  size 201.648 MiB access 0 hz   age 6 s           df-passed 202.000 MiB
    18  addr 127.613 TiB  size 806.609 MiB access 0 hz   age 6 s           df-passed 806.000 MiB
    19  addr 127.614 TiB  size 862.125 MiB access 0 hz   age 9 s           df-passed 862.000 MiB
    20  addr 127.614 TiB  size 215.535 MiB access 0 hz   age 9 s           df-passed 216.000 MiB
    21  addr 127.615 TiB  size 104.500 MiB access 0 hz   age 9 s           df-passed 104.000 MiB
    22  addr 127.615 TiB  size 940.523 MiB access 0 hz   age 9 s           df-passed 942.000 MiB
    23  addr 127.616 TiB  size 640.281 MiB access 0 hz   age 7 s           df-passed 640.000 MiB
    24  addr 127.616 TiB  size 426.855 MiB access 0 hz   age 7 s           df-passed 426.000 MiB
    25  addr 127.617 TiB  size 90.105 MiB  access 0 hz   age 7 s           df-passed 90.000 MiB
    26  addr 127.617 TiB  size 810.965 MiB access 0 hz   age 7 s           df-passed 808.000 MiB
    27  addr 127.999 TiB  size 132.000 KiB access 0 hz   age 11 s          df-passed 0 B
    memory bw estimate: 5.297 GiB per second  df-passed: 5.297 GiB per second
    total size: 10.731 GiB  df-passed 10.000 GiB
    record DAMON intervals: sample 100 ms, aggr 1 s

As you can see the total df-passed region is 10GiB and the hot region
moves as the seq read keeps going

Revision History
================
Changes from v1 [1]:
- Follow David's advise to combine *pmd_entry() and *pte_entry() into
  one. Also remove manually setting walk->action
- Use vma_normal_page and vma_normal_page_pmd instead of damon_get_folio
  to remove redundant folio_get and folio_put
- Follow SJ's advise to only move damon_pa_scheme_has_filter to
  ops-common
- Change the command used in cover-letter for more natural illustration

[1] https://lore.kernel.org/all/cover.1753794408.git.pyyjason@gmail.com/

Yueyang Pan (2):
  mm/damon: Move has filter to ops-common
  mm/damon: Add damos_stat support for vaddr

 mm/damon/ops-common.c |   9 ++++
 mm/damon/ops-common.h |   2 +
 mm/damon/paddr.c      |  11 +----
 mm/damon/vaddr.c      | 105 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 116 insertions(+), 11 deletions(-)

-- 
2.47.3


