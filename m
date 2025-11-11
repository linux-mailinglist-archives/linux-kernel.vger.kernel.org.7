Return-Path: <linux-kernel+bounces-895116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B615C4D038
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077E04A53BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B5634214A;
	Tue, 11 Nov 2025 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNjWiB8D"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E82F7ADD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855822; cv=none; b=CtN9L14ZT/9MIeRHh5dpw02xN+dgHnPjWOQGKLBS3mQKwoE07ze54DTomqeiT7DSAp143+s45vI0obHf2KL2XWjDocfIA//ol11t3Z+1O8E+uqx+spbS13CjSkSfRS7UpzRlodygjoO3tLZd33041eF80F+RFCYiSVRfRjazYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855822; c=relaxed/simple;
	bh=uTZPPC0MqaGD5cazC/+J4yCXLFiW8fnVzZfjil7OOFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJgWGfIcRTjn6FQKDUf5ZrR1vFYaP5IQmQktPBE5CZqLd3yzNnz4iMAXMOwIWs5ttI0/kx0oEITmCjGjnaHawZvw/ZhVT9UEY+AJRagRRPeXX9S4BxJzV7iqliQV0A3+xvtKvgfhqk0sfJK6IYeZYJdakVdyPLScMAIGWu2PaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNjWiB8D; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so7172521a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762855819; x=1763460619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUwW7NcY3A0Nnt9i7cSR6DPTQgR8J//w2MhqorK480s=;
        b=eNjWiB8D/jigPLwiGnY8jdBs9+2ywMRKzCRuzGaWDUSOIXcUPHzHKeqNVw3mUkFl4t
         zeUcO1hDUo/6aIARX1nNeasLQt1bBfMyRfAvemHoLYtFgxToblsZaIldC0/hybrpTAdJ
         OU6nkTNegrw50r75GmEYf1sVBFgf8g8KXKfY0Jo2Dd4Pv+0Ojl0XxCCFsJR0rcc3S7pb
         BqrUBAiYhA1wTjtq5sX0j9UpPKtfJNY+Txreug2+M10faSZBs79ceJWV9ecd7cBFn8Iq
         ZoOyKuaBVMIC7xdQmtDEaxxWl19hyPnQ9f6aaccnYj9qpl/a2pWte8egbM9nV1w+M5/q
         pF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855819; x=1763460619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUwW7NcY3A0Nnt9i7cSR6DPTQgR8J//w2MhqorK480s=;
        b=nHCW8yND3lKph5K8drX69E+9pOcQSoXQ7yLUdXfVN3jbUNjicJueVOo2TjfgUeQowV
         88C4tG5g0RJshvhiUF8Q/UD8I2hByh0K0MVmdsQOq4DX+vAsA6tthIMFAFeTKcjJHdOU
         SJ0Wbkz3mhUklQcr+W8tYAgnC+KKmGHWLNfKb7mL4A4oKw9Lg8xNMQ18fvLZ1oIN+frw
         Slsrl9CKTG21YAobXZGBQSqtonXGUsdiOJim+DSSWRr/oCVr+GbL6qNF3T742j+CBfGw
         Y8Tkp031hBLA2LpIv5LUVLdnO4IEvPxmriUFdIBPGD8c69OyvQ/inTJMimAJydJjLMxv
         irgg==
X-Forwarded-Encrypted: i=1; AJvYcCX7FBNYLSG/ecs/ab7rc3qKcZmY8RK2akwEZWS2+s2QYYMbFLzRRtXcsAnLq5pgtH1GlMI7z2+sEYa36Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTCi1oeykBH1api4YH7rBckfvX5sgaMkWOlpiDcT55f6u2iNvM
	xEq0nDXju0ZCXPGI1+3khvr4E2c8wtPMhuFJG1mIiMpqoe9Q5zT8zL9nbGAM23zr
X-Gm-Gg: ASbGncteiwJmq8ktbzKKJuM/kqbJkEAo0/p8TDHkqkFJbkE5BFGFFxsw7gRu9ro5VQG
	/liXZLGjhqkQjuTBJnyQJarHvqrsWgIlk0FER2JTb6Xsp7TfzMJvbArSjvpbtfpAZmUO2S090HV
	WfExEVXaYOPW6yee7M6GstN0hCtTcacW5bvvozy6y2jDLrr9YOpN+YwRDJhJGKIUFrapXIFzeDH
	cvdDbSmUeu58whml0kkqwvrFS+F8DX6rV2umvhsWXdU41HhqZSswxoLOnJBdc6MvwTVC6VNRy4z
	vQM0sG0vOISfwJDLwpBqRsmXTVe+MYuFa6l+uy9xGarrs1cy/SQXGYxLp6+sXAfHYfOjMzZczik
	+ezoJOcvLDUasIJI8w1nNDcN7ml6r4vgEgH2niWOjYvGmxYLfWU/l115WoDI7r2YlZoGq8NKtG9
	XKnknSF1KCj/jNZf7YafpBc7PE4kQ=
X-Google-Smtp-Source: AGHT+IFoEtEeYMeGJO6FSQdA3zyfJuoVvv8Fxl9E6UqSytTtpd7ggFbIe5eET0jzR74Qxq0gurNs+w==
X-Received: by 2002:a05:6402:2554:b0:63b:ef0e:dfa7 with SMTP id 4fb4d7f45d1cf-6415dc044d2mr9942388a12.6.1762855818179;
        Tue, 11 Nov 2025 02:10:18 -0800 (PST)
Received: from tempest2.wbe.local (xt27d7.stansat.pl. [83.243.39.215])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e0cesm13413859a12.33.2025.11.11.02.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:10:17 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Antony Kolitsos <zeusomighty@hotmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Lennert Buytenhek <buytenh@wantstofly.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] wifi: mwl8k: inject DSSS Parameter Set element into beacons if missing
Date: Tue, 11 Nov 2025 11:07:29 +0100
Message-ID: <20251111100733.2825970-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Marvell AP firmware used with mwl8k misbehaves when beacon frames
do not contain a WLAN_EID_DS_PARAMS element with the current channel.
It was reported on OpenWrt Github issues [0].

When hostapd/mac80211 omits DSSS Parameter Set from the beacon (which is
valid on some bands), the firmware stops transmitting sane frames and RX
status starts reporting bogus channel information. This makes AP mode
unusable.

Newer Marvell drivers (mwlwifi [1]) hard-code DSSS Parameter Set into
AP beacons for all chips, which suggests this is a firmware requirement
rather than a mwl8k-specific quirk.

Mirror that behaviour in mwl8k: when setting the beacon, check if
WLAN_EID_DS_PARAMS is present, and if not, extend the beacon and inject
a DSSS Parameter Set element, using the current channel from
hw->conf.chandef.chan.

Tested on Linksys EA4500 (88W8366).

[0] https://github.com/openwrt/openwrt/issues/19088
[1] https://github.com/kaloz/mwlwifi/blob/db97edf20fadea2617805006f5230665fadc6a8c/hif/fwcmd.c#L675

Fixes: b64fe619e371 ("mwl8k: basic AP interface support")
Tested-by: Antony Kolitsos <zeusomighty@hotmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

---
V2:
  - added "wifi:" prefix to commit title
  - renamed "DS Params" -> "DSSS Parameter Set"
  - Insert WLAN_EID_DS_PARAMS after WLAN_EID_SSID, WLAN_EID_SUPP_RATES
    and WLAN_EID_EXT_SUPP_RATES
V3:
  - Insert WLAN_EID_DS_PARAMS after WLAN_EID_SSID and WLAN_EID_SUPP_RATES
    only
  - Style issues fixes
V4:
  - Style issues fixes
  - Added "Fixes"
---
 drivers/net/wireless/marvell/mwl8k.c | 71 ++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 891e125ad30b..54d6d00ecdf1 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -2966,6 +2966,51 @@ mwl8k_cmd_rf_antenna(struct ieee80211_hw *hw, int antenna, int mask)
 /*
  * CMD_SET_BEACON.
  */
+
+static bool mwl8k_beacon_has_ds_params(const u8 *buf, int len)
+{
+	const struct ieee80211_mgmt *mgmt = (const void *)buf;
+	int ies_len;
+
+	if (len <= offsetof(struct ieee80211_mgmt, u.beacon.variable))
+		return false;
+
+	ies_len = len - offsetof(struct ieee80211_mgmt, u.beacon.variable);
+
+	return cfg80211_find_ie(WLAN_EID_DS_PARAMS, mgmt->u.beacon.variable,
+				ies_len) != NULL;
+}
+
+static void mwl8k_beacon_copy_inject_ds_params(struct ieee80211_hw *hw,
+					       u8 *buf_dst, const u8 *buf_src,
+					       int src_len)
+{
+	const struct ieee80211_mgmt *mgmt = (const void *)buf_src;
+	static const u8 before_ds_params[] = {
+		WLAN_EID_SSID,
+		WLAN_EID_SUPP_RATES,
+	};
+	const u8 *ies;
+	int hdr_len, left, offs, pos;
+
+	ies = mgmt->u.beacon.variable;
+	hdr_len = offsetof(struct ieee80211_mgmt, u.beacon.variable);
+
+	offs = ieee80211_ie_split(ies, src_len - hdr_len, before_ds_params,
+				  ARRAY_SIZE(before_ds_params), 0);
+
+	pos = hdr_len + offs;
+	left = src_len - pos;
+
+	memcpy(buf_dst, buf_src, pos);
+
+	/* Inject a DSSS Parameter Set after SSID + Supp Rates */
+	buf_dst[pos + 0] = WLAN_EID_DS_PARAMS;
+	buf_dst[pos + 1] = 1;
+	buf_dst[pos + 2] = hw->conf.chandef.chan->hw_value;
+
+	memcpy(buf_dst + pos + 3, buf_src + pos, left);
+}
 struct mwl8k_cmd_set_beacon {
 	struct mwl8k_cmd_pkt_hdr header;
 	__le16 beacon_len;
@@ -2975,17 +3020,33 @@ struct mwl8k_cmd_set_beacon {
 static int mwl8k_cmd_set_beacon(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif, u8 *beacon, int len)
 {
+	bool ds_params_present = mwl8k_beacon_has_ds_params(beacon, len);
 	struct mwl8k_cmd_set_beacon *cmd;
-	int rc;
+	int rc, final_len = len;
 
-	cmd = kzalloc(sizeof(*cmd) + len, GFP_KERNEL);
+	if (!ds_params_present) {
+		/*
+		 * mwl8k firmware requires a DS Params IE with the current
+		 * channel in AP beacons. If mac80211/hostapd does not
+		 * include it, inject one here. IE ID + length + channel
+		 * number = 3 bytes.
+		 */
+		final_len += 3;
+	}
+
+	cmd = kzalloc(sizeof(*cmd) + final_len, GFP_KERNEL);
 	if (cmd == NULL)
 		return -ENOMEM;
 
 	cmd->header.code = cpu_to_le16(MWL8K_CMD_SET_BEACON);
-	cmd->header.length = cpu_to_le16(sizeof(*cmd) + len);
-	cmd->beacon_len = cpu_to_le16(len);
-	memcpy(cmd->beacon, beacon, len);
+	cmd->header.length = cpu_to_le16(sizeof(*cmd) + final_len);
+	cmd->beacon_len = cpu_to_le16(final_len);
+
+	if (ds_params_present)
+		memcpy(cmd->beacon, beacon, len);
+	else
+		mwl8k_beacon_copy_inject_ds_params(hw, cmd->beacon, beacon,
+						   len);
 
 	rc = mwl8k_post_pervif_cmd(hw, vif, &cmd->header);
 	kfree(cmd);
-- 
2.34.1


