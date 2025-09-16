Return-Path: <linux-kernel+bounces-818651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5C6B594AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 058194E2DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE07E2D12F3;
	Tue, 16 Sep 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2ZLNIF6"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E162D0629
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020565; cv=none; b=bGchDOi4dquQZ2HgdgOg2KEgEHffwRjr49Ra7fpBjnO4h5qN7RBI4Y0aB8W47E9AwBtVSHOMkLZSy1yMZ2Kg51Ts5gxaAzfrqR4hS9GnNDUeHjuaOJ4uPl0lSlKN9H4nel5MIjjLod8UJE7rlRg0cVjd9SbDILyy1/DSnZnjdcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020565; c=relaxed/simple;
	bh=4ugWzdLxwH7TW3xz+VsZ74Nu20vH+O8v7BzSqvng7pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2F63I6bOoo18U0e4Yabfyx/v6cV7JILHccLBVSobt3flom/xGB1MN+EwxXXB0DlIutNdDCwl1J2PTN52RRrCj0Izh5Nhfp+tyLgoT9GRGGmbfUNvd+chSAn8H+I10IrzlouWw1sO1aeOKzcAW+kK8YcS4eyAztActdDFHOX1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2ZLNIF6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445806df50so42461075ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758020563; x=1758625363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlc7jsJk6p6gKdRTeiAfm5hIuEV2gvb0B1/cOcqj4g8=;
        b=E2ZLNIF6Pvy13OBvsngXIj+rt+60xM/gjUW3PSD7bMpMxql6FBvQAIfjGiOCNy6arS
         /vWNqwsfOA1hzA7CSRhwv2HAbFt25CZMoonSbhEva7c4FtA/Tgtyd26AjSG3+gV7X1uH
         hnc0aei1+ZBJYslcVY3V1tcY/4OfUfFpMDI4/wIZ/4BDWsYr7WWVqgFFxGK5kvoibb/H
         H9OA2mDW1UCn53wppOf7U/epp0Uxe2y8eUIThHkeM7A6Kb5nkMJp6Clzt9GpbfG5Wf25
         Av785BNNoppLNv1QJreT5ta9Xde73m2ZRRtEmUXy1CfaXrTeYrj3bNGFM0CWtnDqzLDz
         ib3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020563; x=1758625363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlc7jsJk6p6gKdRTeiAfm5hIuEV2gvb0B1/cOcqj4g8=;
        b=WyOds5vvYcL5IHVCYdXVa8G23Oa7tsfVyTcjYrxYjrrdzV8Orwin0/ioYHYiicr9TM
         RWF/0OvjAdNkefyiAEjMRdDIpp4bBmjSKMB5HMEXHv5KUbvLpLpe5ulEiJ/SEJ/Iev/Y
         EPR2QygisUfg++0S1vpRj9l48/eRxrAQrFx2+GZkLCUnV/X4vllusME0IVIQVOwDv+9i
         Ne8LzO0c95oIdVla4RAKmeCfVkQj1R0XQKU38ykDPJVz+7Re79cnWXJW/psDJZY7g6Xp
         1B1tp41GxE/JcfBX+2PwmaFtgbP/Ihdx94g7Feu5/0O0fR/J1vsO86k2E1uUk0FAfNjj
         RNkA==
X-Forwarded-Encrypted: i=1; AJvYcCVSsYO3t8rskGLLcQZi+U3+QK7WsUyEkD790zIBdRMZkQhsvoqav2IIT9hLl935NQieRI5SZJOkQzMg3/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhwVEgPOpmQY832PRCeZalvrXVSgJCvR5GRoGvGdhvWTI9cq46
	ynaevY5X3MHrAnbzAfeFiHsIq7xzl3D7nACTK3M/g6b51qR1CJ8TKLFB
X-Gm-Gg: ASbGncsz0Qv4RJTpHwEPLXAR3Y37xPjjkDPnZmtSLpycclwVTGHpsqPkYIr8u9kpo/5
	sOY2N5MLgTTolj9O6GSfM9sSrvbYjpCMH0j5nawL9L21Q2JNeQ1YQEH6NuilIachGT3XHS+NaC0
	HpW9s5jwkJOSJRb5+fHBYrcxYqCDTwt5N7SdFPuaIE2J40dtINxG1KbZbR5nf009m8hF4fbi1k8
	pax2cmsI4bdb/2iyEyhc4FXG1fRBwmz3/vlZxiYf2iOQ56SPBB6e+nHEZPQotcWRoEqYc68SrL8
	lb36V+TSOGmBkLuWAuOPZy0T+L0bBUrBiAN1Dmy13CAMZA4GYaVjHkSIGProEwnruzXIORxZxyr
	5ubQWauJebpWwdmSne5MfIt8GSkLRnz96NLIx6Tc0g3mf
X-Google-Smtp-Source: AGHT+IH64sLUcDgQBMHjtimcEQQJfjOUS+/VsmBxNDcrcn0Ck9ACmp62pRLDSs+pn4IEA+FDfafriA==
X-Received: by 2002:a17:902:f546:b0:267:bdcf:9346 with SMTP id d9443c01a7336-267bdcf99ddmr39744695ad.27.1758020562681;
        Tue, 16 Sep 2025 04:02:42 -0700 (PDT)
Received: from MRSPARKLE.localdomain ([206.83.103.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304ce8sm158761725ad.128.2025.09.16.04.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:02:42 -0700 (PDT)
From: Jonathan Brophy <professorjonny98@gmail.com>
To: lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jonathan Brophy <professor_jonny@hotmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH 4/5] ABI: sysfs-class-leds-virtualcolor: Document sysfs entries for Virtual Color LEDs
Date: Tue, 16 Sep 2025 23:02:16 +1200
Message-ID: <20250916110217.45894-4-professorjonny98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916110217.45894-1-professorjonny98@gmail.com>
References: <20250916110217.45894-1-professorjonny98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Brophy <professor_jonny@hotmail.com>

Add sysfs-class-leds-virtualcolor to document Virtual Color drover sysfs
entries

Co-developed-by: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Signed-off-by: Jonathan Brophy <professor_jonny@hotmail.com>
---
 .../ABI/sysfs-class-leds-virtualcolor         | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/ABI/sysfs-class-leds-virtualcolor

diff --git a/Documentation/ABI/sysfs-class-leds-virtualcolor b/Documentation/ABI/sysfs-class-leds-virtualcolor
new file mode 100644
index 000000000..60b878791
--- /dev/null
+++ b/Documentation/ABI/sysfs-class-leds-virtualcolor
@@ -0,0 +1,43 @@
+What:		/sys/class/leds/<led>/priority
+Date:		August 2025
+Contact:	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+Description:	(RW) Priority level of the virtual LED group. Higher numbers
+        indicate higher priority. When multiple virtual LED groups are
+        active, only the highest priority group's state will be applied
+        to the physical LEDs.
+
+        Valid values: 0 to INT_MAX
+        Default: 0
+
+What:		/sys/class/leds/<led>/blink_delay_on
+Date:		August 2025
+Contact:	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+Description:	(RW) The time in milliseconds that the LED should be on while
+        blinking. Setting both blink_delay_on and blink_delay_off to
+        zero disables blinking.
+
+        Valid values: 0 to ULONG_MAX
+        Default: 0
+
+What:		/sys/class/leds/<led>/blink_delay_off
+Date:		August 2025
+Contact:	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+Description:	(RW) The time in milliseconds that the LED should be off while
+        blinking. Setting both blink_delay_on and blink_delay_off to
+        zero disables blinking.
+
+        Valid values: 0 to ULONG_MAX
+        Default: 0
+
+What:		/sys/class/leds/<led>/brightness
+Date:		August 2025
+Contact:	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+Description:	(RW) Brightness value for the virtual LED group. This value is
+        applied to all monochromatic LEDs in the group if this group
+        has the highest priority among active groups.
+
+        When read-only mode is enabled via device tree, writes to this
+        attribute will return -EPERM.
+
+        Valid values: 0 to LED_FULL (usually 255)
+        Default: LED_OFF (0)
\ No newline at end of file
-- 
2.43.0


