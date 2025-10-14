Return-Path: <linux-kernel+bounces-851736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5803BD7291
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD5BF4EC377
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFF33074AF;
	Tue, 14 Oct 2025 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UQHcUte1"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F312FD1B7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411692; cv=none; b=FCNgn6elnEGF1xq3z3bAQBUEjUUw9EQfxgF+aOcMK/kb5D68jcombwAS4DxJaO3MG7zPf5+kUJoOv06VnhMhFcuvZbutrUVA9Niuugn7MWUc70oLGEsu5pESMbP/LBiCH87Ju7uzxKaUVqO9/0ruyYGq5B6u2vv7IIkuGnvMsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411692; c=relaxed/simple;
	bh=4m0oYSf7YDj+6AkhK+OImG8jLHv98QKB/2bNeTztQ/o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Sd4hMDXRpDBcyjZB5AcZEg5y47UwLwoxNPoy6PeeJik0ivyH0pmOyungZHx60xdhTbNXpLMsBaAB81Fp/chkqBsKiEOa8bvNEkyypVTUecyQY0d14oke89pBQwJ32o6bGHMY+PxR2VspjTZGbXr7Ker4JwjIiZ+rtzkjv/0Vfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UQHcUte1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4258349a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760411690; x=1761016490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h9mILizSboCplYbQmD86FAClfic5oRmsIwqr8yhg9y0=;
        b=UQHcUte1dmRK6W8OI2eYjKD/1lCwOTxFfzWGjZNVQ4kbT+a4xeedXGlaaHfGIevZAH
         YHSPRAjQhrUoVR284jztJwsn65aJfcf3Bn8AFixtfGJq4onVfUhRT2vXW82RzpM4l8k6
         GzuAWhX2kufSZq4pAn34zgOkrm54RWWrfCTgmq+JIAUv+uAGVXWBh2Obuw1xDPYGfu3l
         /HrEl6ZwvL/SKcjA4Ttt+de7muMylIO4l88AoOS+uYDrR+7U/kGCNrkhU8ha59H9wzXe
         0xk7jbYG+XToXaC9Vxz/NcE/hGfIFm1efyo1saQjMSKdsJ78LKRx2bccHEK+ate2HPvd
         1ykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760411690; x=1761016490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9mILizSboCplYbQmD86FAClfic5oRmsIwqr8yhg9y0=;
        b=BMmLCaiDN5oTrjYSyjFhnykaIYBZJsxHM6r5p82HmGpbqnnWX5jjgE1ehf9lhEBmAS
         3d2xQPpByXl/WgSAeJmsc5WXBQ+mpc+7Exob6gKv2I3Sjl9EGE/5EfgqA7iu0EivZwRJ
         OsYDT/v9/iDFhV+EVj7MvF5rQqzZFNQbrfLM23TOAX7S9LhRJRD3qrQdy9iCgf1maDyo
         XEIj1YECaHtiQJIq2DKVYM1+BO9jrBt9xvC7eoQXVdMPqb1uy9L7HSpmAil3fEC4wClz
         Kis1459YMQBj+nvHa9n/VKYvrUsY0QlE/rVF4GrGLM8O0u3qBUGQgQjeeDPq+fwK/W5G
         0TMw==
X-Forwarded-Encrypted: i=1; AJvYcCXFF2oBK/lzWLI9W8TST3Km/yQnH7VGunPsmZQOzJJ5hHNZKwrm/3OlpNuMRntqv0uGAHvaEoAl5ShzE/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPrVgiHxUK+rEz8wyaRybjbN2AVN3TObvPYmBZQUVDT7ceeQ5u
	Jhbcr9GMgOqGSFcly20tIfhLuvXlze5nOFe7tBwFJGatXjFJzYo7EzxKOKXZ154Srrw=
X-Gm-Gg: ASbGnct3SuzSBrhN1NWoHBujUdvAiyTWEbSTZPV0Cpfl6wlmt/8+5lC9B+2hcsMCSwY
	ExPN7W4KmlVSLmV2P0SzVDPGfNG1XCSS5JT+WDt3xcQVf/imftQofrmTEEPWPfavYOBUXhujMVQ
	VbjeJgYa22KkPfarGZLmPdHmz1nYKfI9yZE2Yz0wMhfsaxXtTiKz8hEzs/LPytku7NWxXpPbAIm
	QEHr72gsbd+EiiqW0+WQXLDwpm3Xguz7+557sHNLb0mF8Fudg1HLRB8NQ78wvQEu3pfaTTnXJMB
	hMrH8wkEtbl3QlUFufCh5ShrmnbUFqmVhAQtM2ffLY45JNSMt/iWwZaCsXoSumsqSaqBmAruD32
	pSC/ZFffz6S20sOW8m1WdcHWVp5jjWbENfDWlgx0WXgEVImE+0escSqeqPzPEBsB8fpEhi4SvwQ
	0neRqNhQ==
X-Google-Smtp-Source: AGHT+IEI3jpH2kWAbzu7oGE0nlZT9oIWVCOT7IZNd6Yq9DFB9XEbqH5fgzxf/doWGth7+r0MSrD5Aw==
X-Received: by 2002:a17:903:37c3:b0:269:a4ed:13c9 with SMTP id d9443c01a7336-290273ee214mr291664165ad.30.1760411690202;
        Mon, 13 Oct 2025 20:14:50 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f3de4asm148315845ad.92.2025.10.13.20.14.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 20:14:49 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Add HARDLOCKUP_DETECTOR_PERF support for RISC-V
Date: Tue, 14 Oct 2025 11:14:23 +0800
Message-Id: <20251014031425.93284-1-cuiyunhui@bytedance.com>
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


