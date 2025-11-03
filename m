Return-Path: <linux-kernel+bounces-883607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 899D2C2DDFD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053264207C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ECD32BF58;
	Mon,  3 Nov 2025 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ixb4czkH"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08B931D747
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197300; cv=none; b=KRdGbleTNgqA/X/sKm8nSX5E4erdf7vrYtuexnoDCdLejjdG1Meb5be1skdLbjqDKXX9P9JcREXMEzQDkhS2WmqKLxkGB5im6z9iq88y2OySkxSPStNnjsTUYRlgKaOIiO4K/vW0rTKW8hCeW3Jrkf0QtGqaMPOXO9kX3Ewgiik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197300; c=relaxed/simple;
	bh=2sTVmTa86pv8fJgdD5xjz3zgzXpYVywXrSd1pVhx6YM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6DqoyT2f1KuGenZCZ3J+WRJ/r0vKWtXq2gGM8HLWhgtMR4CgwyTwXH6rOBlPCfp3zdeokEPJsYNhAkDSPPmMtDtVIfBeJwIRfca8mUaQhkn+jrpyBj1fkoAVZgTYdQgiOyp/ONGVcUQR3FucWh9otaBtbZyxk+33iIxgSeReE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ixb4czkH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b71397df721so202827166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762197293; x=1762802093; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swaPnlZ0H028w7OC5FVRDI8/szcqshYIBFL4ftY69C8=;
        b=Ixb4czkHCp76ittYEZ60gpEpQMoN0MUKFJEh0y/qG/qRr4oCt0gHjh56+u4bzCj9rV
         d7IUlkOzUVM0D7mamTzdY1kTIoJFCJONBnkqhLa9m+YaDJyWXjTym+o2Zq1inP2VeJjc
         L7Vw/deuhmRQRP44YJL8c7IsgprjmpbGsJo2HdWGWwhO/auHWaia9owRMq8Y03CKFYOc
         CVINsRzDV0CYuQjuli5EvJoN5NAnwQ2VcBXRM2mfpjh7lYacJG/kfkWlasbPz6nYzXg1
         SzxEiOr4OErPXv8t1qgpR0aGmaPbXAbzxttGoqkC+YzO1N4I4OnHE9EXVR4G9esrJgME
         Cvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762197293; x=1762802093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swaPnlZ0H028w7OC5FVRDI8/szcqshYIBFL4ftY69C8=;
        b=lqUGc2rtieK03HUFKL2ZOfh1A4qjENYV4OFpJ0r/MkBnMqRSJuCyqofb1fzzHawpw+
         AIEfA5qItIOV5Ka9gX+yrn/aIRWnQM6R5egOvZToGhjACOviCbfDt10cjKF2v4IHimVV
         6ngswjgFRvIo3SHxJ4R7scAR6Hj/rOq3APVF/JDUO3F6ZOqh/OQ7nRZQKnC+uzycZkwa
         TTDIXrpnBdWF9S3OYboi7a2wp/UBnhtRUnQ5Tso9j0miW/aEPDfGCRZ+lxPF36xy+rZZ
         hEmmWKJ45djWFS7HKHWu4k2XzKoHt7y0tVnofU9aI/3v+nTU3fW+2qYK0kVl7dwDW5m9
         E4kA==
X-Forwarded-Encrypted: i=1; AJvYcCUXtrdT7lbQ3JpRJDTdmPfMrDT/IUAU2qyRBbE1WtTAjl6T4z6smf/y8eLgi+YDu2S9bYamO8ZSGPmACyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93xJEz4s/b7bckPBvBe9dkOxlyUk5Tmt32VHLysIZVUAmJj8L
	ytmWWUvVnDjgjqUamOo2wnEN9V/6SMLvzxP4UXbedm4DehW7T3G6/hVzP7itwpujgek=
X-Gm-Gg: ASbGncso/TE969wYU9EVv7p04EQKky/rPqCcK7FAk9UUidDAAZSzuY4MF6q/gJIY0Qx
	C9exrx/n/9/TwrWNCFU64i8OnIC9JOEMsNOtLj1yOxqovJavp0A3LVq+r9sip1IYFZ7+ZgRhglA
	KiTsoDjVVneI7IK0lpBdezAGwq37+NqSkioOVOyA3+Zs7LPehY1bOsFoqAiQLqD8Vg8RgdW1xUS
	NVtEpnSwIurOdhqjvPAtxCcy0zVuopUIiOouZAo1IjBxvru1/rcBc8V8yO0Hfy9EvPdlf3h2M5g
	QGHX8TipCVPJuukIQ3eJixY8fIBLnOzCnWudTDjSjbOSydgs+kIqm776S2Da4qMPRKC+D6bsX0U
	apdjFBeA9MkJKPOAPWW6nehPkvYe1hDhFKAIh8VfMjHRv8KkQ2wYLRcw8bs1dup3Lt+ND9AFcDj
	vH/yiygwVIJmVtp6E+l8YomF1oyizN2LSGAELI+tadGIUYGaWkWQlCDK30H5Bdo5NFI/kWmmY=
X-Google-Smtp-Source: AGHT+IHiNqxvdvsqsXOblsPDou25GeBmEyZiMxNTIJQm/CkhHutRBIYZb/OdlmtQUhYFXs6N4+W+Ow==
X-Received: by 2002:a17:907:6d08:b0:b6d:3a00:983a with SMTP id a640c23a62f3a-b70705ea59dmr1451359566b.38.1762197293134;
        Mon, 03 Nov 2025 11:14:53 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b9f29c8asm466765066b.8.2025.11.03.11.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:14:52 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 03 Nov 2025 19:14:59 +0000
Subject: [PATCH v3 20/20] regulator: s2mps11: more descriptive gpio
 consumer name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251103-s2mpg1x-regulators-v3-20-b8b96b79e058@linaro.org>
References: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
In-Reply-To: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Currently, GPIOs claimed by this driver for external rail control
all show up with "s2mps11-regulator" as consumer, which is not
very informative.

Switch to using the regulator name via desc->name instead, using the
device name as fallback.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/regulator/s2mps11.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index f19140e97b9d7a5e7c07cdc5e002de345aad32d9..3e9da15081e680d7660c60270af54ba2a4f8da1d 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -363,7 +363,8 @@ static int s2mps11_of_parse_gpiod(struct device_node *np,
 	ena_gpiod = fwnode_gpiod_get_index(of_fwnode_handle(np), con_id, 0,
 					   GPIOD_OUT_HIGH |
 					   GPIOD_FLAGS_BIT_NONEXCLUSIVE,
-					   "s2mps11-regulator");
+					   desc->name
+					   ? : dev_name(config->dev));
 	if (IS_ERR(ena_gpiod)) {
 		ret = PTR_ERR(ena_gpiod);
 

-- 
2.51.2.997.g839fc31de9-goog


