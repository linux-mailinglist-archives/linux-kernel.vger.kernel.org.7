Return-Path: <linux-kernel+bounces-855404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496CDBE11CE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6113E6EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3876B17A2E8;
	Thu, 16 Oct 2025 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QXzrRBni"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CFB13B58B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574994; cv=none; b=ctf4p526bUHEqbufwQ0tqpEh1kJOuPV9kl/DHw1xi63XNLyUu2vLs8oVUaBc1TkbtTFg5KHybvXmKSoFFmTrwV0c2IdYAC7yGdYuTJxoKiVQAdrjACyXyoikx8Xe8sjf/4bqApqjfFYalrC+14Kx/MPkEMbgEVc6EdDn9IWHh+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574994; c=relaxed/simple;
	bh=qj0YvvOXuOQC7b8yM8MjMnEbVN+hysjYpMTqWns35Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7dOcxi2OsHkE5XT0A3VstjJhUe2vRdcN+PZOsqFrclR4u4eE0O//rQuKjACbvD1Xy8vGCf2JJkAh38XQrPlVwNatlkvaFOfSt6XEqXyO/lucuiVZkB7aFEdUGtuh3VWiO8atZ1TUzm44K4LR58W2jD/k3V1KUBbT2DxYl+LCVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QXzrRBni; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27ee41e074dso2085175ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760574992; x=1761179792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXt/D84/OJQisXQbO31kOLN3Cpr3xQX/Xq1KFsebzo8=;
        b=QXzrRBniTiFzP16mL8A8rh0huXpbuVBi+y3huzL37SF9VkUycuiTZHqpJ1Q7LyRGxr
         ponVSUHSGZ3553ajvyGNrlGfg1TH96xb+X5j4vbv3qpNYHJzbZ6S5+k+ndzZViY8Bn+E
         IM4NqjG9FQjmBEktfQ++C9+x/Z2KeXSUc2RAF8fc6GGAqeNlo8uLnyk6S0Y1hsG/TDNb
         Ihr706HEukbC4cSG4q2cCjnclxScsVpMGKE3LHf1I8rfDXHE6w/Fewkp7FOSrpdCtW3K
         FX4nH6v4NEGsrM3tYD1RgAmT/O1KTDpyaZ5GRiJ8ImAuD6Ne4+j16ynk1UfMZhNG/L1q
         SYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760574992; x=1761179792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXt/D84/OJQisXQbO31kOLN3Cpr3xQX/Xq1KFsebzo8=;
        b=i4TRDCbe8ZpG4MybZ/DWBGKfdCDk+OGmnFCciuICt5g4X3OGVhykEr7T4i+P0cFiW6
         bdTAedXWRUDrzO02beR0UxYFQN+5cPduZy6LxAkYVm/wIS7GQ/7v8lW3qdaaSPsKmicc
         6/nFAWDTJQYumkhpQ7fzBfn6oMsGHqWXMVNG9g0F9rGHqPhK7cNuetZE5WMmzJAsoRrr
         Gy2gd0zu9rCQFmFJaGJ4knlTYAv10229PamOcFbJEr1eNiVTsl94uc+bdEr6DOQlxoNF
         YNs+3vnGGi/jDmYXK8TU8IJam8Uek09YpEijfouzv/cTUpxJTiLGayULx/8wEajDKLgI
         GMtA==
X-Forwarded-Encrypted: i=1; AJvYcCUz2xgvE7SanPvqer9xB6lDYQ6C76cBsxxh4TkJBJq4G+yVeXLRflRVxybaHF6BX81+K7EsPeWdBz3EesE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykR/oLNamdvAc+UlwdT1CnlLv9YOITpB4VaCP3UhrjHocP6JaQ
	MSyEiJoPnS5sZ1Z4YTl1+giE+kZBrc5BtrrtGfTSGkYgczDEMEp271Z1EtgBz2CR384k1npj9rD
	521rK
X-Gm-Gg: ASbGncvmQRNQuJvmLIeFHp0yZSpbupGkDLdbRRIPVwdF9utnBOMER7wVWknSp35t8oC
	g8YpFwACxEppPKUavVbukvhXnB9hWQldo+QUiChfgcgQR6qVT7MW8NEnmkrNYI+bfjnX2+o5Mzm
	JeWZkAMELyJiXdwKd2hVGGWRcft6lZ0S7NLIv/B1/G3mTy0gacKfUMiKjaZ+PtlK8uyMeScUEW1
	JY5pbTmm4zp/4n/5t+BqqzCdZD+KbMROjQm98kauG0El2M6mLhMqDt5n25yhsBlmbwXBRgGrhDe
	riQzoAY8sfGY5GGshg+thBDvQxNZsxdlKjG3haoc5iBykkZYdeQR8UMEwpv1ce87zzVYJymKaiG
	4yJAterUpwmYuTQqwkjXrR57Zpaf+hWbUGRUnyBHhJci4pkCRORgKztV8rSeSDDCgod8/ZLkZYi
	Zk8TaUcjLcnHPaKl6E48PROA==
X-Google-Smtp-Source: AGHT+IGtW+n2FCn4fDdMcJPotohaS+nhnzdOOjJUzirVY10P+zkRGhCTeSBu1T0bO7J51NeGGnPfWw==
X-Received: by 2002:a17:902:f788:b0:28c:2db3:b9ab with SMTP id d9443c01a7336-2902725f2efmr434684235ad.26.1760574992292;
        Wed, 15 Oct 2025 17:36:32 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099aba4f5sm8780165ad.91.2025.10.15.17.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 17:36:32 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] gpio: sifive: Support module autoloading
Date: Wed, 15 Oct 2025 17:36:25 -0700
Message-ID: <20251016003631.3912523-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE() so the driver module can be loaded
automatically based on a compatible string alias.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/gpio/gpio-sifive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index 94ef2efbd14f..e9a992cd4b9c 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -260,6 +260,7 @@ static const struct of_device_id sifive_gpio_match[] = {
 	{ .compatible = "sifive,fu540-c000-gpio" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, sifive_gpio_match);
 
 static struct platform_driver sifive_gpio_driver = {
 	.probe		= sifive_gpio_probe,
-- 
2.47.2

base-commit: 5a6f65d1502551f84c158789e5d89299c78907c7
branch: up/gpio-autoload

