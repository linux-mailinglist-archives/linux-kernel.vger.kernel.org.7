Return-Path: <linux-kernel+bounces-855682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D24DBE1F69
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD7C19A8381
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED94B2FFFAD;
	Thu, 16 Oct 2025 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVrVt1w/"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FC2FD1D6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600548; cv=none; b=kDdiK84w/TiHS8c45CW4ZXI4TIlzH+pBaRwcYGvQUJtglw+8Z6a07giz8fOuZzkNv1Tr+c4EjbClgxp5GkXzwqYDLlvGVqAcnRERhjvfs+Dg1mHf+fHVjhX5ezBc+BAXycAKvowc3+ZuXuZZoEzZsBj9ocCK8LFWT73K2sBkq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600548; c=relaxed/simple;
	bh=ze79z0cIlNbaKQa0MA4ljsXZPan0FmaR8mcmgo52yBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMkUzc4gJlVvxzXSfgZGtzyGKWz3F4zzg/W7iEmBD/J1X6lzmypGXFgigI07ezLzW0sE5lFs9dfj9107i0g5TaqBlq3YwoPvZ546/Cn9uD1ublZ9HqIcrfXgRBzIhNIL1W34Os77E6yR2jYq7OpEcWRvIIqF5N7YNUqsYktd9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVrVt1w/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3737d0920e6so4180571fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760600545; x=1761205345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWYu3otYisP3loE3ZY8+Cvk4qkPP9PP2d80k16BNDdo=;
        b=OVrVt1w/jVJWAbag+iuzqOadfBK33RiogSzzPZtfvmMdO703SDl3gGwxOswYDNzJ6k
         bHvz18OtmM1An1owpnDPDsiEJDLwT5RGg9JJOT19I5ckH6T1vZvoNUzQ2hA8929Y0h2K
         Ey3TLLEhQZ+0rxp4lb1XVJJBfPTDmOdTx4RxzbXpH2fQAIOblZha+wxsPfdUdCWJ0g75
         CEKZYoYL5k2ARLmgcDglOlyEFpoS1fIiRvohl+89i+Y25xns24lUUdp+P6aSS0ZqReBK
         nEwFes+7TVGHQniKaxgTWwdnN28bpiVADI5/uMTNvr0dJHtm9QYTONrAhigxBxNqXVgI
         sA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760600545; x=1761205345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWYu3otYisP3loE3ZY8+Cvk4qkPP9PP2d80k16BNDdo=;
        b=vTN7yLbMDuByFO1zhGk1OY3ATBnGlBKA7g6CRMRRsnWSzXKIbhKg1qTAKMzp/PQ3kC
         jjFI35Tk7upYigsCI4H4KV2O8Qb1H5pN60af51NrIB41c/d6OKLARbV5dXMihVqcw5l3
         jDeH5N5kfmqfqXqFDrIB9anlK4akCZR6q3P/Wn0IyQ4jlDVUktyvFKICwe1mkYvnTuZ7
         rclCKIUE71zbQS0k7ty/tJ+JXZySMTAazQAw/+5QFUYY2+3sWOwa1R74sS2ttvgG1OQs
         3pPulkH+gX2q4ayjKcYHXdRF6hNz+PykPJUiLCylpzpA6W4HWRTWRJ/5UxgUu+W91ToS
         gZew==
X-Forwarded-Encrypted: i=1; AJvYcCXw7Eqcy/VpsYO2UvQJ+CL/ed3PI2izhmvgbFHNMi6FCpNFNo2tO1H5JTnpoWH9F8QA48hjiLB/K93/lKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqeexxhKZpaP3WsJLKix34xOuaap8tpC34NXZ7e7t3xeL9BTa
	JoHQ9XQlmCrO2SR1Kf6x6LyybFg7bA0hbyiOgbXEwgGwCG0+BqcdbygB
X-Gm-Gg: ASbGncusEIAoT4P37w5t2aFISOUoBZmBj0qGmspiP7qrXaNBMZM/ojR4k2ZiycoFlXF
	17hiFJIbG9N3F/O9f10qXw56a4Aqp7YB+TaNsGZQfup4cuF6e2C9H9VZ7N1X2roINhNPvGXmW1U
	rsm46WqmrjVF4iD+Ljz1fIgwivcIYpBWhaDo1yqC73PTlmuX03JB5pRZ3JmNR0WVh7h7BoGM1Wk
	udFJwPML5XZ/CpsZdlpE9xYDH725krFeNl9Nz73vqHUkvnqsWQas2YHw/3jf6uFPVVLtpECN2H3
	Sc4Vr0k2VlovaI3gNP5DAzEotoHZ80x1b1UP7sHPHRn/Kul+jiWMpkOISTz+u0QELkyYN2KYsHs
	1I5jyFQrzFQju7HW4B0iLZ5sMxHfKC7AU3hhPh28oflSz4FSlTfI8EfS3eycalsnhW43IfyACAz
	lJ3w==
X-Google-Smtp-Source: AGHT+IGVgf6/RN8IUHFNYJOZvU23WBLAQhmiwYE6OkYEXsUUlwsCRkSsEJa3T4KsUiG0urBQytUN8w==
X-Received: by 2002:a2e:a98a:0:b0:35f:a210:2a35 with SMTP id 38308e7fff4ca-37609cf7f62mr88037521fa.7.1760600544458;
        Thu, 16 Oct 2025 00:42:24 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea14d46sm53226121fa.34.2025.10.16.00.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 00:42:24 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4 RESEND] arm64: tegra210: drop redundant clock and reset names from TSEC node
Date: Thu, 16 Oct 2025 10:41:52 +0300
Message-ID: <20251016074152.8759-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016074152.8759-1-clamor95@gmail.com>
References: <20251016074152.8759-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clock and reset names are not needed if node contains only one clocks and
one reset.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 942e3a0f81ed..cbe54c4e5da8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -183,9 +183,7 @@ tsec@54100000 {
 			reg = <0x0 0x54100000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA210_CLK_TSEC>;
-			clock-names = "tsec";
 			resets = <&tegra_car 83>;
-			reset-names = "tsec";
 			status = "disabled";
 		};
 
-- 
2.48.1


