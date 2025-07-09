Return-Path: <linux-kernel+bounces-723535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBCFAFE82B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3E34E479C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDA82DE217;
	Wed,  9 Jul 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="p8rJVdMv"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758212D7818
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061614; cv=none; b=Pk9To3Zlx4POxZyofZsAThpCbk2labXUFv1qxRJOvOYmeVZmga3TtVNOyen00UC1iMfNa9o0zNJ/2aam7TEzWormRZrhSo6Y1bvKIhrgC03CLIzSCJeuV5uuMLsXWEooRZ47ED0E5p6q/9cDiMC9TJRBOJom1AxMEEj9iA2ZIiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061614; c=relaxed/simple;
	bh=q0f4Kt7CB4b+gGrecsM4LRgCLVf+5IH0ECZJniU0Rsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=juqN7Y7oXX1f4KGK+Is5XryukKf7JZmsrvPORFQji/LL/sULm/jkQz/GCZoLNIzpxMYaS5klcMXx8NMGLnaWV/QKK3gZkDB/j8L2x7zvnz0+0+YyQN2qkSslVDUU5HDMK6PTHu5pdHlXbnZeQND8mT+inLdCWfm+in0YxbP/JT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=p8rJVdMv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso9756551a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752061609; x=1752666409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mqaqbmx0aerFIcDameI20v5fF8h6z9wFPaN8VWktnrY=;
        b=p8rJVdMvQqD67raf2TgUtXlA7ZLdTBcyLrQ4CCF4cOj8UIq6S/Y0SYJPVaZnf2kdkB
         /8Ov6vbmgDl6dn1F85LaR0mA9V2QeaqYdtOffSN8Y5H03HaoOKblgHpsw5VzveRzi1Uc
         tRzeM+X1Fzi7My+hGQzGOCg1LwuaHXJI0JACfIwj77TIeyc55T33+UiXzEkwC/0S+uYF
         32G+/XlO9iXwBliesJUur6YRBI/PRw9OcV6SeOvdXqPJr7MCbjd8EeLBjnHLMh2oTEei
         EEom6mLKUji5guo11YFku3GFZ2hM/Bcwjm3PU9seRzIwDbUFX4C567Oir0a7pqf7uRr+
         89Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752061609; x=1752666409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mqaqbmx0aerFIcDameI20v5fF8h6z9wFPaN8VWktnrY=;
        b=M+jwzVyhkrjvUebzcj7ppJrz+YjvKDe5FCkRbgf/ZJ2eAH896Y3JgwjzDHVpVPQXzT
         zNBbT47gz73YoQ0aIsWvK0E81ph/lzsPz5ET6MyI4Rji4RSLshaB4UbFzugglnhl5/dc
         OH08C5hipjV2NeBBUShTONSHvVwDb1KO2ZzmKQYlHF8kKYURnGL6hFOaKSO2CAswXCem
         B32LV5oS/zKj+rJ5xKk1skc1QdKBVOKCrnho8lFrfnFt6wRZMF8ixK9h5QRrr+JcrFc6
         3tDryVeiXWBQ8J38NdNbQ0wYmNyiC6Cq2KlckZBYGyG6C+khc9VcMwCwfVd2j5hHu3/m
         qkPw==
X-Forwarded-Encrypted: i=1; AJvYcCUCGj7CR/zz2Q+kobTj15kKoev9by1QgAxEUHEkpfRX7Dq1LMv0v0RTvEW18MAn3NLFaaFi1X4lhD+4eaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpweJILg3/SCMR8KQbtMzQDHMnGARdeN+0jYpX9QxO1UNUN0bu
	WiixW0CN5FuagCRj4VxvYlvPb1VR01C1X+ExjX/j6IC5UhVYmSxklZKWQyk+Ae0tStI=
X-Gm-Gg: ASbGncv7BZ7G/hQE/doA141d2eXmFrwa7fX41BTIkhUyUEuQ04Dz2axVlnFDH6dePq0
	/kT63hRP7HYyccW4hMc4UcoxyMekVLg+mZ5PNV9JGIrkbYyTbdvBAYTCCbVHJd73YRCwEe5pax0
	iZLakxdqH9d0WFMVyWJ6Ff5a5aQ6IkXZgdnJyLLRQ+40CK+yKckTI6yOcaw2Mh/gujYczfm7gxE
	D3XD0MaV5YbuD2FFHt/hJbHm/ZvaqDyhapuX0Xv7j7/nFGl/X/0uVifgKEcgNWYWbe9bZuDrXIV
	hzs3qFokmTrtI2Ce/q1qiY84dLkIGnzM+Ws22Yhgu1x4Exy+oTetRrZOuodd1ZZXR2yAJxIZVTd
	Oku+/oHvObYAg1xzqFU4Y0Agp0spkMKAf
X-Google-Smtp-Source: AGHT+IGe8ifQK3zKlm/INbNEzwNqGtIX1dU/rXl+zkSfPoXCoNmj/1eNhP01t/aTJ30bcZIwFGeScw==
X-Received: by 2002:a17:907:a42:b0:ae0:d78a:2366 with SMTP id a640c23a62f3a-ae6cf64081dmr276746366b.4.1752061608819;
        Wed, 09 Jul 2025 04:46:48 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f692e4ecsm1102995266b.55.2025.07.09.04.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:46:48 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 13:46:35 +0200
Subject: [PATCH v2 4/5] pinctrl: qcom: spmi: Add PM7550
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-pmxr2230-v2-4-09777dab0a95@fairphone.com>
References: <20250709-sm7635-pmxr2230-v2-0-09777dab0a95@fairphone.com>
In-Reply-To: <20250709-sm7635-pmxr2230-v2-0-09777dab0a95@fairphone.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752061604; l=1016;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=q0f4Kt7CB4b+gGrecsM4LRgCLVf+5IH0ECZJniU0Rsc=;
 b=WK2/spcTGkOFsA+I8ICoknzdQfJloKrmYS1KluZTLN+wJZEx6G2GjwtphGdFhyMYagAJEI+dy
 z9OsIl9SHyIA8x8M1W+KJQK0AAL0iP5G0eSLD+npYZDzmIPE5SPQ1MJ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

PM7550 is a PMIC, featuring 12 GPIOs. Describe it.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index bc082bfb52ef480941e1804f1142496e1db6413a..da62eadbe1e97bde0bb56db8c07182ad5c6a4162 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1206,6 +1206,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm6450-gpio", .data = (void *) 9 },
 	{ .compatible = "qcom,pm7250b-gpio", .data = (void *) 12 },
 	{ .compatible = "qcom,pm7325-gpio", .data = (void *) 10 },
+	{ .compatible = "qcom,pm7550-gpio", .data = (void *) 12 },
 	{ .compatible = "qcom,pm7550ba-gpio", .data = (void *) 8},
 	{ .compatible = "qcom,pm8005-gpio", .data = (void *) 4 },
 	{ .compatible = "qcom,pm8019-gpio", .data = (void *) 6 },

-- 
2.50.0


