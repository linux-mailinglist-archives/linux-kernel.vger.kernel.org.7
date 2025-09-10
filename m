Return-Path: <linux-kernel+bounces-811135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683AFB524D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B905607D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1D6277CA5;
	Wed, 10 Sep 2025 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrAYg4Qv"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE25324C676
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757548660; cv=none; b=rFl/cDvHx3frBksjkL+9fhDq06IjBwHG0A9Fp7rfoMjBPzB6MJYf1OLba51QQRwK2Zb3RYdRzsY8OfRCAYXOEKA8Z9C1ub4KScAkk8KXv/owJi4ZUfSBLBMvDXbjQpFF1LabFv3FWjJIyFll+T1dhOzIDqmda195BZ4FWT2fqgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757548660; c=relaxed/simple;
	bh=qz9+9gHyijTiX3GbxpmHDb0ux6mjGKJ86qbTMBx8j/Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qM+3lZma5Gf/EFI7MqwDysH9FVNAVhYn+ZrbeStaf3QV8k50zbugZKylRwiGrCh+wE7PENexXhD4DbieYQkdDD4/Sb01wLFE9AqS5FzxbDuqhIboGZB9fwEHtdYa1vdIOdqm5Xxf1Aq3gFV1ilbGO5alybLl4o5NWijV3RpSawA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SrAYg4Qv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24b2336e513so1251205ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757548658; x=1758153458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U3W9KmAhRtbP+yDFjRzq6OkAwTzphYT+gRDr5EFEvmo=;
        b=SrAYg4QvFYM+he9ouFkPzm5P9k4lIagVSbjAgHzPRfVnLx/i/RurR4KmF9Mv6TGHMy
         ZkFI3gisTue6CDsqHnU9KLFZzusTML3QI+WH6vx3CGNRYQPw3DU7aomy9hEC7V9NfIJK
         zCgoo2zwRJBzDyB6ipuRnpMWN47hUabmflHkpezYOQnAUgHCmdJF4Zr4o/ib6KMRCOav
         UsjaVBjYaia5K10KJoeOrGp7Bi3x458sZ1aK3+2eYJ7IPqmEdLPDt0PDsHVdV/gr/zZZ
         VlgCfc3qhTcKQTcRKss8G07OCQFvPBuRIFeXE3hGaN0E9jRx9Mf6r4RnqZC8cb/Kxakc
         6/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757548658; x=1758153458;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3W9KmAhRtbP+yDFjRzq6OkAwTzphYT+gRDr5EFEvmo=;
        b=GmW/bKMp0dXcP0lQ4rgFcD75fpZjEhzpueR8qvDjlWEDPpSztv8CdL3iFjZlJv6a7G
         V06vaNbxshpgVdFgPb4/Ewou6zdc+KBkzA/dK/ut4x1+o2bTTi3wg9iYmbWwkhwXfLVD
         WUxNzRMl2c/EkLG8f8blqCyxCKUfLp2eIHHEE+CyhjWDT1+EDOUaA3SUYzlhoQ28S3Dq
         Qc/3oV8VaGPw0piVm8fUU/mnjeCwIAevxHvbPtDI23leW7TVrItb8Bn9DWUzGRDu+PVQ
         rz2TiTxv90512uhZXaGOz9eA2GP0YYMAHB8MocQkhQm9epqlChbVYLggybgQm1T7lT3T
         Ve0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWk0MOqBDvCdy8fMNPrFWt7wzH0Ozy5ZuUI4YFx84jZI85gcJYmIBGfQwKaXIFPTtKpuy5nQNlOTnq/GXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfHDfSAok20ImrPBiNYirMPbEEuI+e3XLdkdZYfreaLODAJEfI
	2InTdvdcAJwBwSZT3EA7ie3ziXjr+tovrtkATC7hkL7hwj6gm8g/mmzc1L4ePppAGdet1aWrY9B
	ladjAHvt3CsV/UQ==
X-Google-Smtp-Source: AGHT+IFUIKZ6YAAu0ecY4R9EKyV2/HbtOzWNpGLUTDE+qaL3FL5lUcCQHJs46ff3j8+VKUmaZpk3coRYbtSDEw==
X-Received: from plyw24.prod.google.com ([2002:a17:902:d718:b0:253:4280:9f31])
 (user=kinseyho job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d48c:b0:250:5ff5:3f4b with SMTP id d9443c01a7336-2516fdc77a2mr262461415ad.15.1757548657920;
 Wed, 10 Sep 2025 16:57:37 -0700 (PDT)
Date: Wed, 10 Sep 2025 16:51:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250910235121.2544928-1-kinseyho@google.com>
Subject: [RFC PATCH v2 0/2] mm: multi-gen LRU scanning for page promotion
From: Kinsey Ho <kinseyho@google.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dave.hansen@intel.com, gourry@gourry.net, 
	hannes@cmpxchg.org, mgorman@techsingularity.net, mingo@redhat.com, 
	peterz@infradead.org, raghavendra.kt@amd.com, riel@surriel.com, 
	rientjes@google.com, sj@kernel.org, weixugc@google.com, willy@infradead.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net, 
	nifan.cxl@gmail.com, xuezhengchu@huawei.com, yiannis@zptcorp.com, 
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com, 
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com, 
	balbirs@nvidia.com, alok.rathore@samsung.com, lorenzo.stoakes@oracle.com, 
	axelrasmussen@google.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev
Content-Type: text/plain; charset="UTF-8"

This patch series introduces a software-based approach to identifying
hot pages for promotion in tiered memory systems, particularly those
leveraging CXL-attached memory, by utilizing the Multi-Generational
LRU (MGLRU) framework. This method is designed to complement
hardware-based hotness detection mechanisms like Intel PMU sampling, AMD
IBS, or dedicated CXL memory monitoring units, providing a more
comprehensive view of page access patterns, similar to kmmscand [1].

We propose to utilize MGLRU's existing infrastructure to provide hot
page information. A key benefit here is the reuse of the MGLRU page
table walk code, thus avoiding the overhead and duplication of effort
involved in implementing a separate page table scanning mechanism. The
working set reporting proposal [2] also reuses MGLRU's infrastructure,
but focuses on cold page detection. It provides its own aging daemon,
which could additionally provide hot page information by integrating
this proof-of-concept.

This series is based on and relies on [3] as the aggregation and
promotion engine to implement the promotion policies. This is still in
the RFC stage as a proof-of-concept and requires more rigorous testing.

---
v2: Fixed a correctness issue during page table walk, where, on resume,
one page found with the access-bit set was incorrectly not added to the
pghot data structure provided by [3].

v1: https://lore.kernel.org/linux-mm/20250324220301.1273038-1-kinseyho@google.com/
---

[1] [RFC PATCH V3 00/17] mm: slowtier page promotion based on PTE A bit
https://lore.kernel.org/linux-mm/20250814153307.1553061-1-raghavendra.kt@amd.com/

[2] [PATCH v4 0/9] mm: workingset reporting
https://lore.kernel.org/linux-mm/20241127025728.3689245-1-yuanchu@google.com/

[3] [RFC PATCH v2 0/8] mm: Hot page tracking and promotion infrastructure
https://lore.kernel.org/linux-mm/20250910144653.212066-1-bharata@amd.com/

Kinsey Ho (2):
  mm: mglru: generalize page table walk
  mm: klruscand: use mglru scanning for page promotion

 include/linux/mmzone.h |   5 ++
 mm/Kconfig             |   8 ++
 mm/Makefile            |   1 +
 mm/internal.h          |   4 +
 mm/klruscand.c         | 118 +++++++++++++++++++++++++++
 mm/vmscan.c            | 181 +++++++++++++++++++++++++++++++----------
 6 files changed, 272 insertions(+), 45 deletions(-)
 create mode 100644 mm/klruscand.c

-- 
2.51.0.384.g4c02a37b29-goog


