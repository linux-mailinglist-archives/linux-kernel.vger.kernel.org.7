Return-Path: <linux-kernel+bounces-774570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD75BB2B456
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD111894799
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7612765CD;
	Mon, 18 Aug 2025 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H6pnQoVB"
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363BC25A333
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558636; cv=none; b=SCQC+zE24HZWfWRTrsxyqqZScwk8N8FWK7DXAfkdYMis1CqSlPv/soTX3IjkEU16MVna1fGrpByOoR2FZtjO/emj1BIpmUoOxZRqJ/RF9tHCYoWIs87pC3SYi3+K51ZrAtFj/FWTRHScIpw3t2VJGRWACIGz+lSPLba1CgAsFWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558636; c=relaxed/simple;
	bh=fmhEJJJB/E1FFPI5LjG9ozybSomAbkYBLER6Pk9jyms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bHJRBBgMoqH9Hl0/TkFV8alIq6uDKKjjmJOxYxWvkfim8dtcp60Uqr9wy3gRLxKA+M/IuDkIbOxQ/VcJAmrxwF1QWdWIYDiIIATAb9poNk9M/tzRy1GVPm6gSiS1Dc8/OX4+fvmuRFcmNB0e1USjOBT09D+WJsdtE3VVnmxxNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H6pnQoVB; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3e580be9806so36300635ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755558634; x=1756163434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0QevRU85Pi+9axz8eFxpRKcQRe8ukOlLHQx9hBgz38=;
        b=H6pnQoVBSjnxDHOw8nUX5IrGcTb67khWH+mXN0py21h+cRLyrLx//f4BOCbEj00O5g
         7tHDfWumzYoT6SYRxw75nATdGvB5jnY/2YR9UY4ofnYDcdkzeXwrDEOJX7KXCFQps+Ds
         9GkTxwcDlwdNFQSZaRjFL+FYaO9sTq133m3KmgOolIjCqFmFTdKGUsjK1D+6VKz1FjSA
         UELLJNDzOd3Jf2Wp3y9H5prYCVNHlIC8v8C9iXfvoI8i0Iaa8nCvZlGs1IDR57ommzpn
         KTyD+2Dot2X1GZr0K78chufYGyigTTOGekN8qYMXmI0NwBpMm8gvufYXsxkL7PAeomfo
         Y+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755558634; x=1756163434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0QevRU85Pi+9axz8eFxpRKcQRe8ukOlLHQx9hBgz38=;
        b=KbZTi5qgHe0asRxgpsEYuOlHQUIxE5vm2VY4mS3j1Mum+HOxSQpijIdqspc/akJRpp
         2Bgj1czQAaUNZeaDEo9HpfMN3r+tD1fdNWbt9ky4L4J8NIz0Wfulg94TxrEm2vHSfY5E
         hXy/vF+5X4q39pF+RTeNu7pXyeoZ0Ds3+B6J/RiSUEjt6KXwZEhb4xXF4R44bojQnz8N
         /nJIcfLLP3ddreRihp0JUhVwywGXfyChtgleUWoIs1CfjYua/cTLYNITp08pk3wy+9Z4
         FFjdDNhLnDMtG3kun1+rKkEEQwWqPd/omVInHeZIeonC5nE5Tp/Y+BoQy1wpaTX2e1X+
         7t6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkbDL3VgQ3vz6YcXXmUuzrF4TrhAc7+fnZzVA1zE3qYkUU47N1ck51ZbjRvRdV25i2k3C57eNE0XxS+2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOiiS6Tn7k5tTeIxjtgvCnQGh7V4NnonrH2skL2ylvF0cwA3y
	5vcM65fCEF4FiDGBLahmM2IRLj526/4uKlma5b4Rjctpjv4zvsBk4ojkGWMxVY39VVng9aaCeZv
	OWVEkgD5PoQ==
X-Google-Smtp-Source: AGHT+IFCfiADlQxcsJnYSe59mlfocD3gP94iu57cJNx0vOjYhVOrRJWHhrHJK//rZTjPILcmNtM8bbwrPkcR
X-Received: from jabc24.prod.google.com ([2002:a05:6638:c218:b0:50a:68a6:1578])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:1a26:b0:3e3:cc1b:2b5e
 with SMTP id e9e14a558f8ab-3e676627764mr9826585ab.15.1755558634367; Mon, 18
 Aug 2025 16:10:34 -0700 (PDT)
Date: Mon, 18 Aug 2025 23:08:42 +0000
In-Reply-To: <20250818-support-forcepads-v3-0-e4f9ab0add84@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818-support-forcepads-v3-0-e4f9ab0add84@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250818-support-forcepads-v3-1-e4f9ab0add84@google.com>
Subject: [PATCH v3 01/11] HID: add haptics page defines
From: Jonathan Denose <jdenose@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	"Sean O'Brien" <seobrien@google.com>, Jonathan Denose <jdenose@google.com>
Content-Type: text/plain; charset="utf-8"

From: Angela Czubak <aczubak@google.com>

Introduce haptic usages as defined in HID Usage Tables specification.
Add HID units for newton and gram.

Signed-off-by: Angela Czubak <aczubak@google.com>
Co-developed-by: Jonathan Denose <jdenose@google.com>
Signed-off-by: Jonathan Denose <jdenose@google.com>
---
 include/linux/hid.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 568a9d8c749bc5547ff78d5abe6db7bce2f62d2b..344ab0e40f29afe55575e5a7544496b7bb48a266 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -156,6 +156,7 @@ struct hid_item {
 #define HID_UP_TELEPHONY	0x000b0000
 #define HID_UP_CONSUMER		0x000c0000
 #define HID_UP_DIGITIZER	0x000d0000
+#define HID_UP_HAPTIC		0x000e0000
 #define HID_UP_PID		0x000f0000
 #define HID_UP_BATTERY		0x00850000
 #define HID_UP_CAMERA		0x00900000
@@ -316,6 +317,28 @@ struct hid_item {
 #define HID_DG_TOOLSERIALNUMBER	0x000d005b
 #define HID_DG_LATENCYMODE	0x000d0060
 
+#define HID_HP_SIMPLECONTROLLER	0x000e0001
+#define HID_HP_WAVEFORMLIST	0x000e0010
+#define HID_HP_DURATIONLIST	0x000e0011
+#define HID_HP_AUTOTRIGGER	0x000e0020
+#define HID_HP_MANUALTRIGGER	0x000e0021
+#define HID_HP_AUTOTRIGGERASSOCIATEDCONTROL 0x000e0022
+#define HID_HP_INTENSITY	0x000e0023
+#define HID_HP_REPEATCOUNT	0x000e0024
+#define HID_HP_RETRIGGERPERIOD	0x000e0025
+#define HID_HP_WAVEFORMVENDORPAGE	0x000e0026
+#define HID_HP_WAVEFORMVENDORID	0x000e0027
+#define HID_HP_WAVEFORMCUTOFFTIME	0x000e0028
+#define HID_HP_WAVEFORMNONE	0x000e1001
+#define HID_HP_WAVEFORMSTOP	0x000e1002
+#define HID_HP_WAVEFORMCLICK	0x000e1003
+#define HID_HP_WAVEFORMBUZZCONTINUOUS	0x000e1004
+#define HID_HP_WAVEFORMRUMBLECONTINUOUS	0x000e1005
+#define HID_HP_WAVEFORMPRESS	0x000e1006
+#define HID_HP_WAVEFORMRELEASE	0x000e1007
+#define HID_HP_VENDORWAVEFORMMIN	0x000e2001
+#define HID_HP_VENDORWAVEFORMMAX	0x000e2fff
+
 #define HID_BAT_ABSOLUTESTATEOFCHARGE	0x00850065
 #define HID_BAT_CHARGING		0x00850044
 
@@ -423,6 +446,12 @@ struct hid_item {
 #define HID_REPORT_PROTOCOL	1
 #define HID_BOOT_PROTOCOL	0
 
+/*
+ * HID units
+ */
+#define HID_UNIT_GRAM		0x0101
+#define HID_UNIT_NEWTON		0xe111
+
 /*
  * This is the global environment of the parser. This information is
  * persistent for main-items. The global environment can be saved and

-- 
2.51.0.rc1.193.gad69d77794-goog


