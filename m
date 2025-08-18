Return-Path: <linux-kernel+bounces-773204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49531B29C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4768B167330
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852191C84AE;
	Mon, 18 Aug 2025 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JwUdK/5n"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D4B277CB9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506854; cv=none; b=nqN9wtHVdHw1pKTLcDbVyLEBGHw2gwbCvznlq6Spya8r0ODI4moFTw3PwPpvoG8t3iUvPGf3p6aLUuI0SPS9Tdfkba6Xjm6IlQyifOrHfvghWtPFjQlAwyeFF9jNfeMjDbsNWCh6T0/0FZdfszMCZmJwrhajYX/vnAFK+T6VOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506854; c=relaxed/simple;
	bh=BFqb772XKvnkGz/X/GiHYC9tY0Kc1FlOx29S2g2BP6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Puxl9sSA2KETUHjvUzUrO1ynmhrQs3WQx6wt/nvQ/h1iSBV/tV8NCCDA8x1iRosKyrLmT4FdIDbBlgMad8uGDTkBf9iDHCdOcVxfZAgxxz2RAq+KVgn84SFCszSOdj0XYy0AOJ4t7EdJL1Joc6Pc/KEht5iH2OBHsL2svTpoWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JwUdK/5n; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b761d74so687836a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755506851; x=1756111651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeuayamteocopIdawkFz8GBgWsuO6jcTjJdO7tqQ9I0=;
        b=JwUdK/5nUdkGf0zbwUKOLs+S0/DASbi0UqaDUkEU3nwHR+Ki8Z8Jfsv7aJy0kJ0ABx
         5xaFtRBJpyIdqZthpPCUnb+I5wVK+kQR8UgrdDAt756aGl5ruv44ArgHOKGcjHyhZ74w
         IvkSP2pKgTk3a2OofaEF3+HKt0zyjgCZSKW9FIpQTXEVFTZv3bPE2VerVme+5wX5hEJ8
         3wjbr2HascFvi2Fau6qL+OZiOiSCRVegWe+cWc60BNs5CPSXA5vAwFDPYOyBiW2lRwHp
         NHxR5cvdwiKAgfn8rZ4SZ7CfEy8DC4NKuYDDEWRi2Ke/742SVuw696yP0Fbw40/M8jFq
         XH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506851; x=1756111651;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeuayamteocopIdawkFz8GBgWsuO6jcTjJdO7tqQ9I0=;
        b=eEMhu8gdBZxpoIN1R6EuvyZEIV2raum/JSOAV/nEaEquyWoXluTnrcnSIApeGpg0yA
         u1FkSdPJuwIsppTut/vNPCZAATKVPddZ+RNLvG6s2+3EF6lW6HzuasiharVBC/nUpCPq
         kdEaYavBxUxT9yB0GFUM88hoWh7p0N8Uvqx03LgdRrlokecPrmMbS+yswcEWrIlFtnGr
         eZpg2mLOH61p7vdG7hWklBYFC7NCV8+erant57mVwZf9jPkyMjv0gdlgL+PpNvTYSXEG
         /FlJgyc3hMZEKfoLw7p9Iv4qE7IRDVBi6bcaUnJLwddDSjmvvUY6hOn12KrbWQjTSgTo
         BNaA==
X-Forwarded-Encrypted: i=1; AJvYcCWpKOsKqVVwlPL1hkPgz1e880k2as0pzik60e2382Lp89GJYKkTpZ4Apyw3j4S06E3SQN3qOZdRazKinzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWtVcsbWaVju3nRGWMqsuZNUP8vVTevFQ2X6p5SqKSzU6Kdlz8
	tySRL20PvWcINmBNXbDr62YlZyEB/YSVcF/TtIc2HX/v1Lg8hWzN51GszhrzFuGOZtQ=
X-Gm-Gg: ASbGncsjb+H+8lEOwfzpgzIj+m3Pj45iEj+ija+5q1ePyX5FaQiuAlVPi8+KTe3xDUD
	JEB9x75vnXFYx/0O5B/a47BY/Nj4UEVwitt0Wpi2JD/aNl0SUlAJ0oVxgY/1rs2Q6Lx6bf8IKAu
	VhHPWENUCr1vPqiULDR8ymbN1pvzy/IIN+whBTc7wjeOqtxlfiVK8z25VsQUro6VmXJLOt86JNF
	yX6O0xAaYX7hRZXo9O2uBSIRMxuUCYwozFe6lJdKqzunbmMxY03hntptt0xNbIZ4oa2y5kfDOHj
	gDL7AonQ1sqvpYuAjdTtzgL32fJpuaV5DjA+QnLvREt3qdInONIadYiNQmi80LQNlNlXM/a+ItN
	8y6e7TrR2urtJw1oNWt7fyRezBEiC1qqaQAsqe84kosa49ZNO4g==
X-Google-Smtp-Source: AGHT+IHnFT/QiiX+/jyxr6JrjJHBnX2ZgiTGkz6V56Qs5+zyrhsCVsoAqUSeVCMOf8wng75ASWqViQ==
X-Received: by 2002:a05:6402:440a:b0:617:be23:1111 with SMTP id 4fb4d7f45d1cf-618b0865203mr4787283a12.7.1755506851453;
        Mon, 18 Aug 2025 01:47:31 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618af9da68fsm6627647a12.22.2025.08.18.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:47:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org, 
 s.nawrocki@samsung.com, s.hauer@pengutronix.de, shawnguo@kernel.org, 
 cw00.choi@samsung.com, rmfrfs@gmail.com, laurent.pinchart@ideasonboard.com, 
 martink@posteo.de, mchehab@kernel.org, linux-fsd@tesla.com, will@kernel.org, 
 catalin.marinas@arm.com, pankaj.dubey@samsung.com, shradha.t@samsung.com, 
 ravi.patel@samsung.com, Inbaraj E <inbaraj.e@samsung.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, alim.akhtar@samsung.com, 
 linux-samsung-soc@vger.kernel.org, kernel@puri.sm, kernel@pengutronix.de, 
 festevam@gmail.com, linux-media@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250814140943.22531-2-inbaraj.e@samsung.com>
References: <20250814140943.22531-1-inbaraj.e@samsung.com>
 <CGME20250814141003epcas5p167e0a3d0ecc52fd8af17151cdddd031a@epcas5p1.samsung.com>
 <20250814140943.22531-2-inbaraj.e@samsung.com>
Subject: Re: (subset) [PATCH v2 01/12] dt-bindings: clock: Add CAM_CSI
 clock macro for FSD
Message-Id: <175550684881.11777.14718777449068060989.b4-ty@linaro.org>
Date: Mon, 18 Aug 2025 10:47:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 14 Aug 2025 19:39:32 +0530, Inbaraj E wrote:
> CAM_CSI block has ACLK, PCLK and PLL clocks. PCLK id is already
> assigned. To use PCLK and PLL clock in driver add id macro for CAM_CSI_PLL
> and CAM_CSI_PCLK.
> 
> 

Applied, thanks!

[01/12] dt-bindings: clock: Add CAM_CSI clock macro for FSD
        https://git.kernel.org/krzk/linux/c/5576d8098052952a6c95af86ad3dcb341554ac75

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


