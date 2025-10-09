Return-Path: <linux-kernel+bounces-846213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A65BC74AD
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D4319E1E0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F72367B3;
	Thu,  9 Oct 2025 03:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M7SGv41D"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A14235061
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759980566; cv=none; b=TtxzhfPQemUtUAPs7iREHN6+1vSptRXrcLnllz0wxuaknTf0ABGVvchRo73GV/9XCs2MsWDDPO2EosiG+rCrauIHu3nGtHe6ayGalnKGRWW2HXyGLlbirSEL+33qlbVhsPHIr5WVMwkkk+e71wFVJWe9PIhSF4rDESvmQd8Zr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759980566; c=relaxed/simple;
	bh=hIKKBK0byVJlVWExQ0gRjim96DiErgcAqyz29wmTGuo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RwdYpbmh68pZUU7VxjHCWgj6LW3XTlNYxPq/gizkfpCbOh5lUln/YTjYdsGpu+oRohlOWLbUWHlwHSGIRtaR8GugCBexyaIsCC0t5VSx3Y2SPoloJXu03td9Dy2h6Xc+hplHzNSHFgEAj7dMnwPqcbjQGX5QnDergzTuj5Ce998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M7SGv41D; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7835321bc98so508287b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 20:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759980563; x=1760585363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JpBrYi8OaSK64ZsI47g3j0U1q75t5NwItcJ4jghSQ6k=;
        b=M7SGv41DZe6vlJSPDHpRy1hSqavSihblQlkwTqvL9oXAHL3qr6b1ut5YYmfJwOXoMq
         NWem4mcf8o1bxKQZA3mNSjTxy+0cgv91lGoIq9b+alnKNdT7346md6u61JgQm02OdFtk
         OB2A+aVgcDhfX8nxMilsr3GsATxKNPbU2Gh+oJCp62aUVKnqjKP3bbDMWeA8kB36RgfH
         rxIeeFCDojYdjhJg+VCQ7q7fK3iz4SdH29dEpv5fAIaUTHz6hFCnvsMv9Y4R7CG2CXTM
         bM0AnzdGsPj43dxVpDtGMyOTubkXydF/dyv4vqBiOxITJmFX+9hQMPJptCq6bt2q5+Pb
         Jy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759980563; x=1760585363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpBrYi8OaSK64ZsI47g3j0U1q75t5NwItcJ4jghSQ6k=;
        b=cmIMqOEMNSidVkt+OEqrPFrk7b8fqpJ5qc52lgrxhaveM6YUXJXrAKmXn7toNoMonK
         sy+7MxJjA7OqLOEiQVsuYy8GphyXCp75HY6YpDWL7SGObgFty6zXKhalGHb9q9Alrfgw
         Korqjzact51rWQ3jx7Z8qOPAmPrTxD4PZOuvDPQQDbwe9t5B+E8RzewmO+7k3nXP9yZf
         l78XgZgWTinA+tHpl4SAsPpY77s5fecOg+NMQltZiZBOjoE52Wdj7r+b7ya++L/NwlHA
         7Ph3xP8IW/0EBprxSGaZ1WfxHqlNgf7Bd13Rxn0cGmN3X1bznzxjow54iK30cgIIjYfx
         ROqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGk9aGaH2kfsImLfWNXpoCQoQ6cPT+R4S4Yy01aTHmLzj+AH4P2GJKHLQV6ELvKv458D1ITgkEbrPAgeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOTPLb61Ti0kqFSrYdrdnqW1ObWu9+XwKcYgSi6mAaBli6m694
	gq1cXyypH29kL3Hg1aGPDseIriH0OlhrAEiuja45pNYyQJyYaZme683lM78r2qV0Hoc=
X-Gm-Gg: ASbGncs+hZtfXWeH6octkUKQn3xS8pqFTdvRrDW8upmb3lDKlmnKU+21XhIZctDMZMj
	roh0tazSU2u+I2kv/WnTyMZo+JMhnXZJ5bU4d+xgrbQCSWpXJ7RPf7ITskA/hTP0CnUOrcYMtVY
	CBFNDQ4iD/8Rw+zAyaYX19nWTQ0iqM+OiF9NgNuDeyVyyeNTA/XkxaveH65skKb5gx9WomPmRSY
	PNfOh0HDwKIFDchptlD2bVZk9w766eLSr9UzFpYAMUVFcESPSDFUwtze0nNiDclk0dwr+2Njrd6
	+819dZ3mQge8MCGMWJVtbBjGUL3bI8OTe/hTGF/9fSG66C1MszK54vZPOXbGDUMmLOi4XmvqvrV
	58s+IPybwueqTjW9PPB0JCLqmvQedPPAaUxmcO67b6pTvmVjEaeQiHf0c3WqOCIT9J21RM43L4S
	BhB+FcAU6kWRzB1t+svBHvow==
X-Google-Smtp-Source: AGHT+IFRlFMSgpyV+I+rT5AczJyjaNpsL4H8TkyxvKqiDHtqjU3VLps9m9B9k3wusNgIZV/khJ/OsA==
X-Received: by 2002:aa7:88c8:0:b0:77f:143d:eff2 with SMTP id d2e1a72fcca58-79387c191fcmr6789523b3a.28.1759980562388;
        Wed, 08 Oct 2025 20:29:22 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794d4b39400sm1271306b3a.15.2025.10.08.20.29.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Oct 2025 20:29:22 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Add HARDLOCKUP_DETECTOR_PERF support for RISC-V
Date: Thu,  9 Oct 2025 11:28:36 +0800
Message-Id: <20251009032838.63060-1-cuiyunhui@bytedance.com>
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

Link: https://lore.kernel.org/all/CAD=FV=UEhVCD6JehQi1wor2sSmtTLDyf=37xfo-DOTK1=u1xzA@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/20250916145122.416128-1-wangjinchao600@gmail.com/ [2]

Yunhui Cui (2):
  watchdog: move arm64 watchdog_hld into common code
  riscv: add HARDLOCKUP_DETECTOR_PERF support

 arch/arm64/Kconfig               |  2 +
 arch/arm64/kernel/Makefile       |  1 -
 arch/arm64/kernel/watchdog_hld.c | 94 --------------------------------
 arch/riscv/Kconfig               |  4 ++
 drivers/perf/arm_pmu.c           | 10 +++-
 drivers/perf/riscv_pmu_sbi.c     | 10 ++++
 include/linux/perf/arm_pmu.h     |  2 -
 kernel/watchdog_perf.c           | 83 ++++++++++++++++++++++++++++
 lib/Kconfig.debug                |  8 +++
 9 files changed, 116 insertions(+), 98 deletions(-)
 delete mode 100644 arch/arm64/kernel/watchdog_hld.c

-- 
2.39.5


