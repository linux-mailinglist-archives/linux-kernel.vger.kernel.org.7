Return-Path: <linux-kernel+bounces-795551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA06B3F44B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 864307AFDB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E52D7DD1;
	Tue,  2 Sep 2025 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ewsting.com header.i=@ewsting.com header.b="FYDDvodd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RwSSNWhx"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D94E54652;
	Tue,  2 Sep 2025 05:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756790238; cv=none; b=nn2wXQeiLkZ+TTT+6/MxZTPz2bXuqJncoqPpKDRnwb/uv1JZuKhVRF8H9LlOklJWhVG7N6ts0j8f0Mub+NBCahTNVFA1fzzMivcB6t275PQfwjMxWpEmKk9TI4GiX81pdaEEfWX/dSElHSrQRw/3tGwNqxhAAb2EYd6X/Z2jNJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756790238; c=relaxed/simple;
	bh=89O6hTTAmvbNc2M6jYvCzqNeq3RFv1ZVzAtWHbVogp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfNCV7Zm64V42J6/BrkIWfcYYYqZpV75sMBtDGNKoBj6wJCX3+89LmOzg02jjEHgdJZ21J46Z0PlMloS7v1YduqG2YqEfqHUJGboHLLPU2rMYPqlOw5VuNg4iNXrycSDrNRM6LCNXrfSMsfqgnEaHf17kgpEvIbu7JJ2xdfPLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ewsting.com; spf=pass smtp.mailfrom=ewsting.com; dkim=pass (2048-bit key) header.d=ewsting.com header.i=@ewsting.com header.b=FYDDvodd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RwSSNWhx; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ewsting.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ewsting.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6CFCD1D00347;
	Tue,  2 Sep 2025 01:17:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 02 Sep 2025 01:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ewsting.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1756790235; x=1756876635; bh=woLBz1bUQiCABCptixtOE
	zP/0CtuUPqRPOJ6sbLTMiE=; b=FYDDvoddTRBdIRqnskXbQrfXeqLwxvYAxLAK7
	Yk80DMz88gDE56KLJK/SdvOoJGq8YtyThFUxEZtZhBMobiQoZa63pv2qESqGD6Ib
	ZhGaiHvAw04f8CRHmBf+BSWvXjEjwfKWNbCyXx8AW9aAT0YgiX+GDBfLrUMxG1Xa
	+LeeST16+IyKrOdNTbBIz9QmLm4brt3E/qYXxzLDXMchIICFN1Q/rxVtWYhLgaB8
	QgDNyVFsW4HBVbYyckTpsLlSDgTckGarp6TDoWteZmer+M263SqxtL9kBICK15K8
	gc7NSOowIlXjD/6eACmvtg6xQ40JRUKJR52sKKCO95OboQXTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756790235; x=1756876635; bh=woLBz1bUQiCABCptixtOEzP/0CtuUPqRPOJ
	6sbLTMiE=; b=RwSSNWhxEtEpC0OyahKq2X4J2m/FN0L8DJcqE7dawH0aG3IMpxa
	GNFLC+qlVz5xIznhWinss6DgiVRl2BjdzN4Apo94tV5/k596VrS1rxwX1kIOfxuV
	y0XViY9Fm16XUR92nCMyXN5DVbAuKB74ALnW4eAYyynOrSgEk79infyg5u2mUrbT
	3gxydk4pa4WNLycaaWQNUdgTuYO7XHNow0h4rrXJIS9/K51xBnQXOlbccdSKbXqv
	i6TrVlnTrpXNa9XNPzV6DSV1lSr/CbTFciHMvSgPK7roxbk9D5a3IBqpW177VYN8
	K84WPhiGXUKoQ5ytwv4fp674k0DELNgRtCw==
X-ME-Sender: <xms:2n22aOaBdToe8V4eh0s97LcNrnpLUV7dFOU6NZeQDNna2d9_EKK2IA>
    <xme:2n22aIJDiC2fbvUuPwVQdFAckcVPM1-3e2b4_vywnefc5ti5Ty2ZXYlRf_SJOXt_v
    cntl7HK-7mGKOGRHXw>
X-ME-Received: <xmr:2n22aKtqN_oPyxG2rl-WI-4IQiahk1xKc9L7U0HGWaGIhiMniB01fG5iPriiU545kWaSbxb5hNvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegote
    eftdduqddtudculdduhedmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomhepvfhomhcukfhnghhlvggshicuoehtohhmsegvfihsthhinhhgrdgtohhmqe
    enucggtffrrghtthgvrhhnpeehkeegteefvefhgfejleeuudefgeejieduveelveffjeej
    ffekveekieevkeegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehtohhmsegvfihsthhinhhgrdgtohhmpdhnsggprhgtphhtthhopeekpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhmsegvfihsthhinhhgrdgtohhmpd
    hrtghpthhtohepjhguvghlvhgrrhgvsehsuhhsvgdrtghomhdprhgtphhtthhopehlihhn
    uhigsehrohgvtghkqdhushdrnhgvthdprhgtphhtthhopegtohhrsggvtheslhifnhdrnh
    gvthdprhgtphhtthhopegvuhhgvghnvgdrshhhrghlhihgihhnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheplhhinhhugidqhhifmhhonhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2n22aMXhL3qfJmOgl5gU-QQV4XSuLvBhicL14I0vjH1nuE3XIJNTRg>
    <xmx:2n22aFjUYhAYfgCuyelkQoSn67M8kTckTE3o5feCuiuJIVY48dHx4w>
    <xmx:2n22aEqpe1fZ7SArTPEcjxZRF-TSWYLhz_uBMP7K7ZpVJwOsX_KkCw>
    <xmx:2n22aLFGmafua6Iyxgb-GV-S7cBzgve8NY0wnA4DNRFSQyujisj3MA>
    <xmx:2322aMd2FNfZP5gZAsTrgecaVTVRi5JJWOT55Ww4-q9jA4R5FYmUKK7s>
Feedback-ID: ie4e64890:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 01:17:14 -0400 (EDT)
From: Tom Ingleby <tom@ewsting.com>
To: tom@ewsting.com
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Eugene Shalygin <eugene.shalygin@gmail.com>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add ROG STRIX Z690-E GAMING WIFI
Date: Mon,  1 Sep 2025 22:15:58 -0700
Message-ID: <20250902051603.35633-1-tom@ewsting.com>
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
 Documentation/hwmon/asus_ec_sensors.rst | 1 +
 drivers/hwmon/asus-ec-sensors.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index de2f2985f06f..e5ff386f2dda 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -32,6 +32,7 @@ Supported boards:
  * ROG STRIX Z390-F GAMING
  * ROG STRIX Z490-F GAMING
  * ROG STRIX Z690-A GAMING WIFI D4
+ * ROG STRIX Z690-E GAMING WIFI
  * ROG ZENITH II EXTREME
  * ROG ZENITH II EXTREME ALPHA
  * TUF GAMING X670E PLUS
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 4ac554731e98..d3ee43e2a333 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -554,6 +554,12 @@ static const struct ec_board_info board_info_strix_z690_a_gaming_wifi_d4 = {
 	.family = family_intel_600_series,
 };
 
+static const struct ec_board_info board_info_strix_z690_e_gaming_wifi = {
+	.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
+	.family = family_intel_600_series,
+};
+
 static const struct ec_board_info board_info_zenith_ii_extreme = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
 		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
@@ -642,6 +648,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_z490_f_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z690-A GAMING WIFI D4",
 					&board_info_strix_z690_a_gaming_wifi_d4),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z690-E GAMING WIFI",
+					&board_info_strix_z690_e_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME",
 					&board_info_zenith_ii_extreme),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME ALPHA",
-- 
2.51.0


