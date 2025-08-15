Return-Path: <linux-kernel+bounces-770128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E486FB27717
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFF85E78C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D641222B8BD;
	Fri, 15 Aug 2025 03:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="alvq1nAV"
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB11514F7;
	Fri, 15 Aug 2025 03:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229765; cv=none; b=A1DTa+dWPQI94YVp094oy36OoMfGhqHqUR90z3mSh8w69oWxqb/PVV7J2qtF7T9g2WXOwn9AaisCtIY8w8tqZ/ytKlKjv/7MPyVW4vjCTwWad4T+J23MePSBcjtSzUqrYxOvqLG3jN/ueO8UplJ8ueal/CE7ikvicG24MGonato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229765; c=relaxed/simple;
	bh=vb+8+cI/6mN9k6R4rO9pApJyDljK42JSjMf6BVyNR6M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=r8nVZ+CX3FTrj3B3ed3Qwhsyn8Wtlb7HjCHk9ogRGkBXNDOOjfdQrpuOsOVYviQNdffbbrDHhTukEJu8u80J9G0LYKSiHleCrS/X4EhU65yIDXaIwcsUapcHVieyhW4Yat0SZltie97N7Kg/INBHsHtIcewRotEIkqqoBO4j7PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=alvq1nAV; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1755229764; x=1786765764;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vb+8+cI/6mN9k6R4rO9pApJyDljK42JSjMf6BVyNR6M=;
  b=alvq1nAVfQOUNU2+vrxvWGvPo93HRgNGbSNxV7+xVtni6zkU5hCX8a2k
   fLo+s2277fTXaniNDzRUBanu8WJ0BT+qRXHMkwvrXKu/29zezYTb43XTT
   18gQuZowdXCaJKkQd3+P/6+iglXSft5jcTzyx+AYfTwAWMGruDjG+XKpr
   EcaPYD6fcYsThOWbUZtFvnORLbueg8aWS6HGWfq+lEQ4UM5n3paIPzoMV
   1SU+ltkfFLJ6z+Hfon5duJNEUnonGVeLwk/Br2lofuyx8CQ8qlcMjf0xt
   ONsNTJKM+GHH8oEYeSDQU3yYm/Gvb56pHDE42jJpZ2T3tJKBnVQnQmWzS
   g==;
X-CSE-ConnectionGUID: IORzhdfbS3yqLEvLmmHhAw==
X-CSE-MsgGUID: l7AKp4JeS32A2x+UEUaj0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="212714369"
X-IronPort-AV: E=Sophos;i="6.17,290,1747666800"; 
   d="scan'208";a="212714369"
Received: from unknown (HELO az2nlsmgr1.o.css.fujitsu.com) ([20.61.8.234])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 12:48:12 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr1.o.css.fujitsu.com (Postfix) with ESMTPS id 2FCF11C00099;
	Fri, 15 Aug 2025 03:48:12 +0000 (UTC)
Received: from az2nlsmom1.o.css.fujitsu.com (az2nlsmom1.o.css.fujitsu.com [10.150.26.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id DBB651810851;
	Fri, 15 Aug 2025 03:48:11 +0000 (UTC)
Received: from sm-arm-grace07.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by az2nlsmom1.o.css.fujitsu.com (Postfix) with ESMTP id ED482829192;
	Fri, 15 Aug 2025 03:48:03 +0000 (UTC)
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
Subject: [PATCH v7 0/2] perf: Fujitsu: Add Uncore MAC/PCI PMU driver
Date: Fri, 15 Aug 2025 12:47:27 +0900
Message-ID: <20250815034751.3726963-1-fj2767dz@fujitsu.com>
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

Changes in v7:
- Modify the code as suggested. (Jonathan Cameron)
  - Renamed the macros name to make it clear which register it applies to.
  - Deleted unused macro.
  - Changed some programming styles as suggested.
  - I tested using v6.17-rc1 and confirmed that I get the same results
    as before the macro name change.
- Link to v6:https://lore.kernel.org/all/20250711071404.2138816-1-fj2767dz@fujitsu.com/

Signed-off-by: Koichi Okuno <fj2767dz@fujitsu.com>

Koichi Okuno (2):
  perf: Fujitsu: Add the Uncore MAC PMU driver
  perf: Fujitsu: Add the Uncore PCI PMU driver

 .../admin-guide/perf/fujitsu_mac_pmu.rst      |  73 +++
 .../admin-guide/perf/fujitsu_pci_pmu.rst      |  50 ++
 Documentation/admin-guide/perf/index.rst      |   2 +
 drivers/perf/Kconfig                          |  18 +
 drivers/perf/Makefile                         |   2 +
 drivers/perf/fujitsu_mac_pmu.c                | 552 ++++++++++++++++++
 drivers/perf/fujitsu_pci_pmu.c                | 536 +++++++++++++++++
 7 files changed, 1233 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
 create mode 100644 Documentation/admin-guide/perf/fujitsu_pci_pmu.rst
 create mode 100644 drivers/perf/fujitsu_mac_pmu.c
 create mode 100644 drivers/perf/fujitsu_pci_pmu.c

-- 
2.43.0


