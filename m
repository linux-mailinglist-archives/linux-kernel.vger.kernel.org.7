Return-Path: <linux-kernel+bounces-885900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442DC34350
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8745218C39D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6DF2D24AD;
	Wed,  5 Nov 2025 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmPiwXGU"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29719A2A3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327526; cv=none; b=rdIz05JCaHnlukecq2HOpAoPSdisu830m2ja/McfkTxW3GT8eua4UWakI8AgoZBFMhUGwqVQvRrx4RXOA0n8kHX/RFk8kHM6b/U15TEMnbYvWsvdZ1lVEjfuJkguEnqWFVDW6gcUdFAvEaANxFPLBbuHiDAVmGTbo/gtaIePoUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327526; c=relaxed/simple;
	bh=tvmPBYZnlM8mLqw3SaLismRnZ+xLMx/VxpTUkKe69Jc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L+VB2u0CkeqL3RY8P6SyWahhbK3IIl6gyIeJ1mOrdEj/nZTHyperPbj7pc0aQ8HDIYNu+EMhQI8ajZu0uhpEE5Q7SBTR2h2iM0IY41cNLg2Od0O5N4xiqxewHkhkuQWyENh61Iq3GS/ck5D5YZ5bvRD9e4yHFtpc1Shvhy2DWJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gmPiwXGU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640fb1e568bso186635a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762327522; x=1762932322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIb/KYzXNYt0u1RpA2PEFtOULDEYN0eGfooGuJh8/ic=;
        b=gmPiwXGUxFDhxWgB8oDGH33DrDsUQktXzPpHGpSY5WXjj0Cul0afuRBhGPQP5RADYT
         Sed2cNOZXDYbs6zIgcHQOq5e/qq2BwwTXEr6r0CHaO6C1DdAEbovYHARzjCpm7vgCnyj
         Z5A/3Klo8A39lagFqrso8S8Ywi9qzzVlpLVhEiSxUDdueVH09QJBP2SdwLqAr6FYc9JO
         CXaM7D1W/0gBPoT4OOV1KBykwM/vp6lX/dMb7k0OjjeEEPeOJZmc98MRwrev2blseXjf
         W9ccaDr6DHlsl+cPLHG1iSiVm0P9TdHSrLi2sAPX02C7jHNeSGV271776g2KZrKfKpGC
         2iAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327522; x=1762932322;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIb/KYzXNYt0u1RpA2PEFtOULDEYN0eGfooGuJh8/ic=;
        b=aoU/zT7y57pIfOJb51dU0LG9kVckCnskcibGpMvbbU/lt4wmCLJvydaeZM7qcs6q5k
         nlan6hcVD+ypV58YOUJ/7oaAZdGlEvG1fiYZ4lpNljov1fws07/etG//M8EFtDrg7SMK
         K7JpvlkD0owc1ik0zzNm4oDqIUahlgC7+VQRM2FD1oAko+uTr9WTRNlQsgAnfX5S/q//
         YEHhzhzkKQtUWad4hNaKFEPbfD7DqlL884TFIPPoDR3TsPkWVg0y7s0qYH9xO+BSUAv9
         UNSLw6XmstZitAHxbigped0ypKRe1khXNQP8BrIsqrPi+VXhKnBpJQ4rtvNrURFBJU7O
         zUlA==
X-Forwarded-Encrypted: i=1; AJvYcCWI6w7TSndC9pyODYb4WvUQpvBLAJ55m7xsDaafHFAUYfulIpy/rqlo/BPkSHZnprNxsHgGJaiPQHMEMcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0UoXyMMYLdYO8ygUVJH6TdEx6z759QCPP/YlGIPcvR+F2Fc8R
	qPz0ewwUJCFTa558Ndn/hgSw8O6H8uEmU+XbkDOSKRboa6IAx5IFk1PHmI/oFcEJBbw=
X-Gm-Gg: ASbGnctx7fnxd+req7nosQt38ivKg2tUcg3PPYZVcafyvAXc6M2ineLSY5u1sY+Nabp
	C2Z4Yr5KtQus6UqbwDY43ix7JHti7MrhYwa/kM0vLzF1RK3ZmCFi7FA0US2qv76xZwOtjcXYpwZ
	OjPk7Op5/oJdFKfxIcd9K+4JmLgveJidTho83CuS4Er4tSo1lacx7XIyJy1GvUJ1j21xBaAMKcx
	tBXIDJzmU7yLo1twd/+tVTOXtQ7guxXOHU7OovwTo4ptzA/t5ShQ7eVQi926lzfrvQcMf477XYq
	bIMeZe5Tv1wEH5UavmgVQNU+g3mQIlbDcYsjTLy//nPIzgGIutEoEuFVdAN3TGY24Q5+4HDFWz5
	WF/KtZodyf5W1iG8CAsJ40p3R+AL3EQ4TwrmG6AIBju2Qco0J5i4/Xq7MTHX7ytoOQPsvFhoiks
	6UvyAHHCwjnl/ZF7J0
X-Google-Smtp-Source: AGHT+IGzPFXwhqPyvOn8ewQmtIhpOZEz27+6Xn30YUvZx2NGtmHf7a2VZK75fukyF0zZjg0re8/YsA==
X-Received: by 2002:a17:907:2d0e:b0:b70:b45d:d9c2 with SMTP id a640c23a62f3a-b7265687d2amr98936366b.9.1762327522067;
        Tue, 04 Nov 2025 23:25:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f8c5bsm411534866b.20.2025.11.04.23.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:25:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251031-exynos7870-drm-dts-v4-1-c1f77fb16b87@disroot.org>
References: <20251031-exynos7870-drm-dts-v4-0-c1f77fb16b87@disroot.org>
 <20251031-exynos7870-drm-dts-v4-1-c1f77fb16b87@disroot.org>
Subject: Re: (subset) [PATCH v4 1/5] dt-bindings: soc: samsung: exynos-pmu:
 allow mipi-phy subnode for Exynos7870 PMU
Message-Id: <176232752047.13426.3419883403605615740.b4-ty@linaro.org>
Date: Wed, 05 Nov 2025 08:25:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 31 Oct 2025 00:50:15 +0530, Kaustabh Chakraborty wrote:
> Exynos7870 PMU is already documented in schema. Add Exynos7870's PMU
> compatible to the list of nodes which allow a MIPI PHY driver.
> 
> 

Applied, thanks!

[1/5] dt-bindings: soc: samsung: exynos-pmu: allow mipi-phy subnode for Exynos7870 PMU
      https://git.kernel.org/krzk/linux/c/81280d39a2f9e7dc12056db889da52cce067b1b6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


