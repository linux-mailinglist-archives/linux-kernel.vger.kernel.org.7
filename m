Return-Path: <linux-kernel+bounces-844803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C60AEBC2D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F5AD34FCED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF362580E1;
	Tue,  7 Oct 2025 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luB7v2dR"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB32561D9
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759874686; cv=none; b=r5HWtHxi53q0n1mKrvwJ4LmaaKx7WuOgN//kYNOS7cw/jp9qagQ6uqVtj7y+jS6cVOtmqhM9KUxIk0MpC37NtTd9OytoYLkcRphQrNYEk7849dotQR3SL/g6q1R9GTXxdNVmYE9A0pRcwPABhVeJM854rzfZmJUJgRj2AfaPyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759874686; c=relaxed/simple;
	bh=FJt4EI9wXxHbFKaMznbVfVW3C3rxe/pQzuOTzQ8mQ3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dLFwts/Ad26dnuuzLk5cfrIiEmSdalpyC0OMQAILl0oPmYNOZU84yF8wPzC87RPfXrRi8YK+yp+CgL5z5QsgTAtE4a0JquAGpcWaX+qQNkXAGnSH0c4qjtnzIzHo6jibyJY2VjMaKgYtEiwmlI1rmxYMSaMWgFQsVU0hAZpYuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luB7v2dR; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-362e291924aso54193721fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759874682; x=1760479482; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjum81ajqp9zFhLXYrIJeHtvnzh+57SJTA8FzcN+ebE=;
        b=luB7v2dR2gG7MW6zrmV3kr/NsM5hFg0mG4N8H5kNleAjoVeSd+CUd7MLrEHlMxFqsc
         U23b26QrPF9VvY0oAENnQN0uyIRBGguJZtRIZuRFxL1CCCu48eEpnSsmh3xyyraJxiVB
         QMQuGLe/jszqINJjuOj196XRvrlAeNMg8esa8ltDsuo4Cn3qUjV7/abqan8TiUjO1oYt
         mIyY6D6xbUG1nmXi/7Y6kfU2GiZDc6B0+ZMaultQdazSuqVc249HKChe6i/v68xQ+Yno
         i5xKwqBIa1QPw1dh9auNcOnt4llaXfotvF+stZxPZSJlMAvdfrQLpfTpyau/EJvSm790
         mULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759874682; x=1760479482;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjum81ajqp9zFhLXYrIJeHtvnzh+57SJTA8FzcN+ebE=;
        b=L6HwqMH9k+l1wblXbRuBoCausrt4x3X2k/l3ynSFxJzjnjexTk9MesT3L2QpAha2no
         5HF5CnwWhp3jO3YMPbjjSuE2EstXeJv5FucAIEGMEVkoLyCFeM5UxlUCCjKC7FRf/PnE
         ndKAo7DnpQ3r54yYz1zmUa8txMqDAuc44OoxTjOpFTesLgrPeh+btTbAJgMLa+SjJyZb
         POhtYsAPtunckx6dFmrzmF9IhOwZHloKHaTCrVuw1+rCrbsuqewRc4TRmSfPzdR2CVGw
         GrFGM1i+BLJyI7VSw4J84EvkAgXCNxvaaH57X058xmpMsaCFbsQFcHsajZKPfnsfjVUb
         4Htg==
X-Forwarded-Encrypted: i=1; AJvYcCWBiu/OeIPRaxak5LQi2LPJxULPv97T+GfnSjuqgeHRseIeCxaaVx6y2n4cILvi4R+3nqXgUEqRByZlZBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlj8bjW+/JjM3a5Mp22crw59nQytGc3Vy9trqL4k8Y/RFFIGID
	An/lnHtCkZDO/G2tdl2VDRVN2RdiOjs1ZSIBXQiJCmtjQZJnV/bXMQCC+/49lWs9lvl6Tdg4rFR
	VsUmO
X-Gm-Gg: ASbGnct8gE+kd8Qcf32eOl7w3zn0mYPCwXvISDjK6S+XAA4YjnIwMw5zrCtTrswHGRx
	KKoIKfvjjZ23SitJSzBFXtxqtzINWDiSRsxsqv8bOqFoF0NmvfPAwWYcZLHjLr//36UmY2nLARz
	hda0HkJ9SY7fRnLqob/BspMQTUeQpTnJv5nTkzxrBEgBKj9FGMnoxXwsHIW7SeXrJLdhktLdYuD
	6ItWJK4GfK9CdmN8kQ3Hnpu3BQoV6C+5CSlGufQQbO3AFHz6LTN4abud9vMyAGLgE1YEbRB03zU
	9EGllyk0qnt+tGcF9I7YrrOibDmv+U8gydootZRrl+m+rWF0lPRfpEgsJTNtRHg1Hf74caaxWHi
	p7ThcWu2oNvyFLBXLQvjtlko16S0oU82PlPfmmbnxDhqJiWT5A0hpbTmAfLAFhw==
X-Google-Smtp-Source: AGHT+IH8rX/gMMA42zgSPTNKt5yRjpanc0fxdOzqseVcl9qz3bhoY4mAweQ8EVYqvQqqAu4V3QVl3Q==
X-Received: by 2002:a2e:b8c1:0:b0:36c:c5d0:715 with SMTP id 38308e7fff4ca-37609ea7432mr2819001fa.29.1759874682233;
        Tue, 07 Oct 2025 15:04:42 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39d509bsm13903511fa.12.2025.10.07.15.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:04:41 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 08 Oct 2025 00:04:34 +0200
Subject: [PATCH v2] mmc: sdhci: Stop advertising the driver in dmesg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-mmc-no-advert-v2-1-45bc00006fb2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHGO5WgC/3XMQQqDMBCF4avIrDslCZpqV96juBAz6kBNykRCi
 +TuTd13+T943wGRhCnCvTpAKHHk4EuYSwXTOvqFkF1pMMo0WqkbbtuEPuDoEsmO7dzY2k517Zy
 F8nkJzfw+vcdQeuW4B/mcfNK/9Z+UNGpUpG3Xds60NPdP9qOEa5AFhpzzFzoLNNerAAAA
X-Change-ID: 20251007-mmc-no-advert-8f5646c44dd6
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

As much as we have grown used to seeing this message on
every kernel boot, it does not add any technical value.

Drop all messages from sdhci_drv_init().

We need to keep the module_init/exit() calls to stub
functions for the module to work according to
<linux/module.h>.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Drop all the messages instead of demoting.
- Link to v1: https://lore.kernel.org/r/20251007-mmc-no-advert-v1-1-0e16989d28ef@linaro.org
---
 drivers/mmc/host/sdhci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ac7e11f37af71fa5a70eb579fd812227b9347f83..2025b33bd6bfb51fc3116148299807054179b2e2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4999,10 +4999,6 @@ EXPORT_SYMBOL_GPL(sdhci_remove_host);
 
 static int __init sdhci_drv_init(void)
 {
-	pr_info(DRIVER_NAME
-		": Secure Digital Host Controller Interface driver\n");
-	pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
-
 	return 0;
 }
 

---
base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
change-id: 20251007-mmc-no-advert-8f5646c44dd6

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


