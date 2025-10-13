Return-Path: <linux-kernel+bounces-849830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB55BD106B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FEF18916C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45CE1F4C9F;
	Mon, 13 Oct 2025 01:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yj5gAkhf"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9078B1DED7B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317301; cv=none; b=eCuPqoARzcVqKQOCEYtwgYcu453E7xUAU3H7gxlnxN8ZCjwrnG6Yh5yJaRIyD9I/avLLU0XxKa18OvVPNe59reS03TQzxzFjliXRWFYohPcAFqpbYjYL3m6sLyGf+H683zaHPcEqY4qrKEknMtuo91sLitJbEYT6EaPUGEjs0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317301; c=relaxed/simple;
	bh=vblrrA1PTLfQIEhi9r3mgnNvhMqCX1+5f453+YraP/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=caPwZnkNRzyfdAKkQ3bk7hrd53Q3Cx4NlUuMTGL7l+lBJ61OHFL04jR5DcaDCrX2268iPR8rTAKWjOgGWnolflVx95x5sH0mctUXYnjysNefZqFH7+lJ8qIL+DMB6W2GJ7FbJJgQa119x+Rs3w6haGxBgvW8Yuzt3+nIX7IXq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yj5gAkhf; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b62e55af64aso136810a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317298; x=1760922098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUCP4LKA1bDFYppqppgto8MgAIuMCRJ1Lo8b0QTm/8I=;
        b=yj5gAkhf6BBL0MNXA02+hw36MWK4tBitSyoh4BfsDTi+al+MuFeBXCdJEeAkTzMm1s
         MignmTDKUFtgYQA4KjKucC8ryLXj5MsNwh6q94RyF87l0xrWtCogYC1G0Ax4wMczW2YD
         4se0k6ekipB2gJoK+COiIUwM/JnMGwoD6aRd0XVzhUYWe4Fs2bPzEILQyQ8CW3KUIAf8
         zNAkScD0BZOn1HUV+Wu57bKOD+NMx+wIy8lAWtokhey9J+O4PuUjFngMv4tmbA2trDJv
         9fP5ZEqjeq3neRZBvXnHwXBRWiRXqVd7IhsOfsqdlAK53e8JRllgck/vXAcGR5/yOKtK
         t6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317298; x=1760922098;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUCP4LKA1bDFYppqppgto8MgAIuMCRJ1Lo8b0QTm/8I=;
        b=PtwtYnmqV+3l2DUqV5q4wSlAt5cU7XDIYNPV0UEh9NIjz/ronR2To2YRGH5OW45PpG
         XOy6CjsJMlUV2o8mQR/RheOXciZ5HVb0ZBjj37N+PGGlHfuXPcX7ZgMkzBnpsWAMT5IH
         /SRd7KY9JY5ky64vFDXVqW7/a0FM0AQuoZRaQG+43qoafwktrPc2mhYAlO+4Bo6QYGmh
         tmHH8ce60gkvgn1UTwa/Rv4gpLoPad0qT6XMhVK8wCH480mRHijOYsTEYR90XWu5mFws
         zeuk2iENHkWaHBkK6koFcfYnwVzmCaHK1x7BqYjVNTJkyo1b+yEe23SL8bYoLD8n9bQK
         s7CA==
X-Forwarded-Encrypted: i=1; AJvYcCVJw8vVnnv44YUnbFV46Z2ixj9RHxh2DBYvq5CPFwYHDOd7zPZgNPBaSYIL8Z4qXPnJ16SqzUC7s9KPgGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyyz/lGnt3BBIvZXhifqCtmBbp25kNoPJZ2UmxDMC3+PAdNxRj
	e7PwbuQX1aWp4wbddtYpgnMXmmbBQ2s7YuC9gO+Be9b5XK8TI8DRTX47p7EJKOOUKwU=
X-Gm-Gg: ASbGncteUx9yag61rwHWIdB7VbscqDAWt5YNgxFsneOsQVwTBfDKynDVSn1O6yJR0Pl
	mYHT8VP4VR/5Vm0DUHWo/10EGvZ/krmgtS4YeQHlVpuodmF7w3ZXQsAM4fNsKSS3bK9+TV8kn3t
	+l5hf41nMHBN0zv6/32U43vUoRohxWROQgpo27+UajKFi+BW2gTmdfYaZJbsOclDoGNu+WUsNDM
	eJKFeVCzu1a2KybvkQG9b+CFKmsBmnyBEUxS4tU6x7MuLJxkvDBvYe9Yl3dI0sRdgDo5oYFnsgP
	NKNDmjl6HO2JHar7h1tmhPy0eIYj/LO30g2YrADfNcMXrfzjyXCaqBFHFmZs2F/2BiHIWcIlS9M
	bB77UwuhpmDD8k06dby6R+PigucGXgxPmeGKnBfKzaayzwc7vaMqLAo8xJwa5ekEeGFh/Ito=
X-Google-Smtp-Source: AGHT+IE1B9hR89kcu5D4i0PCjI7kQyz2poCnY9xOFDtLABQiwPAkgeCMqEBV5hkmUp72wJBiyTt0Ng==
X-Received: by 2002:a05:6a00:b50:b0:793:1b79:ee5c with SMTP id d2e1a72fcca58-79387c173d0mr11494869b3a.6.1760317297843;
        Sun, 12 Oct 2025 18:01:37 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm9512805b3a.64.2025.10.12.18.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:01:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
 alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh@kernel.org, conor+dt@kernel.org, sunyeal.hong@samsung.com, 
 shin.son@samsung.com, Raghav Sharma <raghav.s@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, chandan.vn@samsung.com, 
 dev.tailor@samsung.com, karthik.sun@samsung.com
In-Reply-To: <20250925130457.3476803-2-raghav.s@samsung.com>
References: <20250925130457.3476803-1-raghav.s@samsung.com>
 <CGME20250925125616epcas5p37346312c6a788a5398212f671d8a369d@epcas5p3.samsung.com>
 <20250925130457.3476803-2-raghav.s@samsung.com>
Subject: Re: (subset) [PATCH 1/3] dt-bindings: clock: exynosautov920: add
 mfc clock definitions
Message-Id: <176031729214.32330.12498017940011083883.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:01:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 25 Sep 2025 18:34:55 +0530, Raghav Sharma wrote:
> Add device tree clock binding definitions for CMU_MFC
> 
> 

Applied, thanks!

[1/3] dt-bindings: clock: exynosautov920: add mfc clock definitions
      https://git.kernel.org/krzk/linux/c/0b94201e327471d034d81cf5fd2131a5529eea19

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


