Return-Path: <linux-kernel+bounces-844283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D088BC1733
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEBB44F60A0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AE12E0B58;
	Tue,  7 Oct 2025 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtYhG92/"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329671DF982
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842918; cv=none; b=QLlb6im31lSF8+elRtGzu2oVJTFIwUXbybLYL1qEp6/kf8HswgofBZnvWNtysy9mCaPMv5XNjnr0tmXcXCReLmZsEdt01+zoM3oQ7PSHCJoBkxVavtvftWvYKUyIjv9/k0AXnmUor6Ex+M871JrK4LxeHEjwa4xT/WREZ2kQ9oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842918; c=relaxed/simple;
	bh=D+RG4BiNmosB4POjfo5LyZOum/XJgmmiebmEbEc+9XI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hj/hT5HnR2yVv/+ue4+wwGFH1Ae/EMBILUctMYobfQgYGB/nE0RGs1p58qCqRUBGjsIuDHcjqAzjVHwEnywgKu0cRJSA1IBRAotjg34cTZFlCRDvOJC3Jgeszw5zoL4JxMYMOvVujf/XmZlm2S/kudN1BmW+7QaVQNlHrMnAPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jtYhG92/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso8255059e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759842914; x=1760447714; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUbAoZOe38I1qyvuq3YPis6MKfGdcvZ/5XhukSJlpQ4=;
        b=jtYhG92/STiFn3WW2RZSkO44l3Z7+1NP6av0sUM1yAY2l5ihrqUlNVYbIsAw9kDXVP
         6RKVzMWNhGCZUDNPrS8fglDY7t7W9YAH25jc3XWEvDYKHrN5xl8o1/N6qPEqI9wD8eUf
         7SRlwkdiVxuYbd6++TCYOykeOX5llqm5QefdSh6HwGaNrNuY7+uxRhValZxtY7HZHIOJ
         OnumG7WBRutuqbr4fylSC1iOpFwdZTNLvx80UcCOwa44BYeGOLihy0/RvyDtqtOkTSS9
         CtGde1HSV+tLqqDG2tGf3lopcKEZQBcaz14dov9r+GTRLpOlfiuj2z3qGbT/aQ5DJuZz
         k1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759842914; x=1760447714;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUbAoZOe38I1qyvuq3YPis6MKfGdcvZ/5XhukSJlpQ4=;
        b=SjdW1nWLPZm8C4e5hGfhGkRD6TQO9mEU8TQXV6tENBHpwOMX7lEa/MCJ4wqNSp29bL
         qdtBMblhIUakgYefD2MyH4Ea9vX2EboFYwOWhf9rU4IwzJnLQqVFSECLay7HWQnBgsPb
         ofitfCpc8KfE6sCIMGCsUvjn+Nr6O8cOGZhzdZ9gWTKD6zEiTsf+6+0Uo9b8yV45NYpA
         ik0MwqPa7CwAxgG42icWlb6JZic0RitI7RqAk/+g8t5MUJtTx0e4XfkN28B5U/ocbOLu
         VlLKx5b6ebPYVNViVginfNK4ya0El7CJAxOA+iX6j3zzvqYd9y0VM12aFQWXYUpxDCpf
         tpLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtuIPGnFga90RwotsCjNTTxLSnY3JVP87BwpDesKiC7AmhtdS14Sy2R6g7o+XYRl9telW9R3jYf2/8Tvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwstZLEo0ysnp+wSoGSw7SqMEvpXki3ZXFTaXbnonHB5SaxpegM
	64syoSTKpmWN1BNJKAVrkXkVe2ZzpIgHvLwSJryrHSt1f6PGY2FnU/lKpTjJGaJiuYFghqnZslp
	eO+fB
X-Gm-Gg: ASbGncsV3Y2pz2uWKkhO/2cS2KY68C9iL1g3GlqPgt5QwJhRpQsfHwru+4ZPthzKN7g
	pqiVkQGK0t9BMZZ7+kkCcbarL/bG92io8xuPZtupdM6DJhfKCfG3OKk4KUq/8eZmJ9u1pTJfq1b
	rD37mE9ZR+v+2lLo8r0P0DQdbO8wvPALCGQeaaN9Rid4GO2LokHjDtHCKCDL12m2geGva0Pp64Q
	WHohiiC1rSEiVNqto6yWpxpm7FsYLlxe5/9skKSP1xCFXQ0K3ZqUBOklCG7aS/E26JvhywrrKGV
	04c/Om1oADpZf2H69QArPwG4wgcl0uQD/7ZDiC9FN4n4ncEYOXYowMGBVPpHyTFoxq55Jah4S//
	DXp6fcSb75ciw91TwyNTCP6HL/NkHCsUJa+6XM0XdeR44C2NMYzQmEDZrmLHoyQ==
X-Google-Smtp-Source: AGHT+IFRoxaQc91a4B+h8FBeLlnS7vEr4OlnwDY4Hm5RxPgJYcQA/8Qq0ahvJnUd5oMpNbBS7Evoyw==
X-Received: by 2002:a05:6512:1195:b0:57e:a78d:fe33 with SMTP id 2adb3069b0e04-58cb9d1aca1mr5868647e87.17.1759842913864;
        Tue, 07 Oct 2025 06:15:13 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011b120bsm6070604e87.129.2025.10.07.06.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:15:13 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 07 Oct 2025 15:15:13 +0200
Subject: [PATCH] mmc: sdhci: Stop advertising the driver in dmesg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-mmc-no-advert-v1-1-0e16989d28ef@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGAS5WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNz3dzcZN28fN3ElLLUohJdizRTMxOzZBOTlBQzJaCegqLUtMwKsHn
 RsbW1ANFVDiJfAAAA
X-Change-ID: 20251007-mmc-no-advert-8f5646c44dd6
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

As much as we have grown used to seeing this message on
every kernel boot, it does not add any technical value.

Demote the init banner to pr_debug() like other similar
messages in the driver and drop the copyright message
altogether.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sdhci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ac7e11f37af71fa5a70eb579fd812227b9347f83..001802a3aa202c4d8f185ff4924838579ee44c4f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4999,9 +4999,8 @@ EXPORT_SYMBOL_GPL(sdhci_remove_host);
 
 static int __init sdhci_drv_init(void)
 {
-	pr_info(DRIVER_NAME
-		": Secure Digital Host Controller Interface driver\n");
-	pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
+	pr_debug(DRIVER_NAME
+		 ": Secure Digital Host Controller Interface driver\n");
 
 	return 0;
 }

---
base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
change-id: 20251007-mmc-no-advert-8f5646c44dd6

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


