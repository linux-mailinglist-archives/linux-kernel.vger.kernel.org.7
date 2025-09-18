Return-Path: <linux-kernel+bounces-759742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2598AB1E1D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5724D564C91
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06C11C3BEB;
	Fri,  8 Aug 2025 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="oYqLZcy5"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EEB1361
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754632090; cv=none; b=I3+bmiNpudF3YzExyPbYrBj2jXqjlu1+SbvL4c04E30jburOzMnR1zVJ7LR5CuI9pfassIbWvY3ylVETOuf9MtGJmHfRivWxABDXWcPhSuwq84SB6u17SaHrWmQpsDLkqNgI6CmIht2Yii/fyCy/+00kvl/0DEA3bxB3dH7wPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754632090; c=relaxed/simple;
	bh=FZfUcVWCj3I2r+zl2/DkcarFQJD7ycsvbbR2LoWlsT0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P7jYqlxn1uy2pPyb5BPHrVLRtrgOymowkxeH3LnCjdhvAO4E9H3phICwyuSsUv0VWxGNnp5Kfv/RTlSoDHQ/LhML9PFW38vWKMqiQaLeAiB1rPyxB00KpKy8tkgftYqOZui7JiHuy4RY9JJhqRIpYNwJdzN8lnX/fvy+9s7xaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=oYqLZcy5; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 6A5911015F87
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:09:29 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 6A5911015F87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754631569; bh=FZfUcVWCj3I2r+zl2/DkcarFQJD7ycsvbbR2LoWlsT0=;
	h=Date:From:To:Cc:Subject:From;
	b=oYqLZcy5JnTck7cxlqcD92EA4+qGyIiQALGz6T4m+qpJgs+lOvX5UJYF+Pl7J7Kfe
	 wF4x/uYYP+Tbj6pN5tsZKzNdanQhi9qLeXlPyUG+yqTzLPI2Bv9HM+IQW84pFyRq4H
	 y2/5wTM9oR2ONDjUgzGccqLcDzuYdxW5CfFKqzH8=
Received: (qmail 17226 invoked by uid 510); 8 Aug 2025 11:09:29 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.427798 secs; 08 Aug 2025 11:09:29 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 8 Aug 2025 11:09:24 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 3B52D34155C;
	Fri,  8 Aug 2025 11:09:24 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 0C00F1E814A8;
	Fri,  8 Aug 2025 11:09:24 +0530 (IST)
Date: Fri, 8 Aug 2025 11:09:18 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: pkshih@realtek.com, johannes@sipsolutions.net, rtl8821cerfe2@gmail.com,
	kevin_yang@realtek.com, ku920601@realtek.com,
	gary.chang@realtek.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] net: wireless: rtw8852bt: Use standard helper for string
 choice
Message-ID: <aJWNhu9bAkcjEyb4@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use standard helper str_on_off() defined at string_choices.h in
_dpk_information() to improve code reusability. Reduce hardcoding
of repeated use of the same strings to save code space.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202507282341.drTGfLWA-lkp@intel.com/
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index d0e299803225..b01f921b4224 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -1883,8 +1883,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
 		    path, dpk->cur_idx[path], phy,
-		    rtwdev->is_tssi_mode[path] ? "on" : "off",
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->is_tssi_mode[path]),
+		    str_on_off(rtwdev->dbcc_en),
 		    dpk->bp[path][kidx].band == 0 ? "2G" :
 		    dpk->bp[path][kidx].band == 1 ? "5G" : "6G",
 		    dpk->bp[path][kidx].ch,
-- 
2.34.1


