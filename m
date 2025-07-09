Return-Path: <linux-kernel+bounces-723947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38083AFECE3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7429717543A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F6F2E88A3;
	Wed,  9 Jul 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="G2/wTAhW"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B111F2E6D13
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072929; cv=none; b=mMOXcmH0OGpPdnB4RAso7WUZ3KLU50Z4MoPwyE8kJcyskt/ES7R8VFgu4AqfzTSyr23F0N2MeJVdqYeZknxVNnGlYJgNk5ezdLN+Oo8TUYM9/xd2yrqxq9lE2LgV3oF4OxClA0tGWadX3Qzr7IX54oPklC/1HQ2lmADBkxcaQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072929; c=relaxed/simple;
	bh=JjK37/7ou8Ub4yuQzbdrYu/+a8HXwLFQlJ7GCGIoSKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uf/7mP0Lmqj4YK1mcht5MEpCt9LIrItREpU/gxpNGI0QtBx/5nIkM6OKJfAQ2jwVLY0a/WgY/8nvREwvOg9PazRX61nRDRccOfuoyL4jWMOKaboIl9Lr9eFWJdS7bVcV6bU2G/BTA4IbGOJ+Ut/KOoUHR309Pe2VfALFD//z144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=G2/wTAhW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so8471417a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752072925; x=1752677725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqUnckrV2DHR0JIRkRD40uIY/f6Qb0J4rvTjJoaYqS8=;
        b=G2/wTAhWzSamOvQZZmw1tZalAIExmzLA92jJ4s96G2FxsX9D6IDLry+yOxzIPIiFkL
         cpbEwPnisAa89f0FULNEFxVtHK04GId/bjyb5Ith3GQFCmxLbYDXc95xl+RCwGM88146
         teocst8VOAlfrJPyLY1nI4IRSLz4MnYIHUJ3sU3/WN3qrXAgb/WVEkY0ppQsjAcoQnx/
         wMoVGaAhUVOV8Mc8+CeO0SKGSZrtll7RWwZrjUniH5mlioCtIKj0AukzKMcY9hIZOqvZ
         ZC8ub/Epl9gA5wnH1dp9L3ggx0a8lM0VzhxyxW80sSRC4269Wrp+YXAe8PbmeQJg2mic
         Gb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072925; x=1752677725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqUnckrV2DHR0JIRkRD40uIY/f6Qb0J4rvTjJoaYqS8=;
        b=uhDoQMoWhUOntMcD8jpsRnjW/x3zCv4HdSydTe0mKCc0VMitvFGDg5ufnveZ03BYL+
         /8udLMmQiMGJpkQLwY0FnpC8UOHKXBcOFqyNYWmxd4JhItPbWpaO8OaDGZ+CrX+2nkcO
         AGkzzW+yfO2INd5mBjQ0nQsHMMbysdmcDPoKBclfVkV4OFIc5qxt5QF3NURJlT4Oiybl
         cQf7L6BlW8YjbNYLQMfsfcE7B77ivxIsHMOcDUWDoxDYm7QmJ0zo8gmPmxBViXuCSdDd
         8xpV53+X7nw8wE/HFPQMpte72vw3nPDqDxy2W3yKFVr8mQEPQrvxkMGt9iJclNgbXAOJ
         kV8g==
X-Forwarded-Encrypted: i=1; AJvYcCX4uJSPP6UlqaUKhn3gg+W27pGsYaS9ft2liiG+yphFDIKf4MPrkk9G+SJUcQHBHiZ4yfOvS6ggcM6Ppf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/6lBN3MxKwft+Jw9D/SXcBhN7SfxaA6vW/MKGq8Ix+8ku0r/D
	q2KrdGKHOeEP8bw/mZfSEVN0K5TIj8JBpfy8QNsuh0tvs0arQEv5Zmx1LmtoffHNU5I=
X-Gm-Gg: ASbGncu9HKu5zTLK+Zp39QA8xLhJQSiaEF1mYOyMgPS0yLPKkFPUpr+yRQ+ub2kCdLJ
	kcw2DwBoHH0rFsQVZglGykE+jdy5g08b/gqPrxv1+0Cn7msqh6yB32chpyhpw9lvABaYJHJmgnc
	R1oi09vATe8kwVyihRlVRjZ8wIKTYoCJuCdOSLTyDU07BrFGPQnkOqwvDuNs2ZHsSALJ4WYPFdW
	KPk2GKPuB4RwIwUXVGwqDuvDFtdn6aQ6VVL2oZMGKOPzRmM8GXuzsQEP3M2S3ZZLFimZ+Xox4ms
	bQYiXG4CB8waQvdRclnb2vK50wX78rzqEHXPrqXxuefq2OJILPV/P9QFCO7bBzF+Xs1LrsykzO4
	jb9MVfDPXnSlT//Fiz1/52dWKRi76FRE5/FD3+E5Ly/U=
X-Google-Smtp-Source: AGHT+IHYj4k/qDDYaJjD9Pvlt5hW+aGvDzyWD8yDesgLcfq/4kuKmOi8Z6ujnsY58oHIu98v8zVcqQ==
X-Received: by 2002:a17:907:ea6:b0:ae0:c976:cc84 with SMTP id a640c23a62f3a-ae6cf6128f6mr309110666b.24.1752072925389;
        Wed, 09 Jul 2025 07:55:25 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b600ddsm1116795766b.158.2025.07.09.07.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:55:24 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 16:55:15 +0200
Subject: [PATCH v2 2/4] phy: qualcomm: phy-qcom-eusb2-repeater: Support
 tune-res-fsdif prop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-eusb-repeater-v2-2-b6eff075c097@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752072923; l=1187;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=JjK37/7ou8Ub4yuQzbdrYu/+a8HXwLFQlJ7GCGIoSKo=;
 b=a4O39biLPv1ckqefPreNqneOFtzOmXRAtTy90P3R2Po9bjTLgvaXw8O0srrHGpicIbkBCZwtq
 GMA3OKt/wNkAXcOlHdD0WJfhA5Q0vh5eGp6Mfjp75rWf3jKut3x0cbF
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Support reading the FS Differential TX Output Resistance Tuning from
devicetree and writing the register, as required on some boards.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index d7493c2294ef23e37e484019a49ddf7b3d6a6a46..61594739e5b12706775622e1f76af6ad5d2d29bf 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -136,6 +136,9 @@ static int eusb2_repeater_init(struct phy *phy)
 	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &val))
 		regmap_write(regmap, base + EUSB2_TUNE_IUSB2, val);
 
+	if (!of_property_read_u8(np, "qcom,tune-res-fsdif", &val))
+		regmap_write(regmap, base + EUSB2_TUNE_RES_FSDIF, val);
+
 	/* Wait for status OK */
 	ret = regmap_read_poll_timeout(regmap, base + EUSB2_RPTR_STATUS, poll_val,
 				       poll_val & RPTR_OK, 10, 5);

-- 
2.50.0


