Return-Path: <linux-kernel+bounces-853735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D954BDC775
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537533E090E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756822F60D5;
	Wed, 15 Oct 2025 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8vboY39"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1086635898
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760502622; cv=none; b=bRVANjV6zABBem3wxAx8uRJ1cmNwQXaAH1ylOtUBj6AOaAismuc1qf2INAREmL4yHiz6OPg/iK3dj6cy8Koaujc0AnKmIsNTpth3l9tyY4/vwY9iYCM01QBNqNWhdby3y56wOp51L+n1ZpnPb/xxL+MqwaDKMHM76rXUFf6MQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760502622; c=relaxed/simple;
	bh=tI6xu8FNuNdQiwVzMsVnkzJ+aBpDpp8EFG9ToW77OBw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C4wlKzy345L2pVuMaMaDXjuEZWZEPaizGigWMlrKVKsPblLYtjteBDemSCGnI6cQU7RrEWu3QV2zNtzLmivuOXetjkdvHHGRsExvYcSQa7/ZacmN1jLZilKObD7l39kmfNVHy6PziodVjXyKUIKkqz7bt7G97VZSzm2e7VmKxWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P8vboY39; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77f64c5cf62so7259821b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760502620; x=1761107420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yXIS3j5RCM6hVOr2uUyAFDWEwpmVgDpaa3qdMiGXfzc=;
        b=P8vboY39CGR1wBuXwAUB6icKTjBN/E5CN6KuzovcTdbXQ2Uu/QLzItQfWbt7Axy9dc
         ESGO11vCg65kttMh9MppNMuLJt0lOQzmeXDYqwu+hlitrVoNxlKVAzaia000+ZWirWgc
         Gvd+NHNi1MSKEy9B5dbO692mXfXbqqiLLXirDEdKrVJTgS2rqwTxz0rU0nW/DFCKIQHe
         y976MCEQqcK9UhXuFy0noNNW5fg89RKDSonawbENDUoNz8CPRBR4Z3Km7vD2c3as2hmF
         wiEJSeEeUPI+sWcaCVj7PUHRy0mvCXZ480bGK7AvSlqN7yDsDFZcv9n3gCH0BOAtVkFZ
         4ZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760502620; x=1761107420;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXIS3j5RCM6hVOr2uUyAFDWEwpmVgDpaa3qdMiGXfzc=;
        b=MsdHJnIUmsFEZ7oxJcibTS/owehE3+F3DyoYEdYn+T7rn9zt6cjuVCZNa5v131DteN
         AX1rdbZijw9UUT9MP8lrg5lwROwPTZ2P7VxOXsMW+RymPczS23D3GyhFz7SLD7fuTOa1
         6HGSHOyW/KU6M6sPigdUlQDeTWf/CwfxfmXaClWWxH3gGOpSQUsUi3/lzpwvyGoRN7Nf
         Eu4e5NC0OGSEWXU2XLRXJzQLWLmXXag5hoioI2i3UD23rJbdHHX7XWaK+1sDxqqCHpVz
         6ugF13fROVNg9ZfV0XjivRHXDrR9agpEml8W61CGSkODCR37HlxvDt/TqpW9x/Ee3gwA
         YYcg==
X-Forwarded-Encrypted: i=1; AJvYcCW+Pg+zOryuo1BVwDC40OqN0H0uRtBa0s1PERYdkqNPkoFzzerlfKrzv4OCv2IggXqseHjex/Bx/th8axs=@vger.kernel.org
X-Gm-Message-State: AOJu0YweJDf9Abt63yYv2Pj7wxfAebnEltVlFqFyCUb0lELG4ObsEf1v
	IoOvpJ4QKaTQLXC4+kV7mgVtLgzjirzjpzBn042ZjK3m8Xac07A826IlIRh60vfCNm/ogvd+2/m
	j8tXr1g==
X-Google-Smtp-Source: AGHT+IGaZTXT0vciEx7KbYADGeZKTtU68kLvCRG8tGLPmqjhQRCZK5Ay8LX5GjcyaqfAjeV5ynjINN8aGkE=
X-Received: from pgbcs7.prod.google.com ([2002:a05:6a02:4187:b0:b62:e03a:896c])
 (user=badhri job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7589:b0:32d:b97f:6483
 with SMTP id adf61e73a8af0-32db97f6505mr22015042637.22.1760502620374; Tue, 14
 Oct 2025 21:30:20 -0700 (PDT)
Date: Wed, 15 Oct 2025 04:30:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251015043017.3382908-1-badhri@google.com>
Subject: [PATCH v2 1/2] tcpm: Parse and log AVS APDO
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
Changes since v1:
* Fixed incorrrect squash.
---
 drivers/usb/typec/tcpm/tcpm.c | 15 +++++++-
 include/linux/usb/pd.h        | 69 ++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index b2a568a5bc9b..c65aa8104950 100644
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
+					  pdo_epr_avs_apdo_max_voltage_mv(pdo),
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


