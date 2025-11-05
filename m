Return-Path: <linux-kernel+bounces-885904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5032C34368
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8EB18C44C3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014782D0605;
	Wed,  5 Nov 2025 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KkF6f+vx"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B52D5938
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327531; cv=none; b=CykH5/M7vPrC8Ox6sMrtbAy/LNh++vOBVLKp36riAKlTsHe6xoAg0+mTyUsLxgE6urb9AxaJL1gYoX7DCw41OMhAd2zfTZNyaUtI8HBpZPDa4CLcTieayyUMAXbbc6IyKHG8Y/RIxAlPHEkBgpR80zGIyZOrf6KZIGzeCrT0nCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327531; c=relaxed/simple;
	bh=MtDMcwiPMAuijfhsyZaI92s4cW9X8rbO7d13jBc597M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q443W3/Ep/farSKafg97e7A/QR6crnp+l9qOHTd1kOVm5m4dEhagChDlTBeWWFjRBisu83IaTE26ikPDgBh7tVErIB54erUUrbm2tjcqfaVUHMzjF3tPJUBHWYo++gEQcjCDXWkofFsjNnNA5AsZ9SlYb0GT2dn+gDgx4Vt070U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KkF6f+vx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b725c6be585so17140166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762327528; x=1762932328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rY8qDK38lNCOQgDsv3kjC81fEngfx/ZqaQmDfuHd82E=;
        b=KkF6f+vx2HTVZ7f3a0kWOyRh9PxaETXu+TZA327encs4ih6xXpbfqxMHoYcXUxZnMu
         n/R7CV98PmpzkMMzTk9WWPM1PJ31rkuWcoVw+LVBRTIodmIaZP3xJUApxGkMOpMHMKCx
         1stdfqFXrvGhVSIKeKF6JIla6hWSsi+Oy7i/hZ2MdH9D+eZ6Y3eJqIo5/uyK/JBrqQt4
         N44aAsM1PTCL8MBIIqFoMwMiDuMFOvoOiGNtUykzeSRO8Jc6d5OmWcZEnCDk1aYjyNll
         UCU7mrDoxYJBeAUSEXeltzOxYmkkcmxfK9qt57QapaswdQqqhvthb5Ww6euUDGfPjjC8
         bYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327528; x=1762932328;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rY8qDK38lNCOQgDsv3kjC81fEngfx/ZqaQmDfuHd82E=;
        b=f2z9Cipx1Abc05yiUOpW+vTUYzaJRpJgifQRJ9dWSUeG00oYdYI9OxNYhNPhQfmw74
         eRAYIMeEVoOcixnrlMSJ4ltcyZBB4u+lUNOOgXUI12DyCAbFSmE7XY0rvRVGqAuPtCeg
         eZWXuZ9nL9apqrTO5WgoMA52KL7hUJBCKraIamiNar1yfJL0cZ79atUPjW8r1NF2JKX/
         zp8rzLySwJNEL9el1orKrMDg355egjRdyt6Xc2Orq3CCo8+Nm7+xeG3hrN9k5ocXxG0s
         uBMghw0vZZ2moWi8j7onhPGXFyiHhlpFHsMVUE2ufo88XuqpUpem4750RUIYefC8BWRF
         uHoA==
X-Forwarded-Encrypted: i=1; AJvYcCUnYRjtIQckjEWyT8zKgmS6WtzzwMx474kbHQY1USi3ySybUh/iWQu5kZ2Pro23GIry1Z6hHJq5LwbGRHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9z/bliAnzz3HUO8eLET+ip6uN4drAYvcbeB/BErLOXzb01qG
	owPVswn9y+j8hXjm1cDURsZi1Y1ZYOgyaru9fYHEyCxGoEfynVC7XTEv9IwT3YSE7DY=
X-Gm-Gg: ASbGncs9hucvshSfxzV3SKm1VPFdEyzSoY8TjiPhJz06F8uYbJS2AY6sJDdDaGdyZ50
	HANQRJ0WeKlmm+/XuPoEDl34LuwWe4j0inYE25CnmGKWdTrTMKCLa6gL30hsFO49/2quJ1olZc+
	0CvYhS5cS+ypGA94LCiLVf1KaZsA+On7F/fWcMDDKQLtqO+9x3IgjkGycDUbhRkyFrm2d10vd5e
	/i3H0TQjwFhE2XV/a9UimmU9usU4fCNC9RUHif4BFMqxyYtrU4brENWoWV/2uFK+PCoy/rVqFuB
	B4m8VJ0AKdfnLjyocsNLFMqZKOxat1pxe+Oph5iLA9x0cC79eV4gtMnZjn4YQh8+v/cAf5GlJ7D
	S/razdx3ixzXGRvg/VwpGV/oFwA94cUxASB1kwYZaJ8HfR9n+vXWd6Q0cwCvVtkoxip3vU7xopH
	DrG+IEL9P1VI43iIt/
X-Google-Smtp-Source: AGHT+IFDmGcn05NWaAreeMUhIBohR2NC9khjvwR0aTsIxLFrJ5oJ/5mfubvbfEmAQ7WyS1CMvUR+Bw==
X-Received: by 2002:a17:907:9628:b0:b72:7761:1049 with SMTP id a640c23a62f3a-b72776157b0mr13498866b.8.1762327527943;
        Tue, 04 Nov 2025 23:25:27 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f8c5bsm411534866b.20.2025.11.04.23.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:25:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251031-exynos7870-drm-dts-v4-5-c1f77fb16b87@disroot.org>
References: <20251031-exynos7870-drm-dts-v4-0-c1f77fb16b87@disroot.org>
 <20251031-exynos7870-drm-dts-v4-5-c1f77fb16b87@disroot.org>
Subject: Re: (subset) [PATCH v4 5/5] arm64: dts: exynos7870-j6lte: enable
 display panel support
Message-Id: <176232752674.13426.8964418397433880549.b4-ty@linaro.org>
Date: Wed, 05 Nov 2025 08:25:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 31 Oct 2025 00:50:19 +0530, Kaustabh Chakraborty wrote:
> Enable DECON and DSI nodes, and add the compatible display panel and
> appropriate panel timings for this device. Also, remove the
> simple-framebuffer node in favor of the panel.
> 
> This device has a 720x1480 AMOLED Samsung AMS561RA01 panel with
> S6E8AA5X01 controller.
> 
> [...]

Applied, thanks!

[5/5] arm64: dts: exynos7870-j6lte: enable display panel support
      https://git.kernel.org/krzk/linux/c/cad767a9af055c921e29b7b268f99e83c82baab3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


