Return-Path: <linux-kernel+bounces-755287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0019B1A423
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD17716DB40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1DD2701C7;
	Mon,  4 Aug 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGbbrE5u"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A9526FA67
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316682; cv=none; b=Mk4Bb7w3Pk6lZxIi8803SoeaOPFY+1LGab65qpTOYN3lCD7s5JXjFVMosbqKRGqVTVNw5SjDrk7c5WkhBpgcpGSZrULMY5Oi6qzAlMdnzX/1V4bpys6T82OIbb/AQMhHX6O0onMWzv2B4v6TOvbpiXBXRlR3+ZhiIY2ubI0cuf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316682; c=relaxed/simple;
	bh=wD7KH2nul7xWSFaFztu+JHvu62EHoaiPuiZ2VbswsXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oU0V7AyW7eAigH/n5l/rPtGFOTn3Oh78/s7NW+EDyiqU4V/pVOGPW8P/pM5G2HZEnKKkTMpl0G8g60WJkLTuYOuS8DcTMm64aQWxqoTtnwgMhOjR11/90bhSTsD4bs8chq5ayHNMArs+jQpdUZxqWtpwKkh49nMYqW2zt7qZ40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGbbrE5u; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-88163258c33so573414739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754316680; x=1754921480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nuKq8QjQJ5E3pwFU8vQVEGwZ2XyLx0FOu2w9SY7fuwY=;
        b=wGbbrE5u0L6vY3yKUtsgUVTk2CO2QGeOfVbJdtQ7ZdSWQfjOww3Z233O/KE1+5MKMO
         o1Uljxm+Gw216g4teq7ve+xhlQKB1PKWtepWEKy08DeyTXanY0jvLci9XDytsrZUsrU8
         gEmylG95EUlDH07eLjfoxBu+cyp2o68LG0KFKZsrJT0sJSus+YhXoHYUcDE/xsUsJBsH
         R9GEykujNmyGN6NxIB0x0JrbqfbVsYwnfEkwDgKx5ceZhgTCyhXc1TNsTAG7DdCH5b1Z
         PKoil1C16BCoPRxD9MCHlrd1FpRf6690sVjWe5F8XMi5vCv1XpZWl0hYrojY5eWRcMSO
         Rscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754316680; x=1754921480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuKq8QjQJ5E3pwFU8vQVEGwZ2XyLx0FOu2w9SY7fuwY=;
        b=hPl2oFUB+9qwRu9HEnRaAHNr0Pn4pSF6Nv3ParQ1fcfB2Q65vFpTxUkjE0Wi/UFaaQ
         QJpOyRbTXbU9/RQCAg78ON7Cbemz3O8LyMVooBm14meE1h28CFlCJDDWFQbshzdpDjkT
         S41GB+L0It04urE9rwdkpXMftLehco9fKvQpNPD8NafvmF+GkrQfjklQj0bgevhL2E0n
         nrLnJPHQyZ/XR9KSQnnP719/qbOw68LnkxNUCrWin/W5XIAl85/znPk24tVYslSN1N68
         uYC9hk0eBno021UlMq10p0JTHwqeun15wcy+H6uX8qa4WGAsYmbDOAlbQ+p5i2TJWqTA
         OngQ==
X-Forwarded-Encrypted: i=1; AJvYcCUODa5uHvP3j1x6fhFHaV8+oS8cinxIO4KtfR0hksK5xd6kE9PUWBG+vb0BT8jYxVILveCudnKzQAzIi0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YymUGaowRGS0VqbDnzVopoMTu4UHPMQsJC+JUHMc5AEF/Y4zZLI
	VJATzQI4XeFwOMjD7lnDQLWKL2re+c7VWe2gVzHO0GB7yBcdhA2CA5VjgowUfVww6tcAz8uC8aA
	EOWjQ81cZPw==
X-Google-Smtp-Source: AGHT+IHqRipYLC3AElMPz+s9p6pNzZ5o6ocGxk8AyELudHcmR9kBNMUK6KIuj/qjmZElU5urf4KNvsxsch+6
X-Received: from iobbf13.prod.google.com ([2002:a05:6602:368d:b0:881:7968:8236])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:6b81:b0:87c:34e3:1790
 with SMTP id ca18e2360f4ac-88168313db5mr1501133939f.1.1754316679742; Mon, 04
 Aug 2025 07:11:19 -0700 (PDT)
Date: Mon, 04 Aug 2025 14:11:16 +0000
In-Reply-To: <20250804-support-forcepads-v2-0-138ca980261d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250804-support-forcepads-v2-0-138ca980261d@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250804-support-forcepads-v2-1-138ca980261d@google.com>
Subject: [PATCH v2 01/11] HID: add haptics page defines
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
2.50.1.565.gc32cd1483b-goog


