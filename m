Return-Path: <linux-kernel+bounces-863591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72ABBF8412
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2000918C6B42
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264E4344047;
	Tue, 21 Oct 2025 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIdZdCSZ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92390351FDF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074835; cv=none; b=aO+tpYf3hNGIRhBUqjOtDaVZCCQP9tGttYhLzZuDj1jCWmBAiqTCjcqAaWt4fUhD5zHD4NZopnoY9fdRj9Q6m/Q8qQXMo7P9e/o/rgqKpK36eh96zRALFDWvrpjetyMmRD3P78t1zkhas5/8IDxFt+hroKiz4Yns5WCWvloR6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074835; c=relaxed/simple;
	bh=sCX36mBUUD7UPbPD7/zGy00Jms3sN0alcNuZJLzWb5o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TPWQ8QxxjTiahLLj6WPMRPhuQpqAmFCKXQBqvzhpTTtUrNMoV+TWgNpYwmid64nwamoYenuk0ykEaA5F5N1dfcVzjFMHVldiduIjf2U6ZAoDUfo4k+z/aXMS5QHK2u2RjUq6K4yMyFmmNHWob/9BCpI65DaDdeHObPtImvfM59o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hIdZdCSZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47105eb92d8so9335415e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761074832; x=1761679632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2AwA2f/f6W+wFYqRdKOL2857kAZtGdLXYTnjc91Eh8=;
        b=hIdZdCSZodnhQJVNtzb8i5NWpR1bSKkvGlmAngh/xj09Pa8YvTs5FYf69of06kTgg1
         Ul1tb6keo2pwz/SMat5cztvuH3bn4q3jss1qg04pgXAkBwHsFmAATyCoIeo/LT0Pflic
         hHi1RIt1fvhzVTSNcW/EZRjOvO63yFNMd2q1aVV0ZjKMxTGTtDJpFJZ17jNZQdKBdWbY
         GdSzvj/vavI9j8jcMu7G5EdMHtaa51hEOyPNZ+gvMV0W9XorX0RZRWBhmN5/lNnppL/U
         S1NVvG0h4mvp4WE2GNdT2f5aDsCGgJSBF7Bgl3CvrtUsu1V3m/Q761fFv0RXOwvVnj0W
         av2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761074832; x=1761679632;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2AwA2f/f6W+wFYqRdKOL2857kAZtGdLXYTnjc91Eh8=;
        b=n2aQ31qrS4w/zjkY+Hg7cvwPlEtLZ/IiDVQeN0EhWuiNz9OlQeRS/uWOJhkhowrNny
         bg2816kUQWU6zVX4MbpSXRjFBOIUASfR2aY2oX1Hh//XX5+UYsSW3B98RaKzqA8kYn3W
         w9IkRSppg1+HTLaeOcSoqAgHFd5rLTi9lO2J+xKtV4SEg8gO+18jY+mbIkBOm1bI4ss9
         e3VG6/8o85/tJkfqUpGahugW43NPFrFgXc0OyW0915ym+bsRktgvCVAuETG3ImTjkrqV
         g7TvAmt0yu+ucFhVDR+XCylA2OVfT0m18EEy6dSxoWpZgKAkrPaPWOLMk9rET/5mHFkr
         wbSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDjoPB3Im05pPMMWpD/JioX4i85W/3iUoS/C9yEGbM5l935YUlSIG7mXCfWby0et/X5J7PlgHa0nXBVbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFgOC9JVLQBKf7X/bFWwiF7nKjl57Tawl2ubuuRP5AdppRZgwC
	nLSDsTxHaXGw+SE9oErz54KNVUZ5GW+WzOZoDZfJXBtRTo4FqFymhlLXVPWouo3ArSg=
X-Gm-Gg: ASbGncugRVRDPd1J7lfa7m85zWh8PXhMRhnnvRYcdi+6Bm19goXdeCOu1tYtOt69J6U
	3xU6bkBZ1n2dK3ALHqZRq+sFNE/mDWa5C5QAJ4VPvLyALtI36cWdPbhSgaLI7+afD2XjpirsKpt
	+4c5s7/B2vXluT/WAd+8xuvlv4AYw4Rv+X8QMNH6EWa2fviuObRbyuG5KdNu3pxtpt+p8hD2ym9
	Ht4iW4g0SIArcmVbgYGCR3xH+dkOsyP/+bBeNvttQW8nKopPxkU1wsydvkg6EYuIksbmTB4Q2zq
	RydXI2TmNcxT7jonVWrot4P0H4wUvR7Wc9sURu5bFVmMUIpa65fef1gj6kKoRkFfJWmwjKGfBiN
	igVkbnC3uCnxte/kW05eUUP6kJqjC9L/Ak+y0RPz86J0IfQoO5xv3dwDsqUsKYSmblsrLH8oO1D
	SUepFDeraQ2yNkwif0
X-Google-Smtp-Source: AGHT+IEAsN4GLGZOi/gLAJB0fdHh2RkmlNERThaNChpJGeL/SOfJubwUVSTNSVXsVki9aW7gKT0ayw==
X-Received: by 2002:a05:600c:3b04:b0:471:12be:744 with SMTP id 5b1f17b1804b1-47117932dd5mr72625585e9.8.1761074831798;
        Tue, 21 Oct 2025 12:27:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c42b48c9sm7839115e9.15.2025.10.21.12.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:27:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 kernel-team@android.com
In-Reply-To: <20251013-automatic-clocks-v1-5-72851ee00300@linaro.org>
References: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
 <20251013-automatic-clocks-v1-5-72851ee00300@linaro.org>
Subject: Re: (subset) [PATCH 5/9] arm64: dts: exynos: gs101: fix sysreg_apm
 reg property
Message-Id: <176107483030.33931.17680247324177119299.b4-ty@linaro.org>
Date: Tue, 21 Oct 2025 21:27:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 13 Oct 2025 21:51:34 +0100, Peter Griffin wrote:
> Both the start address and size are incorrect for the apm_sysreg DT
> node. Update to match the TRM (rather than how it was defined downstream).
> 
> 

Applied, thanks!

[5/9] arm64: dts: exynos: gs101: fix sysreg_apm reg property
      https://git.kernel.org/krzk/linux/c/4348c22a4f15dbef1314f1a353d7f053b24e9ace

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


