Return-Path: <linux-kernel+bounces-727387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393CB01978
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42B54A1005
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183F627FD45;
	Fri, 11 Jul 2025 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Dt4bBXYK";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="C81Q7tJ/"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF1827FB0C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228813; cv=none; b=OctYwysUNASDy2phX+5UoQ7+a5ZnylcBJRWyImGXmonGwGXa3fjEUzjMLrJrWPc41lKZo6+arvh/sMzZpAc/y6YDobBKYooSHHLRhb2TdkCOaKMlh2Crz6MQtP+xubryaKWGrMEwhfO8e8yk0jFHOhBLWLxgB06sc5Fb5E6kXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228813; c=relaxed/simple;
	bh=wZRySA4lz28cjksFVP733NJp4H6+uYUyG7offN581Wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=naUch3ZNruoSXRwUtZ3DGONYZT0nFWJVCBYVg4DwBYd9ufgjkJG/37uKSF/pA7saeXEiKW5jbXIAQoZcn30+Vm7/x1rOTStc+8GgNUJStE02XTC1fegWh8I5I/mb0WgyveRKY1aprTk2/jjzMYBJ1LcJab56/+h6nf8TDzh/zzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Dt4bBXYK reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=C81Q7tJ/; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1752229712; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=K5i9iQTovVSe0BiRNCldsIl2QT/Jg4d39IT5+8FPoo4=; b=Dt4bBXYKS5L9SSKIDhe2Xj9x+W
	dkGukrvjKu+w2/YxJUVnRaPqKb1bNChBvfg5rHdah/4CnFmvOoqwPSMkl7AKtmT2H0gKtSSFr9pBA
	WsZzQXOEpoO2Ld7IfpV2Z713D9rUpWmatFQcLarX4YTHTwCnB/J/HxfNAg43YoZXhbN5k24tM52Ou
	iwMBlimsI/3F+xALe1mpu5npFcZnaN0AQa/Yi6+uqjwwn50qX1htTYdSj4Jgt2KN2tSwv/WFKalVf
	C5Yc81PJtCEztvtjgkH0E4XugNnI26wLl5y34h1Zl9hIaglJ6ogGRcOZcWTJjz/jeCL0UVBl0S3Um
	pr6TkPbA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752228812; h=from : subject
 : to : message-id : date;
 bh=K5i9iQTovVSe0BiRNCldsIl2QT/Jg4d39IT5+8FPoo4=;
 b=C81Q7tJ/2/4i5j60l2cZ078FBW+loOCJBqquvp+kqbuZilKiTExaoGdW1L0koB1kNuJBY
 CCBbtjAPtDZX0B13fk81EoJxzuo6e0+YfS/w/79yJohH44BEZgGJ41tJAVwtFtUciCICfD1
 nahzTxhozkMINlczfboM2ONsNwBYqrU2S9JBQWiFOioJqyV/svEzAIHhkqFDCjU1YjGsdSA
 e0NpdMLIQdrJMqAom2j+/X9pZ7nRPCMo8OMLDDsi30BTKs7q7WaJNk145PTUJTzGgPIeiyo
 /b73B8jT0scFQfZWF9MgxmveL3t7+lesZ4mXsT5XtIO59yG14VW4MMLUaDaQ==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAkw-TRk6Ep-Cd; Fri, 11 Jul 2025 10:13:26 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAkw-4o5NDgrka66-oyAz; Fri, 11 Jul 2025 10:13:26 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH v2 wireless-next 3/3] wifi: mac80211: Check link id at
 station removal
Date: Fri, 11 Jul 2025 12:03:20 +0200
Message-Id: <ce42107117526535474cf81d514fd030c7376e85.1752225123.git.repk@triplefau.lt>
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
X-Smtpcorp-Track: JAhK-vQaQhF5.tbMelu8K9EC6.KacG2Qrg7fa
Feedback-ID: 510616m:510616apGKSTK:510616sZr30L41yo
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

hostapd can remove a non-MLD sta connected to one link of one MLD AP
several times. If the sta roamed to another link of the same MLD AP
between two of those removals the wrong sta_info could be removed.

To fix that remove sta only if it is currently using the link specified
in NL80211_CMD_DEL_STATION if they are any.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/cfg.c      | 3 ++-
 net/mac80211/sta_info.c | 7 ++++++-
 net/mac80211/sta_info.h | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 56540c3701ed..727eea74bd37 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2217,7 +2217,8 @@ static int ieee80211_del_station(struct wiphy *wiphy, struct net_device *dev,
 	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
 	if (params->mac)
-		return sta_info_destroy_addr_bss(sdata, params->mac);
+		return sta_info_destroy_addr_bss(sdata, params->mac,
+						 params->link_id);
 
 	sta_info_flush(sdata, params->link_id);
 	return 0;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 8c550aab9bdc..f43ebc97134f 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1579,13 +1579,18 @@ int sta_info_destroy_addr(struct ieee80211_sub_if_data *sdata, const u8 *addr)
 }
 
 int sta_info_destroy_addr_bss(struct ieee80211_sub_if_data *sdata,
-			      const u8 *addr)
+			      const u8 *addr, int link_id)
 {
 	struct sta_info *sta;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	sta = sta_info_get_bss(sdata, addr);
+
+	if (sta && link_id >= 0 && sta->sta.valid_links &&
+	    !(sta->sta.valid_links & BIT(link_id)))
+		return -EINVAL;
+
 	return __sta_info_destroy(sta);
 }
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 5288d5286651..a6d2c847a91c 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -932,7 +932,7 @@ int __must_check __sta_info_destroy(struct sta_info *sta);
 int sta_info_destroy_addr(struct ieee80211_sub_if_data *sdata,
 			  const u8 *addr);
 int sta_info_destroy_addr_bss(struct ieee80211_sub_if_data *sdata,
-			      const u8 *addr);
+			      const u8 *addr, int link_id);
 
 void sta_info_recalc_tim(struct sta_info *sta);
 
-- 
2.40.0


