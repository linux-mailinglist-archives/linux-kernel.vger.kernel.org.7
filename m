Return-Path: <linux-kernel+bounces-838773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9032BB01B9
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5290A1927934
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4846F2C2366;
	Wed,  1 Oct 2025 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IrqBAcvE"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16932C3274
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317302; cv=none; b=tTsBU3RbK+YioXFsXzMAOAW78j4PAhFHif/b1qBFGLJSykG3BLLlZBcJeb82lQlCRs14eniaIiNbiUEB6UZWadZ9OD45EPFnc3FuPFmkGjmCPdTHy+3dcmCuyctBAU4TuM0bS7XG7OZppD5arjoQ1xL1xmH/1uBY6HGlzXbgv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317302; c=relaxed/simple;
	bh=UF8UHXiOtAHqVUtZfnwpPDSRS9PwKtC9o1Pltywl+iM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qP3vxRoWV/kVFkw6fd3qXE6mr636uWRkv6urhBDuJKInbiBUir500j7mwwJbCNEmah4xJK77rj2BEIUSlLzVo0jWP8Z1oMQsjN6GIrM9ql0u86B0p7vKbIqOrdvsZkpt1qWEsX5tNKu+lBBZDFMgoWbQnU8a6PLbTYXrBLzOWpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IrqBAcvE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27eceb38eb1so84326085ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759317300; x=1759922100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1+2fSaFB9F3RSpAxYACKIZ12RlpjvIv2ZQovdB0QZc=;
        b=IrqBAcvEcrGipgd5a3NPL9RcJZAx+yzYOj+BeBsoBhw0SG2F5+3+OwE4nY9zeCOB4I
         v0MeF4GgXvohsniq2wbRvf/a9wNQurYqqYy6cZOEXVJyu3R24hv2NUAhKFJb+g2IfIWG
         xaZQkuTJIwMxSY/+10PUjpJf9qeXyBYA3M8zaJz5YPTP7ZZBQ/JBnVh4HqU1JHOcFynV
         kzVhfhkTmdKczC3I9z2tbqAXa3g2UW/sKEyMvswGVJsLXTLUUBhf9HLAnndS0KcXrJbD
         810NmDVQ0H9m6eGB2g5HYeJ8wV94KscDcxTIz3l2Uu/kbpDPTP3yOMCAlpzrXfWowUpo
         UsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759317300; x=1759922100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1+2fSaFB9F3RSpAxYACKIZ12RlpjvIv2ZQovdB0QZc=;
        b=oJNzn9ZblyCybg9uIf78nwVyRCazkqI1ujbLKzMhRdJ5YC/7Pq4Mub2otNsZYAfW56
         2ijHF8eAyIKCwtPok8eaXEoZxNCPDTh04l2CBvm49UOnSAH41uVtrvi5+4FfGzzwf4j5
         hdFMGBM2e5n/qoXj4INjrbBM24Ei7AIcBDb+1OJMZBuC11sIrijw3ztDIY2XDf0/dNGa
         wUtjJem/T4X04FhuMcB7JsZzQE+TN6wLPzdg9ZHmlmfe2BP7IWUMRVQZQqMU8NqhbSMZ
         953jRBQb6nlO38JJdN3PIc2pj4rWLIA3Z+uNcEg8Oal3IwZQ4TC3l8lBho6pA1Yt24Mi
         KInw==
X-Gm-Message-State: AOJu0YwuhfQJRYNUYbAY5Gc267cAqo0Ci0fykpXjk1MBo7YO4ffCfbql
	tTgyvUyiKX0SMOoq+nhHapfYprBxr4zTf7NI3cmu5jrIAMPYoamhRTWtZzgzYY0+RDKLq3YJUnb
	Mrfogx5vjsUKKar88k9dZC0xNYd+TnbLPbCMBkXKSVbq9wf4c9fyRdShPPnN6+/CNzP3xylEvuv
	Kx4zK0u0vcQ+LV6FwgvUospBT61tSMrUi+7Drr5n8JEB8BXuDI6knpGzY=
X-Gm-Gg: ASbGncuzTkamp/orbzXSu9ekX4dKbVQcxrXgrAf7E2VFAzgRrnAod7zk5B62oM5zgVc
	l6FnEwoPVqeM7fgCCPIXMJtmNu4LMwxuLGfhFEXdkDmyGFXL+ICdQ8bR4N80oNxqYDVXGvvdf4b
	i8FEf4tr3LQV223tr9EymJ+fwIABGZhVv4og58tSJBswDxLYLHOk6eA+9j15znfPF7S+kMWOv7H
	vz/tSGqAmUnBtGAAbcOGr0lkIBMQ5oZwBDyu7hXYMsgUwhNp724AuVsGETLvdmEhROqhL1wTZGW
	+IBbP2/R5dYO//Mr2Bndie5f4mgNSDmL2iT4q6P6dibFuzvURXq7BiRkhwgPUY69KVZijS4zl5p
	7mxJCsflhd1vM5/IUUliTEEAWksfhhNL722DDUvEMnst+QBtyUFGS9CekgeyS5ZCOojfLea5REK
	tE
X-Google-Smtp-Source: AGHT+IFKORUJMM66qEClhRMugGzGpIYW8rORBanMylDpKjSnLar+t2zXK3ZVyvAq3H4MPmvctX3m/w==
X-Received: by 2002:a17:903:1b46:b0:27a:6c30:49c with SMTP id d9443c01a7336-28e7f2b59c1mr39193525ad.27.1759317299709;
        Wed, 01 Oct 2025 04:14:59 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27eeb9a8ebfsm155163455ad.67.2025.10.01.04.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:14:59 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	andybnac@gmail.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v 0/2] Optimize the allocation of vector regset
Date: Wed,  1 Oct 2025 19:14:25 +0800
Message-ID: <20251001111451.299163-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The vector regset uses the maximum possible vlenb 8192 to allocate a
2^18 bytes buffer to copy the vector register. But most platforms
don’t support the largest vlenb.

The regset has 2 users, ptrace syscall and coredump. When handling the
PTRACE_GETREGSET requests from ptrace syscall, Linux will prepare a
kernel buffer which size is min(user buffer size, limit). A malicious
user process might overwhelm a memory-constrainted system when the
buffer limit is very large. The coredump uses regset_get_alloc() to
get the context of vector register. But this API allocates buffer
before checking whether the target process uses vector extension, this
wastes time to prepare a large memory buffer. 

The buffer limit can be determined after getting platform vlenb in the
early boot stage, this can let the regset buffer match real hardware
limits. Also add .active callbacks to let the coredump skip vector part
when target process doesn't use it.

After this patchset, userspace process needs 2 ptrace syscalls to
retrieve the vector regset with PTRACE_GETREGSET. The first ptrace call
only reads the header to get the vlenb information. Then prepare a
suitable buffer to get the register context. The new vector ptrace
kselftest demonstrates it.

Yong-Xuan Wang (2):
  riscv: ptrace: Optimize the allocation of vector regset
  selftests: riscv: Add test for the Vector ptrace interface

 arch/riscv/include/asm/vector.h               |   1 +
 arch/riscv/kernel/ptrace.c                    |  24 +++-
 arch/riscv/kernel/vector.c                    |   2 +
 tools/testing/selftests/riscv/vector/Makefile |   5 +-
 .../selftests/riscv/vector/vstate_ptrace.c    | 132 ++++++++++++++++++
 5 files changed, 160 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/vector/vstate_ptrace.c

-- 
2.43.0


