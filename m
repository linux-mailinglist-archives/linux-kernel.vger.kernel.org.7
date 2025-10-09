Return-Path: <linux-kernel+bounces-847053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A08B3BC9C03
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27D193538A2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCED1F8BD6;
	Thu,  9 Oct 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7sw9xbs"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A51E0E14
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023509; cv=none; b=D6bgada2Hs1LTdab08CZYR3t+ldDNlzOChinkVFm5PupBKfhDIE9anjVB4PZtc1GatjZcBNlHeNEE6RzJBflUtAm8ZnuT6P0mnmV70zog4RXJ5OWew/5Fq0aXGBhlwEx9g6Mq5iZGBJ1i9CoX+eNswyRXpDnDRdZiud+aZwfXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023509; c=relaxed/simple;
	bh=Uf428h7aIWFjdKNPWRZHAl8cNKtTa/GyBa9IPqgNN9Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UF/E8JJTtFWv+TtRd2+tm4iNJhPNWpVu5kCEtTQCFWQ4XD5BEd49CFNms0IXVxoSGtCqf/KD8duO/kz1Yx3M7V7dGhSP+RBloBLt0AehQ3qwy1W1MfMbWrypE3svbeH/J3RzbHhIKxjDVV6Cb86zvNwc9U473Q9SZ+zRYbdIWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c7sw9xbs; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3b27b50090so200941166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023505; x=1760628305; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ub2snCiVZE8jzqH1nIij73jcu2bxSWb7Zl/RGJIk6T0=;
        b=c7sw9xbsFCwgVqncOV6CfaXBAPUGqy8Qlm07jOAh7Z5kcCbZdDug302u2zGYPlZfzp
         +iCnMFJTaWbgjWZsqrFSHcVHAruK00FlxW+CURi7aiXzpXQCCS1mcNfEymfCWO2Q6WLJ
         o5s99cGC7FRKGhZJIFlKY75Rra+NslmqfsqaWF7Pk/02Pzlus4XN4Hr9GVZ329lrtLu+
         NVHaeNxcq5HYslvlcEsUNk8JcrfGwlIrFcwIydYFViwTn9O6Pzqawo2HFyciqvPMHhnP
         J9E3OKhcg2kXG6GL0xPexELOcQFvHkCWVhi+HsRbf+0djfAuDUTJdIkT3DD7TKto/TyX
         N8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023505; x=1760628305;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ub2snCiVZE8jzqH1nIij73jcu2bxSWb7Zl/RGJIk6T0=;
        b=kPYFmSaa/5zSvSA/kCuTVLGwnEAhvj5iHjJ1o2vAawC8quZPILkpxmYmtHqRyjLsNN
         nHXzwPw12jLZj3n/De/SX29nOIaI6WO4Q61js0GD7dky4QAIy9JcJz0yTGEDpJ48Z9iP
         dM4vKgb6xDWIeNG4lL1mNd6Y/GkBBthxRM5TuEN0YHz2mNwVy4SKB8HiPrVUX/B+EWfZ
         50iffc1loGlbn5Whuh+kMoHHf3Ev6qudUuxduvBtSIiGLQSnTiLdnSC8XRI4YJujlvSl
         us9OpnBdF+KLcsthOIRdLVyMP483+PkY76yMqUjM9O8v6dOcLqkmK+65dLAZm3hIal15
         8fsg==
X-Forwarded-Encrypted: i=1; AJvYcCXyW2h0FyQJJbrZOKto/2IReuzAfV+j52a/nM0qJMWWqBdtsUTlRIADg9rUs4W4K39uWIlyzr2nSK2HXYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQZJvLzsDgmHjQVI4nCt/FM6J7lueqFupGtf4mJCgbD8JVJiBt
	lgdGTKhitqUZIT3uIFebZJ7N/iZtFBd81rgCjDfU5DgZ1ZG0y6bdMxGzMMBeCURWMNc=
X-Gm-Gg: ASbGncvxStcqH9yEk+JVVFdQin0R0qcxeOH/Q2uKcS4t6f20zh+Nr9T5XY693yO4Fr7
	JyULIlL661ziuZ3kx3Ebbc3BgtuKYopmSXPVxDKIX7UQ1O7ljNmV6kGOov6FC1WSdLyNW30Owyl
	juPng12WndA45cxq2uILuvufdIQqVm6wTVsPD/0Mcp093WAjHJs5/Gb6dtXMiRhw7ufUNIpYz9G
	f1W4lX1B6NJJa7crL8nOdexG4i2Jikc/5ojj22V5/hf81kZky7/lrmBoRmV++bQCvSeJX5/bhqd
	7tP8xe3NfCsOwMnvMzVjWrt7kF7ClaEU0VWWpnar9Fj52gxiZccVtDpZD4bFQ9q2TLPY/xOuoEC
	1xs1eYT9DTjCyI9laa252ntCiexRh7IOJtgxZISSotre/gj2BhilNEEA4401Ed74VBvoVy1MJa2
	60bCWY1VLyojlt3ZWbd/ZPQ/GswRjRXkWHhDWh7wCy
X-Google-Smtp-Source: AGHT+IGm9Ug7HLTZ2JUW5hLT87xqLZ3YfSMB46riBMEdnpjNPrdz2fQrTHR8E+dbh3onnyTmrWbKxQ==
X-Received: by 2002:a17:907:94c3:b0:b3e:d492:d7b8 with SMTP id a640c23a62f3a-b50acc1aa45mr699612566b.64.1760023504704;
        Thu, 09 Oct 2025 08:25:04 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:04 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 00/10] pmdomain: samsung: add supoort for Google GS101
Date: Thu, 09 Oct 2025 16:25:02 +0100
Message-Id: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM7T52gC/0XMQQrCMBCF4auUWRuZhGrUVe8hXaTJNB2QpCQSl
 JK7GwviZuAfHt8GmRJThlu3QaLCmWNooQ4d2MUET4Jda1CoThJRCp9lu6sTrnf2qp1Gc+mhzdd
 EM7926j62Xjg/Y3rvcpHf7w85/5EiBYoZ7YQWJRk9DQ8OJsVjTB7GWusH1LZva6EAAAA=
X-Change-ID: 20251001-gs101-pd-d4dc97d70a84
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

Hi,

This series adds support for the power domains on Google GS101. It's
fairly similar to SoCs already supported by this driver, except that
register acces does not work via plain ioremap() / readl() / writel().
Instead, the regmap created by the PMU driver must be used (which uses
Arm SMCC calls under the hood).

The DT update to add the new required properties on gs101 will be
posted separately.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- Krzysztof:
  - move google,gs101-pmu binding into separate file
  - mark devm_kstrdup_const() patch as fix
  - use bool for need_early_sync_state
  - merge patches 8 and 10 from v1 series into one patch
- collect tags
- Link to v1: https://lore.kernel.org/r/20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org

---
André Draszik (10):
      dt-bindings: power: samsung: add google,gs101-pd
      dt-bindings: soc: samsung: exynos-pmu: move gs101-pmu into separate binding
      dt-bindings: soc: samsung: gs101-pmu: allow power domains as children
      pmdomain: samsung: plug potential memleak during probe
      pmdomain: samsung: convert to using regmap
      pmdomain: samsung: convert to regmap_read_poll_timeout()
      pmdomain: samsung: don't hardcode offset for registers to 0 and 4
      pmdomain: samsung: selectively handle enforced sync_state
      pmdomain: samsung: add support for google,gs101-pd
      pmdomain: samsung: use dev_err() instead of pr_err()

 .../devicetree/bindings/power/pd-samsung.yaml      |   1 +
 .../bindings/soc/google/google,gs101-pmu.yaml      | 107 +++++++++++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           |  20 ----
 MAINTAINERS                                        |   1 +
 drivers/pmdomain/samsung/exynos-pm-domains.c       | 126 +++++++++++++++------
 5 files changed, 201 insertions(+), 54 deletions(-)
---
base-commit: a5f97c90e75f09f24ece2dca34168722b140a798
change-id: 20251001-gs101-pd-d4dc97d70a84

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


