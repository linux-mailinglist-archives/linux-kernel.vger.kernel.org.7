Return-Path: <linux-kernel+bounces-865358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE40BFCE41
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A353D3B2468
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E522934D4EA;
	Wed, 22 Oct 2025 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8nazwZA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E134D919;
	Wed, 22 Oct 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146815; cv=none; b=SXilrPS+oX3/9Cq7lWUgQLbMig7DbqwWgwSrorGXZkCKIxgxUoEXPZboMZ6F3I0bWn9gNUx/WF0gBGHnzfWhxTOqJsoLpIFeeUq/ONLULyv6j48WbihIqnTx7lIlcVcypCitTOJ5c+sbTE/r4ouh1AtcCsHF9S+2iWthuUBvz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146815; c=relaxed/simple;
	bh=8zyRazgWuL0UpyHz9Sxfuy71+oI1/qjeuJpS+vpV/IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjKGoqbjpKOAYilvGkJGa7iJx6cvM7Jomzx1XF7T1he7ZQRaRuLfQGMEaDEppRBKEzXkfwrhChPRzLi+hpnlQlSZBAUgHgS4WlPrKfy4htZ1cgrBz5Q03QI0mAHa6hZW5Bpip2CkP5RkQhE9SU14T1YDE+q2irj2QEwg4Xn16Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8nazwZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72974C4AF0D;
	Wed, 22 Oct 2025 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761146813;
	bh=8zyRazgWuL0UpyHz9Sxfuy71+oI1/qjeuJpS+vpV/IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o8nazwZAHHu67LtAEvg5SWjwFdohm9ZZb203jap1s4hJyLeUIYGY9Y/uUbtmbKDFG
	 HazIwajrcduAog9xCzmGFeG8MBBKTXH9SZzQOby5bHNSA8OrwvUusmM72ffUruFMRJ
	 NSOMKu/kyoTojLmdosVyS74JGVfYDdbWKyOjIaoqHIpAmIj86+OIuIhLM2UR9g7u9J
	 8rPmKI9AWZQ+sbScpAzY30qQw9TqE1DWMDoszHTZ3mq3Bqq3/02PTti6B/VwApi+Oi
	 Kg1Ncq39529ZakDyDOkwmLdBmt9r5f5r3GadOUEAizkhiz82cVmLgcyikxl4VxtSxJ
	 LJk73Ue0SYSIA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vBajs-000000006JY-14bX;
	Wed, 22 Oct 2025 17:27:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] USB: serial: kobil_sct: drop unnecessary initialisations
Date: Wed, 22 Oct 2025 17:26:40 +0200
Message-ID: <20251022152640.24212-9-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251022152640.24212-1-johan@kernel.org>
References: <20251022152640.24212-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop unnecessary initialisation of variables that are always assigned
before being used.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/kobil_sct.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index cad3cfc63ce7..3a1343d88386 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -178,10 +178,10 @@ static void kobil_init_termios(struct tty_struct *tty)
 static int kobil_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
 	struct device *dev = &port->dev;
-	int result = 0;
 	struct kobil_private *priv;
 	unsigned char *transfer_buffer;
 	int transfer_buffer_length = 8;
+	int result;
 
 	priv = usb_get_serial_port_data(port);
 
@@ -272,10 +272,8 @@ static void kobil_write_int_callback(struct urb *urb)
 static int kobil_write(struct tty_struct *tty, struct usb_serial_port *port,
 			const unsigned char *buf, int count)
 {
-	int length = 0;
-	int result = 0;
-	int todo = 0;
 	struct kobil_private *priv;
+	int length, todo, result;
 
 	if (count == 0) {
 		dev_dbg(&port->dev, "%s - write request of 0 bytes\n", __func__);
-- 
2.49.1


