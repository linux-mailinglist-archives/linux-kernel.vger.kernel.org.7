Return-Path: <linux-kernel+bounces-753871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D093BB18946
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59079AA2BC2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6299123ABB5;
	Fri,  1 Aug 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+zmF1/8"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079428BAB1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754089214; cv=none; b=eg23cDub2uCAEpoCyIbuMc3p4sZ86jsPD9TJ4ZM8qfErn2fJ2qzywKz60CS24bln4+TVY3BTiF5lpEHHZnTnyclbQnnV2q2ZUZ+mJ7VcisWUsmmDFDxIG/rVy2Ku8ocboDclQkZXKxrOz3rozpVdG93qWJuFAcry8SSi+bGY5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754089214; c=relaxed/simple;
	bh=g8bAFHULYrY8r68acynE4yxCOA7QQPyExYWq8EQMal0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5Gv/Q5u/ILA3kLuSlfldJ2VYs0C5y2y/RmlGW9XV/+SY92RYfV2z2lMvm7m6GtlgdiIqv7ku/lb1InkvD2OXNWB4Ui5Mnp7OeoYuIq7kjakSXQ2l/GrXOCKHgMCamXbCqlWNoXzjFCNmQGnzv9thIXtQZZbxhzCJJfzbha8mMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+zmF1/8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so4093102a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754089211; x=1754694011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zMNMwlGsmPkFnaHU0PDDeLlWFlLk9FifMJ8SvVP4vxY=;
        b=d+zmF1/8/Snr/04JuUqPPy8siLWKO2+Xecr2F8w0lJXNRT0UxD9jGaKXm6PzNuKYe/
         aWN72JYd0MClqWBG6+KSUwfVYeJzixP3qHxHnO8AUOXqhEQnaLGK90A48Tp0eBijmOJt
         ynjupc4rsf58l8UJ3NYnCPZL1NElppDd8aKE5aR8lzsw3hwDVh3fLu3ul55M5yqUwTtK
         xzXa3wuDKqwVGJPMNbrD7N3DP+P3sRkLB29visS5ir82cOrTfheanf63LiZwMUtEUxKu
         lVOe37UZEhc+3j0xSnja23qAI1+mreAIofx26kIDeE2+qRQZLMqB7SsbF7gbYjE2ORyK
         UrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754089211; x=1754694011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMNMwlGsmPkFnaHU0PDDeLlWFlLk9FifMJ8SvVP4vxY=;
        b=glSnV3dAXAzP3LqMaanNOySxmaWkJxKD+n2U6f8K8urmAAmHkXCU6dop/nCnH7X3D0
         IWkG8257ez7ik56P5etsWekhpHkWLOWyAKjgRvTwx1ua4xvQoVEpW/1sFA0ByvzXaoWN
         5EcqmstqoNUqWJK2ENvU2KEfX/ORRjQ7hwZszvuBmhg7xcpp0yA8Zv1SvIRsXFItBHi1
         8M9qU+mMxff95JooC+rNPVg6YZUpaFkHlcvQcZYqNgu1pplEBrgBohdzX63R20P/1/VM
         0lTA2O8KvjuM6n9m+QAPB0yfv2OP7xrGfqjfL2r0TqyC83oKdQJ8DMzgzvha3ghu1P9n
         8drw==
X-Forwarded-Encrypted: i=1; AJvYcCX+cjG9gNn4EXmDRxjIGOFPv7osSIVuGvxgbMrkHiW8m9gn8XQvy8cG8BydJoDTC36DEEWgOltqDkFoRfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwk8PVXbjydP+5LaMFx8PCye6eWXwjsw/c0P387ytJu7WQbzrC
	1WPPgs5Q3N+0AEz8z+gzqHhDSOiMaWKhRg5/6da31UH894WOSpaXO46x
X-Gm-Gg: ASbGncsEm9A2zq4GYlQxyqxl++1rBTm25nP2DrI9v5x/yWeeMV/dWbEtecnqIQfclBw
	8bUtYuG+rTZa7tsnQLzJte06SYyS1ebxmrvX8l9xFdyH2bWzIuSZ+LrPDPCumqUFJrgGAAS5L4K
	iEmKTJIfSxQxnejyb+GiekXINw4qz7wsAtsoR/UEWEhA5ON3spzkaiGekQ8CtQ15co3A+YHgI0B
	N0zWLhCBQxQkdqmdek3igr3jb+ZS1SB055fYBRElXtxDmVj832iXLNmiK8ruQdXjXtZ5PZ9OM6H
	KCYpIvUhoHlntoRnz/3UpOvGmTSQUfuGD2ZeVy9llDq9awXIIOEh3lNwRGnQQl2Zs9Q6iyI+04z
	Ofc7GgX4FqXyRsmpRRUY03+80WzvHlEYb/roL1UxsdCbbs5eOFpvcFP4O+peH3np/wGhuIGU=
X-Google-Smtp-Source: AGHT+IFnVRnrsg9ncutTril6bhBhLAh+iORwQnRdsoguSnMGnXS3nrWaw/8zgfS5xc+Ciny5pIJY1w==
X-Received: by 2002:a05:6402:2688:b0:612:b150:75f3 with SMTP id 4fb4d7f45d1cf-615e6ed2172mr1068482a12.8.1754089210430;
        Fri, 01 Aug 2025 16:00:10 -0700 (PDT)
Received: from rs3labsrv8.iccluster.epfl.ch (nat-icclus-192-26-29-9.epfl.ch. [192.26.29.9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffa17csm3279290a12.49.2025.08.01.16.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 16:00:09 -0700 (PDT)
From: pyyjason@gmail.com
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Yueyang Pan <pyyjason@gmail.com>
Subject: [PATCH v3 0/2] mm/damon: Add damos_stat support for vaddr
Date: Fri,  1 Aug 2025 22:59:49 +0000
Message-ID: <cover.1754088635.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yueyang Pan <pyyjason@gmail.com>

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
Changes from v2 [2]:
- Fix some naming and format issues raised by SJ.

Changes from v1 [1]:
- Follow David's advise to combine *pmd_entry() and *pte_entry() into
  one. Also remove manually setting walk->action
- Use vma_normal_page and vma_normal_page_pmd instead of damon_get_folio
  to remove redundant folio_get and folio_put
- Follow SJ's advise to only move damon_pa_scheme_has_filter to
  ops-common
- Change the command used in cover-letter for more natural illustration

[1] https://lore.kernel.org/all/cover.1753794408.git.pyyjason@gmail.com/
[2] https://lore.kernel.org/all/cover.1753895066.git.pyyjason@gmail.com/

Yueyang Pan (2):
  mm/damon: Move has filter to ops-common
  mm/damon: Add damos_stat support for vaddr

 mm/damon/ops-common.c |   9 ++++
 mm/damon/ops-common.h |   2 +
 mm/damon/paddr.c      |  11 +----
 mm/damon/vaddr.c      | 103 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 114 insertions(+), 11 deletions(-)

-- 
2.43.0


