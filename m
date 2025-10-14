Return-Path: <linux-kernel+bounces-852924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9B0BDA39C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA5518940FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673392C0F91;
	Tue, 14 Oct 2025 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJLtjcAm"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9830171B
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454311; cv=none; b=IodvEFoJRZGEM0IZSKoET/xEqR+WXcy8vEih+moCi63hIHu+ZPRygz+AxAR48Vl+aXMrWmW7v/9woo7HljYDPLLhvN7GW+Tum3KbyuZIuUcQUu7IYabQdOxD05eiQcghJMFwYhLWeHQLmAHZs+SD/CP6MF4beMQE3v7QCWNRKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454311; c=relaxed/simple;
	bh=1JKajXUwqRhul1ka4zSxgmuIZmZnF5dN2V8kqpA2Ejs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XrTuDO25NbfNto2/zngbvMXHIaH8kCRX/70816OFmEbRW9WNz3z/kOJUNfr8JddMkBIdsUN8gphuYLX2XWGiekj0mg5M6vXnPWd4ELAkOW7PzliB6Bgbx4jGbwEUhHOE8/w1sBSElPYsXvANc8pOAeLfdTzukx+35lgbXzlfclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJLtjcAm; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-330a4d4359bso4515547a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454309; x=1761059109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyHd36Q32D6LVFmjxrrSCjpcR8v8mTvafzGLYpLOI3I=;
        b=mJLtjcAmcPPCn7W+jLsrvXxFbu7U1gdzZ5om6PWWaLIR0PuqDyFi4zSay4+zZuUazW
         gwgDW+mbmzXkwR0q8VGQp6E4w+UXlYu5JvkR9yWSk++0Vb2X1/q4H6QV+9wfUman6BYe
         v7fT885Zt9S9mxJluMARWMWOeEkBueGqrMaLlgt539nwURi9cfodxufcB87K81efRQvk
         1QWWwoNNFEckYeqzjS+fhCaKNpxqPaRrVq0fzJViQe4xked4h/Mxg8HRamTNcTNBRXAB
         HOUvt6Ab5NIT5q37o+6LcRJ/yRKIE8EoPRFP9qsCs1j/i7aV5oI75T8ZM15n0TqI4914
         2DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454309; x=1761059109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyHd36Q32D6LVFmjxrrSCjpcR8v8mTvafzGLYpLOI3I=;
        b=OSKbtEtGqeenQ4KewKAaZpe1Qk61wdhq/B37C7ef/nkVyCxzX7AmedZxpl1XjJnhWV
         L7AjBxY8QgcOuSU7XZqp565MtjEh3HsBUVYiG4oQqETsZaWTy6AhUzuq9S8O8HHTU2Rt
         zJHkUTg+hHcVXC45kkj4eX1GSlh1KKuM2DEOScRhkDLox2aKDOvEgVBFj38Yzy0c2P4N
         63xV7AV9PA2LLF+8gTp8UVH3C4D1ihu0gRuIH/kSFP7skpRXRDL94exG/K4hmA+HRZL/
         bUkXeuFL+0WrsmcSrDklnrpXApmuTGknXULpGw7b+YiKkXgOIdm5HpM+IJWSlhx3stGO
         FyHw==
X-Forwarded-Encrypted: i=1; AJvYcCXhonrvHGH8x0fP337uhQTWfoISoHNKsZHynlAcpV02oXiaTY9dY3yQTHQq1bJpd51bfwst7r9WYNQoFkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqKNbFkDGmDID5rW/SdcWCamZbu8XdX5sw0KL55Afzj2wrQATE
	s5cHAEhiufFAsVT8u1dgfrZgYZP9IgyWbicyBZp0I849on+zEVhdk2PT
X-Gm-Gg: ASbGncuD/MsWYH/JkKhIoplh6JMxqHehomf82wEctFTrGzdDSKWCsgF6A1EUeCLdL5Z
	PRc6B19RePAcr74mqsIkA09Xw86dr+O6LpAsItM2orzefsXhOrhprVvjfYkHTrLgJcK+22bdKug
	CCvGLRlaijJE1zX2OPnZKhm0Z7PLc7Ql3+QsTlzFPu5+fOpQH4HlK30CtuAS6vqb6seRcWhUyEj
	L8BbV1aTZjvtwklVgrz5WQCx5qRFXDjv6ELqwXX3+Cpt4OsrWef4qUVA4s9yfRvbVYxDuu9pgbN
	pTc+oHPDLinnqIW3HRiLtN6j48qGSKEhQA2P2MpFUNUmR21RIKwgyD+vv4EjzZueorYTIrr746c
	5eo0f0L8zGTkHLB/IWLwliJbVEsI4Is5zv+bGBpxfT2U=
X-Google-Smtp-Source: AGHT+IEjY7bDQyIY5jvN45R8h40HRz/mrkV41Wrt6tjyF+cIPRkH0RZhP/fAaYofUftjWnewdxxDUA==
X-Received: by 2002:a17:90b:38cc:b0:329:e2b1:def3 with SMTP id 98e67ed59e1d1-33b51168d95mr33754194a91.10.1760454309043;
        Tue, 14 Oct 2025 08:05:09 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:05:08 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:47 +0800
Subject: [PATCH RESEND v8 14/21] arm64: dts: apple: t7000: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-14-3f94d4a2a285@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=1JKajXUwqRhul1ka4zSxgmuIZmZnF5dN2V8kqpA2Ejs=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZugCbmni6EPY7dskM7QjCDK0rY7DwO1/bBA
 DN+fo8D4aqJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbgAKCRABygi3psUI
 JAEbD/4iBlLYvK5aeVArd4aJpETMdoyQya2/cnTtxya7scu4bEBXmzUl0lxJiBj5ca4LuUsXV3H
 gPSzIS5mC9pa2dL7nGt+hTIZUXfvIIktGfltui37vlUFxUPwopY+xcs75U1bjVGX7b7+gTYagjY
 FZxBe2W1f6iwEIZtUcT/6sEcQDjQbuqWUWX9LlzO+LFVa8wS55Xmf8gBwA/UIFn5O5Fj48BjhIn
 nOEWG/kV9QDPi7GvQ8Oenq6HT57WCMGX1sQGMTXIUTftuSdGbTM03sN2amh4K7g6X6YVoass1VB
 IAKHZwYiVjObkjB5zXQKz83tTYq9ewTqR63fSmuGSmaxfkX2q4fZXKTMjPlyMU2NeoNsX0Ho59K
 yydP42BIWTjH+9g53VFhlPUsTBbSdCghjHMQesPf8+GSQ9uzyeWenr73lA4nqVxqVIB6ftJOqus
 z8CGKz3bVyob8Zhg2OGhAz8CEu2pxZonXUqcH2duqy3WISGftEU1XxkxXP4W80dFbku5SlZKve5
 eoqx4vvPKfJArysAkflnRpKJ5bDqUUcLLYGo/X/x6Dyv5Bj+DIunaRNXNHxjOrfLUh5SY1s+uNU
 /cwvoL0wK4LBZ/pw/RWav3cNh+cbohqQzucWj1yyQyCmewgbMRWc+1LE/A4bcbRMQnAnkCndhzC
 Kp9YaPmsU82RlDA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A8 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7000.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
index 52edc8d776a936ca5ba58537d4d68e153023f536..98c41473a84098bd70df86c2728a8080b05b41f4 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -206,6 +206,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,typhoon-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 78 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "t7000-pmgr.dtsi"

-- 
2.51.0


