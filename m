Return-Path: <linux-kernel+bounces-835290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E39BA6A51
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AC13B83ED
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8386D2253A1;
	Sun, 28 Sep 2025 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH0tUPNW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB502343C0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759045752; cv=none; b=PZqBSwgvi6yHWMlL3hSPMqkpTjnyHqyXoLLMf05olY5rJzctdr700QV/L3c1C0sAcuFwdeRFGA0qs9xAFx8Wv3ML0Pk6cW7CAMsPlERwbxYhBFi+ymr1yV/3HmeJKcijtO8MVd1f0BIzAUjAyFGjtviD4o1GAyqAEs9QnFugOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759045752; c=relaxed/simple;
	bh=j3c7FouKL5skROTw/0AZy7/egEPuFd8LTlkjIptlo8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxP8XL3C9AplCWfClAQf4N1SWqpOYIdqigI/iGeeYjGjgoi9qNqC1wzmuhMCFMbfsXZc5SpUW0nlwd1OLBp/6BAU4wg7nlarUtM6AsoGAgXvqTxbKmogxy6DKq7vAuA27xkunP/qpvCIbmnJEkGsrn7YkxOKl5Z5xhhPsCLij9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH0tUPNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F5CC116D0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759045752;
	bh=j3c7FouKL5skROTw/0AZy7/egEPuFd8LTlkjIptlo8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TH0tUPNWOXiE9Yp0HNfjHiCRzHo6Xl8G3gaMO4RDp2sCiKLgFUhIt0HG9LxAgmfQO
	 U9ppC8IzQVY/xYHAoNSHkRqF7Rp+07O4Dc6/pVAwVazYaxKkV96kIrMP43Vkml2VGS
	 3TuHYQi+n2bHCe41nLm1h1w+yBMGnpudw1aoe3wHOVkwueF92loin9Yb/z0Ctbf5Oi
	 V2vcZ7tk3RQ+35l3gbvR1p9MzopeJ5fTad16AiYYUibvnzLUp8m2ctMdz0stJSfKFB
	 zbV4FQ1a4kZYzyop773GUltVKgLn8jMoRTbo6p3+qvvRUf9I97KZpBfrwlbDf70kXi
	 9QDa8cSECKbdA==
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2698384978dso25972675ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 00:49:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIf4F5h0pozxBZpCYUNp4fGzkf3Yh4WOjzwQskGBif915p5WsRKTnTOUBFf6+rrxBEKg9bbgmi1GByGUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ctiZRwzTPXwSg4p7qp8e3qvsWOnNgrliwR5QMXosJmnbjM6t
	HX0X9sy+LSxEi2dR3Iqs/t4faxDuVQIzTiDZ6UdOGnhXitor6q8QHqvXmx9vZ9gtlaOZdbF/qXF
	bTE4V9BqjmT2kT3Whj/7ZRy5P9wVPiXI=
X-Google-Smtp-Source: AGHT+IFpUdHB/+CVUZHfkEdJ2POKP1ak1+lRPx1y5PN9kbJW6f15ZFTm715q2PK5y2cB/xO4zd6cpfsv/m5ADSjkezo=
X-Received: by 2002:a17:902:f708:b0:27e:eabd:4b41 with SMTP id
 d9443c01a7336-27eeabd4ef9mr90231205ad.7.1759045752063; Sun, 28 Sep 2025
 00:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928070419.39881-1-make24@iscas.ac.cn>
In-Reply-To: <20250928070419.39881-1-make24@iscas.ac.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 28 Sep 2025 16:49:00 +0900
X-Gmail-Original-Message-ID: <CAJKOXPcFzHYV0YWmWqA_ZoMBFyNSOjizBJi1-qLR73dPO0-qtg@mail.gmail.com>
X-Gm-Features: AS18NWCp5rbiQcjWZ6kRZR2AsSbwoNU0TngRkgKvQDxBcN8z2LXAnpJLBfP7Ulw
Message-ID: <CAJKOXPcFzHYV0YWmWqA_ZoMBFyNSOjizBJi1-qLR73dPO0-qtg@mail.gmail.com>
Subject: Re: [PATCH v2] soc: samsung: exynos-pmu: fix reference leak in exynos_get_pmu_regmap_by_phandle()
To: Ma Ke <make24@iscas.ac.cn>
Cc: alim.akhtar@samsung.com, semen.protsenko@linaro.org, 
	peter.griffin@linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Sept 2025 at 16:04, Ma Ke <make24@iscas.ac.cn> wrote:
>
> In exynos_get_pmu_regmap_by_phandle(), driver_find_device_by_of_node()
> utilizes driver_find_device_by_fwnode() which internally calls
> driver_find_device() to locate the matching device.
> driver_find_device() increments the reference count of the found
> device by calling get_device(), but exynos_get_pmu_regmap_by_phandle()
> fails to call put_device() to decrement the reference count before
> returning. This results in a reference count leak of the device each
> time exynos_get_pmu_regmap_by_phandle() is executed, which may prevent
> the device from being properly released and cause a memory leak.
>
> Since Exynos-PMU is a core system device that is not unloaded at
> runtime, and regmap is created during device probing, releasing the
> temporary device reference does not affect the validity of regmap.
> From the perspective of code standards and maintainability, reference
> count leakage is a genuine code defect that should be fixed. Even if
> the leakage does not immediately cause issues in certain scenarios,
> known leakage points should not be left unaddressed.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 0b7c6075022c ("soc: samsung: exynos-pmu: Add regmap support for SoCs that protect PMU regs")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the typo of the variable in the patch. Sorry for the typo;


So it wasn't ever built. It's not a typo, it's lack of compiling, I do
not take such patches.

You didn't respond to my review, so same comments as before.

