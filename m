Return-Path: <linux-kernel+bounces-862971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1020CBF6AED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5873A9BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9982D334C15;
	Tue, 21 Oct 2025 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b="oIsp2Pt1"
Received: from MTA-10-3.privateemail.com (mta-10-3.privateemail.com [198.54.127.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A613346B4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052205; cv=none; b=hrxoQnn3PBK+PJISPo+OiRy+NHfkzuVl85e9l+Gt0L9rlgDoWdwfOyzwqUsBYyFh4PV+sIk5sJEki4uZvHafbA/R8wF+NortG8dot8MUOkylxDLW2N4bjAhDk3oClKGboFPKD99cWurKhUYZkEjB97mBDKH8kPFmVAF/UMouQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052205; c=relaxed/simple;
	bh=EtJgwKHWrSqXIKpl+oPummZQv4uBvd9A2aAOwFth5DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stvDcQJLbnWS/ISxLF+VtkXofMCBI9vFytslDItvq1ie15vos85mUQySNggdn3HdczfUVVsf3zg84Js4h3F6pL+Tjn4PtNQ4X/nmYzFMiPDyt5vUGawp8w2OYOp1yipKBbmHfiCd9SKS3mxHkT/BOge9ajrwx2LT9+Mx7uzHUlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev; spf=pass smtp.mailfrom=lukowski.dev; dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b=oIsp2Pt1; arc=none smtp.client-ip=198.54.127.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukowski.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lukowski.dev;
	s=default; t=1761052202;
	bh=EtJgwKHWrSqXIKpl+oPummZQv4uBvd9A2aAOwFth5DA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oIsp2Pt114RPjV9Knsd67Lasq34XG5ujJTuS/6lsAHKmiDrf0Lkh3Nrugy5G7zhAp
	 TwV1P2mFJ3HsjZB7tyjGvVa5zW28Ximjeq1VjPueVMuv7eZMgU09qD+zkOwIZvr+UP
	 Abn0s2etAxpF1WIoH5Q1SLfkVZYlCzocLcXJtn+JuTNWvgwzQJViSPplLD+TcWHAmu
	 FL6Ppl20lGIss2Y/e3W/yiVc8HdvWPqlhpW4scTUFFG/XYr2qyPcU32GsIeli5t3Gb
	 SGOWQfFqb8V8YFUTMBh4NDB84aBznkw5l3j7PhHpCpwucoLkUzRUJFuz2nN9Rkp1r5
	 T5EPROytroBTQ==
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
	by mta-10.privateemail.com (Postfix) with ESMTP id 4crXhV48GYz3hhTw;
	Tue, 21 Oct 2025 09:10:02 -0400 (EDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [150.228.61.72])
	by mta-10.privateemail.com (Postfix) with ESMTPA;
	Tue, 21 Oct 2025 09:09:54 -0400 (EDT)
From: Olle Lukowski <olle@lukowski.dev>
Date: Tue, 21 Oct 2025 16:09:28 +0300
Subject: [PATCH v2 1/3] staging: most: i2c: replace BUG_ON() with proper
 checks and error returns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-staging-most-warn-v2-1-cd51e1e717f6@lukowski.dev>
References: <20251021-staging-most-warn-v2-0-cd51e1e717f6@lukowski.dev>
In-Reply-To: <20251021-staging-most-warn-v2-0-cd51e1e717f6@lukowski.dev>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Christian Gromm <christian.gromm@microchip.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Olle Lukowski <olle@lukowski.dev>
X-Mailer: b4 0.14.3
X-Virus-Scanned: ClamAV using ClamSMTP

Replace BUG_ON() checks for invalid channel indices with proper checks
and return -EINVAL to avoid crashing the kernel unnecessarily.

Signed-off-by: Olle Lukowski <olle@lukowski.dev>
---
 drivers/staging/most/i2c/i2c.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2c.c
index 184b2dd11..db806b00d 100644
--- a/drivers/staging/most/i2c/i2c.c
+++ b/drivers/staging/most/i2c/i2c.c
@@ -71,7 +71,8 @@ static int configure_channel(struct most_interface *most_iface,
 	struct hdm_i2c *dev = to_hdm(most_iface);
 	unsigned int delay, pr;
 
-	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
+	if (ch_idx < 0 || ch_idx >= NUM_CHANNELS)
+		return -EINVAL;
 
 	if (channel_config->data_type != MOST_CH_CONTROL) {
 		pr_err("bad data type for channel %d\n", ch_idx);
@@ -125,7 +126,8 @@ static int enqueue(struct most_interface *most_iface,
 	struct hdm_i2c *dev = to_hdm(most_iface);
 	int ret;
 
-	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
+	if (ch_idx < 0 || ch_idx >= NUM_CHANNELS)
+		return -EINVAL;
 
 	if (ch_idx == CH_RX) {
 		/* RX */
@@ -170,7 +172,8 @@ static int poison_channel(struct most_interface *most_iface,
 	struct hdm_i2c *dev = to_hdm(most_iface);
 	struct mbo *mbo;
 
-	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
+	if (ch_idx < 0 || ch_idx >= NUM_CHANNELS)
+		return -EINVAL;
 
 	if (ch_idx == CH_RX) {
 		if (!polling_rate)

-- 
2.51.1


