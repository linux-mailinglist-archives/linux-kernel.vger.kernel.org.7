Return-Path: <linux-kernel+bounces-774860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF35EB2B874
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC574527E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8299630F559;
	Tue, 19 Aug 2025 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLbIZgbE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0021B87EB;
	Tue, 19 Aug 2025 04:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755579025; cv=none; b=Pg4E9o4RYx5/nQq0pFLO1cxCqcLHReBl6lBvJmsetEwP+7d1foxrqvDQyl+kw0ZYATdDKrdsq1zTgEkYxLgGmgs/0Jca0YvlLGwKscl6DP5Z0YZOMTPAX/KGRXrTX0Cb0Zn+UI228zzxjIlu9KZUm6Sk46pKh3nc6Wfn+8tjPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755579025; c=relaxed/simple;
	bh=PBvPxahHFjwZRwtL+CsSTpgiL3TNLm5oDpUNDInXAPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XEjk3826870WTcaPasWQMI1G1aisSTOydWom8tm6K2UZDcw1rIicB5ubICUOplYk0f9VjU9BUZmQjkwIFrCepMGZutzzAzx1nrkWwUTIKfEM93ya/lwXRaH9YXQucV9xyUUDOW61tarholFnPGcLjcMhm0g18MPTtOdtE62RQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLbIZgbE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24457fe9704so36698665ad.0;
        Mon, 18 Aug 2025 21:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755579024; x=1756183824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vJmKQWtl6J7yVeYEb7WsF4szveHuDGwgxqszhsgVgg=;
        b=OLbIZgbEQu+N5CrTPiLkAsIHJOpT5HwF0S0QTU8TSpNgzMyS+KT2UVzxo1IeqwEZ3/
         NDd5YWiD8WIWjXEP6FVyENzd0iX5yWhe3oo1gYa8lQyYWmnvBOz7x8y9Mr12imerOlhJ
         PpZSejfR+Gu47tXGy8PvXPUljXIexcQcFrJLAF3Tcaky2Vf+VCqfoaa7FxLqHkXQyWsa
         lxKT3nr3HPgRlDdavoW64CTewmK5UfyXvPWGcWgrsZg44tfoarI3ju0kfvEwqPL8Xo2E
         2TfwhOQzLLZx+OcKr3sKPdQLVtFZCojYBSq5jERIJFmC6ulgSh3UXlvS3YsS0pMgPCqX
         lf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755579024; x=1756183824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vJmKQWtl6J7yVeYEb7WsF4szveHuDGwgxqszhsgVgg=;
        b=d78sPTl0XCgJIj4VgYsoQMz5kGFd0x9gq4GGOoRQ0yZr3yenu7lXTdQ0YqOaQCT8JS
         ft4qCQ2RGSR9FSgHFv+BKMhI19awC2fEduVKyNvV6H5UVYGpu49IcHDtlsXiJxioZeSa
         BaN5w9meidJ8o4whPCmfYJbd8s4gkZQucUNwehgTwyRUfYgfsKmV8L3pDj/1ZtTSlZGe
         elkFuebOWwuOcW83ZAGFP3rjCu+u4/KjxjZtSLvTwvj39Fj1HkveSvsXcIN7UDF/ZAPu
         guoQTdnJTk5YE/JuRVvfpnZB9BFXz1gI31apf43E5yHtkuvweT9Jdtd3e4TK707DX7nS
         cu4w==
X-Forwarded-Encrypted: i=1; AJvYcCVyy90H2e5aLlCaor7N39i7EhCtlgzupbs1rPQocazWt6uNKZ3ugHR1SJSNHqpOfP7df6Ot1/Ax9CAZsk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXwmSrazV9HHCC0vYF7oQHsdCtbr2VNkQ4gC3+Twbsyip7FhQ8
	NA52UjBXZ789kNfNwos9YnYjomNiyrHQhtCkyGluiYRaayCPzV/AWMD0
X-Gm-Gg: ASbGnct1I5HqPvd3+s7AqWFtLlx5+yJfL5nvQfRPE8ZSi/bL6ZpLvCfXZKa/MphNsG9
	LfKwfpQ2n0/CjEMSbyzibpA2w1Sq0uZ8+99tSpnmSFQZ6ZbnfwqaZLCszdrR19cnMGDgfH4Hs+L
	B+hudO/S/LdS2sORdaW7UFX/9KnFQ7Kaq68sVHfHH7ZCK+BIXmOCfSpoJ8WcEDwIALkP1QSLwcq
	d0ThbPseqZablKBRB2njKE1U4UJqwR24xkza2a5CxfzBwfRrexFmP2EBcX2spCuQ1fliU+cOdIl
	cf/Cwyvd9n3KmdLe1+acVioBidIMXC76LmMajoLYKS+qTW64kM4mA79cC8AY58qWc8qjFFYDcRw
	TbtRWiyl+8AmqgcvRsw==
X-Google-Smtp-Source: AGHT+IE+vvFkCAMYWcasDYcaMWmjMZUKz3Kfg4C6k3T20iFxSNENGqz3MfkDySluEL6Scuwb+o/WUQ==
X-Received: by 2002:a17:902:e94e:b0:235:e942:cb9e with SMTP id d9443c01a7336-245e043538cmr13109365ad.9.1755579023656;
        Mon, 18 Aug 2025 21:50:23 -0700 (PDT)
Received: from anyang.. ([106.250.177.234])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446ca9d02csm96119415ad.7.2025.08.18.21.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 21:50:23 -0700 (PDT)
From: Dongjin Kim <tobetter@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Change ethernet TXD timing delay value
Date: Tue, 19 Aug 2025 13:50:17 +0900
Message-Id: <20250819045018.2094282-1-tobetter@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Very poor network performance is observed on the ODROID-M1 Board
(REV 1.0 20220613) when running iperf3 (under 200Mbits/sec), and
this problem can be resolved after changing the value of TXD
timing to 0x35 from 0x4f.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
Change-Id: Idecd246e3fe93447b6e3e9b165d077d2050bbd75
---
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index 0f844806ec542..e1a550a04498e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -210,7 +210,7 @@ &gmac0_rgmii_clk
 		     &gmac0_rgmii_bus>;
 	status = "okay";
 
-	tx_delay = <0x4f>;
+	tx_delay = <0x35>;
 	rx_delay = <0x2d>;
 };
 
-- 
2.34.1


