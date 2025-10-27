Return-Path: <linux-kernel+bounces-871308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF6FC0CDE9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B3419A4F16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B5729D28B;
	Mon, 27 Oct 2025 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wZxztD2J"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856B1DDF7
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559398; cv=none; b=HyLdujK2DgaGqXH6yLYiloIid6JE/ogcZdHNoLXmOhIb6juvRHiVU/n1QtN5TH47/WERJLPy4X4MZwkZMgHv8Gn0HaqAF32Qo+tGNu8sWghWOgk2NymWMefbXrotucEZ924/QtDPzo2G0dzZR0WsRTIymm6NpVGn7ZNclNlIzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559398; c=relaxed/simple;
	bh=UsbQ+WpNw9QU0fwNOFzFvjbwLtYCNOqGCHRn0w4LmJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UP6mcldrNusEx9k0xTRKx+sJwi9jnyJku8sE4eRUaL78Q/sQJJeuQTeaWo8jbRoPODElnKJQsXQ3msnkTTq6t1Qythl7UIyfbc2s3bhftOHU50AKNcUqIk7rd9x4yGYPZZu2USHJXPAg7FpS0zF7WGV57Hs+psuJiIOZMncppVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wZxztD2J; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59RA38Ld8517210, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761559389; bh=ErEJPFULfCUiNvY/AdDxJrKkzG/dT+C+SOULSA5VLxI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=wZxztD2JlXnEpVR5wPHsmywN7YWc680+ui5qCJ22ASLz9KGb0EXgnP26jjDKcRloV
	 cFBms+UXlyp/L0HZOXqrvW1CVx7OgbjDxyc66rGJbYVg4tWISGIqbi41wmZA8j5OoN
	 P9wFMMspi2Bq5Pkgb05wFHDsINaqxGDPyoDj41PbrtkfBmtgFgC2HNI6Z4PbyTMC7M
	 IXrNz8uiXQr+8FrOyp2DKQko2oT11QHe+UR5/LJY454erjUIx0Saj9GIEmOz+Oo8xe
	 wR2E6ffjgIuVWNVP+crKCu/qVJ6bcwqLM7QcPS7Vqs7kUKcqP1TPUEYYjj3GDiip6F
	 V4jLX9ftDuKSg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59RA38Ld8517210
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 18:03:09 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 27 Oct 2025 18:03:09 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server id 15.2.1544.27 via Frontend
 Transport; Mon, 27 Oct 2025 18:03:09 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <cy.huang@realtek.com>,
        <stanley_chang@realtek.com>, <visitorckw@gmail.com>
Subject: [PATCH] mailmap: add entry for Yu-Chun Lin
Date: Mon, 27 Oct 2025 18:03:09 +0800
Message-ID: <20251027100309.22035-1-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Map my personal email to my business email.

Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 717d754b378c..9f44baf4a8b8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -854,6 +854,7 @@ Yakir Yang <kuankuan.y@gmail.com> <ykk@rock-chips.com>
 Yanteng Si <si.yanteng@linux.dev> <siyanteng@loongson.cn>
 Ying Huang <huang.ying.caritas@gmail.com> <ying.huang@intel.com>
 Yosry Ahmed <yosry.ahmed@linux.dev> <yosryahmed@google.com>
+Yu-Chun Lin <eleanor.lin@realtek.com> <eleanor15x@gmail.com>
 Yusuke Goda <goda.yusuke@renesas.com>
 Zack Rusin <zack.rusin@broadcom.com> <zackr@vmware.com>
 Zhu Yanjun <zyjzyj2000@gmail.com> <yanjunz@nvidia.com>
-- 
2.50.1


