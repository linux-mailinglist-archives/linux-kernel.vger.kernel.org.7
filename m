Return-Path: <linux-kernel+bounces-792862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7779EB3C9D5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD91580B81
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11371F3BAE;
	Sat, 30 Aug 2025 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZbpN7TQ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BFC1EB9EB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756546766; cv=none; b=V89AWxEsLDJuKAzoPXQ3mMnr4O/3GtDRPAwZv4CIqF4Nc3EBR1mn4gAhT6qjQn0mPyWN/jW+dSxOGO0vW0nGs2aQ1y729Fh8O6DjxMfVJcwnRP5Zu3ilAF6KTf4eoo6Xd5eHVlIRrUP7F2wWhpN6GwzZZtsPw588bw79taLHbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756546766; c=relaxed/simple;
	bh=7dtwlT+QH5+HXAaXOGsHqcyqtmA7cdi+ZckhOJDo/Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ot1K2gwQjpz99oO/LxXAaHqakcSZieq6oEMn2/YbOwvxr+hwleYTxwjJPHsnVXF0uzaqTidJgfMkrvmEcMOauwFOR72KlvoGQHfPiRstFuidLW6mlMlYW5AlVGJDjFwiyIOXgpYK3T2F9KFvIjptYal6UjbuzEZve2KnTvbLJ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XZbpN7TQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61cbe94a190so484067a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756546763; x=1757151563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/DHTxjBxzogPKxJ4cOK4Z/whU+0rHPxz/zI82eTcXtc=;
        b=XZbpN7TQn88Dx5+yzqebKfh5hbXGtOiO2vjabFYkBN+Q4z8ky9x4wZs6GiRS/XxbMU
         hcFqM50WQmKHs6uV/1Hy59GMVSCBI1y3fq92Y2A3g6Xik2m4b5ZauGxB5yRbHSDvRbp5
         BlERPcZKPbl/kUz40rC9Jmay1tUxDHhbhmzgzVNOEZwHdIxM4/hOh288UjWcz9uEjM89
         tVTykPpdUNWiTZAZrUGEKHxWraohEHZlNJ8at89aur0xVsor0hrmPKmjTAspaMT40XXz
         bTHRVhGkRqzKEWaNHMaIrDXBLtaGvQDJ6DMbs9glGJoPVm3SG/ICsqmOBtoHqq47wOY2
         lQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756546763; x=1757151563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DHTxjBxzogPKxJ4cOK4Z/whU+0rHPxz/zI82eTcXtc=;
        b=QqskapHPL11n8BBUaMU4P5W6TgG3bJQMM6GlwcVJJ1pTWQK4qX7ZxyIM1VC9QUy4yg
         Z9pViSldTy2vTG6HhCwiWv3cl640aZst5uLK8UAx2Gg7KhtCR7GtmzFJS9Buk1VQ6l+r
         eC6rma3CNzBD9niVvd7kAemsuNzKHFPeQjJAb3o1/TkSEnTqtzG68d+o6LhyTLgqtnQP
         JGlWKNJHwoB+YDvmPedLxeo5flENsWKFNVjHo4cZMkLt1ge0MsBMQMftnd7GDhwoDkgm
         syiVUgM6LkNxtWSfm3XcM62e0qBKBIehIasDWgF8BC5rx8khZ55c5RFS4JbDz4YuDD57
         SCVg==
X-Forwarded-Encrypted: i=1; AJvYcCW/RMlrgJTHGWvqlFPDkHgrGozoYYo/BgmX1DZVz4Fqp1ubnsS+DYALDo8nS7X8fkIdpaqsz8WfYz2f4S8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9P8+G9VLfoPUvdq60hWENwqAfSfvwmc72+QrW0snyX2E6oJpz
	HFneill+mHIo6OYt3SwVyDG7x+ul5XNme+YdNkHFhn4aitrk3ZtfsTUE94qRXJz9LQg=
X-Gm-Gg: ASbGncuB9deVzDdiyd9qTgs+/YSl2BsDa/on7wziCHCtSM1G9XE5eFd9FkPo8wanntT
	9tT/bVNM4xzPAXlY929dmcRUTa9ipApweG0t3NeWauSKk6igzRaCt/c4XeE7wKYDPacLjaBBQ6g
	Wgecx1wtvVJPGAMyElqeUrgDthXcD867mhpL5EZG4BSSrXrBECZZbngBToOFv/CtKjTRRzVlVk/
	ZwVhovpSPWhkFwL3wC642dhsaCyEr7Hp0LoAHPtw7u+QPMTm3Hk9cTliGB6MOkrNDeplzAjmqhI
	k3YYWbJ9Orcl5NdWmMbMDa2DRpr1/3d71G/42dDv/iTcRdKZRCUwfZrjsLd1D8rPkydaSw0mzco
	JR2pb5mjpalRz9eillfSwqDSHpf0mPWSfAZYzau4dl/Y3dOONKZUCAec=
X-Google-Smtp-Source: AGHT+IEju/3F/3C9ok/98yVSIdOJnhW7fq35+ZOG8H80oN0vPxCkUSsQjBebNcRcRfWBfMhOZptwVA==
X-Received: by 2002:a05:6402:13d1:b0:61c:d24d:e2fa with SMTP id 4fb4d7f45d1cf-61cfe7eb745mr2895448a12.2.1756546762810;
        Sat, 30 Aug 2025 02:39:22 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc579ba9sm3180786a12.52.2025.08.30.02.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 02:39:22 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] arm64: dts: exynos2200: Add default GIC address cells
Date: Sat, 30 Aug 2025 11:39:19 +0200
Message-ID: <20250830093918.24619-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=7dtwlT+QH5+HXAaXOGsHqcyqtmA7cdi+ZckhOJDo/Gk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBossbGCgZcWgvcE82Z7nXJI8DCsyLZU6WLNZixz
 QaqMvXQfA6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLGxgAKCRDBN2bmhouD
 1+HWD/9dRaipZDON12eF3QCIU9kraOUTkBjWtHXkkfuLvQp2LMYnArQG+mlhmB9h4iZMPaRqh2p
 dyv05+2sPUhy3H6g1pKKB5rn8yNY0+axRMRSWRzDy/71I3oVMAbIGdp9eYDwe2H/PBnlBxZPTMk
 iPDv1wLEqi69HkMylnFaA7svIjyvILHGm0tz8C5B+/Jnn+rY0Tv3wu7TqfFgxHgau78zxASgdOi
 rYLPjg9epLEWT0RAEVx4l7xt0NIMtRQIH79x6Pk1Mot39imkhXtHyd80E5nbYrjEG6ECj8QUHky
 u3ZrUO4fY6a0fFxMtQVXmjWQDdenCEcKDHQvhPSrJqnvu6GhBA6vlQ5WrfNuKrrljUBTixlK23y
 zVxHBsco6jxzNYu6bpYt1IK/bRX2oCxVPBRMwEDBAXCoDaxTYVPDu/d2woKDzSTe/QPj99UXo65
 K44zjJ8rohdKZexwAG3NrOWPTQJevcVPBuzVYTzbSfvgf+YlkbieaNCwtLOA4REk36by0G2o07c
 PfPmn/9vB64tQhLbWNLrUeugwT9XseK6kIcn8mFtvWoNanlds5ky+1jkkZvoytyzJNRpezHvUZh
 pHFwT+Cc8IkBs8WKKJEVvcHJSbcJ86dT9goOi2/I/yZvq3G551FaEkXCSKgr901cThMd3nIvhJw MxXamzrF7Dj+g+Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to GIC interrupt node.  Value '0' is correct
because GIC interrupt controller does not have children.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v2:
1. Rebase
2. Rb
---
 arch/arm64/boot/dts/exynos/exynos2200.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos2200.dtsi b/arch/arm64/boot/dts/exynos/exynos2200.dtsi
index 933ab7818ab2..6487ccb58ae7 100644
--- a/arch/arm64/boot/dts/exynos/exynos2200.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos2200.dtsi
@@ -274,6 +274,7 @@ gic: interrupt-controller@10200000 {
 			reg = <0x10200000 0x10000>,     /* GICD */
 			      <0x10240000 0x200000>;    /* GICR * 8 */
 
+			#address-cells = <0>;
 			#interrupt-cells = <4>;
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.48.1


