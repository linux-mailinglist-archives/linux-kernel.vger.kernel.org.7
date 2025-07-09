Return-Path: <linux-kernel+bounces-723493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E819AFE79C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B370E16CF1D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AC12D5A16;
	Wed,  9 Jul 2025 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="nsSYil+T"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF9291C0E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060163; cv=none; b=hLPul+EhqgaYQ/mItIvcWVO3xCUc7n/Xmdp1kE+PgRhMZCPQAkZsEKu1U7d3gVCVTtlR4vnD+znS1qm0ez+by1ygXCl6hXs9rOPctypAeD3B8suozf4SllOKBzyiGzKlF1igwcRg1/tePmh4GkufpRaeJ22f5IYFrJOFD4x6NU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060163; c=relaxed/simple;
	bh=KV/da6xIzbVHrhG2xY2P4IEV9DKl1AvKU/5Rm5fhtk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ayLpgZbxiLbAcVCBuHZii08regYW8wcfmASwg6YY4c8Q1gAXkBabe7zC3U0EpVPaSE8TpeeybU3eVHQ1TIX7DU2vx6tOA7eG+iSZBZkXAytSxdDTojzFd7oYrfGUuzqzNjIEatm9JfH3TMz/bm1Ri/SlDJkT/y1ow1x5tRr7DTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=nsSYil+T; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c60f7eeaaso8227331a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752060160; x=1752664960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fK4ANoIWktsPShrmwGNUmQluv7mHl27MCE1eB8EJFoY=;
        b=nsSYil+T1Qd+O8Yt+BgQPYU4/pXrNW87XRBiUvhOP7R1BgXf1MekOxNCzLVQ39T2PV
         /3lo/EksnjEd1xrQT+N0T1WzuH/f6MTp4oP2pcapKRqJc2YpE4HZ01deUgJi5VvnWKSN
         mX27EK1cF+NsUlwoLL5+cn2KWPquNA4xhVF1ufNBXeIEkjP1f6INasEUVSpv8YHrlnLg
         rYDB+Y7a/zELato6+MJwQsd3DjIo+oiY7KidqSjp6SmIgAnJqL+PWOeKVF2ZkPEXe6Hg
         +i+GNTJkBt6kC6jKvd+asnO/wx1gYoL4l1KoD/3IgNRwTef0S+/InMUCaO96A/IltwGx
         LO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060160; x=1752664960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fK4ANoIWktsPShrmwGNUmQluv7mHl27MCE1eB8EJFoY=;
        b=fu0MVhQg7s/i40eutEAtISrYrWwNSS08FrKlEvSChTQmwKRojICHa4jbMc7lQqbPes
         vuvAkZsLEIk48vZRFiTYawDwuM8ZBsEV8F0n6ASucsP92kFJEbeWzge7rOcysc1ZEsVW
         hBRXfu1AZcVZpFB4mowgIJdbwU6+l/BNVjliosfFQ/pPmlsNI+2JxRX5YkYcbbetez5L
         xDlymt+CRcmK0E634xsT2LP2rUmEy9iHXe0B1QCtf+jedLAfdf2hZiMmNbCvXXQAPJz2
         H27ekps90seUqmI2lV5dEtCtdsxVBvhTDZysl3oNsHr6Mw7IfdpE8u+IZF5hjfUisWhW
         cyow==
X-Forwarded-Encrypted: i=1; AJvYcCXNiRaQOXgJKug/+eef1o+2tE40YfiWGS0poASwmuEPMBUoSQl5fN7VI3BL06tZ2ePX5EW+SndNTYX9RyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwv6B64gCgtGes3rK7enhqucC8SRLSh6yDX1r6vqwE/l4Qxlg
	C2lI+IV0g+5S6H6/sH7KeU+IZfhpgaazrACSTDBmAKD2MQ79NtQCR+8a0mazVMHwabQ=
X-Gm-Gg: ASbGnctLz75sPTVR9emNOHX35X5JIq3gRoyVq6fet54if6tcxch1KG2/ceUTA6gtbfz
	LQu7KNXXxV4arF6GcUzxBNirPtG4fp1YmAw44leR7UXa9VNBubiG1XzqXcQSmsjatrqFGrMg2kh
	NqI7AIaIvVEk0hKrONxTL1dxvSuzozGFIlqqy/iYAzmlTuoi4zLU2rTZTF8d4SF9q9NaVFH5P00
	HWSThydLYkt0jZ/FmKroMqAmx8xHNXSHU3Iu6b7azjNS8f71A4cR3tb6R0AnVIV45r9fWxHqSFt
	ffmAvExuXVE5jaMReWzvpLiQQtqlcw/o/0YjmHyG7PNRNksxZK8tG/m/x/6AG15mDtek8Zr1R7A
	SDC2xOLfMyl2esBy7AvwsbB/XnWIwN0I9pO0/IxfjnHY=
X-Google-Smtp-Source: AGHT+IHZxwLmYMHgjDd4zGI1+9Hd3ISiMtfdbCFiwSyXc9F1royVFxYLXpMSuKapmOzkESC7IF979g==
X-Received: by 2002:a17:907:6d0a:b0:ae3:6994:5511 with SMTP id a640c23a62f3a-ae6cf5d76e9mr268843566b.16.1752060159608;
        Wed, 09 Jul 2025 04:22:39 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d93basm1079861066b.4.2025.07.09.04.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:22:39 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 13:22:28 +0200
Subject: [PATCH v2 3/4] pinctrl: qcom: spmi: Add PMIV0104
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-pmiv0104-v2-3-ebf18895edd6@fairphone.com>
References: <20250709-sm7635-pmiv0104-v2-0-ebf18895edd6@fairphone.com>
In-Reply-To: <20250709-sm7635-pmiv0104-v2-0-ebf18895edd6@fairphone.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752060155; l=1096;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=KV/da6xIzbVHrhG2xY2P4IEV9DKl1AvKU/5Rm5fhtk4=;
 b=xXytyaef40ZyvPrSPOwWzJfwNcIkMrPdQjGb0A6tTQU0ejQ5IAIsJ0UY+yU49mxJVPhVCpSQq
 rA33o/OJcXeBDA04u4TVHfK+ujFJ9Ntn6/I3J6W7oVdYHSKos4UDQQb
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

PMIV0104 is a PMIC, featuring 10 GPIOs. Describe it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index bc082bfb52ef480941e1804f1142496e1db6413a..40de5554c771d0c034a458fb4d5e8876473b391c 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1244,6 +1244,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pmi8994-gpio", .data = (void *) 10 },
 	{ .compatible = "qcom,pmi8998-gpio", .data = (void *) 14 },
 	{ .compatible = "qcom,pmih0108-gpio", .data = (void *) 18 },
+	{ .compatible = "qcom,pmiv0104-gpio", .data = (void *) 10 },
 	{ .compatible = "qcom,pmk8350-gpio", .data = (void *) 4 },
 	{ .compatible = "qcom,pmk8550-gpio", .data = (void *) 6 },
 	{ .compatible = "qcom,pmm8155au-gpio", .data = (void *) 10 },

-- 
2.50.0


