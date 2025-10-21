Return-Path: <linux-kernel+bounces-862972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9527EBF6AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7731619A4D07
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9A4335079;
	Tue, 21 Oct 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b="aFIoQ+sP"
Received: from MTA-10-3.privateemail.com (mta-10-3.privateemail.com [198.54.127.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C253346B4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052213; cv=none; b=WukoaQzMRdVTWuVRAYWGPnxfX6jWV8kHKj6bHS7MMO4a/ivUvtW5kqD+IH+7LsED3QoEspGegBYpfiI8TiBxykq4uFTkcZsipkBGxpZdvm10w5lRdsiFZzCySzzkSGQt/W5sEPCltQsG9LR6wf48P3qpS4BPPXs8wDezyVz7rc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052213; c=relaxed/simple;
	bh=zMYcIjcZ5Qko2lWukNtIxUtnji9kjjaAHKDaJMAjepw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TulR8x7GgNFe6MqeCEs2vXwpQmNCpn6ktShjJXe2STPX7123HNqlN9DH1XqG/wyghBHz1/YIsIIfO/Ros4maaZ61lOu62HVknsZd7Qc394R8e2wPzNA5JeQRnNx802thElpWz9ZCNSLADs+luhHtZ0qCQ7+59OgJ/TBetRSPfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev; spf=pass smtp.mailfrom=lukowski.dev; dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b=aFIoQ+sP; arc=none smtp.client-ip=198.54.127.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukowski.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lukowski.dev;
	s=default; t=1761052211;
	bh=zMYcIjcZ5Qko2lWukNtIxUtnji9kjjaAHKDaJMAjepw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aFIoQ+sPTXKjmQJogO267nHC9rTAvjifSRiogPQJL/iARjT/cndO6CLC0AxtkSyRq
	 YUjl7wVmMozVDXWCaCJaP/WE47x71IdVAciK0AUYg9JVoCJ/CA54/jRIfdOYRATZSV
	 8RPI9jL8HudF3PWFUl5+qmdpjKMgiEMawOEGnk5PXpO/pEcd7qZ4VNFDdje15/tDvp
	 ba1zf70Gn4sg8KUKBjq6l7GVSR4gk7WocVc07vFejUDNLAqq/D3hvApl0exwww+64+
	 BQlq0N1xra6yRUfj7t4sYubAs9/AAG5ZEZ3k2BzOEvErXQyGYKB1nE/TjG6+FONdTh
	 PvI9IyuGNmwxA==
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
	by mta-10.privateemail.com (Postfix) with ESMTP id 4crXhg2q46z3hhV0;
	Tue, 21 Oct 2025 09:10:11 -0400 (EDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [150.228.61.72])
	by mta-10.privateemail.com (Postfix) with ESMTPA;
	Tue, 21 Oct 2025 09:10:02 -0400 (EDT)
From: Olle Lukowski <olle@lukowski.dev>
Date: Tue, 21 Oct 2025 16:09:29 +0300
Subject: [PATCH v2 2/3] staging: most: dim2: replace BUG_ON() with proper
 checks and error returns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-staging-most-warn-v2-2-cd51e1e717f6@lukowski.dev>
References: <20251021-staging-most-warn-v2-0-cd51e1e717f6@lukowski.dev>
In-Reply-To: <20251021-staging-most-warn-v2-0-cd51e1e717f6@lukowski.dev>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Christian Gromm <christian.gromm@microchip.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Olle Lukowski <olle@lukowski.dev>
X-Mailer: b4 0.14.3
X-Virus-Scanned: ClamAV using ClamSMTP

Replace BUG_ON() calls with proper checks to prevent unnecessary kernel
panics. Return appropriate error codes (-EINVAL or -EFAULT) instead of
crashing the system.

Signed-off-by: Olle Lukowski <olle@lukowski.dev>
---
 drivers/staging/most/dim2/dim2.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index dad2abe6c..d0832704b 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -166,8 +166,10 @@ static int try_start_dim_transfer(struct hdm_channel *hdm_ch)
 	unsigned long flags;
 	struct dim_ch_state st;
 
-	BUG_ON(!hdm_ch);
-	BUG_ON(!hdm_ch->is_initialized);
+	if (!hdm_ch)
+		return -EINVAL;
+	if (!hdm_ch->is_initialized)
+		return -EINVAL;
 
 	spin_lock_irqsave(&dim_lock, flags);
 	if (list_empty(head)) {
@@ -188,7 +190,11 @@ static int try_start_dim_transfer(struct hdm_channel *hdm_ch)
 		return -EAGAIN;
 	}
 
-	BUG_ON(mbo->bus_address == 0);
+	if (mbo->bus_address == 0) {
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
+	if (!hdm_ch)
+		return;
+	if (!hdm_ch->is_initialized)
+		return;
 
 	spin_lock_irqsave(&dim_lock, flags);
 
@@ -455,7 +463,8 @@ static int configure_channel(struct most_interface *most_iface, int ch_idx,
 	int const ch_addr = ch_idx * 2 + 2;
 	struct hdm_channel *const hdm_ch = dev->hch + ch_idx;
 
-	BUG_ON(ch_idx < 0 || ch_idx >= DMA_CHANNELS);
+	if (ch_idx < 0 || ch_idx >= DMA_CHANNELS)
+		return -EINVAL;
 
 	if (hdm_ch->is_initialized)
 		return -EPERM;
@@ -567,7 +576,8 @@ static int enqueue(struct most_interface *most_iface, int ch_idx,
 	struct hdm_channel *hdm_ch = dev->hch + ch_idx;
 	unsigned long flags;
 
-	BUG_ON(ch_idx < 0 || ch_idx >= DMA_CHANNELS);
+	if (ch_idx < 0 || ch_idx >= DMA_CHANNELS)
+		return -EINVAL;
 
 	if (!hdm_ch->is_initialized)
 		return -EPERM;
@@ -643,7 +653,8 @@ static int poison_channel(struct most_interface *most_iface, int ch_idx)
 	u8 hal_ret;
 	int ret = 0;
 
-	BUG_ON(ch_idx < 0 || ch_idx >= DMA_CHANNELS);
+	if (ch_idx < 0 || ch_idx >= DMA_CHANNELS)
+		return -EINVAL;
 
 	if (!hdm_ch->is_initialized)
 		return -EPERM;

-- 
2.51.1


