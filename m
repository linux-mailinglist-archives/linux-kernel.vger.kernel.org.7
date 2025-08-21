Return-Path: <linux-kernel+bounces-779568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BDEB2F5BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116A26020C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DB230E0E3;
	Thu, 21 Aug 2025 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB1IOAov"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22EA30DD1B;
	Thu, 21 Aug 2025 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773817; cv=none; b=Roa+IPQ+6bKUSfbPLlhWHz9Mtu9UtUFAk65I1mMIUAFJ1tlLAZGmyLZfio4qF+vEoJs/shHRP5UIRarDWyK+8LuaUkpwofKgG2jgIHFx6G2MKFZaJpQfJ6i2KZIEPqKGjcxkHfomtotZfPWFuHvHkCslftk74M4KHzWfS0dMqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773817; c=relaxed/simple;
	bh=iaHOGptznAcaiLxedhi+fdj7JOV3h3QH9q5o9VE+Lqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3UkoQNlZ5cc1gG2c+2JF5wMj5AyKYSu2lJj1oUfGBKJFIiX4VndmmXPMqFVzTaxSKzZMWe+Te5CMWkCoF5nYY9ds5+mNdYeJWAMACr4mgMxFsEcU6oFxjPTua9QF30W7Py99fgCHs21hgpkxHUkuAEbz8BX/wsc84k3VQnU9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jB1IOAov; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78fb04cso114106666b.1;
        Thu, 21 Aug 2025 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755773814; x=1756378614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjhHptinaxWWJO0WWsGKsxwtJOMywvKfSlqr/lw9SPs=;
        b=jB1IOAovM9B4S5bZkecUdZSUcwdxdRQHqL32VKeZSOSNQZixVzsAqG8TcpHrR3MM73
         hQHSA05zUUQoJfjjXCuP64og44hjawxalyCT90b3Id6crW1MFsWd7xfQsF0uc5gfPLcl
         FBmEmhbkh2Tz9NATh4f0R45lRhuOITDD9O+2fMMmtfjXUS1yiLYFX7Fjr6G0aS9Popb3
         bchx7EwfXRNosZx6WqwgKvZTUaQN4yw4FMpa/epy/TecU3rjpPUEhsPyWbbPJ+u+NwBM
         rX/qtQmls6bNt8s3tQzvuUS4NRbvecgsUnPzACY6lQ6UhByC4xoGUO9FfMSMtXsEJAr1
         tbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755773814; x=1756378614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjhHptinaxWWJO0WWsGKsxwtJOMywvKfSlqr/lw9SPs=;
        b=L6uNFsfslnehbzIyQ82Cf5nSrjSV0ruNTjLEpAd2fiDjncaWtQWqZ7Y1CyMcZD46nS
         NNvjgR6c33QZuBaNV/QtX5s5ZEae9geuQmMeYJIxuV7HuToA26UD7nhSr1kOAENnMz/C
         paf7pNObJCuu+fCWD+kYYYZqSj2qIpChd5tJbFogJzEXqPcZNCLuMHQF1K3ez1pecFUS
         VllBiLYg9fpBdZIo2fobd4KLTaBD+Tvp20KfFYlzA+cbNLvWuJH0xhpdFwr9L0IoUepD
         NY3UXR8o1miBy193nebaG1+xzlX0b/RzQYX/zRzkW5i4DpP7ks9DRwTVNUExGS0flgis
         T2IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqfHQbvxuhzxzu2wAQidCdi93s30368078YSthcoQYhbrmUpFOHcY/GUlqQNJgVhkgb1zQYnG6NU5HuClF@vger.kernel.org, AJvYcCXpWWQRc+0XysxS7Laenxa4YIs5KL36aBqc9W6BIOiEBf8xQxh4VN1JUPRv1MfN1gp62XE+kDSIaxz3@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfqR/Yke9cip/xvVvwbHg2+nW63nF33PzA2unZATR1f2Qi8pG
	pLbeZXKs63lIzkQGqFGd8QvpZOgHBEclFkfStX9XKmymkhWbV+xNqMq1
X-Gm-Gg: ASbGncvTiosPiBF1urv2ppPQGxmZngL/M7sGNDNfqBrgXkcCaM85WF4/Ul161cpim9S
	XCZHUp6htd76+q00o2dE0SERsaJmyyAzzGTAjjhmiV08lUCYk0dD9/KBKhhGsJ1bHVjdGVnLZ3S
	UjxBS0RdXz1h8rrx0A8AemlbeKE0JxQ27PlfnJyD/nsV1GmsCLL2xrGWriEbEBQB7WFjNfNQ6rq
	BjNLHjZxPvpPm1yESVJVwq3bsZ7G57uXb6wYq820PgPXyud0wbSHDLDDdHIt29ZgPQcOCt6fwz0
	trvStjXpZgp95SnAS/5iqXbirZRBtEj7MQRg0qZkPgqqykT+1fam8MH7Y20gzew6DxlMSAXFBGD
	AoUMnaq/9dXNXMStP6nlkLKVBHtd1U3jGbXqaF5uMg21YsfOSV8uv
X-Google-Smtp-Source: AGHT+IFh9B4wg+Jo7EUBE7+NvFrwXNN/AeIRkW8yHoL/KgrlM8+Hu4y+F1NmIGfgsp2QuK8PovS6Lg==
X-Received: by 2002:a17:907:7fa4:b0:afd:eb4f:d5cf with SMTP id a640c23a62f3a-afe07d4c63amr191037866b.63.1755773814070;
        Thu, 21 Aug 2025 03:56:54 -0700 (PDT)
Received: from DESKTOP-TTOGB9M.localdomain ([92.120.5.3])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afded4790bbsm373602866b.56.2025.08.21.03.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:56:53 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'
Date: Thu, 21 Aug 2025 13:56:34 +0300
Message-ID: <20250821105634.1893-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821105634.1893-1-laurentiumihalcea111@gmail.com>
References: <20250821105634.1893-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The DSP needs to access peripherals on AIPSTZ5 (to communicate with
the AP using AUDIOMIX MU, for instance). To do so, the security-related
registers of the bridge have to be configured before the DSP is started.
Enforce a dependency on AIPSTZ5 by adding the 'access-controllers'
property to the 'dsp' node.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index afcd8c785cfd..841d155685ee 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2437,6 +2437,11 @@ dsp: dsp@3b6e8000 {
 			firmware-name = "imx/dsp/hifi4.bin";
 			resets = <&audio_blk_ctrl IMX8MP_AUDIOMIX_DSP_RUNSTALL>;
 			reset-names = "runstall";
+			access-controllers = <&aips5
+				IMX8MP_AIPSTZ_HIFI4
+				IMX8MP_AIPSTZ_MASTER
+				(IMX8MP_AIPSTZ_MPL | IMX8MP_AIPSTZ_MTW | IMX8MP_AIPSTZ_MTR)
+			>;
 			status = "disabled";
 		};
 	};
-- 
2.34.1


