Return-Path: <linux-kernel+bounces-824915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6492BB8A75E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE793B8C89
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F032039E;
	Fri, 19 Sep 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGFsG/JL"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D931FEF8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297512; cv=none; b=aXQ86aZomMYAuhH7WyYY28iG2veFNS9X7+Z0pmqNPu4NVk71J7vGnC5m2N9wLfBtbxDkEqT/CLGjvV88FjQpDCErS9pzVrt6O/KUo3RheCx29nlS4aYLghax16GhC9rMVHbuZRWN/NvTigxm1pqXB2PgcphNZthhp6rHRPlIVFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297512; c=relaxed/simple;
	bh=NJnIJR+a01tiFVyycgg5z2jTHr11W/B75N+lse5oSTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1+ZGTQu3wzm65b3F9E+Iat8lFuWK6B69/st/j7gnsER6uV2FROxpKGvBXD5eeV54Uitx3bDNzO1ASpHjb6y+38uUIJbeA2EC/URKhhSQylldZSNieKHWJBWaIh3eh45PUxLlE1FOfwPV/VKTPekfAC+dvUnVhRBiPmB4pqk3ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dGFsG/JL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee1381b835so1257043f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758297508; x=1758902308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UP5dGRqrdTptZhQQ4EtYFVr64j2KjS+2vfjCc+4QY94=;
        b=dGFsG/JLRuC80ua5Ov2+qjxCJQ2rqdNb4upMGW7jGl3tXJ58Ncbx1XFGdvjDAs4VsH
         f5lkZmNQFnS1c3pyJZj5F86fMiLpAxY3WUrRuLitYxipVTylCb4+VTOAWAT5Fum1vLR7
         i2SGcAkv68Wc7ETpmEiQy3Z3xJaLnKC2dyUQCCQTNAFo/5QPTYfVEXrwnDUbetALTLDT
         2eUdvQNISHzdWdEjmi3xhi84nfp3ij0p6dVHxnuWPx+p+4WHOL6d4pxW70gV6KQzRfnn
         EBEFcz9DtLQWDaapPO8HEkte6ft3+wk7DCNnf1Rs3Yp8eWpXac/zFkcI0QTcyxyk9T8X
         Zjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297508; x=1758902308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UP5dGRqrdTptZhQQ4EtYFVr64j2KjS+2vfjCc+4QY94=;
        b=T4ev3zD+v9tdnhwidP9hYqIUF4CWQdHQ6Acs9KI+UhSLaXhlD/1BHdvT4Zfhv08rk1
         XDYEp+OdVYxQhMZbJ3jVw7TWC4+wsbi8sUULz8V07Fwqh7qEC+SpGn02Il7tbU/s1xhe
         bszoMZESeKnh/4tJGMtM6stb49od+Rx5S43jSSLrF8mfSnVcoMVv0Pv4ZvPpoPWRlcNV
         7LHPoM2iYuqx6TnbDS6kfEEF2VO+dtASNpfOtJjuBPWVXF6g1hGmEGKvfwk27aZErbai
         ew5i9c6Q+c7iIKtiRVznkU3jsZyK+xkB5jrwODqHynE056+Lc0hEnVy1ig23+pXRJBcG
         oJDA==
X-Forwarded-Encrypted: i=1; AJvYcCUsTBwiQLMt1Igj7pWhyr6yY2cp8tVx+GvMsSngrfpv9zKEJWiKUDOP/h4uyqE4XdVThJLgJPt07SCwGvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZE6rtK02o7knXY31lRBg6QESv+k3SsukDATtNqpBzVuPxsLC8
	7Aa6eUQjxaOG6vGPJMhmdYjnTLhIlbJVyUIWVst2BQ5ARbVaCvOxfbf9amD3Mp9a0q0=
X-Gm-Gg: ASbGncsHPQUo7yhIB9VcsCkl141tdg9RCveY84uRVQMbBZZO6Cq7qqTrWavGWh03fTv
	CvC1/zE89rVi4L9xRGc7CdRSqikvfX1pm52qstg0pht+Cw2fpwAswGP5VUr9vk7+1ltaWsQz1hs
	55TuwnccY5nHiVJGnkJxOTeXdtsLmjjqnC5piGMUi+G1D4lYnS6OrSAk+e1a80Ec8dGbQs+maX7
	Zjr96+ZfpbDyB61jklfKeoxC2c94X3N3pBxyjwHntrm7ozZO9/gDVBZxnfbSuROp5jD/wLHJvAg
	2EHJYct87AEc2yqr6tfwWT0Pi/ODtvdFESnoIuUnd5XSIEg4riAHbpGs/XnSwY2Nlfp2+7MTRFf
	B5RjwhcbWmxTsuyAg0oP6ycbzUZ5+Nzk=
X-Google-Smtp-Source: AGHT+IETzqsiuBysZBMfPLsmfeqemqt5Mwb8f51wHMHjVVo0pcnRoASq/BUs1RN16Mcn5F21Vi0GdQ==
X-Received: by 2002:a05:6000:144f:b0:3dc:ca9d:e3d7 with SMTP id ffacd0b85a97d-3ee7c92548amr2737996f8f.8.1758297508355;
        Fri, 19 Sep 2025 08:58:28 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:9dd0:62bf:d369:14ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407fa3sm8367224f8f.21.2025.09.19.08.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:58:27 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
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
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 3/3 v2] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver
Date: Fri, 19 Sep 2025 17:58:21 +0200
Message-ID: <20250919155821.95334-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919155821.95334-1-vincent.guittot@linaro.org>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
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
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d32..fa45862cb1ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3084,12 +3084,16 @@ R:	Chester Lin <chester62515@gmail.com>
 R:	Matthias Brugger <mbrugger@suse.com>
 R:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
 R:	NXP S32 Linux Team <s32@nxp.com>
+L:	imx@lists.linux.dev
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


