Return-Path: <linux-kernel+bounces-748573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F9CB142EF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4B518C2720
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7164278154;
	Mon, 28 Jul 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8k7Y/ym"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD15248F70
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734424; cv=none; b=MOf2Wxi1UgbdlrHpPzwzEFF7uNnE5eoij62tR1J3HXOUy7/ZBFPiODvYsPV7KsIIM3rESUI5cDe5zmZwx0nHMP+fICRcOvaHUZUGbV9uIAInFs+sm5jWt2ygD8tBv2/4o+8LOqlNojAJgiPu1rpuCvzbvsrcmg48KLkd7926lME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734424; c=relaxed/simple;
	bh=FOsqsYou5/P32c2XlFx2QdYjhVrB8Cpb7P8V9ps+wxs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eC92RvvTlPcCcCuOrSeAYW4RdHMmxG4LVBKW4jKIWZEN5bjLlg6mSdLLuyecwW765DBo/IA5k6eyRppKil0A8W0hyTlbcCxQCwDjpavHOfo1B1qqkyFEZvyzsD4uRPCR+bqE+6T3AzBdb7BoMFhsShMI6EjqwXVqWuJJkkGfs7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8k7Y/ym; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-75e28bcec3bso7676475b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753734422; x=1754339222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6IWZ7aJwNJ0i58XDePtfXg84Zvmb7Xy3RJeSCsk5t9k=;
        b=b8k7Y/ymdaCoKZI84UrRMD3WJppLRqXG5M4lLEXvj69z6prWLTmDuXduV+WGkH+hMi
         bbnD0RJPrCXiB4ZJGTC3dIamWFThBqxjUeW8+/MmrYiOuOb4knTNPPPvM+XIL5HojLOb
         ivEps0ZH7sdkvfUGN/Oq9hK5Jauo2nvPyP/aDlXrY9Q5ap2431Xuv2rX+KPFPwG5PMWT
         JnuJPk7BUkbb4Cj3Q3/DDma5YLffBTo+2aA8M1e1keVUxvQwvpRXeuPTXtJvDc9xbI5M
         MgT5Ss4vrbboLDk6I6mglojFx4uOqdwE26l1Q3l0HIefumZwaiImnlArvT19cRA7nLU6
         Xw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734422; x=1754339222;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6IWZ7aJwNJ0i58XDePtfXg84Zvmb7Xy3RJeSCsk5t9k=;
        b=cesDHrPXO4Y3zIbLg0X07cv91LUbhllZLF9jWWyXx3HQ6W31WPqQSj4k6G0r11Ej+3
         jeUzitgklmO5DUGueUR3WUxTdeb/Fm7YZD5Mbn+jAmPuSv/hM9oNSxCydXAC0GC3dYwk
         dhdIXTz/qAHauCKrpf6seIWZ12cMfmj3yQL+/Ip355SDtzdReoM9eINWJd6h2Y4pwTz5
         Z8zeL90iw3O94jL7bBwra+rX+zuR7Ef+3xyciXxZxrNUMYEDEJxjZdkxwfC4XkqD2T9F
         ZL7C1yPv16yvZxzYHo22ZJWZXZV67Yjt6t89VVeDvcG5O9CvWCQCBoOwRVl0kXcuBsez
         Gevw==
X-Forwarded-Encrypted: i=1; AJvYcCXuE+gmI/OtrDQxiIkrR+0Wo8V0CjNzZAb8n3BAy4AYz/1SmFdgVWkFtcbLawG1/S+l8CHtJlS3CYE3j+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUPzLhEfgIQXKW0ZtH07G9m7CG8xkfUqURKzqlGpdP6rQtFwUD
	wMsipBjWP1O4WsSAUIyYgFDFL6xMnSjOSImOnrdtN43rylDzrVCChVT80wqp7eOaIVG8go2cNzz
	eMkBOtcT85bBkA0l8Bf4V2/qYDRMwaQ==
X-Google-Smtp-Source: AGHT+IGUReHUkUbmR2M4RfqQQuk6vgsVDC00fdDQUCL9Df/N+1gwrxiM/Xclkwmg52vacgmobdKHIGvJ/zhinzrEKwc=
X-Received: from pfbfh25.prod.google.com ([2002:a05:6a00:3919:b0:748:f98a:d97b])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:22ca:b0:74b:4cab:f01d with SMTP id d2e1a72fcca58-76337014813mr19166325b3a.12.1753734422185;
 Mon, 28 Jul 2025 13:27:02 -0700 (PDT)
Date: Mon, 28 Jul 2025 20:26:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=samitolvanen@google.com;
 h=from:subject; bh=FOsqsYou5/P32c2XlFx2QdYjhVrB8Cpb7P8V9ps+wxs=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBntdwXFcpofxCg36R+p2u0grPaokVllgr6VzXaT4xYpX
 4P2mrd0lLIwiHExyIopsrR8Xb1193en1FefiyRg5rAygQxh4OIUgIm48jEyPLp9ZtXxtcG7Xinc
 Ou2hckRMMVFHhOHUxN7fj5c8zI7ZF8bwi+nP2yo36x3n86/eut5yWnTDW1mHew7/lk6LTfvA1Xr SlwEA
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728202656.559071-6-samitolvanen@google.com>
Subject: [PATCH bpf-next v3 0/4] Use correct destructor kfunc types
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

While running BPF self-tests with CONFIG_CFI_CLANG (Clang Control
Flow Integrity) enabled, I ran into a couple of CFI failures
in bpf_obj_free_fields() caused by type mismatches between
the btf_dtor_kfunc_t function pointer type and the registered
destructor functions.

It looks like we can't change the argument type for these
functions to match btf_dtor_kfunc_t because the verifier doesn't
like void pointer arguments for functions used in BPF programs,
so this series fixes the issue by adding stubs with correct types
to use as destructors for each instance of this I found in the
kernel tree.

The last patch changes btf_check_dtor_kfuncs() to enforce the
function type when CFI is enabled, so we don't end up registering
destructors that panic the kernel.

Sami

---
v3:
- Renamed the functions and went back to __bpf_kfunc based
  on review feedback.

v2: https://lore.kernel.org/bpf/20250725214401.1475224-6-samitolvanen@google.com/
- Annotated the stubs with CFI_NOSEAL to fix issues with IBT
  sealing on x86.
- Changed __bpf_kfunc to explicit __used __retain.

v1: https://lore.kernel.org/bpf/20250724223225.1481960-6-samitolvanen@google.com/

---
Sami Tolvanen (4):
  bpf: crypto: Use the correct destructor kfunc type
  bpf: net_sched: Use the correct destructor kfunc type
  selftests/bpf: Use the correct destructor kfunc type
  bpf, btf: Enforce destructor kfunc type with CFI

 kernel/bpf/btf.c                                     | 7 +++++++
 kernel/bpf/crypto.c                                  | 8 +++++++-
 net/sched/bpf_qdisc.c                                | 8 +++++++-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 8 +++++++-
 4 files changed, 28 insertions(+), 3 deletions(-)


base-commit: 5b4c54ac49af7f486806d79e3233fc8a9363961c
-- 
2.50.1.552.g942d659e1b-goog


