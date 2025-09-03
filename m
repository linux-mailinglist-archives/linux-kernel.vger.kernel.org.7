Return-Path: <linux-kernel+bounces-797641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4223AB412D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0BE206160
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E6D2C2348;
	Wed,  3 Sep 2025 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ewsting.com header.i=@ewsting.com header.b="AFF7ctD5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K26D5+i1"
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0181853;
	Wed,  3 Sep 2025 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756869515; cv=none; b=fXV9CHdhObYwXLc6hX2VjbYP7VgC+18y8JLoGGGiAuHApSlTzPaj/eIlVWWbQf0f0kL3gzJaX9249mLm2cEIsGYvyY5Pq6F7eZ4zSOkcCuN4/sO9A0XOZGIzvt5IxlkJuu9gNIOcnK3/Uh7T8MLGg86bsMisAnOtkGDyzfeLxxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756869515; c=relaxed/simple;
	bh=+XAiQdwEKKjx4kZCat6VJkTBDxQ1h6cQE5wcr39BkfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cywZu9EIlOxQXbMf17jMlZDDg0ssIfQimVKLYqswkHu9+hg7vJIOPDEFraDYBgurFPFW3taprSlWfUc/XSYXMY6XrqYrS8LWEnQQiPNqNENpbAxcMBz6l2h0VzmV6V+TKJL0kIBSjR/31mjbSbycjMaeR92IzFPXWiu53H3jIgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ewsting.com; spf=pass smtp.mailfrom=ewsting.com; dkim=pass (2048-bit key) header.d=ewsting.com header.i=@ewsting.com header.b=AFF7ctD5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K26D5+i1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ewsting.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ewsting.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C3066EC02EF;
	Tue,  2 Sep 2025 23:18:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 02 Sep 2025 23:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ewsting.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1756869511; x=1756955911; bh=C2NgMjoLg+HfZOV56VM3Z
	r6kcsvwgGg0k3kMWY7pzMw=; b=AFF7ctD5PCnm+ljeAIzg/xqoA4u/sHOl79ee7
	9d2RDCOaSSbOd4XE3+lOzq8E3yeg1g78hwr0AaoQf/YPwSAoRlJMX0brYsXxTPyi
	ACSbMSxR8U1q9DOHbHn3TE20GevMVholhOtpy8BHUeLFe9NT/RerUtYurZuwQiC2
	yG4SZ97nXRSUs/aeKNf65V8ohtmyEboc8mMZdvjirzIPUOiSMeoYEZC7RSNsrn8J
	YRFfm98Gw6Ys4VBKhu4FMaStu7boprmmPhHJWKpshozDIlrrp3YVov0+ds+fabga
	r+3kpPg4Ljn05kDjdlSL7w7cXzfBUMk9ObmBPPUfZzJzshyuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756869511; x=1756955911; bh=C2NgMjoLg+HfZOV56VM3Zr6kcsvwgGg0k3k
	MWY7pzMw=; b=K26D5+i1pU0f+e2frNHPOhimUvqNAm/eHrhO88wOpsbfkczP6hy
	2MWdDmlSEkIsseSTHbUDXQ6yx931MnSIiaZ3JWd6srmGmAzIWwZztS3ch/0evdqL
	lYf24i2f7X3LBqCSAUUyj3v9lSLYfQeB/N4LfzUTne4hpjqB0ZiI9AFxcsKpe88x
	BPyGmizRA9v4SN7nkMrjofENM9ERnTKbf1VoZUswyZXdW5dT49G9ORcmMHUKr6Nx
	s1FZavnShdHBv/mbXyJOcrwwuD/gsxs48dvmT9MAtfnNjDniq8GLgUBNLRTvA3H8
	hZUyLwqa8DQV27/v3m2EUo+J3YlsrYNeQHg==
X-ME-Sender: <xms:h7O3aNuaBpMWExUj-JHEOJhB00Z1I_d5uypj87wx8oA-rrw20oLOvA>
    <xme:h7O3aOEMr6iWCDJ7eOgs5SfPgXv8yGGr3QqPXxoSn8NcQiORgJdgNEM88rtqKytxb
    AKpXtX5z8ls8P4sQ9M>
X-ME-Received: <xmr:h7O3aOac76Ndc3xOVUDWsaPiC18iXmgwzuvx4AjIxptYog67Eds4wBf1oSpziKXh9bxgiCN1OP2f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoteeftd
    duqddtudculdduhedmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepvfhomhcukfhnghhlvggshicuoehtohhmsegvfihsthhinhhgrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedutdetffdvgfffgedvieefffetjeffudduueetueeigfevteff
    udehtdekleetleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhomhesvgifshhtihhnghdr
    tghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epthhomhesvgifshhtihhnghdrtghomhdprhgtphhtthhopehlihhnuhigsehrohgvtghk
    qdhushdrnhgvthdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtth
    hopegvuhhgvghnvgdrshhhrghlhihgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqhhifmhhonhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:h7O3aOUvkb9bHNQfz0lLO3_raALnNNYUsF0w6U9qetdCR_jMASxmjg>
    <xmx:h7O3aElA3jPhWaSMI3Z4UTSX9uih4fYHro5Qy1XhwBuIYjeNDBJrfQ>
    <xmx:h7O3aJCD7XyztpDP-Lw6AvUakUXFRBdd2sRaP4h6dUfXHE3jfLFhCQ>
    <xmx:h7O3aDhizJ7b_4nJYjcrPgc-KOn84oCLev29K2KYswNcoUVkbxIVLA>
    <xmx:h7O3aI3FnqJJgVx7YVmkkRc-cePg7nXMNiDl6QZ_EacQ6A6bTpsuiq_w>
Feedback-ID: ie4e64890:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 23:18:30 -0400 (EDT)
From: Tom Ingleby <tom@ewsting.com>
To: tom@ewsting.com
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Eugene Shalygin <eugene.shalygin@gmail.com>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (asus-ec-sensors) add ROG STRIX Z690-E GAMING WIFI
Date: Tue,  2 Sep 2025 20:17:56 -0700
Message-ID: <20250903031800.4173-1-tom@ewsting.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the ASUS ROG STRIX Z690-E GAMING WIFI

Signed-off-by: Tom Ingleby <tom@ewsting.com>
---
v2:
 - Rebased onto hwmon-next
 - Link to v1: https://lore.kernel.org/linux-hwmon/20250902051603.35633-1-tom@ewsting.com/
---
 Documentation/hwmon/asus_ec_sensors.rst | 1 +
 drivers/hwmon/asus-ec-sensors.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 12c6b5b266bb..e5052159ffa0 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -36,6 +36,7 @@ Supported boards:
  * ROG STRIX Z390-F GAMING
  * ROG STRIX Z490-F GAMING
  * ROG STRIX Z690-A GAMING WIFI D4
+ * ROG STRIX Z690-E GAMING WIFI
  * ROG STRIX Z790-E GAMING WIFI II
  * ROG STRIX Z790-I GAMING WIFI
  * ROG ZENITH II EXTREME
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 09a751b44ee2..728e21fddae8 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -625,6 +625,12 @@ static const struct ec_board_info board_info_strix_z690_a_gaming_wifi_d4 = {
 	.family = family_intel_600_series,
 };
 
+static const struct ec_board_info board_info_strix_z690_e_gaming_wifi = {
+	.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
+	.family = family_intel_600_series,
+};
+
 static const struct ec_board_info board_info_strix_z790_e_gaming_wifi_ii = {
 	.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
 		SENSOR_FAN_CPU_OPT,
@@ -735,6 +741,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_z490_f_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z690-A GAMING WIFI D4",
 					&board_info_strix_z690_a_gaming_wifi_d4),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z690-E GAMING WIFI",
+					&board_info_strix_z690_e_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z790-E GAMING WIFI II",
 					&board_info_strix_z790_e_gaming_wifi_ii),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z790-I GAMING WIFI",
-- 
2.51.0


