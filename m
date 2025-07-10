Return-Path: <linux-kernel+bounces-725280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3EEAFFCD6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C542C1C2787F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408E828C86E;
	Thu, 10 Jul 2025 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QSw1rtTn"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E88A283CAF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137648; cv=none; b=L1MfJNaF+Jm0bT19wH7ziqHLoBtyhnqHoS4vjGkWUK9skc0CZjuxzxQn0vAIHro2rKVJEY+7iLvaKox5Dje89TBkIcDHqw7pXXC43p7hANRPrCStWJ1xjNKRwngbopLYRBcXBulJBimvP2qY/HUXnPhLsL7nHZIJKMzt38ubnHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137648; c=relaxed/simple;
	bh=+Z5WADhe/Xuq6DteK13WAlWULoqbZ60Vl2RjQpdIoM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HaZOoNZpcs05Ax699iO/Eyf0xQlsAkb7S835U0ahVik+IKVEjYKXqv1OvSSMTdNhwalUOuhyjzzc3OjZwrUA3HX92Eravqxn1Vj2zol83kuF6mcResdEsWbeiJdcp/E5Mk8f//LK3a7ezeiMNVCPSy+JnrirdbLfXJiwODPF10A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QSw1rtTn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so686044a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752137646; x=1752742446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gWbi6xFF8NpvBvxiKjb+PGBnnwTuskR8M/z7QpKQFLM=;
        b=QSw1rtTnbD3y4LHBG/zJqD+WTw1CDZxWx7C0vW7YA9/Ccc863xYzzJaGTTbd6b7P9k
         RJKrV0MG4bNxqg/t3NSeKnJWbmMG8Gr/hyiqzmGkO00k0Y8rphKElENkzFh07iaV7hO/
         JNi+65cXjGw9hX8ZaFbhetdPOPQ+CBCjFdfGHf8wlI0EVPcIqSk9hRNjgJAZQdF4JXSR
         nrK/qQwzKbskM01y8NS2pHNGpMRd0a2kSs6+MZn/v4cSTJf6/X+4/2oyD9O32GHK2CTU
         nWRywC6P/QoSd/rSDO4Iyls0E88Pq1L4FNECmtFT5ps3qKZIxp1rQz0WC0cOsu2dCC8p
         tHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137646; x=1752742446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWbi6xFF8NpvBvxiKjb+PGBnnwTuskR8M/z7QpKQFLM=;
        b=U/DXD9MW0zb8BvcaKR6P0VydNTpHASVKnYN1EprRoNMsPTmvzeKcXCCMvQbBhyMsAy
         h4PRAIWqw+ftfebvDf1DgvfodCtMJIM4Z92Z62a/zjhbpLSwhFmZx3Q7S3T6vcy+GEhP
         yONuhqhtROfkQZcQaZU7CbC1wQ4seu3XXvjVp9gEWAtmY2Ym0veDQavwhGysRW0q+FtG
         K+KmSrcZIWq+2c6q4TB6PUx1US0v8k9fKezodJ7XJqf6TLf8kkivFJMcNCurxJebClCj
         73MoEa2DmjunufyaflU0bTKee7Sdr1q2oR8zspmsjWL9Yy+Spn+gHGOMpj39c8jcH4di
         FDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm1SOatSRQrWmAiRPVySvVNu3Opmk9E7WKxTFuh01x/uwsbzlDyfoCd31kXi5COkfZnO2z5zOT+q9CpCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQpJwlKhRUZ7yHuXPpypATx4BORa9ptiQdsmTzEQnGh2E75iL
	LNiAI+HXraQyGqs2IAk+5HF07DG3D/lLcVNX2D2jVa+hHQhbNhWNYaMsSep+fwcAK44=
X-Gm-Gg: ASbGncuQOiUtE9StQ09quejHFscAHHaTExeqAlPnluqLtF4z2c54zxPJXDZOF0NNaqv
	U6NTdXEXGDTK1PNn8JSwKD2mTlGNhoaxQyQsELprLiuPywsB1ylZc+w7c4Bpg8vXKQyAFjAbXR/
	enpSqi8yQwVCxlAw66n3eo5zJ1yVE2Y0eVE4RVvbGlP05rYWYRQ8AeEq6xRBZZq7F5BCx48eLUG
	kX2JspPwp37nMldw3JoN5e5/DEN/7/cOt8kTkvidU6J1AOp32+yr9QQNIExrdZCLHo0pKtHFdfm
	TuqGMwOdkCdeHoNISTJlYGLbwVhukS0aPvxO+3ewR9YA06P6FUwiYbFrw0Lh77XjDPTssWC+G/i
	X4XfZTggoJ14FcnoSXT9p5dJE
X-Google-Smtp-Source: AGHT+IFSCTXPP1Dwv220thp+IerNnUa3CxD3gdRWucNdZnQM1rhZZ8D4iNbDue+54p483oZCo9Cdfw==
X-Received: by 2002:a17:90a:d884:b0:312:e90b:419e with SMTP id 98e67ed59e1d1-31c2fcffd1cmr10025787a91.12.1752137645501;
        Thu, 10 Jul 2025 01:54:05 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e975d41sm1650228a91.13.2025.07.10.01.54.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Jul 2025 01:54:05 -0700 (PDT)
From: lizhe.67@bytedance.com
To: alex.williamson@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	jgg@ziepe.ca,
	peterx@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com
Subject: [PATCH v4 0/5] vfio/type1: optimize vfio_pin_pages_remote() and vfio_unpin_pages_remote()
Date: Thu, 10 Jul 2025 16:53:50 +0800
Message-ID: <20250710085355.54208-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Zhe <lizhe.67@bytedance.com>

This patchset is an integration of the two previous patchsets[1][2].

When vfio_pin_pages_remote() is called with a range of addresses that
includes large folios, the function currently performs individual
statistics counting operations for each page. This can lead to significant
performance overheads, especially when dealing with large ranges of pages.

The function vfio_unpin_pages_remote() has a similar issue, where executing
put_pfn() for each pfn brings considerable consumption.

This patchset primarily optimizes the performance of the relevant functions
by batching the less efficient operations mentioned before.

The first two patch optimizes the performance of the function
vfio_pin_pages_remote(), while the remaining patches optimize the
performance of the function vfio_unpin_pages_remote().

The performance test results, based on v6.16-rc4, for completing the 16G
VFIO MAP/UNMAP DMA, obtained through unit test[3] with slight
modifications[4], are as follows.

Base(6.16-rc4):
./vfio-pci-mem-dma-map 0000:03:00.0 16
------- AVERAGE (MADV_HUGEPAGE) --------
VFIO MAP DMA in 0.047 s (340.2 GB/s)
VFIO UNMAP DMA in 0.135 s (118.6 GB/s)
------- AVERAGE (MAP_POPULATE) --------
VFIO MAP DMA in 0.280 s (57.2 GB/s)
VFIO UNMAP DMA in 0.312 s (51.3 GB/s)
------- AVERAGE (HUGETLBFS) --------
VFIO MAP DMA in 0.052 s (310.5 GB/s)
VFIO UNMAP DMA in 0.136 s (117.3 GB/s)

With this patchset:
------- AVERAGE (MADV_HUGEPAGE) --------
VFIO MAP DMA in 0.027 s (600.7 GB/s)
VFIO UNMAP DMA in 0.045 s (357.0 GB/s)
------- AVERAGE (MAP_POPULATE) --------
VFIO MAP DMA in 0.261 s (61.4 GB/s)
VFIO UNMAP DMA in 0.288 s (55.6 GB/s)
------- AVERAGE (HUGETLBFS) --------
VFIO MAP DMA in 0.031 s (516.4 GB/s)
VFIO UNMAP DMA in 0.045 s (353.9 GB/s)

For large folio, we achieve an over 40% performance improvement for VFIO
MAP DMA and an over 66% performance improvement for VFIO DMA UNMAP. For
small folios, the performance test results show a slight improvement with
the performance before optimization.

[1]: https://lore.kernel.org/all/20250529064947.38433-1-lizhe.67@bytedance.com/
[2]: https://lore.kernel.org/all/20250620032344.13382-1-lizhe.67@bytedance.com/#t
[3]: https://github.com/awilliam/tests/blob/vfio-pci-mem-dma-map/vfio-pci-mem-dma-map.c
[4]: https://lore.kernel.org/all/20250610031013.98556-1-lizhe.67@bytedance.com/

Li Zhe (5):
  mm: introduce num_pages_contiguous()
  vfio/type1: optimize vfio_pin_pages_remote()
  vfio/type1: batch vfio_find_vpfn() in function
    vfio_unpin_pages_remote()
  vfio/type1: introduce a new member has_rsvd for struct vfio_dma
  vfio/type1: optimize vfio_unpin_pages_remote()

 drivers/vfio/vfio_iommu_type1.c | 111 ++++++++++++++++++++++++++------
 include/linux/mm.h              |  23 +++++++
 2 files changed, 113 insertions(+), 21 deletions(-)

---
Changelogs:

v3->v4:
- Fix an indentation issue in patch #2.

v2->v3:
- Add a "Suggested-by" and a "Reviewed-by" tag.
- Address the compilation errors introduced by patch #1.
- Resolved several variable type issues.
- Add clarification for function num_pages_contiguous().

v1->v2:
- Update the performance test results.
- The function num_pages_contiguous() is extracted and placed in a
  separate commit.
- The phrase 'for large folio' has been removed from the patchset title.

v3: https://lore.kernel.org/all/20250707064950.72048-1-lizhe.67@bytedance.com/
v2: https://lore.kernel.org/all/20250704062602.33500-1-lizhe.67@bytedance.com/
v1: https://lore.kernel.org/all/20250630072518.31846-1-lizhe.67@bytedance.com/
-- 
2.20.1


