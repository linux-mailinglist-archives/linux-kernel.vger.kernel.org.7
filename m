Return-Path: <linux-kernel+bounces-815614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 533A1B568FD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B417E18982BA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A55A27A114;
	Sun, 14 Sep 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUiC/OiP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7C26CE03;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757854608; cv=none; b=e2foS7WYf0f1YMzEnBprB1HI5XJ/L+wcVCG2s5LTmi43OPBMs9FnWUa8jKpZQq1v1xfi2W6yFDLwCkJsIlCvsPrX0WAbSjRy1nJJbnmN/P8VWQkXoa987o19LEaWidw/CeeTUwHxVtCTlRJ/dXKpQeslW4MILdnbJzzhnPMZOkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757854608; c=relaxed/simple;
	bh=GGf5QllyT61ysY566RYqLFNgno0l8ltEvVdR6bQN+qM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qROBFkfYLaUmxRHoF4Qwf62l0R0VGRGSRwBnaMaMSuFxDCkdxPdtDGaH3MrznjPG2K9fROagRAwEiIis69SBzvMGaQ0z4RUwhblrHBiVT4T5bv1d0PE03Z0c6zIDGaMiFEU4xnhdb5t5JJcgBMw7XxTbeYguqtLuuQ20MrUOPgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUiC/OiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9116BC113D0;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757854608;
	bh=GGf5QllyT61ysY566RYqLFNgno0l8ltEvVdR6bQN+qM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dUiC/OiPYVS67Ur/9+AsrvRREGlm8DN1DpiNoBw52tkpafCjIOzwwZKVpzpQeY0YF
	 cRCAGhcg5/Ip0c7K8DqHXDbX6lplqkc5LlnyIEYDHfmm69pCDCXZahusoAf0JTxsod
	 2xCQEvpLXRDo5OiNi6dLRooc+veev4v3p/Rud3P5DoJxC4i2mWbjYQd40Arf5loYZZ
	 q8HTJbQHgO5mHGURKk0nAMty5TyRPONgO9pC0EDl6J1QYpiuXvPT9KLcaROIwnJv4M
	 TJL/5+iPh+znhMxR+4UttogN09YOSNAVvZ+RzXZy2uQd6SAM5nB4CerZwI4RvEhujX
	 d6qE3roA9M2qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B193CAC587;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sun, 14 Sep 2025 12:56:14 +0000
Subject: [PATCH 09/11] usb: typec: tipd: Use read_power_status function in
 probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-apple-usb3-tipd-v1-9-4e99c8649024@kernel.org>
References: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
In-Reply-To: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Sven Peter <sven@kernel.org>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=bWtfpNYNeM/tSnjKG/cu9lo0fgNBV8UwebqdAD8QF6w=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8ax3W0fT4QWvHjcHsSxxazpQTznhJi5f6z3y7An5ln3b
 P2nOPtnRykLgxgHg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAiO9YxMizxXdt8xmyvCMd+
 OT/u2Xp5b2WOnH/htPnnscbuD14rN9ow/FN4cELDUCZsyTmfYg3HXOOccPE1d5Z0z/hxp3zW177
 8cBYA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: Hector Martin <marcan@marcan.st>

We need the initial power status to be able to reliably detect connector
changes once we introduce de-bouncing for CD321x next. read_power_status
takes care of this and also forwards the status to the trace subsystem
so let's use that instead of open-coding it inside probe.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index e16c6c07c72a3e285f1fc94db72bed8dc3217a1d..f546f4ae563af3d411ec6591fe9c3b122e4efaab 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1549,11 +1549,8 @@ static int tps6598x_probe(struct i2c_client *client)
 		goto err_role_put;
 
 	if (status & TPS_STATUS_PLUG_PRESENT) {
-		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
-		if (ret < 0) {
-			dev_err(tps->dev, "failed to read power status: %d\n", ret);
+		if (!tps6598x_read_power_status(tps))
 			goto err_unregister_port;
-		}
 		ret = tps6598x_connect(tps, status);
 		if (ret)
 			dev_err(&client->dev, "failed to register partner\n");

-- 
2.34.1



