Return-Path: <linux-kernel+bounces-884715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9BC30E23
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC68A4E90AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0DB2ECEBB;
	Tue,  4 Nov 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEREGphu"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619B12F39BE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257847; cv=none; b=pbQzH/ckrooduuCmNWd9DtDjLfezohEAAPtXWPFXnsTfSXZFBm9/JlHyd7bKzQZob0DdkK9cPADka8PfbcFmMxu9xW8HT1TVdemz9OAmgmZZNYn9ZjNRcT+vmuJNP8cQk+/3SsLGbr8Xeu2D2TuFMN64Bv9WlGYNlI1B0Xte3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257847; c=relaxed/simple;
	bh=TgTd1HpIl/XZJoNIxl/sF6YycwPbOWbZcWt7SX51N6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGj66COdKOsz/kaE8gCXWb+Hgf4T2/xH+pidDfODhTf83fyBv/BI1iFItCM0Evu/VWbtkzmYvq9kD/1BecMOMNt8rF85hgVbuOb0oVVrj3Si5+YmVAARboxBKJu3hecILbFvJ1LohWkQVQlNmeH9i7jCFdN69VzxL82gyMPC0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEREGphu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7200568b13so178913166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257844; x=1762862644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MONqpZUeZWIIjN6d114EqSMuX3Td/c118reK/5knf7I=;
        b=SEREGphuW7G4f/PD7getzsGEd/9jYb3YmPdN/Ewequmz744g/e/votmfzVoG6ae3pX
         d0IVVhzQxwREjburiCjVaDIacufOhfE6ZuKRRkPNUAe9lpRqVUGS1uKgxzGJAFMp9Pl1
         FlKdhxVTuBAkeGXfgfyJHm2uyynPSjTVOIO4IHPS5Zorgi00BnMukY/h36VpbHzrvurI
         /aYhGoyARczJGZbXnTOv643J6oU23SKDA97SFQ60w1kgMZFBG1wa+IYMxP5T2MCVsFbE
         36FR45TcQk3orfzAEiOiRJW6ZmsmLExHaJlnV0ADSIuZiIZtz7F15/39NpRG5cbOn0JL
         63bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257844; x=1762862644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MONqpZUeZWIIjN6d114EqSMuX3Td/c118reK/5knf7I=;
        b=kjDkk+LOn4+dk/6FywHBNUeAyywgASFNFXcMsc3ZWi3dZ81awayrglcdIrlMWI4+5K
         zC71nJcWU9vmgBURNf96izf53M69D33ReRV9P5tD9jZ6/IKsBhtekXi5AET+Bz+gxmHV
         eXDTtpicqFACbeZFhFxwIBV7CpxzJazhziZrvfAHWMrarj0YnlYdRX114vzzZJVbNBlc
         lw4rIR3sGV8s9ugcEEYyq4STi0guP+r8MXg+V26ZNYxrz/yj0HoYDw0OzeyDz09IXXqD
         hIfyowYDZuWX4/6PPMnkQpKquV708wZP8veu1Rxum1V0h/WbgWJTX3owqnmR9OmfRK2x
         O86g==
X-Forwarded-Encrypted: i=1; AJvYcCWiT3pj2ABKDhW1oGElAHcHFBlc6z/6AcuL6sf/9NxwG2jKHH0G9dtvrUgc2jJDtQtyPJURVnYJ6PnTfkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8tgMWUYkrh/fd4b16EZ+DZOd91fwCv6HFOntdR/Psey3mXaD
	YW+yC6ZjL9wpQxWpBljphO+AZyZoABKRXD2TKPYcTSokxEHrEK/eO5Sb
X-Gm-Gg: ASbGncv5G8sv7iv5ZXgIej8rKTRq/XVEuQN+cl8YQ/7AzYSWd9dcYeXJnfJ9NKkJoc1
	BYXZl9Q/0Ikn+NWrpSj27gxHtHy2Gm6zOPrKQH4cBJycHBXcaSzRdjsjJBLQT1p2bGezQ7dPKqb
	2Z+gqd7XH1WE6sMuZiNM57yWNOqTYiyLIMr1ecd6T+Z53NnfPQnL+fXI/GV6rmkW28vpn4bC4kQ
	HK6CqVQ3kcMsna0UGxsuqVG7PSnAM6srSwMOGH59SzGICxt7WaUqAOCwQwojB5pYkptqlq9kOXN
	BXg/ymNDqQwBtEu3rlgjEV1lnslwWpc0XuOozE8MH04P8iRhptgHXsNI+94HVZuYiJJhKErngFG
	2XrLK7SKwFEyE2DPD0WPVL7mtj4RqdoGkmbXMW+J7Q4ytlQv3Z+kbAPU2ZMkMIv4ucUwPd1Z2Iv
	vEy+Po9o8ZYMeZmpEfriRVpJ02tA==
X-Google-Smtp-Source: AGHT+IHRrE0o2sdiIAqRFi5TYM4KHbBFm9RA/54j9UR13Jtqc+5S0hJxSBlIU42MxJbJO58DHC9lVA==
X-Received: by 2002:a17:907:3da7:b0:b4b:e419:9af9 with SMTP id a640c23a62f3a-b707018cfa3mr1722945866b.23.1762257843561;
        Tue, 04 Nov 2025 04:04:03 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa038e0sm200894166b.54.2025.11.04.04.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:04:03 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v4 4/8] reset: imx8mp-audiomix: Drop unneeded macros
Date: Tue,  4 Nov 2025 04:02:57 -0800
Message-ID: <20251104120301.913-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
References: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The macros defining the mask values for the EARC, EARC PHY resets,
and the DSP RUN_STALL signal can be dropped as they are not and will
not be used anywhere else except to set the value of the "mask" field
from "struct imx8mp_reset_map". In this particular case, based on the
name of the "mask" field, you can already deduce what these values are
for, which is why defining macros for them doesn't offer any new
information, nor does it help with the code readability.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index eceb37ff5dc5..e9643365a62c 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -14,11 +14,7 @@
 #include <linux/reset-controller.h>
 
 #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
-#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(0)
-#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(1)
-
 #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
-#define IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK	BIT(5)
 
 struct imx8mp_reset_map {
 	unsigned int offset;
@@ -29,17 +25,17 @@ struct imx8mp_reset_map {
 static const struct imx8mp_reset_map reset_map[] = {
 	[IMX8MP_AUDIOMIX_EARC_RESET] = {
 		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
-		.mask	= IMX8MP_AUDIOMIX_EARC_RESET_MASK,
+		.mask = BIT(0),
 		.active_low = true,
 	},
 	[IMX8MP_AUDIOMIX_EARC_PHY_RESET] = {
 		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
-		.mask	= IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK,
+		.mask = BIT(1),
 		.active_low = true,
 	},
 	[IMX8MP_AUDIOMIX_DSP_RUNSTALL] = {
 		.offset	= IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET,
-		.mask	= IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK,
+		.mask = BIT(5),
 		.active_low = false,
 	},
 };
-- 
2.43.0


