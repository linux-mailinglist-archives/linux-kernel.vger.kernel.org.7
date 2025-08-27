Return-Path: <linux-kernel+bounces-788081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F31B37F84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BB4172C43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26BD343D75;
	Wed, 27 Aug 2025 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Od87xW4p"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C801279324
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289424; cv=none; b=sDpj6nkzzQTMOWky4GvTcDwseG20r3jQTUhiIYWAHKHxdMyLa2YSviH12QkyKmYsrlnDrATArU74hV2jU8LNzREz0EElC9FRdSh9LIcztGI2UvfAjUdcrHmsyACrKl7x1xZZlzMKsSCfV3xC1A6Hyfe8dSZEdt/6++qDMMvqI44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289424; c=relaxed/simple;
	bh=gT+TxytpB2pMt3fNZ4AkISCyEtC23V29tHLEOyl3WRM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=N3ENYDpuJ7TkFIHu0ABtHjhGNljmqgxC+1GD0ZGVdLny9LcJlm8rXt65ZAB9WuXD8NbFUIOCHtLWEKbmJnZifDG03FbqNtz3OBU8YPP07kaH3uTLeAg41k/opBbogtV7wv7qmaUkst1VcjqXp/azaLczCnrulMbFYwSvrBQ3TJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Od87xW4p; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326e8005bso6771351a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756289421; x=1756894221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fBu9j6IaTs08Cy0/naQSIbDYy/Ds97IIeYDx16xjQz0=;
        b=Od87xW4p84E66eplDqlWSgtDuMdhypyVAcfmgDXMXG/9NjbMtOpPtdaMTE5xlhSYiR
         +fzsPSydkZfCbDiCTW2KhYqyWzgSqTVtBvticp9LKUBEbyBOkvydmYKp2w2bmkfB6WGd
         5+EF/aA3iekARLDWRlELluCy3G2i/QoIHG/dI14EQNdViLtTOHhTz7HvSp8rerulQYqN
         PK8DECUh3kGWaWuZ6VtOPApUa6LP/YHFqqV0AbpULorW/j+HVWb4dJsWUwNEryWJRyJb
         LVAYCEpaztoNbwBZn2HsjIErVhw01/UnHGckkgqfreTA86vvelE8JQmn8oLis/k8WPHC
         d3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289421; x=1756894221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBu9j6IaTs08Cy0/naQSIbDYy/Ds97IIeYDx16xjQz0=;
        b=nBcQEuVGfwFOHQhu3SwDTfUHzV5Jt3sKwNTXeQm4Uu2bCybSRkAgtVFVzxzPrf4Fly
         A4QqoJpRiwhnAlZKVRxIi8+L5KdxKv9rz0AvKmTl/HoMBunOxSMq6Z8M/cIoKm2BkY6Q
         grvnVIzhJXJQqIjPtQfqU3VLKGwffOOg3RjmJnk45VFmx5z4yP+2CV+ne84htaUgivv3
         Fv3LJPQRxeEWCYXKJCR/mPhvs3GT5yetuE8qdxtDq0lE9zZjFSUya+Z2yO82Sw4J+/y8
         qMsBjmbjZSeTzMp1MYSqgnsoyUQi/NRzmPsw2ndv0Iui16NO10x9h8lYvLyhNTFK81Hy
         /JSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZl2mSxarPuYPp4T0naSID1OdsjZCx9fwpvsg87Vi32Lmh1Aw/4VypdK1uG/l47x80m3GH2gEie8a303g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWuLjmPJFjmHgkaI7uAAxPNBRVxKOVielX8T2KoTGLvfUw3TK1
	78yRMDeYrpm0MpWGN0fL5QXHwF2UEa+qhMSRcIV+ztQGwBl+QAgp7wo0WYwh7GQ26W4=
X-Gm-Gg: ASbGncsDIGLQuBgFPCBoaWO9ZDEk5BBxM+AXXVc/YlkyeNto2GBdhKSgQ02L1UEHPqS
	B4wKcOzvAKiP7SgrCKznRQeE0Tfjz97wAZ0D4JymFiLiuRXVgYgRvRn3UFKXlEw7FHvwg8ZATdH
	8akAXhXRS7CSX/I6gBs9IaIUSGHJIaupzCxIEFB13m5Av1nep9NmNFe/isQlyJxDOFvxpGujF1W
	qyhV41OSBtDSVZP2wq/ppLZrAWRCyru+HzeNohEojMZ6aiVfBRC4locmhL6PlcX9X8sxcW4j/Kf
	KvwtJDv4oWUqx2XORcNgJhD/CIhk0cOgJ4zL+4q9qwaR5Y0lXT88Bk4g2u32gRRe0iSS+/5NbfW
	6c60KmziyJB9A+iR3I2uZDewfKzeleAhxe3+p21pWJGryZ4opSWDDf3NRt//D+lni+EcdqT2fjQ
	==
X-Google-Smtp-Source: AGHT+IE247z+6IbaCQjI/JRybcT+dCJSxuMKhLrRKRCY3vXFrDNcNNm2FeQS/0dKWf+BL5aq7dNmLQ==
X-Received: by 2002:a17:90b:538b:b0:325:cce7:f65b with SMTP id 98e67ed59e1d1-325cce7f86emr11644260a91.29.1756289420620;
        Wed, 27 Aug 2025 03:10:20 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm12813462b3a.79.2025.08.27.03.10.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Aug 2025 03:10:20 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	atish.patra@linux.dev,
	anup@brainfault.org,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	catalin.marinas@arm.com,
	masahiroy@kernel.org,
	suzuki.poulose@arm.com,
	cuiyunhui@bytedance.com,
	maz@kernel.org,
	zhanjie9@hisilicon.com,
	yangyicong@hisilicon.com,
	dianders@chromium.org,
	mingo@kernel.org,
	lihuafei1@huawei.com,
	akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	rppt@kernel.org,
	kees@kernel.org,
	thomas.weissschuh@linutronix.de
Subject: [PATCH 0/2] Add HARDLOCKUP_DETECTOR_PERF for riscv 
Date: Wed, 27 Aug 2025 18:09:57 +0800
Message-Id: <20250827100959.83023-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is mainly based on RISCV_SSE, and the enabling of the
hardlockup perf feature depends on RISCV_PMU_SSE.
Link: https://lore.kernel.org/all/20250808153901.2477005-1-cleger@rivosinc.com/
patch[1]: Move watchdog_hld.c to kernel/ to facilitate reuse by RISC-V.
patch[2]: Add Kconfig selections for RISC-V.

Yunhui Cui (2):
  watchdog: refactor watchdog_hld functionality
  riscv: add HARDLOCKUP_DETECTOR_PERF support

 arch/arm64/kernel/Makefile                   | 1 -
 arch/riscv/Kconfig                           | 3 +++
 drivers/perf/arm_pmu.c                       | 2 +-
 drivers/perf/riscv_pmu_sbi.c                 | 8 ++++++++
 include/linux/nmi.h                          | 1 +
 include/linux/perf/arm_pmu.h                 | 2 --
 kernel/Makefile                              | 2 +-
 {arch/arm64/kernel => kernel}/watchdog_hld.c | 8 ++++++--
 8 files changed, 20 insertions(+), 7 deletions(-)
 rename {arch/arm64/kernel => kernel}/watchdog_hld.c (97%)

-- 
2.39.5


