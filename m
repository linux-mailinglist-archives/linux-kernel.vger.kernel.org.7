Return-Path: <linux-kernel+bounces-718257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F93CAF9F3E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jul 2025 10:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A3E584422
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jul 2025 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7923028A70A;
	Sat,  5 Jul 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZiidFHq"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1224DD0B
	for <linux-kernel@vger.kernel.org>; Sat,  5 Jul 2025 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751705540; cv=none; b=Cm7cd6iJ/DmAMt4Nrc0opoS9hsAUssZ63usrqFj5f/PDD8w9FvzInwO9l/IC4S5BXFM4Mx/cf/j3nSDneFJZOzx1uqCFReYR/q9UtetVDSVXReNdyTpTornNGSfZf3EXP/TNB2j/j/sxbrXJDCtU44fvTUcCtBgEZ4c4qAUIloA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751705540; c=relaxed/simple;
	bh=OH6Donon7lVbQXTIs6DE02Wj3iwK0njDFmZpSCw8VmY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E14+fIrQmj1PTmhIE1F1OQE7gyEbK1PUoxjIICsS4/cARStRK6RGGjbDJYyhb5IGgkaJscPr/SjBy79/lBE8LhRe+aTWOWVF7gmcPm6Nblsr0zPJQRvB1g2tsxw64hV9cvVb61q7T7YqufHDpMVlgh0VlC5w3obn9/Pj+CbhOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WZiidFHq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a528e301b0so61823f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jul 2025 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751705537; x=1752310337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqxTDa4DhWJhcXAPACl5qTQfjpblrskBrbY4onevVXk=;
        b=WZiidFHqzD2zLHNqa+kMYXC+Z5R8jDTKfhiRWqhxbhVCJ9CnTIB9uDT7WNN32kkWVc
         gPlxRTiJudn3GR0/XXRj50uNpWzIg/9kz4wLW9Q8EtSMPaRYkFghkIRl1RFvjCwJ0NfP
         rWRZlTnfFVhEiO8tYm9Bth370oF2gQY6f1XeQZl4dh/53Xmr2zqWMd7xCCL6729pThVu
         qTCONfAVQaWnGlM1bYRbM3YynSo+AuUZ9v6JQDU9VB25UqQCnxfaPn2pKc/FvIGLY/as
         BQov+OQVwKy06D1HCuA9JUQgXUxXUfPGuj68CFgwvwVA5Ee6hvP3N5EF2RiAXf+f2pSy
         Ap8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751705537; x=1752310337;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqxTDa4DhWJhcXAPACl5qTQfjpblrskBrbY4onevVXk=;
        b=Z+Z1AQvkexWil3D5/p+/ThVsBFCbxjCIazGVWrJr9xu9ZCIN4FvANRAN0yOcb+fiez
         tG1MERcSrR3euElXE3AuLIfbOSztAweYduJqs8hBD47DKpg2Zbk1WBvYx/7dv3KoN7TL
         3a/dDs2srb/lQAoEBNgviPqQ6RAIFBzfy9paxnuU5lQjWYFQ8OnCuQDisbyBtTYPknCR
         xoYU+ZW0OpXzwB3gBdW/HyBMgD1kAZyLy4JqUKmJ543YZJdSqJRK6dUSloHIz0EpR1QS
         byRIaR0FBQhrwejHVH6+EixVjA29TnEv+SNc/PoDEafaW4B1UIL5YQi+/IsqhmeGOb9X
         AJOw==
X-Forwarded-Encrypted: i=1; AJvYcCV1cewWZyfLlYTcLouNv63KflQAs5KB7oxLhaATatfJReNlHmdOp8GyHlpuLhJ1DM2Q2T0UAMcB88Qy05s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVxhiH9Ypf9XUpeuuaclEr+UJCDE2XKKCm+602bKeTAELFa61L
	TmagNJ+Pt2iYAEri+mHhJQ/cM8EuyEyNjQzSs6FKepeokG+8wbs+CO1E8hd3Ayemhrk=
X-Gm-Gg: ASbGncsOojlr8/fzEymPWCohe24hbk+LgwGVZb3PJN+kuEQpqe8eG5NRVHQbD6bdbAO
	6vNDoBOX4JP7stGEwUv9fuZCvjjhFTbGYIdpvh/n4B+XvjFH1I283QxnQATQ2HIid00lxNnfrpf
	h048LsMZOi1J/IBNw7czV+M/snbfiVrYZkBFMokD/YWPkgeJJ1qBhgWsgvRSFslee8ko2setl2L
	pAn75vHmd7IxoyEPXoP06rj4SrnQPIvORdhIWPa1HPQ1nMpzXZdMLxphXEEOQ++5UpNSNKvZxuL
	JYWDayYCALMZkECXy6HmuNq7Ybo2IbwznioQGKKIBUSw+xRHWIJrmfiQARm/I2kNx8ytbOV9Dol
	t
X-Google-Smtp-Source: AGHT+IElwpP/DQng7j4Oje4er7qQ/M9/KObJu58P5AwQY+utyeAiG9MFQncSMbCXC18YqE2yzss9aw==
X-Received: by 2002:a5d:5848:0:b0:3a4:eeeb:7e79 with SMTP id ffacd0b85a97d-3b496606062mr1737174f8f.12.1751705537562;
        Sat, 05 Jul 2025 01:52:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0af7sm4644670f8f.35.2025.07.05.01.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 01:52:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250626-exynos7870-dts-fixes-v1-0-349987874d9a@disroot.org>
References: <20250626-exynos7870-dts-fixes-v1-0-349987874d9a@disroot.org>
Subject: Re: [PATCH 0/3] Various devicetree fixes for Exynos7870 devices
Message-Id: <175170553635.13627.13202029423234330131.b4-ty@linaro.org>
Date: Sat, 05 Jul 2025 10:52:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 26 Jun 2025 13:02:55 +0530, Kaustabh Chakraborty wrote:
> This patch series introduces a few minor fixes on Exynos7870 devices.
> These fix USB gadget problems and serious crashes on certain variants of
> devices. More information is provided in respective commits.
> 
> This series has no dependencies. Would be nice to get them merged in
> 6.16 itself. I assume it's okay to cc stable as the -rc releases are
> also owned by the "Stable Group" in git.kernel.org... [1] [2]
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: exynos7870: add quirk to disable USB2 LPM in gadget mode
      https://git.kernel.org/krzk/linux/c/e9355e894aebcbeacffd284644749190cc5f33a4
[2/3] arm64: dts: exynos7870-on7xelte: reduce memory ranges to base amount
      https://git.kernel.org/krzk/linux/c/2bdfa35a7bb6e3a319e7a290baa44720bc96e5e4
[3/3] arm64: dts: exynos7870-j6lte: reduce memory ranges to base amount
      https://git.kernel.org/krzk/linux/c/49a27c6c392dec46c826ee586f7ec8973acaeed7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


