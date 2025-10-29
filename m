Return-Path: <linux-kernel+bounces-876821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E8BC1C715
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93FE54E2402
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D27B21420B;
	Wed, 29 Oct 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVKg42lR"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08985145355
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758828; cv=none; b=l0/9IBaF8Tr64blykBZGJnMur3q6OGqU5Enz93nkLcybmoyd5NsRg7k3WfywgrMibYJiseJSHyN2K9SCkripnA1MsxsivPDfP7sFdP3NvCCK1EvOkAPsw4Lkh/YW/UHdfTfZFJZmPqM9hXh7uiIR8CRqnwvUesXkk5J6jM4itgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758828; c=relaxed/simple;
	bh=nLdcEjD73TqcZhQfAF/K1QDbrMu5fdY4HoqJfW/B97g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o5WfgOai8CqSXsq3es07BbZdB9+IHIZdwaCIpsqgmm2KP0JX6e4+0zsYm4WYsd3D6xnzEMX8nddDcXi/9bOQO05tY9CqtGB042Z7CA+spmMwjWLR9D1uK6xgTO/AzD52eSM/cHrVeJ3C9wL5S5KV0Mx51nckBTyuKPOeESTLqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LVKg42lR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee130237a8so94104f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761758825; x=1762363625; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTLxD8/PeCN5+lbcjiqLAGIYiVKi49LLzCBzMkykXbA=;
        b=LVKg42lRVIA1MOjv32eEmpHSEGBRoNnRNaC0FCfNt+co6z89p1xh3KIlRrNCy5CGE4
         WSlokCvga6h+N6HS55cDA0DhdDQQ60fkRS7Fzj3oCwu77TnzGppaUy6odeZ9YzmXK10j
         sOfUHj/PBDkpTkDXq0Z3gQTlg781nn5ktX+O5pTREHV0h0uI4Kgdlon/c8Vaaw4rBX/G
         bMsMMLfTp9tQQ5cJd6Y3dMi4mnfwZKAAhtxTw1M8AtF7AnRmVQWKYv1jxn+UmkMAJjHH
         gRazyjhn0IaKo+69o1BvUZRyklYmgaiQiRQoihTPKQkViSqGNgo/PrbeihmpbZqP0MB1
         Znvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761758825; x=1762363625;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTLxD8/PeCN5+lbcjiqLAGIYiVKi49LLzCBzMkykXbA=;
        b=EkmRjyNqXyV9tsJ7XiglwEb7vh878NdklrgB7vHksDG7HgwhWWxvAwX0HeB9gupmUm
         ejo1wOeqews3KKiH4gMvBglqYZhIZEIVEK6yq697cdPu1YbCutwHVEuuYhLhxsNhVoKl
         oc2Flw75PXbwCOtUTcdnSdBZlZ4HSLaZXXT1BwpEoEyf8Wq6fOOQir8MXuFNiHAoKLli
         mycw0mY/nrnQjX1rwxq+McbnA8IyO8CYgzzD7JaESkRibw55hZt/pdml3XZegblcd4Ib
         xpNKrdONGS0aPHVMzyA5AtVTEKgpp7rhVvMmAJ265xOAadn8jh4NQg262zjevNbWibyD
         05dw==
X-Forwarded-Encrypted: i=1; AJvYcCU0jDmKcWZCOS7NQ37jHMEWyZYjIYO7taRLBUzCKGFCTkLn6Ai/DUu7A8c2sDu1qK/R8Dxn0seQroEI8uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvw8cn1oR9rEeh5QjOzEgzO9NppGnWoVwzswQFGZwuL0Vo7UO
	jDcEvhF6SqZg+77oof9vmuuyCgJjRKQDN6jbA3lYpBPAxavnmZh5m5UiTuryNTmDpGg=
X-Gm-Gg: ASbGnctf0PDvjse79b4cTJuns1jb0lqrcTJ9jTlf9wIMy+eBOlB9Z6YUE98da1vmWDv
	AkdxAbjGeV4hmHrnx2kttRVFpH8TKEy+Oh4lWwYJOwz1wE9uKb/nKLcP0M4fNMb2olIASaiIp/7
	tlCZoZxD1BO18qms+iQtPqsXG5uHyOr4m4auRGMKf7o8Ic3PYTuKePWRBJK7A04fAnEZpP7JSgJ
	rXLENIgqFhAU09PGvsqmniQsAlDvKv38SkirtxgPMoDX76cH5r1sEk0+Du4XsjPJKuswIzt5Rf9
	CP1kc+ZwGVhprFKZdRyDGpIzmWm0h+3Vm26vyW/PqLtsWByTJ5w5tqolMoLRhzUaNOxQ05xgUhf
	hQpIX3axgyL+TSqu5oxh3bECG5uIjVIQmqjmCjq+v91cfwNA5fcOO26cS5FoLP0jtiduDGM2SEA
	xFdq0+9JXTNJ0KSa/P
X-Google-Smtp-Source: AGHT+IGrGTlJHnWW0SL55uNuRZuTPbaR18fj1P8buI5Z3DCiqzFLCxkZpjc9Q+yRSyDaqaUQ+bJ/OA==
X-Received: by 2002:a05:6000:220f:b0:429:8cda:dd4e with SMTP id ffacd0b85a97d-429aefbbd70mr2829627f8f.32.1761758825168;
        Wed, 29 Oct 2025 10:27:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952d5c9dsm28545855f8f.26.2025.10.29.10.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:27:04 -0700 (PDT)
Date: Wed, 29 Oct 2025 20:27:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lee Jones <lee@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 0/2] mfd: syscon: introduce no-auto-mmio DT property
Message-ID: <cover.1761753288.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Most syscons are accessed via MMMIO and created automatically.  But one
example of a syscon that isn't is in drivers/soc/samsung/exynos-pmu.c
where the syscon can only be accessed via the secure partition.  We are
looking at upstreaming a different driver where the syscon will be
accessed via SCMI.

Normally, syscons are accessed by doing something like
syscon_regmap_lookup_by_phandle_args() but that function will
automatically create an MMIO syscon if one hasn't been registered.  So
the ordering becomes a problem.  The exynos-pmu.c driver solves this
but it's a bit awkward and it would be even trickier if there were
several drivers accessing the same syscon.

Dan Carpenter (2):
  dt-bindings: mfd: syscon: introduce no-auto-mmio property for syscons
  mfd: syscon: Don't auto create "no-auto-mmio" syscons

 Documentation/devicetree/bindings/mfd/syscon.yaml |  4 ++++
 drivers/mfd/syscon.c                              | 10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.51.0


