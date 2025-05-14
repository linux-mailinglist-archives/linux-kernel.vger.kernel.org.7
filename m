Return-Path: <linux-kernel+bounces-647786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB54AB6D59
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 15:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46CA9A008F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85DD27AC39;
	Wed, 14 May 2025 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lLkhrenp"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E1275106
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230760; cv=none; b=oK1mcV11U/03XsIBEnOoOog9NuuiQROmlTQiJaxmjdjf3pgc9GrzWzlpkerSvDODxwlYJ1+JUD9ZbsFNekeGGO3JA5Urf+2GDylbKgrkzbb6Y6ht/CBI5oshTM05nF0nsNYy7IOPXg14OC4FiDwgiKmo5pP7Ln4LFzFIziMc6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230760; c=relaxed/simple;
	bh=sk9+Hmx76K9353/YSJ7f5CerbKr8aapCJIG+K320SkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=itSSMF3j89Gjgp+zw5ryhErk2+yHC/YP9btpgvnyBxMjucWw1ldLEEw/lc8rGjc+u6hiQEEy4F3vW3f3WgebFuty240kj1umAo6EeCeQkvP0/mjxcAqX3Qj00TVz+stOAOd9B1SZbn1UN3hAYL+ykZYE8JA/lyCFLdvbhIhmHiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lLkhrenp; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250514135234epoutp01c6a00b2e00ee8b9f6d3a8235cc2bad6c~-aR07ZmQC3198031980epoutp01G
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 13:52:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250514135234epoutp01c6a00b2e00ee8b9f6d3a8235cc2bad6c~-aR07ZmQC3198031980epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747230754;
	bh=fS6WP64nxk5RGLAeXo0j9rsjSAjpHA9bB1CIdrtYv24=;
	h=From:To:Cc:Subject:Date:References:From;
	b=lLkhrenpf4Ang8OJcMujjFvGUsmln4m5a0oWv9u2tKHHC8Q+egyTspbQWDmdF0+iX
	 ZG2sijOPbFyVC0MAD4gfvJG5qqJrnqOBvgggrIh+RQSVkoGt3q2lN9Xrx1vsecUSwd
	 qJLNgnGpZgebvt0EJedbmnQecu88JePj0s30AGEU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250514135233epcas5p2cd9c912a0768e52b0bb584a54b97caca~-aR0NkYDl1501215012epcas5p2p;
	Wed, 14 May 2025 13:52:33 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.178]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4ZyFCN0GBvz3hhT3; Wed, 14 May
	2025 13:52:32 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250514095233epcas5p3f51037e71e60a1e690709f8497606385~-XAQ6OqjD2612726127epcas5p3Q;
	Wed, 14 May 2025 09:52:33 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250514095233epsmtrp1fbfec6ef430e6f4547e13f7a873b93dd~-XAQ3FzyG1927519275epsmtrp1D;
	Wed, 14 May 2025 09:52:33 +0000 (GMT)
X-AuditID: b6c32a52-40bff70000004c16-01-682467e1cbba
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	5E.35.19478.1E764286; Wed, 14 May 2025 18:52:33 +0900 (KST)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250514095230epsmtip2a60aed22479ca7753f78aa377417c155~-XAOEOn-v1808418084epsmtip2i;
	Wed, 14 May 2025 09:52:30 +0000 (GMT)
From: Raghav Sharma <raghav.s@samsung.com>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	sunyeal.hong@samsung.com, shin.son@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	dev.tailor@samsung.com, chandan.vn@samsung.com, karthik.sun@samsung.com,
	Raghav Sharma <raghav.s@samsung.com>
Subject: [PATCH v2 0/3] Add clock support for CMU_HSI2
Date: Wed, 14 May 2025 15:32:11 +0530
Message-Id: <20250514100214.2479552-1-raghav.s@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvO7DdJUMgztrFC0ezNvGZjHhS4TF
	mr3nmCyuf3nOanFvxzJ2i/lHzrFaNM54w2Rx/vwGdotNj6+xWnzsucdqcXnXHDaLGef3MVlc
	POVqcWyBmMX3lXcYLY6cecFs8X/PDnaLw2/aWS3+XdvIYjH5+FpWi6Zl65kcRD3e32hl99g5
	6y67x6ZVnWwem5fUe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGu8ehBW/4Kv6v2MzewLie
	p4uRk0NCwESib/Vi1i5GLg4hge2MEl8+HWSBSEhI7Pv/mxHCFpZY+e85O0TRW0aJ9xMPMoMk
	2AS0JK5sf8cGkhAR6GKSOPfvFVg3s8BOJomV6yVAbGEBM4llV9aCxVkEVCV6zs9kArF5Bawl
	blzvhdomL7H/4FlmiLigxMmZT6DmyEs0b53NPIGRbxaS1CwkqQWMTKsYRVMLinPTc5MLDPWK
	E3OLS/PS9ZLzczcxgqNFK2gH47L1f/UOMTJxMB5ilOBgVhLhvZ6lnCHEm5JYWZValB9fVJqT
	WnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXANN8ieoat3X+PUqv5T9+yX46yWOGQ
	HnJvxnfP13qP5IzEJe/kK+f3/F///LV+1ifVnjIPhzCxxTLMK9SX9TXuvsniW7i4ckb8HKfE
	Td86dlj5++1SFDu6+a/woY5o3qppWdyC0u81d2gvYZSza7n7jnH/qbSjniEbeZ7f35G7YF/7
	p2/PL+kuedCfdav5q/LXxqdVj/YWdeY0fWnxEDEXFYv3ndwz4+LiymKez22RUyNr/I13rutf
	1MDjXnJD59acx2p/9l2ds+f+kbNq9SLOZj6vGdxv5jkk7xVpqNRpU2Y+nbFso6zfW3aZFrb9
	LAl/XhxrrO29qHsj3n5DiczR48tvRj4ofSe7yYJp9dY5SizFGYmGWsxFxYkAP1DrSAUDAAA=
X-CMS-MailID: 20250514095233epcas5p3f51037e71e60a1e690709f8497606385
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250514095233epcas5p3f51037e71e60a1e690709f8497606385
References: <CGME20250514095233epcas5p3f51037e71e60a1e690709f8497606385@epcas5p3.samsung.com>

This series adds clock support for the CMU_HSI2 block.

Patch[1/3]: dt-bindings: clock: exynosautov920: add hsi2 clock definitions
        - Adds DT binding for CMU_HSI2 and clock definitions

Patch[2/3]: clk: samsung: exynosautov920: add block hsi2 clock support
        - Adds CMU_HSI2 clock driver support

Patch[3/3]: arm64: dts: exynosautov920: add CMU_HSI2 clock DT nodes
        - Adds dt node for CMU_HSI2

Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
---
Changes in v2:
- Added cover letter with the patches
- Submit the patches as a series as they are inter-dependent
  as pointed by Krzysztof Kozlowski

Links to v1:
[1/3]: https://lore.kernel.org/all/20250509132414.3752159-1-raghav.s@samsung.com/
[2/3]: https://lore.kernel.org/all/20250509131210.3192208-1-raghav.s@samsung.com/
[3/3]: https://lore.kernel.org/all/20250509125646.2727393-1-raghav.s@samsung.com/

I also got warning about build failure from robot
Link: https://lore.kernel.org/all/202505100814.gnMY3LoZ-lkp@intel.com/ 

As the fix is  just a new version of
the same patch/commit, there is NO need to add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505100814.gnMY3LoZ-lkp@intel.com/

So for now, not adding Reported-by: tag

Raghav Sharma (3):
  dt-bindings: clock: exynosautov920: add hsi2 clock definitions
  clk: samsung: exynosautov920: add block hsi2 clock support
  arm64: dts: exynosautov920: add cmu_hsi2 clock DT nodes

 .../clock/samsung,exynosautov920-clock.yaml   | 29 +++++++-
 .../arm64/boot/dts/exynos/exynosautov920.dtsi | 17 +++++
 drivers/clk/samsung/clk-exynosautov920.c      | 72 +++++++++++++++++++
 .../clock/samsung,exynosautov920.h            |  9 +++
 4 files changed, 125 insertions(+), 2 deletions(-)


base-commit: aa94665adc28f3fdc3de2979ac1e98bae961d6ca
-- 
2.34.1


