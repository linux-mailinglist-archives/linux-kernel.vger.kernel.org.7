Return-Path: <linux-kernel+bounces-863589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C0BF8402
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E51E3B3A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE77351FD3;
	Tue, 21 Oct 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+4Z/sSv"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7203502B3
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074833; cv=none; b=jILNDHwDAidqrQ0MLBGFx6W2r/wH90hALJ0cZ2iNigr5QzR5pTPaSK5KQ+THaK4cwsiMsN6VBEGRK7MK74U61H6FIOaUPpMTKbC9LGzj3NCXxtrnjvsjieJ5l3X4eZLEPoTJ5qxXtTuXkYk4ChExmF716obZTqiqRluZIWX278k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074833; c=relaxed/simple;
	bh=DeJqDi9szQA8p7WmTtRsNFt70PHzVsGKe9eHiJ9l310=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nN8dnCNDjjkfFp9fJE2O+G9fYvaRR4WaXSyXxdATJpoVeOVDnVZ2bMlnQrFCzlMxBCZpgmYHiIzClgrA1QXNr5wTAmMRyG28uXEmPXx4JfOdnTZG5D7NHJYiNAjzcHRSPXtQcc8cAxs7M4mX97cto7xFmtc6SHwHDJVsUOPbfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d+4Z/sSv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47112c4abc8so3822115e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761074828; x=1761679628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SCUkszQLT3jhOeJ8xWYrP1u+Oz6oVJ2BJ9Vl0R1XPo=;
        b=d+4Z/sSv4UIy80HAt4Mvgmb6afc92SvGkb6sUSlw75O1hOa7k2EmLGgiZTLFgU2C5j
         r0cb6sbWMY3N/HEJAwioAoOQimpSmvnej61OXXBLm81+epzjdSY5HBSmAplS6xoZDW2f
         1siwtTKbdKyLURAJNkZqR0lBGiapvFhVx3gl9xCV6S1v7uN9sQaj1nfg77ytqq/jDspu
         eP44b+xaU0wIRSTq/sbkC4SEO8XAJBOqaKC/0fuRtNlAgqWohUz7ya3a+slp01JIeR5P
         cC7OvgRIPtB3Ni60lou8A9ohsvQoC4AqgVWFJ5cv1hAhUUtJX2p50Xq5bJci8/it02Ui
         a4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761074828; x=1761679628;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SCUkszQLT3jhOeJ8xWYrP1u+Oz6oVJ2BJ9Vl0R1XPo=;
        b=bsO/l7UONk8AM1v1lLUi5xT6hti4NUPWpFKSXsx4AbnhRPTWXYKN4e2f0aN+K1QAe1
         Z/JGrABTH6q1R8BBxt5zF5Os9HbfUPlybYOJGYKjzO0Zw7kni8m9GNZrJf9Ved56EZl6
         9WThJhibldznDMPAPwWcCRrPX7WnnmICMcsE1KgZU2t3MkbqpQZMDBw8UoK0fsg1sFVA
         9OWyZOBeyy9oov1HlfGrLcVQP1jqctE/z9FyS07Me80caQ+XQ/7FJ+IGWVNuCB4d2HQ4
         wUlJDcm3AD7ydbRvf+MLECU/4kSNBvjFhhwoE7DhBXDW0NvPReT9niF6ZdD9vq7aRSsb
         4C1w==
X-Forwarded-Encrypted: i=1; AJvYcCW7/AR4vY6Jw8YqDHf8RATYfjmzhqysvXVVgtZCoFyU27ZFMwLDWO/hs6fj6YzZACMDoqvloVEHJMuEPV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydCLpq2JOYCwPLWGklmU4KbowYzPzLp8nq3fjGKFWnnFFRbw9T
	a5/mCL8w+nK2A+zC/di3jcsVf5iwj6Q4JqY5urWLX/Endpdxcr6OVeGA2NVZiooCwC4=
X-Gm-Gg: ASbGnculi5wded31e2zFuJ9J+J5sx5s/cSKZX1xRz7Ma4x0i+8Y4r1Dz9GhssmmxdYj
	v1nzkJwJj58neXFIkOIs60p6rWczESd7hi9B7VD3F7lu9+oMTbSzmwMyqpXNchXgbqQA16t4cjn
	UNqeKQtzmEgIDaEEL9subYmnLVLel0tYnIDVLUf4d1EIwAeGCky4YDWOhsMZEgiS+ngva1yajXg
	v/PVGB8MlLfuRE6NseDS2azU4W/OfAo6KHwWqi+AOvLVfNFpdMR85rFLLKWo/3/pkDbyix4v/io
	kiHn6RD+4GZxBp1ILRzGqcC4t0fNu0W3Ib/5yOXhQuDDE9DRusdrprGy2ew5QCrSwIajUksLUkV
	rRcZITROEjFT423zK6/mkcUmp98feY9fOBhRM51K4UMlMxfgX02WLFEYZtd9fKwlLDbawiIfHKz
	5fCFqNXWSOhq7o73uvoBvS+kGK6rFYn7BJll48kA==
X-Google-Smtp-Source: AGHT+IEyLv1lnWbFD6puUzU9WbOWyzqsLRxtSYF5/o3s87IaGKKi+zQdweoF9FjJ4w5n57/TykzA0Q==
X-Received: by 2002:a05:600c:458a:b0:471:1d8e:3c7c with SMTP id 5b1f17b1804b1-4749435b2b6mr19420285e9.4.1761074828560;
        Tue, 21 Oct 2025 12:27:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c42b48c9sm7839115e9.15.2025.10.21.12.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:27:07 -0700 (PDT)
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
In-Reply-To: <20251013-automatic-clocks-v1-3-72851ee00300@linaro.org>
References: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
 <20251013-automatic-clocks-v1-3-72851ee00300@linaro.org>
Subject: Re: (subset) [PATCH 3/9] arm64: dts: exynos: gs101: add
 sysreg_misc and sysreg_hsi0 nodes
Message-Id: <176107482703.33931.10968219434076858681.b4-ty@linaro.org>
Date: Tue, 21 Oct 2025 21:27:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 13 Oct 2025 21:51:32 +0100, Peter Griffin wrote:
> Add syscon DT node for the hsi0 and misc sysreg controllers. These will be
> referenced by their respective CMU nodes in future patchs.
> 
> 

Applied, thanks!

[3/9] arm64: dts: exynos: gs101: add sysreg_misc and sysreg_hsi0 nodes
      https://git.kernel.org/krzk/linux/c/08d9d0d9ae6f9f83bc1802a3f8ab2a4801ccd3e6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


