Return-Path: <linux-kernel+bounces-856361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A4BE3FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE99E19C0C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D413431FF;
	Thu, 16 Oct 2025 14:47:04 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F501B4244
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626024; cv=none; b=aH+3bTa7trjL5pThJdNcMwtVONKebzWEQH2GQ8bwLXWJ9JD85AotJNzFG7xrMiZ6rOs2OyBliOK/R7WUyyTweloD0X1vv+i5mb4ubdAs3FRAw4QBwZv4weYf+1jmBRWREKWobdxMD3mvchybDgXlEbOEl1/VHhd66dJeCUZeEUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626024; c=relaxed/simple;
	bh=sA59ZYLqRjQRcEDrdphsOdS3J6yviy7YDv1qUdw1/7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+ydRvgGzslby1N/S1RCom2d6VLZnnT9/4lDlorITyHhUSTPXS7BAV7+sWYEni4ko4O3s3Jxx0ozYf7Vff4PctEmHIXV512b1/gLCg6u4F0BgfyCu4qWP8UH+HcwyQAdtK2k0LUglniOs4BDLbzKN2QNchapt89Xl55zUecfH6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c278c25aefso417051a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626021; x=1761230821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUqEP1dwmUVPaxUfPgQ2bKqmT6S9ky2aoE0uUBHPT0g=;
        b=J7rGKSHwghKi+k9aS5pTJO2nNuImLMjQUbFeBRltRgD0QqseVbZLtejFuJJcdTgt/A
         7JtvXihvWCPCER1S2ssuziEHtr5Y+aMVvTzGWZvkNgECl1F8u/AZvC3iuHjOkT0syRiw
         qRVlGx4hl0fxbzzpmtjhT6aUmqwGJ9THT+fLFQ/2JOM4/A4dX6YRPTc/3Oe1wyl20fgS
         7fOVnNSOK8nrh+gnut/XY0YFMrrd54hhOYWW9Pf6aZu8i7nJjhdwXZm1S79ENqqx6+qj
         iut9XjdeiO8cUOgJu4cM/wAtawyPtc4y5Be6Uz+IzdZmgzVGmo6eEdfysohYaalq8xEp
         IlAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtorN0b6NVB3Zf+C+0dxXDK6yf/aj9urDEYPWh+b+IWG0X+GA266it70S6c+9c85e3cgelHSLRzev0Pm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs5IDz/JPAFnyCbKVkwnC4aHSWDNOG97o7t1GQ2WH4X/3NL7u2
	AXM2R4zEUFpBmzGIbbR/CQZ8pV7w+0VS/fPrp20KZDc1Gmfro3VL5akT
X-Gm-Gg: ASbGncvqPsuCzTaJemitgE6NS7sht/PjUw4S3lfw2wL1Ux+kO3WN/EO2ecLcO0AjuAE
	FVXpQE9Q6qN/iz1DRyllU1j+pFWo/SGC3oLMbYFdEfds0k0ZmBe+jYPAPq/5EaRp2UkwmOI9E85
	+UbsoiO8lwcdHs4wpLl6Jza2oPDnGrRIKyM/yQDjfvls5cCIcA+3Te3z+zkgB5wnNV68GBCQ1T0
	www9Z/sQbSKk1fKmW0WVzaAyZcZaZAXe9Z+WSEwD9rtgdHStOqtdW3ELdB1FI/k+/hW9RIq3qPp
	65RNMwtIEkrwsbFOyfguSNNewK9yHe27oCeSE3LYcdfKMktk18SvMmHvzqYLirad5FzOE+8yaZQ
	6tEzQKLEAXmpDIlkKzkyW699mBnZgmXuMFCQjRdYrr0mwmKLrJPIeMlrUm6mIzo0MTzm0snQpsl
	TQG3e8R4APphCns7V4qviti8iqkucXF//2B4AH/RSBIuYRiMihN+7KziryOIScWTXnDhQ=
X-Google-Smtp-Source: AGHT+IF9DW0Z61L6docyCir97py3czxMKDh5vf9yDUOUUa5eqZnxxy3L15m2srpQ+v03IN0vXX5rpA==
X-Received: by 2002:a05:6808:30a2:b0:438:3350:8d25 with SMTP id 5614622812f47-443a2ff491dmr103652b6e.40.1760626021433;
        Thu, 16 Oct 2025 07:47:01 -0700 (PDT)
Received: from localhost.localdomain (syn-067-079-108-173.biz.spectrum.com. [67.79.108.173])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441cc812f24sm3678018b6e.12.2025.10.16.07.47.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 07:47:01 -0700 (PDT)
From: Jonathan Perry <yonch@yonch.com>
To: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	James Morse <james.morse@arm.com>,
	Roman Storozhenko <romeusmeister@gmail.com>,
	Jonathan Perry <yonch@yonch.com>
Subject: [PATCH 0/8] resctrl: Add perf PMU for resctrl monitoring
Date: Thu, 16 Oct 2025 09:46:48 -0500
Message-ID: <20251016144656.74928-1-yonch@yonch.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose resctrl monitoring data via a lightweight perf PMU. 

Background: The kernel's initial cache-monitoring interface shipped via 
perf (commit 4afbb24ce5e7, 2015). That approach tied monitoring to tasks
and cgroups. Later, cache control was designed around the resctrl 
filesystem to better match hardware semantics, and the incompatible perf 
CQM code was removed (commit c39a0e2c8850, 2017). This series implements
a thin, generic perf PMU that _is_ compatible with resctrl.

Motivation: perf support enables measuring cache occupancy and memory 
bandwidth metrics on hrtimer (high resolution timer) interrupts via eBPF.
Compared with polling from userspace, hrtimer-based reads remove 
scheduling jitter and context switch overhead. Further, PMU reads can be 
parallel, since the PMU read path need not lock resctrl's rdtgroup_mutex.
Parallelization and reduced jitter enable more accurate snapshots of
cache occupancy and memory bandwidth. [1] has more details on the 
motivation and design.

Design: The "resctrl" PMU is a small adapter on top of resctrl's 
monitoring path:
- Event selection uses `attr.config` to pass an open `mon_data` fd
  (e.g. `mon_L3_00/llc_occupancy`).
- Events must be CPU-bound within the file's domain. Perf is responsible 
  the read executes on the bound CPU.
- Event init resolves and pins the rdtgroup, prepares struct rmid_read via
  mon_event_setup_read(), and validates the bound CPU is in the file's 
  domain CPU mask.
- Sampling is not supported; reads match the `mon_data` file contents.
- If the rdtgroup is deleted, reads return 0.

Includes a new selftest (tools/testing/selftests/resctrl/pmu_test.c)
to validate the PMU event init path, and adds PMU testing to existing 
CMT tests.

Example usage (see Documentation/filesystems/resctrl.rst):
Open a monitoring file and pass its fd in `perf_event_attr.config`, with
`attr.type` set to the `resctrl` PMU type.

The patches are based on top of v6.18-rc1 (commit 3a8660878839).

[1] https://www.youtube.com/watch?v=4BGhAMJdZTc

Jonathan Perry (8):
  resctrl: Pin rdtgroup for mon_data file lifetime
  resctrl/mon: Split RMID read init from execution
  resctrl/mon: Select cpumask before invoking mon_event_read()
  resctrl/mon: Create mon_event_setup_read() helper
  resctrl: Propagate CPU mask validation error via rr->err
  resctrl/pmu: Introduce skeleton PMU and selftests
  resctrl/pmu: Use mon_event_setup_read() and validate CPU
  resctrl/pmu: Implement .read via direct RMID read; add LLC selftest

 Documentation/filesystems/resctrl.rst         |  64 ++++
 fs/resctrl/Makefile                           |   2 +-
 fs/resctrl/ctrlmondata.c                      | 118 ++++---
 fs/resctrl/internal.h                         |  24 +-
 fs/resctrl/monitor.c                          |   8 +-
 fs/resctrl/pmu.c                              | 217 +++++++++++++
 fs/resctrl/rdtgroup.c                         | 131 +++++++-
 tools/testing/selftests/resctrl/cache.c       |  94 +++++-
 tools/testing/selftests/resctrl/cmt_test.c    |  17 +-
 tools/testing/selftests/resctrl/pmu_test.c    | 292 ++++++++++++++++++
 tools/testing/selftests/resctrl/pmu_utils.c   |  32 ++
 tools/testing/selftests/resctrl/resctrl.h     |   4 +
 .../testing/selftests/resctrl/resctrl_tests.c |   1 +
 13 files changed, 948 insertions(+), 56 deletions(-)
 create mode 100644 fs/resctrl/pmu.c
 create mode 100644 tools/testing/selftests/resctrl/pmu_test.c
 create mode 100644 tools/testing/selftests/resctrl/pmu_utils.c


