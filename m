Return-Path: <linux-kernel+bounces-894982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF940C4CA1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0595B4F9EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEAA2F1FDD;
	Tue, 11 Nov 2025 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGhv33bP"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068FA2F1FD7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852714; cv=none; b=G6LFoKjDU7juh0djrFwcRlSjJ05VcOxSMQ3hWdcWEQXaZFJUJlWf30qQ4hkJz35MCNVpCo7l+82sI2yMjJgyrbNLFrl1OzGRELlufHyfAVd6Zq0tlngX3Me8s9TsRysrZD2IEO+ixN7XYWxY8d4YtUF3rbYfZosiInnWrxXF5j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852714; c=relaxed/simple;
	bh=SYMCs6IARkW/lZNSJmIn0XhOmmhkphMEY31kEhj1XjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+wBUKzxsXy0JwY2C18uqbfQl4z1sxry8FSAmRgNIWTD3b087QKe8UWyIY2/60MG3x07tr04njhSwZ1vFqQFhtRrDPS3ALHyDvZ11PXTrviOr69F4mXRNCfflqIv4M04x8Op2zouiy7Tp0o9Ke26RHsEk9i5S6o85YqQ2KWxWbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGhv33bP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b72dad1b713so489894266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762852710; x=1763457510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NHCO1d37EeP+V9PmUIUb4Wzw3rgGoWYS9h8j1CUD1ds=;
        b=nGhv33bPEGoQcmn/IVr4EDp1O5mi1FowYGcmoy569+8oYvfnlRfYZYkWDRgWxk9yay
         hI30aLqlyATbw51fks1qCkVjdg771sUmXVd8KHNC6eCS04IPvjg5Ry/GRyErFkqfa3XF
         0hYrFaqqzRqCmlhiKl+C/bHOLv+2OtzGPAYhce+w/OUE3Vb3USuyqC9Hjo3NXYm1rVnZ
         novBrlrrDRAAfXnipv3+2q4Dqw6Ath0ycjCY6tJMAShCPHIi+rLBhIH0dmbybkwvvute
         IOmvm7u5Sw5tOON/4LhtqEL5zzMrAHmZH37b0MSTMMrzbphtLF+xIXK8Q0BiENZ8oESY
         IhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762852710; x=1763457510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHCO1d37EeP+V9PmUIUb4Wzw3rgGoWYS9h8j1CUD1ds=;
        b=t02G7LLpurGH+qJF5MGQEKfvAPRmvSOSWqb/vw/r/bqMRcenDXfhB6/4RTlbUqjy0m
         jpIeI9RMhv6I7ZouwEO6RcIgmlrPq8j19lc1TBZ8zFkAGc8JpIG0XElfv+81NxQzl/7X
         bYl2R83cY1KxjuAeDjTLhTChhEBW/0ST9O4B5A2zgWXYgf90WntYVO3h0S27h3dRAq69
         loEwMuJ12xcQHD3OqLdFazQ94faLsTgVuJ8QxojVK2QUbAh5QdgMNpuvbt6QCI+4IdQD
         kXc3US/7a6rr2WRo0Z68Q5IUySCtXWeb03lv14Q0Feljcz5700Irb2KuHoQUApxgDKWn
         2XKw==
X-Forwarded-Encrypted: i=1; AJvYcCVZi2/oJJI2UAbuOek7d3kK7oy9gY+Qk9XfL2yJBpF1KGho7u08dzLztU9regTizzJO7GVRN9oGgNIAkMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Ckt3w7mzdvR1o0cDA5MzE8Mhh6pjlYKgAt28OUuhY6DEg5Co
	TaPsjSlncpaUz5awCsWmozi5BO2dtMycYppMZh+EFxq3ZDGn3yx928/N
X-Gm-Gg: ASbGncuKAyeJJeiipVrB23dw71Aen+KOsUgC0k1vxP/XeVGr+vsP6ZkM4Qv++YzOeQ9
	O4toOhdoszMImnBLOdz5dxXxKK74hYBt0B9wpqUVqZeJcJnzZQkKIW6gEfkrgP+nvhrryoiDiDN
	WMbXaiuVTtzNFpFWCzgNjiw3VezArw6ojj3hTs03ZjQEDcsknyLQrfGucRhizow8OA9tG/zB5y0
	w2FH0EMkE1kxuDVtEo2IDA2DgCHw/dGDY3XUyI5O//83gT4BaU2vsEcgpFFuKy/u9zz4K9e1DEF
	zbmsSB4R4OHW6mR6tjpy4+pSHDmjb54hxR5V5eiUOvL/JEcpS13wlz+ZexnIeyx4OGcstuW8uuN
	KWkUjMRxaBCXJUPMSoNQ1J+SOipaNTTuFN8GnKFQ2ZY91B6tQwWElAfzM4DGeUXj1bK2Ro/mKvV
	t/82cEY3PAOdKj2pS6kS1hy/ZQQcA=
X-Google-Smtp-Source: AGHT+IF0sUsr02exVWB3sJgaPpmNYrn8j5MgaPfx/m2oC64aA1GIC9/OXl0RkFQl27OsOWGCqREJSQ==
X-Received: by 2002:a17:907:6d0b:b0:b6d:6bcd:6c59 with SMTP id a640c23a62f3a-b72e062615bmr1148531166b.64.1762852710016;
        Tue, 11 Nov 2025 01:18:30 -0800 (PST)
Received: from tempest2.wbe.local (xt27d7.stansat.pl. [83.243.39.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d0ffsm1350690266b.46.2025.11.11.01.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:18:29 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Antony Kolitsos <zeusomighty@hotmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] wifi: mwl8k: inject DSSS Parameter Set element into beacons if missing
Date: Tue, 11 Nov 2025 10:17:04 +0100
Message-ID: <20251111091708.2809266-2-paweldembicki@gmail.com>
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
---
 drivers/net/wireless/marvell/mwl8k.c | 71 ++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 891e125ad30b..3acf71cb5007 100644
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
+			WLAN_EID_SSID,
+			WLAN_EID_SUPP_RATES,
+			};
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


