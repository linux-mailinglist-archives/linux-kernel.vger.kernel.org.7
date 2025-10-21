Return-Path: <linux-kernel+bounces-862868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B911BF6709
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA225445BD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82831E7C23;
	Tue, 21 Oct 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b="QjUXlhej"
Received: from MTA-08-4.privateemail.com (mta-08-4.privateemail.com [198.54.122.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDB2F12CE
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049050; cv=none; b=LFQsVAsHdRw8VZ7EbshawO2tcGhwk1pxZar6cIoC1WXEG23tWlyIw8rqdp5u6MXYYhbCwR/gCwq6YVw6BcMnKxPI99WPT16IzsSkaBdAJCNGR/mA6P37NLGj9y3Duu+c0/mpmv8GRWirbOVtdSs501AVP3aI8iRSPYGbXs7Lwp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049050; c=relaxed/simple;
	bh=w+GW5NbNovoY2ZgC174ZtXRXKIMdtt5c2zCoL8WbMIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uehe1Pn9uyse4dZDMPbRAVeqswevPEtcr+P29GHU20/3cQCvGPNw18LyyqmYBJ8hHmVg/ZVKnlSTu9xXbURkdi/qY0vxHarabe7XTAb343n/+imOV4jiPLeT7hbP/MQIujxsbSQy8unHGloqyFLNVHe9HMdy25slD8Mpva7s7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev; spf=pass smtp.mailfrom=lukowski.dev; dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b=QjUXlhej; arc=none smtp.client-ip=198.54.122.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukowski.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lukowski.dev;
	s=default; t=1761049044;
	bh=w+GW5NbNovoY2ZgC174ZtXRXKIMdtt5c2zCoL8WbMIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QjUXlhejuWzVLDPd8xKTIVOgXFw77XXHJrcZkU1ltBU2J2rz/qBdgmrjNqH71npH+
	 doMHkMG1tqHSh00lcFT9Hqw/dIhQFutj4lur7J9Ccqe7nb0zteApYhC+KjpQilbVi6
	 cQXLnhNe6siSevirQiMed9Fv8QggCEip91Jt2mN/isToQX/Hb/m2Fub7hkF8dpat7D
	 E6ira6Jp3e+Nss0fVO2tLeBAq3Wxiz2A2RaG/93tLa1xxrOfJkgoa+qZl6mxab9Qlu
	 19Tt1TYhz+MIwncalCB7M0WE31Qr2WTokzu81ihbvc3dba+9kjsCeqGmqk4baoDNd6
	 OTU0tBDU/SPmw==
Received: from mta-08.privateemail.com (localhost [127.0.0.1])
	by mta-08.privateemail.com (Postfix) with ESMTP id 4crWWm5BLBz3hhTc;
	Tue, 21 Oct 2025 08:17:24 -0400 (EDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [150.228.61.72])
	by mta-08.privateemail.com (Postfix) with ESMTPA;
	Tue, 21 Oct 2025 08:17:16 -0400 (EDT)
From: Olle Lukowski <olle@lukowski.dev>
Date: Tue, 21 Oct 2025 15:16:28 +0300
Subject: [PATCH 2/3] staging: most: dim2: replace BUG_ON() with
 WARN_ON_ONCE() and proper error returns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-staging-most-warn-v1-2-4cdd3745bbdc@lukowski.dev>
References: <20251021-staging-most-warn-v1-0-4cdd3745bbdc@lukowski.dev>
In-Reply-To: <20251021-staging-most-warn-v1-0-4cdd3745bbdc@lukowski.dev>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Christian Gromm <christian.gromm@microchip.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Olle Lukowski <olle@lukowski.dev>
X-Mailer: b4 0.14.3
X-Virus-Scanned: ClamAV using ClamSMTP

Replace BUG_ON() calls with WARN_ON_ONCE() to prevent unnecessary kernel
panics. Return appropriate error codes (-EINVAL or -EFAULT) instead of
crashing the system.

Signed-off-by: Olle Lukowski <olle@lukowski.dev>
---
 drivers/staging/most/dim2/dim2.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index dad2abe6c..a9dc3765b 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -166,8 +166,10 @@ static int try_start_dim_transfer(struct hdm_channel *hdm_ch)
 	unsigned long flags;
 	struct dim_ch_state st;
 
-	BUG_ON(!hdm_ch);
-	BUG_ON(!hdm_ch->is_initialized);
+	if (WARN_ON_ONCE(!hdm_ch))
+		return -EINVAL;
+	if (WARN_ON_ONCE(!hdm_ch->is_initialized))
+		return -EINVAL;
 
 	spin_lock_irqsave(&dim_lock, flags);
 	if (list_empty(head)) {
@@ -188,7 +190,11 @@ static int try_start_dim_transfer(struct hdm_channel *hdm_ch)
 		return -EAGAIN;
 	}
 
-	BUG_ON(mbo->bus_address == 0);
+	if (WARN_ON_ONCE(mbo->bus_address == 0)) {
+		spin_unlock_irqrestore(&dim_lock, flags);
+		return -EFAULT;
+	}
+
 	if (!dim_enqueue_buffer(&hdm_ch->ch, mbo->bus_address, buf_size)) {
 		list_del(head->next);
 		spin_unlock_irqrestore(&dim_lock, flags);
@@ -269,8 +275,10 @@ static void service_done_flag(struct dim2_hdm *dev, int ch_idx)
 	unsigned long flags;
 	u8 *data;
 
-	BUG_ON(!hdm_ch);
-	BUG_ON(!hdm_ch->is_initialized);
+	if (WARN_ON_ONCE(!hdm_ch))
+		return;
+	if (WARN_ON_ONCE(!hdm_ch->is_initialized))
+		return;
 
 	spin_lock_irqsave(&dim_lock, flags);
 
@@ -455,7 +463,8 @@ static int configure_channel(struct most_interface *most_iface, int ch_idx,
 	int const ch_addr = ch_idx * 2 + 2;
 	struct hdm_channel *const hdm_ch = dev->hch + ch_idx;
 
-	BUG_ON(ch_idx < 0 || ch_idx >= DMA_CHANNELS);
+	if (WARN_ON_ONCE(ch_idx < 0 || ch_idx >= DMA_CHANNELS))
+		return -EINVAL;
 
 	if (hdm_ch->is_initialized)
 		return -EPERM;
@@ -567,7 +576,8 @@ static int enqueue(struct most_interface *most_iface, int ch_idx,
 	struct hdm_channel *hdm_ch = dev->hch + ch_idx;
 	unsigned long flags;
 
-	BUG_ON(ch_idx < 0 || ch_idx >= DMA_CHANNELS);
+	if (WARN_ON_ONCE(ch_idx < 0 || ch_idx >= DMA_CHANNELS))
+		return -EINVAL;
 
 	if (!hdm_ch->is_initialized)
 		return -EPERM;
@@ -643,7 +653,8 @@ static int poison_channel(struct most_interface *most_iface, int ch_idx)
 	u8 hal_ret;
 	int ret = 0;
 
-	BUG_ON(ch_idx < 0 || ch_idx >= DMA_CHANNELS);
+	if (WARN_ON_ONCE(ch_idx < 0 || ch_idx >= DMA_CHANNELS))
+		return -EINVAL;
 
 	if (!hdm_ch->is_initialized)
 		return -EPERM;

-- 
2.51.1


