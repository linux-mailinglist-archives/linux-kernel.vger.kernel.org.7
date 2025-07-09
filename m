Return-Path: <linux-kernel+bounces-723169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E35AFE3ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AB516DE9C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C9E286894;
	Wed,  9 Jul 2025 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="kOugYCjH"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC33285062
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052728; cv=none; b=h+n6XS0+O4rEAb7TslZjp501sdjmzpVT9Cwmn4AYsP9NBuqBdAem0vsXNBL5he4WRCuiOsESjdDETBPTPwEXxXqW6Kom2O7hfDrtzypowXgppRchxz9Y7O5mwDcxznj1WByeh7KUkBDAp2MtiD0y8U2I916fLZmWTBTwoiASidQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052728; c=relaxed/simple;
	bh=ypwpLrRTvDMuCRzzHaQyRH1tZrFg5WTx+gHcQSKkU3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jjG7p+AsgyAx7TrNMwzBzFj1K4HYtmew43EH09DGnjIVwPUKQ7eFMnCVkvNXwr8qtzgQgXyZLJrJzpG41yTO70mPT2sGERdrAiv08TJuvqyzwkp7NpJQgSvNrOWEG3KFxEhfgFjhzj3ylbEGLQuSzZh8npbRQVTN8AoGF+6l/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=kOugYCjH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so8359350a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752052725; x=1752657525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k19wXpNqnFMbk5R7eovbUjQ7UB0GYLr4+9IyBRmyPec=;
        b=kOugYCjHPsGx+ilJfEi2PN7DnIQyn4utaBS1iMlc6XqP3z9VR4x0LSMq2WelbJ5aHP
         5et4bNen8HjWu6jB3PkVJyAIFvSLXzQ/D1Yi1ggiDYoDckkoVp8ar4pGHpbURUyAvFNo
         R2JLJX7g1XxPqU0u1K/ay94qYd0tQPYOCcSF7mh6WhvklIpKOhtjpP+mP6hWQv5OgU3o
         gEloaS0VdDKeewyHBEESEBD2iw7SH007W5xtdXkZN9++fqy4pYxO8PBWrVdsQlbPLbCc
         f6NOmTTx9N7v0pxxwHk8qycHDTEbpaBH/o/wdfzLJPSyjqk4YEqv4nYbuB9zSl9MFI46
         673w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752052725; x=1752657525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k19wXpNqnFMbk5R7eovbUjQ7UB0GYLr4+9IyBRmyPec=;
        b=q+AIKpWaFwctIH3p2EJnIU85kL5UBMG2/bi237mFu8FY/2jAYugLQecTRgBiJ62vhq
         fzIzAqQXkBPe+2dlRaZovZu3syJ9iQf0HyjAMxx8zgqDOVymjMCKSwHE7qDcun7mKfZc
         kCxE+BNJ3ZzgW5uQzaTb2MD8ju274gEb3jYR+no2dfrSXoqqtBFK0OrX5GwTGldRlzZv
         O+JtbdgnydzQKOiJq4ssR5AHMqEcLCZWZi2mkYAO3sCMu9vPbsdUVCxjVy0zg+3+He68
         i97Xs2YALlW0L8M+XfUFiROylDoeXZ90Bez2Dav7Q2gmssw9Q5mTEny3OFcLGwOj7Q6B
         7aKA==
X-Forwarded-Encrypted: i=1; AJvYcCW8vX6MPlEQbqSZvZzPMjMyFtNUyL9B5YJXH0MZ95n1MWHfPADkzgD/MWIKXmqJTKuHNL4c5TGqpIG1gSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdTAruvmFg9n8N+2wF0M3KamASRWqbbhtIqQZOcQASax4gg9bS
	lTyn6SNaXKA/H8bzdpRJ1r8At9Ww6L0h8hyydKe7tOYPaTt8zoC18dOOoYF/M9/hMoQ=
X-Gm-Gg: ASbGncsv8CTsWYtFscjfAszBzeB6pseU12zllBxLfhsW+DL620l9tEDVb+uGn69HaqR
	GLQ/O2IAkeMFuiqN0qUlp11yDRQrm14GarDttoo9n6bpQBsXiVvohLByc32nD6FznGi1zdrnp3y
	nFN5zDMJ251zoPYeEurysgYJXmfrWCs5qeMP6qepuiRAF+r4YWnMOFWev5MgNpaIIolrgsXy/wk
	J4xnRPlyNIidvPjODWvJCAs4B4pQN7yOOcqI6LjGVPeIP7mDoLzbtpTdG2WUzH/Np9kAhznGIam
	JX0/DGWauWsiEV4Hjm+E8H8r1vgTcfbl55Hy1W8yOV19DGzlfaIE0RAtE/d6Qw3ZS2EmJt8457z
	Osu2LniKXuzTZuI3G0t3N1sth9HNUs1GW
X-Google-Smtp-Source: AGHT+IEldUKbclROxgKKvDj16YdbKCkfb5vsSnzNDwXOeeA+MdVlRejqQ2rYPeZd+UWqDhaqfEndNA==
X-Received: by 2002:a17:907:3f1d:b0:add:f191:d851 with SMTP id a640c23a62f3a-ae6cf70f6ecmr193619966b.32.1752052724529;
        Wed, 09 Jul 2025 02:18:44 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b5e737sm1060116866b.142.2025.07.09.02.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:18:44 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 11:18:17 +0200
Subject: [PATCH v2 3/4] phy: qcom: phy-qcom-snps-eusb2: Add missing write
 from init sequence
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-eusb-phy-v2-3-4790eeee7ae0@fairphone.com>
References: <20250709-sm7635-eusb-phy-v2-0-4790eeee7ae0@fairphone.com>
In-Reply-To: <20250709-sm7635-eusb-phy-v2-0-4790eeee7ae0@fairphone.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752052719; l=1183;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ypwpLrRTvDMuCRzzHaQyRH1tZrFg5WTx+gHcQSKkU3w=;
 b=qWz3s8ZAOTflgxuX1N6dBmF5nLHnOvsOGcagHqbmagvbHIa4s4DGNR3HHtOQx/6KBWkS49b78
 y8aXmLEU/40BkHdwOhmwGYx/yUn4lOmbIbaH1RiDiedOPOnvRiI1YBJ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

As per a commit from Qualcomm's downstream 6.1 kernel[0], the init
sequence is missing setting the CMN_CTRL_OVERRIDE_EN bit back to 0 at
the end, as per the 'latest' HPG revision (as of November 2023).

[0] https://git.codelinaro.org/clo/la/kernel/qcom/-/commit/b77774a89e3fda3246e09dd39e16e2ab43cd1329

Fixes: 80090810f5d3 ("phy: qcom: Add QCOM SNPS eUSB2 driver")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/phy/phy-snps-eusb2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/phy-snps-eusb2.c b/drivers/phy/phy-snps-eusb2.c
index b73a1d7e57b32cfdfbe314ab938ec54746ed53be..e232b8b4d29100b8fee9e913e2124788af09f2aa 100644
--- a/drivers/phy/phy-snps-eusb2.c
+++ b/drivers/phy/phy-snps-eusb2.c
@@ -437,6 +437,9 @@ static int qcom_snps_eusb2_hsphy_init(struct phy *p)
 	snps_eusb2_hsphy_write_mask(phy->base, QCOM_USB_PHY_HS_PHY_CTRL2,
 				    USB2_SUSPEND_N_SEL, 0);
 
+	snps_eusb2_hsphy_write_mask(phy->base, QCOM_USB_PHY_CFG0,
+				    CMN_CTRL_OVERRIDE_EN, 0);
+
 	return 0;
 }
 

-- 
2.50.0


