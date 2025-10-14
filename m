Return-Path: <linux-kernel+bounces-853062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3D3BDA921
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BBCB4FF68C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D569B302742;
	Tue, 14 Oct 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGnXAIGP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945925487B;
	Tue, 14 Oct 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458050; cv=none; b=U3XSHn9NW74CctZKrXX9Q4Nm1gEP3c8n2AlQNk2Pe923xaJ3TtJNz1dnHtZzYeaWYdqngEJDegQraySQQ80FdjciQEtYz4+mP+3HWrk2KXPu+3XR42juuuJaWfGMuF2zSHHsq0RZCuM72Y5hwYRFBa/eP9nozCUVdieoCwaqHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458050; c=relaxed/simple;
	bh=5zdYhL/rLP+9RnOQt6OF/1CKrvbgkne51WdJCnfUIRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tvdfPccy+0r1ex/U7QlCodVvKr3GHB+tSs9AtzqxmqgVlpYdx8SaMEWSdvXLGubxrusQGhRuYipaBleweEY5FCv9d/rHg90vYshMjjbrt+nQ3cO5HfVBoKpgGpUSObxsIql5rgy8Lxih165N0Bc4W02PVkBSX4MX6OBZPGQrukA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGnXAIGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10555C4CEF9;
	Tue, 14 Oct 2025 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760458050;
	bh=5zdYhL/rLP+9RnOQt6OF/1CKrvbgkne51WdJCnfUIRk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OGnXAIGP0MSlAR1LYwqzcKhkvgmZJzROjH8I0CQUrFnUwYdK2dhQxr2XCKVgcVPbQ
	 84cchJ1vQmPK+WfVkVAR3IlgReasfjrIf2y6dOcsZLv342LPKDT2QYb+OB2FtISkEV
	 HOWTlSLcRYI+XzzsPkbyzRS4+/2E7iZC5hezmPkEbUfXbcPTJeyiI2CjaqhE4DZJQw
	 aYO+Tdl7DaB1bSv65Pdtp+CwlnEqJgSubQzZhGeqIN/vIEsApy0K8rzzY7CNW+0new
	 kHAhZxlDOzRX5auGd5oI34ztNEZ7+sgZoZV0JXqmFjJQQdKdw+8KLTz8Fsiyfa19Ta
	 SH2dJqLQhr2vA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 14 Oct 2025 18:06:46 +0200
Subject: [PATCH 2/3] usb: typec: ps883x: Rework ps883x_set()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-topic-ps883x_usb4-v1-2-e6adb1a4296e@oss.qualcomm.com>
References: <20251014-topic-ps883x_usb4-v1-0-e6adb1a4296e@oss.qualcomm.com>
In-Reply-To: <20251014-topic-ps883x_usb4-v1-0-e6adb1a4296e@oss.qualcomm.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, 
 Jack Pham <jack.pham@oss.qualcomm.com>, 
 Raghavendra Thoorpu <rthoorpu@qti.qualcomm.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760458037; l=2901;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=U08eJtJbB7L1vN1PbveiV/822d+V9NyzxY+lDf6nmhQ=;
 b=A3kNgKdJs34kt1rnPr8FkQgpXVMgT3BWcqSWAqAjT6O6BK2ToywAXGT2VW9VtEPrZyKYha7W5
 I5XwSvOMLyKDHgsfN0OMpajXw2m/9/ZBRC84x4YRXK7SJxsChpcmZb7
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

In preparation to extend it with new alt/USB modes, rework the code a
bit by changing the flow into a pair of switch statements.

Reviewed-by: Jack Pham <jack.pham@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/usb/typec/mux/ps883x.c | 71 ++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index 68f172df7be3..72f1e737ca4b 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -99,44 +99,47 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
 	int cfg1 = 0x00;
 	int cfg2 = 0x00;
 
-	if (retimer->orientation == TYPEC_ORIENTATION_NONE ||
-	    state->mode == TYPEC_STATE_SAFE) {
-		return ps883x_configure(retimer, cfg0, cfg1, cfg2);
-	}
-
-	if (state->alt && state->alt->svid != USB_TYPEC_DP_SID)
-		return -EINVAL;
-
 	if (retimer->orientation == TYPEC_ORIENTATION_REVERSE)
 		cfg0 |= CONN_STATUS_0_ORIENTATION_REVERSED;
 
-	switch (state->mode) {
-	case TYPEC_STATE_USB:
-		cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
-		break;
+	if (state->alt) {
+		switch (state->alt->svid) {
+		case USB_TYPEC_DP_SID:
+			cfg1 |= CONN_STATUS_1_DP_CONNECTED |
+				CONN_STATUS_1_DP_HPD_LEVEL;
 
-	case TYPEC_DP_STATE_C:
-		cfg1 = CONN_STATUS_1_DP_CONNECTED |
-		       CONN_STATUS_1_DP_SINK_REQUESTED |
-		       CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D |
-		       CONN_STATUS_1_DP_HPD_LEVEL;
-		break;
-
-	case TYPEC_DP_STATE_D:
-		cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
-		cfg1 = CONN_STATUS_1_DP_CONNECTED |
-		       CONN_STATUS_1_DP_SINK_REQUESTED |
-		       CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D |
-		       CONN_STATUS_1_DP_HPD_LEVEL;
-		break;
-
-	case TYPEC_DP_STATE_E:
-		cfg1 = CONN_STATUS_1_DP_CONNECTED |
-		       CONN_STATUS_1_DP_HPD_LEVEL;
-		break;
-
-	default:
-		return -EOPNOTSUPP;
+			switch (state->mode)  {
+			case TYPEC_DP_STATE_C:
+				cfg1 |= CONN_STATUS_1_DP_SINK_REQUESTED |
+					CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D;
+				fallthrough;
+			case TYPEC_DP_STATE_D:
+				cfg1 |= CONN_STATUS_0_USB_3_1_CONNECTED;
+				break;
+			default: /* MODE_E */
+				break;
+			}
+			break;
+		default:
+			dev_err(&retimer->client->dev, "Got unsupported SID: 0x%x\n",
+				state->alt->svid);
+			return -EOPNOTSUPP;
+		}
+	} else {
+		switch (state->mode) {
+		case TYPEC_STATE_SAFE:
+		/* USB2 pins don't even go through this chip */
+		case TYPEC_MODE_USB2:
+			break;
+		case TYPEC_STATE_USB:
+		case TYPEC_MODE_USB3:
+			cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
+			break;
+		default:
+			dev_err(&retimer->client->dev, "Got unsupported mode: %lu\n",
+				state->mode);
+			return -EOPNOTSUPP;
+		}
 	}
 
 	return ps883x_configure(retimer, cfg0, cfg1, cfg2);

-- 
2.51.0


