Return-Path: <linux-kernel+bounces-899783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C09C58DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD6D14FB941
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FD035F8BC;
	Thu, 13 Nov 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts00Z7qv"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E371A35E550
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050540; cv=none; b=hj4Fvqa7dU0lutuUNCopDCzCKEMr7ZuX8ap2YPWeODKFerMy1srkdNlVmpCfW29arShk0A/+VSp0A4VLFv5GsJ9kK8P3MbI0F5yUzAmkTKeEbOj3eRQ9m0bpbcjE/SqYgU7a83WZ8btLtpvb0AeCRr7Ar+a9JKjmZLGszt7kQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050540; c=relaxed/simple;
	bh=TWEkez4qa74/GelrihI7Pr5Km20IEaqU/Sv6EgMpAwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pl55LzsJ2lsPUBwYbtCveU6VRmVSSpvsmAERqhAwRcr/kBexqES7I8CCRmHbYD4iGzclBIcuF0YTKtdgeCKQzlpwOVXqYx9BbMESrqekqaCpxjBPAsouc9ldXdoytn6tutzw+6faOaPhvnUS9HWjk1n//XIsAvzZ0XavzhNxUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts00Z7qv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477632d9326so7326425e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763050536; x=1763655336; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8KjP0K8IuiEFgrTGQMK3BBanWGBPr/IHVcMMlCVe7Q=;
        b=Ts00Z7qvu+ECstOffCDEC6qusMVZolPoT8nUi//+/+U0CtvSoV4+OBYfptrNuimTw5
         q59hl9qNQlGkZyMaWUG+Kjj1uFuEUeYroD8y+sls+otnk6+hKe+CSUbMLJkBNSQR+qsg
         nX8ejlfIrq79sm0BTY5agVWtSOAG9use3IWXxTAwPFsrl25laYualq1FfELGS6q1gp+c
         OkN242zwFgGs4NNBlPoDdIpqVD1/JgO4DbEsAZtiYR/0C2cH8pfvmuoZWgaaXWKSpNtn
         Kxaa7zFdXsi16GkgyuzrmXtyPI1zp/hA583sDJQ+8VsmAscHtLNSAJctdWkklNrSuIgo
         CxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050536; x=1763655336;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8KjP0K8IuiEFgrTGQMK3BBanWGBPr/IHVcMMlCVe7Q=;
        b=FjdNzz6mKfSMDI3fbi8d2AGJDv0qiyk4qiA6qE3IT9Svgsfb1lEVEtxNSfKFXGMVNM
         fjaBx6qU5S2fGpgE+k79tCgUuPErT/xg75b4MukfuBr54HSg8zwS7bq0FQsvcz1fY6x7
         7XncPHQEXa9ohgbvC13jP9S7u0lMhZaGynQN/EciT45IsLP6RuhP7+C0VQFskot6So4J
         aku8j2NHL4UZNaLPNqhkVEhjygoYBDYJahSbDHRhkEGNw78UyNKNBKsp7UbHM4nKCyA9
         pOIbHXnH6SCMb7Xc0JHPOkvwh80cNbvxj9zgq50eLl2YiojnE1tkDriA2rvZltpbb8GY
         KDNw==
X-Forwarded-Encrypted: i=1; AJvYcCXdLSEwreoyhQkKB4IwvraLSGydM8+oIBrEwyWhQp574BnYFv5MFXKBcQWgB7aglP28rhuAhT59OaTJ+Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMc0zHCk9hBc4titvrFe7gEmk6+uKqGxqgQmlxnloVuLaiQSjY
	1aF74/Klyze/b0/QkA2jKl9PSVJgzShLYXJG+al2k+rVJabqtOuQX5cd
X-Gm-Gg: ASbGncsBo+hsgkUL2CcurD+zDtkznWbAUIp9xq7D0pKwtl3t8vgxzhk971Ipq79AKg4
	5rQnc/aVYG+x9kRLn4si9UVy1Ng4PfkE2t0s9P56GQyn/UmcD+92zmWTP/5a5ph0lHU7c0gOyD/
	ZuKzXwqdzxcBgFCmoMQ8AhpOQ+n/ufJLRoTw3YkC5wowozQJILzw6wJOrlX0hW2MuZvnBiJDIA+
	6OKlkDhxSxl9P/Nnwm6xqFgyllmYmyiEwtU30peN8hEgsHhvyafLeqJbktvsQJucvMNMTAYKmTA
	vtoo1nKDWHJniWZmh5IHvPp7DDGUZ64foxb+50U6gwUmw9P1nqxqG9wQ+TJeFlOqSMxrodN6YI9
	VXyChjKTz5rG3+HtvRpj+VwjCnrHP4HvfL5/mVQ/ADJCtUoPWfOWuR6WTmCarUxGqqZkrk7NF24
	V2G60hc10mHV2Kf+yLSpTRTiqZ5CyNEQ==
X-Google-Smtp-Source: AGHT+IEQBr7kyonNOCf+6/ITah462rsUm/fMGQESxqAsjgQp5o7DXD/7On9C9thqMTrE8oLwe3DOSA==
X-Received: by 2002:a05:600c:1d0b:b0:477:7975:30f2 with SMTP id 5b1f17b1804b1-4778fe5ee38mr587435e9.10.1763050535961;
        Thu, 13 Nov 2025 08:15:35 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4778f4bc9c6sm11445025e9.14.2025.11.13.08.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:15:35 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 13 Nov 2025 17:15:25 +0100
Subject: [PATCH] clk: qcom: apss-ipq5424: remove unused 'apss_clk'
 structure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-ipq5424-remove-apss_clk-v1-1-e942e720cf99@gmail.com>
X-B4-Tracking: v=1; b=H4sIABwEFmkC/x3MQQqDMBBG4avIrB0w0VjqVaRI0D/t0KppBkQQ7
 25w+S3eO0iRBEpdcVDCJirrkmHKgsaPX95gmbLJVtYZY2qW+HeNbThhXjewj6rD+Pvy4zkhuLZ
 qEWrKdUwIst/n/nWeF07T1OBpAAAA
X-Change-ID: 20251113-ipq5424-remove-apss_clk-79def5606ef3
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The locally defined 'apss_clk' structure is not used in the code, so
remove that.

Compile tested only.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/apss-ipq5424.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq5424.c b/drivers/clk/qcom/apss-ipq5424.c
index 4c67f722e009af2889ff7435535d7bc156192c47..2d622c1fe5d0522f00d7acb4614ebe4381e066c0 100644
--- a/drivers/clk/qcom/apss-ipq5424.c
+++ b/drivers/clk/qcom/apss-ipq5424.c
@@ -35,13 +35,6 @@ enum {
 	P_L3_PLL,
 };
 
-struct apss_clk {
-	struct notifier_block cpu_clk_notifier;
-	struct clk_hw *hw;
-	struct device *dev;
-	struct clk *l3_clk;
-};
-
 static const struct alpha_pll_config apss_pll_config = {
 	.l = 0x3b,
 	.config_ctl_val = 0x08200920,

---
base-commit: 682921ab33129ec46392b27e9dafcb206c2a08dd
change-id: 20251113-ipq5424-remove-apss_clk-79def5606ef3

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


