Return-Path: <linux-kernel+bounces-825466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3DEB8BDB3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AE11C028EB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847BC1FC104;
	Sat, 20 Sep 2025 02:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="EtIQTZXP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BemXBZ2n"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F71D10F1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758336715; cv=none; b=Xvpup5CfY26irQ+yC5NkpowNz+qhfcVj4dqPwG/wtR2BoLLGli+BN+R0Yk8KI3dwDNwhDAgtqZdWusTz44waE3uDx00in+SZFB1lOGAfYAk34eeUACd1bdrV9W9k1G7KWutGp/lOFz8MoJ5kTcQft0Ojcjsl5iVQPnEYGbEhj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758336715; c=relaxed/simple;
	bh=QlywqAczzD15iAgOol44jVJLu6Pq4GywopCkF2EOngY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRKvQerImWQaR9pv0EeXmIbRCQ5utJorlfmWgs0sPoi1HR3ogBJBBqRULkURcax8PjMvJOt3FiMMR7F46nU/Dmziy50qDThx4YAXCo7XX/OEbLYhvD/YpBUNLDXVVAPOlBBZi3Ojjs5Q5nlXYlBwdB73vz2bg/gL+2B65+vufgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=EtIQTZXP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BemXBZ2n; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D3EDEC00D6;
	Fri, 19 Sep 2025 22:51:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 19 Sep 2025 22:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1758336712; x=1758423112; bh=xf9/YYuF53
	HW6Ufjrarn7wTcw0/FDn9NhhmiveWm2rk=; b=EtIQTZXPG8TRY7jhGPe7Ky0Ern
	kZ3cgKKCfg+6Oj4/pC85jRB3Q877KY8U7Wwn/pX9t6UDPbWlZ4kK0fI3oq1dv1tZ
	6e9wkiBlarKGjwpO6BpaOYyRTPQwlahOPirMCnZQxb3U8y0y1Idk6yDTPVJZh+F0
	fwdOzccC07rQ+yt8SvdJjl80JNmqGV+R4daSCajnIBpPVdNdppZIqjAyw+4TtG0k
	zyJbXTwFWHudqYLhyibJpdU3g+oSNRftzQI6ge2JMIB+URDEtz5DggoProqF0Vs+
	bLgapVHeKNz4PdPAe/ZPdZEpfd2TMWsKkEJiL0Gi3V3DHeAKk9Gqra8ThQsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758336712; x=1758423112; bh=xf9/YYuF53HW6Ufjrarn7wTcw0/FDn9Nhhm
	iveWm2rk=; b=BemXBZ2njUpZtnLxAtOFKYj26KFNpEnsIHgcmdgjOJja7ogoNdI
	3GRLpM/jJNw7p68zA8OQUu2CxcVk5houdBDKQMMboVxC4FzL3HokO8wnJ+uIfvsa
	I03KLFRR3S7Wa+t9255Dn0PVjbS5q4UBwdg8wE9/wdAMqw+nwkTVn7gxxRhhKAAD
	3mhbNmYeP9gm9EQGohfablnS8shavp6iiW+jeC/sEgg+VsDwYqFiQ5pKYuFmaCtu
	fe12YbxvcufUWSJUl73HoPuzW5MATduarp1DFQnmtJtNNwyHfPuzm6t7xrAgsqZ2
	znbiEc1GTdxCQ/Kf0oja9Ay5e3f6Td5+Sjg==
X-ME-Sender: <xms:xxbOaPCCUe1j4Dsrdb7C7mi3W9Ido8yIbykZ2WVk_nk9Qq-qiOcA-w>
    <xme:xxbOaOfdXga96UbBIy-oM0eKn3PFvBCvosq96Iu9ZJP7RoFI9PT8oiSPsMMLDw1im
    8VC_XiJTbZZHwsw1WE>
X-ME-Received: <xmr:xxbOaMjwTXJCWEbtDxn5FM7PtavYP8vgb97STK6TL8pt2T0QEAIvVFsnEPV8VEgY0dQhHie1WclDFfe9RU-qQmS-mru6uBVMBzhZ6HP3Tg76gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevkeduhf
    etjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmh
    hotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfh
    horhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xxbOaOrnd_UMEebUUGSkoJ20x64K_K5O8zYH9njVDUcKNyR2mf9oOQ>
    <xmx:xxbOaEHy86eqyCFKjfLrx9rqGEDPre2_5Msh5-c7EKGitrN0Z84VkA>
    <xmx:xxbOaAmU7pTbGZ1S3_Ny3jFEePhKF9mS66JxTRX9SMLQlfHldgEQwg>
    <xmx:xxbOaHmhq_GoZp8j18986JusG3yjb3nHGFRPaIaMNC0pILcc47o_Qw>
    <xmx:yBbOaKGRRI98OX17ccjtWtel5aLaepG88z_gwHP50v1D5IQba15ml2Yg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 22:51:50 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: fix overlooked update of subsystem ABI version
Date: Sat, 20 Sep 2025 11:51:48 +0900
Message-ID: <20250920025148.163402-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In kernel v6.5, several functions were added to the cdev layer. This
required updating the default version of subsystem ABI up to 6, but
this requirement was overlooked.

This commit updates the version accordingly.

Fixes: 6add87e9764d ("firewire: cdev: add new version of ABI to notify time stamp at request/response subaction of transaction#")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 78b10c6ef7fe..2e93189d7142 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -41,7 +41,7 @@
 /*
  * ABI version history is documented in linux/firewire-cdev.h.
  */
-#define FW_CDEV_KERNEL_VERSION			5
+#define FW_CDEV_KERNEL_VERSION			6
 #define FW_CDEV_VERSION_EVENT_REQUEST2		4
 #define FW_CDEV_VERSION_ALLOCATE_REGION_END	4
 #define FW_CDEV_VERSION_AUTO_FLUSH_ISO_OVERFLOW	5

base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
-- 
2.48.1


