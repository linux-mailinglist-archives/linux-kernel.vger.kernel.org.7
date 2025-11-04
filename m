Return-Path: <linux-kernel+bounces-884830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0F0C31451
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D018461151
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48056328B65;
	Tue,  4 Nov 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9BPDFR7"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5C2F9D82
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263642; cv=none; b=BUroGpZsPzH4Up6HtaRxmQ5mM2XxNLXMudKDGp0tioFcZ4s3YjxiOZHo58RAdhRiXWRY0231GZP7o5dE681b4tfBecAceFQ8ck9b4YiSWVUGNoUWfkPeX7sb/f1ZX3l1ntC6t9jqWBLANrQf5TXVroCbzRipXKDItZcXkaCji7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263642; c=relaxed/simple;
	bh=ZhjBl+UBjHacxZXf4ZcMtkjefM4tVboDQltonLi33ow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DBELw65kUFVNDyvAn/RCu3ouTG48cnvkN/vyvq1QPPWSu3mwgIxG67n00dvsq+MJsHilGHaRzXjWHHlFZ3DfRp1crwamXsSYovNZCMV4+alwUt6GmtNjSmhGJP8KLREQ8pyKHs14u4k8AIrFZkEJ1wDaT0jq47zEmWfyKbV4W60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9BPDFR7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34088fbd65aso4660199a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263640; x=1762868440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SF3OZOyoceOibm03NP3Mih92U39NdJi9E+pazzkoq2c=;
        b=G9BPDFR7bKNidfzIsfafycLyO2S7Oko6O+NIfydCu6jaOPEFXaC6rRjCYCBFWtHvG6
         6wDb4aZel0BCAfWJrxoIVbC2B7gMphG1fi4wNfeb7nYwFXMaw6/I61AOBCYdeuy6NcNA
         Z1IqG7pBuwGevZuJADP8qttDaT5Mw7y1WuGXSOCFvKu/1WCMzQox53fdjRKMmHUvTBY3
         BIWgEGnWJjpQqjuEHgExrnNfd1XLU/cnOv93MTbH7gp3UNEmqd9MAeseMCTGyGfpPUZ/
         rhUMDPYviO85eONOhaAW9J4JJpzBt7UISgZSKXWxHob+l1y0uJWkSSD5aFsgSGmKxmyY
         rBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263640; x=1762868440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SF3OZOyoceOibm03NP3Mih92U39NdJi9E+pazzkoq2c=;
        b=RwqyzR03PTnayF9+TYpwfCFU586PrImyUPasgnoTfri8qngycEV6ZLlHOrO6/iRiJt
         zLKP2SnRUy8AGAPDdgenSSgB1SKVeyJvYsYG7/fNlCzjAvuwEIXQc8sl0NBD2hCpvhP2
         NopiUQB5VwKvMWVvef/joldl3KaBPx3KervHpeY52jMP0S5Lj1je2RvnPO8KG7QObcG8
         IKQkpxhqqi9kevYrtgJ5ADcHtAQ4sLPTb6z3ND5rWeBw7gAaSAr2yWIlx+BlziJp/TKx
         x4w9ajJpc4VxIK+PQdW52qbrHNQHeAIyuy6Vk79SP917F176/APw8dwxZYMEHiKRSP/h
         sF2g==
X-Gm-Message-State: AOJu0YxWTkiNO0MHTPjohZ53ALjmoT0+81PmreZe9RXOkqs5ZY+fwQwf
	lFTT7DkCMkRmRKDUJMYFrxyD/FcB361/rVFUuUNUmaMuvTSgpyGaAifs
X-Gm-Gg: ASbGnctrtOiKsRKIZ7NLSOzXr15I13F9LwGFuGkE52a4JYZNUc5XFMNBIGHkCB1K74F
	Ji46hKTSYTRTC30bYbQGH4zXAiop4IEXd6wRLzty1j2R/7qPlwxcBd6bcgm2pH+dIJvbHKhgGco
	9EQve0J4B5GCsU9d3aDmnoShMotx3ZRK+lAMOQw+Cqkyj9XMOVxE2MIkq6Cr5wuvcoSJqhdnZiy
	Wrc3Vas9er4RIfSvwAwHCaz+XLhfJGn55aqFiCcdxlNqYIj1/9Z97a6hWRPBYxjTktzNWiQVTnZ
	BN9UH339NbuCn+sfEbpJHZQzB44ovHJUs4u0hgyzzi/Vbus1FXpCG1gayZKlrjUE2+1YwYTpwe1
	72F/Dkc5S92lUxC/UUkPouTAIkEYsipzmLljzYvryeiT//Y+SDxsrmhwxQOLEHgcaAUaGw+hoML
	DPpLtBwfog/YXo/CvC
X-Google-Smtp-Source: AGHT+IHkPgcIAhbCrLMveJbJmdTx49ld7p3N4G/OD0oa66daars4gmXhdApmDvDeB8mUNmklnMQj7A==
X-Received: by 2002:a17:90b:1dc6:b0:33b:b020:597a with SMTP id 98e67ed59e1d1-34082f051b4mr21249866a91.0.1762263640230;
        Tue, 04 Nov 2025 05:40:40 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm2499238a12.31.2025.11.04.05.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:40:39 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [RFC PATCH v4 0/7] libbpf: BTF performance optimizations with permutation and binary search
Date: Tue,  4 Nov 2025 21:40:26 +0800
Message-Id: <20251104134033.344807-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces significant performance improvements for BTF
type lookups by implementing type permutation and binary search optimizations.

## Overview

The series addresses the performance limitations of linear search in large
BTF instances by:

1. Adding BTF permutation support - Allows rearranging BTF types
2. Implementing binary search optimization - Dramatically improves lookup
   performance for sorted BTF types

## Key Changes

### Patch 1: libbpf: Extract BTF type remapping logic into helper function
- Refactors existing code to eliminate duplication
- Improves modularity and maintainability
- Prepares foundation for permutation functionality

### Patch 2: libbpf: Add BTF permutation support for type reordering
- Introduces `btf__permute()` API for in-place type rearrangement
- Handles both main BTF and extension data
- Maintains type reference consistency after permutation

### Patch 3: libbpf: Optimize type lookup with binary search for sorted BTF
- Implements binary search algorithm for sorted BTF instances
- Maintains linear search fallback for compatibility
- Significant performance improvement for large BTF with sorted types

### Patch 4: libbpf: Implement lazy sorting validation for binary search optimization
- Adds on-demand sorting verification
- Caches results for efficient repeated lookups

### Patch 5: btf: Optimize type lookup with binary search
- Ports binary search optimization to kernel-side BTF implementation
- Maintains full backward compatibility

### Patch 6: btf: Add lazy sorting validation for binary search
- Implements kernel-side lazy sorting detection
- Mirrors user-space implementation for consistency

### Patch 7: selftests/bpf: Add test cases for btf__permute functionality
- Validates both base BTF and split BTF scenarios

## Performance Impact Analysis

Repo: https://github.com/pengdonglin137/btf_sort_test

### 1. Sorting Validation Overhead
Test Environment: Local KVM virtual machine
Results:
- Total BTF types: 143,467
- Sorting validation time: 1.451 ms

*Note: This represents the maximum observed overhead during initial BTF loading.*

### 2. Lookup Performance Comparison
Test Case: Locate all 58,718 named types in vmlinux BTF
Methodology:
./vmtest.sh -- ./test_progs -t btf_permute/perf -v

Results:
| Condition          | Lookup Time | Improvement |
|--------------------|-------------|-------------|
| Unsorted (Linear)  | 17,282 ms   | Baseline    |
| Sorted (Binary)    | 19 ms       | 909x faster |

Analysis:
The binary search implementation reduces lookup time from 17.3 seconds to 19 milliseconds,
achieving a **909x** speedup for large-scale type queries.

## Changelog
v4:
- Abstracted btf_dedup_remap_types logic into a helper function (suggested by Eduard).
- Removed btf_sort.c and implemented sorting separately for libbpf and kernel (suggested by Andrii).
- Added test cases for both base BTF and split BTF scenarios (suggested by Eduard).
- Added validation for name-only sorting of types (suggested by Andrii)
- Refactored btf__permute implementation to reduce complexity (suggested by Andrii)
- Add doc comments for btf__permute (suggested by Andrii)

v3:
https://lore.kernel.org/all/20251027135423.3098490-1-dolinux.peng@gmail.com/
- Remove sorting logic from libbpf and provide a generic btf__permute() interface (suggested
  by Andrii)
- Omitted the search direction patch to avoid conflicts with base BTF (suggested by Eduard).
- Include btf_sort.c directly in btf.c to reduce function call overhead

v2:
https://lore.kernel.org/all/20251020093941.548058-1-dolinux.peng@gmail.com/
- Moved sorting to the build phase to reduce overhead (suggested by Alexei).
- Integrated sorting into btf_dedup_compact_and_sort_types (suggested by Eduard).
- Added sorting checks during BTF parsing.
- Consolidated common logic into btf_sort.c for sharing (suggested by Alan).

v1:
https://lore.kernel.org/all/20251013131537.1927035-1-dolinux.peng@gmail.com/

Donglin Peng (7):
  libbpf: Extract BTF type remapping logic into helper function
  libbpf: Add BTF permutation support for type reordering
  libbpf: Optimize type lookup with binary search for sorted BTF
  libbpf: Implement lazy sorting validation for binary search
    optimization
  btf: Optimize type lookup with binary search
  btf: Add lazy sorting validation for binary search
  selftests/bpf: Add test cases for btf__permute functionality

 kernel/bpf/btf.c                              | 177 ++++++-
 tools/lib/bpf/btf.c                           | 436 +++++++++++++++---
 tools/lib/bpf/btf.h                           |  34 ++
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_internal.h               |   1 +
 .../selftests/bpf/prog_tests/btf_permute.c    | 142 ++++++
 6 files changed, 728 insertions(+), 63 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

-- 
2.34.1


