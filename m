Return-Path: <linux-kernel+bounces-859624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80244BEE23D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 433494E8678
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B6F2E5B1B;
	Sun, 19 Oct 2025 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yhnf5gET"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108242E54DB
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760865860; cv=none; b=p5y/SYGsw+gErNygdkn0OG+roeJAQLdAWvL+qUCxi2brykSZTJ7iT7dLPFqrORdY8TvkrZJRXBPfJIca525fivHWo4L0KsObOazQ2o6QdPSs6fzteTK6z12n2f9nqKS9VNK4DaqrThRXMVHRu9LcVrPewubCWnR7+xDw/HQ1qkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760865860; c=relaxed/simple;
	bh=5k6B+2Gkv6ahAvoJ2QIVhv7UjXsFYpKGLwBlGkw92u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0uiY2tO5jW2jfcUAyemQAT0k3pADc2NknQ1djTEyKfVUXcLBFM0U9D4wGvjA+1G0devTeOv6d6FOLq0cF0wmjgGqLgtfpMxKgeZspyEPgulYaV5tvOK+xkCkWTRMBg07VU0gDtS8c0Z4PdLCzySj8qZmmRittavNDWGmUcw+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yhnf5gET; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6a7d3040efso584458a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 02:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760865858; x=1761470658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IEEUUortRsKDif5/C6NaVIjHsLkDuCc9ssKtrhB8jE=;
        b=Yhnf5gETs9DeuLHi2yhsC41gGNJ+BJPqH5ZpyRkgkDqzFQ30pKf5UklVGaa/jZhpkw
         GygOuJxCLk59JrtWsPYWhi5FtyBiGWdoVhmGq3dWIlxJRObbmYyoEv0WR175Xj6/78X8
         FyNvgnVDx5BafRPr/9QVXhNy/K1QNZxvGpVlUS6JVmagSA5O1tmC6arvS6OLP3U00EtL
         RtpPYoozn2HG3knFDSZrE06otWqK54OHW/zHBcskBSRFTI9EZlGcjuCHHXFsaf41QCj5
         P2r0KROiWp3VatAtcIfaeC2kD2MvDNEfmgiq/iAJcKBjRajx7qSBK3UxrhlSy7WT7CxR
         ETPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760865858; x=1761470658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IEEUUortRsKDif5/C6NaVIjHsLkDuCc9ssKtrhB8jE=;
        b=O1VvKFhfdN9icltJeYSw9vs+n9T2oWegK+vWw7ZYpOrDXPyoHoS36+Wg7hugA732uJ
         H4cYUoHWngbX1XwrIvnCLaM+Sj9M7R8HLa99mPQxB+zUMdsABleyYpcCDzbdDTFp4vmP
         U5g1khdBrxE7Mv7L/LZ7bTaD1vrE3fjCGnANPCRK0LStIHbJopowQsmJriewAIcZFPiu
         htex4oqvLDC/QIG97F7bl1z4tfm4pDFU7+qcOCTHrFpHMea47dqiszbWKdGJo3x4bhQc
         ui/MpLqIuxGueUJ4dAWumxpdGE/KTol85qDpXYzFhMJscvB9e6zbwLgszCL4TGdRsRjK
         EX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2X9n/l8Eoq1L4ESqaZvPoFdu8FCTCgY9u6m97IpH0i3zGiP6b/e7tz73vdSqzVUY6qTv1p258t1pfeJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtfSTOiVnizT/p+3/AZf93pM9s/f2koFGpG9BixpvLve2DOLms
	raYLuXh7lL5Cx0KPhFQXkW4NyDc//U7dkqCeATKWeTM9WDjrNKRDwWF0
X-Gm-Gg: ASbGncvJmee0wkk5h7coEX6oPKe/xZOB/wZPVswz9kf6PMSbSyddsafIbmd7LLkr+kN
	j3hBFGdweht1nVN0KPqWd0asUFIF/2ZhI2I1wbOynBJhR6adBiF2MueyBjV4S0HxDwpMBk5p/Z8
	SEKGxtMRU+osAZYO4iaZVkwN+mDJGAa3KTaUfmVAnJnU/QN+BPiS/WFmWkIdJ6ttuSVQ+xxemdU
	s2utO5uqYJWO+S4YjLVWhAw8Lim0+dfzxV+hsSV2wLcb3oGTk7CUVwVbsDUaMNKoOSYWXzk+2Tb
	0kcZuTLayL5m8gQ9S7Qlo9H2lavtnTYTFbDtkcFs+uUICrpKq4O/0Oekc28g8jidmzvTcPdj3kW
	t5fZyeWmGxy+xZP0WfL7g1LW0v5NER6VgzYHPPsDC12jpJdBXDCqf6FdPFSOxZQ3/Mob+fZ2ZQ1
	l2KkeNW7fz9s9I8lfCBxU=
X-Google-Smtp-Source: AGHT+IF47Bmb/eccmGhShDF9o/qoPWSD6ziSHadaCR4ZNVXketjm3fHbjuIdKH6MpF4Y3hOhFbsTEg==
X-Received: by 2002:a17:903:b0d:b0:269:b65a:cbb2 with SMTP id d9443c01a7336-290cb27eebcmr117044395ad.47.1760865858109;
        Sun, 19 Oct 2025 02:24:18 -0700 (PDT)
Received: from MRSPARKLE.localdomain ([206.83.99.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebd215sm48313115ad.14.2025.10.19.02.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 02:24:17 -0700 (PDT)
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
Subject: [PATCH v3 3/4] ABI: Add sysfs documentation for leds-group-virtualcolor
Date: Sun, 19 Oct 2025 22:23:26 +1300
Message-ID: <20251019092331.49531-4-professorjonny98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251019092331.49531-1-professorjonny98@gmail.com>
References: <20251019092331.49531-1-professorjonny98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Brophy <professor_jonny@hotmail.com>

Document the sysfs ABI for the Virtual Color LED Group Driver,
including brightness control, priority levels, per-color PWM control,
and monochromatic LED diagnostic attributes.

Co-developed-by: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Signed-off-by: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Signed-off-by: Jonathan Brophy <professor_jonny@hotmail.com>
---
 .../ABI/testing/sysfs-class-leds-virtualcolor | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-leds-virtualcolor

diff --git a/Documentation/ABI/testing/sysfs-class-leds-virtualcolor b/Documentation/ABI/testing/sysfs-class-leds-virtualcolor
new file mode 100644
index 000000000000..f9b455ca34c8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-leds-virtualcolor
@@ -0,0 +1,89 @@
+What:		/sys/class/leds/<led>/brightness
+Date:		October 2025
+KernelVersion:	6.13
+Contact:	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+Description:
+		Controls the overall brightness of the virtual LED. Setting to 0
+		deactivates the virtual LED and restores the next highest-priority
+		active LED. Setting to 1-255 activates the virtual LED and applies
+		brightness to all grouped LEDs (monochromatic and RGB).
+
+		Only the highest-priority active virtual LED is displayed at any
+		given time.
+
+		Range: 0-255 (or configured max-brightness)
+
+What:		/sys/class/leds/<led>/priority
+Date:		October 2025
+KernelVersion:	6.13
+Contact:	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+Description:
+		Sets the priority level for this virtual LED. Higher priority
+		values take precedence when multiple LEDs are active simultaneously.
+
+		When a higher-priority LED is activated:
+		- The current active LED (if lower priority) is turned off
+		- The higher-priority LED's state is applied
+		- When the higher-priority LED is deactivated, the previous LED
+		  is restored
+
+		Default: 0
+		Range: signed integer
+
+What:		/sys/class/leds/<led>/red_brightness
+Date:		October 2025
+KernelVersion:	6.13
+Contact:	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+Description:
+		Sets brightness of all red PWM LEDs in the virtual group. Only
+		affects LEDs configured under "pwm-leds-red" in device tree.
+
+		Range: 0-255
+
+What:		/sys/class/leds/<led>/green_brightness
+Date:		October 2025
+KernelVersion:	6.13
+Contact:	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+Description:
+		Sets brightness of all green PWM LEDs in the virtual group. Only
+		affects LEDs configured under "pwm-leds-green" in device tree.
+
+		Range: 0-255
+
+What:		/sys/class/leds/<led>/blue_brightness
+Date:		October 2025
+KernelVersion:	6.13
+Contact:	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+Description:
+		Sets brightness of all blue PWM LEDs in the virtual group. Only
+		affects LEDs configured under "pwm-leds-blue" in device tree.
+
+		Range: 0-255
+
+What:		/sys/class/leds/<led>/monochromatic_count
+Date:		October 2025
+KernelVersion:	6.13
+Contact:	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+Description:
+		Read-only. Shows the number of monochromatic LEDs in this virtual
+		LED group, as configured in device tree under the "leds" property.
+
+What:		/sys/class/leds/<led>/monochromatic_leds
+Date:		October 2025
+KernelVersion:	6.13
+Contact:	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+Description:
+		Read-only. Shows a comma-separated list of monochromatic LED device
+		names that are part of this virtual group. Returns "none" if no
+		monochromatic LEDs are configured.
+
+What:		/sys/class/leds/<led>/monochromatic_brightness
+Date:		October 2025
+KernelVersion:	6.13
+Contact:	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+Description:
+		Read-only. Shows the current brightness values of monochromatic LEDs
+		as a comma-separated list in the same order as monochromatic_leds.
+		Returns "none" if no monochromatic LEDs are configured.
+
+		Example output:
--
2.43.0

