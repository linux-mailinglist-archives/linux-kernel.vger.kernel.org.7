Return-Path: <linux-kernel+bounces-735573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C513B09122
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE5F7B5B16
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6042FE38F;
	Thu, 17 Jul 2025 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="o3tGQGT8";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="WhEsPQJL"
Received: from e3i105.smtp2go.com (e3i105.smtp2go.com [158.120.84.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F82FE317
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767760; cv=none; b=lSlXKxs/2MhcV3PGibESnMMi86gvl9QbejahNSGiAYYOeM87CiU6W3VnkAgh4uGeg4I3vPQKT9UGCrjk15nNsq/zToKr3Dn+ZZis5y62n0uODuRCx0VuvFyoAOwRqfC00RQWP3or+L5z/OFBQ4Y2E7rEvmft7vXDdSK0D8xpnv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767760; c=relaxed/simple;
	bh=U47f9WVWX49XwgYkmvGT+3joZrWkuzftZnBDgHqGLyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jUXvgWp+CFDPQlCU4xOF+lSKvtgokniWGKM8lyHz56GioCRGABUJesHBWKzyyH2mHrzU71atDOobILpGH8JByOyrxU6DY1zYEaDdIlkxaJkkPTmVtgTeZ5bHAdI3B87BeoX1MpSkZ87a5PLHiMeop1TvLF8J+wxnwpwQ6fqyVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=o3tGQGT8; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=WhEsPQJL; arc=none smtp.client-ip=158.120.84.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752767756; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=OYtEACTZzGea53FbOPy1SO3CM3inWtkbAiQquRgeXPc=;
 b=o3tGQGT8tvhtbrZV+PABj2NRo0Hop+GGs3ba6L+RbOiWiP/HPSdDd4j/LNEdlXVNzdKvv
 DefAR+g4NVuMBgFxIy8PczNObTX3T/VAWsXwnilMxHjA7EI8xUZZOp8v0HoRk+GazhpNOK1
 ZeH8jqzijJ5l0Vb9A1ORtP1OIa3qx4g0j2Wgg6GGHfIn76YgxtubDzo+eYBmUlW/WFgr42O
 JJj1OD2x9O48L2iExww524WayrCq/RDUNfoZ157gE8FtKQe4t8yRRyZnhkc2ViRTc5DajKx
 7WSWPl7lOqwLvWbASMVib1ieEbuDRzYMVAPujo246UROtQH6YhrVbX5NULKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752767756; h=from : subject
 : to : message-id : date;
 bh=OYtEACTZzGea53FbOPy1SO3CM3inWtkbAiQquRgeXPc=;
 b=WhEsPQJLV0Ix5X9ultIKz7MuDVHIy7eBFgUmFG4VrVVdrSzft8zmHhoCRxKFbMO99hDeB
 KKTHWTSigeF7fr/7y+eGHEoiWcktn72GQaVi+VEPdWU5nllATSuUUFBReQ6nIF6oMjvPsec
 g4xGt5BinCwCBYJJLa7MgvoYI+YkD9RVzX30h6QOudGdQMshc1W6WunXpMe4koeYHH8+Wfz
 gLUXoOqNVEe5hkfHcg7VS2wSGRLYRFvOm7q0q5axkawiZotrvJoTx+aJdCStpypzKj19TXI
 dtq1CkmsaYJR9z3o0DfHaS6G+1oZVohzNidHEm7KyerXQE2eCS7V9dPAAG/g==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1ucQxZ-AIkwcC8pXvG-HvHi;
	Thu, 17 Jul 2025 15:55:49 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH wireless 0/2] Fix ieee80211_tx_h_select_key() for 802.11 encaps offloading
Date: Thu, 17 Jul 2025 17:45:27 +0200
Message-ID: <cover.1752765971.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sQtDXqd4MU
X-smtpcorp-track: TpLUUthlanCT.hcnMLS2wF4Eh.5mKSvQZeLry

The fix in [0] introduces issue with mt7921 chips (at least), due to the
802.11 encapsulation offloading support of those chips.
ieee80211_tx_h_select_key() treated 802.3 frames as if they were 802.11
ones causing the skb's control block hw_key to be invalid.

The first patch fixes the root cause of this issue and the second one
reapplies the initial use after free fix that has been temporarly
reverted meanwhile.

[0] https://lore.kernel.org/linux-wireless/06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt/

Remi Pommarel (2):
  wifi: mac80211: Check 802.11 encaps offloading in
    ieee80211_tx_h_select_key()
  Reapply "wifi: mac80211: Update skb's control block key in
    ieee80211_tx_dequeue()"

 net/mac80211/tx.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.50.1


