Return-Path: <linux-kernel+bounces-860189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 048F7BEF8D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 789294ED3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EF62E0B6D;
	Mon, 20 Oct 2025 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qwco39ka"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B92E03E6
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943365; cv=none; b=PPcvM2eDZvpa1j8tjmGGj9v+D6hsh2A4l/b8UmDXtRy//GSsUo8WglyKtFLapO6SuveLUvBrsYtFOQcKnXb9HxtTLZqlkBlFzxavIcPi9t6mp0zhi6+GtNM9qR9c0ioVF2J3SNqyyfikpR904C5LP3nUOtySuPg6X9FaqXMkjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943365; c=relaxed/simple;
	bh=z/nKAyPM8Gl3KMi0qkV4zPK4PT1ivqYkvCn2i3d2YbQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DhNobcbnSvJYrM8bKlBFXNM67FGRUDZcjW8xG0WHhSxRVdLUlYy97YTpuBgh1q2Ppu8YkoSpEi6HvR4bZ+hEO6bEKHxqNh4Srn5kjApnNb6YbrsuC9hjXiP2k90Lv/wgtkNjSjCIt2gwjMHO2p7N20xx55cJFKY9H62BZ8XpRCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qwco39ka; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3e8f400f79so67271866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760943361; x=1761548161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0DnThhMkOfv9YGDKUQ7VwqLvt/fY4Aetr2LPisH1YU=;
        b=Qwco39kavjz9il7ru8MtW5CXU9oQtMYm3H1N/9YBxgXD/W4XxEhLGKfOUf43SgT1i/
         RhfavRnP0oMO2Y20DDLK3bAdyoIJfjf5TUhitKoRcTSDsdb7VXHZerZNdfZw/tahdEFQ
         QnVltwZOLNuNigZKJUIaODhua8QhjydxVTnra6CIUiZDQpHARxZbzB7UiIYWeLkPixdo
         HCsuzc9+2ZUtfB+XaQsMgfB05FUZ+j+3NYzL2/HniY3xK6FXNwubNxQH0ToORTIWHr2v
         JpAgrTrbY0CcDqhZtd+Bhcpkm81szB96F80Jctt4G2TV/+1VIGFXsCBWDlOeWDIH0WfA
         PSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760943361; x=1761548161;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0DnThhMkOfv9YGDKUQ7VwqLvt/fY4Aetr2LPisH1YU=;
        b=DacpeY2xI2mNcnocQl5KBdRa+lzq1T1Kkx4gm4wiggnlOSGMjYTZxylGCGuaEGmsvr
         whU6EpEB+h5uSm1Tpxc4R7QqNDzOm4OO5m7JhsIkx7HIoRbrKXWzZqo7RHSTtMrgccq7
         hw08pxXusn7t1Fr4seIuYIb4n9DOkUKid1Ku5I7sHdavXDf1t2bP55hEkGMUluyQQvFh
         k0Il3Rfq9C7Bmd8uEFYjFw8ur3zgM4M1G1RGD687c5yDIVKWEHnHcciQ1pwQNXQdmGZz
         MvxpWjiPfE7pnkYhz8OnJz4TK0bMnvHQWiT0i7xrH3+HNC6RQF8MHrLyrTvm7gsS2iNl
         btNw==
X-Gm-Message-State: AOJu0Yy+iK22Cc3rkjBM1kYqQqRrXz7lKr0DNbvmD+OGL65GHhfqPTNW
	VYCYqOwQAx2YhXV7s1j9M9RZHQCyDucrPcYKB7naT8Mkq2RsBSu46D5RaG+skhesjjg=
X-Gm-Gg: ASbGncuLJCWjHRfhOcHtip8Q4vQzT1RIwe7Pc2lN+Hg50HLE10iL5DbghetZjFfdgcB
	DtQjI1ofQrkhH7fsz8ZRrwrdqBlGdeQoK5HWC9lmCgHNooedvXZzE/2ToRzXi//kuYYO3kR7e9F
	t4SZ2J8TaGubwar4wYM+YQNTzQ31TFD0jvnD5J6Pyclo75ke1dmtAAsQ1hqTm35jGMq/TUN0hvT
	IkIZoPWChRyPTOOhkFtdI4548Hg5oyZq7/p/udg9DmpEkrUtN6A92uj61LDBASE7MiCylVnSSOf
	EqeUvdyYaWvVYIHHvbsIz9gV17wlwX9xcDX7GcwVgz8h4IbhUSiH/twkFBd10NI49ZFEXoS//VG
	PctES+EADm1IJzar9/3eZJce7XSriJkNtrTdtoqLLqOLRC+UEhD2mWwTSVaB1X6BKpWSp9Oo6E0
	mloOYpfLcdGTFXPCsJ
X-Google-Smtp-Source: AGHT+IFB6Ey5I5GEPVDKYwQBF2ZBDxVATO0+MlEz4wW7uv+BJczKh6T6QMgfi5LUYg/EAYYZmtjQvg==
X-Received: by 2002:a17:906:9f86:b0:b3d:5088:2140 with SMTP id a640c23a62f3a-b6472353d0emr732095566b.3.1760943361476;
        Sun, 19 Oct 2025 23:56:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036a3esm711731466b.46.2025.10.19.23.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 23:56:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
In-Reply-To: <20251010-acpm-clk-v6-6-321ee8826fd4@linaro.org>
References: <20251010-acpm-clk-v6-0-321ee8826fd4@linaro.org>
 <20251010-acpm-clk-v6-6-321ee8826fd4@linaro.org>
Subject: Re: (subset) [PATCH v6 6/6] MAINTAINERS: add ACPM clock bindings
 and driver
Message-Id: <176094335955.18498.10975479866423717961.b4-ty@linaro.org>
Date: Mon, 20 Oct 2025 08:55:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 10 Oct 2025 12:46:36 +0000, Tudor Ambarus wrote:
> Extend the Google Tensor SoC support list of files to include the
> GS101 ACPM clock bindings. Add the ACPM clock driver under the
> Samsung Exynos ACPM Protocol entry.
> 
> 

Applied, thanks!

[6/6] MAINTAINERS: add ACPM clock bindings and driver
      https://git.kernel.org/krzk/linux/c/ad97aba3e64f8e474ecbce0c4e08486023ce8ab2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


