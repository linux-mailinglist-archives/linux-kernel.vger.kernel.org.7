Return-Path: <linux-kernel+bounces-716548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76110AF87F8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 08:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63293B0B03
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 06:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F18A1DE2DE;
	Fri,  4 Jul 2025 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a3uHT91A"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656B246BA8
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751610393; cv=none; b=PDVzmCI3oYFpmpBq455s+cQ/2MUcT2FbyG9y5+EbQUle0KhGOyLxuJnwLwFNXCQzU0VnHsKUSJD+I/oJgPn6XPK1jXckjQW9XnnybrEcLz0wQ4smNDUL077kVDLTeCrPMThkH6XqIQR7r6u6dBDGN8zy+6dQmx6n7/R2JSfMY2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751610393; c=relaxed/simple;
	bh=TqO39hOdZuFrt3Vk4NPBD+GxpccbOwHCd5B4qz3NG2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izj+synbm4wUVIuWVVFrlh6GwpgglUff7UNocuRHtS4IR7IZkCpkDvKfVF/sovuZDHJySfDZJ6zsltXVAaZJTPSMpcMQD2PLskXsao3MoroZhaAD5msCx5kW0YwEDOpOG3bjU94TEJpPe1T8yDA346t//+7gc2veTAf8dL5Bz5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a3uHT91A; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748d982e97cso691581b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jul 2025 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751610390; x=1752215190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtAMrec9bYb31s5/Huy8ScC44Y0MeGNii8Ny4beAYaA=;
        b=a3uHT91ASzcIngTp4XE7hZOzPz5w7PXJb57+8D9Nc6pPCp85N4OGLdUYCIlJtlcCGI
         /h+/NmHlFlvhQvX/ekcs2zQ0/BYcVblssHKfWEpZCmGdbranK6nxQtxEGi3e7dn1rqYR
         c9IdEYeKnDIc95d9Oo+stAoCIMAye/jWGzO/oDSsjVEQAmKt5liIuMOIAFVqPQkQX4jN
         tAsn79LzPxEUNFolYK6FoyAqvV9t/7tE7Jm66538pCX0eb65j/P7NINgBaPjBjgdRym2
         TBu6p3cosUOJeL3X5LyAYhEVTDfIuXJp9YJLMAz4mZC76n2O786vzEAYPkiCThSUvi4Y
         5eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751610390; x=1752215190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtAMrec9bYb31s5/Huy8ScC44Y0MeGNii8Ny4beAYaA=;
        b=GkMS/3kTfDn9W4DAnNmemDF1jptLFlz8X02g/hdHTV0Q0ZdzH5wh9G63Q6DaFtDKso
         1m+fO0XdSBBj+EVX28ipeXUIAhYyyrSMnHDHosBnM3CLpNAewF01z3YBrtymAAdPyMpW
         pzQj9aaTdlUuO9bDi0DEf3rwGzKPb7dWPP10Gx3XINs9UxGb181E+voBi67QtqedYi3g
         OwY0qWsl/H96dbnQPoG9efsGVP2uC6zRhqa3vGSKG0qOldSRn+ni3PLwkFFPyDmsrAnm
         5Ox2h2h96LuXCtY45fijGXGp4/g+LG/8C57GXVh/z7x1QWmn8cPA9RTAVVNUSxDEYJfA
         R2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWQMtX/haWRMkx4FOPk3kEkynBrYUNCEap3SBCtlYFiz0v1KuZ/GTJv5947eJSqW6GvHMgROkH4RiEPKYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1SehqDosyE9BlmJm4k/+2m0bEJvIikE+rjqoSAkeGzx4Zde6
	KflU8VY2duhA2RFEftUyhhmGcywYrIvR1vgWrdrdBhSs1bMvBwTg8EdehDms5q5sr/PtYih+BeI
	KmKAn
X-Gm-Gg: ASbGncvVatO+x/7z9dPXMROO/s9dQnbD92rRuORK+dUBiBZxKnyJvje1ic6TgoKOgOE
	DJI5dPeKOodxCu69OE155iWKRUbt37rR1cQopMEDp7wHwru4Q5YG5dHUIqH3omU58gYKKNvgR2x
	lNUXAP/zyznFimlaFnnLhOIGFkpo3OylkrGjBOeS5uVRHO6n+8UV8p9epxvm/GR9JIxiIiwkBm8
	c/1Uv8ru65Jv4S1b7aDawySH7EQxFT0B5imThI2UfEBqFU8OEyKtc0tZUuccTvy2Qz1ppFpka4c
	bFUtSlT9/8SF1x7kMUbonyEAzwBSqYirnqu/p2t4gsxLMlrSN8dKWByITVIFasrn3vziBiJsmks
	AHET72tAa91sZ
X-Google-Smtp-Source: AGHT+IFTOzGu3zFWSHTrf4KF59AoRGl/bkuEswL36beEW28ePztb4UqI8rnrlZ/0ccy+thk4y06H6Q==
X-Received: by 2002:a05:6a21:694:b0:201:b65:81ab with SMTP id adf61e73a8af0-225b9f64162mr2679259637.23.1751610389786;
        Thu, 03 Jul 2025 23:26:29 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5f643dsm1183240a12.37.2025.07.03.23.26.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 23:26:29 -0700 (PDT)
From: lizhe.67@bytedance.com
To: alex.williamson@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	peterx@redhat.com,
	jgg@ziepe.ca
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com
Subject: [PATCH v2 0/5] vfio/type1: optimize vfio_pin_pages_remote() and vfio_unpin_pages_remote()
Date: Fri,  4 Jul 2025 14:25:57 +0800
Message-ID: <20250704062602.33500-1-lizhe.67@bytedance.com>
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
 include/linux/mm.h              |  20 ++++++
 2 files changed, 110 insertions(+), 21 deletions(-)

---
Changelogs:

v1->v2:
- Update the performance test results.
- The function num_pages_contiguous() is extracted and placed in a
  separate commit.
- The phrase 'for large folio' has been removed from the patchset title.

v1: https://lore.kernel.org/all/20250630072518.31846-1-lizhe.67@bytedance.com/

-- 
2.20.1


