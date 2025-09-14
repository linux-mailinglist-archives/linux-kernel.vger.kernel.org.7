Return-Path: <linux-kernel+bounces-815618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DDEB568FE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFB817C942
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD3F27A44C;
	Sun, 14 Sep 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRkdzLI8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80326CE32;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757854609; cv=none; b=MYen8zQ0WE9zOdpYZFdSrTg2NRQM6ReBGscsElZgnTLaMdT4DVwsarwyHsSMqsUfkaGOaWH6OAjDg3wTgpZ8lqFwIYTBha3rxbo+pTiD6XTf22YiyNf7PoApxRwBlKPseYG2mSzjERoYiUIHfx4LjQ3FFMe3aKzeY2CoqK7arv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757854609; c=relaxed/simple;
	bh=vOCSchiqykXCoVM7fs9znsbVw4UvLeu+/CcSAFHKCss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcvi19by4NP+YrG1Oql+3YATWV1itizLX5tj+gDVDHJ8EF6Hl04vmMCZgwoLqDohQ3M3M/oC2EDmlOJL3SWHZ9JEBdkAFPe7/I688qEJD4CMNKL3TpLjUC2vCvw4MMeeHxZhckD++Bu49GHHiwbYOGguerLUh8gxtwg5Lp8amfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRkdzLI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 828DDC16AAE;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757854608;
	bh=vOCSchiqykXCoVM7fs9znsbVw4UvLeu+/CcSAFHKCss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VRkdzLI8aXCkPTftCtYSvhS0yi6xG7iIeE5bYLTAM1jFOVZYXJu3LV5d+76dHXnta
	 mlmcnuySMKsQIOIaY1AhnLeC0U0JcZblVIUixdNFQSb0b7f2TOnVTs9WNOlkHhQf6a
	 q7xW+FzMjtkrs9ZzNr09C/BP+/RV0X9mTLpDBdzBJqEXRxvnRnfz6Qoaqk9xvSTru2
	 vBXw2KsTNPrDrCFbJYDLRs/fQUM7Oep10BDxEEH9ZK8IrfrQMZdnuqQhQsC5Un4G1o
	 FWl55ssNbHe7p3IQpgFUL7TLia8gnT+Oc2bBn1w1VIO+pDRAOtkQYP4vflEwBK9diz
	 QY6miSD8fx5qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799E4CAC58F;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sun, 14 Sep 2025 12:56:13 +0000
Subject: [PATCH 08/11] usb: typec: tipd: Update partner identity when power
 status was updated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-apple-usb3-tipd-v1-8-4e99c8649024@kernel.org>
References: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
In-Reply-To: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Sven Peter <sven@kernel.org>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=rY6V5NMDdkiVm06hCdoOp7C9X1kzTeKeAD8FlJOwjT0=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8ax3c1eu7J+1bkbGjw67pdp3510yy7oQaDmhx9GeqvOq
 USX2E/sKGVhEONgkBVTZNm+3970ycM3gks3XXoPM4eVCWQIAxenAEzk2F1Ghkd6Jj1dRwsvHa+8
 cM1X8mDEMltubt2iTYx2LlaiV04aXWNkWNVcX3opq3zTqybJv6r/J3u92WwsqP6nlzdCxGj19l4
 1ZgA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: Hector Martin <marcan@marcan.st>

Whenever the power status is changed make sure to also update the
partner identity to be able to detect changes once de-bouncing and mode
changes are added for CD321x.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index c7cf936e5a61a331271c05b68ff1b77b89c0f643..e16c6c07c72a3e285f1fc94db72bed8dc3217a1d 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -635,9 +635,16 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
 	if (!tps6598x_read_status(tps, &status))
 		goto err_unlock;
 
-	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE)
+	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE) {
 		if (!tps6598x_read_power_status(tps))
 			goto err_unlock;
+		if (TPS_POWER_STATUS_PWROPMODE(tps->pwr_status) == TYPEC_PWR_MODE_PD) {
+			if (tps6598x_read_partner_identity(tps)) {
+				dev_err(tps->dev, "failed to read partner identity\n");
+				tps->partner_identity = (struct usb_pd_identity) {0};
+			}
+		}
+	}
 
 	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps->data->read_data_status(tps))

-- 
2.34.1



