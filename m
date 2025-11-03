Return-Path: <linux-kernel+bounces-882877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12467C2BB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 741D234AA6D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FC8313555;
	Mon,  3 Nov 2025 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A5uMosam"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33A313529
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173300; cv=none; b=Lx31Nu5p0UFTg0FvEWplbffzp/+C5kI1gtugb61z3+e0VrT3siQiWhs6yXD0k+4mQf+tQqPZn82P5e/7VB3VSn3BCqZEDWcyzPen2qoZ4RkG9zYeCz/w8rzZ3jWqJqUssQs7iOTxQMWdofvr5Ud1+gLd4z0IynoP61myRYDYPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173300; c=relaxed/simple;
	bh=3xgW8eyVg87uFaJOm5qQHzSf/P3kQbF4L7YN8xrhMwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YfobYqrce0WMiug6EC5F7BSQ9RO/+Ga6XT5XImJ/Tc2xzv0nt7kC9uqInT50Q0hz/nhoVDGefYp7vya1IT6Usr+rqjhoExgZUXSCj8GNfZfWyeCxcoQZomOucc8gNh1BqxguQasWmn4rhMX06ekfCrh0F9TQVb5XXcTbO4YgZAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A5uMosam; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762173295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ekl/iI2jfKdLyx4UNHPO1Gy4FnWkFCcqmusmBDMu+SA=;
	b=A5uMosamz/hWU9VPGH6yg/vgDrPF0de1ibFokwH4UGGtpA2cUABHoqcgD6BdnYDefR29X9
	FKZZnBYvAwipZ4w1K3Tw3PXrUpWM4C5NFbhy847tfu4JY9C2dxadzWxnTEZhihOxfxlWh2
	W/bMtIctRTEQ6rooXyjHmKrcGWToVDM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Michael Hennerich <michael.hennerich@analog.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: ad525x_dpot: Replace sprintf with sysfs_emit in sysfs_show_reg
Date: Mon,  3 Nov 2025 13:34:03 +0100
Message-ID: <20251103123403.62076-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() in sysfs_show_reg(). sysfs_emit() is
preferred for formatting sysfs output as it provides better bounds
checking.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/ad525x_dpot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ad525x_dpot.c b/drivers/misc/ad525x_dpot.c
index 04683b981e54..519f97089a00 100644
--- a/drivers/misc/ad525x_dpot.c
+++ b/drivers/misc/ad525x_dpot.c
@@ -419,7 +419,7 @@ static ssize_t sysfs_show_reg(struct device *dev,
 	s32 value;
 
 	if (reg & DPOT_ADDR_OTP_EN)
-		return sprintf(buf, "%s\n", str_enabled_disabled(
+		return sysfs_emit(buf, "%s\n", str_enabled_disabled(
 			test_bit(DPOT_RDAC_MASK & reg, data->otp_en_mask)));
 
 	mutex_lock(&data->update_lock);
@@ -437,9 +437,9 @@ static ssize_t sysfs_show_reg(struct device *dev,
 	 */
 
 	if (reg & DPOT_REG_TOL)
-		return sprintf(buf, "0x%04x\n", value & 0xFFFF);
+		return sysfs_emit(buf, "0x%04x\n", value & 0xFFFF);
 	else
-		return sprintf(buf, "%u\n", value & data->rdac_mask);
+		return sysfs_emit(buf, "%u\n", value & data->rdac_mask);
 }
 
 static ssize_t sysfs_set_reg(struct device *dev,
-- 
2.51.1


