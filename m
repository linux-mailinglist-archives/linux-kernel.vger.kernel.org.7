Return-Path: <linux-kernel+bounces-735579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADA0B0912A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82219A47262
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E47301155;
	Thu, 17 Jul 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="IYoii2jU";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="RuQIQteK"
Received: from e3i105.smtp2go.com (e3i105.smtp2go.com [158.120.84.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDD2FE39B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767766; cv=none; b=mNUbN8Zq9m/ubz+J+9NFFYnNAIyNkeLfs5hyiOiN/MA2VBiZGJlt3t1QYTXVBNXErc9xdBLsyRM0mIXX9znjac6EMlQ9dwNfpiwFWnYd9BBR+IQgQdtLFUo801D02ogAFgsN+R2KmaVSDb0WpipuuJ5KK6xznLRcs2Qr0SD9G+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767766; c=relaxed/simple;
	bh=2WMfvBNE2F2EmCmzIXntmRnTPlV59NtALx1Yw4oHVMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4rh/SQiUwr5YWo2CCwBMFgWi91eMxQYjzmaykYQC8ZA6e55Dcflk+uYoQTbHIIawTUUs1FLrpSyIW6MnZ0xUSahl3c6MCsw/18zzuxaYXXQWFHHhuN8E66hahOykjTdIEIZ7l5nvXoDi7YzC4wxdQjJ99FrMIlYFC0BqnhlqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=IYoii2jU; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=RuQIQteK; arc=none smtp.client-ip=158.120.84.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752767755; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=l8lNZs8wsHBELGPqY5Il4azRpO25P6AXof6ovV0cSeY=;
 b=IYoii2jUvkWvYZoc8R6xJrbTacS6C5wg117RiowMsNPks7g3KIG0HbtjA/pIZV4Clkmk0
 gh1bxjOaoKX06QFPpGpZRLA5ATpQJaNCEmJoZ5wyUxP/CRuWuqZ7LVEIkCRXBi8AavJ2/ly
 tDM67M+PEPkMWmeGnZrQ3OfqyV1c0+ruNBPMwvkP3HN0j/rcrymmsBvyuZnVNJJ13w9XHr7
 3KEnHioDQmam8KWjbcLmtG+/sMFMBJ9slO87KG8AM9A/ZhWUw56yzsZl6l9rpuIYhe4s/Yr
 ylf4XMgoXieWIwgtIcRdkGbWyTaWP5ry8PvguwhYbkrXCEazbbgOgdaRxbPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752767755; h=from : subject
 : to : message-id : date;
 bh=l8lNZs8wsHBELGPqY5Il4azRpO25P6AXof6ovV0cSeY=;
 b=RuQIQteKnhdyVza+N1CuEHI3w4uh7stOCvosQXAw1Y3+ZHu4uEUJXiNKcdW426T0grfJk
 jf2ynl6da4wIBnCasJ9gKhiHjXM0ZDPT4PkGpu/wQUwdG0+XM8QTEkg6IbFYS/KI5Sni9JN
 UOMolhhXPu825SoK+kLpg3Fjg1A3PATnM3F6ydoIt2pAjV4aIdNo+BTxWgvC+uwcucVcszU
 j07oLrzdTgxUYQS1HKHH1cVYuQC/ITp06ZTo0PTKPVC+19jXauc+GreyrltEYFpnWeSWyLr
 SgesYgYfVGl48VQrB5Rlh8AFpD65bMcWeEVqXOq7nRPL+diTflkOcCmzmgsw==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1ucQxa-4o5NDgrfb1E-lJpi;
	Thu, 17 Jul 2025 15:55:50 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH wireless 2/2] Reapply "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"
Date: Thu, 17 Jul 2025 17:45:29 +0200
Message-ID: <66b8fc39fb0194fa06c9ca7eeb6ffe0118dcb3ec.1752765971.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752765971.git.repk@triplefau.lt>
References: <cover.1752765971.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sZs8vCkADn
X-smtpcorp-track: nSPOFT87ieDx.JCkvPuioJzft.XaBgKAIAiU_

This reverts commit 0937cb5f345c79d702b4d0d744e2a2529b551cb2.

This commit broke TX with 802.11 encapsulation HW offloading, now that
this is fixed, reapply it.

Fixes: bb42f2d13ffc ("mac80211: Move reorder-sensitive TX handlers to after TXQ dequeue")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0af5bf9aba6a..fdc994d8c9c3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3882,6 +3882,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	 * The key can be removed while the packet was queued, so need to call
 	 * this here to get the current key.
 	 */
+	info->control.hw_key = NULL;
 	r = ieee80211_tx_h_select_key(&tx);
 	if (r != TX_CONTINUE) {
 		ieee80211_free_txskb(&local->hw, skb);
-- 
2.50.1


