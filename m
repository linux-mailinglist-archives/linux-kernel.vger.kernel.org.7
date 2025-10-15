Return-Path: <linux-kernel+bounces-853719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28ABDC66C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2C7189F198
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFAB2EA480;
	Wed, 15 Oct 2025 04:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ud9y8Mid"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B181A23B9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501179; cv=none; b=s5MAkVAYof6m5UtFD98NhfJRu4J18tElXjmzCVSsKo+h2vevdfv0jawZIaJC2BdtsgVVULEPfja31yfRvwUXr5kxtzqUppVwRAgK1YN07jf5BjVeB2b39oXZoHdzX8wX4I3D0b9UgsrGhxeQgvug3/bxlZ/fym1t2CubuVrNl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501179; c=relaxed/simple;
	bh=/44g2pYdKq9ygg0TXfmnBV9QwRff63b+9J/B5/ccqSs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qz6pLoIkW7zv5iV5FPxSMIwKQHN4rhWN8x1ERSeS9QjEHrlzspM1qBO3Y6pfoqObVOXsXcETD4ss200JP2BFQXn7bCqtXOSRazypaxYfjwGW/NjvCANOt8ZMfHg04hAaydDHCTahEOdrnza2dAkEW0y6sg+mJGPArMAZ1Q+7Z3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ud9y8Mid; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2908b2ecc19so628665ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760501177; x=1761105977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSFpqpnYHV+0VrMTT9QxKJCNx7rDHc24HZbRx5FVpUQ=;
        b=ud9y8Mid9NHQDKTeDYJL5uB8UjDfiJsGR7kAG77zVottw86cS/4/4218BX/pBqHoHH
         D8k9CZjFTf0fYaQv9CO731KbcZeYV4n5hqjQuPKT+KrIwmAX/gDp6mbBTirZTp0IacHY
         W4t7EJgzgltDgbLPRCu+gM4n1b+YC1R5MIroeIWMs01Y2U0V31IQqdVyjFpLIArXgHk9
         noRTXlsqq4HQtpz9L/nZTak4jiITSTmeSUHVXNbiL+QhJ0LUY4g0mBl7Z42JkUgszS5m
         iILSsMm9KD6bigKZJRk8E3OTJm6bEPq4GvU0EiTKH6fNgaMF+kxDCwabb98Gk2hIzo7e
         gVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760501177; x=1761105977;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSFpqpnYHV+0VrMTT9QxKJCNx7rDHc24HZbRx5FVpUQ=;
        b=Qb3cKEBttflYDrnsoc5ddcxN85QKdOI3hnPOV36D+e6X8t+6iVk1U2HvHB0r7BWSs1
         3ztrWpv6jsw/ajvl2ZSvLmngj2k5BnTT527GW94qRqzScNjQOKLTl7BdLVAAPkviAnd4
         Wfez3K1hI4jytMlOh4Ps2mJytRzZ+LdX3IyV3TcHfc/yWslGwVCtqEI8Suj6NfozijTk
         ceBUecBUInf/+IydRSx4ARhRwJg4xbgo6GUUMTp14bAqGU2WJGIIAfntp6YTs0/vX2VD
         SNx7fuuagWWblHrHmB1aBafi02ggSQSVfDY1VYW9/2a5c2n4Onlmmb+WOpL010whnamh
         pTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXgDKzAHGoUdq8pNSPgOwnYdVAbyAi6zW2uFRlCn783Ujz/J2gc8vkiIjPYefvTHbRxKtSFRxnSIUTAfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Irij42T25nibIIJMvxmh3VwPuQBS4Oc0YhUAm0bGmm6ntFd0
	3JY76jtxZkZmgqApOWFRXhPShp+IU+5Nx0ZdLyZ7RN/PtPYEUbIVyBkeAH3y5ljj8aIT0NN8Sem
	UqstUFA==
X-Google-Smtp-Source: AGHT+IFgyMNpiiRDvkqL7tmLH9mFZypAKUQC0necQHOSaL+v002UwQa/dCcrVFmA7Ze0fy1fgpF/jpkehhI=
X-Received: from plbli4.prod.google.com ([2002:a17:903:2944:b0:269:f500:5735])
 (user=badhri job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c6e:b0:267:ed5e:c902
 with SMTP id d9443c01a7336-29027374b4fmr337326395ad.20.1760501177557; Tue, 14
 Oct 2025 21:06:17 -0700 (PDT)
Date: Wed, 15 Oct 2025 04:06:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251015040607.3005975-1-badhri@google.com>
Subject: [PATCH v1 1/2] tcpm: Parse and log AVS APDO
From: Badhri Jagan Sridharan <badhri@google.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	badhri@google.com
Cc: amitsd@google.com, kyletso@google.com, rdbabiera@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The USB PD specification introduced new Adjustable Voltage Supply (AVS)
types for both Standard Power Range (SPR) and Extended Power Range (EPR)
sources.

Add definitions to correctly parse and handle the new AVS APDO. Use
bitfield macros to add inline helper functions to extract voltage,
current, power, and peak current fields to parse and log the details
of the new EPR AVS and SPR AVS APDO.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Kyle Tso <kyletso@google.com>
Reviewed-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 15 +++++++-
 include/linux/usb/pd.h        | 69 ++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index b2a568a5bc9b..6e6c27df3c2e 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -823,10 +823,23 @@ static void tcpm_log_source_caps(struct tcpm_port *po=
rt)
 		case PDO_TYPE_APDO:
 			if (pdo_apdo_type(pdo) =3D=3D APDO_TYPE_PPS)
 				scnprintf(msg, sizeof(msg),
-					  "%u-%u mV, %u mA",
+					  "PPS %u-%u mV, %u mA",
 					  pdo_pps_apdo_min_voltage(pdo),
 					  pdo_pps_apdo_max_voltage(pdo),
 					  pdo_pps_apdo_max_current(pdo));
+			else if (pdo_apdo_type(pdo) =3D=3D APDO_TYPE_EPR_AVS)
+				scnprintf(msg, sizeof(msg),
+					  "EPR AVS %u-%u mV %u W peak_current: %u",
+					  pdo_epr_avs_apdo_min_voltage_mv(pdo),
+					  pdo_epr_avs_apdo_min_voltage_mv(pdo),
+					  pdo_epr_avs_apdo_pdp_w(pdo),
+					  pdo_epr_avs_apdo_src_peak_current(pdo));
+			else if (pdo_apdo_type(pdo) =3D=3D APDO_TYPE_SPR_AVS)
+				scnprintf(msg, sizeof(msg),
+					  "SPR AVS 9-15 V: %u mA 15-20 V: %u mA peak_current: %u",
+					  pdo_spr_avs_apdo_9v_to_15v_max_current_ma(pdo),
+					  pdo_spr_avs_apdo_15v_to_20v_max_current_ma(pdo),
+					  pdo_spr_avs_apdo_src_peak_current(pdo));
 			else
 				strcpy(msg, "undefined APDO");
 			break;
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 3068c3084eb6..6ccd1b2af993 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -6,6 +6,7 @@
 #ifndef __LINUX_USB_PD_H
 #define __LINUX_USB_PD_H
=20
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/usb/typec.h>
@@ -271,9 +272,11 @@ enum pd_pdo_type {
=20
 enum pd_apdo_type {
 	APDO_TYPE_PPS =3D 0,
+	APDO_TYPE_EPR_AVS =3D 1,
+	APDO_TYPE_SPR_AVS =3D 2,
 };
=20
-#define PDO_APDO_TYPE_SHIFT	28	/* Only valid value currently is 0x0 - PPS =
*/
+#define PDO_APDO_TYPE_SHIFT	28
 #define PDO_APDO_TYPE_MASK	0x3
=20
 #define PDO_APDO_TYPE(t)	((t) << PDO_APDO_TYPE_SHIFT)
@@ -297,6 +300,35 @@ enum pd_apdo_type {
 	PDO_PPS_APDO_MIN_VOLT(min_mv) | PDO_PPS_APDO_MAX_VOLT(max_mv) |	\
 	PDO_PPS_APDO_MAX_CURR(max_ma))
=20
+/*
+ * Applicable only to EPR AVS APDO source cap as per
+ * Table 6.15 EPR Adjustable Voltage Supply APDO =E2=80=93 Source
+ */
+#define PDO_EPR_AVS_APDO_PEAK_CURRENT	GENMASK(27, 26)
+
+/*
+ * Applicable to both EPR AVS APDO source and sink cap as per
+ * Table 6.15 EPR Adjustable Voltage Supply APDO =E2=80=93 Source
+ * Table 6.22 EPR Adjustable Voltage Supply APDO =E2=80=93 Sink
+ */
+#define PDO_EPR_AVS_APDO_MAX_VOLT	GENMASK(25, 17)	/* 100mV unit */
+#define PDO_EPR_AVS_APDO_MIN_VOLT	GENMASK(15, 8)	/* 100mV unit */
+#define PDO_EPR_AVS_APDO_PDP		GENMASK(7, 0) /* 1W unit */
+
+/*
+ * Applicable only SPR AVS APDO source cap as per
+ * Table 6.14 SPR Adjustable Voltage Supply APDO =E2=80=93 Source
+ */
+#define PDO_SPR_AVS_APDO_PEAK_CURRENT		GENMASK(27, 26)
+
+/*
+ * Applicable to both SPR AVS APDO source and sink cap as per
+ * Table 6.14 SPR Adjustable Voltage Supply APDO =E2=80=93 Source
+ * Table 6.21 SPR Adjustable Voltage Supply APDO =E2=80=93 Sink
+ */
+#define PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR	GENMASK(19, 10)	/* 10mA unit *=
/
+#define PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR	GENMASK(9, 0)	/* 10mA unit */
+
 static inline enum pd_pdo_type pdo_type(u32 pdo)
 {
 	return (pdo >> PDO_TYPE_SHIFT) & PDO_TYPE_MASK;
@@ -350,6 +382,41 @@ static inline unsigned int pdo_pps_apdo_max_current(u3=
2 pdo)
 		PDO_PPS_APDO_CURR_MASK) * 50;
 }
=20
+static inline unsigned int pdo_epr_avs_apdo_src_peak_current(u32 pdo)
+{
+	return FIELD_GET(PDO_EPR_AVS_APDO_PEAK_CURRENT, pdo);
+}
+
+static inline unsigned int pdo_epr_avs_apdo_min_voltage_mv(u32 pdo)
+{
+	return FIELD_GET(PDO_EPR_AVS_APDO_MIN_VOLT, pdo) * 100;
+}
+
+static inline unsigned int pdo_epr_avs_apdo_max_voltage_mv(u32 pdo)
+{
+	return FIELD_GET(PDO_EPR_AVS_APDO_MIN_VOLT, pdo) * 100;
+}
+
+static inline unsigned int pdo_epr_avs_apdo_pdp_w(u32 pdo)
+{
+	return FIELD_GET(PDO_EPR_AVS_APDO_PDP, pdo);
+}
+
+static inline unsigned int pdo_spr_avs_apdo_src_peak_current(u32 pdo)
+{
+	return FIELD_GET(PDO_SPR_AVS_APDO_PEAK_CURRENT, pdo);
+}
+
+static inline unsigned int pdo_spr_avs_apdo_9v_to_15v_max_current_ma(u32 p=
do)
+{
+	return FIELD_GET(PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR, pdo) * 10;
+}
+
+static inline unsigned int pdo_spr_avs_apdo_15v_to_20v_max_current_ma(u32 =
pdo)
+{
+	return FIELD_GET(PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR, pdo) * 10;
+}
+
 /* RDO: Request Data Object */
 #define RDO_OBJ_POS_SHIFT	28
 #define RDO_OBJ_POS_MASK	0x7

base-commit: 877c80dfbf788e57a3338627899033b7007037ee
--=20
2.51.0.858.gf9c4a03a3a-goog


