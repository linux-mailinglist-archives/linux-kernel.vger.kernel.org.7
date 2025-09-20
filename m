Return-Path: <linux-kernel+bounces-825683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E294B8C834
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 14:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8193AA78A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8D4301716;
	Sat, 20 Sep 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhlAz6rp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7F239E65;
	Sat, 20 Sep 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758371290; cv=none; b=Oa18kwtzrZWOB3+jIYwAJco5QAe/BODDJDG9/w9h8tXtCP4nwRz1h/COQPVilKH6lqhnELESf8QNfusfP7Pp4atpzWExAQeyeZdgA78fIKdIcAhaGVoZOjOyNpA0MNwosHCsn1v8k9/WO935rUjpiBv4GhJrbHR9N0KAexhm6nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758371290; c=relaxed/simple;
	bh=0b5NmMOnbDP9MtwNwBgV04ka112u6zlExhIdniRtJx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oj2ZYTxhNuPIklFHydMFAMbfUj1AN6gNyAXolNnW8H/irDj75xsGDt4u+9AMn+hiKR0Nq7/SBM+QR3LCDDybqS1SWmTUro5dtTUVzFB4D2mHFKu1dE+/fAUMcd+KHt/k3h0K0jqKohtQosEs+7zwPlvOMWuDccJV1jZIfkazh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhlAz6rp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3423C4CEEB;
	Sat, 20 Sep 2025 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758371289;
	bh=0b5NmMOnbDP9MtwNwBgV04ka112u6zlExhIdniRtJx0=;
	h=From:Date:Subject:To:Cc:From;
	b=ZhlAz6rpD1MD6GHBG0V2Ul2mY7P/nTLPmN+KMhL2AtPR8Y8Tv83UIDeiyi2ONehHi
	 1V8M7oXM5sdP9ClTvRAOGmPRmVcxcwfL65rQkVUoO9KWlMdQ9LNBZ10T7ha8xGCCiv
	 EZ3CJx/yFfg+sqvBRmOiKNKoxeN2jKTp933x0puX5i6O3Ilxu272TFBkG7QL/oUuMI
	 bcr8I4IV4TF40M/wo7WCtgvMT75ZIZrFm99l1EyhTdE+NTdK0IhQv6Qmof2D3uVDRi
	 4MrlfIs5iuVWr3VdMSh1voLMdZ4FrvdNn0a77tZygmfo1hi63/PKd6yo359Qob6+Fc
	 WremT60SA6JDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA137CAC5A8;
	Sat, 20 Sep 2025 12:28:09 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 20 Sep 2025 12:28:03 +0000
Subject: [PATCH] usb: typec: tipd: Fix error handling in
 cd321x_read_data_status
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-tipd-fix-v1-1-49886d4f081d@kernel.org>
X-B4-Tracking: v=1; b=H4sIANKdzmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMD3ZLMghTdtMwKXYNkU4M0yzRLy0TTRCWg8oKiVKAw2Kjo2NpaAHd
 1ZmJaAAAA
X-Change-ID: 20250920-tipd-fix-0c50f9f99a5a
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2170; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=0b5NmMOnbDP9MtwNwBgV04ka112u6zlExhIdniRtJx0=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8a5udctpXkWrnv+976tQobui80y03UL3mz2e5jNy3GsZ
 j7/wafMHaUsDGIcDLJiiizb99ubPnn4RnDppkvvYeawMoEMYeDiFICJhL9n+J8vmfzsVXKd8sSH
 PmdlI59ci/y1asWhlR8maLhtLQ++9+IZw0/GbzeLePfPtHoz44mmnf98OxmmlTtcT+16GnBwi6k
 i8xI2AA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Right now cd321x_read_data_status always returns true even if it
encounters any errors: tps6598x_read_data_status returns a boolean but
we treated it as an errno and then we have a bunch of dev_errs in case
tps6598x_block_read fails but just continue along and return true.
Fix that to correctly report errors to the callee.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-usb/aMvWJo3IkClmFoAA@stanley.mountain/
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 2b1049c9a6f3c4300f4a25a97fe502c47e82a134..d0c86347251c5cc19a9b377550c00c27966f8329 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -577,30 +577,36 @@ static bool cd321x_read_data_status(struct tps6598x *tps)
 	int ret;
 
 	ret = tps6598x_read_data_status(tps);
-	if (ret < 0)
+	if (!ret)
 		return false;
 
 	if (tps->data_status & TPS_DATA_STATUS_DP_CONNECTION) {
 		ret = tps6598x_block_read(tps, TPS_REG_DP_SID_STATUS,
 				&cd321x->dp_sid_status, sizeof(cd321x->dp_sid_status));
-		if (ret)
+		if (ret) {
 			dev_err(tps->dev, "Failed to read DP SID Status: %d\n",
 				ret);
+			return false;
+		}
 	}
 
 	if (tps->data_status & TPS_DATA_STATUS_TBT_CONNECTION) {
 		ret = tps6598x_block_read(tps, TPS_REG_INTEL_VID_STATUS,
 				&cd321x->intel_vid_status, sizeof(cd321x->intel_vid_status));
-		if (ret)
+		if (ret) {
 			dev_err(tps->dev, "Failed to read Intel VID Status: %d\n", ret);
+			return false;
+		}
 	}
 
 	if (tps->data_status & CD321X_DATA_STATUS_USB4_CONNECTION) {
 		ret = tps6598x_block_read(tps, TPS_REG_USB4_STATUS,
 				&cd321x->usb4_status, sizeof(cd321x->usb4_status));
-		if (ret)
+		if (ret) {
 			dev_err(tps->dev,
 				"Failed to read USB4 Status: %d\n", ret);
+			return false;
+		}
 	}
 
 	return true;

---
base-commit: a4e143636d5def935dd461539b67b61287a8dfef
change-id: 20250920-tipd-fix-0c50f9f99a5a

Best regards,
-- 
Sven Peter <sven@kernel.org>



