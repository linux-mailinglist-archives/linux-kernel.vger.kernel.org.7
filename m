Return-Path: <linux-kernel+bounces-879459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 026B7C232BB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C8344F0B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7482750FE;
	Fri, 31 Oct 2025 03:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6jeZQxQ"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0F28E5
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881218; cv=none; b=HILHJTjAC1fXXHF6A1NXQ9jCBassMxXqoqLX7BCFHKgaAHnkU2T+8hVd86xcAU1gjvGX9gc2E1N8tllpo66m1oyKOusU8xlubK7cfadY3NRIIpm9eZCcC5O99aXkHbO+OQLiv0wigWoScEGaCKC/bow8flBM2YOkFVTJ2zdppcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881218; c=relaxed/simple;
	bh=lzrcsACN94BCEn6LIamXzeWSOdsXRu5qZRO+WuapXvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pl251QpANFNM7YvlYzBMhCXOfcLoAAZD8QwyKBn+BXIZkBoGMFf/KQM2Ih0YQFHcXZAQmzFPVDUSPt4z7OadnV7ARlKhVW4AhOS594H4jjNC0UI8oWr1TNgHGsT2l8nxGzjwK84736dtE33ZR0aEnxNH3xROHI7dgfggZEvVTns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6jeZQxQ; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-781997d195aso1308322b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761881216; x=1762486016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3sd3IabjWPLM0c1Ep7/X4EzSdDhj89uNdykGpHI9AnQ=;
        b=S6jeZQxQ4gpVUKm0p6QA3Kf263Qw8HX7M/h0uygUmmYjLi18D6UL7bNi0daha0VEkf
         TB8CKxVmVmftLGJHmeKk51OSRwMHWUgMe3ijAyx4s/Veax/NgMB1C0MzyKmjjq+DIvfq
         O29PWQ8mDvPH56/Ko6KsFpKaU7C8GYCAXGNcjJItPiXn5s/VpQEB7cI/7IhRvGgSp4T0
         TEmxpDdl79aOXWeWJgYBltJpCerzC3WFnVZLcvvHaCeeTmqnu/qltlUkpNqPP9MRj4x9
         8/DX0PdOTnmoBweTIbImt2GfmrT8qsGcJhS79Sv9iw721HPnqNBoPpPw/0tVDHr71ad2
         DqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761881216; x=1762486016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sd3IabjWPLM0c1Ep7/X4EzSdDhj89uNdykGpHI9AnQ=;
        b=acbZtnlkzF8pD0QkIJNmOdrOjxWBeEaOdM5ZkFQo8zpQv34OBpymbEPD7LeDOBjHD5
         oOXVnvBd5Sy+T7OK17wGMAuTI6l1pMFBRaYgcbiD2vRM33vmL8oILqvlq/9TSpo5PWX6
         RZ/SG4Jv/Q6G+auVKSshxGE2hgC2KvCDHy7HdN6nsXzEqjDv9U7LoOp0Jo68pgd/oDbK
         jPwYEsnxBBmGJr8qLte2WUILzuvhCGeVYItyAArwbzQ07hZlBRHy16hhmRs9uya9iiiq
         q3mCjOBWivC/SuqgLR3078noOJ3fAW05ophhyoirNTZa9JbL9WunEyWqAmotMisGYKfH
         B5QQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5mMhbGZYqsBq/jt0QkTOniOX4WPi81+6fBM30ahtiIk4ignX4FX2jlVf+8+wk7YCmXa9JfKI/zhczVRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZig45JRUN+eRxe3kV5hjg7BGD5JOjZWLOD407gHX+yoZ3FzR
	WOe/9gkvDN1koqiUqH0hYc51Ggzq2k0yXV0M4ypV3OcRd4WbNWfAeSqtoXKkWR/m
X-Gm-Gg: ASbGncuPP+70KNG6j1NeztXoawKIHUO9iL84Pk/QmpDAMFJQRpHV276qMDvMz6psxwP
	rcnYXbwbU47WKrHZbTgrQkRhQbA9m1OnuC2AVkj0nQCeiDJQLvSy8BPWM9CYiw6IHaYUd5Oa18G
	0Ud+LhYwUPfYsvb5vhpDZt9Qujdko5c92j8YjcVzRUj9Mv1DdFZmN4D+jTSERHCAnZ3QwQfnTNz
	v7CYjjnCljA7Qkz68CTP8IJLxooPpag4TCGOp/VEoLXp4uCJDdkACYY1bAalsEJaIEHGfCQ7po4
	GcexqvMzKeQERrQl4eunub8jtrnCQBxMleTgKzf5h3lRebUcjiotZ2BYvDjhuJUKvaX+e0QGQiX
	QMFHD1gqQTbTjqELIB6fGb3Uu6r4sbooUngYMsU/3v1I9n5LTPiotO2x3fFTXUUkxIR32WTX3ly
	C1pI5asEZZKhMsVHh1xw==
X-Google-Smtp-Source: AGHT+IG4r50iTZrGvj1cbFayoAZBBFf91AMPMADhvBTgNdyW2zv9biOn14A1Mq7Teeu0mp1Vg7Mv5Q==
X-Received: by 2002:a05:6a00:2d0b:b0:7a2:6b48:5351 with SMTP id d2e1a72fcca58-7a77766c91fmr2503068b3a.8.1761881215769;
        Thu, 30 Oct 2025 20:26:55 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897ed6csm418406b3a.13.2025.10.30.20.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 20:26:55 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: bpf@vger.kernel.org
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/5] libbpf: add Doxygen docs for public LIBBPF_API APIs
Date: Fri, 31 Oct 2025 11:26:21 +0800
Message-Id: <20251031032627.1414462-1-jianyungao89@gmail.com>
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

Jianyun Gao (5):
  libbpf: Add doxygen documentation for bpf_map_* APIs in bpf.h
  libbpf: Add doxygen documentation for bpf_prog_* APIs in bpf.h
  libbpf: Add doxygen documentation for bpf_link_* APIs in bpf.h
  libbpf: Add doxygen documentation for bpf_obj_* APIs in bpf.h
  libbpf: Add doxygen documentation for btf/iter etc. in bpf.h

 tools/lib/bpf/bpf.h | 2962 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 2941 insertions(+), 21 deletions(-)

-- 
2.34.1


