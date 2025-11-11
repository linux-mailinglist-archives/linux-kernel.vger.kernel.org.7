Return-Path: <linux-kernel+bounces-894802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48553C4C207
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A153B26CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC963161A3;
	Tue, 11 Nov 2025 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QVRUMlPH"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CC927FB1C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846526; cv=none; b=FEzup/nZzrwYf6/z118e/soRvxNVKi1a0za1aCpZXUYuCUFW5jGKuP95trHFNvOpKxPOjVp9OzbV0+/bV9tPlqpMvLenqMdzTsFzn+Dh6ZkICLd/SlmJtDm6x+RMReCcpkRtS5YqOk3cCPBc2uU8qXS4IxQxtkwVP6Iwxg3zkBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846526; c=relaxed/simple;
	bh=GlLb7hndPvEpfxlqOLmPms+o+qaLaVat60M/Kd9C5Fo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=hHe0W4hEOh2bDGhnH+mheJCiKi6Cmv1b1aCQWWiAmSi5deMeQ4L+Dw/IPP1jOiJtByCQrNr6sKIL+QI4lyM/7MD45Gdu7eODApogk2+9L0k6iJ/csJmoepgOLoDngCUixAWX7JlDrrZ4GCgsFOaFPXOyMtXORsw4dNno4jLougA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QVRUMlPH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-298250d7769so10965725ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762846524; x=1763451324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=533MpmlhqTKJtLtKqvZVG6ekGMT1k9z8ZUML8V8gWiY=;
        b=QVRUMlPHi1N9oef9xSGByvemx9lc4kRPfB57aJl+3XVHYiX/3qTIAjM/rkoBbG5W7v
         J8eLYXodT0uhaC9ZoyGhev3plsko2NivMIZAdehB56kBfTLT354xcX7sB3/fA4mZZTnE
         +dl53zUvunXp/Jpq2E9yrG8vPV/AF/njQ3CXCS9a4Rjn6N5mrkTUNoC+yRMHWZact2R/
         KZaKUhU2Y62ezTpDy/ugjz9NRz2sBWJ8O29NW4x6xjwN2JESnRbrVHaNF98DtpmydgrF
         zD7dO5DjZJXVafHWtOxuwJw0FgXJGG0JBlPWq0ct+ie0wZHm4c8UNdmdJPTcMlh4v1us
         x1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762846524; x=1763451324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=533MpmlhqTKJtLtKqvZVG6ekGMT1k9z8ZUML8V8gWiY=;
        b=T3hOD6PrN4yY6F3WzqHxicSXonxf6eJGjME/mjCeCCFpnCJbF2FdiX8JDIaU5q+ycR
         Wf7CT+OVfARsG2gf+FqRygLnvSan3f3p9os0aLSqqvBG/RAsdoOXCbP3g+uKehLe6fcs
         VZgb0LMIbUI34T5eRctn6zVbBF/tIco7DZI9af1aiEx2FrIlVdkWKTZjJG+pjVQ/gDUi
         SSR5a/2HoVvQEVfqLlHlLXtJpuVMZaeHdnzJl7BV6XAu0k6F25PReNEIBTjGAhNAr8B5
         KK00f7bhWXrhq6SwgcXJqol1Gle+4eTGmz2aoZUOx3ES3vANdgxD5m4n7UGa6ZYUlTaG
         pUAw==
X-Forwarded-Encrypted: i=1; AJvYcCUs3h5zYTwaQGWV1gV6ye42Vp4QirrjTyscMUnFerqb8fuomwaufZpA0ZMsRkLXxZKCGclx4AkshBs25zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJ0zKTBABnQn8Vxd7CZeeOh3KnDoRDyMRaypHnsKnzzVGDXHz
	m9mhV2W7U3119HxdA0UoC7J9GZ/qukc47WkvV44JjIg/+eSaNnd6VVEQ1P4XzlJFsO4=
X-Gm-Gg: ASbGncsyGGVsZXq5BBYXjdtrISt/DY0Tx14jlGljCoJ5ckYbtW70uEUxlEf2pp5foxK
	+YlUv7R0zHikxbSw8SvQvRYqeLpe0BwRs0IYofk8aeaBsNdaSlSFEGE0HAi1hDMiGKE50n/iXJx
	RG7/Ktr1xrHp/cRgq7Cai7hV0zGcZBM8JSwBvty0Sz8BbUXlGlOQcIlcbIKvcQ+eqGcatIJe4hN
	3B7EBX7s4WorD6+B4Uk38vLbuVO5eMSwzPoQ41C5JpcSq1sGbNYrsWORxtAaWfez9geSaJw6BFm
	qoAkwRMgxd0z67JnkcVzNT5ieYXMES3RWzJcN1zj7ru1sZjZkHeEZxu5bUBnRAS4hgx69EG281r
	wEbNAo8xvmBhNnCVNyHQigio4OvElD2wR4z7/osH/6FYY2G5Ehvq7dNmjNvppOGp7F7qWBGeGIV
	X6vsxc2MX0qvG1Qv0mBSHVklKVTLt++b4=
X-Google-Smtp-Source: AGHT+IHc4/svjuXEJqiJPblrTTMmTzjo8sWSLvFxa7A/n/1dDjeXQeMDKykLsDl5TXqJ0t2zOlW8CA==
X-Received: by 2002:a17:902:f684:b0:295:987d:f7ff with SMTP id d9443c01a7336-297e56df951mr138535025ad.42.1762846523563;
        Mon, 10 Nov 2025 23:35:23 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c94abasm172928885ad.82.2025.11.10.23.35.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Nov 2025 23:35:23 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	catalin.marinas@arm.com,
	cuiyunhui@bytedance.com,
	dianders@chromium.org,
	johannes@sipsolutions.net,
	lihuafei1@huawei.com,
	mark.rutland@arm.com,
	masahiroy@kernel.org,
	maz@kernel.org,
	mingo@kernel.org,
	nicolas.schier@linux.dev,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	suzuki.poulose@arm.com,
	thorsten.blum@linux.dev,
	wangjinchao600@gmail.com,
	will@kernel.org,
	yangyicong@hisilicon.com,
	zhanjie9@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/2] Add HARDLOCKUP_DETECTOR_PERF support for RISC-V
Date: Tue, 11 Nov 2025 15:34:57 +0800
Message-Id: <20251111073459.44030-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After discussion [1],[2], hardlockup_perf cannot be completely replaced by
the hardlockup_buddy approach, so this patch is still being submitted.

v1->v2:
The contents of arch/arm64/watchdog_hld.c are directly consolidated into
kernel/watchdog_perf.c.


v2->v3:
Add CONFIG_WATCHDOG_PERF_ADJUST_PERIOD to enclose the period update logic,
select it by default on arm64 and riscv, without affecting other arches
like x86 and PPC.

v3->v4:
Place the line "select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF && CPU_FREQ"
in the Kconfig files for arm64 and riscv in one line, with no line breaks.

v4->v5:
Remove __weak from hw_nmi_get_sample_period()

Link: https://lore.kernel.org/all/CAD=FV=UEhVCD6JehQi1wor2sSmtTLDyf=37xfo-DOTK1=u1xzA@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/20250916145122.416128-1-wangjinchao600@gmail.com/ [2]

Yunhui Cui (2):
  watchdog: move arm64 watchdog_hld into common code
  riscv: add HARDLOCKUP_DETECTOR_PERF support

 arch/arm64/Kconfig               |  1 +
 arch/arm64/kernel/Makefile       |  1 -
 arch/arm64/kernel/watchdog_hld.c | 94 --------------------------------
 arch/riscv/Kconfig               |  3 +
 drivers/perf/arm_pmu.c           | 10 +++-
 drivers/perf/riscv_pmu_sbi.c     | 10 ++++
 include/linux/perf/arm_pmu.h     |  2 -
 kernel/watchdog_perf.c           | 83 ++++++++++++++++++++++++++++
 lib/Kconfig.debug                |  8 +++
 9 files changed, 114 insertions(+), 98 deletions(-)
 delete mode 100644 arch/arm64/kernel/watchdog_hld.c

-- 
2.39.5


