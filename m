Return-Path: <linux-kernel+bounces-815756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C99B56AD3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1F67AE711
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A9C2DE1E4;
	Sun, 14 Sep 2025 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CZNKGi/I"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17102DF123
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757870186; cv=none; b=q6jaoYmC16YdAvhR5FgVG4/L4rqTNAyJcwuO3vU4aZfhreangFzkTx+o33NxsK/td9RCp2qi6Vm/txtdPzRGei6U/ITDt7mLTMWWH1GEUUghFv0jYmlnA/dRZGyL3Vr096HTb4Y1pW3UUS/JK5Td6FX8C3wIhXNn2m2FPjRHFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757870186; c=relaxed/simple;
	bh=7R8rcOL3f1HwsUpPHaL0+BUAREAOiXb98Mm1tlgtyCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbUcrB6IYxY9VSxl78L4tsQEpaWkOFsM4TIPdPdA+7ArW+Z3hnORO7nLu+YeSFT1K4N5rXGlxe62NdvZwtdiOMcjCbnS3L6wVe7t6VHP+G/W6a5dZE4Xx2iGwYq68UftrrhjK1HxzJ10xD3vV3q1wnKs3K1/fIGRrZiunBtjH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=CZNKGi/I; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f0411577aso2406796a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 10:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757870183; x=1758474983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ9ovkCr6DqOwPekQL9mbbfb8pXGwCeM0TnyH7IdLxU=;
        b=CZNKGi/IHBMBaVws9rL4ax1ta6pLgauB7OVRZScLOr7GMmxwpF6Mn1vRQs0Y4e3wRZ
         BVnds2dTwTS6sB0cLZy0mZaUx1HvPMy+x+yVf/W9lifjneFWy3Wbo3E2tGVNdVrZcq4j
         PGJ2xZPqqs1iE7AD30ofJv2M3m1VmSVqQAGoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757870183; x=1758474983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ9ovkCr6DqOwPekQL9mbbfb8pXGwCeM0TnyH7IdLxU=;
        b=opbwcODFFganzvukRHmgT9V3CUWHeHja2+OLkcRoz+4JzD+DQKE05LjnvvbVxpe46g
         GR2IMYsWD6s2bChmrFP37Xa+yPFV4qVTUb13cNOGa38um8QqnUKK9DLyMHl+i5ePHHmV
         4nCdNbVopVR8AUzwRaAL96pBE6X4P5xdzf1VjZOxJ4SJtuVePhIQv94kyopNnLHP5Yj3
         5ayT835FHgowtQaZDMV+kBGRA1qiMkmGybnmjsoXuvkJiREZFGZlIyW2pTVRc8CENluK
         ZjKBAE6tX/04TDeJosNsfcvfTd6Yxiz+esfnBn3Unv2qVCZ0haN7koiJvU7oOGu8hBTN
         H0gw==
X-Gm-Message-State: AOJu0YxYj6dqVmgn1I4a792/Jpqk/1yX6kGXD/8vzFd8xgIqVf+CPdcl
	FGecao8bhgD9Z4Vw4gKddZNqfEaicLKk0sNRSTApQA8Qpb5fQDaRSOeG7EEdzswk+kkhZiQxR14
	EAlqd
X-Gm-Gg: ASbGncuT6oFcHm0dBUOGdCEraEmOzF3E/plDTrcmCHuRBMBB3k2uO0BO8wPKYZvfW/U
	HInk50VVetjNw5ICXQzdexGReX3XcDaIIAqf71sCGBEJ+K/91KiTIVf9362HN3yCLScYuxKOqI8
	LerULN5MlB7lspXbGXYbMhdnIyhq8iPw95/ez/w34sxKjI14KAWgJAdBN3hgwHLU1ehBAk77h4P
	jjaJONac4UiFf+ColuySkgREaTLh8YgT2zVmoagZCPDL4hs/we1hAmD90EKVY1D5GJXeoUU0f7z
	smmgT2kGdvSdITZQ9ix2/arPDKxV7SBAoKrB0mHugo+qRYq9DW96KRxauh0zxj5aX3ipBCrekCT
	f5NjP/uZ86HMpUuJFKJ/3ePlZJ5/YnMpsxaivuo6lN8IwjFbH+jKUd7vlI42XAxQIHWGjwM0/x6
	Cb0dAJ5muBjLF5DnjBg038+NH3UqFQKk0iAh2QarLNC6ucJHFq8jeQvJk2qetboTQ4
X-Google-Smtp-Source: AGHT+IGvSuqYu1iID/ihliDiP5cWiNfNXKYVhuVRH/gmTXAOtDLlKa3rm5WJL/vzrHXGf7HRci4VUQ==
X-Received: by 2002:a05:6402:1d51:b0:628:62d0:fdaa with SMTP id 4fb4d7f45d1cf-62ed82c5a2dmr9785589a12.23.1757870182851;
        Sun, 14 Sep 2025 10:16:22 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e76dsm776980466b.102.2025.09.14.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 10:16:22 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/6] ARM: dts: imx6ull-engicam-microgea-bmm: set touchscreen glitch threshold
Date: Sun, 14 Sep 2025 19:16:02 +0200
Message-ID: <20250914171608.1050401-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914171608.1050401-1-dario.binacchi@amarulasolutions.com>
References: <20250914171608.1050401-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This way the detected signal is valid only if it lasts longer than
62 µs, otherwise it is not sampled.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts
index 279d46c22cd7..f12084d8f2a0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts
@@ -154,6 +154,7 @@ &tsc {
 	pinctrl-0 = <&pinctrl_tsc>;
 	measure-delay-time = <0x9ffff>;
 	pre-charge-time = <0xfff>;
+	touchscreen-glitch-threshold-ns = <62000>;
 	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
-- 
2.43.0


