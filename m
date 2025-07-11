Return-Path: <linux-kernel+bounces-727388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F93B01977
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E69A4A0D43
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182AE27FD41;
	Fri, 11 Jul 2025 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="xpqXM3qN";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="H0EjvsKf"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551F27FB05
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228813; cv=none; b=o1tBr1X8KNfy+6YWhbY37yRRZNGUvLnTA9rbwWaA2D+fNuXziQYdwdBQwfkdb+niyhExHMsx+3aYJvalwD0QSLG4EFrCiuIQ1hix5VrP7HaSMXkz8Re8HdGdh0rFZujBY5MmNo+WJmhfckC0dwyAs5SEH783KeNYwV2dBw7ywh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228813; c=relaxed/simple;
	bh=ImKq2rn+4T7uQY59CuD2QZLaohTp66nHrgzJOoPpZlY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fqetfCr1lizxWb/6P8KvArxLsNkrG5hJHdV8nbM89OYLiamGam8S8n/2sWMNA7ZPDARXYzLMQuCNT/iH0ZrqJp4LBHqLVdP68V6uo/5WKZ9Jm8WSaoJC/bg/Bjzlp3OGUR/UbY4YAR7UHvF/SJDdgfvwMLBsGgLGIcFIDFWkVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=xpqXM3qN reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=H0EjvsKf; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1752229711; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=LWttc/saTpTqPkGokRytJGpWQYncHL0xmTev5i5twbU=; b=xpqXM3qNcttFGUbd6+dRVmN1oL
	uegwSeKOZ38gJ3pFAet5b8DXbV7yJ084z4cXRpRcjc2lY9fhMxqRX8kdgnGkrGueF4eSM+LNVq2im
	JvBTMVVeGy6r/dZ5E+v5pI09vzCy1GLwmiQ64PONqjVOt/wqyDbsdTz65ESdlnQXxqq7l4xYlP7Tn
	exc+kAPj/4gU1iPp93ieb2eqm8vjwkIgY75oRmTtXabF7yrOWP8mkjkPgI6qxVkmn5t75ZZ0GW4SW
	xiVv9KuK/Q0D7kw1W1g12U5DoWV7fZu8wn6ukns98N/W7puoYBHUOcX8N+WhEcF8n4wfkVVfVt3F1
	bwQdBbhA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752228811; h=from : subject
 : to : message-id : date;
 bh=LWttc/saTpTqPkGokRytJGpWQYncHL0xmTev5i5twbU=;
 b=H0EjvsKf94+mGN6NPkR1QQiVt3vu3fQkHA8CBN44PN57oaGW9QwlbtDmY8i/POvsu8Rih
 QkF+fsZzdm+8phmlIUE3p6KHfHK8JuExOxDK+OzYaBCSAsFUxWBqBWu1Sysrmpz029nD3Rf
 mwCfW1PYgCKg0/Lfwb5i5yKjqXfKz1Tqmtr6haE8nJJRAtp0+5XT6zHrfiXZiU8ZIBnvSrM
 NmzsOZ/JzkiYTNIdEjLvsSzL6JyQd+xj7opTvpgfmngbzBqKZNcg8NjxHQtdMf25Nl2EsHm
 Y/sqAGBer2Oxhat2RGGiqAjs4HwBus9fM8pvwBu9oPngpurJgisex+nwLHTA==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAku-TRk66u-B2; Fri, 11 Jul 2025 10:13:24 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAku-AIkwcC8mMi3-Gz1i; Fri, 11 Jul 2025 10:13:24 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH v2 wireless-next 0/3] Allow non-MLD sta to roam between
 MLD AP links
Date: Fri, 11 Jul 2025 12:03:17 +0200
Message-Id: <cover.1752225123.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: xASNJyEO5_C7.DK4d6Mtbhyor.X1fLuwI8FAC
Feedback-ID: 510616m:510616apGKSTK:510616sr38dkfA4L
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

This serie aims to allow non-MLD sta to roam between same MLD AP links
as if they were two BSSs belonging to the same ESS.

The first issue is that when a non-MLD STA is connected to one MLD AP
link all received management frames are reported to userland with the
current associated link id even if STA sent those frames on one of the
other links (e.g. offchannel probe request). Because hostapd relies on
this link id information to select the proper link for answering those
management frames, probe responses to offchannel requests are sent
through the wrong link and the sta misses them.

To fix that, the first patch of this serie tries to match reported
management frames link id with the received frequency. In case no
suitable link is found, frames are reported without link information
(link id == -1) and hostapd does the freq to link conversion to respond.

The second issue comes from the fact that hostapd queries a sta removal
for the previous association even after the sta has successfully roamed
to the new link, causing the current sta to be removed. To avoid that
the second patch checks the sta removal link id parameter. If a link id
is supplied and the sta is not currently using this link, this removal
is ignored. An additionnal hostapd patch is needed so that a link id
parameter is added with NL80211_CMD_DEL_STATION requests, and will be
sent to hostapd mailing if it appears that this serie makes sense.

The third patch fixes the link id information initialization when tx
frame with 802.11 HW offloading, this will be needed later to get sta
roaming working with ath12k. An additionnal ath12k fix will also be
provided in order to get non-MLD sta roaming working with this driver.

This serie along with the mentionned hostapd patch allowes a non-MLD
STA to successfully roam between several MLD AP links with hwsim.

--- 
Changes v1 -> v2:
   - Moving this serie as RFC. I am not fully satisfied with Patch 1/3
     but can't find a leaner way to handle off channel mgmt frames.

Remi Pommarel (3):
  wifi: mac80211: Get link_id from freq for received management frame
  wifi: mac80211: Correctly init MLO link in ieee80211_8023_xmit()
  wifi: mac80211: Check link id at station removal

 net/mac80211/cfg.c      |  3 ++-
 net/mac80211/rx.c       | 41 ++++++++++++++++++++++++++++++++++++++++-
 net/mac80211/sta_info.c |  7 ++++++-
 net/mac80211/sta_info.h |  2 +-
 net/mac80211/tx.c       |  2 ++
 5 files changed, 51 insertions(+), 4 deletions(-)

--
2.40.0


