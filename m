Return-Path: <linux-kernel+bounces-833522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF20BA2377
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE3032176B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B7A261573;
	Fri, 26 Sep 2025 02:33:18 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6CD27E;
	Fri, 26 Sep 2025 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758853998; cv=none; b=QayaGN42NZ7QjfbQU99YbAAMhnaiwNxqQLMuPoXKElZZkx0rizwQ3d7yBzzjl+J65JMpXiMgTy2LyFgy2S2hoCp+Vq8nwF6D+gD0Pq5p6gpq1Npeg4B3LDxJR+rPGz2iyBPQtSvi1EYvTiPsHTYVapa++QXs+gtYjC/+NSPLr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758853998; c=relaxed/simple;
	bh=x3PFWaBUPTmQ986Ev/z6aqN2yyGmzhZKttLWMMBIcXc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tzcbAkKTWL7Yu0/o9MCuejZnHQZf3LPXH7jvRxjyX3jcgR7SVhIFr62V1wfPjKTWLaQaUkTYp0C331S8Vvmts7EFdM7esOCpKKi/xqrNgx7JMyi3YlwAGucgaU+S/Xu5uiuCUfhLCRtgqx/in8hgbx2CTAXdmMZVstTq5THZnaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 26 Sep
 2025 10:33:08 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Sep 2025 10:33:08 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add Aspeed AST2700 ehci support
Date: Fri, 26 Sep 2025 10:33:06 +0800
Message-ID: <20250926023308.2890607-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series adds support for the EHCI controller found in Aspeed's
new AST2700 SoC.

v2:
-ehci-platform.c
 - remove ehci_ast2700_platform replace by of_device_id data for
   dma_mask_64.

Ryan Chen (2):
  dt-bindings: usb: ehci: Add Aspeed AST2700 compatible
  usb: ehci: Add Aspeed AST2700 support

 .../devicetree/bindings/usb/generic-ehci.yaml         |  1 +
 drivers/usb/host/ehci-platform.c                      | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.34.1


