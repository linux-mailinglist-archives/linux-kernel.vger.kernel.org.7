Return-Path: <linux-kernel+bounces-844153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9511EBC1260
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4181634E4EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74DA2DA75C;
	Tue,  7 Oct 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3g79q2R"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778412DA74A
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835894; cv=none; b=nysbZZpI5TaQXlQpbFeRaeX/LG15/7px7OfCy4T71+FbvzO1ifkQ2rs0iPkwiJqVcRw5o2MA0Y3IBaxmf2wZuzO5PNAK9Z9GpK3T2k7+c/THNBYYhn6UNVbNsOaLQ6RZjTbH3rolw0VlJAQqp/BF28JAMEYMHn4lFcqrJWOpiz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835894; c=relaxed/simple;
	bh=EBXsHgi+TPtnux5Mjfvq3s8Tobe6+wN+A1W9K6WofCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGMopSM0PcMXxNNuoZ9e0+8VSqlVHLWZJwyLCf27dfxeHNm0aRID7EnppSxqGcDBVdbYKuSdbb+U1mvchVKrn/9ToFdXLVi+RNE6JaMp4jOe5y9kQa2GRjNXNhDE4zcHwqD/HObTWrUVhPXVDPQKuy6Bc+etg5Tui4FowKroH78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3g79q2R; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27edcbcd158so79429505ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759835892; x=1760440692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfRZW1u7QrD8wKs/E/qokjfPak76+Jqb1NI8oZKYmR8=;
        b=Y3g79q2R3sTwjmbtS6j1kGagio7GsvlTL3JjcMezmmd2BPDZXaSIh0wYudVsmWWL6P
         XnDZb3g1VeBi1JYWZzoeZC2+BG9nuqzkREQwpe/APIv5IwXMM9+cBuqoZwSzoOBkkYxT
         r8hjDnHNLhl0nshZ/E492MPsB4i0PXCKlXvf6ESDuBH+oEmzgGiq8Im0EjjVwIcrMNd4
         2AUPvTvdigr0WsvEpJRhvML+PWunikkSCvqNAbUEeDd+V0bbBr7iB2wv8TO7sjfnwhIX
         iFap+nohZedl2KAY/WcLCdYpG/GIJ3OCkfcwcjzDmeujsMB8b9oW3rfDsUIsO7cNTD5A
         vNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759835892; x=1760440692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfRZW1u7QrD8wKs/E/qokjfPak76+Jqb1NI8oZKYmR8=;
        b=kWgOzGJKfDQliVlST0iivmpcjfHWc3lY1SouLGO/Z7g+rODxUsjFUEMG4qf8XqiL6x
         BnUeteOOZVBzYyv2HpxgRGXAXdpwpy8zOXW89xCYixxxrrVJx5xLuX3B3ErhfwhIjdJ7
         GBsyEBmLLtG6gjsSRk3/Et7gfqSiUtD9Deku3FyOx9iTb0zQjc2eDAIJzWPmGcSFvq/3
         O8xwb/4jjsIimCl5q3QQorM5f2FeJFQe2/C/a7OwP9p58alqoPG2QuY7OBE7FI8MvumB
         tp5YXlXFPulAeQeogWOtftGGooCutBhiQS8uQ9YS15p7ZlS24E+aRIMrR82L1v3OpqA3
         XUJA==
X-Forwarded-Encrypted: i=1; AJvYcCViB4mXiOQn6rxOzH1r+W3AttII8cpQcZNcJsdQT0ixmUoxLn70yyCm3zPQOCaiFvg8SUcpbAJPoBJ7+Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbqDTk11m5z6PM5F1dReEIN4FV6uJOqGPjxwPOTG5Fr4Oj2HJ
	B38S66UNI7Dkr+yti/3ro/zAna/fULPFDiQI2yHacXC2QWZHXRKt/1+5
X-Gm-Gg: ASbGncszHSG/+bwVEsEg1E5A29Q3HoYc7hiedUlryyfswixRisKkeK8/NGjDMPO+yVJ
	+X9wI59EHmIVgy33WB5W/gU8F+GCbXa5KXvKzkSIBrf6ESyhhipP/vWOb778/I85xKCGO7XMIzH
	7J6I+9IJolQjfwYlFmlG5ShTNS0PN6ToZTXaT3039CGiyd/UYlyfX+Pr8AzATmjOH1SFICVZPKs
	2DOSQHGp1xamPfo6U2YhSwhxMOYcLL6dp4uHA9q7IRayMiDfjDpy2D7eZN8PF2g0QmBKReTElHj
	5kZGfnHX3iOhJdF5Xf3Pym2aaYmEdB2dymtEqm7j+2iOdPRj7OxMUnUqUFmF6pFt0kCWW5xZKOo
	85G/sSlX7UgdwWvJ/Q9ES8flxBMAsmiUXlbzcPt7YdPIaWPLvlIblQO7pQbMkaAxZPdusJCt7R+
	c8egRqe2wQ70nqJkFWip7xQNN/1YDY7le2iJ8pBQq/6A==
X-Google-Smtp-Source: AGHT+IGtobxlQxOmzElmeLrz6XbtLmYqUVeHEzRkuSFLIl/0CLj9uRwuwV2m/uCsqAKd9lcGvF8YVA==
X-Received: by 2002:a17:902:ef0c:b0:28e:cc3a:371b with SMTP id d9443c01a7336-28ecc3a3963mr25458815ad.57.1759835891715;
        Tue, 07 Oct 2025 04:18:11 -0700 (PDT)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d31bdsm162509045ad.94.2025.10.07.04.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:18:11 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 07 Oct 2025 21:16:48 +1000
Subject: [PATCH v3 07/13] mfd: macsmc: Wire up Apple SMC hwmon subdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-macsmc-subdevs-v3-7-d7d3bfd7ae02@gmail.com>
References: <20251007-macsmc-subdevs-v3-0-d7d3bfd7ae02@gmail.com>
In-Reply-To: <20251007-macsmc-subdevs-v3-0-d7d3bfd7ae02@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 James Calligeros <jcalligeros99@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=744;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=EBXsHgi+TPtnux5Mjfvq3s8Tobe6+wN+A1W9K6WofCg=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDBlPvm1dVi8Ud3Oy5Jr9b70ezTox1bZcTX7RxhNtd28es
 6nxv3nxUUcpC4MYF4OsmCLLhiYhj9lGbDf7RSr3wsxhZQIZwsDFKQATWanJyLC3I+z5shiFivn/
 fhV4mitU2Nmznvq/6W5DGuupxz6KdRsZGX6JH93744nU5dT2JfGTeufsYWn+etDq6ZXeTB6t3T8
 s7TkA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

Add the SMC hwmon functionality to the mfd device

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 drivers/mfd/macsmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
index 500395bb48da..51dd667d3b5f 100644
--- a/drivers/mfd/macsmc.c
+++ b/drivers/mfd/macsmc.c
@@ -46,6 +46,7 @@
 
 static const struct mfd_cell apple_smc_devs[] = {
 	MFD_CELL_OF("macsmc-gpio", NULL, NULL, 0, 0, "apple,smc-gpio"),
+	MFD_CELL_OF("macsmc-hwmon", NULL, NULL, 0, 0, "apple,smc-hwmon"),
 	MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),
 	MFD_CELL_OF("macsmc-rtc", NULL, NULL, 0, 0, "apple,smc-rtc"),
 };

-- 
2.51.0


