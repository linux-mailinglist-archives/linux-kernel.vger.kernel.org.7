Return-Path: <linux-kernel+bounces-723948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A98F3AFECD9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B66D188C1AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF482E8DF7;
	Wed,  9 Jul 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="K6hq+9Qe"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E582E7653
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072930; cv=none; b=HuESrkMt1/fi52vINIlcX8IbLad2Wd1go6rWGU2UATksz3WP1tHckI2ak3J2gVxAbFMflmscsNsCywdYK6uSYdeBJwKd088RjwJTlLsVRmlPMcntBwnVpTg2Xv4aJ0BFJYCfaR82xk37oCDEZftDZ5dKQgsqFPDDa1UYDcemccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072930; c=relaxed/simple;
	bh=dqwE+mgZFmDVF9ARQ35sDJJ/X46qouKrH+a/CF0hG4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0VH31sByUKmUxJavJF7Q3SeNn9mR0IiLqDf7lOUTe8KeXJC9NZ078ZT5BB6Awtr862Lh3q8BpT4uksgYqMKXceX6x+qfG2AAs6IGMOhdVP3OsY92n4v8lz9WYV3bON/vkzs3XH6JQbI+zb81HYrFqdBD7PTYoplSEeAD+/9oK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=K6hq+9Qe; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0de1c378fso867077166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752072927; x=1752677727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MGHNaliWz7mYnqQYod2IP0rY/CEmdQgMImzv7dtE1Q=;
        b=K6hq+9Qew1kDjCw7OO/rcesSqRTVQiTuwJYlCc/wtP8JjuUl/3LUuyokf0O+0b6SF7
         Cm48TyWF8D8Nrt/90fZKn4eHiXSMeeefWDW818nTQHurB6fWZSt19XnZ4gbWWMsyY47a
         uPlYahwqYwfZo6eZrTfRdVkEuddyrUN/5MW5lvZZ4/xAXU2/1b6EdKDZ6K6YRpxsQ7kw
         toTIZFz3I84ZwczdH4XLJgKgg8hnsOVU2zH2f4hwez8vNsQxajLL9FDZduv+NR+OEp9f
         GjduxYhcFdEjs20vuWg2nEZz9xIT0XpdhZGlXO99YGdD6RCLNZhdGOSDI399j71lnUsO
         xxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072927; x=1752677727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MGHNaliWz7mYnqQYod2IP0rY/CEmdQgMImzv7dtE1Q=;
        b=rY88VocMPDVQIysz3m6ClPe+nZN/TW62eV5F5J1lIm68WHs9VeyfNkKOJrriqQBjhw
         +dyI8WmCtnJUiEx9TRdd64TNlY+EvOx8molBd9+IFhXRYW/JKPOcgqOtXghhxWory8rQ
         OKM8QY5c5kIvyyDhV7xxilygjYDMZBB3/dqm8wkY56V4A8frV/yGq2FNVCUJdPsqTrzd
         cEckq2N12Umg3pD55hkHLlBMhr86BpWqThxsAfHmLe/vkG29epKfO3ioveVx2q2GXeVE
         7PjjpldiKZhvAdBK8/t2vg3bxUVgRBkwWBGU4+zGc84L9sE58IC5F5L8sVOtq5yUh48y
         +mZg==
X-Forwarded-Encrypted: i=1; AJvYcCUxjhSfEzKahgXTNm1Nd3u+mih9KC6iQMnpzMIxwnyMcf1T0eR2wJ+5qz/bcfnLwdZWUV3omXJtuaFlY48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcX17U+2cjvJHMxtrdm3z+OBa5pd4ZCix33fq4nLmRajNf+RPk
	PnyDXc40HLkblCfDmv+S1IqT0Hx/9jXBY/bGN7lXeFEuYFv/sM8qUa3usbr28ieyhOg=
X-Gm-Gg: ASbGnctvd5g15vHdG4zlIP+v9Lu7L6J3tYMgCUsAtteDsriiIyz51fegJ7jnkvvoXcS
	/Zcdr/DVahIm/P5aOXCXeoxQrQVd6/Q0C+oo61tstfub+Gpun6hzTYkkqu2pJwK7t9kAbcSwQ9Q
	86z6SC2+fwgS3BnnchY740dQS1PGd3oUDehXGJTBCa1RFitQdr5Vz5XmEQ77/O6b8fQ3u+AMkLk
	zwv0gIY2BIW9i/iQ0hUri+s/CUOT/8r4hIVWfmwOqpl8MDx7RG8ACbmcOgNpJoytoNbtfLj3TKc
	q3RXHFMYjy1mQSC5orSaQti8yJoy0qI2tuIKgrULPlCXZqsQCBidAulmGu4QbCXSVUraAaeMrNW
	QQ7pjp2EYDZIGF4S/dWXh7/UX9PUmYoaX
X-Google-Smtp-Source: AGHT+IHPOGWQN7CQo5uvqH3maITnR7iEOg+MpVOumRq8qlMhfQS1/sDkbsRXe/C9cg/75eQhqbeYCQ==
X-Received: by 2002:a17:907:3f89:b0:ae6:df9e:736c with SMTP id a640c23a62f3a-ae6e10bbee5mr9312366b.21.1752072926801;
        Wed, 09 Jul 2025 07:55:26 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b600ddsm1116795766b.158.2025.07.09.07.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:55:26 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 16:55:17 +0200
Subject: [PATCH v2 4/4] phy: qualcomm: phy-qcom-eusb2-repeater: Add support
 for PMIV0104
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-eusb-repeater-v2-4-b6eff075c097@fairphone.com>
References: <20250709-sm7635-eusb-repeater-v2-0-b6eff075c097@fairphone.com>
In-Reply-To: <20250709-sm7635-eusb-repeater-v2-0-b6eff075c097@fairphone.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752072923; l=1730;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=dqwE+mgZFmDVF9ARQ35sDJJ/X46qouKrH+a/CF0hG4w=;
 b=lyt8D0KlGNc8UG/Ba5c6MpLOjIKEHZ2kTOawV2liOjxfTKc8u9Nw5YChPEsmez45eub/Or6uK
 TMYz3TmgQPZBVmIdMkPKcrbNwsoHX6fNfz3hrG8kiWbd2JZYNOLOxEc
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add support for the eUSB2 repeater found on the PMIV0104. There is no
default init table for this PMIC, just the board-specific tuning
parameters are used on top of the default tuning values.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index 61594739e5b12706775622e1f76af6ad5d2d29bf..3d4cdc4c18becd8efd5015e698b836ad4d7cf18c 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -82,6 +82,14 @@ static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
 	.num_vregs	= ARRAY_SIZE(pm8550b_vreg_l),
 };
 
+static const struct eusb2_repeater_cfg pmiv0104_eusb2_cfg = {
+	/* No PMIC-specific init sequence, only board level tuning via DT */
+	.init_tbl	= (struct eusb2_repeater_init_tbl_reg[]) {},
+	.init_tbl_num	= 0,
+	.vreg_list	= pm8550b_vreg_l,
+	.num_vregs	= ARRAY_SIZE(pm8550b_vreg_l),
+};
+
 static const struct eusb2_repeater_cfg smb2360_eusb2_cfg = {
 	.init_tbl	= smb2360_init_tbl,
 	.init_tbl_num	= ARRAY_SIZE(smb2360_init_tbl),
@@ -264,6 +272,10 @@ static const struct of_device_id eusb2_repeater_of_match_table[] = {
 		.compatible = "qcom,pm8550b-eusb2-repeater",
 		.data = &pm8550b_eusb2_cfg,
 	},
+	{
+		.compatible = "qcom,pmiv0104-eusb2-repeater",
+		.data = &pmiv0104_eusb2_cfg,
+	},
 	{
 		.compatible = "qcom,smb2360-eusb2-repeater",
 		.data = &smb2360_eusb2_cfg,

-- 
2.50.0


