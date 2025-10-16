Return-Path: <linux-kernel+bounces-855493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CC0BE16D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 589114E42E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E4F215F42;
	Thu, 16 Oct 2025 04:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b="QQDpsKoP"
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB88113AC1;
	Thu, 16 Oct 2025 04:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760589109; cv=none; b=ObLBb5Bb2U26XcV/b92/0OTwGxwRmPzXL0uTHWgfTovzTs9TLclGhF2eK6lVXU2PJ0RuWxp6uhzhRQXa0F8irdHUEKcqe6zd8GeI7LGwrIVnIkWZKG3T0gPxdhQN4aotYFRWytw0KYlBMDGUCtBHY7ZlNSUw7iATiLiMh48VHd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760589109; c=relaxed/simple;
	bh=0N/vehwtRWCtYehNttI9Ju13qsk5bS7jNthluYyiTec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LnFGoVd5wwK6bqW7fr3XFU+Zy8Rw+aHVZmdDLq4GLe+0thjgDOnQm8yiCvajHuF/mwVUl2xiddR/BhEoloRT3g1j+SmKCoxD4KzEoo9FDX+SAtRG50qppZmXfBwaBaI6GV8yu8sEqTl8sVudNHODRM+2CaJkLOMC9R0ot7Vwn4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b=QQDpsKoP; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 59G1dwDv1579329; Thu, 16 Oct 2025 10:39:59 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;i=
	yuji2.ishikawa@toshiba.co.jp;s=key1.smx;t=1760578757;x=1761788357;bh=0N/vehwt
	RWCtYehNttI9Ju13qsk5bS7jNthluYyiTec=;b=QQDpsKoP6QHf/NneiUqD9ulUIX/13UeB92/+CY
	HNxMMtrvK+i4AFIz9YNviNmmfuOEMv88H9Z2SjFwl07419T6gmhBz85zSMuNgWLipQ4oO+oBdT5RZ
	vC0HKH3agujnME4KLVujZGnKTXiMV0+cydcARqIjGqnmFwBJ2oPmTEDs+9qEAEuqWYGrTxBPeRGfO
	aDrconBZXNtZTZ+XB4gFmxhKB8ShhOzCBOnCX5AXvpAARbysk295/2NVnsoQIOqklnl5H9DGuJwCC
	Xi31EHWIPzBOeICZ5iWOtDe2yi8HlHoiNwPRGGW79Nwh2GtEx/YITl0D93iAMqLNOvuYGLL6A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 59G1dEij409533; Thu, 16 Oct 2025 10:39:15 +0900
X-Iguazu-Qid: 2rWhDxZXiUctHiFsU6
X-Iguazu-QSIG: v=2; s=0; t=1760578754; q=2rWhDxZXiUctHiFsU6; m=At88A02yyMty72IxemKjb6m7fTgZRP/26fXwMLRdT+g=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cn9bh5hcsz1xnZ; Thu, 16 Oct 2025 10:39:12 +0900 (JST)
X-SA-MID: 53068305
From: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] clk: visconti: Add support for VIIF on Toshiba Visconti TMPV770x SoC
Date: Thu, 16 Oct 2025 10:33:26 +0900
X-TSB-HOP2: ON
Message-Id: <20251016013328.303611-1-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for Video Input Interface (VIIF) module to the
clock and reset driver of Toshiba Visconti TMPV770x SoC. It provides the
definition of identifiers for clocks and resets, and the control sequence
of registers.

Yuji Ishikawa (2):
  dt-bindings: clock: Update identifiers for VIIF on Toshiba Visconti
    TMPV770x SoC
  clk: visconti: Add definition of VIIF on Toshiba Visconti TMPV770x SoC

 drivers/clk/visconti/clkc-tmpv770x.c         | 71 ++++++++++++++++++++
 include/dt-bindings/clock/toshiba,tmpv770x.h | 33 ++++++---
 include/dt-bindings/reset/toshiba,tmpv770x.h | 10 ++-
 3 files changed, 102 insertions(+), 12 deletions(-)

-- 
2.43.0



