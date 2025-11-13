Return-Path: <linux-kernel+bounces-899347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDFBC57760
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6668A4E5CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD922DECA5;
	Thu, 13 Nov 2025 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUkQWyzG"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA9A343D6F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037603; cv=none; b=NiNirNHXN9i5ymBK/2BLOn1c6Wlza0OXn74ViiFPGiNt21nqnlSu3nZss1ouUr5B+zAbUGeEHGXHLjWQwuchJOiQTCfYXJ1hUgxv9UPgptFLabJZpkHBvBTHO2qjxFEAYNC2ll1qouqN5QlAGM9kG5aIH7qZ8ajgxKqJUWoFNWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037603; c=relaxed/simple;
	bh=zPxQZq6swDm7cDZrcHpyHFJLp+QXnuSI6H2xrgOhuug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qN7H2Op/xYv7e+Py8kNnBi4R48AYuBXxzekaLz2QlG1MQWmM9ZwOPKfvoECG1Xx+7J1lGfSPHE8rXmlWnA1C57ZZLwEmExdaGao27OOwrARD3hkEtKgYstI3pHLJnlm2YBAS3Pd8niWqCj5EygqtCGNJd5I6x8HKyAcyV+B92lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUkQWyzG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b312a089fso450099f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763037600; x=1763642400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa4Z5vcyVHYCi6FZLrrSakjhFJDnPUnns7XV2UHv/wQ=;
        b=hUkQWyzG/XrseNZdjDH4Nab5qx84In6X0lgfOmPDZU3bBlwzbyG5X8sZifrjnIUL2q
         ISd/0Cj4gPhEdTzgulajy896RuirBzHWc9Nnf9TBRclb3sXRt5QUa8n+mOqEDCZBOl0V
         2EpQkAqXsPtmb4M4sygfTnSESXsVm1KkZRNwsHtR9BDPJw4aDPGYFUe+4fy1AU/QmCc9
         zvJbfbrjnWJIJQpg7ucj2mfpk/YnZGJav5OT2qTBEZAkCwEryGg4xo1ad9SzEn0c6SeV
         vziz+fA9/mVLhnlMDaNpe/7sDvGaiFJaeI6hrMeip/MDs6GHhDDFCnO/m2tB7QuZqMvA
         mukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763037600; x=1763642400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa4Z5vcyVHYCi6FZLrrSakjhFJDnPUnns7XV2UHv/wQ=;
        b=Y9GzCl3KPX3B1XeTKskDXvicLXhymyDkEzdGOtNwtHv7tKgBC2I6sCqvsl711xRVJO
         11OeYvYplUCD/zyJ5OB8MF3BFhRgy70NpOt5O5pAsL7b3et8IdMc6SCP3j/F2akgMXg7
         4lQwuWEabI9ltOVQCToWZQJtAALXbhLrrE6x511ewL4IY4xCyP4GQKA4eEvf0k+tiVB0
         Uay/JxdE+FBgYPe0i9xZyKviZ6qOfMvETmyLWbMCOxZI4NcObI22pIaA1hvfF/Ss40Ku
         oSZunweS9+rvYd4xXW6fLWxFjFSAM1sBXEQILuQ+sln6bZ9edytTkUzNULK6TJPOfEpz
         eO1w==
X-Forwarded-Encrypted: i=1; AJvYcCUhWtzImJx1kVEjXcWar7CneQIsWBMwraMX9EIzOCdG/+fdYEqITvJehpNTHcW3UAtF9wb5aSUOs77HInY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UIIYmGH4+Hnok8h2T3zBliShMRVBH/Sy9jM2qzwJ/rnbJ8SW
	RGIP+I0oLJ52QIxkRGpf1gndl5f0+2kk+0YL1TbCqWzK48YaK+dHqhRr
X-Gm-Gg: ASbGncsPmxHB2t/G5uS4hN7PGRStNJ3TdT8Ck7n9rj/Wwb5FqqBT+V9DgADX5w9eCcd
	ej7vW2Oz9lWPVncmdhXaSgt2GPmqwv9K+BIr1XmjCwzd4n48YdRFNNpP6uQaGMIXl3PtQGCuJDB
	9urzt8a/s9VKk9Uf1M3+pINbdU3f1r/gZl6TNacrGHYFNgOziSoNX3dw9GzlxXKC5qeOOXomIZU
	L9Tq9rbIrnqHs12RDyMycjp8xJBbz9ROcexI1Yjbjg4zu1jeSliprdZSArKu5VaVLx8oQLyWUbz
	BrvRL7hV/7AkaF5OJT2n6KzjrD3w+M9FeL0YshBdEPeJBXxN/y93gZI4x7ueHbOMuNVwtjEtCYF
	izedDeFAsTKiONr3ca6zyFoV/qv7gfWPtc5fJ6lAzi/cKKc/SRZTGIHkNEQ9+qgEnp46wQAUVgH
	3b3AmsG5ZhLNcubGXBOua3cR0=
X-Google-Smtp-Source: AGHT+IGJEiCSuPDOO3Jx8gHScyRdLNX97D4znVoZz/xNuPgCq2qLems59o3ScwU+fbav/LPhdOQFFg==
X-Received: by 2002:a05:6000:1849:b0:42b:3806:2ba0 with SMTP id ffacd0b85a97d-42b4bb89b8amr5613657f8f.2.1763037599393;
        Thu, 13 Nov 2025 04:39:59 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b62dsm3697140f8f.24.2025.11.13.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:39:59 -0800 (PST)
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
Subject: [PATCH v4 0/2] libbpf: fix BTF dedup to support recursive typedef
Date: Thu, 13 Nov 2025 13:39:49 +0100
Message-ID: <cover.1763037045.git.paul.houssel@orange.com>
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

Changes in v4: fix typo found by Claude-based CI

Changes in v3:
  1. Patch 1: Adjusted the comment of btf_dedup_ref_type() to refer to
  typedef as well.
  2. Patch 2: Update of the "dedup: recursive typedef" test to include a
  duplicated version of the types to make sure deduplication still happens
  in this case.

Changes in v2:
  1. Patch 1: Refactored code to prevent copying existing logic. Instead of
  adding a new function we modify the existing btf_dedup_struct_type()
  function to handle the BTF_KIND_TYPEDEF case. Calls to btf_hash_struct()
  and btf_shallow_equal_struct() are replaced with calls to functions that
  select btf_hash_struct() / btf_hash_typedef() based on the type.
  2. Patch 2: Added tests

v3: https://lore.kernel.org/lkml/cover.1763024337.git.paul.houssel@orange.com/

v2: https://lore.kernel.org/lkml/cover.1762956564.git.paul.houssel@orange.com/

v1: https://lore.kernel.org/lkml/20251107153408.159342-1-paulhoussel2@gmail.com/

Paul Houssel (2):
  libbpf: fix BTF dedup to support recursive typedef definitions
  selftests/bpf: add BTF dedup tests for recursive typedef definitions

 tools/lib/bpf/btf.c                          | 71 +++++++++++++++-----
 tools/testing/selftests/bpf/prog_tests/btf.c | 65 ++++++++++++++++++
 2 files changed, 120 insertions(+), 16 deletions(-)

-- 
2.51.0


