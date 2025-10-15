Return-Path: <linux-kernel+bounces-854606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20781BDED80
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3D8B4F396D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ED520E6E1;
	Wed, 15 Oct 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaH2cK4Y"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6A1A26B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536250; cv=none; b=NBGMV8vp5+eLWSNSW0H6mlYWphj7mfV17ZYfjV8EAjJB3hiAq2PN8lQNKxaxPEv2qdSILQF0/NsozKqiWh/iZCMefZTgi8OPvEgVBqIjIK6PnL6ILzWZ2QeApaI3odmqbRm7mTwZPPRTid5syUzm40P8ZpJpkV7EJuOWosvk/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536250; c=relaxed/simple;
	bh=knT0AgUZx/WJt/TfX3dK506+fZPjXPnwCi0Sfg3XEk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PnNb/frhXJAhc1oVP+IiD8oBvlYaIwj08+AYSy7MOqzHpNlHTGAlDH5nMWGONGZ+r5Cw1pZfD0/pLOsih6VlGcmljUqQf284JnlQljYcxZqJovOJ7K6c6z6kTMUyzWea/M3j5BZpoXMxV5JfsA3dEEk5TebAM2zIa6wvMZLPg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HaH2cK4Y; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4256866958bso3799812f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760536247; x=1761141047; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CtQg60jxxHPLg2XrygVfHHTNwesZOmU2O0EczGZvtRc=;
        b=HaH2cK4Y4jJBti0Sa6EKDsNx78ZZl83PvmH7wIQ/yTafF4FTLexi0PHIwaewfYYOsA
         Af01Nz+r9fTRddtSGGSvcRo34Ec5nQXILerojePkQlo45cBLObyxdRl0HjFd7YzEhB54
         hj28xprCWEiuuj8LdydDFKQ2I/rMhjyQfNVSe10pta23StiKjEZXDOCgVAPxZp+EPUW2
         BiX+8/ZIEBOaf9CT3dazaWDypehzx+uUGzaUK/ct2LZHOh+pKxjyvngfrUlfhueKy1Ga
         BNyAwnwplGlukfc5O31mJFy8vKtvh2JtND83H097/fDsrKlKEPrCYu/K2nGQk8M9Bbvi
         fzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760536247; x=1761141047;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtQg60jxxHPLg2XrygVfHHTNwesZOmU2O0EczGZvtRc=;
        b=LsSUxzuR2ooYy6sA1XyeQI5VGJys4ByAsRUktYu0cnuW5nNKJ47OzmLWZ1Rf0wM/Mq
         Lx21DULXZ9g/kcXdDPKG6dsILW4wW0cCbjRZ19a77Osf9b0/U6Ad5buRLNX6m/M+THmU
         hsoa3qkxa23439pp6XUNtjRTnaakNzce6uPYwGJ4YtQoGw+JLkAa3NHB04hPXzowN0yQ
         qn9AvVauysj0YDiWrwwVm8iUp6pvy1Az82kMHS6zxIWKgvxZJp5xERefxvFC9hlw0UMM
         UwfRPbuQbuJyoNi/V+FAw8ZNP/u5RdM361sx/Rp1v6W1WUs0ZL49FN1qZUQztMkl9R7G
         Tn6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGuuq3lSzFcbia4WA6dlMDdkLRZipMQti0QycvEIicvA9hfN1Q6Y+NI8gUuTgWaQQG2fwi3Cxh8h+BEbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ZUjamBgBnhO21HLbOKHBpu3GKwy/8bQ5CZfuush0SqwqhitS
	SnC6TCvwnFixQyx9KeIqvvpYQ4vkHtiNwoDwVp6gCMuDBEG/oaDsettb3dWInEbd+w6cTWBeDO9
	gV33N
X-Gm-Gg: ASbGnctOMSKZaCfLFjrw/mSzPraz7rKSTD/tRsiTRQzhyjkyZZhD99RwPXth+LGa2PK
	LL8rcg/a50HHFjKjEy9+OHxKsIIoKxZnYFbwSEbu8euz2T6PhAhOOxit2gbzd2cI0Rtmfoujnpy
	RP/VEjIPr7MG2nAT2TvcvaFJGbFP5S0pWmM64J3rpLc1XxCR2j5rSzJO9AZgugUjv+QP6aITmEU
	z04m8LBqLY+aRpDBIqmwUI7+GyxCljFB0cj4DYtsC9hcJXeIAgIRquFi+C9ErgwWR8H/xeM8Ps2
	AD02Ag/cDBBnRbXq0NAq3HlfgT6XW4ToXwx5NXEeNdEKzKIE3pjMTIU8PkklAGVHAVNDbN1MhTL
	DKyE8PJ+EH3mYoS4D1cMxB6fEh2leXToMBKc1Qhi5ITc=
X-Google-Smtp-Source: AGHT+IET9LWb+g7l3Fho2/XpjW/mb5azVvQakw10RTmxd6GzJmRhbSPq+kNx1ap6c+iHxmjFaZ7rig==
X-Received: by 2002:a05:6000:2085:b0:426:d53a:fbb6 with SMTP id ffacd0b85a97d-426d53afc93mr10252904f8f.31.1760536246782;
        Wed, 15 Oct 2025 06:50:46 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583335sm28882807f8f.18.2025.10.15.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:50:45 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 15 Oct 2025 16:50:36 +0300
Subject: [PATCH RFC] usb: typec: ucsi: Add support for orientation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-usb-typec-ucsi-orientation-v1-1-18cd109fb0b7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKum72gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0NT3dLiJN2SyoLUZN3S5OJM3Xyg7rySxBKgNl1z09QUg0SjZMu0NGM
 loAEFRalpmRVgw6OVgtyclWJrawFenFiPcQAAAA==
X-Change-ID: 20251015-usb-typec-ucsi-orientation-75ed0a2c9ff3
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3082; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=knT0AgUZx/WJt/TfX3dK506+fZPjXPnwCi0Sfg3XEk0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo76ay07z4bJL+B6GLZdNrrvquXjltLhL58A5m4
 wdEWin4R7KJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO+msgAKCRAbX0TJAJUV
 VmG8D/9pmjnhzSmP3MymHz3QutR+WJPD1tUFHKbtALhaqQteoGSS8oPclvfEO/ipMFJ7U0Y3wF6
 aVHTTNRnthGOoR7wT4DbWa+mXvNX+Gv1qyf/aYmbPdJ4uzb8ycnYeruf187VZBuJ4b1S8ZbwvZH
 qZe3dxsgilqQiXVd+NwVaI2n0D1CJdyWUVdU4YKfkELq1DWpUsFgk/kNM20uyXydrOkZUe9J6EX
 gg4UaadH/p9E3xBAM3NkilUIZbmMDUG/7hIZQQFQpckVjQCsjCbKvl3qr5OZeSgrCUio9gWidbT
 V1y/uv1P+mRILNgM1fTYLILkNR238mYAB4k0Z6Fz4JXsnEl66WAh1348zNTWUhXtE+wMMVu80z6
 1898IzLzGitRIa1IFzO7j2RiLSIFBsL33sXwoF9G7MztpK2f6L5PF5T6sSwN54kK+wrSyyz+OVS
 C9Kn/73l72fzOHBmLz1f5M3ExXANfnU8Q63VsIQKTgH5zlNaR0ND1I54IW5RoXiPy8OjaQAVZTt
 scT3LLqaAbVV4hGR0VGhrWURkTJNFzKrZEqZRuAL4nHG+XbczY/1CAVkbJ5JHT1I4sNfvQkylk3
 eGusO7P5GMAeVcDUdzEXufAQahYutRNJo9+CAviVAn0FHuGh2FfdEwq/qmWN7uoINMBiq6w17cy
 6jb1ojWxRRGN9Rw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

According to UCSI 2.0 specification, the orientation is
part of the connector status payload. So tie up the port
orientation.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 24 ++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 3995483a0aa097b822046e819f994164d6183b0d..17439ec434d41d24e8e4c7a97d7e6117fd07d950 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1008,6 +1008,28 @@ static int ucsi_check_connector_capability(struct ucsi_connector *con)
 	return ret;
 }
 
+static void ucsi_orientation(struct ucsi_connector *con)
+{
+	if (con->ucsi->version < UCSI_VERSION_2_0)
+		return;
+
+	if (!UCSI_CONSTAT(con, CONNECTED)) {
+		typec_set_orientation(con->port, TYPEC_ORIENTATION_NONE);
+		return;
+	}
+
+	switch (UCSI_CONSTAT(con, ORIENTATION)) {
+	case UCSI_CONSTAT_ORIENTATION_NORMAL:
+		typec_set_orientation(con->port, TYPEC_ORIENTATION_NORMAL);
+		break;
+	case UCSI_CONSTAT_ORIENTATION_REVERSE:
+		typec_set_orientation(con->port, TYPEC_ORIENTATION_REVERSE);
+		break;
+	default:
+		break;
+	}
+}
+
 static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 {
 	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
@@ -1258,6 +1280,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 		typec_set_pwr_role(con->port, role);
 		ucsi_port_psy_changed(con);
 		ucsi_partner_change(con);
+		ucsi_orientation(con);
 
 		if (UCSI_CONSTAT(con, CONNECTED)) {
 			ucsi_register_partner(con);
@@ -1690,6 +1713,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 		typec_set_pwr_role(con->port, UCSI_CONSTAT(con, PWR_DIR));
 		ucsi_register_partner(con);
 		ucsi_pwr_opmode_change(con);
+		ucsi_orientation(con);
 		ucsi_port_psy_changed(con);
 		if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
 			ucsi_get_partner_identity(con);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index e301d9012936fb85eaff7f260a862ff099eb77c5..c85175cd001487fa9d66076e608e098d236f5275 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -360,6 +360,9 @@ struct ucsi_cable_property {
 #define   UCSI_CONSTAT_BC_SLOW_CHARGING		2
 #define   UCSI_CONSTAT_BC_TRICKLE_CHARGING	3
 #define UCSI_CONSTAT_PD_VERSION_V1_2		UCSI_DECLARE_BITFIELD_V1_2(70, 16)
+#define UCSI_CONSTAT_ORIENTATION		UCSI_DECLARE_BITFIELD_V2_0(86, 1)
+#define   UCSI_CONSTAT_ORIENTATION_NORMAL	0
+#define   UCSI_CONSTAT_ORIENTATION_REVERSE	1
 #define UCSI_CONSTAT_PWR_READING_READY_V2_1	UCSI_DECLARE_BITFIELD_V2_1(89, 1)
 #define UCSI_CONSTAT_CURRENT_SCALE_V2_1		UCSI_DECLARE_BITFIELD_V2_1(90, 3)
 #define UCSI_CONSTAT_PEAK_CURRENT_V2_1		UCSI_DECLARE_BITFIELD_V2_1(93, 16)

---
base-commit: 13863a59e410cab46d26751941980dc8f088b9b3
change-id: 20251015-usb-typec-ucsi-orientation-75ed0a2c9ff3

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


