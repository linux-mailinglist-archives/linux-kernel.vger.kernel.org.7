Return-Path: <linux-kernel+bounces-738603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768A3B0BAE7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5283A464F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577CE2101AE;
	Mon, 21 Jul 2025 02:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DGCAMXaB"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E1314D70E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753065985; cv=none; b=tYS5QqN6KZlQt9krTihOhe8+F1uxpxc1zEt1092JgV08TjkvVJ8B20Jhpoz1TuI1DjReTU23JIbwLD+2PLEiJl4b4KqnXtlhIV+jCMCI9UobpCnnqMbNyG/aFfFicf6Do3JW70otykMpmM2dE3VNlRSAJQAUbKeZwuiizWnfanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753065985; c=relaxed/simple;
	bh=Rg4Va32fBAbmtBk6RqlKF8YxDutq1GOM3dDeUTb2uEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ICE2B7EL7WWU/iI812YIH5FMbPVq5BYtsJoiWpOwWtTZqAWaU0YFBCZKKHK/stBbL6N/NNGEMjjA7+irbqUWz5Ij6h+CQ/ZRsBlPOp/dHr9UftGKJEs6DkMgyZTDxcc420I2Cr5+wrq0LFEQIfhyDggpMc9pHGW3AHNeg9ohPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DGCAMXaB; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250721024613epoutp030b936b43de8dcbff22a65988f0b40c93~UJDbmH3rv2248422484epoutp03j
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:46:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250721024613epoutp030b936b43de8dcbff22a65988f0b40c93~UJDbmH3rv2248422484epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753065973;
	bh=ZG238iiqL1oF374QqgAnsl4UhN940jn7kxJw1Y5yyCg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=DGCAMXaBmH8wMXZoYXvCB9eJ0KhjlGitNip8FfYDbAF0LlToCqrg9HjOIyUXXtjr+
	 kUDoVMk9z9WEc6ziDVA06YAEun0MIQoKHYYjgl2oPmJQdyN2TpCeXFoAn9Ekiwj4kg
	 DlZunwq50HukKvveoBWjf3id2f6W2nICc0jxXg4E=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20250721024612epcas2p3f4e5b3b426411163c8327e39d09615f8~UJDbJ9J8J2776427764epcas2p3v;
	Mon, 21 Jul 2025 02:46:12 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.36.99]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bllC76Z9wz6B9mF; Mon, 21 Jul
	2025 02:46:11 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250721024611epcas2p43099e043aaa6f48c05eb0237065d31c7~UJDZ3TRM00521705217epcas2p4m;
	Mon, 21 Jul 2025 02:46:11 +0000 (GMT)
Received: from AProject.dsn.sec.samsung.com (unknown [10.229.9.52]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250721024611epsmtip29239d66d3840037030b3fc786333a782~UJDZzOhmh1443514435epsmtip2D;
	Mon, 21 Jul 2025 02:46:11 +0000 (GMT)
From: ew kim <ew.kim@samsung.com>
To: broonie@kernel.org, s.nawrocki@samsung.com, robh@kernel.org,
	krzk+dt@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
	conor+dt@kernel.org, alim.akhtar@samsung.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Add ExynosAuto ABOX generic platform and PCM support
Date: Mon, 21 Jul 2025 11:30:43 +0900
Message-Id: <20250721023052.3586000-1-ew.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250721024611epcas2p43099e043aaa6f48c05eb0237065d31c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250721024611epcas2p43099e043aaa6f48c05eb0237065d31c7
References: <CGME20250721024611epcas2p43099e043aaa6f48c05eb0237065d31c7@epcas2p4.samsung.com>

This patch series adds the ABOX Generic audio management driver for
Samsung ExynosAuto SoCs, along with IPC messaging and PCM frontend
drivers, including their corresponding device tree bindings.

### ABOX Architecture Design: Fixed and Variable Structure

The ABOX audio framework is designed with a clear split between:
- **Fixed part** (common framework): reusable components across SoCs
  - Generic ABOX platform driver
  - IPC messaging handler
  - PCM frontend with ALSA compressed audio support
  - Solution manager for dynamic control
- **Variable part** (SoC-specific): defined via device tree
  - IRQ numbers, stream IDs, buffer sizes, and ADSP allocation
  - Defined per PCM/IPC device node in DTS

This separation allows the fixed part to be upstreamed and maintained
as a reusable framework, while only the DTS and minimal changes are
needed to adapt to each SoC generation.

### Major Components in This Series

- `abox_generic`: Root platform driver coordinating subcomponents
- `abox_ipc_generic`: Handles ADSP messaging via IRQ-based IPC
- `abox_pcm_dev`: PCM frontend with support for solution chain selection
- `abox_solution_mgr`: Manages software-based audio chains via dynamic
  kcontrols

### Testing

Tested on ExynosAuto v920 board:
- Verified ALSA compressed audio playback via DSP
- Confirmed solution switching via kcontrol
- Verified DT node parsing and IRQ routing from device tree




