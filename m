Return-Path: <linux-kernel+bounces-862866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1822EBF662E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10ED18C7B25
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED42E2E7BDF;
	Tue, 21 Oct 2025 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b="wnpwlGxO"
Received: from MTA-08-4.privateemail.com (mta-08-4.privateemail.com [198.54.122.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33018355034
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049039; cv=none; b=ADQuX3H7EkP+gekCJp+jVz28flDniOLTN3QFQEu6MfAMYC7gXSP+7aM3kJgUaoGo5Zt517vXYj5bppklwgOa7RUd9aHM8n6vuVXcmyT8gJ/7I8XAoBdegv4alV1W6TOYixHU82tN/9map/CtH0LyMaAQk50DGW1OGUqoqgMRKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049039; c=relaxed/simple;
	bh=uZv0x3wx3Gxr6XcL+voEowtpQlpNWPH2FnQJC7GDLF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MeGOjxt1GHdYsCiUZ98FGvcTHwisuCwmo2Aof8jEPd1Y+Jh4Pkms3PEGIpSCgjtfdYIUs0g6Df8oQmoAoVp/4AxNeiYjmdzdNCV7OAG0pt7u6iHAVCbY/BlkdQoLdp02a7qGobQM0jcgBvX7bLXcbyLbMi33Swu65aG0k5SbQLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev; spf=pass smtp.mailfrom=lukowski.dev; dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b=wnpwlGxO; arc=none smtp.client-ip=198.54.122.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukowski.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lukowski.dev;
	s=default; t=1761049036;
	bh=uZv0x3wx3Gxr6XcL+voEowtpQlpNWPH2FnQJC7GDLF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=wnpwlGxOAeBGAF4ncvDx0Q/mhgGU54DnGDk+Ih45ycwn12CzJ2aPY9wtNrA/sv3hA
	 ICGsHZjaQ9NarBmIySpMsZue9KZfYHwkPGB8c0WIC+MPLld8sEionioijS3EX+wKMd
	 gxdLA/sodLTzru7Dh1rSBSGM6rnYa16NlnR5bVjMK2Y4WkZEdIn1hX4c7y+q7Ewj15
	 TGdZQWUjxLf2lh58N7THk5gY2Q5KBayg/tBNsqyfzghozyqXzWTlxuNUUe5LIsHhNX
	 JQpX4RzAQUmmQnO9ljLQGgOxpbrl+iOG+rAY0lUbECW2qVUeMd53i9Qb3ToF1eovVt
	 w94Jf+YIm2f/w==
Received: from mta-08.privateemail.com (localhost [127.0.0.1])
	by mta-08.privateemail.com (Postfix) with ESMTP id 4crWWc2NPDz3hhTS;
	Tue, 21 Oct 2025 08:17:16 -0400 (EDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [150.228.61.72])
	by mta-08.privateemail.com (Postfix) with ESMTPA;
	Tue, 21 Oct 2025 08:17:07 -0400 (EDT)
From: Olle Lukowski <olle@lukowski.dev>
Date: Tue, 21 Oct 2025 15:16:27 +0300
Subject: [PATCH 1/3] staging: most: i2c: replace BUG_ON() with
 WARN_ON_ONCE() and return error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-staging-most-warn-v1-1-4cdd3745bbdc@lukowski.dev>
References: <20251021-staging-most-warn-v1-0-4cdd3745bbdc@lukowski.dev>
In-Reply-To: <20251021-staging-most-warn-v1-0-4cdd3745bbdc@lukowski.dev>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Christian Gromm <christian.gromm@microchip.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Olle Lukowski <olle@lukowski.dev>
X-Mailer: b4 0.14.3
X-Virus-Scanned: ClamAV using ClamSMTP

Replace BUG_ON() checks for invalid channel indices with WARN_ON_ONCE()
and return -EINVAL to avoid crashing the kernel unnecessarily.

Signed-off-by: Olle Lukowski <olle@lukowski.dev>
---
 drivers/staging/most/i2c/i2c.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2c.c
index 184b2dd11..b9267c3fc 100644
--- a/drivers/staging/most/i2c/i2c.c
+++ b/drivers/staging/most/i2c/i2c.c
@@ -71,7 +71,8 @@ static int configure_channel(struct most_interface *most_iface,
 	struct hdm_i2c *dev = to_hdm(most_iface);
 	unsigned int delay, pr;
 
-	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
+	if (WARN_ON_ONCE(ch_idx < 0 || ch_idx >= NUM_CHANNELS))
+		return -EINVAL;
 
 	if (channel_config->data_type != MOST_CH_CONTROL) {
 		pr_err("bad data type for channel %d\n", ch_idx);
@@ -125,7 +126,8 @@ static int enqueue(struct most_interface *most_iface,
 	struct hdm_i2c *dev = to_hdm(most_iface);
 	int ret;
 
-	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
+	if (WARN_ON_ONCE(ch_idx < 0 || ch_idx >= NUM_CHANNELS))
+		return -EINVAL;
 
 	if (ch_idx == CH_RX) {
 		/* RX */
@@ -170,7 +172,8 @@ static int poison_channel(struct most_interface *most_iface,
 	struct hdm_i2c *dev = to_hdm(most_iface);
 	struct mbo *mbo;
 
-	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
+	if (WARN_ON_ONCE(ch_idx < 0 || ch_idx >= NUM_CHANNELS))
+		return -EINVAL;
 
 	if (ch_idx == CH_RX) {
 		if (!polling_rate)

-- 
2.51.1


