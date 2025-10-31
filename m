Return-Path: <linux-kernel+bounces-879637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9B9C23A23
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A2C3BE21B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E084432AAD5;
	Fri, 31 Oct 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+Lje8q9"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75DB328B70
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897576; cv=none; b=aFDtGd9qURGDF4hAhO3dQ4M0vW3wZBVb0JEFT6DGbeMVuIK4TzCtXxeRONZMjZwhYwImfUzsYchcBX8nZRsINM5/D667cQg0UdREaaerz/dNUbJFq6CgpEQ8eIhCT6Svcien0H+j2HyS/jrcwWz7UiJfoDBSb2SGmV5SCMQa1/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897576; c=relaxed/simple;
	bh=oCFU+Jq75hVAWXXdS62XSOnstkhM/oQ6Cc7WTvuNuXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=baYR8s8oDjLr1s3x1tHGfAWCrlG+ZhEENVMfGBo2YHORqZCvaNUqQAjOj/vgUAedweIB7f1/J9NdpHdMq81F+S5NYDQWDLGAMfI184NIYldTwPRFylcoRqQo3ecHRegPVpnPtXS4USWQt5Bg12eu5k1l/MBNvPduVgA9F/aizZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+Lje8q9; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-78118e163e5so2595679b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761897574; x=1762502374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FIG1gPHWz5YUTSFTq2X6NcEVev5w3QKx2U2b3x+eC04=;
        b=D+Lje8q9jWoTtcKwZvjdKuqVly1M+Md6sLDhgLHf0DrgO9dMPHg/2hbyk7QpiueWyG
         p2LGOlro7LjGr5UG87mVKFmLVMHn1rRH1sx9PUmepKeHzXDvQ1uYM47eRBXxuA58lVSC
         fo+ZijT3OV/Z9c8sWINOd7EkrqT7gDeRlFGv+8PDxBU5XYojLetuyCuTf6jShXB9BjUP
         g3B8igvQlOFtAUv6oHspWDY63J9Cmk4CY/cog34kth9Cw9C7Ixeo5k+6mVX9gau9a0Ru
         1uiEN8uUJB/B4G3C8RCtu3fyzTkvIn5cs3T7l01jVIa+yqqYrcUE0S0V5/xNU6qPs8eb
         XU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897574; x=1762502374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIG1gPHWz5YUTSFTq2X6NcEVev5w3QKx2U2b3x+eC04=;
        b=VAZ8ddxQJp0A5uirW78U1jE/BkxUb4pu5MdyJClhD1ENHXm1jSh7RIwCXmJ0vaP65M
         azJ/TYpZGTg2zXRitkf88kV3WnWEdcCUQ7v4dEXomj1rYvOkDBQDqTyC5Pd1qpfIfK2Z
         yq4M94gSmMO7bgrMk73DFLJIDzfw/ZXCoIe1zZTaDhEwFmwRYL7082k4ZKDkrqiRYn3/
         LM+JidUapbrL7WNOYVMSdTvXVX6e/VlQ1QyjyBiAnJlQlsXenn1ztevUG8aiQKttePfi
         OqHx3T2GcRmYmnCcIZQpGmtQPkHDbH2iiU2RevYaVsDhpYthOYx/TpcAXMAopbngQPiC
         4MEw==
X-Gm-Message-State: AOJu0Yyaw9gjdYq22MgcGFZ9N4ljjINs4tG5DZbggGDpk2ePS+gTCXlv
	BgyN5G8MyK6gVve5yXUKBODaK6oPIZ9RBpDOP7bAJYt7g7x0Tl+Hi0LPBQPDHjUI
X-Gm-Gg: ASbGncsHX9GldjsGyja0xXxd9+vJEhNY02mr4XIV+CeTeFb4ZHvAfq3lVIIv2ZpgDSU
	dEAQfSXT9BkC3ZsXIlHNCvmlJuE9p49dNNfp+/4/OUpPzJIrrlUI2zGEXdADCAfJ/CypcsLDleE
	viUJ5s27ERgZQxl70fK/N1nzf8aV06EZWtJD2pg+t5JO6alN+nYMgP3Q3If02RztO1FvPGAFeX2
	6yjvxVsnmdiPJaTjkunjsebA+R4N5K/VucO3vYBsTLissBzFU0Q1rhEDvwdOSon+Uznn4p1gWtg
	n3Udhu2S3AjGq0rVV0eCCQ/nl9skSO7OwT/fcTAaCHl1hLRYvSH5nVVRmeQP3LnCLvJk2/TADRU
	VQDce+sA38TVxrV5HbTEu7b0u4w79nX0uluFLvvTrHdvz2ThWRbgYIvM6WrLAPrc0xIzngLja3z
	WYKglggyuwLAfOda7wc722DGpwxP1TTc+eu3/OfTk=
X-Google-Smtp-Source: AGHT+IHdbZmqsXSWeXv/r8DTnZI3dtQC+Ykx5SbKuHeqzqFtK6HuJVgXOKgrXJEaUHZqapUmILM+JQ==
X-Received: by 2002:a05:6a21:998f:b0:342:a261:e2c9 with SMTP id adf61e73a8af0-348ba48c3d6mr3838807637.8.1761897573947;
        Fri, 31 Oct 2025 00:59:33 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be4045fbsm1216575a12.28.2025.10.31.00.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 00:59:33 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf))
Subject: [PATCH v2 0/5] libbpf: add Doxygen docs for public LIBBPF_API APIs
Date: Fri, 31 Oct 2025 15:59:02 +0800
Message-Id: <20251031075908.1472249-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Background:
While consulting libbpf's online documentation at https://libbpf.readthedocs.io/
I noticed that many public LIBBPF_API helpers in tools/lib/bpf/bpf.h either
lacked descriptions entirely or had very minimal/fragmented information. This
makes it harder for both new and experienced users to understand semantics,
error handling, privilege requirements, flag usage, and concurrency aspects of
these APIs. To improve discoverability and self-service learning, I prepared a
series adding consistent Doxygen comment blocks for all currently exported
LIBBPF_API interfaces.

Goals of this series:
- Provide structured @brief, parameter, return, and common error descriptions.
- Clarify behavior of flags (e.g. BPF_F_LOCK, batch operation semantics).
- Note privilege/capability considerations where relevant.
- Normalize wording of return conventions (0 on success, negative libbpf-style
  error == -errno) without changing actual behavior.
- Improve completeness of generated HTML/PDF docs produced via Doxygen.
- Pure documentation; no code logic, ABI, or symbol changes.

Patch breakdown:
  1/5 libbpf: Add Doxygen documentation for bpf_map_* APIs in bpf.h
  2/5 libbpf: Add Doxygen documentation for bpf_prog_* APIs in bpf.h
  3/5 libbpf: Add Doxygen documentation for bpf_link_* APIs in bpf.h
  4/5 libbpf: Add Doxygen documentation for bpf_obj_* APIs in bpf.h
  5/5 libbpf: Add Doxygen documentation for btf/iter etc. in bpf.h

Diffstat (approximate):
 tools/lib/bpf/bpf.h | 2962 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 2941 insertions(+), 21 deletions(-)

Thanks for reviewing.

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>

---
v1->v2:
 - Fixed compilation error caused by embedded literal "/*" inside a
   comment (rephrased/escaped).
 - Refined bpf_map_* return value docs: explicit non-negative success
   vs negative -errno failures.
 - Fixed the non-ASCII characters in the patches.

The v1 is here:
https://lore.kernel.org/lkml/20251031032627.1414462-1-jianyungao89@gmail.com/

---

Jianyun Gao (5):
  libbpf: Add doxygen documentation for bpf_map_* APIs in bpf.h
  libbpf: Add doxygen documentation for bpf_prog_* APIs in bpf.h
  libbpf: Add doxygen documentation for bpf_link_* APIs in bpf.h
  libbpf: Add doxygen documentation for bpf_obj_* APIs in bpf.h
  libbpf: Add doxygen documentation for btf/iter etc. in bpf.h

 tools/lib/bpf/bpf.h | 2967 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 2946 insertions(+), 21 deletions(-)

-- 
2.34.1


