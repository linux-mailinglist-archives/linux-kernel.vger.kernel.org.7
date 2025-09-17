Return-Path: <linux-kernel+bounces-819899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55029B7D084
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89612A7F38
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A952C258ED7;
	Wed, 17 Sep 2025 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGZj9Sj5"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2D165F16
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077432; cv=none; b=S5aS3GKhiicbgChjy2RTYJTZXxPqnO5meBgkjmoZHfGwF/GB88EdJYtnfmg1lEZo1s3ixBRHM/0ImwwER9DfOIAoQjJ+USz13X3vxhw5n7BfVzZKKqeu1k9EVlQkgyQFUGe88p8jUc6tCTuUSNz5ybqjUw3ikTCjzqVqgDsqEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077432; c=relaxed/simple;
	bh=G3g3cnv6PVmlCRdWuXcYL+JSoJrbey4jSA+m3Ra+bQ0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Kp2uC4k7VUAtoYnD9Ff2ql7Grk7IvyYUSKIIXF+5W3ehrG2evigZtA0qHICy58qGo7Ip/M9UEz9SgMk/MXmBwaggTYyz3dCJuvFY8HgX14J7xj2Rs4/6mYDK8Jjmahr+o7OKEo04aA+ePjp9r6UXVHYlZBTFOLiZM++MAei0tgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGZj9Sj5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b54dd0b6abaso2064837a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758077430; x=1758682230; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QvfS0lbIl6nsb5SOfYP9Zx2VfhCPX5J5Iuo96LcGehc=;
        b=zGZj9Sj59dNokeiIomq5SG3zKl3RQd43F09nkgq5zyZx0OtcDwYprwM2RM/fmrXlwK
         l/i5HlYZ0flbw8HRtCjTpe5w0FgiSMlyRfslTDRcOimZvIJiCcrlR04XWDkhjdJZfdg6
         MMKf+LJk0gKkCY6VafOUCzFyllcMOAP0l7q5bojtA8xC/DLBgtn0+jcuFpbeEkpU+ybO
         C6ZuKD7os6OjlPwu8BDo8GBfU18km2M/IK1NKwG/TFv5fM12m/0eEH5107lZ0433UV7p
         rV5ltiYz8WjdKDi2l++MlCebvK85VaRsJEnIQwxMEwIRHFJnnzAmli7CuN7pDqh6ZMRZ
         k/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077430; x=1758682230;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvfS0lbIl6nsb5SOfYP9Zx2VfhCPX5J5Iuo96LcGehc=;
        b=CriaSfwB6CyfBTqgya52BeRh/xJ0ZgDONjlB3MbaNJ+9yWDolsSXVFn5Ie9kHEXFMN
         muvsPrSCXURMOawF64CpTfHCbt67cVDHa/pstObE5dEBeBbkHxqoOul80teByFtrl6kL
         F3fk/DWMR1WjakZ/zAcnSjn/YoVnDNaEtvA7K0hQQ5uu3LwZ7Gu8Ik4UqXD8jMu16kak
         qUYd8pbIWlkt1K8EeR93c1gtFm/aDjDQjspa9SRQ7SmTAKNd6w1NyZMk61G7juCEm0rc
         3Scbsxczak4eTVVV/G6x2UDuh9P3+TnfYq/ycQKK5E74t5OTSG2RqjsNmtPPTuTygaW5
         XgTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSS4oDH9XrlFY+yHTYhKhBRIc1FMwBBMbsJ7gAX747Wxre8/98qvxCg9Hv6F3hwFXnf+KOcgo6F2j3sZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRBnfDU+PK/I7ASiGsu9m39iMlyhWdVUAh2fXkbGXIRB7xeHPR
	1LxDgJDSWKqmaXKuau2xjmlj7jEzfCdxCO/j2Elua3FNgu8dP3CSarPg9DBLNNx1gOnhjTM3/kn
	GNHaJ/iLe2fBymQ==
X-Google-Smtp-Source: AGHT+IFsWd78Zl+0JpPchoff8A4M5Kb6apJ4WgYWtl1LRPz8f4ijmhz+IeY75j5Bme4PyrExdVwrt2ZA8lDSow==
X-Received: from plkv16.prod.google.com ([2002:a17:903:1a30:b0:267:ea8a:35da])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:22c9:b0:250:1c22:e7b with SMTP id d9443c01a7336-26813aeee86mr8191395ad.43.1758077429969;
 Tue, 16 Sep 2025 19:50:29 -0700 (PDT)
Date: Tue, 16 Sep 2025 19:50:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917025019.1585041-1-jasonmiu@google.com>
Subject: [RFC v1 0/4] Make KHO Stateless
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, 
	Joel Granados <joel.granados@kernel.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

This series transitions KHO from an xarray-based metadata tracking
system with serialization to using page table like data structures
that can be passed directly to the next kernel.

The key motivations for this change are to:
- Eliminate the need for data serialization before kexec.
- Remove the former KHO state machine by deprecating the finalize
  and abort states.
- Pass preservation metadata more directly to the next kernel via the FDT.

The new approach uses a per-order page table structure (kho_order_table,
kho_page_table, kho_bitmap_table) to mark preserved pages. The physical
address of the root `kho_order_table` is passed in the FDT, allowing the
next kernel to reconstruct the preserved memory map.

The series includes the following changes:
1.  Introduce the KHO page table data structures.
2.  Adopt the KHO page tables, remove the xarray-based tracking and
    the serialization/finalization code.
3.  Update memblock to use direct KHO API calls, and adjust KHO FDT
    completion timing.
4.  Remove the KHO notifier system infrastructure.
        

Jason Miu (4):
  kho: Introduce KHO page table data structures
  kho: Adopt KHO page tables and remove serialization
  memblock: Remove KHO notifier usage
  kho: Remove notifier system infrastructure

 include/linux/kexec_handover.h |  44 +-
 kernel/kexec_core.c            |   4 +
 kernel/kexec_handover.c        | 821 ++++++++++++++++-----------------
 kernel/kexec_internal.h        |   2 +
 mm/memblock.c                  |  46 +-
 5 files changed, 404 insertions(+), 513 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog


