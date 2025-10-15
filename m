Return-Path: <linux-kernel+bounces-853736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A8BDC77B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E16C3AAD53
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614B2FDC5A;
	Wed, 15 Oct 2025 04:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4IiFi3m"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF321EFF93
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760502624; cv=none; b=juyDzZ5gkkm3ft58emIZE6rve7goswj3Psa0fnItS4V1gYmIk8NiYSxiMhvi9m+TUA71k+BEJRIR1/Zt1I3WEPyPBQFupNvpyUsEN3pq60401b/ZLMKMC7TSDaa0JD08UXIk2CnkvOdGkfyJkg7HGQYSftsE3pZ5yvTJJ7KJlII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760502624; c=relaxed/simple;
	bh=gEHbLD9RPEttonCCo/mmfEfjmcBJVFJ7LQpeOyHdH/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m2At5GnRmgUKqIUh26ODiG8uHvxN0LaSNuvwsGNgH/ya1D6QLMU0WThwixrUEYuqrQg/MKxRUnkJrr75Ezo3r89Ezom7pq10LUjF2DaMdJHYvI0jR8dn5vBCU5qd4NL1ZakmMbVFVUzte8FCmCddWZXRUmwB84iROLh/+1u7uwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4IiFi3m; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78427dae77eso8759899b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760502622; x=1761107422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmMvyh4fnjqHp1OFP+Q2QSeAQcQ5ugB+WtQrIGr0TMs=;
        b=A4IiFi3mTJfm+RXnHeddo13R3xH1k94dySr06+lTpc6cdSDCHwHDqyg7q9aN0uLS4P
         DviKAAEFxIlr7Is1CDkgM+0qeumw0MRz5a6qAGc/J+QcHO63kjFkomZYoIqEmc3OvbS+
         xdo3IHVOmJBGuqRKz3lMJitXWXTqZ8IwezFLDKRyusyzTI0SkObkM5Xge6TwT5A4tutu
         gofklWw05fz1ChJQv4h6yFp5ONIn8HnnezcOynzQHTQZ0FgvYjlE9MW/7wnO6lmm83UI
         70NY/3D4OZyzf7wdyqGTD1wfGCAgvyThSAT92BER9bMUMbuB9pK2LpiSUxsQudz6aQ/w
         L/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760502622; x=1761107422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmMvyh4fnjqHp1OFP+Q2QSeAQcQ5ugB+WtQrIGr0TMs=;
        b=Kuj5r8C0SyEkSh7BVYJRB2zadTS6nIpPYZYoKLch5RYm4LBPWmf/xKHGV25rirGcUZ
         WunEUq5h+W/xqUQbiFr37aO0mzIAuAIn2KAIAl4Nyj5z4B8lVCrBEzYGF90CDJ67c3zm
         E5k5qGNYmYbQWoV+xl/Wc40W3W3PR3Ypm0kOYoYxLGqaQndHI0Gs3Srtu+2dtd6owypw
         vlH8RfA1Gab8qE27cxi5ieG7qKa7EOupy1nEIXD3SS8dG0/SvXmITe22uabXvY9IFrOA
         lcjPqh1vFymFRUC1sFLZCKJL4bZzkvJJN12K1e6lNG4VgygCwdFZXmdNHqSt7UuzM4zr
         hldQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg92Jn6g5IyGmt20wvsieQ5BRyZnFK7LoFs3JMNs/dBc7HFDAodKFZ/npibGK6PEH99zw4WZ7fm61CMV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfXgNusk683NO2RzNVC4NfCLJytav4Fdt/qCFPX7GQfjjK17t/
	u8ARru1/E4aO4uyyduXMyymhYb+nnwYk/JNmLJQ8RmqNSiSyQrrfJ9zu735d7s6cqVBwpGZowil
	jMepDkw==
X-Google-Smtp-Source: AGHT+IGtc+RtpcrlelQatgq+N00chyu11KcMvbeDlEMEu4MMR5+ezW9iNtj5AD52An2umJnvqFkpeD5muug=
X-Received: from pgbcs5.prod.google.com ([2002:a05:6a02:4185:b0:b55:734:6b47])
 (user=badhri job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca1:b0:262:9461:2e5b
 with SMTP id adf61e73a8af0-32da8463095mr32673308637.53.1760502621897; Tue, 14
 Oct 2025 21:30:21 -0700 (PDT)
Date: Wed, 15 Oct 2025 04:30:14 +0000
In-Reply-To: <20251015043017.3382908-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015043017.3382908-1-badhri@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251015043017.3382908-2-badhri@google.com>
Subject: [PATCH v2 2/2] usb: typec: pd: Register SPR AVS caps with
 usb_power_delivery class
From: Badhri Jagan Sridharan <badhri@google.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	badhri@google.com
Cc: amitsd@google.com, kyletso@google.com, rdbabiera@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

usb_power_delivery class will now display AVS cap as
`spr_adjustable_voltage_supply`. `maximum_current_9V_to_15V` and
`maximum_current_15V_to_20V` shows the corresponding current limits
in mA. `peak_current` follows the same convention as fixed_supply
where the value reported in the capabilities message is displayed
as is.

Sample output with an SPR AVS capable PD charger:
$cat /sys/class/usb_power_delivery/pd1/source-capabilities/5:spr_adjustable_voltage_supply/maximum_current_9V_to_15V
4000mA

$cat /sys/class/usb_power_delivery/pd1/source-capabilities/5:spr_adjustable_voltage_supply/maximum_current_15V_to_20V
3350mA

$cat /sys/class/usb_power_delivery/pd1/source-capabilities/5:spr_adjustable_voltage_supply/peak_current
0

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since V1:
* Fixed incorrect squash
---
 .../testing/sysfs-class-usb_power_delivery    | 28 ++++++
 drivers/usb/typec/pd.c                        | 95 ++++++++++++++++++-
 2 files changed, 118 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-usb_power_delivery b/Documentation/ABI/testing/sysfs-class-usb_power_delivery
index 61d233c320ea..c754458a527e 100644
--- a/Documentation/ABI/testing/sysfs-class-usb_power_delivery
+++ b/Documentation/ABI/testing/sysfs-class-usb_power_delivery
@@ -254,3 +254,31 @@ Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 Description:
 		The PPS Power Limited bit indicates whether or not the source
 		supply will exceed the rated output power if requested.
+
+Standard Power Range (SPR) Adjustable Voltage Supplies
+
+What:		/sys/class/usb_power_delivery/.../<capability>/<position>:spr_adjustable_voltage_supply
+Date:		Oct 2025
+Contact:	Badhri Jagan Sridharan <badhri@google.com>
+Description:
+		Adjustable Voltage Supply (AVS) Augmented PDO (APDO).
+
+What:		/sys/class/usb_power_delivery/.../<capability>/<position>:spr_adjustable_voltage_supply/maximum_current_9V_to_15V
+Date:		Oct 2025
+Contact:	Badhri Jagan Sridharan <badhri@google.com>
+Description:
+		Maximum Current for 9V to 15V range in milliamperes.
+
+What:		/sys/class/usb_power_delivery/.../<capability>/<position>:spr_adjustable_voltage_supply/maximum_current_15V_to_20V
+Date:		Oct 2025
+Contact:	Badhri Jagan Sridharan <badhri@google.com>
+Description:
+		Maximum Current for greater than 15V till 20V range in
+		milliamperes.
+
+What:		/sys/class/usb_power_delivery/.../<capability>/<position>:spr_adjustable_voltage_supply/peak_current
+Date:		Oct 2025
+Contact:	Badhri Jagan Sridharan <badhri@google.com>
+Description:
+		This file shows the value of the Adjustable Voltage Supply Peak Current
+		Capability field.
diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
index d78c04a421bc..67f20b5ffdf4 100644
--- a/drivers/usb/typec/pd.c
+++ b/drivers/usb/typec/pd.c
@@ -359,6 +359,84 @@ static const struct device_type sink_pps_type = {
 	.groups = sink_pps_groups,
 };
 
+/* -------------------------------------------------------------------------- */
+/* Standard Power Range (SPR) Adjustable Voltage Supply (AVS) */
+
+static ssize_t
+spr_avs_9v_to_15v_max_current_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%umA\n",
+			  pdo_spr_avs_apdo_9v_to_15v_max_current_ma(to_pdo(dev)->pdo));
+}
+
+static ssize_t
+spr_avs_15v_to_20v_max_current_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%umA\n",
+			  pdo_spr_avs_apdo_15v_to_20v_max_current_ma(to_pdo(dev)->pdo));
+}
+
+static ssize_t
+spr_avs_src_peak_current_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n",
+			  pdo_spr_avs_apdo_src_peak_current(to_pdo(dev)->pdo));
+}
+
+static struct device_attribute spr_avs_9v_to_15v_max_current_attr = {
+	.attr = {
+		.name = "maximum_current_9V_to_15V",
+		.mode = 0444,
+	},
+	.show = spr_avs_9v_to_15v_max_current_show,
+};
+
+static struct device_attribute spr_avs_15v_to_20v_max_current_attr = {
+	.attr = {
+		.name = "maximum_current_15V_to_20V",
+		.mode = 0444,
+	},
+	.show = spr_avs_15v_to_20v_max_current_show,
+};
+
+static struct device_attribute spr_avs_src_peak_current_attr = {
+	.attr = {
+		.name = "peak_current",
+		.mode = 0444,
+	},
+	.show = spr_avs_src_peak_current_show,
+};
+
+static struct attribute *source_spr_avs_attrs[] = {
+	&spr_avs_9v_to_15v_max_current_attr.attr,
+	&spr_avs_15v_to_20v_max_current_attr.attr,
+	&spr_avs_src_peak_current_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(source_spr_avs);
+
+static const struct device_type source_spr_avs_type = {
+	.name = "pdo",
+	.release = pdo_release,
+	.groups = source_spr_avs_groups,
+};
+
+static struct attribute *sink_spr_avs_attrs[] = {
+	&spr_avs_9v_to_15v_max_current_attr.attr,
+	&spr_avs_15v_to_20v_max_current_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(sink_spr_avs);
+
+static const struct device_type sink_spr_avs_type = {
+	.name = "pdo",
+	.release = pdo_release,
+	.groups = sink_spr_avs_groups,
+};
+
 /* -------------------------------------------------------------------------- */
 
 static const char * const supply_name[] = {
@@ -368,7 +446,8 @@ static const char * const supply_name[] = {
 };
 
 static const char * const apdo_supply_name[] = {
-	[APDO_TYPE_PPS]  = "programmable_supply",
+	[APDO_TYPE_PPS]      = "programmable_supply",
+	[APDO_TYPE_SPR_AVS]  = "spr_adjustable_voltage_supply",
 };
 
 static const struct device_type *source_type[] = {
@@ -378,7 +457,8 @@ static const struct device_type *source_type[] = {
 };
 
 static const struct device_type *source_apdo_type[] = {
-	[APDO_TYPE_PPS]  = &source_pps_type,
+	[APDO_TYPE_PPS]     = &source_pps_type,
+	[APDO_TYPE_SPR_AVS] = &source_spr_avs_type,
 };
 
 static const struct device_type *sink_type[] = {
@@ -388,7 +468,8 @@ static const struct device_type *sink_type[] = {
 };
 
 static const struct device_type *sink_apdo_type[] = {
-	[APDO_TYPE_PPS]  = &sink_pps_type,
+	[APDO_TYPE_PPS]     = &sink_pps_type,
+	[APDO_TYPE_SPR_AVS] = &sink_spr_avs_type,
 };
 
 /* REVISIT: Export when EPR_*_Capabilities need to be supported. */
@@ -407,8 +488,12 @@ static int add_pdo(struct usb_power_delivery_capabilities *cap, u32 pdo, int pos
 	p->object_position = position;
 
 	if (pdo_type(pdo) == PDO_TYPE_APDO) {
-		/* FIXME: Only PPS supported for now! Skipping others. */
-		if (pdo_apdo_type(pdo) > APDO_TYPE_PPS) {
+		/*
+		 * FIXME: Only PPS, SPR_AVS supported for now!
+		 * Skipping others.
+		 */
+		if (pdo_apdo_type(pdo) != APDO_TYPE_PPS &&
+		    pdo_apdo_type(pdo) != APDO_TYPE_SPR_AVS) {
 			dev_warn(&cap->dev, "Unknown APDO type. PDO 0x%08x\n", pdo);
 			kfree(p);
 			return 0;
-- 
2.51.0.858.gf9c4a03a3a-goog


