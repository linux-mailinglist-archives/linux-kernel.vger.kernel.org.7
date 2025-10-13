Return-Path: <linux-kernel+bounces-850199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8E7BD2384
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B34874EB1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D672FBDE8;
	Mon, 13 Oct 2025 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YKMEYGmE"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C096220F2A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346806; cv=none; b=rpg7jdrs7fo5s5Q3skocNb5HL8rycFmSZ2CiW+XwFFRxngdLDUfEOrvx5/Q3ChUg59aCNOlLZ7wVC2lEuYj+0DkpFVDIGdr6UM2V1YEC8pRWKWWd7PoX3yYJXxrp5ZG4dqAbNI6RQ5z6DKdyYX55cG4W4xarEf3hKhgcYkrFFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346806; c=relaxed/simple;
	bh=1rGLpmr2Rc988K6c4+jGB9nY9XYW/BSrv2mqDgcSFAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HvP2cXnELchSKxg4zIioFCUJKvnYiSXOIFMlCkJUOmRYZN8qcvs2ppkLaprDBrhCYHUzEPdJvl1nsLiHZT5DK1NNDhCWODCDeJRElpsys8fzPu2LA1EEgln6AXQBrDpRCNDOJ0+l5k4fnNGp2LprK/nslL8VR9FhjhR4qnGWeX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YKMEYGmE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so3099354a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760346804; x=1760951604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=puEhtlhHdjNZJq9B7H+sgmW+MNQKHkmLHApkYcMFYqw=;
        b=YKMEYGmEAoK1EhWXSJ7AOFGK8GcEic4r6wK6dXQ3eMmXIERcnjyeQgW1rpgKmFZ2B7
         2hSbx5NL9bu2IVORQaVsxYD0yMvDab/QbKMs7VE6abEbMM1+KLiLJHTYDpiTm4B2+c3J
         gs2ScpE6DzSc0MaK5KBA1Cwfww4lzaFVCDUY5xzjrPQCUn5LD/6UB5VnZyQFtyFI0qOo
         FtGwm20n41w6dIoQjVD7rtptKUqEhVmWQWyWnXvYsc2LD+Un7ejlXRgxkbNOP4KAKTdp
         KTTkaj6B2fit1tG/FS8cJWWMJbNJwbxzV7vtaQax6QdeaTm4uH9+LbbcB332ku4WFM5r
         XtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760346804; x=1760951604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puEhtlhHdjNZJq9B7H+sgmW+MNQKHkmLHApkYcMFYqw=;
        b=BXNuxTmE6ToNpm9GsBvwS7h693ZyfhB5rdvuaUto8mKbbJdeAvfkDUURcfLnCTs+da
         SCRiGOaEF0mcnuVdwOd4iOLDkKF82ViqWLFM80Ucb1GCVt0rWfw6UZeVxwaWoQwAUsmM
         y/NJ6EsV2WN2COsvz7svJduLE7q4+9xmDGbvuNhEt8N337njrWL8rmrHIi03rZAdqL5A
         6bBaMa9M09vUdB3ramNnTfPZYdU9l8Zm3OpolmRax2e+uPchLT/CEEc8ecRA++n2i+xw
         j1keb7PoLKkB2SOvdK32NkcbBxZG+OnnrVX/cZcTOp8ME0VrCczwdd4pQ+Z0gE7O0nxn
         4y/Q==
X-Gm-Message-State: AOJu0YzfzPGG8zxqP+OuFUt/rvbCpA6rf/zoNDqB89pkylakdhs0Odnn
	UQ4DGPQ4d6Hk9RBJZsontQwOZZWjE8GhYve7I24byL/xU0hVx+lpjS9/w9OzGI6NF80FEptfJ3E
	g/udjVkHechnKMgc5hY3z9OasoWjdFyHWzESa1TAzj3+m0AV8MymadKg1XxC/EeACJCcIn054m4
	DuWARuGgdk0diptwC8oi6hPlw3mu5f4ZcVU9LQRHjwJneUAVGT5YcAGO8=
X-Gm-Gg: ASbGncth3WblemXyCVQI7EL2vKxydD+H6fstvIeKUF4S6Va6lrzhNlJpTHfSo2ZxAMp
	tbT5HuM3upb0GLKWMLhQqt+Un+pc4PxVlDON4XfKHhGm6kpDHSJG0i0tweMYvjaLFdXzfm3CFq5
	wKrRUC8kftHWcz8CCayKTcJag/f0FvL3dr+mKzoGevd23VlournIwYustXkZIMnYTq2erTGRySw
	YP6GXNd6hkWG3j528MV6nDIv9pHRByuXzuCnOLIF2I+OtbdrC/2P8b1SGeUVs7lxG9xbdyU6TS9
	F8IMZNKpx9Jac96PlpPIEC2Pb2ibphGEST4Wg7l5H+QkDdEytsWrsmqjCb9ZNXrMMtKRJiscJqo
	KLsndgBqzlZIiAcPZ1zYxdCR1TPLLxz1x7njp0BXjg/4wVntdAERZpmYuG3PSVTaCTbYnNOM=
X-Google-Smtp-Source: AGHT+IEoj7YdDMoreA1spQJTu0BCnH14OzuerL3I7BC4yPUexYDFbRuPl/Tikz8AnuBBaxg3bqJ7SQ==
X-Received: by 2002:a17:90b:3b90:b0:32e:3830:65e1 with SMTP id 98e67ed59e1d1-33b513be284mr29173869a91.33.1760346803844;
        Mon, 13 Oct 2025 02:13:23 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a3cc0dsm11727220a91.9.2025.10.13.02.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:13:23 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	andybnac@gmail.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v2 0/2] Optimize the allocation of vector regset
Date: Mon, 13 Oct 2025 17:12:30 +0800
Message-ID: <20251013091318.467864-1-yongxuan.wang@sifive.com>
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

---
v2:
- fix issues in vector ptrace kselftest (Andy)

Yong-Xuan Wang (2):
  riscv: ptrace: Optimize the allocation of vector regset
  selftests: riscv: Add test for the Vector ptrace interface

 arch/riscv/include/asm/vector.h               |   1 +
 arch/riscv/kernel/ptrace.c                    |  24 +++-
 arch/riscv/kernel/vector.c                    |   2 +
 tools/testing/selftests/riscv/vector/Makefile |   5 +-
 .../selftests/riscv/vector/vstate_ptrace.c    | 134 ++++++++++++++++++
 5 files changed, 162 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/vector/vstate_ptrace.c

-- 
2.43.0


