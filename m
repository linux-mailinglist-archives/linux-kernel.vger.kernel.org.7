Return-Path: <linux-kernel+bounces-727048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAE7B01486
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C112B42ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832971F8908;
	Fri, 11 Jul 2025 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="mxAoN1EW"
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034691F2B90;
	Fri, 11 Jul 2025 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218312; cv=none; b=GMFJ6Rc1QhepSPUT7cOwfYScF7KpDQS25g1/tbB7Ag58p2/KgXrnXiIl4nORvFrSIPz+B9pVkSn7juPxrTsPZnSgOA971YtgtZjbViNGM5/ClD55soRseqxbaTcRIqrzMUOJabANPy2sUQ6ElclS6m66MG68912/hi7DUCxOM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218312; c=relaxed/simple;
	bh=htbULLvIprcyq7yA8huF8f4wUfQOwP+2TeOLYkOXT0k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z1wHf0F11OjNSxmGS8ckT0Ty2KjaAQ34gX9VxXVxgsm2yEOjGYb96LUF+FW/u8m3/e+kYHf/xcKc4LAxbl9+Ylk8qioi6tJRQk4VzWOtloQy4/JrNGsZ6vE5ZGLFmiw9AeYC9rBfYKNx1hFXOdkekaY3P4zqX0kBGDEpzortNKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=mxAoN1EW; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1752218311; x=1783754311;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=htbULLvIprcyq7yA8huF8f4wUfQOwP+2TeOLYkOXT0k=;
  b=mxAoN1EWKQUwLgKsIvbauhVm+yG5f3LPOiBhIBU4PS/czqdFeZRZLqmv
   WagR7geHAuAWPRnl/LhY8XFzwd1W96eSzfa5qfk7vKUaDhHNhKHyChHxP
   4sAXgJz59XyP0mfVqt3kM68sjXysH7DHa2uGd7khRkIIElwl5sv56bmmI
   yjTqlZIhxyToD/KOJcqd8zhkT6vs4n7RpTCxDmqoaNo+oKMM25MiBLy8s
   FGTUDMJAdkvo04EiBN9pS45OvCV0k5Dvkq5EZLU+5Fyete1f9tUhHzjKQ
   TqLtUzi0ZtgfJEWyGboKYRnonZdSveOWJw6lRfPEn2usqE/ItMgVqfdmB
   g==;
X-CSE-ConnectionGUID: TYvdfj0QQHy4e4UlxURTwA==
X-CSE-MsgGUID: ALvUBdE8Rnab0wQQjALIBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="206003246"
X-IronPort-AV: E=Sophos;i="6.16,302,1744038000"; 
   d="scan'208";a="206003246"
Received: from unknown (HELO az2nlsmgr4.o.css.fujitsu.com) ([51.138.80.169])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:17:22 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr4.o.css.fujitsu.com (Postfix) with ESMTPS id 56CAB42A319;
	Fri, 11 Jul 2025 07:17:21 +0000 (UTC)
Received: from oym-m2.gw.nic.fujitsu.com (oym-m2.gw.nic.fujitsu.com [10.85.9.162])
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTP id CB2641001368;
	Fri, 11 Jul 2025 07:17:20 +0000 (UTC)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3A84FBF3C1;
	Fri, 11 Jul 2025 16:17:19 +0900 (JST)
Received: from sm-arm-grace07.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by yto-om1.fujitsu.com (Postfix) with ESMTP id 5FC4240059D52;
	Fri, 11 Jul 2025 16:17:18 +0900 (JST)
From: Koichi Okuno <fj2767dz@fujitsu.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Koichi Okuno <fj2767dz@fujitsu.com>
Subject: [PATCH v6 0/2] perf: Fujitsu: Add Uncore MAC/PCI PMU driver
Date: Fri, 11 Jul 2025 16:13:38 +0900
Message-ID: <20250711071404.2138816-1-fj2767dz@fujitsu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds two new dynamic PMUs to the Perf Events framework to program
and control the Uncore MAC/PCI PMUs in Fujitsu chips.

These drivers were created with reference to drivers/perf/qcom_l3_pmu.c.

These drivers export formatting and event information to sysfs so they can
be used by the perf user space tools with the syntaxes:

perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
perf stat -e mac_iod0_mac0_ch0/event=0x80/ ls

perf stat -e pci_iod0_pci0/ea-pci/ ls
perf stat -e pci_iod0_pci0/event=0x80/ ls

FUJITSU-MONAKA PMU Events Specification v1.1 URL:
https://github.com/fujitsu/FUJITSU-MONAKA

Changes in v6:
- Modify the code as suggested. (Peter Zijlstra)
  - Added PERF_PMU_CAP_NO_INTERRUPT which means not being able to sample.
- Link to v5:https://lore.kernel.org/all/20250617102819.3685543-1-fj2767dz@fujitsu.com/

Koichi Okuno (2):
  perf: Fujitsu: Add the Uncore MAC PMU driver
  perf: Fujitsu: Add the Uncore PCI PMU driver

 .../admin-guide/perf/fujitsu_mac_pmu.rst      |  73 +++
 .../admin-guide/perf/fujitsu_pci_pmu.rst      |  50 ++
 Documentation/admin-guide/perf/index.rst      |   2 +
 drivers/perf/Kconfig                          |  18 +
 drivers/perf/Makefile                         |   2 +
 drivers/perf/fujitsu_mac_pmu.c                | 569 ++++++++++++++++++
 drivers/perf/fujitsu_pci_pmu.c                | 553 +++++++++++++++++
 7 files changed, 1267 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
 create mode 100644 Documentation/admin-guide/perf/fujitsu_pci_pmu.rst
 create mode 100644 drivers/perf/fujitsu_mac_pmu.c
 create mode 100644 drivers/perf/fujitsu_pci_pmu.c

-- 
2.43.0


