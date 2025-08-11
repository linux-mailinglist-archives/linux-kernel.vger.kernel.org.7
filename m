Return-Path: <linux-kernel+bounces-762655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A514EB20966
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7624178B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DDE2D3A66;
	Mon, 11 Aug 2025 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHnrhHvp"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E992356C0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916878; cv=none; b=WTokc3Urb4QF0O3hb1GcxAznGOkkiHDYEWZ9v9j9PhHrOfJGdGGnFFnyiF3AFH11LUMkl+EqZXHF5GtfJeMkZtomWF82UxpaO3ikUDR2lVh9ISVJDTgDwp9yWuEMq1pSDIRHJvyj+EG06JlUnS+vo5rQou3nrnhotVhVofpFEUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916878; c=relaxed/simple;
	bh=TFZbRVbWaK42j1oZOTPXuiI+mXfrZOh+cB8SKE4c1nc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MCyMoDnW+1hIWB3KykaRBlFu1tF/HTCskpGhytcXnPXz7VIe5M4fLzS4UcTRAILjqaZWtZYXdpW+jk2HuCBmCGfyMnYrAM/HKAT9XAvDHJZjx3Dr/EQicclBQblsbwKCol+0dcx1U81ZpNHLX1squr9G1mKwuyhKS5vC4Sv5NOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aHnrhHvp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-617b526d402so620230a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754916875; x=1755521675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lAJkrzYbYXDdUOmXoNrO2X+aQxNISX0LyszDf4L6FM=;
        b=aHnrhHvpz4U33RfVTQsJdshKIRthCqyK4K1bOIRkIWIqW1FWUq5DJ498qoBC6UEtci
         dkXC5qFrB9nlnrMfDvph0GCtwRb+poq5ivGHqhPXJrn+2mQ7DcKBzDFK8pgKcfRbM0U9
         vImjHdDaXP78GN6cG8Rle86zRCEEZ0Ys5M6Gb33k8Kp6I7S3RsoYSjlCHDHErMskXfI5
         zq4Dxbg8tEX7xw86yktrDNhD31UNKhC1JgMz+WLzeC3vqIzcWUxTul/se0AxFyvUudII
         xwKjfldqaCxRYrRROLHeRCuC/uVyrMguu/tWD21U2prhB6A8tIDEcDw58tyAFpa/yya6
         sGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916875; x=1755521675;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lAJkrzYbYXDdUOmXoNrO2X+aQxNISX0LyszDf4L6FM=;
        b=FBWM60WbCc9ZcSlXRzkngJYDnGUzGFH3XIWGBS/pTqa0CvB5bGDmfuBrKzbcT18o+5
         tUn4yBsAQ1AvUXTzBkvSZeu62pqy3FdRdVQmq/TYlSlzd9vZplgQWecD88iOX89PqHCf
         ze0fO3Xhvsx77qhc3JDuq0vIHd36iqZ3bsS9wNzpECqvqBFAycD4Q7aEO/RSe0yL2VGa
         QY/Q49wAPY7czlchHt+MMx4imYHI6wR8dKDK9yCgMnnhHa5vxqg7sSY34d/3DAapO/kW
         UUaACcEqLeccOwHSe/NRyUWbvLBYrweXHGH38nDbEwERTfO1uKdpAowVsngMnnPTkxqj
         hMOg==
X-Gm-Message-State: AOJu0Yz7nfkm1q8qmYO3de5LuINThp6mnoSOgsdq+QMFPr52AOOSzYpL
	MM4yBeQsMQ4bfMmIOLitGUc6b8iFYwzfmhTFW7wtUjY8JTgCdeFjLI1F4kNa2qZKRIg=
X-Gm-Gg: ASbGncsTK4hLdkkbMJ5bV84YeIgRJ8R6w9ZWHjknHuc1xxoztdGdCrDPnJsiewv+8H+
	9FQnBIdJ+BM4Rcc7Fv6JEggN74l+dznmsYMe7Ho1A4LZM9a4P0VjzFaXAD7mdCru3NjJO1/dVjP
	HBWRq2Ky9+JBun/fqzd/Bm9sH/TEUrbngz3MWdUu+GZdCevuKvsWpCgId6wsiXdrAiH9LNNQ8Mn
	ZsvVc93nNqdwRCeEe9r4OrZNeHhqW3W3L0iSbrG/jxtV97ZFXQP5QdZEqiG4q3BEnOpTPIEv8H4
	YJxPCmqYW5xb8rkRx8dpEI0oJsF4ozevSmME8y/dfFW923cGkzG3EkBN3BVLJu6t0fS/MQ5xeho
	vKUztvBaPFfFJWm3SFiDi032335VDpYva50KzXek=
X-Google-Smtp-Source: AGHT+IECY43uJOlj+dSXwBjNh9vS3ub+xUvRPR3BQ9Imlbk17n5tAWIN4VtFPlQp6xo6pwqAMMQMiA==
X-Received: by 2002:a05:6402:40d1:b0:617:be23:1111 with SMTP id 4fb4d7f45d1cf-6180afb0786mr3247729a12.7.1754916875030;
        Mon, 11 Aug 2025 05:54:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8eff60esm18727470a12.13.2025.08.11.05.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:54:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christophe Kerello <christophe.kerello@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250807-upstream_omm_fix_req2ack_test_condition-v2-1-d7df4af2b48b@foss.st.com>
References: <20250807-upstream_omm_fix_req2ack_test_condition-v2-1-d7df4af2b48b@foss.st.com>
Subject: Re: [PATCH v2] memory: stm32_omm: Fix req2ack update test
Message-Id: <175491687378.136727.8468527575102760404.b4-ty@linaro.org>
Date: Mon, 11 Aug 2025 14:54:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 07 Aug 2025 09:34:09 +0200, Patrice Chotard wrote:
> If "st,omm-req2ack-ns" property is found and its value is not 0,
> the current test doesn't allow to compute and set req2ack value,
> Fix this test.
> 
> 

Applied, thanks!

[1/1] memory: stm32_omm: Fix req2ack update test
      https://git.kernel.org/krzk/linux-mem-ctrl/c/d140f3ba76ac98faad7f9b37ef5a3dcbd57f59e2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


