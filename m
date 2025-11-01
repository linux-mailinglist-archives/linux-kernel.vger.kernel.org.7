Return-Path: <linux-kernel+bounces-881343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D59C2C280C0
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BEFE4E5B22
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224CA2F60C1;
	Sat,  1 Nov 2025 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MLrO46dq"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1F1A073F
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007014; cv=none; b=ubpA/F9rmpkcWC4WdCnWuIW/nc7uWfn4PBNOHgzGPZIQDBL3fRo9yRJHXcrqbgRkoErEWkmswK38o+p1QyLN4tk+8mKqzTc8aj/TwxSbHtFyX/nrsBRJDU3xGLSGSZvVnZnJW7be9CK642xRC5a1pZZd4oftbN+eMLV8gbW45E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007014; c=relaxed/simple;
	bh=94ek665fvNP9ZcSxYKAXNLB9maovdGcTJ9/mzIK+5FM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HHoBE5AN9c+X6AXHUJAaj4XV9iZ2ufjasH51JVt3F0UpzT6jMU94ywxMU4sLiD28NF8H8dgPSnFZ0qG4YoOo8xzFbuN2EpQTprGefGix2eg2dW3d0k2MmANxDF+7YnRxwlMKke56OiRkIDMCEtoFtNw2OdQg9+OT0iJCNKSEESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=MLrO46dq; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-932e6d498b2so2690580241.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762007011; x=1762611811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mjyYeFyfCt82d7aSwBTlmR33nET5fMThRpkyy8tjGGE=;
        b=MLrO46dqvmJjJqRnrz8yzEp11sB6LGyuwPERSt4FOCbhDcPi06f/DltZ1Ir6K9u/eN
         HygSnNMsGcian0oxUOJ0+89672BszJM9N+To7aHSEmsOG50SGsIkr4D4YcnMTCZFFKM/
         abB9D4hdxnPQ9jYh5dMs8yrgjBRuFtGi97p0PnSCSTqbqIawpjVknr7jsem1vPs3y0YJ
         Ifpw73IotybZ6mPsMkj3E/Ck5c7Bf8/tUkl+qjePjTlqLtlFD4/6Q2bDxD6/YmN842mK
         DPHpzYOyLbMhQIFSPJ4HoTvCNljbwKxnfmt9SxuEny6kGUMaruyNMy7D7vweZqnujh4A
         6KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007011; x=1762611811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjyYeFyfCt82d7aSwBTlmR33nET5fMThRpkyy8tjGGE=;
        b=PzVR2xSoEQdltmM8X7tNpFSA67OboERHHNGebKZQtXeN2vMRLZyK6eBnsB4mgXgIbi
         5LRIgnCJeTTQ3oqYQry3chOrTBUDRkwgV4ocecz+qHeLjqUUPjbfpHJRsQsJzZvM2Yoq
         rI4X6CkojqTKy9Z8Tl6rCX6VxTL1+KteLP12zCHB9FQqziytbK3YwOsLySL+6crV2Yah
         6nM1a1Un/Bl+7cfQwl1Lzb0izmHVhhlS2oYcGA9lawnnqIjx8jhT5+sITc1ed9RT1MJ3
         VYGpy+HUpXKa8ixni8zoo3QW/bBy6HB+hyRJ7YT36WjAiQfAB0Zgwg4KUQAeNs19UwK2
         cktQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPjsrwxXX/fQwpn8sK3aitS+lotYfGJQ3d86wGvCHsFNQZn8U0qCi7UUgwaG+aPVL5kozLKiA50Kj1e7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBk927qoKqjQIlHlAk5Xc5A0Q1aiMsu7r0o0sk29hn5HHstLUS
	BmGclksQw496qLzv3sZs4Nagx3GLowA0P3eUhqFg6nxz8uAcY5arT9Hio7HEloNFaQA=
X-Gm-Gg: ASbGncu8Jc2BJXA/W02UITXiN8f0USxlIwECqyTKGeWH+z3VoppFevVTbR5widDmDU6
	sY4J7KSl/8CGWWx1Sh7bFEjfo57UQBQj0kYwlBEsaevBqeNemmFNuDL9cQpRLUaXLpQGZbLET2g
	aqW87ASKrigXX4nXgUg5NSDbHsKcnPx993W+hcx9uMcbAmyP1jzOJrioZHjG7PE/SJ1B7keIIPJ
	7b4F0/krNYv3l/sJ99u2VPa0FpzkfvUnv6A0pdkaO7O87VkZQRb/9d3DlJNBXrmvGE7uNOqDNHk
	0mQC0Qrs/xBMoLAqUo/e4aE3eXzOc5JsmbA0sdmnOkN5yfO5RfoY/QDMp7PDT64Y03a1ObM1Cak
	/Qh72Dj9dkALaY/vfaEQk48quPLNxBrIufpg63z7pjRd2X9eT/jW5RIQ2wy0IZ7SENUSsY0BAeW
	vzQqNxuQkRbab8FLBBZlDK6HE+vwsEEKxGR5TpjHOYF+gna/nfU1b0fTXQDMWfXnTfkdgg7CF0h
	nxM10nKgw==
X-Google-Smtp-Source: AGHT+IGBXiDtpLvwnOU1rUIvjzlWuqMrUwK4wBcxPPZuC+/U/6yYNYHC5t6couOoofEI67TRcbfb2w==
X-Received: by 2002:a05:6122:2a51:b0:556:9cb9:65c8 with SMTP id 71dfb90a1353d-5593e122cb4mr2859544e0c.0.1762007011445;
        Sat, 01 Nov 2025 07:23:31 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559449647e0sm1776242e0c.3.2025.11.01.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:23:30 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	yanjun.zhu@linux.dev
Subject: [PATCH v9 0/9] liveupdate: Rework KHO for in-kernel users
Date: Sat,  1 Nov 2025 10:23:16 -0400
Message-ID: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v9:
Added review-bys and addressed comments from Mike Rapoport and
Pratyush Yadav.
Dropped patch that moves abort/finalize to public header per Mike's
request.
Added patch from Zhu Yanjun to output errors by name.

This series appliyes against akpm's mm-unstable branch.

This series refactors the KHO framework to better support in-kernel
users like the upcoming LUO. The current design, which relies on a
notifier chain and debugfs for control, is too restrictive for direct
programmatic use.

The core of this rework is the removal of the notifier chain in favor of
a direct registration API. This decouples clients from the shutdown-time
finalization sequence, allowing them to manage their preserved state
more flexibly and at any time.

In support of this new model, this series also:
 - Makes the debugfs interface optional.
 - Introduces APIs to unpreserve memory and fixes a bug in the abort
   path where client state was being incorrectly discarded. Note that
   this is an interim step, as a more comprehensive fix is planned as
   part of the stateless KHO work [1].
 - Moves all KHO code into a new kernel/liveupdate/ directory to
   consolidate live update components.

[1] https://lore.kernel.org/all/20251020100306.2709352-1-jasonmiu@google.com

Mike Rapoport (Microsoft) (1):
  kho: drop notifiers

Pasha Tatashin (7):
  kho: make debugfs interface optional
  kho: add interfaces to unpreserve folios, page ranges, and vmalloc
  memblock: Unpreserve memory in case of error
  test_kho: Unpreserve memory in case of error
  kho: don't unpreserve memory during abort
  liveupdate: kho: move to kernel/liveupdate
  MAINTAINERS: update KHO maintainers

Zhu Yanjun (1):
  liveupdate: kho: Use %pe format specifier for error pointer printing

 Documentation/core-api/kho/concepts.rst       |   2 +-
 MAINTAINERS                                   |   4 +-
 include/linux/kexec_handover.h                |  46 +-
 init/Kconfig                                  |   2 +
 kernel/Kconfig.kexec                          |  24 -
 kernel/Makefile                               |   3 +-
 kernel/kexec_handover_internal.h              |  16 -
 kernel/liveupdate/Kconfig                     |  39 ++
 kernel/liveupdate/Makefile                    |   5 +
 kernel/{ => liveupdate}/kexec_handover.c      | 532 +++++++-----------
 .../{ => liveupdate}/kexec_handover_debug.c   |   0
 kernel/liveupdate/kexec_handover_debugfs.c    | 221 ++++++++
 kernel/liveupdate/kexec_handover_internal.h   |  56 ++
 lib/test_kho.c                                | 128 +++--
 mm/memblock.c                                 |  93 +--
 tools/testing/selftests/kho/vmtest.sh         |   1 +
 16 files changed, 690 insertions(+), 482 deletions(-)
 delete mode 100644 kernel/kexec_handover_internal.h
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (80%)
 rename kernel/{ => liveupdate}/kexec_handover_debug.c (100%)
 create mode 100644 kernel/liveupdate/kexec_handover_debugfs.c
 create mode 100644 kernel/liveupdate/kexec_handover_internal.h


base-commit: 9ef7b034116354ee75502d1849280a4d2ff98a7c
-- 
2.51.1.930.gacf6e81ea2-goog


