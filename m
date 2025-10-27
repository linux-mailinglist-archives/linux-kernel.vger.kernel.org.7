Return-Path: <linux-kernel+bounces-871739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C42DC0E380
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 106BB4FB977
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BCC30594F;
	Mon, 27 Oct 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKtQ3kaU"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6BE231A23
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573274; cv=none; b=e5M9bYTg4DgwVVtelR8Rgs15B7DWULYiwY2SgFVU+YNhqvhYw49CABY58votcA0P/+3zTVa7PtWqZytid/7xk8O78bXsNRsrs30UALiQLxB9sO1DgFrlm4gpNRFR/IOEZuB3QFoB96LM3PHp3jpnEkLQnlLvQSGa3OXC4UcN+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573274; c=relaxed/simple;
	bh=9dUg+cyLNhN9BTpI9ArrVpEOGS9W0/szZDF7RkM1sjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o9DaTpMnqX2RxZ9D17ysN0hOYM7J9XNQg3Mx7um6bCBS9usUK1R3q5rSp4NmJBKBGDtL/Te4SnIiA65KO8lXYATMLXxuKA6yU17x2TbNeSAxfCe8DYTza/ktQWMIO9xgd1uP6/IVj5U/ahIP/sboKB9Tmh0iy9rhf6d9UPlz+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKtQ3kaU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33c4252c3c5so4380323a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761573272; x=1762178072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f03KuUA7432J8JNmY+1PvZsiGlTGWgolhZe60JrC/gE=;
        b=aKtQ3kaUk9fW0EYHv0bj9LF0RiY5hcmmPgblTHNURQdggI+Avon3vSUddywTwUb6ZH
         sDW4JCm1MNZ9x6QbuKKh+4J0qKSDk6Ara9bq2Tmhlq3P8xyU6zNx5Pkla/n53VmHPE+a
         grAkvVwFCt85F+f8jcLi9GRnx3OfFzpllgQgkZrvsQf0CV8X+eOiRJR2ZUh/6uyAc3Am
         Q6HcoU0WEg4eIggPxUUKTHSt5BSGgDkc+I4jqM7DOOjz5juwTkiWSls0xstBc7zLFZBi
         XrIxJgkIY8oFLR763qCMzOgWS+gdYLaNmT2S04KzCuqs/lNXeTraeaV/843tenxga1YN
         YzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761573272; x=1762178072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f03KuUA7432J8JNmY+1PvZsiGlTGWgolhZe60JrC/gE=;
        b=WYFgoLGcXqsQ81bStJ3BuucM8xoAOGQhwfP5O8+KQAa2gwtb4p3F2Vu8Hjfy23J0hS
         2Hh68bgld5SZKTIZ0yPWgJ30c3264ATZDYflYvACQVb5h9fzCgTCZ2W4ZpUPwsZ3kDsZ
         r+zieVVUB6RYalaxJ+/EyCbJD/6sI7y9HJhIg7sKA45WODWI9AQcDv2Eb07ktCtdjyez
         DbPYg3Xu7Iz1NjqUUrlD+FYNuCuTl5cvMD8WATqarhi2oglW1FCBF1Yguf6eWG3tbB8e
         U5cHC8tXuXlANeZS1vydc28ayTcfkQ697KgOFb1m0WqOlralMJL2RIgrr5Ts+rTS3x1b
         W3Hw==
X-Gm-Message-State: AOJu0YxM9ciFzrI5JZ/mbpp+JHh4HfnfkeqhDuW6fyRFy/apsN1zehI5
	l3Ik4G4ObAySKnrzDM6zNbMf/SjuRF+BQlPLmeEwajzCQ3H6d9BBTXkdm93n5Z20
X-Gm-Gg: ASbGncsyyRVaeBRW6w6zjSBcQm9ZitWCUYNNyC2uh+T4iCh4shy38vEumBttjCZu1+8
	U17Mo/DzZ7AmYJ1lBpcZXCoCcLHAubbncj1iE5B7nwrJlt72VuGXcBUSNZfILg5KpqalVaAWHpn
	9QWRVo3BRgghrzgXq8B394Q6Bs7XQQVxS/wfkETPXiLVSJrT22JcsNagUeohNg9AunCaDpkCQJq
	BlrYWyoZ6DrMs0wrJvczWgNVZezS81h4cwhdL+AUAy0SiwcxmzQx3/v0B/DTV7ZJAToGIhvOIWA
	fOeO+01KHL6q7+qL8adCXDsVDkJxlAi2slDUmEYmnuWSHzUZXLrNwumeB4TrTL1N746RGZxOXvO
	+0asTXv0qkHK354kQKlmXCMlRQ2hQMHxLdWbVeImaSKXfBtHspXG2mgT+Ep7PB/RS37Zftvnw8K
	rOmc5rFQcZ0ai6R4oBZZpzJozBUFQ=
X-Google-Smtp-Source: AGHT+IFtvYxCbikSbaZMg1KaUpeSrllaNNeLVSqVHrOb6NH79D4XLDrzdDXs/kaauXcKnz3sC473Qw==
X-Received: by 2002:a17:90b:4c02:b0:32e:3686:830e with SMTP id 98e67ed59e1d1-33fafc1ce07mr19191783a91.23.1761573272413;
        Mon, 27 Oct 2025 06:54:32 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a83csm8574361a91.4.2025.10.27.06.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:54:31 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [RFC PATCH v3 0/3] Significantly Improve BTF Type Lookup Performance
Date: Mon, 27 Oct 2025 21:54:20 +0800
Message-Id: <20251027135423.3098490-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The funcgraph-args feature frequently calls btf_find_by_name_kind(), which
currently uses a linear search algorithm. With large BTF datasets like vmlinux
 (containing over 80,000 named types), this causes significant performance overhead.

This patch series introduces a new libbpf interface btf__permute(), which allows
tools like pahole to sort BTF types by kind and name. After generating a sorted
type ID array, these tools can invoke the new interface to perform in-place BTF
sorting. During BTF parsing, btf_check_sorted() verifies whether the types are
sorted.

Performance testing shows dramatic improvement after sorting by kind and name, as
demonstrated below:

# echo 1 > options/funcgraph-args
# echo function_graph > current_tracer

Before:
# time cat trace | wc -l
58098

real    0m7.514s
user    0m0.010s
sys     0m7.374s

After:
# time cat trace | wc -l
58837

real    0m0.371s
user    0m0.000s
sys     0m0.383s

This represents about 20x performance improvement for BTF type lookups.

v2:
https://lore.kernel.org/all/20251020093941.548058-1-dolinux.peng@gmail.com/

v2 -> v3:
- Remove sorting logic from libbpf and provide a generic btf__permute() interface
- Remove the search direction patch since sorted lookup provides sufficient performance
  and changing search order could cause conflicts between BTF and base BTF
- Include btf_sort.c directly in btf.c to reduce function call overhead

Donglin Peng (3):
  btf: implement BTF type sorting for accelerated lookups
  selftests/bpf: add tests for BTF type permutation
  btf: Reuse libbpf code for BTF type sorting verification and binary
    search

 kernel/bpf/btf.c                             |  34 +--
 tools/lib/bpf/btf.c                          | 262 +++++++++++++++++--
 tools/lib/bpf/btf.h                          |  17 ++
 tools/lib/bpf/btf_sort.c                     | 174 ++++++++++++
 tools/lib/bpf/btf_sort.h                     |  11 +
 tools/lib/bpf/libbpf.map                     |   6 +
 tools/lib/bpf/libbpf_version.h               |   2 +-
 tools/testing/selftests/bpf/prog_tests/btf.c | 109 ++++++--
 8 files changed, 559 insertions(+), 56 deletions(-)
 create mode 100644 tools/lib/bpf/btf_sort.c
 create mode 100644 tools/lib/bpf/btf_sort.h

-- 
2.34.1


