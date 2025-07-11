Return-Path: <linux-kernel+bounces-727390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E57B0197A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EEB87AFA7F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A07128136E;
	Fri, 11 Jul 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Tb0hsBBl";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="NjKhmJo4"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF327FB0E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228814; cv=none; b=lBHMQsAcPqaN/hU/i84Kkp9kp8t7b+uJrsF+7rVQrHXTFxtXr2K04USHElrnKPb/VrzdbzwEfgDh4d+9xQKD1gJYgDnr/Wgzbpp7+fAa2Ffrh2pe3I2IMONKkM/97tyN0SumiHCmV1S9D3s/LMe04SeMcPfVJWBbZUtbIZI7tHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228814; c=relaxed/simple;
	bh=iYW1urDA+J8ItpsBASZ/fIer3hBLBgL3fsKPeaG4LEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mn6uyak0CrGQCV1anteObt7M9bN1aya3E6b22jaZ5cGAZ0qU1oQCQZTjYs0ErM74Lz6DMG1aU34ckEaUKMaicPU1+TOm0NiNHVnV6jFwDALbP1Wks0AVAKJUs1iF9UxG96PyblCWzDBRZy6MD3Q8AiViwFEXsISMDixrUG+yOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Tb0hsBBl reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=NjKhmJo4; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1752229713; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=X0gOzHc7MjO+Xkrz1FdedGsE2tBnHEgnmzARquvVn0E=; b=Tb0hsBBlaI8UHghL5szhsfUxpC
	m4GjKMjb0lqtcJuMKU2aYXnU0ZcWewuYEsBkiC6iAhB7jPpzZRO7i1WuJ8hB6sdK/nd4WbycoPePB
	35ZwQus5mf3YHn3n2e0QTkLfRwaJfLMz14lGL+4QfuO2fbu7LvSe3PlmxjEqstGFMyTHj4TGVA+eM
	wvUSUNWqeLvUHWBmpvuXezZpOI/VW32qe1mrXo2Ea0Uy3BWiZd9V+Y1je68Nwvk1rGK8wTy/rPurF
	heh1Dgdp3dzmMrInBo2nSdKpV6ye+/pXEzAqgPxW78+BJcLu5TSaUSbFxmBbvmrk6GwnTnDH5xbxm
	LaSNUfaA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752228813; h=from : subject
 : to : message-id : date;
 bh=X0gOzHc7MjO+Xkrz1FdedGsE2tBnHEgnmzARquvVn0E=;
 b=NjKhmJo4DB8U3bJBMissUGcs6hqd3QbCOH/Y5LfFKIQ0Sdz5rR7/xIDi+zrWmgD+wdgPp
 bIY//gYRwmvJYs+GpG1JIvaEKenlkd5116D0C0VcLIuLOb67NtF/T+G+AyNg+3tFT6EvunC
 XDwx2Ack/5VfbaqCo7QsNuVXH+4YD4/7XnK5iRRTIHIz8T7Umgm3IYkrZLujY1XAvYqGiaR
 mu/+IZ3HLq/BobmXFfG72fGnjHv+Ib9R2tmDVHr4wMjM3eCekXKd2tQFeVO+feLIefTcSvN
 4CQGSwK2w9XjZuPZMNbhyG1HZbP7/SvewOXMtF55BkDHeu5FNtOMYWQ3Vzdg==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAkv-TRk6D0-RY; Fri, 11 Jul 2025 10:13:25 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAkv-4o5NDgrrfkz-mXyv; Fri, 11 Jul 2025 10:13:25 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH v2 wireless-next 2/3] wifi: mac80211: Correctly init MLO
 link in ieee80211_8023_xmit()
Date: Fri, 11 Jul 2025 12:03:19 +0200
Message-Id: <a62f4c066c967c954648a409e5e1fa185d6edeb6.1752225123.git.repk@triplefau.lt>
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
X-Smtpcorp-Track: soChYzaxMFMR.ugBXRM-nzJ7U.wQiEqQBwzO2
Feedback-ID: 510616m:510616apGKSTK:510616sbg9r1WNUf
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

The IEEE80211_TX_CTRL_MLO_LINK info is the only part of
ieee80211_tx_control where a 0 value has a specific meaning. Thus this
should always be initialized with IEEE80211_LINK_UNSPECIFIED if there is
no MLO link information associated with the skb, even using when 802.11
hw encap offloading.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6fa883a9250d..1d6b976bba72 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4638,6 +4638,8 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 
 	info->flags |= IEEE80211_TX_CTL_HW_80211_ENCAP;
 	info->control.vif = &sdata->vif;
+	info->control.flags |= u32_encode_bits(IEEE80211_LINK_UNSPECIFIED,
+					       IEEE80211_TX_CTRL_MLO_LINK);
 
 	if (key)
 		info->control.hw_key = &key->conf;
-- 
2.40.0


