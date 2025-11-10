Return-Path: <linux-kernel+bounces-892945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F92DC462E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6CF94EA0A6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4E30CDA5;
	Mon, 10 Nov 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJsyPEc+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2A309EE3;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773292; cv=none; b=HVIoubw6M6XVrJGS6sysalMD0iBjnPWk30rgSQfyD6Jdpq3z51e8JEmO5FO/PyNyPziF/T1F/V8yeWP8hvmafQC8yoIDuychnZonE68rbv4jFRYPtjIl/0byordLH3zVnDucyX0uFLyajOjMIE8j5MIKP9GJqlDW+6ZkbCS7Uhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773292; c=relaxed/simple;
	bh=ebOTp9Im7EP8vahUtI9Dz776aAEFiIaHqxCgLoS7eEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMC5HaYzlh8vpzGPYkwwtQuIWl7uXYP0uKh4dFxvNTVFToVH0+UT7sIv1cjZbB1f6m7Y2B/sfmwtWOgRBCCBUw0JqVdkafk9s6fLh2IDToyzrvfTNT3HnwKuovv+A2fXmSdmFewoemB/IWBFvLY71kia+ffj44LCqyCVNDxhru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJsyPEc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE20C2BCB0;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773292;
	bh=ebOTp9Im7EP8vahUtI9Dz776aAEFiIaHqxCgLoS7eEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJsyPEc+kilCshK8zq7Od6729rpM2HprFnJ+PjxhKwvAmq5ZOGb9up2tsPtjvAvTP
	 5PUjlUZ/yF7qmXnTvvQ/Gj72v8WNhMGKAIPF0Yg67+TS/uo8/umA0O8PMGLUr9Xghi
	 40ID/ZshSCQieto1AnBgwFOkU/ZRF6O/vMJfJvbQnWDtgc0RlC0X+kZUSRXwGdy0wu
	 6mB+70rqGTlNfBhINBGYkK/Qy0pBwuawmDZDniVViL8E1sa1TNJ6MvpWjoAAAo2QR+
	 c6d7knASL54YRF/lJ5bBVKXQqxa/KN1W3tdTmR/zoQaAi+s1Mvo5gaJErl15XAzCSK
	 Jnt5Hs3hgNNfQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIPrI-0000000007m-2aKX;
	Mon, 10 Nov 2025 12:14:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryan Mann <rmann@ndigital.com>,
	Andreas Messer <andi@bastelmap.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] USB: serial: ftdi_sio: enable NDI speed hack consistently
Date: Mon, 10 Nov 2025 12:12:10 +0100
Message-ID: <20251110111212.32702-7-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110111212.32702-1-johan@kernel.org>
References: <20251110111212.32702-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original submission adding support for NDI EMGUIDE Gemini enabled
the existing NDI speed hack which remaps the 19200 line speed to 1.2
Mbps, but this silently fell out during resubmission.

Enable the speed hack also for the new NDI product for consistency. This
will also allow for cleaning up the implementation without resorting to
overengineering.

Link: https://lore.kernel.org/all/YQXPR01MB49870CB7B3075ADDF88A3FD4DF43A@YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM/
Link: https://lore.kernel.org/all/YQXPR01MB4987F1E0DA41E689779E6958DF48A@YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM/
Cc: Ryan Mann <rmann@ndigital.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index d583b39b64cc..f5786689697c 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1312,7 +1312,8 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			     (product_id == FTDI_NDI_SPECTRA_SCU_PID)	||
 			     (product_id == FTDI_NDI_FUTURE_2_PID)	||
 			     (product_id == FTDI_NDI_FUTURE_3_PID)	||
-			     (product_id == FTDI_NDI_AURORA_SCU_PID))	&&
+			     (product_id == FTDI_NDI_AURORA_SCU_PID)	||
+			     (product_id == FTDI_NDI_EMGUIDE_GEMINI_PID)) &&
 			    (baud == 19200)) {
 				baud = 1200000;
 			}
-- 
2.51.0


