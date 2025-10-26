Return-Path: <linux-kernel+bounces-870182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B124BC0A1F3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 04:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6D93A8B3A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C169223908B;
	Sun, 26 Oct 2025 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9hchCjd"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE404249E5
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761447715; cv=none; b=lJOLXz39tiHTRPqJKdTLMduXGS6brKm/mW7nS3NSYJeU9Sqs5uOAjJ0IjI/gd+SZUU3wqPop14iflM9uojWsl5cVnHhpneoSWo0Amj12vfE2yO/Zz27IWBPIflci05jW0w+Y790GVAzvalZ6zpk5E7BhL2z9Kk0pIMOHiMq2MuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761447715; c=relaxed/simple;
	bh=iaHwTrGVnGciWMjn8Nzd0xPOsyU6baCadBkXvKT19gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+OxOiA8wvGFMVGhPtAED7LudgY3UqCOhYey/3W8TodGkaoRtg6iU2QvDroUTV5u7SjemDPJfBIFRAWpD8ctwknezgmFqNp1NMiKgmwxZd/kYOpDaP6KFMNhs/Z3NB8l3WhA3LneOWSbqe/vDt+KT5So7m4okSAoEE362SredZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9hchCjd; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-290a3a4c7ecso38428085ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 20:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761447712; x=1762052512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXYl16vyCySzBmLxYb9g7KSK62mtaFrc8XpoELCZfXk=;
        b=V9hchCjdSXZroxO9QQm0ge8ByGM2dQfmTRtwS8O3HnBMlq9a4JFulmj1FE8iGwc+9+
         /d+FtdzsEybf03hpdE8hPpcfcqGfxB65fK1hsyFdBYuJG4b53pnWsO/byu+Bs2oKQ7A7
         ybBEJ9p59CcfeNQdBW5axrOw/Qsw3c/PkzQ6Rzd9HMzhzzi5Pbt3lYTowA43735s8Rhp
         cYN/yTuuBlx7nj1y/jie6ScRErkuc98frXXAAfA12BjfnittRfmTz9YRXPnrtUv/LIHt
         w/tmjRTdloyFI26KcybjLLT+SGHaqxPB+FlcEUyJmwEY+6VXhPdwFU4AUZcPQ0ntj+st
         XlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761447712; x=1762052512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXYl16vyCySzBmLxYb9g7KSK62mtaFrc8XpoELCZfXk=;
        b=fip5LFczYk/8AmC4W8pwNlYG0grW2NJ5f8RDUsfrU9ZMo1b6HOlELvVvRF5irw3E5k
         PwZKS1FNIMNRDzektF81WyahYlN1MeAHpBPutse64Riz753RGafNUV8HGKPGbeZqzn2U
         lU2WQhIaR1gKOGqljjcP9axDsiyqH6B4uo2LXncO/12Ow+3A2xneWhPTkVFBouZXRzCm
         NMeU06D7+Vv6B2Er42LcwrPfztzV1a0cLBENTCbONK4LYSmmatISJfYl1Rmrr+yooy+J
         l+nvMMvDQgP2gY0RFIOOvdJdeiIZvdqjDC+AYQf8ZOOeWzO7+vBLc1PRLd2U4CdxlGbc
         D2pg==
X-Forwarded-Encrypted: i=1; AJvYcCV4tLwGoRSohYpFm/ejZOH2gfoI476vPuij05XlLYX/Nnq53dh/OVTDXB9HlglWTXPmFR/azKlK2Codh44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9RkNExIqW1Y4xvtBlbllAwdxQeQEJmdTRVopmhWGmk4gGRmza
	PW4m0OY4HEkz6MwTgsEwBB8noivKvQN6XzcZ05BOl1JmmH90dGi5mzT2
X-Gm-Gg: ASbGncuCNcH0NGYiB6oQI4JELVSiT07K/sA1Pw5Dx2V1bay1sg6Bs1JalHhGchErS0o
	OAPWUd7xkVlAgqCv2mFD8Vqexfn0//SWLV/zS0oQYAa74vaCFI8SOspcmk2fCW76iuBiADZxELk
	+aTV85o2PtIU5Fuc5+tC+94QEvitbWHBWgv/2aA47tBZVeKTKExm3/0/8AjrIheK9mwOShRu6iE
	pAnwjWoFnnzjU4P6UpaZ0NokmgNoAI+fAO2RjA1VPxFQSqMGmuofdtUA4KeD6H5c8MoxpXh9eTc
	rJWYSdOY2AXKd0uoZOr7I+3sfOlGKP8Rg2pBhvZHMXdIt4r0MqtNJ2E8Ej7QcUbaKy7RiGndEmB
	bUohxmCaGjz/chWV6LVW6unonU6z3W+iT//Y56pG3t5mMIBcqQ2YYtljrAoRVJ1+rPffbHhEOuV
	9BPbt3YZ1kA7MdKWsCyTxKfQ==
X-Google-Smtp-Source: AGHT+IFMC2yoTBCqvafrh22kIpK/2+2o4SnwzUWnGo0yvXCL9Nkdv+DMpuwly7n7AdRPexdpVAitYQ==
X-Received: by 2002:a17:903:2445:b0:25c:25f1:542d with SMTP id d9443c01a7336-290ca1219e1mr406570025ad.36.1761447712161;
        Sat, 25 Oct 2025 20:01:52 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b1esm38100645ad.73.2025.10.25.20.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 20:01:51 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/7] bpf: tracing session supporting
Date: Sun, 26 Oct 2025 11:01:36 +0800
Message-ID: <20251026030143.23807-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, we need to hook both the entry and exit of a function with
TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
function, which is not convenient.

Therefore, we add a tracing session support for TRACING. Generally
speaking, it's similar to kprobe session, which can hook both the entry
and exit of a function with a single BPF program. Meanwhile, it can also
control the execution of the fexit with the return value of the fentry.
Session cookie is also supported with the kfunc bpf_fsession_cookie().

The kfunc bpf_tracing_is_exit() and bpf_fsession_cookie() are both inlined
in the verifier.

We allow the usage of bpf_get_func_ret() to get the return value in the
fentry of the tracing session, as it will always get "0", which is safe
enough and is OK.

The while fsession stuff is arch related, so the -EOPNOTSUPP will be
returned if it is not supported yet by the arch. In this series, we only
support x86_64. And later, other arch will be implemented.

Changes since v2:
* squeeze some patches:
  - the 2 patches for the kfunc bpf_tracing_is_exit() and
    bpf_fsession_cookie() are merged into the second patch.
  - the testcases for fsession are also squeezed.

* fix the CI error by move the testcase for bpf_get_func_ip to
  fsession_test.c

Changes since v1:
* session cookie support.
  In this version, session cookie is implemented, and the kfunc
  bpf_fsession_cookie() is added.

* restructure the layout of the stack.
  In this version, the session stuff that stored in the stack is changed,
  and we locate them after the return value to not break
  bpf_get_func_ip().

* testcase enhancement.
  Some nits in the testcase that suggested by Jiri is fixed. Meanwhile,
  the testcase for get_func_ip and session cookie is added too.

Menglong Dong (7):
  bpf: add tracing session support
  bpf: add two kfunc for TRACE_SESSION
  bpf,x86: add ret_off to invoke_bpf()
  bpf,x86: add tracing session supporting for x86_64
  libbpf: add support for tracing session
  selftests/bpf: add testcases for tracing session
  selftests/bpf: test fsession mixed with fentry and fexit

 arch/arm64/net/bpf_jit_comp.c                 |   3 +
 arch/loongarch/net/bpf_jit.c                  |   3 +
 arch/powerpc/net/bpf_jit_comp.c               |   3 +
 arch/riscv/net/bpf_jit_comp64.c               |   3 +
 arch/s390/net/bpf_jit_comp.c                  |   3 +
 arch/x86/net/bpf_jit_comp.c                   | 221 +++++++++++++--
 include/linux/bpf.h                           |   2 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/syscall.c                          |   2 +
 kernel/bpf/trampoline.c                       |   5 +-
 kernel/bpf/verifier.c                         |  45 ++-
 kernel/trace/bpf_trace.c                      |  59 +++-
 net/bpf/test_run.c                            |   1 +
 net/core/bpf_sk_storage.c                     |   1 +
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/libbpf.c                        |   3 +
 .../selftests/bpf/prog_tests/fsession_test.c  |  95 +++++++
 .../bpf/prog_tests/tracing_failure.c          |   2 +-
 .../selftests/bpf/progs/fsession_test.c       | 264 ++++++++++++++++++
 22 files changed, 694 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.51.1


