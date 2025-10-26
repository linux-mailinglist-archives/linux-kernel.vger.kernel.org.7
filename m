Return-Path: <linux-kernel+bounces-870372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9276AC0A89C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA3DB4E15A5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0226E2DF15E;
	Sun, 26 Oct 2025 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/Dt2xVU"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F12309B9
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761485822; cv=none; b=h50S9YFHBbuHm4jBys9s78Iwmrmfk7l/yt60lnEEi4fcX3U6tG7ZgCLWIC8Rke2eZO9oHbJ6lt/yMR5g0RNC7wQN2fpQe4vHTxSxTezemDYZMy+YqALVZzOHK+83coByEAVZ1n+93RiBOayDjjYjJFbtqs1YHoQ8J9uuBCGSdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761485822; c=relaxed/simple;
	bh=k5Xu+Fx91w23i61CCMFAZ+u9aD54Fy0PXtQ0IULwHnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWzOltCK79aJT3r2x3+4pHrH2B7sNHS+uzax2DrXZ8DDdLnVIcmoNxjY3Wol/82et78Rri16mKxBygzdS2oUr/jvxRoGQW1Tzu6lr0Cz3Ohr4s5TFk7saxn+wHJ7a8dn/c69Q3kVLPgcj6eqKunpzUbw/0+2QX6YO6uBZpB5y/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/Dt2xVU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-78118e163e5so4116994b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761485820; x=1762090620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4q95rxfDB89T9aMYjvX0MgcFXoo23MwOCFX912uJuHk=;
        b=H/Dt2xVU5OfwZp2w/lnX2gbk3TifH2ZztgQ8MM1dDWacRxlUnlRukja9hT1j6h6OZG
         TjRBPLfn+aWHfyl0XUIjh/ktTS/vw8W6WA3lqdAN78nmlAuTm6Tlbii1ApYfLVGmGX2U
         uCMm1cIfcPKr0vZ8fBJmAmqtTdN4DL7s+uL0S2Afz4u6Mz8WzCAeC+7mnVe5uiflpEQi
         taM+UKdhZTtsHdAxUAF9d8+pGi5hnyHXjrsPge99FLIVBLRHaH8L+mEnMM2SQzJNf/Hb
         VJk/EIAufmH7u499L2HJ97dZG0skX4rD3vQh2SgUxPBKZGGZTLYCNqSSUKK3Hmy7KCtO
         4bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761485820; x=1762090620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4q95rxfDB89T9aMYjvX0MgcFXoo23MwOCFX912uJuHk=;
        b=UyLPstU1r5AO/WWi7IQWwaX21J4n4Kb/yEnJzZq9/x3KwqhDkk1yF4hvU0LTLGiCmC
         4N8Ay/oMroNo1HsSCXNPkSmaVuLkaBzxvltQblUNMtXbhqTzWhkkwBcBfJzreV6ibGmE
         gOrwMluyCYD9a/jbnFQ8MOouYB+9hSaRfzPRk7Yij4agNUgxllmLiY86VDfhxkAcJmvU
         G6E5c9B7YqrAjAw2o3rFlzJsnWV/dGwKxzJV38OjL8NghRxDi+T697a2zlbAMHqDaWkS
         mANwuGEWmClCVvAvikfCPlVQ70KKxYenMh9P1bokSbn5SfkEZv7vA38gUQn6EB1DdNdo
         rDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUu8NCHjGg/83V1LZwJgZeHfXKv0XzTvzWN24DMb4t+WJsOmQJ7cHvpupLgQNh4BH6JusjL1R1Gvucngg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0yUroiPrkI/D+lUqmalhoktZKiObzfZPhyeGZgyE9NYuMBp68
	iXyC/3/Znt95c5LZfFkoqMDdjYFc63wKv8vS3rBs4b+roAfz/LcfmSZb
X-Gm-Gg: ASbGncuNU7RnT5kGU3j77Z3plmwTjd5InDMsAoFdEHtrSbf/S9qxh8hBBy2Yj7gQAhD
	eiM80oBmpMlUN5EGREVonJZpteQ2ORu5f9UNXL0F89hziYKO3IZMUerCmSgFzbTP7McJSNdy14X
	R5l04YGW6dqQbF7NHvicJaWTfWYWVUHZepFBY2yoU5aIAzMof7kuBrwF99v8gqgGPTmB3LCtAsn
	JNXTr6UPhTljTzwIeb5hRQMVEvoGxAtipLqWSzu6qcfj14NXDZNPJeu2/hnUMnABgqZX8dCEzi0
	DiHLYJvhTzzpXi7wtR0cmM97cvaP9BW8tUw1nMYhE4KHaC9/HE5BJTZDksNzRizn4xVgPkj0iuI
	X1sLWmxxr6Xb05JNU6rlevL+W1z2Rm6tpDyFPbzhgnzLD8ofteNc2lqPQ6GJcBKo=
X-Google-Smtp-Source: AGHT+IGI9yVmqkshJAUp2sgizg1Z5RFAEA9X7PnH7GLFoLbo49UGAbjKO28ty0jrOiiJOueYMsoPvw==
X-Received: by 2002:a17:902:dacd:b0:265:f460:ab26 with SMTP id d9443c01a7336-29489d70d80mr106863085ad.3.1761485819705;
        Sun, 26 Oct 2025 06:36:59 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2401:b60:5:2::a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40a7esm51605775ad.70.2025.10.26.06.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 06:36:59 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Frank Sae <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Tianling Shen <cnsztl@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: motorcomm: Add support for PHY LEDs on YT8531
Date: Sun, 26 Oct 2025 21:36:52 +0800
Message-ID: <20251026133652.1288732-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LED registers on YT8531 are exactly same as YT8521, so simply
reuse yt8521_led_hw_* functions.

Tested on OrangePi R1 Plus LTS and Zero3.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 drivers/net/phy/motorcomm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index a3593e663059..89b5b19a9bd2 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -3048,6 +3048,9 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.get_wol	= ytphy_get_wol,
 		.set_wol	= yt8531_set_wol,
 		.link_change_notify = yt8531_link_change_notify,
+		.led_hw_is_supported = yt8521_led_hw_is_supported,
+		.led_hw_control_set = yt8521_led_hw_control_set,
+		.led_hw_control_get = yt8521_led_hw_control_get,
 	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8531S),
-- 
2.51.1


