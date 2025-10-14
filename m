Return-Path: <linux-kernel+bounces-853061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B41DBDA8FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACD6B355E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D8C3019DF;
	Tue, 14 Oct 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBwDoEnc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E725487B;
	Tue, 14 Oct 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458046; cv=none; b=S3h9V7GIbk2s/zTJ9F10S4ESZqtUancd3MwFeKYiy1e2wwLJv5MJSCMMavyUwN2eg48mLzhXXiN2URJ3YIfTSlyKflkBJ3uwrNCAVYlPNnLpjnX5LhTad1FKx5bL0Ff3WZSvsD5V3FteruLjzF0kq9KTKXXEutLr4LBuF0NIcyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458046; c=relaxed/simple;
	bh=/VG9zzgUtSRpSsTxCEkJIpPcTmz1osIcGzqmkPxbwiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sR3N837b3HenRyJ+Xo/l/+hMK7kNI10CT7PVkQGkvi3kpjk2QqfNdUbHIPKy56yReDxwDoEzBK/b/Vu3Wel090KsJZoiMBbKgXOBgEsC7Ep1e/v+qgi9vmHfO1Cptcsjt8kpx6wEtHK2GzQ1iwQBqyLQiGwdVROx+40+xs2AYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBwDoEnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849D4C4CEE7;
	Tue, 14 Oct 2025 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760458046;
	bh=/VG9zzgUtSRpSsTxCEkJIpPcTmz1osIcGzqmkPxbwiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JBwDoEnc10zHFx09E9Ku6NY3CjX3FliT6v3Bj/KahTU6+fIqA+2jr0JZkeBWmhms4
	 e+Y0tPoc08KH/Kk1OAX5iyNYfNA7eVWUI97O+zhGmw7HuHjr/Z5MrOtrdWfUfWaAHN
	 DjsjCw6hw5hqMQ/C0PSCaiz2uODHpYtsLKKVUKEqS8BMUjN7/rFx5Prb/d5lyLZFWW
	 zZAhV7tnYvjKs0iFjeTmUljDCJkRXC5LMHtcc5w4FJblCAK9H6xhS0/TJsXJTWMDqd
	 GpubQBgOCFl08R0Nv1s+txesv+LXkhuVRwYOw91HQeEmRLIuR3bxaxNeuujnu6f/or
	 KzCMSQkKBVxlA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 14 Oct 2025 18:06:45 +0200
Subject: [PATCH 1/3] usb: typec: ps883x: Cache register settings, not
 Type-C mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-topic-ps883x_usb4-v1-1-e6adb1a4296e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760458037; l=3637;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=1gQv1ObK9g3E3LIAXDYmzTvACMzocHpS59Dz4XaOF/0=;
 b=wAxfEf/nM0o0sTWOXwMWqdQJK+rJZua6+zsyVlSsXRRWbE/cKN3V5N42NNVaEYNcD2/+cxQfa
 x9uym4/c+5XDwWFalarE6cgb1YmydsIQNw6nums+JT8lty/P4MhYntH
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Certain Type-C mode configurations may result in identical settings of
the PS8830. Check if the latter have changed instead of assuming
there's always a difference.

ps883x_set() is changed to accept a typec_retimer_state in preparation
for more work and the ps883x_sw_set() (which only handles orientation
switching) is changed to use regmap_assign_bits(), which itself does
not perform any writes if the desired value is already set.

Reviewed-by: Jack Pham <jack.pham@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/usb/typec/mux/ps883x.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index ad59babf7cce..68f172df7be3 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -54,8 +54,9 @@ struct ps883x_retimer {
 	struct mutex lock; /* protect non-concurrent retimer & switch */
 
 	enum typec_orientation orientation;
-	unsigned long mode;
-	unsigned int svid;
+	u8 cfg0;
+	u8 cfg1;
+	u8 cfg2;
 };
 
 static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
@@ -64,6 +65,9 @@ static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
 	struct device *dev = &retimer->client->dev;
 	int ret;
 
+	if (retimer->cfg0 == cfg0 && retimer->cfg1 == cfg1 && retimer->cfg2 == cfg2)
+		return 0;
+
 	ret = regmap_write(retimer->regmap, REG_USB_PORT_CONN_STATUS_0, cfg0);
 	if (ret) {
 		dev_err(dev, "failed to write conn_status_0: %d\n", ret);
@@ -82,27 +86,31 @@ static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
 		return ret;
 	}
 
+	retimer->cfg0 = cfg0;
+	retimer->cfg1 = cfg1;
+	retimer->cfg2 = cfg2;
+
 	return 0;
 }
 
-static int ps883x_set(struct ps883x_retimer *retimer)
+static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state *state)
 {
 	int cfg0 = CONN_STATUS_0_CONNECTION_PRESENT;
 	int cfg1 = 0x00;
 	int cfg2 = 0x00;
 
 	if (retimer->orientation == TYPEC_ORIENTATION_NONE ||
-	    retimer->mode == TYPEC_STATE_SAFE) {
+	    state->mode == TYPEC_STATE_SAFE) {
 		return ps883x_configure(retimer, cfg0, cfg1, cfg2);
 	}
 
-	if (retimer->mode != TYPEC_STATE_USB && retimer->svid != USB_TYPEC_DP_SID)
+	if (state->alt && state->alt->svid != USB_TYPEC_DP_SID)
 		return -EINVAL;
 
 	if (retimer->orientation == TYPEC_ORIENTATION_REVERSE)
 		cfg0 |= CONN_STATUS_0_ORIENTATION_REVERSED;
 
-	switch (retimer->mode) {
+	switch (state->mode) {
 	case TYPEC_STATE_USB:
 		cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
 		break;
@@ -149,7 +157,13 @@ static int ps883x_sw_set(struct typec_switch_dev *sw,
 	if (retimer->orientation != orientation) {
 		retimer->orientation = orientation;
 
-		ret = ps883x_set(retimer);
+		ret = regmap_assign_bits(retimer->regmap, REG_USB_PORT_CONN_STATUS_0,
+					 CONN_STATUS_0_ORIENTATION_REVERSED,
+					 orientation == TYPEC_ORIENTATION_REVERSE);
+		if (ret) {
+			dev_err(&retimer->client->dev, "failed to set orientation: %d\n", ret);
+			return ret;
+		}
 	}
 
 	mutex_unlock(&retimer->lock);
@@ -165,18 +179,7 @@ static int ps883x_retimer_set(struct typec_retimer *rtmr,
 	int ret = 0;
 
 	mutex_lock(&retimer->lock);
-
-	if (state->mode != retimer->mode) {
-		retimer->mode = state->mode;
-
-		if (state->alt)
-			retimer->svid = state->alt->svid;
-		else
-			retimer->svid = 0;
-
-		ret = ps883x_set(retimer);
-	}
-
+	ret = ps883x_set(retimer, state);
 	mutex_unlock(&retimer->lock);
 
 	if (ret)

-- 
2.51.0


