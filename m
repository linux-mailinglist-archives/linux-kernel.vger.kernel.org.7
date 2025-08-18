Return-Path: <linux-kernel+bounces-773205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B4BB29CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2000318A34F7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715443074A7;
	Mon, 18 Aug 2025 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGlCf3RQ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA1304BC9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506858; cv=none; b=MF9YFsL3m7OgS6lPXh+h0MulAU0pxY2ZjZMc5tkewjj/EsBD/BOW590uapE//2C7lC0bnv23q7LRRq3YsKOS7EODaN9whTEHdBkkuBD+npMAzcVQGvclW1R6zvv45VX8IfymebL8mSSa3xIqAXxPWtm61apK03Ahb5A/bznANZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506858; c=relaxed/simple;
	bh=cfhhhzhQxZrXxPloRoYunXy+b+gOmZJrF1u84C5Mzbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n4+HIcR3V58drKjD1Vp8ypTa1mDm8gh21AChAdgTTBeb7Th8/lsc9oRfqjkCRvMSZM4LP99TPKIAqvAUSOvRuIO0OJBESj1r7NMR6W9YC2MaQkYB4kO3DYq5vKu3NKPJpxOtceg174Z4vrVG4Nwq7KVez9g010Lgcr33E1xQDd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xGlCf3RQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b6f5f9aso646238a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755506854; x=1756111654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0L7vCqnemiga4MJSGEdKnywkyS4sL50zcZbVWgOu40=;
        b=xGlCf3RQ4OmYcH5KpurF2OaO1+xexpMa7V1UcD1BKoR60Qyf5OdIGs5eLIfRfjd8sB
         GwoJow6gXrqivJeYhMZ7n3IAPAwP1TrKollsllF/aqm5/S3fRQk8cklGJARp7VMDD7oV
         G2JZvvk4hC6VpCYnYCufufk3nBMESnf600hcp/o8imuSeytayRJgvB8DbsBkZ+FYvvL+
         S0+UzRXh4Sv4ztoWVxjTahRrVZIYAm03B9oWwVizrsxRxSfPvAOrqiT6E2BCMWFBeklJ
         BVuQAmvTlUyhngkfX04Ksi/ZaJq5TW+lWXjWy8tmaziLZYTSm3tbNR8pDoYsmIQHdO/T
         yDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506854; x=1756111654;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0L7vCqnemiga4MJSGEdKnywkyS4sL50zcZbVWgOu40=;
        b=iR090fJimScf0z0G+WIPKQXX8asyXLrA/A8NCdHkZmyOz4yAbK06LwwUzciC188A+z
         q+MN5tcTRSvnhWBT7Uf5i4/bvkEOOwPz/Q08iQh3u6N35onKk0c4my1YTpHSKw2sgSWm
         OAECEhGNcZ7aY4DMIq+O705/SdEzs7sDDA7b/Z/7+dMHgoQnMr53x432WSJeYmz6IkTi
         JpjXNDh7yCQpWuvf8JPBWUhMTneZWwiNLSNCXav7dZ9SutRe2wYhIKq4VYZ4amAbF3rS
         JVbuDG6s80+5OclIA8sKNTv9IMpzVD1WMk0RTMW4P0mTNfCfZcKfQD1DWeN+NBlAnUkY
         I3sg==
X-Forwarded-Encrypted: i=1; AJvYcCURUkiMW+O2CyasGZXfqtJ34wy+a0RxNAW977+UsDN3NXdGc1oFDs9kz6Kb5o2zFNbHLAbqUX9sIyWatJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyrF82KNW75978lFXMSqdXoIgFCJkNQ3SJZZpZuHpcBgonK7l4
	qM6wx7kR2iyLRgj0lTlBL3yHaRonINAVQg1y3JZz7y9iAtpGOuyEQg53KFxV9YWG5L4=
X-Gm-Gg: ASbGnctcDzqym+rGkN5BbsmNi+3zGKYOQlTv5LxtTwQcPe4AokF+IHk9Yi2aYeRx3r9
	4l2FCztk9QLatqsDpLvtgTrbI1RIE2BFahYPhnICgT0XccHL8FVU5uEC7qzCsaQswE4/5we0CwD
	lAim8vMB0mv6rE3PjagmJZ4gDj5Wej8iY1nvJ6fqSr4eyrwJ5RkkpwTAaJ3nV0rd5BnbVbw8Tx3
	Sdl3ua6+PpKHpYdWtB3usWLb4+JCxytaRMvn5194x+DSWZJFOqvyOgIHN2dA9FtvbLOgxethl0R
	Yla9SUVfi64aJUH3vM+S6G58mRZYu0mYWkuOwVPH2beH8FuG47pHf5COd6Yxk6Ycfhcn/UsOQ4n
	f/+bExuCbW9BbnCTfyD+x0G7msOk+Vi+6AEWxYgM=
X-Google-Smtp-Source: AGHT+IHknpi+jVcAiHPe7qLq8tMu11yKP03M4lXkXrorN3kjMjAvXVfdd/sJwjbdKxYg4VZrpI7G9w==
X-Received: by 2002:a05:6402:1d54:b0:615:5cc1:3446 with SMTP id 4fb4d7f45d1cf-618b0f1c504mr4641443a12.5.1755506853905;
        Mon, 18 Aug 2025 01:47:33 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618af9da68fsm6627647a12.22.2025.08.18.01.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:47:33 -0700 (PDT)
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
In-Reply-To: <20250814140943.22531-3-inbaraj.e@samsung.com>
References: <20250814140943.22531-1-inbaraj.e@samsung.com>
 <CGME20250814141009epcas5p153e4aacfc1ead3db8c9bb647c6e5c7c4@epcas5p1.samsung.com>
 <20250814140943.22531-3-inbaraj.e@samsung.com>
Subject: Re: (subset) [PATCH v2 02/12] clk: samsung: fsd: Add clk id for
 PCLK and PLL in CAM_CSI block
Message-Id: <175550685171.11777.14695565851704310683.b4-ty@linaro.org>
Date: Mon, 18 Aug 2025 10:47:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 14 Aug 2025 19:39:33 +0530, Inbaraj E wrote:
> Add clock id for PCLK and PLL. These clock id will be used for
> operation of CSI driver. PCLK is AXI2APB clock used for register
> access. PLL clock is main clock source for CAM_CSI block.
> 
> 

Applied, thanks!

[02/12] clk: samsung: fsd: Add clk id for PCLK and PLL in CAM_CSI block
        https://git.kernel.org/krzk/linux/c/1a713bd3b0c60d826bdde633919bedc1fd38df4d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


