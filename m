Return-Path: <linux-kernel+bounces-814201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F0EB550B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102783BC5B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D49313E21;
	Fri, 12 Sep 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rphKZ3ja"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F5C313525
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686489; cv=none; b=SNX8b+Djzx3e5hMHqSji3HwYAhpuh5ALSQj+CT5NbpwTmKQfOTndwK+DV57W8OQlv8IDQOTVIA6dOIwyz3ojQ+a7RB2JYRTiotZMYH297WfjEEzd3POZESbBnfJGPLisNt2eVw+ciY4qPquguySgXFK4xY5jj1IVrwgSA+UYFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686489; c=relaxed/simple;
	bh=Sx4qNTflZvWx6Pe1Zu0lV/BCv5K0fKMX8u+tZdVvrdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCzKES7QM5TeWGkZBVk2eTVE8yPP2r8SG+WPDSMlV4+Or41i6Rsad3cat39LoniBm/EvvSBVR/0aogTG5Sj662F/0LUcdweko3HBDb9e2QR3g9qj43TNGjXWGRchvuAXHJwlWQq3aAfQFX5TbFAbOpossivNt/lldqLCuXdEqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rphKZ3ja; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so1439838f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686486; x=1758291286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYYU1SORSnF86QOoLhacy3DzKZyj7/fWijxhLZdd8eA=;
        b=rphKZ3ja+FJcO2sswf6k2cMb+CwbbITompdmCIpYyd7AbNYQcv6BiBZeHWcGENojSI
         4n9EvZfvNhg9pQmzwr8+iqk25LgJMsuNTMpA+EU8dAnHc7mwKsoCAtEtqS1bb7S2KXZq
         WnEAG1+mvgvTQTVdUmasBFc159aYp084T/vBihByvM7LGNxNwXrMHezQogNAzWtSTcZm
         PO+XmNzc+uzdGsR+9/Yr6tUTUn+R2sQJbdF25x0J2aHkSiq0QROY+tOUGmeAWI3KHC67
         RSatsQSeXAq7gpwwihIMI+WUwGbO6thac80jFIvI4EsuDMsZjs/55Ijm5LArmIkFKWKj
         E1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686486; x=1758291286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYYU1SORSnF86QOoLhacy3DzKZyj7/fWijxhLZdd8eA=;
        b=R4+7oPErWtlyfR3jnvx3I1grqcBII5cJT69slcBRZdoRGterUUywNLYi5+4YBGRUTq
         ADRz1EtXzLqKW/D7JOrvuZqzw2qyWApx7ePfQfURSxPeugcCVRHm/MhSotZhXUC0tjr6
         BJU0GWcA9ACWVWYgJYpqqZtZqip5cokhupHg5rvHvvHuB9WNGOeoTMsDsS1fW8zEAAPQ
         d45lkDdLYcOY0TPQPNp2UCpRwpgRSzcrAukufHplEGfIbdT6Ptsl+bdJLgAkbPwh+svP
         VIA1TRPhAz+QcCglKrPkLJetWJezhDtCLBaVCsIKwxbYZtrG3KU0GrzQUJO7ZhCYIvSZ
         rppg==
X-Forwarded-Encrypted: i=1; AJvYcCUTDZbclobOVM7rVwVJxHfpE1ZQeou92En/rPMZdApEo7yg7KGWe2Rr/pYqsubw1NA4BQ2ktF1G9HekVSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwktLKG3C8eeOKi3tKqsdYX+Sg4WxziIVwhfY6+IptQA8sV1Jry
	3JvjTgx15iBKBn/Z4jpIY7/sSDgntThyMqaKxm3+gAGMqWJKVkiAaavzcumaPwmIGMw=
X-Gm-Gg: ASbGncvnvrt0QUtaJAvl+/Y8LqmLoRXhpML/qqGe2FBRoq44xYUiEQ3NPyL87CE2tB6
	IajKNOnlxOnyurZtPQug9zNLmfdPL15/FlVfLcHxyzHqzzKLB9LPFrsqvsMNAFh6qPUmCRq5Vsj
	EI6rInQht7UAaT0U0aFK/0ILwhpIA1iPnw0bx7b5Rd5Lm8AqXrNNCCF2d2D02CTrimBpi+q2k/f
	gsOSGzH4yEqk5rzK7Nw78b2V7JHaejCVCkDU/Jisrma8k5LeXqbrUDu1aW+Ly8D0GOuRkXuFqcO
	5i7v5E2kTkX1bGfsnjcZbJmI5vcGmsy37+FYzwU8YyMxczmPpbaS/P/hD+RzlhVMrcvOFE1fCZC
	tiUAs8RVy3LI8Kcc9PbzbPbwvpmB56fI=
X-Google-Smtp-Source: AGHT+IELwPDPxYCpFOkmaAqs6QS4n+6xPwFX8EClQCkLmWQOaqKB/UsohwY3InyXz3cWYcEWRVaTyg==
X-Received: by 2002:a05:6000:178c:b0:3de:78c8:120c with SMTP id ffacd0b85a97d-3e765a139bdmr2764778f8f.38.1757686485677;
        Fri, 12 Sep 2025 07:14:45 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:40ce:250c:1a13:d1ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm6680739f8f.30.2025.09.12.07.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:14:44 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver
Date: Fri, 12 Sep 2025 16:14:36 +0200
Message-ID: <20250912141436.2347852-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912141436.2347852-1-vincent.guittot@linaro.org>
References: <20250912141436.2347852-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the s32g PCIe driver under the ARM/NXP S32G ARCHITECTURE entry.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d32..e93ab4202232 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3086,10 +3086,13 @@ R:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
 R:	NXP S32 Linux Team <s32@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
 F:	Documentation/devicetree/bindings/rtc/nxp,s32g-rtc.yaml
 F:	arch/arm64/boot/dts/freescale/s32g*.dts*
+F:	drivers/pci/controller/dwc/pci-s32g*
 F:	drivers/pinctrl/nxp/
 F:	drivers/rtc/rtc-s32g.c
+F:	include/linux/pcie/nxp-s32g-pcie-phy-submode.h
 
 ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
 M:	Jan Petrous <jan.petrous@oss.nxp.com>
-- 
2.43.0


