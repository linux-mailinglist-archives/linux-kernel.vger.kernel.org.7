Return-Path: <linux-kernel+bounces-852926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AFCBDA3AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F8219A30DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDAB302754;
	Tue, 14 Oct 2025 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8PojeTv"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDFC2C11D4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454318; cv=none; b=ngEJSUY8pUyorJ7GPGQc7WTuf3TWpO/zLRNwMvnzEaRWLmgMJu6AydIvs3CvL1YrhZvqJAXnq3c/qnCqRRFysYmIhs9qJesOQ8ozyJydgpuzEKs6W3jmBC4XjeVVn+x5IC5WN8QJUk/QHHN9FUXTnDzo+yATreXalm5KEHyIusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454318; c=relaxed/simple;
	bh=KUmhbvVhE7a9qQQiOxTeh6fcRXxeiaIPFMb6Ibxmxag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNIv8S7MkQP0oGqS3RDZpM4kF4u5RV2C81bJl5QaH3MBOtXiaz/dInkwnJvGBY7JzxuP7GCxpSOKTxw+XVmVfyXUTX6eWwNFd+MmwTeZukga3bY0N4h0ZBgyFq5/I4VYkkc8nPMI5QOoF6ELd5QXxEZ8fttb2v8E0XdlTYcP1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8PojeTv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so4874360a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454316; x=1761059116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKXUCmU9jFowxknRpXATBfrh5U5iaqmYG7UiFDMEOEw=;
        b=A8PojeTvlfFKVS5PGNHbyOH4iEM6J4XOJ6WWdSQeASnuECU1+TjSc9LddxWbrxyYOa
         bqBC0elThwkeP9KeDe3zOtC+o7gBh+a2OYnQLc1nwTRhkkwd3BgqKtmT3i+e8jyoIH6Z
         jpmtIwGl5yddxaGbXzXB8Lhzgr8ODO+cMMSEnJb31iwtGYD0hlR3BOl9Yqvuga/VVEDo
         aQKcP4vR091ywDrdUnOpnY56RKfDSyac1ytMbf8++T5N6ptaEFMTp9OZLmxsWmZJ9BFH
         8v7RyS7U6lUTRlr7Lf3yTXZUGLO97V1RPVJYVciL1NT+qlRfsJtJ37L2doMuP8fVkoMb
         60zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454316; x=1761059116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKXUCmU9jFowxknRpXATBfrh5U5iaqmYG7UiFDMEOEw=;
        b=imCvJfer+D5afRgCIQtLiItR7T0tn2Qkrk9bUbUbp6srn7h7n9flsFsGJS3kJ3E9XP
         MMNQQe7z0t3ZXdzZjqJQoMZfGoPj7hTe0CcVnr94JjtxWPwrHG1PQAQIkNFCTACTKFBA
         p3YFqyDv1g23fZ/fPBumT2vOPXWmf0Rfdk1aNYOvqyhLOpklSVZ0oSQdA0DExYxcR2L9
         0x1rhZkotOALCjc12BoaLz43tPX2fbT/iNMV7hEaOAAjtbig1KJpZouhtiB+09FWIqZS
         eiCRGeAAeX/PjPW5UEbfkAZ7XD4d8LHWlht/Zq5WTvVjCShItWZZNEn4ftvcnZ/3WX4w
         7YYw==
X-Forwarded-Encrypted: i=1; AJvYcCVEJCPGU48HVGzE3H0RFjqsIyXgF9jOeVb4COntdiqJdeDJyMeFbMFWmO0fW6ZWdpouFBMY7qwaahnxH1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YysafmbQAWKB6SojPbpcvMHA3qjgzO2nUmxBuFshPnOofxeHZmz
	wL3iVWhaHFM/hT51cvnqtB0vprNARmbQHPkE/CVKP6Oepp3rbzyxlKpR
X-Gm-Gg: ASbGncvDaTu9KPX58OQENCvMVAx9Eu/72P0vME9OosQ92KzFeiD6C0DUPbam8966Wby
	94yti6Q7l/nF7JrosKSoSXXQlwaI31aMw5f67JRzDmpFmfSjJ3NW03+EDT+IoIXtlDoiVXvAtrj
	V/FSh4F5jKIcxGJZPO8yIvKU8d0d3257SV1BOe64nBTwNIL/QlbFyNyum2BY3mdtyYd+jMyE6wk
	ZwAohaHDMXkG17tDlQ4O0GkG5zQ0FV302mJBg+ouEl7wqzgGciAsc5QKKA618o1y4znFqoclrvS
	pJFaORHnB9h+BfydLoRyz+sSxj4+C2hJcH8pIzdyGYg0VGixSGLJbJlO2xbNRT+j5P18jUIeXQp
	MbYfzaf2S4fJfEYHNht4ko50hp9Yb4vu+Ges8grPhdC4=
X-Google-Smtp-Source: AGHT+IGBkWS8gO3ZSwZOT6x7Qoh3z6cOoLFKGH3Z57P8QReIcdrjAjkWJi2zfQBYmSoAjoVcg5azOA==
X-Received: by 2002:a17:90b:3a92:b0:313:1c7b:fc62 with SMTP id 98e67ed59e1d1-33b5137591cmr34129260a91.22.1760454316096;
        Tue, 14 Oct 2025 08:05:16 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:05:15 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:49 +0800
Subject: [PATCH RESEND v8 16/21] arm64: dts: apple: s800-0-3: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-16-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=KUmhbvVhE7a9qQQiOxTeh6fcRXxeiaIPFMb6Ibxmxag=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZuMNyJ7OTVUXLasrGIPIVb1HBj9fWNw8yZt
 x7jbIc/tzOJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbgAKCRABygi3psUI
 JPs2D/9uehUxcAwSWk9iIwuMFWleyYm4LiS7tb15vFvqVEPXMUdQbk3G/e3eMusQArCpn+ycogj
 GJnwe0S8BwwKu3XcYLuNeIltnBhYG3ttIWXlIv6+v0wZd9gnGNEfgBUFUdV/jOuBlYRltuPxhhT
 eZiVnlIyArZJXWC7ZUPvjvnAGUs9HsJqJ7mw0BTcxhi4fUowK/2T5rPvDO78eBAARkeF5YGWqKc
 V8zTBUCHNsYb/mKXrGMVQik7gN5e4OPRvelEjnJy5vydwcTTKWc1G8skj/Psr85LG4blw3t2OF8
 9wzNSPW0+qJVs6nJTw7OHP6HWqVOk8Ahm0BWROI3WF7NFa2lKb68hQAnn3r+/xOT+VDTntFMu5w
 J9qwPqKEBxkXTbCBlnsJaXOFhvNaYmgcQjbFdwyunGgv5/kBIpeOYbwPVm4/LuAZvHsfONBXSK9
 uX0EnZrWIBvlEfOo8x4ZBITYaux26qtx2xk6fMsFhdgDXLTmZmu9gY/leIam/UuI3i2tCEkgjrH
 Axn8Ce0OR7Qp2DpYzHEwFlnI/jCaQ6jhcyI/RoUTO1NHPydclY5HYZObCyuVkR/xJVfCIpBCfks
 gKH0riwiIyWOaccR6cKpl6YEpjYknaMSuK+/sBaQsNs69k1R5YYZUVrei24afzpvPjXdP5OjYIY
 r0MyYbipMVm75+g==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A9 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s800-0-3.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s800-0-3.dtsi b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
index 09db4ed64054aefe5b8f8298553d87fe5514e81a..bdb66f7e0de43a6a751af37c9ceabba44ef907d6 100644
--- a/arch/arm64/boot/dts/apple/s800-0-3.dtsi
+++ b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
@@ -180,6 +180,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,twister-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 76 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 79 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "s800-0-3-pmgr.dtsi"

-- 
2.51.0


