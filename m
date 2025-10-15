Return-Path: <linux-kernel+bounces-853607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924CBDC167
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D7B1923A74
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E3D3090E0;
	Wed, 15 Oct 2025 01:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHB/kz+P"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA92FFDE4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493445; cv=none; b=pxzlFGRhZVfRga5AjUjEHxxgHq3SA6IsoR197fC2GOtLQGZ7Qn+8v4Fc0h4jATghbUOKl3psbVP80p30yvwXS2WvM9oHv9OUbHmNdZPtI/iK+Sgbss4IQcBNG10EGbMMA05MA22No4227MNOrE2KjKyWnCZDRpiBtMSXlR/+wfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493445; c=relaxed/simple;
	bh=/cVyorIkMsFWVSCnGKCrbbEYTu4fe5GBf2CabcXfTrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0aMo+pyFL3s0EsThXAjkkEPkfC/x5/BzKga2i/RdjEHF6WifrjK+hldVYlAUuaxslEcgJtNJVpC/pgz7gZrD/mC578D5EMM6dzdn5+LiwUfuL+W9eDHOXtlC+qe1a4/lztUCoTkamDOl7DfIBYU9wJaZusHzdqx724i5UYXWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHB/kz+P; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42d8b15548eso29786825ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760493442; x=1761098242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zeaP8NLxfmWjn/koiHnTCdCJDPT9I5Q4QaBgGQBf3WQ=;
        b=SHB/kz+Pc6Fih5PtUyl2gREWwj7WnGxLijGuoFdDB3Rinf5Dac06fY+Cx+2LgIUUOF
         3ClRXyrVKUBdpW8TAmF1PGRJf9E9miXyRcnbwsRSKjZGTYBPVYfY10h1fUmpyq6Ios6Q
         Dm+/0stGI0GMoaJp8VHcCscRhVA8QMyBwsesqZtc0HmPB0H/dRBUOdugkIYQ40gojr8x
         3lpq1bN6T5lW/BHdXCIfEO6VJ5PLcO51hq3optGjgCz55KOZdw8CGqy26hR3HMFdCxiT
         ZeosbT001OzShWHYAfrPwRipRKgJRCz4JET45MQRy4Rn2BoGv/8Qw/Lv0x5tq9R9Ghlm
         LAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493442; x=1761098242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeaP8NLxfmWjn/koiHnTCdCJDPT9I5Q4QaBgGQBf3WQ=;
        b=GEEWSU1ckfm1O6kHcb2NrFBL2MJr2bvJL/JADR3n7C3M/oDLU2ppezMA7zlRQYBXZ5
         RA2IyL0J50X5JamVguYThVzuTmhnNix9EmG8rZDbuhp01HJZZVsuTsHdPvSZ8QFxxf4n
         32M9r1d6CDPeOEW1R9EHmAlmwUMZXqJSczN2TGzIlNRvpSjf4ewGlYIT5T8N3cPNZBuH
         jPnPnNIlHEDW87xYRjvPl8z1Opo6hsvafZQZ9DRkM/umMZko47HNQEajJD/Ux9ayF4xF
         gXb+aKeUku/M8tIvZyopvKiNAKUlO0UAHF7KUpdAPn5SggYDkQ6UtI9UJvTSADlx7VRq
         OOrQ==
X-Gm-Message-State: AOJu0Yzf6Sy+fUudbPYc4jbxUk8uXo0Vvy68CoUX4wCrdKjTczv5riGn
	yHGD4OQrqEe+FU2+oU3fwmOX6ishh+rpdgTfkz9EhnoS6UhzxyxyUxg1moA+kYCe
X-Gm-Gg: ASbGncsFCgWkKYIpgPhZRBXujoOKx65uMRd0rFS4J2u1Iix2OqCQeB4OBZBFCYHkk1w
	DmYuTKrGwIgROWKR8JVa1XvcYYO5Gxg+KZJ/DwaZej88Yk0SoSSuioMhg2u5r/1sUKwNa4jmlmP
	52BIfck51vdpg6Zcx/2r+wmC1Ml03oCLD2QfSy2paQNCUaYI0uV9xVl9saw85T9SZfXxaxjSo5Y
	3kHhzhrwiMEIrphV9p5/ZzxRDO6TYaGCr4jXj5xievcLnz32wrdoiRM5YehgIBkylFpdjQ3qMw4
	r/UiLiHmzFWNKRxza7XRaABLETC8P6j515uHHs77uhdnXgkeYmfAywDFc4W7Lb7X4CL01UosKCd
	Kuo9b1xJAqAVtHJQvkfAap5plxGPv2kaKPCbcGf+vA1m7x9Yc8SGWHn+2FLP4WJ61we7eHfE0JN
	OLWGAhz/qK9hrP+qvEpVKXzmWg0+EZe7lES9T5E0Qy
X-Google-Smtp-Source: AGHT+IHONv40Afq4USs4oFY8rp4xprbCzgrbv1IRyEssSifN3C6Iy08xejlgJRMY3XfSG8EFLXW1Rw==
X-Received: by 2002:a05:6e02:184d:b0:430:ae26:7c28 with SMTP id e9e14a558f8ab-430ae2680aemr2267505ab.1.1760493442295;
        Tue, 14 Oct 2025 18:57:22 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c496ed8sm5254772173.13.2025.10.14.18.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:57:20 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	arighi@nvidia.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v4 0/2] sched_ext: lockless peek operation for DSQs
Date: Tue, 14 Oct 2025 21:57:10 -0400
Message-ID: <20251015015712.3996346-1-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows sched_ext schedulers an inexpensive operation to peek
at the first element in a queue (DSQ), without creating an iterator 
and acquiring the lock on that queue.

Note that manual testing has thus far included a modified version of the
example qmap scheduler that exercises peek, as well as a modified
modified LAVD (from the SCX repo) that exercises peek. The attached test
passes >1000 stress tests when run in concurrent VMs, and when run
sequentially on the host kernel. Presently, tested on the below
workstation and server processors.
- AMD Ryzen Threadripper PRO 7975WX 32-Cores
- AMD EPYC 9D64 88-Core Processor

Initial experiments indicate a substantial speedup (on schbench) when
running an SCX scheduler with per-cpu DSQs and peeking each queue to
retrieve the task with the minimum vruntime across all the CPUs.

---
Changes in v4:
 - review comments (from arighi@nvidia.com) addressed
 - make the test much lighter weight with 4 rather than 100 workers

Changes in v3:
 - inline helpers and simplify
 - coding style tweaks
 - link: https://lore.kernel.org/lkml/20251006170403.3584204-1-rrnewton@gmail.com/

Changes in v2:
 - make peek() only work for user DSQs and error otherwise
 - added a stress test component to the selftest that performs many peeks
 - responded to review comments from tj@kernel.org and arighi@nvidia.com 
 - link: https://lore.kernel.org/lkml/20251003195408.675527-1-rrnewton@gmail.com/
 
v1 link: https://lore.kernel.org/lkml/20251002025722.3420916-1-rrnewton@gmail.com/

Ryan Newton (2):
  sched_ext: Add lockless peek operation for DSQs
  sched_ext: Add a selftest for scx_bpf_dsq_peek

 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext.c                            |  56 +++-
 tools/sched_ext/include/scx/common.bpf.h      |   1 +
 tools/sched_ext/include/scx/compat.bpf.h      |  18 ++
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/peek_dsq.bpf.c        | 251 ++++++++++++++++++
 tools/testing/selftests/sched_ext/peek_dsq.c  | 222 ++++++++++++++++
 7 files changed, 548 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c

-- 
2.51.0


