Return-Path: <linux-kernel+bounces-748144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1C4B13CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 361C17A289D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3420226D4CE;
	Mon, 28 Jul 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNT0kvku"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0126D4CD;
	Mon, 28 Jul 2025 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712434; cv=none; b=uuDawRjBKMnDcs22F10Bm7cF90S8W3SwN9WJ41dHQ6SfOVjruinrdnbMtPoiKQmOwZqE2o901bjry8SOB9tq+wXNtj5VdMPD//JTleBcpQ+ZtYOJKInKgSzt5eb/OaJN011kLrOtChcHpSVKkNtewCEIB+814xkzfKdfezlqdMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712434; c=relaxed/simple;
	bh=PxJJD5BdYiecz3+HAlAUv0mqXDsb9508pUsTSJAhu14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGv9vRqZQbiZTx+3g/3UvyYNoAi1GU8G4AGQtYnm90tL5D3s/qGPDSSceVlCKqZpoQFh7HJnQe58goMWauvLGNvheY4PbxavYvBwSS9jDFSciCGMTZHxN9r2corvY8mhiJmqbgS1t3zGbtxhCwI5Olqdezta8dFbWhJCvjNFM/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNT0kvku; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-76858e9e48aso744644b3a.2;
        Mon, 28 Jul 2025 07:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753712432; x=1754317232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fCuuegqOgh7yiTp50CPz7MDoO4s4zlMG+vfGbQq2dc=;
        b=CNT0kvku/uN25iYxo6BC4NzvGDUoWgJ6cnGmVdjQHzGUFrKmXIXMtgbJholuAtr8/A
         Uca3NfWfXHq+zrT/674nXMeU+0ztg9z+iL03Nh1aOH9sFeTX66f9MKPTSURCB3ZKRA2F
         dYfYT7ayS2G0shY7lbqPhOt8/5kgBK4fhVtcmLbivSZuSJavEZrz99YG4B6WniklzdYa
         vO2JLnuZqj6yu51dawN0HAGHYHhIUjrRgwzlkIz1qTjvIHGXMsW//oKZoaRcsksJhCl+
         LynY0Mv/daVpOMJ29IJG4XDZna6SXludZuKJT8Br3zdzq95zoDf3BPOyTc20dEZOaOyp
         Ok7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753712432; x=1754317232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fCuuegqOgh7yiTp50CPz7MDoO4s4zlMG+vfGbQq2dc=;
        b=AWnZdsv8u763GvMMakd4BOFWbQzvR9fbu7YbCRtmwsTiLb9Lt+9LdA1zUa1YdbC0ru
         9/1vvSwJ/ayJ7kRqqXKMp4b3WMXU+1ZbsZL330BuI0hUgKzZ1qKWTqiR7MgYcCtEu2ON
         HqTvHBuDGbwStYYj7bjmJ3VBcvBtSATkQq4xz3LMexpvteA5/roTBm+RjXhyZydU0l/y
         HyWC3xrjTN5K+Ayprw0y8J32VudjUAiNT/jw78YTHjHc4bziIXhtxX3iBX6MgJvT5VXu
         v6Ifj8g5ybi1WXRJTppnlKUaXYMgkgPerMEXBl4/1PoTBM+U5H74waE6UjNtvccKQe9v
         OwLA==
X-Forwarded-Encrypted: i=1; AJvYcCUZqIvr/EDDecVccVeXOmaf4Rd2SXstgrnUFUGV86dTyeS9+B3JeWrhdtNZcfpLPNxu9B9209nbutev@vger.kernel.org, AJvYcCVyphXBuC/qjxYGolCA135wwoyAjQ3mscaSHWql3FcV0G21hqRGZ9eijDLeiegubfNorqtdLUL7RHJsfUWV@vger.kernel.org
X-Gm-Message-State: AOJu0YxXiRk1j7QG4qh6Uj+7hcxyTj5MqagDUGAaQP6lG0wN69wPo2sb
	BcnKciSTDEUqgXIAXvWUlh2YxkZCj/uSMWLzjFpv0UkfhBDNO/a1CEmaHKOycQQyQRmjQA==
X-Gm-Gg: ASbGnctNOYj+GyHXDZYTDHJGptJzm3OaylqavO74Kb+MMvC56/MQ04IG4aQO0A/tkGl
	mR3Q2miapzkF2VMmBX8Sagb4wcUl71c0OH7cgbloFb2zJE+423e5UrhFpB5MI9LZAKFTIoHCu8Z
	msh3gEc/oghfeOAeO+liho3ohtfZhgokZems+bKfj9/NgtxzcvSLB+M7VZ2xetHkxlg6ZgyvW0C
	IgVnf7L6FyDlBt2Kb7VteyFvTYHiEva+6hO9jtfqiXtcExjayIpatz0B79t4bEUYVMMlOk1lc3Y
	XoVokdlfbyzRspZwri5b6K/AUn6ii5Uc0hs4aqTLxEN6DQl3i+OhhTY0hv2ror3EXXzayXNculT
	lQj8gXyN1Ek09EYnxORLVK8hw7aFMY+dd
X-Google-Smtp-Source: AGHT+IEObfYk/Wz6SuT7jPbvRWcLuE1W9sEClVf+JDsYA2szDPxZRsKWqL3+hYUXv4qBE7HxdUFs+g==
X-Received: by 2002:a05:6a00:4fcf:b0:749:4fd7:3513 with SMTP id d2e1a72fcca58-763389ac8ddmr17218955b3a.16.1753712431742;
        Mon, 28 Jul 2025 07:20:31 -0700 (PDT)
Received: from localhost ([2408:8256:2284:4127:de49:6dc9:a446:157a])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76408feb725sm5638582b3a.60.2025.07.28.07.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:20:31 -0700 (PDT)
From: Troy Mitchell <troymitchell988@gmail.com>
X-Google-Original-From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 28 Jul 2025 22:20:15 +0800
Subject: [PATCH v3 1/2] dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK for
 SSPA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-k1-clk-i2s-v3-1-5d7579f02227@linux.spacemit.com>
References: <20250728-k1-clk-i2s-v3-0-5d7579f02227@linux.spacemit.com>
In-Reply-To: <20250728-k1-clk-i2s-v3-0-5d7579f02227@linux.spacemit.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753712415; l=860;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=PxJJD5BdYiecz3+HAlAUv0mqXDsb9508pUsTSJAhu14=;
 b=AR0VW6KLcEEQ1zKFa+FXIaRCpIsXGTDIiSgdsPRiKOVyzjaJvdb7zMJtedM2MZ2oc3qcz5rlq
 kuoNFsP3bN4DgKsQQIamO7iA44EY3wLztWmhbxcN0QtEPsV+5GMDkBb
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=

In order to use the virtual clock SSPAx_I2S_BCLK in the device tree and
register it in the driver, this patch introduces the macro definition.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 include/dt-bindings/clock/spacemit,k1-syscon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-bindings/clock/spacemit,k1-syscon.h
index 35968ae98246609c889eb4a7d08b4ff7360de53b..9be578953d71e79e93eb10eaa35b47b97812e826 100644
--- a/include/dt-bindings/clock/spacemit,k1-syscon.h
+++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
@@ -179,6 +179,8 @@
 #define CLK_SSPA1_BUS		97
 #define CLK_TSEN_BUS		98
 #define CLK_IPC_AP2AUD_BUS	99
+#define CLK_SSPA0_I2S_BCLK	100
+#define CLK_SSPA1_I2S_BCLK	101
 
 /* APMU clocks */
 #define CLK_CCI550		0

-- 
2.50.0


