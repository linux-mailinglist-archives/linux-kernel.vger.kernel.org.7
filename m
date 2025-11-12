Return-Path: <linux-kernel+bounces-897812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD48C53A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11E2D3466AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191DB346A02;
	Wed, 12 Nov 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XbWpKcXx"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9773451D9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967914; cv=none; b=HGRUgqZ337aH5ena53/O3cnBrkdrhUABMjLBEngq2Y3DdcnuMK9GnNnPlf361MWIHuYjVvrvx/XOfmgBnTxQ77zDZmxQhw4Axi8jBgnA8CYRm/E5n567wIXnsZqUZPUi9BIE21d/rGjln5yPQAHkc5h4G5v5USYpUAySoGSvnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967914; c=relaxed/simple;
	bh=jMpPXYaKDkwcVsPk8JTKIBY+RZIzXHL7r/ukT6REJIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnpknO5kYpx2iEa2LKsUwx85YDTe9wpb9UDEugcOFEyWK8ow6QMNOQcMbpfB2m6tE801Dkud6d8IBGRSi4lG6fKQikrAB4phifrHRVHKzmXySNTuzOJm9LSsnu6+bAveUMQKOJYWnlDBbOX84E07HrbtGfrTjbHktSyEzwcJAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=XbWpKcXx; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso1666317a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1762967911; x=1763572711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fFp1zvnznBgN+0T1h+jmPtm8mqRaI84OPEX4IDfRKM=;
        b=XbWpKcXxrb12NTcAGpHf++0IfM6TdeKlIEwD/2Ymdy/fm+HpSZqLp360RP860nRI8X
         IuHTSjWzw2wKsBjzj/4rO3026gUM+fbaKc3aqaDP/VAnqdXZ1U1kQr+rRPCA4KLWG0OA
         +qnXFHZPrtpfH0vJh6h6huSEiOTFbuGXRGYDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762967911; x=1763572711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8fFp1zvnznBgN+0T1h+jmPtm8mqRaI84OPEX4IDfRKM=;
        b=hMQyA9SHhvSYdLbhQyQ0DxSvHVNj0tJE7oCQSY6njotBiJnTo1UZsPaLXOmz/URSyA
         QW6o7+MaOVr1RrrJdww071TautDVMttuxNJHNiXu/iZi1qGU20LccmHCB9D2FU9phxSn
         pNAvv/pN4hMta6/eFK1XhLgYAirXkaqRK+CC67FnhKsZZdXvnPIiV85r5lP1W2alLXGP
         QRTpQJ0PK+9K2aCw4G/hSr/MmTppjn9JOEHyzx0tSGyFqHTrJTFPKpa2pm+lvEZlQ58U
         ocgZGo132hkUmLqfUD/03Dwmm56Uea2ApyanHxWZN6Eo1VPnS2ZU2CXoVA7WknsUJAI7
         HALA==
X-Gm-Message-State: AOJu0YxKLCLlsRSKqozsioFDlF0WPL0HqleThnQdw3/j/HZk2zPoam89
	DU1FYu60lu58JRdAFd8pNyN5N4b2q9pGS/W/uT7GfnBzcf9zLe3GmT7qvYPLUMen6t8ZKCmnh7q
	G7FOy
X-Gm-Gg: ASbGncvFE8/FhuaNrNH2kVoFBO7mes1bQyRHPbDR7WZACuC+EuVpxD3cMDnqrphYF+Q
	Hvj+tfikecDnh7y2Y3fdKK+TPIyFet0CbcqYFgVw3d7qn5lZQOF1KplohNh0xg5h79Mz0bQmRMA
	hdliXBbYstt5eu+7LOCFQc80i/TedgSWp5QVRc3Vxk2jO5SoSM1uDmY/kyf0JusQUGUFjQnXp05
	7HBQpTN+HvcKjsQyylxX1BhPkZ/kxG1ctiq8PSDWeuYRKzXnk4IHNpkoXQwp4RYR5RgQzjK/G0d
	nRCpGJ7r+UWcyHeWTnpwCaW5A0TLcWOBCVel0bliXermY9l7axZAguqYOzT68bS9yJ+NZh4HJwU
	9FsvSI4BVxLRbKxeZX/aDCZ/2oU79vsEwQ38ObHa02uwlyB1JmoBHtqbuAcfRZDdPLklts2CH7k
	xujqUwMEe49WSNHGhFWVKPh9ogqe1PQk5jOCllKN/moyaxSFjsgYZPx+7IhCPi7NrnCi+bYdWgn
	jS6VgOQDZEbqPZHY204McgRw34DieOTTHjzLezZFbIheMVJfDQ4QkU=
X-Google-Smtp-Source: AGHT+IEEV00bHQWd/lidxf8la3g3vKUR8rGrFzsvXovQz2c7aRvWz16PbrAlC12SmBL57s3JHbjEbg==
X-Received: by 2002:a17:907:60d3:b0:b4e:a47f:715d with SMTP id a640c23a62f3a-b733198d584mr376086166b.17.1762967910867;
        Wed, 12 Nov 2025 09:18:30 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-54-71-163.retail.telecomitalia.it. [79.54.71.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b73381dd3besm180731866b.43.2025.11.12.09.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:18:30 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v2 2/2] ARM: mxs_defconfig: enable sound drivers for imx28-amarula-rmm
Date: Wed, 12 Nov 2025 18:17:13 +0100
Message-ID: <20251112171820.4046537-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112171820.4046537-1-dario.binacchi@amarulasolutions.com>
References: <20251112171820.4046537-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable TLV320AIC3X I2C codec and simple-card support used on Amarula
rmm board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Drop 1/3 patch "ASoC: mxs-saif: support usage with simple-audio-card"
  because merged in linux-next.

 arch/arm/configs/mxs_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 3b08c63b6de4..603fb003b223 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -100,6 +100,8 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_MXS_SOC=y
 CONFIG_SND_SOC_MXS_SGTL5000=y
+CONFIG_SND_SOC_TLV320AIC3X_I2C=y
+CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_STORAGE=y
-- 
2.43.0

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
branch: imx28-amarula-rmm-audio

