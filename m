Return-Path: <linux-kernel+bounces-827547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABEEB920C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1398B179743
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E780630214E;
	Mon, 22 Sep 2025 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="kEPjzzsL"
Received: from mail-108-mta73.mxroute.com (mail-108-mta73.mxroute.com [136.175.108.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2C24DCEF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556152; cv=none; b=TQ2syBNLBq+wkbAdEP59m+tGUl6a4x1BsjpNN4EQBp4Z6p1ybYhg/iiwiCS/8pfA4m/v4brWbk7BzByCksrgRztzrH83t+yqNww2bb0P8L1IbqSGq20zpVKf/wJKL9E3up/9xrrZr/0l64z9m+UecSKjMTKEkA81SdhNza1FZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556152; c=relaxed/simple;
	bh=iIGvux50TESzjj1eoSoBdxqakhNVSI5qpVupMzfxtlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdxGqv5qRxYJCu2MDzpmuHrMg1wti0ySFPcRqQT6ZpMBtzne1coRkzQ39QIegozzNqRFsdLLBm2CoxlvSZv+6beVWNY6tgBkX4wheYFGFEk/l0tAwslqyhPp+Im8r8sw7M42RsWOPohVJ54ecBvBg/evld+sal6+GM2tmH/K2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=kEPjzzsL; arc=none smtp.client-ip=136.175.108.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta73.mxroute.com (ZoneMTA) with ESMTPSA id 1997218931c000c244.003
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 22 Sep 2025 15:43:57 +0000
X-Zone-Loop: 0a5e50abfee574fae511fa48df171d359aafaffeedd3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=NL5DazgC+1XFrc/1zvLChWWjytvo0Wn05gD//cJKMlg=; b=kEPjzzsLnI4H
	MEZeVVJQ5OcyoWHHB9eaOmt0tqbq+GrEmJo2TA7QKs4d3YAY2bhSvOo/ph7UYPhG3A7El6qxEhor4
	E5myxq+dlD9Jj7LbQ8dqwTZ9IiYZHW8Z2AGgJ2cjER7XgNlQkvwc+94MWgvzCLFPQViYmJUw2luB5
	o4ZMFONtLcDRpACwfdcmEb33f+R2lSw3T2cMQ/HqLmgMdjNTBEGMXQT9v9TYK6eEjlKzlYAG9lbdX
	tHq8VnYxdTGXecOkDnvbCe8BIzOfRSV2RFdLS5afVwncRSZFg9ZccKY+5KAtYzDj4b4XqlWuim8Yb
	/ppSiyN98iHyi9qfShQQuw==;
From: Josephine Pfeiffer <hi@josie.lol>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Add missing MODULE_DESCRIPTION()
Date: Mon, 22 Sep 2025 17:43:44 +0200
Message-ID: <20250922154344.641438-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: hi@josie.lol

Add missing MODULE_DESCRIPTION() macro to the RTL8723BS SDIO
interface driver to fix the modpost warning.

Fixes modpost warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/rtl8723bs/r8723bs.o

Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index f3caaa857c86..1d0239eef114 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -490,3 +490,5 @@ static void __exit rtw_drv_halt(void)
 	sdio_unregister_driver(&rtl8723bs_sdio_driver);
 }
 module_exit(rtw_drv_halt);
+
+MODULE_DESCRIPTION("Realtek RTL8723BS SDIO WiFi driver");
-- 
2.51.0


