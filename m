Return-Path: <linux-kernel+bounces-897355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D270C52A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CF4F34C87F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D22777FD;
	Wed, 12 Nov 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fuw2lKM6"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C05A265609
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956733; cv=none; b=fPbTbPlmXL8E6/tMlAuXM/TFW1zaj0yPEhiM3XBmmhJFq7965BJ1CNcSetAgDGDGPR4YGkAh1JRJcDLaIbqkIGzwWqg94FDCFcYJEsDIK+3SID7B6hFKS8RmML5Zkh/7Bh+KK6QhViW1TpI6AitZKyEV2p93okxrH497i7P6iYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956733; c=relaxed/simple;
	bh=4gTu62Cbo/85Ca8gee18I0As80cWfB9FOIdzXKqVpRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hd0EV1iV52Rsc6Pr3tkfLXv9Jj5PuQSB9F5ViSuQ/EqcLtXne1OQSEJ9NKVOJySzzGVEAtZh0wAIWx/5tNlhN/RuGw6ABVOGjJNm/C7FKqAF4eGoN5DbTd8OR5X7m5mWYDOFE137yUuAlc73CxIykqTXHmt7jRzZFHakSOimf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fuw2lKM6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477442b1de0so6304155e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762956730; x=1763561530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tI75hDbouZIETMFT8ke2RFFEcLU/TsScHe/NrPN9qMM=;
        b=Fuw2lKM6RluMC7ekY+j1yNwqIqsZ2np8giOXCRNC1d2NfUzW2ugs6MbFO1S8uCWJ7z
         hMDPbA/Z1dF+Sgj0IljblfCfZDqQjPTggO4WT6NM2PSUkDuOYAht81B0D33tQPCj+kRk
         Mnn2ZxMHy6s+OwaX61dpg2pznymwtXng6lec74U87QAElled5xvlz3K7uC7k59qKqB1s
         nOqf1CxX1s4GkSv8JaSlR2hRQk5yjVWtPelorQKA0dl/QXCqs94bI7Fj6tEdYHO6IZs8
         3sSitYR9V2lAmxWWa2qlBGcRN2TmIxxr6/tMbDIo6CUnnEpDtQUoDYoHaazz+sNDcvpv
         5eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956730; x=1763561530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI75hDbouZIETMFT8ke2RFFEcLU/TsScHe/NrPN9qMM=;
        b=dnphUvcnE/UxKpNbeZyI27y7t+i9ejPS5IawUXVnokYCAZFP7I4crBRhwCEegGXUUX
         EHYeJdC0SFBO2MZPG7Lo8pSTZzt+JObY/Wr3EEv3Xu4XyAaqITLUiQsJGbJm/L7LlPJl
         ZkFiF0FsFXnW7Cp9Syt6nsk2kX0cUUHzZqlD3PX5covX8GKxJKDyLijGxWzygUoWQt2y
         W0oWlx7yV0kiLwhnjxHv4dwjDn719OJD+dcgfenSZR8ZyojjxxbAAw3doBWsg83mnUaH
         U1uETwygc5qPmFTlk5121caVVRL0rQyhqbBUQwBSPPDGW3NS4OgeZm5FZyv5i5GSEv4u
         5ZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUhEkJco7M+owlCcbTEChQua3IH7yPRP2uvH4jIclnEqkzHQ3t6j6Kz745JWQkpoYpT2gbLUGoNxum67w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRfxk0nczmomp4d+PvRcxnXL/veqDVAECdrwxDMYn7Tsn+oP37
	9b1JaTmu3RFoquXtSPjDPtH5YKdEsXyrjdSFATPvtXYhp7JB8wUOEzE4
X-Gm-Gg: ASbGncsEOq2yVKRmrZuOV8yjCBfdFt5owGbX1OSvw1qp44W+5vZluOxfd9cd7yfEtbZ
	Yr3VHQvJHcsFJItQwpPJSzjrtGGi08t4wZ8J+pLzC5ro9Z+HrFTPvj3rFBr5WRxKTW4gB0Q9zgS
	K1Nswp6QcvLcg7OPuvTeLuyNf4Hb6Re9wUtpV+n9qsyfTtCb2sqDi8M6sPv1RBEd2YoK+TnfUMF
	yyfu2qpapgbC6id8Hw8n1SAGCWDA9CNEgZ6/Fm8pTQ+1i4D3a7zc4DEkoc1HCY+al7LGpUzR62w
	uxEY/ZNQ+POcPtlZ7L+aWimlSuR2nudv8IVSAf07duayyop0e5kVkjVv7sFV/aLMuIvTwlfjTK/
	2mQT7L14sgRSi6yKUwLm+kc3BHWvo7pzvsjlJfPlU2xCSUGJ9x9H36+7xk+0DUegpvZB5WVxxVr
	bYeUsH4/kLEYvq
X-Google-Smtp-Source: AGHT+IGyXbTaO+xgr/SsYmGbnGDHZeIma9mt9kzGgq8EkGWGngWs1vXcu5nKfKxkP0snMbzheV5Niw==
X-Received: by 2002:a05:600c:3511:b0:477:54cd:2021 with SMTP id 5b1f17b1804b1-47787041346mr31763365e9.8.1762956730247;
        Wed, 12 Nov 2025 06:12:10 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2b08a91esm28303603f8f.2.2025.11.12.06.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:12:09 -0800 (PST)
From: Paul Houssel <paulhoussel2@gmail.com>
X-Google-Original-From: Paul Houssel <paul.houssel@orange.com>
To: Paul Houssel <paulhoussel2@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>,
	Ouail Derghal <ouail.derghal@imt-atlantique.fr>,
	Guilhem Jazeron <guilhem.jazeron@inria.fr>,
	Ludovic Paillat <ludovic.paillat@inria.fr>,
	Robin Theveniaut <robin.theveniaut@irit.fr>,
	Tristan d'Audibert <tristan.daudibert@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Houssel <paul.houssel@orange.com>
Subject: [PATCH v2 0/2] libbpf: fix BTF dedup to support recursive typedef
Date: Wed, 12 Nov 2025 15:11:32 +0100
Message-ID: <cover.1762956564.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
Podman) due to recursive type definitions that create reference loops
not representable in C. These recursive typedefs trigger a failure in
the BTF deduplication algorithm.

This patch extends btf_dedup_struct_types() to properly handle potential
recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
handled for BTF_KIND_STRUCT. This allows pahole to successfully
generate BTF for Go binaries using recursive types without impacting
existing C-based workflows.

Changes in v2:
  1. Patch 1: Refactored code to prevent copying existing logic. Instead of
  adding a new function () we modify the existing btf_dedup_struct_type()
  function to handle the BTF_KIND_TYPEDEF case. Calls to btf_hash_struct()
  and btf_shallow_equal_struct() are replaced with calls to functions that
  select btf_hash_struct() / btf_hash_typedef() based on the type.
  2. Patch 2: Added tests

v1: https://lore.kernel.org/lkml/20251107153408.159342-1-paulhoussel2@gmail.com/

Paul Houssel (2):
  libbpf: fix BTF dedup to support recursive typedef definitions
  selftests/bpf: add BTF dedup tests for recursive typedef definitions

 tools/lib/bpf/btf.c                          | 59 +++++++++++++++----
 tools/testing/selftests/bpf/prog_tests/btf.c | 61 ++++++++++++++++++++
 2 files changed, 110 insertions(+), 10 deletions(-)

-- 
2.51.0


