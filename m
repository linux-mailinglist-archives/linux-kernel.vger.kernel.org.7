Return-Path: <linux-kernel+bounces-735930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C4B09574
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640F4176687
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2CC2248B4;
	Thu, 17 Jul 2025 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bP58NdRU"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44CD1E0E14
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782909; cv=none; b=ZifNFwTMdbk398U6OI6oLWbTMtqelQh8U5gqODzcUl8Y6S4BxWlmg/bdQ5ilRtAgk6SeuNyP6tavktRIa2VvtQ2VLT1ZxUADL4MDRigGZWqQwTAs+BFDeqog/I8Qz/8xflgsBQZljhud56d9Vj08oUZrXjU+mz6hYwj5arst8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782909; c=relaxed/simple;
	bh=abRUT4VIbFoxvso62PscTwQkzbe7cjWiYeJMRzWSc9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSVaVaf36/a46ZdUKaYn0kYYPon6cQGH8oTkVE7SXR82SNXRLu/gJWpO3tl3wpWrqFAIZi6+D/Xh8FqKMZBJATchNw4EYKactn10OzoahvoHouadHnWRDzMCza5Dsghxq5B8jjJBj9fhRLj5+4dwMapHI9ETXuM3dYueWfRBULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bP58NdRU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748feca4a61so907074b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752782907; x=1753387707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLi/2kK2OpzvR6kQ99RKZMJhDu4imyXic6NZCN8mCPw=;
        b=bP58NdRUw943/d316eoyI+vNLBd4nXFi0tqscjJ/cYvKyf201UvQlsQlhwBqDTpHym
         7JqsbcX3SL2t9B814yMtOsyheJL2LGNVuwCYHYPD9jCAIfywhaItZA5HH4KtwFwIRIeX
         GPlAg70vzbMkhXRMsO3EavdCdzN1ghE0mNAmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752782907; x=1753387707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLi/2kK2OpzvR6kQ99RKZMJhDu4imyXic6NZCN8mCPw=;
        b=JUgpUWoignURce8Ktbyjx47NtQy2H6y/S7DYb7cZrF6QiyDMIoc32aVgSbeWBElKPx
         7xXuxkw4sZWKTx0BW1geLXYxNI9pNrbeGNzy0FaIh31X3M2dtSlyS9vZqMSEkvwCExme
         XSM7wHkbm+/H7MyT4iGQ0ZAP5RRYY7FR//LYyjYmo+PZDft7HHSv9S8gz/n4q/Rhzb05
         evi56qJGKk//5rcIPpmasRM+rqwzoAeOn8C1h2A/No69fmKV2vj3quA/xWx+4OsxTZhM
         nxrRfdngCRhARECb1r2YNNJfjRjjdb3j6ni/kGJYV1awuRG8ApddI7bcvwB0OsfR3dJR
         m4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4eA0l8r26kiOtDT1WZYPdMjH4su5wC/ngXirUB8lZIrGEKvYl5cN2LhKM36tF3TUMtbEtWTX0Nsa4giE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiw8SacyRtGUklKWFmcIA++FF8J5kT75/fUhuNLjZk3tUOpYgT
	cunzZdu9cx7NGgCC/uJTJm4Hx5qejhe9ID5wL7UiVsg+RXqXE2VYHEj3eXKdCLV3fN5+pV+POen
	Nva4=
X-Gm-Gg: ASbGncu2Z8BjvEbnrn8f0J7P39ICaJZw9KeFWtLgcSG6fxIsnf9fhgGSMZ05KuxOeKY
	ub3VBfuiHJDEoKZpMHd190eHQaX5YyTuVoWTpPp4XZjtGaHw0KDcUl59ye9adS45iFPcz8o4N4O
	PLF44QAnlsY50baRo3z/DmwnqpkZ6aqfJwL6nUv8SpuI7sHYmTgVGAgLHOC4S3X3CXqL6GGc3ks
	8bhclrZxPs3EKl2GdW+AbepCEw2BQyYd8KgVmNgPnkhPAe0fC/XxfAIkTn8Sai2sIhdV0MJh7gB
	knC2B73u5/QtwfLRIzfwpBvE1+Dg907Bos97lTNXtwVmxfER+uNuZibsnlrOO4TWewUhRMXctFQ
	FFhoNcig0D5r+w/vmO80HKVBx7XxW8o/ej9CH7s1c2KVJAGSN0l6y6++GyG9sPWaOtBAAcLmgew
	Cl4NuQi2N+NfOwPDIb
X-Google-Smtp-Source: AGHT+IG7JZ+cgjz5MqKSp68wtq2cJNg234+8XTpqvhRJWsE4682BdNtl16OfvKygzFQBJ0C5v3EoxQ==
X-Received: by 2002:a05:6a21:998b:b0:237:d013:8a78 with SMTP id adf61e73a8af0-2381484403bmr12782253637.37.1752782906902;
        Thu, 17 Jul 2025 13:08:26 -0700 (PDT)
Received: from bleungmegatop.c.googlers.com.com (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff61f6csm39467a12.45.2025.07.17.13.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:08:26 -0700 (PDT)
From: Benson Leung <bleung@chromium.org>
To: heikki.krogerus@linux.intel.com,
	jthies@google.com,
	gregkh@linuxfoundation.org,
	hansg@kernel.org,
	sebastian.reichel@collabora.com,
	dmitry.baryshkov@oss.qualcomm.com,
	madhu.m@intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bleung@google.com,
	Benson Leung <bleung@chromium.org>
Subject: [PATCH] usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default
Date: Thu, 17 Jul 2025 20:08:05 +0000
Message-ID: <20250717200805.3710473-1-bleung@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ucsi_psy_get_current_max would return 0mA as the maximum current if
UCSI detected a BC or a Default USB Power sporce.

The comment in this function is true that we can't tell the difference
between DCP/CDP or SDP chargers, but we can guarantee that at least 1-unit
of USB 1.1/2.0 power is available, which is 100mA, which is a better
fallback value than 0, which causes some userspaces, including the ChromeOS
power manager, to regard this as a power source that is not providing
any power.

In reality, 100mA is guaranteed from all sources in these classes.

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 drivers/usb/typec/ucsi/psy.c  | 2 +-
 drivers/usb/typec/ucsi/ucsi.h | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 62ac69730405..62a9d68bb66d 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -164,7 +164,7 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 	case UCSI_CONSTAT_PWR_OPMODE_DEFAULT:
 	/* UCSI can't tell b/w DCP/CDP or USB2/3x1/3x2 SDP chargers */
 	default:
-		val->intval = 0;
+		val->intval = UCSI_TYPEC_DEFAULT_CURRENT * 1000;
 		break;
 	}
 	return 0;
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index b711e1ecc378..ebd7c27c2cc7 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -483,9 +483,10 @@ struct ucsi {
 #define UCSI_MAX_SVID		5
 #define UCSI_MAX_ALTMODES	(UCSI_MAX_SVID * 6)
 
-#define UCSI_TYPEC_VSAFE5V	5000
-#define UCSI_TYPEC_1_5_CURRENT	1500
-#define UCSI_TYPEC_3_0_CURRENT	3000
+#define UCSI_TYPEC_VSAFE5V		5000
+#define UCSI_TYPEC_DEFAULT_CURRENT	 100
+#define UCSI_TYPEC_1_5_CURRENT		1500
+#define UCSI_TYPEC_3_0_CURRENT		3000
 
 struct ucsi_connector {
 	int num;
-- 
2.50.0.727.gbf7dc18ff4-goog


