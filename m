Return-Path: <linux-kernel+bounces-844291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAB8BC177C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66A144E0F2B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674962E092A;
	Tue,  7 Oct 2025 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDt1HBFF"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09D85FDA7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843134; cv=none; b=TZkA3h0jUbhdKRbnSBdvVSDZ9nEP3KnK8B8RvgPSnMh8WjB2oFyMv3yhCoTgVA8qtKO42sZR/fWqVdWnCjzRTzJ/BwDAqQBvw8HYM6wZSqXPKlEOzIUtBG0VHCQxOSUCNFU2kpBIpEoBZm1O4DDJDylo8cjQp1uZTrtt1rgZAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843134; c=relaxed/simple;
	bh=BSqoMya0AJUlmlWcX8U+e7/UMGEzq1d9TAX/x/1XsmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZzUSRqXFOB8urP+g36qu/GeYwPfS6dnDKXQbjaboYosJhskIvkdEfSDLpBHapqDty9he2UZzoE155gPQequoExiCXqV0bW7BkpgYV4R4k6zIZhFUKorxz5tUsb/95xzNHGm8wlr1V8ursFLD8KCMhzOEHWG8CHMUGEd0nCBz3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PDt1HBFF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57bf912cbf6so6641180e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759843130; x=1760447930; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ajbHWTHE9uQYw3vfR8RbF+tNtVDiIRA70g0ujJyyOWo=;
        b=PDt1HBFFv2czRewptBV0j5bUHIAcIGaTxMNe8PcdoiI3h/wrLepVM0gNP5SPrXIO98
         J9GiJVzwmI0lP4DskKB4zh22baCzKjtuVqDS1kv1dydgzbZcknN7QfdqoNhwQSsPDnty
         7pIsxxfCh7zjCTI6gHYuraHpCgueMBBzxMg+S0QzpzTpqul4czBQngCjQpLAIQ2WsR+h
         66CdS9yEFUd9OmWo1+02dB5rxOfIIGG0rnBdCaHpftHs8AGqYHO1IE3+4fBzSdeV4iG7
         eiQOEI95hG9Rygl0mXTHHxvM23SJEwSxRU4LpJ/dGol7SWbbqVtWI61YRo8ZkI/M7doj
         dlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843130; x=1760447930;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajbHWTHE9uQYw3vfR8RbF+tNtVDiIRA70g0ujJyyOWo=;
        b=CBYTQLwViDzlSAIzJCPGtdcB28SDIdFwwSFxsxPJsY6RhXD4aw80Xea/TV4VZ+nORt
         QOnxdE0ZQTCJTfLsN911rFI3Kz659BopCUTcc/jgp9VToCwpBmUJa4SCSE1ZbmhoAd0u
         Oz2UF4ZnS4AlpEX/+wb6Qa4IIuCQxCRxbUkBnnjRTtPvV6oDWhL4Ha2xbZYx/NT/rDrb
         qOEbZBYy2NcOghIUM2RTaEn8oO7Wkc8quWl0+iG4kt0P0TD4gjFgRvRQ0w8QiHuiv8JQ
         gPE9u71NowebrVSw7X7SVtd72bgUCOMenRk0/u07+D4eEdtSRqsO0/plh1AcfahXD58s
         Cg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLeAjNnW6CrbZ+X3PD8226CdvU8HmHRwN0CqXLrIcmyN+PfxvYAPXaT3Aw3AVenLTfUJ3d+drAnsoT1/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDerhXavGs1Ly4tRyApQNe2R2mIbyneRfnERm6qmVcpC4PUa37
	8sLS+l2fUAJyEcN+dgqBlV2RTDJkFSaDQ8ADlcmQmHPrfd9f9t3uGz2mJOBzZCfZgwbOhe39rtX
	oEz8Y
X-Gm-Gg: ASbGncvTPwEgDaI32l8wg+U9JuoZTmdJVS5Sk7XsmxrbBWBjjYgp0+YtJ/PjzAD2tVu
	M6wAiq0jhRuzVG/U3LdTzGL6g29pHGXxW6S+JLso3zgFRUiS2nGQghRPAsM7TClJkAqe3PD0Vqg
	6MF8MlllnXHOHAJ0U7mlfEh9txOdXyyaTsV7iJfQEe/ptsIbDnQ+U3KDybyRJSzlpYoPYTyE+Sx
	0lNE+8WNux/4fNXOyPV8VbSWLs0pN4BA8b10GqgeeKbs39xvLlaBmGz79vya1XlpYgjyoVC2pXG
	ZmtTgp3hoOzfTAWUPj2caXx21uwLth4uitO7iC3QU0ok9NFfAOVYoOMrUrDNKHFbvJ40ovPNVDm
	tltNVr2Ls9bTVNQFqMY20RE+aaf4sWk7qarBHg4s6mwj/kVUGAUIRq5nNr8bhFg==
X-Google-Smtp-Source: AGHT+IHDv3Zjlc8YEk/MOaGe0FXf0zsPzQjoGH1NOeEiNlTVYYPWdc+1Ii90bcMEt0vtg05NcLYPyg==
X-Received: by 2002:a05:6512:10cd:b0:57d:9f0b:fd4b with SMTP id 2adb3069b0e04-58cb956b7f3mr4828529e87.6.1759843130367;
        Tue, 07 Oct 2025 06:18:50 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011a9154sm6082460e87.115.2025.10.07.06.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:18:50 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 07 Oct 2025 15:18:50 +0200
Subject: [PATCH] pinctrl: Demote subsystem banner message
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-pinctrl-drop-advert-v1-1-df16410680af@linaro.org>
X-B4-Tracking: v=1; b=H4sIADkT5WgC/x3MMQqAMAxA0atIZgNtsYheRRzERA1IW9Iignh3i
 +Mb/n8gswpnGJsHlC/JEkOFbRtYjyXsjELV4Izz1pgek4S16ImkMeFCF2tBstYb6pwfOge1TMq
 b3P91mt/3A9Vnj4tlAAAA
X-Change-ID: 20251007-pinctrl-drop-advert-d1150d425942
To: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

There is no reason to print any "hello world" from pin control
unless (maybe) if we are debugging.

Drop the banner.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index c5dbf4e9db84424ae9ceb90ed3681341654d1871..157510157d47aad96b459abf68cc0e4eed957f2d 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -2416,7 +2416,7 @@ EXPORT_SYMBOL_GPL(devm_pinctrl_unregister);
 
 static int __init pinctrl_init(void)
 {
-	pr_info("initialized pinctrl subsystem\n");
+	pr_debug("initialized pinctrl subsystem\n");
 	pinctrl_init_debugfs();
 	return 0;
 }

---
base-commit: c746c3b5169831d7fb032a1051d8b45592ae8d78
change-id: 20251007-pinctrl-drop-advert-d1150d425942

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


