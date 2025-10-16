Return-Path: <linux-kernel+bounces-857072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A28BE5D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFCC3A9EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C9D2E7645;
	Thu, 16 Oct 2025 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5WfYls4"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2622E718F
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659157; cv=none; b=lnG5oTjPzso1fUUe8KRiOMKPXJqfQucD/LRf1WZzy4lqpPW22+59LsazvUz7QNKVDCtg64oEp13FQbgzmucFFzScWwfvdea7/lQu7b2vYCKncWkNm70iMGs8teQFxwwNL/NDp77NUWeAQ6uXe25PGK00f4Kw2/rPDYjenXOwP+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659157; c=relaxed/simple;
	bh=y5EXC/RlVvoDBCIFu38lkbndAmXhZFWX+983xzQy9AQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DA++AK+2mDWrzKd6AGx+bQVCRwyumBzrWUUnaNCKyOAOirtyEZN78mzeE2t9WXlPZeRgREhcx6eW9tpxk5E/XE7P5F1P5aimqlk1vbLh3X8Zv91pZL0vmUfLyCBYuDelj5RB9W5j2VPMtt2EVTQ3IckVOb2yRGVlhXztupkEouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5WfYls4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2681623f927so12572185ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760659155; x=1761263955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=amhCjyCI8MmrcwuS+u9dzfqGhU0Q37AqcKDz74nSqyc=;
        b=W5WfYls41nKJ68TsW8ExbHQFqRYZABXvP4DQcIYUz1yLflXv4nHY960spUE1DLe78Y
         ABPJk5cZF+NPJltWLddq0p2ybbP0YL0/9RV4u2nmWmmvNFmEcqqABdeHe/SgZZFAZ8BX
         TerwQpC8Wzt/4rm9I+xbbJN49WhYVzZX84M9uIgLkxU4yPIAnb2HvpZ91ROiOQROKIos
         GPfd6UwqQ25OdZ5k/7YjDVWMXouBbiyU3zzpazlU+ezDhK6PRjNtTGBfnMmQXXz3e+Ua
         W4yZFFc1Y8Klm2lTKoN9TdfGzKcJPeySHD9e+i1oaqDIFyjYMaS5FXFQxvPd78KpdWhy
         s1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760659155; x=1761263955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amhCjyCI8MmrcwuS+u9dzfqGhU0Q37AqcKDz74nSqyc=;
        b=i//StzE4ZeAglcG653wzgq5jsvvWdkKluqbDpxFcqxSByJ3m/2c5SeuzlwfrWS+cem
         m3jGuX1QUJ/wAq8KQyzDf4LSoD6cdQlpEf9yZFl6NH4et4QamGhUaudkSC0uFjTzcqXC
         c4PAnh7sNvTTOJYnXZ1E7/vMEZat12Q1l9xFZCpM5exYMZuqHcgBz7tRf1rYfGUrxMw/
         f+xsmH7AMSdph1gSsB2eecDj9eetl799C3ZEiRYAnEKSETeKwfmge5XWHSKifl4eofld
         pS+OY78MC3pj0f3KnYh68+DMdYdpbyRhrVhl1R4ojFEKvCgJmCtnlHRnLowIoRnlz4Cc
         Tssw==
X-Forwarded-Encrypted: i=1; AJvYcCXp9P8wdQIGc+86IyHqM6BD2O/hq5HPlEPJpWGHaMguSZ9h/gqFM+0MV/B8tHIr3DX3CY4cnyen8Hzo87Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy459GIAqV2A+E0y26VHOjjB1ekySoXPmu63h3IuNTcxpdSCBSo
	av3qXqyaMilTMg+3XHWrV/s0L0PeX4gf+hD8HOrtPX/FPU+3raPcpZcWxToiZtX9XfxLfdV6fdO
	2Yr4X6A==
X-Google-Smtp-Source: AGHT+IGnNvgCUQhrSpH6uovgpuM+LtzLmQViNt230iZuf1i1LHjt0isB6VwcYtPMlC/XIQJT1C89rlbyfok=
X-Received: from pjrx10.prod.google.com ([2002:a17:90a:bc8a:b0:330:6c04:207])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2309:b0:262:79a:93fb
 with SMTP id d9443c01a7336-290ca121803mr21591325ad.32.1760659154882; Thu, 16
 Oct 2025 16:59:14 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:59:07 +0000
In-Reply-To: <20251016235909.2092917-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016235909.2092917-1-jthies@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016235909.2092917-2-jthies@google.com>
Subject: [PATCH v2 1/3] usb: typec: ucsi: psy: Add power supply status
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, kenny@panix.com, 
	linux-pm@vger.kernel.org, Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for power supply status. If a port is acting as a sink
with the sink path enabled, report it is charging. If a port is
source, report it is discharging. If there is no connection or the
port hasn't enabled the sink path, report not charging.

Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/psy.c  | 26 ++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 62a9d68bb66d..2b0225821502 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -29,6 +29,7 @@ static enum power_supply_property ucsi_psy_props[] = {
 	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_STATUS,
 };
 
 static int ucsi_psy_get_scope(struct ucsi_connector *con,
@@ -51,6 +52,29 @@ static int ucsi_psy_get_scope(struct ucsi_connector *con,
 	return 0;
 }
 
+static int ucsi_psy_get_status(struct ucsi_connector *con,
+			       union power_supply_propval *val)
+{
+	bool is_sink = UCSI_CONSTAT(con, PWR_DIR) == TYPEC_SINK;
+	bool sink_path_enabled = true;
+
+	val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+	if (con->ucsi->version >= UCSI_VERSION_2_0)
+		sink_path_enabled =
+			UCSI_CONSTAT(con, SINK_PATH_STATUS_V2_0) ==
+			UCSI_CONSTAT_SINK_PATH_ENABLED;
+
+	if (UCSI_CONSTAT(con, CONNECTED)) {
+		if (is_sink && sink_path_enabled)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (!is_sink)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+	}
+
+	return 0;
+}
+
 static int ucsi_psy_get_online(struct ucsi_connector *con,
 			       union power_supply_propval *val)
 {
@@ -245,6 +269,8 @@ static int ucsi_psy_get_prop(struct power_supply *psy,
 		return ucsi_psy_get_current_now(con, val);
 	case POWER_SUPPLY_PROP_SCOPE:
 		return ucsi_psy_get_scope(con, val);
+	case POWER_SUPPLY_PROP_STATUS:
+		return ucsi_psy_get_status(con, val);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index e301d9012936..cce93af7461b 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -360,6 +360,9 @@ struct ucsi_cable_property {
 #define   UCSI_CONSTAT_BC_SLOW_CHARGING		2
 #define   UCSI_CONSTAT_BC_TRICKLE_CHARGING	3
 #define UCSI_CONSTAT_PD_VERSION_V1_2		UCSI_DECLARE_BITFIELD_V1_2(70, 16)
+#define UCSI_CONSTAT_SINK_PATH_STATUS_V2_0	UCSI_DECLARE_BITFIELD_V2_0(87, 1)
+#define   UCSI_CONSTAT_SINK_PATH_DISABLED   0
+#define   UCSI_CONSTAT_SINK_PATH_ENABLED    1
 #define UCSI_CONSTAT_PWR_READING_READY_V2_1	UCSI_DECLARE_BITFIELD_V2_1(89, 1)
 #define UCSI_CONSTAT_CURRENT_SCALE_V2_1		UCSI_DECLARE_BITFIELD_V2_1(90, 3)
 #define UCSI_CONSTAT_PEAK_CURRENT_V2_1		UCSI_DECLARE_BITFIELD_V2_1(93, 16)
-- 
2.51.0.858.gf9c4a03a3a-goog


