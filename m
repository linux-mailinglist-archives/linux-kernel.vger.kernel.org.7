Return-Path: <linux-kernel+bounces-843230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD8BBEB2C
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E821895993
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079002DECDD;
	Mon,  6 Oct 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMc9fMnW"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9C2DC76D
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769013; cv=none; b=sYhSHUEI3IHa1onG9xvQzDseqIdI4pJhAJtN6DaVCbtKXZooTE92HD7VrIi+VplNqK9/265OWAX281ahyQe0ZGjfdl3VUKguFqm1AOKdHrcw6PmcqGJ5Wq++VhLQteMR/cunERZb79EP8lXDC8U0wv1RffPDaMTZAhnoW3Z77SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769013; c=relaxed/simple;
	bh=HMtcLDEIKjq6G2Zgr0JytIoIw9ewVlt1cHK9VF+l//w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l+/hLsOWhLbNK/vR7Vj0Tfkh4Znp4ulfG1yc6oH1RmEKsVbGtgJ3eZO6Gic0CXQVK0TU076wvGBxHKpc5o2qZqWDzHEvuIGaIZX2q3CreTxm0H1lOzcrQB4Wvf3uuBCxI36XxR53YMrB7pmSzS0BpHbu2lrA/Vn0Jk9JLyHYH5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tMc9fMnW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3d50882cc2so990520066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769008; x=1760373808; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKtphuJ/4di9yNIsz6yNlkrtQKgCMc1BLXd/ATWAWto=;
        b=tMc9fMnWJiszVnxWCzpauPGyIxTsvBolcKNfpM2X6yK1w79upYCSF4SuOdm78GkLbl
         8uTaAwDZziqJrKughTM1EUR7cR5ztBLGVBlcTT1iza5Tvt4l+ZC5ENf2pjHYvhqv3vub
         7Iqcu3KhnuCzkLuDSf2s+lARm11qdCUgqY2AjXic4HhKgHeA4Y48MkQ/S68k3kMbFoCl
         Ha042F+gF4iJ3wHFXtz2lMrFMWH38w+6JpSkqGIVYZTkrSwfK2+5h1dmqDUHA4E8Gudn
         eE+a/972ST2e5F01hWkVBbZR75stysD1C33NDz+paYOYmFYzBZuRLz1W386bsZ79QmVl
         7bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769008; x=1760373808;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKtphuJ/4di9yNIsz6yNlkrtQKgCMc1BLXd/ATWAWto=;
        b=bykPvhXWOg/QboPI6P1+s+15dMSk9oCBCFWBbuBMMdGLIGnN3nBdIVw+/ZR1MfRNO6
         TOMiZlZchCpkAhLBLmn1bUIBFvKXYJY+FDLw83JcWuLOsoRoG7478S+j7cRdOuFgPSEJ
         gUHp05gzhiugOTNR6D6FdO8oj1UMzwSqlTjMkYw4NIDgZMHN8ZYHX4vpfYbOS70pIoP2
         KLIVTju3FPKcKXlJ1wwPjsI5eSfN5xeOepn99dke958AEhtYcPP1PTXNYT0GGHezaHYe
         3Q+WmClX5vgMx7ZfFgNsAhzIIn7+POgZQ5Asr1032z/xQfJYUTRz7IKjoNPYM+FfHOvS
         nbhw==
X-Forwarded-Encrypted: i=1; AJvYcCXuQKlfd3sd0wYLAJkFLWd9BpCeQgnritxKUomFcw+ixDKReUE5+DbIk7O2ll0K1xURTF2hrnqFzPuVNws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP1ZZZ6fTxBKMx4jtkS1Rbx0yE/Qd7jDux8nppYjtbmh3K+Os1
	iW9oSHZk456RIh78/x28WaNqVDPzcmtVvOzK5Gea2s5/5uOSQ687H4UjTlmnizSk/QA=
X-Gm-Gg: ASbGncv0gRMcnSW1XzKnlSs87tCSYPKhCuNXB2Z6XDoz81/cVw+pULl2/E36D9mQoeI
	gIU3BuTVQwVS7ER8FqEALYG39cDzyOXTGqi1L0IKknfo2P0YkUz7FTyNRzR/5y34p9UMQfoP5TX
	7VXXoF80GcF8wLYzZRcCjLQQZNW2saksZtSzPVmp7BTQcV12lQodFZptGjkjf3Yy05/8QLJm3XK
	F4DcMUHAeLe4Eq2ZeP6wO+7VP74nEkTnvJSGg5ig2l4t/Q0+poznBdXv76yyCYj0tDzr/4tSjrD
	jae/+wC8wim7vrABDF+E1rTdDK7hdq24RlSjxZT3f+111K1nh7GOC5EEc4ax+tz2G4XiULMseIj
	uT4uOYRMBK/1hBzNJJIFB/nf+QHS6cbUiWpb3uTYa7B6EiC7gcSl/nQVZQuFPDUMRVCO4A+5E4X
	2zK3z58kgS56JdFTKuTxKNQvq2Dg+4fGY/h/bpYhxRGGHaSK7ebqs=
X-Google-Smtp-Source: AGHT+IEH9sBJd0VNAAJtz9rRu8u+k/yXhel69FaA4JYwSprBvbLGJFT33oMJuv5fmnK6KbnU7ExmwA==
X-Received: by 2002:a17:906:7951:b0:b44:7c83:cd9 with SMTP id a640c23a62f3a-b49c47accbdmr1839696566b.40.1759769008357;
        Mon, 06 Oct 2025 09:43:28 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:28 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 00/10] pmdomain: samsung: add supoort for Google GS101
Date: Mon, 06 Oct 2025 17:43:26 +0100
Message-Id: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK7x42gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwND3fRiQyBZkKKbYpKSbGmeYm6QaGGiBFReUJSallkBNio6trYWAAe
 OGYtaAAAA
X-Change-ID: 20251001-gs101-pd-d4dc97d70a84
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
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
André Draszik (10):
      dt-bindings: power: samsung: add google,gs101-pd
      dt-bindings: soc: samsung: exynos-pmu: allow power domains as child on g101
      pmdomain: samsung: use to devm_kstrdup_const() to simplify error handling
      pmdomain: samsung: convert to using regmap
      pmdomain: samsung: convert to regmap_read_poll_timeout()
      pmdomain: samsung: don't hardcode offset for registers to 0 and 4
      pmdomain: samsung: selectively handle enforced sync_state
      pmdomain: samsung: try to get PMU (syscon) regmap
      pmdomain: samsung: use dev_err() instead of pr_err()
      pmdomain: samsung: add support for google,gs101-pd

 .../devicetree/bindings/power/pd-samsung.yaml      |   1 +
 .../bindings/soc/samsung/exynos-pmu.yaml           |  53 ++++++++-
 drivers/pmdomain/samsung/exynos-pm-domains.c       | 126 +++++++++++++++------
 3 files changed, 145 insertions(+), 35 deletions(-)
---
base-commit: a5f97c90e75f09f24ece2dca34168722b140a798
change-id: 20251001-gs101-pd-d4dc97d70a84

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


