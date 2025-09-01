Return-Path: <linux-kernel+bounces-793874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D31DB3D991
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2853AC34B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00776243387;
	Mon,  1 Sep 2025 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="F1ltyGPY"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56419AD89
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707156; cv=none; b=U2F0Ztqap2pqgfXObKlblK+8I9uCnIQatDXy8pVw+b2BfqEr/SJdSvKFZTSSvzLxpUVwk8kY2Vq/jzlqAUM/zZvWn9pygsinz5hOBZJDaZOzgsfN+JoQfWeYXUiRLYsu4PcrPImLEVegekAT80fHyfA/uuxsBYBLx34EEwaDxxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707156; c=relaxed/simple;
	bh=BGgqtB2T1dEih12Xb5wEbBlVHD6h7kVSVwSv1DTjHhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRVLuy8vN9qaBDEI0zmmbwcB35rVjTTt4N7Fb3lvjOwyMv8qdPu0pOg/qzQOZuO5wMpZKx8QJY5BCzxsk8mXzf9lYIZ5f1puxkcD8xhXOvKTVmTrMdXJRIgX8nHTRVF88htk+8VQ38M9fdW57f/BgsUGNoygQKLtXDFYzftMuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=F1ltyGPY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61ca9a5b41bso5148620a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756707152; x=1757311952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KpHLc7A3u13jSpGa9TNDfhEMDSTSK3zE0bmrT0DiPuA=;
        b=F1ltyGPYAXGgIFVPmN8jFr5+ZDlzyiQNO2zouMKQUhmWa+Is8NgNB52i95AR4/ytDy
         3qJAZbAz2w8JPWwGT8l/6/R/8HZT99NvcMECh7Z/glrQTvuPZT1+xbQxVvZXQCjUnKYd
         FszMeUUdAQk5iuDgOCOR9mxEtzbx4rGZ2GChS2JJmf5wgJfl307+m50yzc1kNPzye+Aa
         Uno7ya2Q9jiiDYSm2Q7QNaMr+JW/aktWOtu7IGPyAzhU+gVDOe7uKZ2tB1lRm1k96SDz
         t55xx1eqZDmQk4VJtIa1XBsP5gSQelekM1DcseirEjfLtFpMmKELhZ+q9mZRA831bAcl
         4Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707152; x=1757311952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpHLc7A3u13jSpGa9TNDfhEMDSTSK3zE0bmrT0DiPuA=;
        b=gbBmf0dyuRRvBHl10fN/wrLGdzZw7GIMooXQhFpTmKSTvoV+0/kwcOvy0NyR1TTkW/
         Bdi7Fn7NZusd2xsHDW5QLhlw4cgRKvQtDo49CLi+jhOPA4r6fVdblb9/zKekf34n16U9
         KNpMPIw8rU2k3nw278mVzDxFObN/dk4s5ts9NSlxYZPdlRwO0sFcj5ATbIk961rW0rpa
         IkSovcuPvOGow/NPRkfbZc1yTF4rbCOdUN+XyUDMv0d+/aAM/3BvUz6kmG/Pn4qLVBgW
         x5czqfJ/USf7CPKcviGRJ917F78AIx7Hb+WjpYrmRtHexlYS+WX0YhuauT/tMOke83yH
         WENg==
X-Forwarded-Encrypted: i=1; AJvYcCUqYZLS1eOH7B/kNoo3vVHyweNimwY6C5k0DGUyhDmda2d3AJKtEvlKB61OwoYsxR07tB9c1Yq+x8F1jiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN0yp23FjbHXof5j8yJaJ+wGqUQKVytwh8kyJOMMxpbR/fujqg
	sx4dsjjGqBemtg+rG2WGxD7O3oH0EJDE0kc+/y71sy8Pb4xc9WVyoNKWKZNxfGS0kVg=
X-Gm-Gg: ASbGncvG7IXJNzWVCVpC8Xh0a2Iaj0dHkEbROJrQl7j+xG5BqtFEkDSb+g4RmMecak3
	y3zR5hrMm3vZ42bO9euTlOyUIDRrWZhWW86qMW2ggcqT+f7b5gFNiZAGzLjjbamMroz3urVOqtS
	PTtkXsyWPVaglacDPaz/98gG+VLwdvuITTa0Eh5vcRLUMyR8YI9bE5wZMCh8dmDCWgIcH/fwTdV
	WMAASRLg1/2l8QgXIsoTISEV9VsgyYYBDMqx35QxecDaFKkUiRKyRf2navC1VTB5vkCDo1taJ/7
	EechGTk1hbFZ895cjeZlZw+AmcyPrXAz4odz+WDpBwHE4Wk+/kDjj7794otTU/c67AYLgVwNF9G
	puLN5MpUNnjr2mdq9XbPVRXYuVChStD6SpDodowaFQ2L7dPmZrCvuXDd5QjvI8FnxJlunVsCs37
	OUI8CgwmrbqpWi+HTyQgpiIcVNqpiUoN99
X-Google-Smtp-Source: AGHT+IGBFtmEnqB1bVOIv6STAyxunZzW94SmLiywCtB1sDFjhfn22FdqbPmZlx92N7ZJy9skuz+v4g==
X-Received: by 2002:a05:6402:268e:b0:61c:9193:a4c with SMTP id 4fb4d7f45d1cf-61d26987b9dmr4913122a12.1.1756707152279;
        Sun, 31 Aug 2025 23:12:32 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm6374533a12.23.2025.08.31.23.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:12:31 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 00/12] mm: add `const` to lots of pointer parameters
Date: Mon,  1 Sep 2025 08:12:11 +0200
Message-ID: <20250901061223.2939097-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

This work was initially posted here:
 https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/

.. but got rejected by Lorenzo Stoakes:
 https://lore.kernel.org/lkml/d6bf808d-7d74-4e22-ac4b-a6d1f4892262@lucifer.local/

David Hildenbrand and Lorenzo Stoakes suggested splitting the patch
into smaller chunks.  My second attempt with one smaller patch was met
with agreement:

 https://lore.kernel.org/lkml/20250828130311.772993-1-max.kellermann@ionos.com/

Now this is the rest of the initial patch in small pieces, plus some
more.

Establishing const-correctness in this low-level part of the kernel
enables doing the same in higher-level parts, e.g. filesystems.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1 -> v2:
- made several parameter values const (i.e. the pointer address, not
  just the pointed-to memory), as suggested by Andrew Morton and
  Yuanchu Xie
- drop existing+obsolete "extern" keywords on lines modified by these
  patches (suggested by Vishal Moola)
- add missing parameter names on lines modified by these patches
  (suggested by Vishal Moola)
- more "const" pointers (e.g. the task_struct passed to
  process_shares_mm())
- add missing "const" to s390, fixing s390 build failure
- moved the mmap_is_legacy() change in arch/s390/mm/mmap.c from 08/12
  to 06/12 (suggested by Vishal Moola)

v2 -> v3:
- remove garbage from 06/12
- changed tags on subject line (suggested by Matthew Wilcox)

Max Kellermann (12):
  mm/shmem: add `const` to lots of pointer parameters
  mm/pagemap: add `const` to lots of pointer parameters
  mm/mmzone: add `const` to lots of pointer parameters
  fs: add `const` to several pointer parameters
  mm/oom_kill: add `const` to pointer parameter
  mm/util, s390: add `const` to several pointer parameters
  parisc: add `const` to mmap_upper_limit() parameter
  mm/util, s390, sparc, x86: add const to arch_pick_mmap_layout()
    parameter
  mm/mm_types: add `const` to several pointer parameters
  mm/mm_inline: add `const` to lots of pointer parameters
  mm: add `const` to lots of pointer parameters
  mm/highmem: add `const` to lots of pointer parameters

 arch/arm/include/asm/highmem.h      |  6 +--
 arch/parisc/include/asm/processor.h |  2 +-
 arch/parisc/kernel/sys_parisc.c     |  2 +-
 arch/s390/mm/mmap.c                 |  7 ++--
 arch/sparc/kernel/sys_sparc_64.c    |  3 +-
 arch/x86/mm/mmap.c                  |  7 ++--
 arch/xtensa/include/asm/highmem.h   |  2 +-
 include/linux/fs.h                  |  7 ++--
 include/linux/highmem-internal.h    | 38 ++++++++++---------
 include/linux/highmem.h             |  8 ++--
 include/linux/mm.h                  | 48 +++++++++++------------
 include/linux/mm_inline.h           | 26 +++++++------
 include/linux/mm_types.h            |  4 +-
 include/linux/mmzone.h              | 42 ++++++++++----------
 include/linux/pagemap.h             | 59 +++++++++++++++--------------
 include/linux/sched/mm.h            |  4 +-
 include/linux/shmem_fs.h            |  4 +-
 mm/highmem.c                        | 10 ++---
 mm/oom_kill.c                       |  3 +-
 mm/shmem.c                          |  6 +--
 mm/util.c                           | 20 ++++++----
 21 files changed, 162 insertions(+), 146 deletions(-)

-- 
2.47.2


