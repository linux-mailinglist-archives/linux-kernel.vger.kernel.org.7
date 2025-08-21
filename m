Return-Path: <linux-kernel+bounces-780217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09ACB2FF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED0C17DEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAA03451D5;
	Thu, 21 Aug 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtZ4GISr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0092DFF28;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790804; cv=none; b=qzIMJp34Zu/r2wnzv/YW+9zn5Jfu7ipiz1aYbmqQRwzj8wgnSHdLWNqoHDY+rQglH2+FUaqskGoRw5Zyr21mEGJycHzTL2zTB39Foke2HWHkkIwBiAXIPLvXbaKQnKzHhXZ/R/vqIakwrHB9UNPDhLFdNJIxTxMivCbXFHS84Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790804; c=relaxed/simple;
	bh=983CG/MM3PcL5TC3u/pW2QKWD6qqvQjonF9bKDfHiWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tDSjpGuiJrWE1Md2SFn9Nuy50S5NmQPRN6iJNFZk2/fMpDaKrXCxD/5o70BC6EsWhpwBzjQEnlCjCx2qcGJit6CaxgnA4V1cIjAO7oYrHIs52HCZHZpAL87E1ZDLTnz/wMNv01HeAX2IvStOIAxQcLeBBV0UFOT/vj+32+rjxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtZ4GISr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 115E3C4DDF1;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790804;
	bh=983CG/MM3PcL5TC3u/pW2QKWD6qqvQjonF9bKDfHiWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UtZ4GISrLRQy+Ri5tVkjPwREu68Lb90FYK/T6sOy/+DORJGscW+c+VHx83+bWusmm
	 VXT3O/0JYdI1HVw47UGrfSivi2Zm8xAhotj9q//asJYeaDD/0muDrHvVMpHlu5D1bQ
	 X1YnICf4vH5T0RczalmnVb10mC14y0SrBYGhFMQc2lzhqxMyLUHdj77u54vzL1wOLe
	 CygYzLFroCp4pn4YQfxZLV202+sWERFk9ca9VT7euRgpzTLD5V/ROp9mC0y/3iAtER
	 yRjqWNcSD199syP08bcDwpjNS2r7cKDMlzrZRy5hC1DJRYk/1v3KtY/NwBMGPf3yNa
	 MNZ2CYgCEc50g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012D9CA0FE2;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 21 Aug 2025 15:39:09 +0000
Subject: [PATCH RFC 17/22] usb: typec: tipd: Read data status in probe and
 cache its value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-atcphy-6-17-v1-17-172beda182b8@kernel.org>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
In-Reply-To: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=w4gEKin788lV37T7P3ejSzEd1QqxJ5N159RtspJlYHw=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Zy293PtrFe1BQWP/vRXeAgT+GkU3W2b+NczGo2eV7zt
 up74nq0o5SFQYyDQVZMkWX7fnvTJw/fCC7ddOk9zBxWJpAhDFycAjAR91kM//O2n1hQUxEYfLGx
 sX7rsSpGabXncYsZP/usTD9rMT9R35iR4bHO0kmcCd/XHDfWuefYe7dzv+05v5lTVv+q/1Ecn7I
 kkRcA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: Hector Martin <marcan@marcan.st>

Just like for power status we also need to keep track of data status to
be able to detect mode changes once we introduce de-bouncing for CD321x.
Read it during probe and keep a cached copy of its value.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 2b7c5017a347d153b50383b34123a2ecc424eb68..bada42fbe59b29a9e864e17644da41908a445102 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -177,6 +177,7 @@ struct tps6598x {
 
 	int wakeup;
 	u32 status; /* status reg */
+	u32 data_status;
 	u16 pwr_status;
 	struct delayed_work	wq_poll;
 
@@ -539,6 +540,7 @@ static bool tps6598x_read_data_status(struct tps6598x *tps)
 		dev_err(tps->dev, "failed to read data status: %d\n", ret);
 		return false;
 	}
+	tps->data_status = data_status;
 
 	if (tps->data->trace_data_status)
 		tps->data->trace_data_status(data_status);
@@ -1554,6 +1556,8 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (status & TPS_STATUS_PLUG_PRESENT) {
 		if (!tps6598x_read_power_status(tps))
 			goto err_unregister_port;
+		if (!tps->data->read_data_status(tps))
+			goto err_unregister_port;
 		ret = tps6598x_connect(tps, status);
 		if (ret)
 			dev_err(&client->dev, "failed to register partner\n");

-- 
2.34.1



