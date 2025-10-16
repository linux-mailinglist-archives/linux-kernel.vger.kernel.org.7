Return-Path: <linux-kernel+bounces-856525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B34BE463F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51A91A64285
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E89D350D46;
	Thu, 16 Oct 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qecl9sbA"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34892DF12D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630327; cv=none; b=n/fTnOEOzSQB5rPukmkqHgNjcldwxFovIpkNvr6l8dutlIjRkyOEFM2Kysk7AX1hN+cgc+PY6Xtz89gUQi1OUp1c/c1JSZpIxiXrE4WL5PtYmCb7Fp2vAsyLkrfFr2+DCfV3JK2gmXJBQTB//EWk4eLDpezeN9TGy0G40Abd/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630327; c=relaxed/simple;
	bh=4jQ+EIyiQVXkIlbc6gRNRqq+XDNXLeO4UR1HNWzVZhQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XujsPtvsG/VqqQ0hzcny+y4vJkOGYavqmD0nLIY6xqZ6/UgadXjYZMu6BNlPMA5CS6/ioywG0ZiX6gepLKhvExIikBiFEypL9n2tKX4TrAluxGu6y3Y+sYjLWDfsF2dJY47RlGo8IOoDCEJ9kc1Gl3OW5rtXHfA11Kt97hUtlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qecl9sbA; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso179672566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630323; x=1761235123; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZIFtHvs7F/q+BdnxOwwAZugPQcTpk+W4nyCeOYTpMg=;
        b=Qecl9sbAF7PEhnB4tbgezfl0cYLkccGIhHhzUERCkFfP0gSCIhadvI10qcpJUTYTS0
         d4XjWv5ZgzxObokPn0mELPzzknYsiCvUGti5AWq8wwSMXJAkF2IiC848q/8yVRNsiFip
         3QiRpPAGmfE7DO/E1+MNDFEoAQ1tjPIucrL3NHsOFppHDdkDuhcX45x88JUIFbNwD6/Y
         CT1IpZZ5FD7z30eewDE+zBg7ZmVRK2ctaN6VOTjYQmShJcai8+yJp1Zs4242/NwYXc5E
         654UK6FNL2dRiPUR9IDUEuu/FyV0cOl7FRjRcW05KoN78MmZK6QrsX55IQu/YlCbo9F5
         nEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630323; x=1761235123;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZIFtHvs7F/q+BdnxOwwAZugPQcTpk+W4nyCeOYTpMg=;
        b=eXm5oJfYpldQ8oAGaHewcdeyOv9dsASqQMj5AQmR1KejYG26C+V98aBCsMX6YeQul8
         JmI8BVr4Cgf36N7swAcamUp+vV0YillSuSUyBPZHgTqBgH/YSPd6Z71DPFz+Tmlpt+ju
         xkqG33OiBLOF+gX2Hb8JQiFUWciwISCLQoCW9hWkzkDRbjXw46bYlgi7yJeEIDEVhDBr
         gHKqeXkSJnN7detTzRnVK4hOJWDDdaJyfPo6VhgzT9YbigTXb6B1tQIZdHlx8AH+UQi9
         WNauHRIjGKUhbMy8h8z5wTCF5XQhKa1UZxrx1h+UGnECUc/5B1hF+gk2rjDDFLRr9ViQ
         clhg==
X-Forwarded-Encrypted: i=1; AJvYcCV80Rk5Y+4Mf7+b2NMjX4qkVTG6cm5GmzPPev4SB6+RuWcIIdXnGm7/ZPEA+RbsAcwvmB/xBwyN37s7IW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG5MYQAAPpirInwp6qoKGJKBc34X1HTYkagrcIulFpbb/wr5IY
	ImMsvxpFWLnRBzqR5t7mxhBBND5X502UVMYGl8OMkhRLYjPWOcK2c4WqWb2NTsZiWdQ=
X-Gm-Gg: ASbGncs5Ot5WL+LULYobaG3nob4lhcUAiSBKEV2wXCWFR/mK7ezULhsMGUXeb4qBFhu
	zEfOlrhuxjBD4BiLhN6uRi6b+iN1JOusy9mm68m6q1MBTler/db97S7gBzE7k4zrScmGLvrFxWK
	ckJtyiZc7GmwOOvbbY7hcLgPiihTlydcRLeVmZzaYwjRT2WfvD7CfxT+xiBTPyaXWrvt8vVD7aw
	kwfq39olsZyQoVrhBmuxPl9ypsfUq7++zKexaeNwl01OnjG4AMhwnvAnxVNPTzKAwsRCVRRXUMG
	lbkFGE7XLC/8BBH5wcBdpABycv3EPCsb9GnVXTLQuY+6WrG6mtL07JHneXKCQJVGWK1gOHJLDiz
	+YmWk8yCAQfH/QKx6ujMAeU/Jdl1EtXJxT33CJJblmNKL0DHK4WD21XN35aQ5xgx9NKUWr9nfMc
	QDP9+xZ6LrAbzOJcKx2xd+YIvVs1XXhkbi1KqfuRB4yrCKk/VkB6nCk+sVf+CxDgytzavib9k=
X-Google-Smtp-Source: AGHT+IG4HRaUmyVAr/Y8mfqN8pN0d3XueS9onISZHfbE+N4+RTdShVGlTthizBkJnoAWjpKCiPeqBQ==
X-Received: by 2002:a17:906:f589:b0:b04:61aa:6adc with SMTP id a640c23a62f3a-b647195b6c9mr48758066b.7.1760630323195;
        Thu, 16 Oct 2025 08:58:43 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:42 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v3 00/10] pmdomain: samsung: add supoort for Google GS101
Date: Thu, 16 Oct 2025 16:58:33 +0100
Message-Id: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACkW8WgC/1WMzQrCMBAGX6Xs2cgmja315HuIhzR/XZCmJBKU0
 nc3LYj1sjDLNzNDspFsgks1Q7SZEoWxQH2oQA9q9JaRKQwCxYkjcuYTL3cyzEiju9a0qM4Syny
 K1tFrS93uhQdKzxDfWznz9fuNNL9I5gyZQ92jRm5V218fNKoYjiF6WCtZ7M1uZ4pi1k6qxvRCu
 br7M5dl+QCIJ7682wAAAA==
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
Changes in v3:
- use additionalProperties, not unevaluatedProperties in patch 2
- fix path in $id in patch 2 (Rob)
- drop comment around 'select' in patch 2 (Rob)
- collect tags
- Link to v2: https://lore.kernel.org/r/20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org

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
 .../bindings/soc/google/google,gs101-pmu.yaml      | 106 +++++++++++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           |  20 ----
 MAINTAINERS                                        |   1 +
 drivers/pmdomain/samsung/exynos-pm-domains.c       | 126 +++++++++++++++------
 5 files changed, 200 insertions(+), 54 deletions(-)
---
base-commit: 58e817956925fdc12c61f1cb86915b82ae1603c1
change-id: 20251001-gs101-pd-d4dc97d70a84

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


