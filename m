Return-Path: <linux-kernel+bounces-714168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A26AF6422
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 23:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9BD14A865E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 21:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5EF23BF91;
	Wed,  2 Jul 2025 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="R9bum3YR"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB6A2BE623
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492230; cv=none; b=JpIQGqas58fzRqw6PRWmO8UuBS6zq6lDtQ72WxCBmnZBYl7co4ny7JCLpXR07KtZwVmw/FVci7uyacvWkcFh4WAVNrf3g+JTAXAkIlCldh1KjfeSDCV2I1V3HOyGSQP5yuH6qIs4tKuQG736ifODfg1qFgKv38XhVYAcINAwM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492230; c=relaxed/simple;
	bh=WB/IrpIB/wfBJbu5dFJUlcKQY59F+HJ0MTfMkd8sfQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGKeYL3NRxrv0OPlRVuQIXqTw4hW2/a3MMXgplIXBpSu9j9R0HCQQM2WY7RJ/KolnRhpBY2WqvRjsi7gFGC19Bk3lXY7krp6CgxCeoSFFLFBz2vajMKe5Q5kGi+6O2Gvl3uXJcALZok33EmJQzCOU+/wzryjJwJYbgmygX2N0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=R9bum3YR; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso73516706d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 14:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1751492227; x=1752097027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z77tQyjzfW0dcmF8i2CALNcRi1lkFInteyFHSr2VXyM=;
        b=R9bum3YRUI7UInsDEmkEa3gyb9TT9B94Yfr7hlcPcUAUpwyqK25pNA7A2mDwoMoHkZ
         B7YiQbmaFJ2j/9clB9KfnP7Cqn16jpzk2P6ajpLyg0eYANj9LAxSG+fL5Yd+IbxPI5RG
         5fzMgo/ApASZ2NoLfHfH6rBd8E5fVcCZzzZIDpmnEDTBvh7pfrIQBphyTkvUeKj7VL53
         XjGJVoXX6HgYusbCikekUfoDDEl5j2bP72zwrfH70R5heoX+SoNWNlnHI7cAlUqv7wHN
         zrzARjvhn4IwbfObJmVXZrK+zMUF8X2KjgT1yB+BZD5h8VmZHbacqd/I7rZum/ax/Exa
         SI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751492227; x=1752097027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z77tQyjzfW0dcmF8i2CALNcRi1lkFInteyFHSr2VXyM=;
        b=BA+q74g4ca3Wgcg4ojan8rc+I+kBSwKHUIC1P6uOMzgaZ/jK4kYwG6pyUZkCheRFAx
         UCmyWb+crZEEBN9O3WW/w+Qaw6yuGplMImtKHykDQYzLhM4vJGnGcYKyRfyz2q/6l7Y/
         udyBdBz/CC2mCAHtjZuogcw4rTR0Ahjw5alcMeVp/4XUGVlACqhr3EDXegQm2TlGqYfR
         IegaRcrSPVi0II6SMyOoEA2OtIXJBWzNf0BYmaJx0djWbDuEd6kRl7Y7akPMKP+t0XRO
         iZxw7luINjtYvFqpLESpLA0rcek4ziNbkOAIxzdaohUBJU4p1nV63foe4XbcwSFPz35b
         L3OA==
X-Forwarded-Encrypted: i=1; AJvYcCUiCUkzkNJmattPPB0Ofq8NALkAXsVCZlLKLsAQj5OBZ1E29xsjgXhAYy1A9mYxdC1B7B0Td7ogq6bdLPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfcznTPRnztAioH3OKJB52yvvhjYeBcxITXsdfXIA2UOHoqt5A
	ihtYSSGoWeRAgPw+b8LlV4h9ZI4Qrnv/MrdLRoZSex29dgwQ7+bL5UN80oe9Km7qQx8=
X-Gm-Gg: ASbGncvJuF0vVxNz8TiXJHWgCdfFrtQeEvy8BonnMyWgZW4ziwg6H5rdWjc5y8y7wwA
	5zypQ3DpOpEwr+6pVsfHs9J2MA4+jRxnTquCr81D0HR/2HSBUB1jN5tLdjxMooAMQHLErsUC4as
	aie5lgBOpewonytdHS/XYegYLGBfDpQVbnex6ir0JlJeuGe7GEj7rKVDIVdZa9N62W/3teDeXu/
	T/AIje+Qp/qnOvljIUZD1eHgaDeYGmYu2QEpQlLdJ50Rhhci8BodAWrm43qgVyCGg0HWbi0Cmim
	6MAHpVr+p1+u9KHHVw9l733txQ2A9WZNpBO/ooYmznODhQCnBX2CUHzoWST90rntETditnwG3vX
	JizvGj1V2iY7QGFQZV31Yxwk4X2ViSXzV1bk=
X-Google-Smtp-Source: AGHT+IGRObx6Rpk1Zs9IQPZXVPL/wda/SaVAzAggTxX0GxDaBqWEjwz2sqTqj864Fw46dZI0C1TGsA==
X-Received: by 2002:a05:6214:2342:b0:6fb:66cb:5112 with SMTP id 6a1803df08f44-702b1c1ed54mr54743616d6.43.1751492226919;
        Wed, 02 Jul 2025 14:37:06 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771bc01bsm105691746d6.40.2025.07.02.14.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 14:37:06 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/8] mfd: simple-mfd-i2c: specify max_register
Date: Wed,  2 Jul 2025 16:36:51 -0500
Message-ID: <20250702213658.545163-3-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250702213658.545163-1-elder@riscstar.com>
References: <20250702213658.545163-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All devices supported by simple MFD use the same 8-bit register
8-bit value regmap configuration.  There is an option available
for a device to specify a custom configuration, but no existing
device uses it.

Rather than specify a "full" regmap configuration to use this
option, Lee Jones suggested allowing just the max_register value
to be specified in the simple_mfd_data structure.

Signed-off-by: Alex Elder <elder@riscstar.com>
Suggested-by: Lee Jones <lee@kernel.org>
---
v2: - Allow max_register *and* regmap_config to be supplied

 drivers/mfd/simple-mfd-i2c.c | 15 ++++++++++++---
 drivers/mfd/simple-mfd-i2c.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 22159913bea03..3f959f4f98261 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -33,16 +33,25 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 {
 	const struct simple_mfd_data *simple_mfd_data;
 	const struct regmap_config *regmap_config;
+	struct regmap_config config;
 	struct regmap *regmap;
 	int ret;
 
 	simple_mfd_data = device_get_match_data(&i2c->dev);
 
 	/* If no regmap_config is specified, use the default 8reg and 8val bits */
-	if (!simple_mfd_data || !simple_mfd_data->regmap_config)
+	if (simple_mfd_data) {
+		if (simple_mfd_data->regmap_config)
+			config = *simple_mfd_data->regmap_config;
+		else
+			config = regmap_config_8r_8v;
+
+		if (simple_mfd_data->max_register)
+			config.max_register = simple_mfd_data->max_register;
+		regmap_config = &config;
+	} else {
 		regmap_config = &regmap_config_8r_8v;
-	else
-		regmap_config = simple_mfd_data->regmap_config;
+	}
 
 	regmap = devm_regmap_init_i2c(i2c, regmap_config);
 	if (IS_ERR(regmap))
diff --git a/drivers/mfd/simple-mfd-i2c.h b/drivers/mfd/simple-mfd-i2c.h
index 7cb2bdd347d97..706b6f53155ff 100644
--- a/drivers/mfd/simple-mfd-i2c.h
+++ b/drivers/mfd/simple-mfd-i2c.h
@@ -27,6 +27,7 @@ struct simple_mfd_data {
 	const struct regmap_config *regmap_config;
 	const struct mfd_cell *mfd_cell;
 	size_t mfd_cell_size;
+	unsigned int max_register;
 };
 
 #endif /* __MFD_SIMPLE_MFD_I2C_H */
-- 
2.45.2


