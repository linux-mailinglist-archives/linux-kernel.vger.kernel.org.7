Return-Path: <linux-kernel+bounces-735575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09946B09120
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F66E1C46196
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD8C2FEE09;
	Thu, 17 Jul 2025 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="oginOUih";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Rzg2h8G9"
Received: from e3i105.smtp2go.com (e3i105.smtp2go.com [158.120.84.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAC72FA65A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767761; cv=none; b=ufKT7D45ynqeWgJt+kh30rNUMgAM/eZG1ycBwDKazV2J9s0CmhEcml7NoNJHXwspmhBDD8AFt5Hp2wth79YZeCvT+GysJ93mNRq2RwbrQGyt7gHaCWdlbT2gQWQgZMFk3HGKL02eiO8Lw02ajgBT0SHDX+Cp5JiXcNMfSCL3CmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767761; c=relaxed/simple;
	bh=nB3WuwalJ9U/+bfO3AqJtL5A16Qj0C4J1YopVLVq6dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BssloBuqBmZ7I11pIZlmQZH0xiAjLYu28OZr2GY0lhQmUjeBKTq+H4qruMEPAqvAESwUfzSckDQ7fBv8rptqoj+WBTN3kmwQqo0gN43nV6ZHPT5XT44C0jARy48nkmpwEmZDexjV4uO+Yeb1BvPsznK6rnvtVSMFnOG5n/gq+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=oginOUih; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Rzg2h8G9; arc=none smtp.client-ip=158.120.84.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752767755; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=9ZDHBHMgGYp8rnsczho/Xwe4hAvNHcAACUmeGw53gPw=;
 b=oginOUihhX69ypXyTLUdWqgkdF5JxFQeoExRdj2YnZLcbx0LgBSXNLLV56KsMxLxT2jHw
 jsnK8t8pk2O4TbBl3bpnAnGUygVGeRjg0aFZ1ObfK1CLjC4nMqRN3h9sVSkjXvYwKqzX7sP
 5fo4/RLrVNaifu3XuNyXHzEX3JJYksQo8ICOBiP9ob4GgOgugKZY01LXOmQGh6xGEjEW8S6
 CfKf7zm+paPumeVTrTbXJ2TTWegIMyEHMfYCW9OBlU7eggYHVFvHi3f7zY7gprrwEVj9/gW
 XKpp7ZGpWTwecOdOzx/O5ea3ahLe7eINcf6AEMP1SMyzdGRFdgCp3edYbZjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752767755; h=from : subject
 : to : message-id : date;
 bh=9ZDHBHMgGYp8rnsczho/Xwe4hAvNHcAACUmeGw53gPw=;
 b=Rzg2h8G93j75r3krFvj5ciJhtQ1u8U7Gc8NsqsChaV0UPhRW7ZWlJRQ5GTbQOd2kX77Pr
 A2KG9eYMdY6mweI9VpXJ4tWRt4HwLgZ9/q+p0sN1KTKiF+c7L/POAeBHUum/a13pOfOjtr+
 lkIBmiZL152wVATEQeALWkSiYOI3xBUzPjaWpE4OHL77HT0Ee/BGHnkbgan5LmKTjNMxjsK
 vU2Nt4mhnBoYXwgIExkmPtDPGerLJ+Qdoo+OsNJcipke1LUmy7lh4zTqL+pcS6K1LSPc2Gl
 eokm1R6liwdF0jDNqntTOCd+aGb0ikTfgNutPd4os/xG9vQVjdDfmJArUNrg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1ucQxZ-FnQW0hPwcJx-nuXC;
	Thu, 17 Jul 2025 15:55:49 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Remi Pommarel <repk@triplefau.lt>,
	Bert Karwatzki <spasswolf@web.de>
Subject: [PATCH wireless 1/2] wifi: mac80211: Check 802.11 encaps offloading in ieee80211_tx_h_select_key()
Date: Thu, 17 Jul 2025 17:45:28 +0200
Message-ID: <1af4b5b903a5fca5ebe67333d5854f93b2be5abe.1752765971.git.repk@triplefau.lt>
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
Feedback-ID: 510616m:510616apGKSTK:510616sYIRlMKefe
X-smtpcorp-track: 3giNsy77KLpy.T5nKk5GR7r8K.ZimjfwN1lOd

With 802.11 encapsulation offloading, ieee80211_tx_h_select_key() is
called on 802.3 frames. In that case do not try to use skb data as
valid 802.11 headers.

Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/linux-wireless/20250410215527.3001-1-spasswolf@web.de
Fixes: bb42f2d13ffc ("mac80211: Move reorder-sensitive TX handlers to after TXQ dequeue")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/tx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d58b80813bdd..0af5bf9aba6a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -612,6 +612,12 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 	else
 		tx->key = NULL;
 
+	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
+		if (tx->key && tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
+			info->control.hw_key = &tx->key->conf;
+		return TX_CONTINUE;
+	}
+
 	if (tx->key) {
 		bool skip_hw = false;
 
-- 
2.50.1


