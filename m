Return-Path: <linux-kernel+bounces-888573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE34C3B3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBB142644C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB9F30C636;
	Thu,  6 Nov 2025 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLn4Xw07"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6B30EF98
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435219; cv=none; b=DLeXDzECCUNJzKmeHOluiwd3pQ+g7PcKhOSb7958S2mvjjrUWmzu+rXxueqekzxLs/Wc0uAfzsC/Qi1foWyIldqMFJuN0ZnpUXwz+4K6W7F9tbLHn1kaBWDuoefpfGqO8rT8bnBVSbQ52Ia8oHuhTZARXJL+TZBuU7e8T7y/n8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435219; c=relaxed/simple;
	bh=tv3AVTVmIt2vysAhe5TEh7aE7ZY74H9lF+4YJG18wYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=etnUd6LOZVJsqmE+Uln9a/q5gEthlXKf2CnARLzvSHOx0Zsodj2LGpZT7N9/2072aOlIIMDt9A2v5ZoX2vAJeiMXAgD6vqM9V/0xjKIpPLvxXJ41aijLynFyU9kNH6vTtJdZi+za0rDt3pQBTQPPwlGSdYcfW76wuwZgbmqpEPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLn4Xw07; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso898165a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435217; x=1763040017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1r7+S0h8xTWpDvAe8XotCuljIjCSiWr7Nuoeij6IPg=;
        b=YLn4Xw075bMpoI5fTw4rGpn5pgYiqzaG2Gmqf+XzXqxpnsB2WEnljobPxzpN2MsKuW
         oSv1p4P3ssKToZ4Luy9vWTdbzxFIO+DnpORPVn+zfoIkbnlKuIMdoRqyLE4/VGxY4xPh
         SN+c3mwrcBFC3u8tudjgBYX16sOm3OjKvDpEXPsDPW1TvyEU/gVKJxbG6YOt+BmGwfze
         hl2gwgK8w/dzrsRDa1mE6Zgg/Je5CCifKXzYJRA0KBgTuiw3sycsacdaZQqoVF1M0+JO
         KIXuujMng4+lbQGdwUQJngWmcIpr7bugf3SndOCupnKdoajnzJfo73FV3ILimzIjB1u+
         HdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435217; x=1763040017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1r7+S0h8xTWpDvAe8XotCuljIjCSiWr7Nuoeij6IPg=;
        b=O8JQFb4QCNmPppy4Hec3E0SabbT3avyuf32BZjI/NLnl+o693YVfbtgOAaj2JURNFl
         TpMtPk5emVUsuD0Bnvl0NtChK0HVquyteM53dDIrsdig2SZeP8WfRoJrCK/NEkhFOUYh
         GCTGXe5c4vf2kd6Lq7H513cnU8Eov3B6sZN2HmVm+jsddCEWrVDFA65e+H+khtIbDI8S
         1YYWMRm3jZ8N8ZFC2BrwsR6iSTKPESlUWhWlDcBpOeYJ0Vf0Jy1QQTPnkIsB6xRjZGk/
         fOYp7ezUOGN8adhE6h8eEbKCnZhizM2dehW/DPd/5CfP5pXD7gOzlHIfWDW9Qox1grci
         94/g==
X-Forwarded-Encrypted: i=1; AJvYcCUhdh7NQna9+mlIEqAnFmuWhpROjTgmXYECQDh4SbSFpPjmNnTF58rpruaLeF6sDsaMo13WNTClRa6yKBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQt9lwJmmpDDSeES9jDlhcS2TandhXFRZ1iEEis+oNqmPvkjd
	3EuRRdcZUWQzc9MMVPV+cYk3HBMQZoy7XjBT7amsgzN8YxhCRmdx5OSjULwAf9dYkdk=
X-Gm-Gg: ASbGnctq0Yd8IS7ITZKzDPd8jVq4Zby6xXYCvsTNsr5qbgxshdfbjejAArht8o+hEnn
	zAH10BwYVQwJcXL/vhAwqDDqjX0DrtMZ1+3OFrIymT3CfK0a1NUvofPwG+7KBJsAx/u7Wq2Qdd/
	0oWrJbe+IXQFWYrLH0Y4E3ka83jvYUGMnxOCyWYwqueB4SnIcZ+Jd7La/99USMArdD6eCiQCiik
	Zv62enjxxqKSVL7rbtEGLGvu0XyZrAuaislTXp4bfellugaBq22HbS9Sdmh5XPI27oIGwQRKIp8
	EUwjaQcGr2PHmS6tDKFDxCFCK02WdEn50FBv5j4jDmAtarC9hI+EthHU0JbAh29Bj73TKe7VErs
	FHsQ11tmAyGQDd7U/S9DkkFoyLZ7nFoO037L4QSQXr4LGD6kIXfXhwpylD1KcXlhy9Iviwm3h5a
	7oqSM0xAqzk4lZCzbM
X-Google-Smtp-Source: AGHT+IFpaP6rgxqF8/pAWzB5X0NgBhsVtsp7Okxs1TLVp4Q0wHxl4Ka8sazuzSDOhtnd7I+ifYyDzg==
X-Received: by 2002:a17:90b:1844:b0:32d:e780:e9d5 with SMTP id 98e67ed59e1d1-341a6db6c07mr7878274a91.22.1762435216708;
        Thu, 06 Nov 2025 05:20:16 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d3e0b0b2sm1914869a91.21.2025.11.06.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:20:15 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH v5 0/7] BTF performance optimizations with permutation and binary search
Date: Thu,  6 Nov 2025 21:19:49 +0800
Message-Id: <20251106131956.1222864-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces significant performance improvements (~1785x) for BTF
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
| Condition          | Lookup Time | Improvement  |
|--------------------|-------------|--------------|
| Unsorted (Linear)  | 16,666.5 ms | Baseline     |
| Sorted (Binary)    |      9.3 ms | 1785x faster |

Analysis:
The binary search implementation reduces lookup time from 16.7 seconds to 9.3 milliseconds,
achieving a **1785x** speedup for large-scale type queries.

## Changelog
v5:
- Refactor binary search implementation for improved efficiency
  (Thanks to Andrii and Eduard)
- Extend btf__permute interface with 'ids_sz' parameter to support
  type dropping feature (suggested by Andrii). Plan subsequent reimplementation of
  id_map version for comparative analysis with current sequence interface
- Add comprehensive test coverage for type dropping functionality
- Enhance function comment clarity and accuracy

v4:
https://lore.kernel.org/all/20251104134033.344807-1-dolinux.peng@gmail.com/
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

 kernel/bpf/btf.c                              | 181 ++++++-
 tools/lib/bpf/btf.c                           | 449 +++++++++++++++---
 tools/lib/bpf/btf.h                           |  31 ++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_permute.c    | 279 +++++++++++
 5 files changed, 878 insertions(+), 63 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

-- 
2.34.1


