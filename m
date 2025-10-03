Return-Path: <linux-kernel+bounces-841584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7AABB7C08
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897F03B0543
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91D2DA76B;
	Fri,  3 Oct 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="diqUfvnA"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4486284B2E
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512769; cv=none; b=iFbCYLQqNyiQ/6s2jeF1U///OAiBExugMQxwDztHFkLfBckSYynCunbRVsS5dL8I6r0s+Qk8B7MftUs2Iz1MM22TpBkEmyjIVCePz7YkbVN7Bih3qbsckUJUm9IxkskLcA49/+CsP1q1qrViD3Pqdw8uVpVlCNxenYMma0zCdb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512769; c=relaxed/simple;
	bh=BoUvXUx1856Z2mp9veLGPB9txmBh/kcwlgQ9qzc/WoA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RiUqVmhnfwpfkzbPMGPSowgScCTzIu5F80OXf1EWRTOc6sgNJHkPjaLGm+JMxtN2N2K9EgNyLbv/lahjyAfzYvaJ2llg+S7PYhvJu6ZvjQ3fp7JoozJGrlJFeSTAoTTGt0WwhXw2tQse0keUj/R67LiRCuWFjosyo5YS+P1f7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=diqUfvnA; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-633009e440aso2203889a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759512765; x=1760117565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rtqteAJeUmRGsxg/Z0dCTAtvo7UMTgyQH1Vgz2I+fM=;
        b=diqUfvnApUEkdnJID1fl17MQVUjL/VEB+ArnnXk62k0nVj5JAu3sQAyBXFkmq52Oo4
         HlWWM8P1azL9KOLSQFMpHl/XXFe0DFsAH3KIOIJyrKhUNQXRuQOi1dAdQOn1LqAo6PUU
         EkExuDqzWrlNLbniHSsYClIO4k6C10TWg0ZiwahPwx4Pv/xk6J7LcgP2MakTP/3aYDZo
         a8z6u2eJCB923cmuUHPnom7gKwBYz8PXdm2IZtjv5ZCPbv8DORJcG3kw+Pp61W0zlHX0
         Srdo6bOHy9Nqtata8J4p1iXYfNPbcJr1N8j9TWKPGd0mka6nQntRcL+0kO/7F2FccQqs
         sQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512765; x=1760117565;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rtqteAJeUmRGsxg/Z0dCTAtvo7UMTgyQH1Vgz2I+fM=;
        b=oCvxJYUJg/LlBSITFzkrrGHFqdEuUnxpU4Mv/l+oSn32042mHpMDeUfQbAraHt6Mor
         Ho/GXL084psmBxm57XaE9+miCQ9vCxrhLOMxOIdo7RB4nnOgfVbDsME+5/ENsQtc8QjW
         MFVJc9JNrgz6lVhbSRFyPw6XFIMiZFGIxFYTl04+wnIHLvYu6/9t2yX6dzMcf1oGLFkH
         UhGTc7c9hI8v0J3T7V8kMTkqZxOpRrcaHaHs08zXsHZxIb4WAyC4oWk2lP6jXyNp2HAX
         85/Q1jaL0fzX6WjEIMP2rpLhqAysLgIaynq2aC0MpH5U0DLgATJ8LOgDhM4vgyyrgNir
         1+rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpBf3qiVKYxYaFrsTmtJ0wI08ipUnBTEcLgb5oCsgSlYUknLnrZKTotaxdM3P0b1nJlrDTVtrNFBVg+Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhi9/nKhR2JgDkaXbOr+JKxASA0GqEkdhPAACtYgBnsIXcmdg8
	wJ9wcFK8GUPhRXnNKdPjMwhs2RlGJdI6ZPtkoeMQjC9StXilrpskOIWVoJg6Mk7hBVQMKtRJJJK
	Eno1cten4rn2yXg==
X-Google-Smtp-Source: AGHT+IGlpvvYRqRysNX3SlhoP9uszCyEAfse5Ll61mfhygdHXMca2IgjMh5S/svFSAScgQFHPBRqwfLja/G1hQ==
X-Received: from edwr10.prod.google.com ([2002:a05:6402:34a:b0:62f:9fc4:ce8f])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:184b:b0:634:a23e:df26 with SMTP id 4fb4d7f45d1cf-638fcb7c9d0mr3359707a12.6.1759512765118;
 Fri, 03 Oct 2025 10:32:45 -0700 (PDT)
Date: Fri,  3 Oct 2025 17:32:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003173229.1533640-1-smostafa@google.com>
Subject: [RFC PATCH 0/4] iommu: Add IOMMU_DEBUG_PAGEALLOC sanitizer
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Overview
--------
This patch series introduces a new debugging feature,
IOMMU_DEBUG_PAGEALLOC, designed to catch DMA use-after-free bugs
and IOMMU mapping leaks from buggy drivers.

The kernel has powerful sanitizers like KASAN and DEBUG_PAGEALLOC
for catching CPU-side memory corruption. However, there is limited
runtime sanitization for DMA mappings managed by the IOMMU. A buggy
driver can free a page while it is still mapped for DMA, leading to
memory corruption or use-after-free vulnerabilities when that page is
reallocated and used for a different purpose.

Inspired by DEBUG_PAGEALLOC, this sanitizer tracks IOMMU mappings on a
per-page basis, as it=E2=80=99s not possible to unmap the pages, because it
requires to lock and walk all domains on every kernel free, instead we
rely on page_ext to add an IOMMU-specific mapping reference count for
each page.
And on each page allocated/freed from the kernel we simply check the
count and WARN if it is not zero.

Concurrency
-----------
By design this check is racy where one caller can map pages just after
the check, which can lead to false negatives.
In my opinion this is acceptable for sanitizers (for ex KCSAN have
that property).
Otherwise we have to implement locks in iommu_map/unmap for all domains
which is not favourable even for a debug feature.
The sanitizer only guarantees that the refcount itself doesn=E2=80=99t get
corrupted using atomics. And there are no false positives.

CPU vs IOMMU Page Size
----------------------
IOMMUs can use different page sizes and which can be non-homogeneous;
not even all of them have the same page size.

To solve this, the refcount is always incremented and decremented in
units of the smallest page size supported by the IOMMU domain. This
ensures the accounting remains consistent regardless of the size of
the map or unmap operation, otherwise double counting can happen.

Testing & Performance
---------------------
This was tested on Morello with Arm64 + SMMUv3
Also I booted RockPi-4b with Rockchip IOMMU.
Did some tests on Qemu including different SMMUv3/CPU page size (arm64).

I also ran dma_map_benchmark on Morello:

echo dma_map_benchmark > /sys/bus/pci/devices/0000\:06\:00.0/driver_overrid=
e
echo 0000:06:00.0 >  /sys/bus/pci/devices/0000\:06\:00.0/driver/unbind
echo 0000:06:00.0 > /sys/bus/pci/drivers/dma_map_benchmark/bind
./dma_map_bechmark -t $threads -g $nr_pages

CONFIG refers to "CONFIG_IOMMU_DEBUG_PAGEALLOC"
cmdline refer to "iommu.debug_pagealloc"
Numbers are (map latency)/(unmap latency), lower is better.

			CONFIG=3Dn    CONFIG=3Dy    CONFIG=3Dy
			            cmdline=3D0   cmdline=3D1
4K - 1 thread		0.1/0.6     0.1/0.6     0.1/0.7
4K - 4 threads		0.1/1.0     0.1/1.1     0.1/1.1
1M - 1 thread		0.8/21.2    0.8/21.2    5.6/42.5
1M - 4 threads		1.1/46.3    1.1/46.1    5.9/45.5

Thanks,
Mostafa

Mostafa Saleh (4):
  drivers/iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
  drivers/iommu: Add calls for iommu debug
  drivers/iommu-debug: Track IOMMU pages
  drivers/iommu-debug: Check state of mapped/unmapped kernel memory

 .../admin-guide/kernel-parameters.txt         |   6 +
 drivers/iommu/Kconfig                         |  14 ++
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/iommu-debug.c                   | 160 ++++++++++++++++++
 drivers/iommu/iommu.c                         |  21 ++-
 include/linux/iommu-debug.h                   |  24 +++
 include/linux/mm.h                            |   7 +
 mm/page_ext.c                                 |   4 +
 8 files changed, 235 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/iommu-debug.c
 create mode 100644 include/linux/iommu-debug.h

--=20
2.51.0.618.g983fd99d29-goog


