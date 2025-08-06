Return-Path: <linux-kernel+bounces-757326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6C8B1C0D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEABA4E3021
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38E5220F2A;
	Wed,  6 Aug 2025 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Um4s4hL1"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E82215F7D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463637; cv=none; b=lJayNrgppcF/FaMRDqUOVEdpxv3stPMHHRtHv0gKqChoUGUwscBPOXMHYEPA3GWOCJOaPwXSokldBVmQYpv2wq6NDaEOj+SdybMLVeoyymskXLP0P3bIYhpObfhvETbZjhoBqhNg+jaXS3cU/hm40YboVd5Yibeuv67yBt06/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463637; c=relaxed/simple;
	bh=+MWHStb0ww9VLUM3N1AKvx3gYFWe3/t3UW8FAD65ZWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ahXe0TqlsfAhfgoxEVlpR8QRPqUfz1Uk+tguCR1AWjgJ5tQRRRvc/HYiycLPb4P5bfo/QgebI8Y22aKDCEzpCFbImGTu8qLHTzB6xr/wsr/SmbRFYmia0mF87Il7OKEgaYmwszUPZygB5fEMwAOa7BiVYD/mgemfwDo6LCzjm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Um4s4hL1; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250806070031epoutp02b08e4050912fb1a217ed0d3c3f5d6152~ZG2Cuk-wR0839208392epoutp02Q
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:00:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250806070031epoutp02b08e4050912fb1a217ed0d3c3f5d6152~ZG2Cuk-wR0839208392epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754463631;
	bh=Vjz8oWdZc5/ymEPuFGcDwtJQ2WD6c0Qv4Cx8RnrFpVY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Um4s4hL1j+xTRmGFUMrCdMItLKXPVYActD8B13OaF6qRs31zZ5xG3YW8P4qxcmtwJ
	 dxuBNDYIQwdUuaDGhFqwWOROXYMwgo1jJShousXPYhUXkgV34bGlDycoYu1NPJZFJ/
	 kUyKIicmSijtk/plTfqHmCyeV2t33rN+iHCAnqZg=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20250806070031epcas2p475e68bca23c7e30d16f11b01aa495009~ZG2CJLkJg2311523115epcas2p4S;
	Wed,  6 Aug 2025 07:00:31 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.99]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bxh5B2yP6z2SSKZ; Wed,  6 Aug
	2025 07:00:30 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250806070029epcas2p18a80cf9215e331012e0ed4890cdae700~ZG2AsvPPN3143031430epcas2p1U;
	Wed,  6 Aug 2025 07:00:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [10.229.9.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250806070029epsmtip2f4934ba8b8bde9cb0018a76809e0e8bd~ZG2Aow3U-2292322923epsmtip24;
	Wed,  6 Aug 2025 07:00:29 +0000 (GMT)
From: Sangwook Shin <sw617.shin@samsung.com>
To: krzk@kernel.org, alim.akhtar@samsung.com, wim@linux-watchdog.org,
	linux@roeck-us.net, semen.protsenko@linaro.org, dongil01.park@samsung.com,
	khwan.seo@samsung.com
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, Sangwook Shin
	<sw617.shin@samsung.com>
Subject: [PATCH v5 0/5] Increase max timeout value of s3c2410 watchdog
Date: Wed,  6 Aug 2025 15:55:09 +0900
Message-Id: <20250806065514.3688485-1-sw617.shin@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250806070029epcas2p18a80cf9215e331012e0ed4890cdae700
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,N
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250806070029epcas2p18a80cf9215e331012e0ed4890cdae700
References: <CGME20250806070029epcas2p18a80cf9215e331012e0ed4890cdae700@epcas2p1.samsung.com>

The ExynosAutoV9 and ExynosAutoV920 SoCs have a 32-bit counter register,
but due to code constraints, only 16-bit values could be used.
This series enables these SoCs to use the 32-bit counter.
Additionally, it addresses the issue where the ExynosAutoV9 SoC supports
the DBGACK bit but it was not set.

V4->V5:
  - Update s3c2410wdt_max_timeout with Sam Protsenko and Guenter Roeck's sugestion.
  - Break [v4 3/4] into two [v5 3/5] and [v5 4/5].
  - Rename S3C2410_WTCNT_MAXCNT to S3C2410_WTCNT_MAXCNT_16.
  - Rename QUIRK_HAS_32BIT_MAXCNT to QUIRK_HAS_32BIT_CNT.
  - Minor Typographical Errors and Style Adjustments.
  - Link to v4:
    https://lore.kernel.org/linux-watchdog/20250724080854.3866566-1-sw617.shin@samsung.com/

V3->V4:
  - Merge patches [v3 3/5] and [v3 4/5] into one so that Quirk and its consumer
    are part of the same patch.
  - Link to v3:
    https://lore.kernel.org/linux-watchdog/20250714055440.3138135-1-sw617.shin@samsung.com/
    https://lore.kernel.org/linux-watchdog/20250515075350.3368635-1-sw617.shin@samsung.com/

V2->V3:
  - Correct the incorrect tag information.
  - Link to v2:
    https://lore.kernel.org/linux-watchdog/20250514094220.1561378-1-sw617.shin@samsung.com/

V1->V2:
  - Modify the max_timeout calculation considering overflow
  - Separate tha max_timeout calculation into a separate patch
  - Add max_cnt in struct s3c2410_wdt
  - Set max_cnt once in probe function
  - Add patch that uses S3C2410_WTCON_PRESCALE_MAX instead of hardcoded one
  - Remove unnecessary inner parentheses
  - Link to v1:
    https://lore.kernel.org/linux-watchdog/20250513094711.2691059-1-sw617.shin@samsung.com/

Sangwook Shin (5):
  watchdog: s3c2410_wdt: Replace hardcoded values with macro definitions
  watchdog: s3c2410_wdt: Fix max_timeout being calculated larger
  watchdog: s3c2410_wdt: Increase max timeout value of watchdog
  watchdog: s3c2410_wdt: exynosautov920: Enable QUIRK_HAS_32BIT_CNT
  watchdog: s3c2410_wdt: exynosautov9: Enable supported features

 drivers/watchdog/s3c2410_wdt.c | 45 ++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 13 deletions(-)

-- 
2.25.1


