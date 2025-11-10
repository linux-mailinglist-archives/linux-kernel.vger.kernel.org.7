Return-Path: <linux-kernel+bounces-892493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D042C4533B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C1C18886D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1582EB87E;
	Mon, 10 Nov 2025 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d91yox7F"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5328B7D7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759510; cv=none; b=erdhX3yyAlT+jOF6C5rravSOd3q9DHT6nGvJmPOYN+uYdeyMmTTEtLwIPW9MVQrf5j0z+QBzHAI9yzsDDMBN+konvQl9CBvgDLWQzoXrPifkoeAjZTy7fxs6cbmNpW0HXvrlBrN1FiPuJ3mb03HsoTPuDQXWPlpbuxfNV9HxQ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759510; c=relaxed/simple;
	bh=C3gGqZ5U8ux1aPUbNSsW0BzmedeousX0iTp7nghe9FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g53Gu6+14tLhsClz+efOZoU4BA0+50JxRVd4kyn28UWLJFVDkIdHyXF61SzSlmkc1OLgHdzGqxxLgQJPdZkCCCZ8IGqsb7Bxa7itVHSGkFNJEUi35gDwyiN0XZDawJLMwnVVQ2+aTYGFSzcxGDLj64abLR+UlDDkCQ/t56LEVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d91yox7F; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso4662770a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 23:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762759507; x=1763364307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhkptmGE1DDJk6/2xm0aT+Urj2GqEr04ECiE4Pa6iDs=;
        b=d91yox7FlBABYWhvrwtlc9OqcQUiM911ldnJ3qKldyAjeI+MQdNCDs6kdnVdnoWjEy
         Xyf+LutP2R2IdmizueYhbKzYWHnGZRbf6Xkm0LO8Kb//fb27adhbQX3EOsG8OctNyjzm
         vMOhVnisyRu5SXKDuYdDVNRmaltyBacUyRYrZUYxpEaO6fMLG/7OZr2hG9TgyhmZ2sbH
         zjBvMQFpgSBh8w2UEOMbt8sHuF8j7OsDG3UANNgwHy6m67zgAQnIu/+EXctsiM7G9kDw
         fUcw0joFzRq4GOX38cwLVWVwb/LB4RwgVoqXZRkp/7C2x+Jtm/EONoy/xJfwAi9sc4aH
         /zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762759507; x=1763364307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhkptmGE1DDJk6/2xm0aT+Urj2GqEr04ECiE4Pa6iDs=;
        b=kpHlVq0gh6lAuwyovj+D6e7+psr38XT1x2O5dtK7ygLsGdIsmOgLxHTUfGnlbXglj0
         w0ikrUKAORgR8HqyQeCRYGkG2e8OyRqCzGuVzmletpRFqXqZMaxiG/SAgc6p+/2qDnMx
         XgtqfR10cJnD/Aye4ZfFExn2Eo194/uWlmzRXeHW2+HQh1MohLrwExHXMUeTcBYfTXqs
         bm5K6LoRzeh42bZen+SlM4VKvPfJEy+pQR8QfAYSkJzEVRjK9VbppRE2glQCOG/wgANQ
         iSFc8SAuZaVpRlG3AD4Iv/UbD0vyMHaUFhHWWLWHYJiJmXQUInl2H8Vc+tkkPYaznYep
         H/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFgdq3MOmGCmIIG/68LhoUN7DONMsL3oDLvG4ZwG5/VDYxNiBZbGI+ujNWIPBYuSzk9EAuASNizi1Mx+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYMVTq/NDA2DljrAToP9B+bWvsI3836QFgOcq4CWZmdZc78SG
	kz1GHrhBtlR9i9IeIeOJkDMBFcjkRE8AyB0cpuaJJHfifhbHSDb7S1JL
X-Gm-Gg: ASbGncveSi8HyRLDZvWse8qNUPnU+4+6d/pCWbGa6ltFcfPaoTpKcG9PfaB44mbXoCB
	ptFbLIMIl1LBSVx40ldo50kvztHJeziXzsOKiNz4Y+9Ycf7kXQgXgHUxSzxzK6nzlFp7rFim4Ct
	H5D6s6R12FYcINjCp1uq8JWXKvqQClhqP4QGg+oYCRtb07og+MiIWiq6XuiQ7GZf/SaOnRjOCMl
	wBOiqVph1C8VuvK2Ssw/zUQSsRf3+5bFcVW3Rp3ivjjfZLGrBJJWRyuxS9CM+hdL0LxB10ED3Ed
	zfgnmZE9Px6voiSGECziNybNId1a9yJnlzU7v1qa0lRPPMO9BCIUr1kYBzPkvJx4/tcHLFnVxdd
	d/D+Ieor+mxmWAttAmUTAcFBHyXnxRwkA2sIjcUczex+99SeFKptNwarvk+7K61TraHQSir4fsy
	jRBJF/kY7ooR59t9b199UM84cdWrs=
X-Google-Smtp-Source: AGHT+IFXvPsBl9JXtCQHnVgKHRgjg/ljhd7h8KWm++ej2k9gFajvgXLbFcMylGufmwQk56PV5RfbcA==
X-Received: by 2002:a05:6402:438a:b0:640:c394:5a4 with SMTP id 4fb4d7f45d1cf-6415dc1aea7mr6419131a12.16.1762759506794;
        Sun, 09 Nov 2025 23:25:06 -0800 (PST)
Received: from tempest2.wbe.local (xt27d7.stansat.pl. [83.243.39.215])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6415d91f486sm6047907a12.22.2025.11.09.23.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 23:25:06 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Antony Kolitsos <zeusomighty@hotmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mwl8k: inject DS Params IE into beacons if missing
Date: Mon, 10 Nov 2025 08:23:49 +0100
Message-ID: <20251110072359.2295615-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Marvell AP firmware used with mwl8k misbehaves when beacon frames
do not contain a WLAN_EID_DS_PARAMS information element with the current
channel. It was reported on OpenWrt Github issues [0].

When hostapd/mac80211 omits DS Params from the beacon (which is valid on
some bands), the firmware stops transmitting sane frames and RX status
starts reporting bogus channel information. This makes AP mode unusable.

Newer Marvell drivers (mwlwifi [1]) hard-code DS Params IE into AP beacons
for all chips, which suggests this is a firmware requirement rather than
a mwl8k-specific quirk.

Mirror that behaviour in mwl8k: when setting the beacon, check if
WLAN_EID_DS_PARAMS is present, and if not, extend the beacon and inject
a DS Params IE at the beginning of the IE list, using the current
channel from hw->conf.chandef.chan.

Tested on Linksys EA4500 (88W8366).

[0] https://github.com/openwrt/openwrt/issues/19088
[1] https://github.com/kaloz/mwlwifi/blob/db97edf20fadea2617805006f5230665fadc6a8c/hif/fwcmd.c#L675

Tested-by: Antony Kolitsos <zeusomighty@hotmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/wireless/marvell/mwl8k.c | 61 +++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 891e125ad30b..97462d05c9ab 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -2966,6 +2966,42 @@ mwl8k_cmd_rf_antenna(struct ieee80211_hw *hw, int antenna, int mask)
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
+	const u8 *ies;
+	int hdr_len, left;
+
+	ies = mgmt->u.beacon.variable;
+	hdr_len = ies - buf_src;
+	left = src_len - hdr_len;
+
+	memcpy(buf_dst, buf_src, hdr_len);
+
+	/* Inject a DS Params IE at the beginning of the IE list */
+	buf_dst[hdr_len + 0] = WLAN_EID_DS_PARAMS;
+	buf_dst[hdr_len + 1] = 1;
+	buf_dst[hdr_len + 2] = hw->conf.chandef.chan->hw_value;
+
+	memcpy(buf_dst + hdr_len + 3, buf_src + hdr_len, left);
+}
 struct mwl8k_cmd_set_beacon {
 	struct mwl8k_cmd_pkt_hdr header;
 	__le16 beacon_len;
@@ -2975,17 +3011,32 @@ struct mwl8k_cmd_set_beacon {
 static int mwl8k_cmd_set_beacon(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif, u8 *beacon, int len)
 {
+	bool ds_params_present = mwl8k_beacon_has_ds_params(beacon, len);
 	struct mwl8k_cmd_set_beacon *cmd;
-	int rc;
+	int rc, final_len = len;
 
-	cmd = kzalloc(sizeof(*cmd) + len, GFP_KERNEL);
+	if (!ds_params_present)
+		/*
+		 * mwl8k firmware requires a DS Params IE with the current
+		 * channel in AP beacons. If mac80211/hostapd does not
+		 * include it, inject one here. IE ID + length + channel
+		 * number = 3 bytes.
+		 */
+		final_len += 3;
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


