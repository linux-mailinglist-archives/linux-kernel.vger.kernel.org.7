Return-Path: <linux-kernel+bounces-727389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D4B01979
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7FC761176
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAD2280332;
	Fri, 11 Jul 2025 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="njJ97rF5";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="GyOnSe5Q"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BA927FB19
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228814; cv=none; b=nnPoJE3fLhBO6g0hWkacHTxd7SBaTHCezZMf0Q51WbTT1X1+hkRCyGVkrPbKXambZS2Q0T8hTKtnRMzPMwz6zIgbnjXN4HnYHFiSXURG4YvSqisggzczK2Ge2XFgJj3LqfEccPYZAO8jwn7jctrmjQI2pILYHYOwwH6H3dHDsRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228814; c=relaxed/simple;
	bh=h8sDtTBFaKQV2BzaMtetG1bYXeS9efVwysgWyiEug68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eo4a7VvaAVnteNLmlPl6wBCAgzKpRXmi3nDtzoIjMvmWMCKKfPC5ib1wJCsF5uaVQDxbGYBNTIgraypT5G/FhSkuxJnec58nq/SCgM0Wn6pWjxve0+LcIa6jHh86qJY9fpgtpOaldfNOsz8A/fvkVf8pigL7ZtB7KOPF7vQI2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=njJ97rF5 reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=GyOnSe5Q; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1752229712; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=dzP7r4lWPYTYs3RU7pAFEhDbKI/TMIWoBzzkQ7Rua34=; b=njJ97rF5NihJXst7F7w2m9obxj
	X4mYODutix/BC4lAb6VMI0QU1I32Gg6O5mNVcroCkhHK7btEYgYrCn5cA7bJnMrgl0lXh3T3We4Dz
	oWOhKmlSKU8any6oZ8r3CEURh2fRV0kp0EiwbON9OxadBgBtt7zTVSfLAsNO/0Ea1wIVwmFr02fPW
	2mq17zNyZ6DfRT7yvC5DiZ5qpaT4zJWYuMgPKz+qRzsJNreV2Y+JR/CqfUXgNmk/tjT5sI05Y4xtA
	8H7zc4oBL+/dYVv6yk1AHrEKH39i6sKW4Ctp5plSv8Aqq2bmrjdAo0zTMXiRxir95ltHR1IYDj1Dl
	sRzt9p6A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752228812; h=from : subject
 : to : message-id : date;
 bh=dzP7r4lWPYTYs3RU7pAFEhDbKI/TMIWoBzzkQ7Rua34=;
 b=GyOnSe5QHOVGwPKv1m5m21dy6fuNi1ydZRdEuxcOuiWTxlA1lg/fwpZ/Fxo70mCyLjTIK
 EpVX/8LrYNrqJ3eDaXCEn+F9SRoyHojNHuZvN/moDzU6jPJgwWMV4jDbazvtKO88niv5vaf
 hdvzwt092gIdkHVVPB6XtB2sI9LcSgqPdUtdsumNk6lbL23a0DBWBNrWSenLoRchTTGLZw7
 INz/+k+a7QJh+XwvFG7X5sag3T4pmOnVEOS4QTh+ktAfDSXHMM1jDyUzD00kz/vV2k8irP+
 +ycawfq6O2HV4fPZFtcxgZZLytwnBapqYGCW805iat06QWlqE5zaI29esUWA==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAkv-TRk697-0t; Fri, 11 Jul 2025 10:13:25 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAku-AIkwcC8mMix-JkmE; Fri, 11 Jul 2025 10:13:24 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PACTH v2 wireless-next 1/3] wifi: mac80211: Get link_id from
 freq for received management frame
Date: Fri, 11 Jul 2025 12:03:18 +0200
Message-Id: <dd0eb517cf088f386b00c138563bda3c778ebe41.1752225123.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1752225123.git.repk@triplefau.lt>
References: <cover.1752225123.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: K8KxmYQGhkNx.sPRxa3Z5KdA2.IacAFQsVM8Z
Feedback-ID: 510616m:510616apGKSTK:510616s4UM4Uu-B8
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

A non-MLD sta could want to send offchannel management frame (e.g. to
do a offchannel scan). Because ieee80211_rx_for_interface() fills the
link_id information with the link the sta is currently using; hostapd
would send back management frame responses through wrong link causing
the sta to miss them.

To fix that, use link_id that matches the received frame frequency if
any or do not fill link_id indication for management frames, relying
on hostapd instead to infer the proper link from the received frame
frequency.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/rx.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index caa3e6b3f46e..26be0f378b3f 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5114,6 +5114,37 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 	dev_kfree_skb(skb);
 }
 
+static int ieee80211_rx_get_link_from_freq(struct ieee80211_rx_data *rx,
+					   struct sk_buff *skb,
+					   struct link_sta_info *link_sta)
+{
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	struct ieee80211_sta *sta = &link_sta->sta->sta;
+	struct ieee80211_link_data *link;
+	struct ieee80211_bss_conf *bss_conf;
+	struct ieee80211_chanctx_conf *conf;
+
+	if (!status->freq)
+		return link_sta->link_id;
+
+	for_each_link_data(rx->sdata, link) {
+		bss_conf = link->conf;
+		if (!bss_conf)
+			continue;
+		conf = rcu_dereference(bss_conf->chanctx_conf);
+		if (!conf || !conf->def.chan)
+			continue;
+
+		if (conf->def.chan->center_freq != status->freq)
+			continue;
+
+		if (ieee80211_rx_is_valid_sta_link_id(sta, link->link_id))
+			return link->link_id;
+	}
+
+	return -1;
+}
+
 static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 				       struct sk_buff *skb, bool consume)
 {
@@ -5131,7 +5162,15 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 	link_sta = link_sta_info_get_bss(rx->sdata, hdr->addr2);
 	if (link_sta) {
 		sta = link_sta->sta;
-		link_id = link_sta->link_id;
+
+		/* Use freq to get link id information on management frames to
+		 * allow for offchannel scan, roaming, etc.
+		 */
+		if (ieee80211_is_mgmt(hdr->frame_control))
+			link_id = ieee80211_rx_get_link_from_freq(rx, skb,
+								  link_sta);
+		else
+			link_id = link_sta->link_id;
 	} else {
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
-- 
2.40.0


