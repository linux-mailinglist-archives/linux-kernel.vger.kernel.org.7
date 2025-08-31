Return-Path: <linux-kernel+bounces-793456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF371B3D3AD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B761894783
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A9626A1CF;
	Sun, 31 Aug 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiCZn2Rk"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD526A1CC
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756646901; cv=none; b=TGPrMeqet649wUBsH8OG3LI6aZMc1j9yvEjnII+Ewe1LKng/NlM/SRO0bwr7eAe+kat8gpEDKOGu9/k0XkkRMckVB7v+kYPBVlz0AaBwHx7fYH1nopnEF7xyMhLYHUBamWCL582jv4ejRmZeEAoZDUXbv/9qsEBt+Tt74mam3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756646901; c=relaxed/simple;
	bh=LdivQQ+HHnZWD9LIPqe5v9pOuvWPc7P5UYV8ZAoOTho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eQBwiydliIwvZzW3lgHgk339IxQ0vqtllr+WPkZ9ArpcDqhAa022Qj9yhoYa4ewy9ZwDvVCmHrcKwDyO42/KM50uq6JpkhTppQjNk0Ft1Sz0AMtWXA8RWeVXJGzCbsjWlbfqIzfc3DUkHQ2dC9QejZnG8j5ouFIJkKbSMsZpWGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aiCZn2Rk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3d6af847306so1556f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756646898; x=1757251698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuVblRpOdjWQCfpwKse83LT8IgPkp+MhNhnqf1geLpk=;
        b=aiCZn2Rk10y3E6tYyekqS7YbSY8SY+93KAD+xThLDbMxjJnLCqkcD18G5ZLBbqceCH
         Xj68ArzsBIYW6qwWiwRn6kvMY4GCop6aOHewJgETm4jjptSYEzMgqmt72Yb8XwnZbXs5
         kKq6N9FNwq+BXptH8fDrYU3vKNGMdYwpXhtFGVk7tOwLSoFKF9JAlls6WRGX6054b4Rl
         g9DQdVGqZQ2CWk9oA+z+NKpgEdUuyK1CkYTsNkV3s6pS2sZkEvpYMXCvzbP9Xxj3Dv2l
         1FH/91BG//8XA6T0nz29P3lCHfSPFhjv6/BG/qZzpOHpt4qlqPcePFXJvZ/aAaraG0dt
         Pv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756646898; x=1757251698;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuVblRpOdjWQCfpwKse83LT8IgPkp+MhNhnqf1geLpk=;
        b=Zuv1LBFGJHJHJ4bG0hzlJFwUBAowQBaSf06ELCoLaVb2ipO6PGmwJChdmso2YuJ7u+
         6G1jzd0Gth4lTdhOWitFX4NkJL7eNjErCRhyWSjHrGfCXgAdumj1ECsKI2Vej6hszNCj
         F0rZSoVi/16Pfg10Uj0NAfY45kCtg0kfBWY6hOKySFIjnNFIG9pxYRFl4kcRt7CfVLRy
         c/0sabAvAMCUO4oYiPZU0kWWe6lcKqiWCga6/Q/Alyy8KZeIw9GS7yYB3qduBNmQZfWY
         qefmeijxvzuZB+CEkaog4fab7nf6ahDai8PjWcErW9NjJjA+h5O9chAN6rkHKs9rPFGv
         ySjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpNTMHxOJDCunF6NaO/JMMjzj2qNSRyaHBbIbARUw7NuDg3S3Ib9zAWyjcwdl+RblaMaEgO7r173JwQh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuXvk0kRMv7BPmhvvhpL1Ezxf1dAuUxqhpsdEmNEIsOgFjaGo4
	pt7IAj4EDyX3/Hrx1j4iObzDVzG5PJI2vzT0A2E1aK+1cotg2wlAKf0QVechnQLn5/U=
X-Gm-Gg: ASbGncuh11GcNnsL+5vvC1kN9cAOaQySzfxH5wV0c5KZciMDIRnLU0unbnTLASOlN9a
	vrW+e9klaq9tYdpN0wvo/TbBx2vT8q7aYOjmwxJC2W/25GrQq5P4omw/ZSdwmTFMcOYveb01g24
	7IAtnMv246OiDOJz9PCi3/fxvjDMY0sP/n9CZvaqMtIwr2LOoCHXyc874NOQUEwbABDS2saCaWI
	DVRnC7F6YQVGzbuma/QHQjTzlMg8E1zIaBV8yLCJC+SV+FW0V+SQX1j3SJuEbBg0fVQuHRSbQlh
	UkZ7QVFWOwZrQH9gOFRIrqqlZwqRY8eXsHV/2zyeauaaD8dk+GlLI2KNsgsvlFqRRF9lf71e86U
	ZAhtPp6qiSIPYSbyudhneF4Y94ExWJGBM/gNEB3dZvwyWV53YNQDVNqvI4Gc6
X-Google-Smtp-Source: AGHT+IGjjCRfDtUdQVx88kWUHZJxBBGxwDC32T0AevVKpXcpfKjnIqL3cEb2Sd3S+uivJb0HGuqySg==
X-Received: by 2002:a05:6000:2dc7:b0:3ca:6c06:70f3 with SMTP id ffacd0b85a97d-3d0f967dfa7mr3081239f8f.1.1756646897869;
        Sun, 31 Aug 2025 06:28:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b87b3900dsm29956925e9.0.2025.08.31.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 06:28:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: jesper.nilsson@axis.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org, 
 s.nawrocki@samsung.com, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
 linus.walleij@linaro.org, tomasz.figa@gmail.com, catalin.marinas@arm.com, 
 will@kernel.org, arnd@arndb.de, Ravi Patel <ravi.patel@samsung.com>
Cc: ksk4725@coasia.com, kenkim@coasia.com, pjsin865@coasia.com, 
 gwk1013@coasia.com, hgkim05@coasia.com, mingyoungbo@coasia.com, 
 smn1196@coasia.com, pankaj.dubey@samsung.com, shradha.t@samsung.com, 
 inbaraj.e@samsung.com, swathi.ks@samsung.com, hrishikesh.d@samsung.com, 
 dj76.yang@samsung.com, hypmean.kim@samsung.com, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, soc@lists.linux.dev
In-Reply-To: <20250825114436.46882-7-ravi.patel@samsung.com>
References: <20250825114436.46882-1-ravi.patel@samsung.com>
 <CGME20250825120725epcas5p36cdf2c4e839db307f1cc0dc81346b913@epcas5p3.samsung.com>
 <20250825114436.46882-7-ravi.patel@samsung.com>
Subject: Re: (subset) [PATCH v3 06/10] dt-bindings: arm: Convert Axis
 board/soc bindings to json-schema
Message-Id: <175664689576.195158.13430798793147668085.b4-ty@linaro.org>
Date: Sun, 31 Aug 2025 15:28:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 25 Aug 2025 17:14:32 +0530, Ravi Patel wrote:
> Convert Axis SoC bindings to DT schema format using json-schema.
> Existing bindings supports ARTPEC-6 SoC and board.
> 
> 

Applied, thanks!

[06/10] dt-bindings: arm: Convert Axis board/soc bindings to json-schema
        https://git.kernel.org/krzk/linux/c/ea0484e4b82b3496310a94684dfad5e61421f633

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


