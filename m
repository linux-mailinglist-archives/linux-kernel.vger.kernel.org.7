Return-Path: <linux-kernel+bounces-801019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBBFB43ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBC5188B094
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B530320CA0;
	Thu,  4 Sep 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJrT+Hd0"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB031E0FD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996104; cv=none; b=Q3ndIvIaDhZXnM4MoF8B9Il9vjk0MAiB977R/WWBOqto/NJtkj15WbFvtOjlUHvEMocw/8BHc0gcPQ8vWpB9bHc3kPfsfAycIuBeDFtiPh2MiHySiwuAkeOMi+RsxzKRtzxxCJvxVLqDf80VSfE4yEUoY7iDXSNq6+bGZqK0uno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996104; c=relaxed/simple;
	bh=QTjgMxMpkqLWpIeuMVGtCnInfpv7GD4qqA4XFz+DIsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPb4Mvwd3ghzp/tJFnWcVw3Ygamrt+Koc7om3SRxfAZMERbg6AsTY4cM5zAnqDrBU5N9bMNbobhrnUKwxeqniV64NYIYfJ4Cvdwji0KFgsfNyVLV/DN8z55uoSX3LdWHzLVo8LFC5AjI8yHXkqhKnetqIxjp+/r6IgonH35Zsdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KJrT+Hd0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b8b25296fso7611455e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756996101; x=1757600901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DcDEKKNnQTPrirM2TKss0tLgkg6+UenJjOFVj0kydUE=;
        b=KJrT+Hd0DpngAN2dUpXudbOaUJPr9KJ7KCZuGfLtyAC7stz78Pe21xEW+6VrjXkQqx
         UqfcvkItHcrGdBkmpZ3nwHBzc01kXtle9VIWJU6DkDexB1HHhU4DuQxEtv0q148jTE59
         rTH1KY34QJ4NjtNo6MMC9ii4mmGQoKx89HNacbsbFbTepyrgIaSqVMscztxzEEsbrDP3
         Eq5PfIW4e00pYdSHglC0WQAE+zHczOH9ymvBuVcXvHUmjePxQzo8f5SCF4jAMdK9lm8h
         vilY774VRmXcSqku+vaDrOnZcJiaERXneDyR8OAm+CeOMRHToCkY/y9TvZrR0TpFehjn
         DgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996101; x=1757600901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcDEKKNnQTPrirM2TKss0tLgkg6+UenJjOFVj0kydUE=;
        b=OolM1QjSPRQLOmCb16SWUOyj52j9b8D2G6SifJBIws66bQ3FFwPw/VvoDZGGN0sru6
         RGUhmN6vNCDy39yLYxcIPvyJWJlqiF80fL79eiumq5bSgucvz8s8sps7YkJIXBq/2J3s
         nhwCFtz3Tyj6XKxS7OCQLTDPi5pIcBVd5KLLm61mZbwWj7gTH1ZR2DATAV4bO9CiM8dU
         j8K1DG/EEGCL2qxB/s0gwK9po0DHAGpeTZR3hB0w8rnt50AoyR8nMAmtiHgrB1cUURVT
         PB5LTrRklLRNkQCaN0PBi2TFchg25ZHIT0rgTess4hia+4SOLtwOH0kNKVTLt1z20O+B
         v+LA==
X-Forwarded-Encrypted: i=1; AJvYcCUPTzI4Ck/qmXFj1zD13jgzvDIPVw2bmd3+i/pBcBvDoEdwKGB2mhRqPlTa2DncWhkM9JSX2yyd+vXPwJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzslLmgboe7888Dp9P5k4k8+zD9vMqFq94XdjMSH8i0FhVC6dg
	eOiMKSUkDD1QeXkwb1Eg7MqO/aZjQHAVuZMdWzmg4nBgvuVuHBiwLmSPdtGhf139Y5c=
X-Gm-Gg: ASbGnctcEeUPKaZtcZHcsngRAhmqWexhSOSjj9GfA/mHBc7emcDwewEhm+1N5udZJwf
	vEC1LkQ9nMfXIMMiCF/ZBE8CFHzuV4VyxrjykpMKb+jUcD/3TIHMg3rYgDkExyw7Wcl9lLi0e6q
	9bYGUix/RUZjaesbPmT8mr5caC9afK8waNQT8lUFcF0NWawQtYXWANriNyxMVoqEsXQa3uma5qL
	GrgUeH5QwyFZpCub4+/q0jaxWbu7dFay9BcpN6hPJHlScn/d8+Q7xdYiLX8Q9QXEngLpLUgVaPV
	5wwDjIaE9JFsgGfOsfP3vws3+r/Y0KRiLcX7eTmrt4cbFsHjYsBFQ5dYxmM3UgH2hp3ddYz7Yxt
	a2CvthrxznTPxX2FQvzNhW8/+9Hpf3Thz
X-Google-Smtp-Source: AGHT+IFMpG6ZWacwiwSPkZLZJzyjsT25qjvuify+8jgJtfkFvC5YMwDloMKDY1OfWLbskoCZF7jJRw==
X-Received: by 2002:a05:600c:8b23:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-45b8553f3ffmr156662065e9.3.1756996101466;
        Thu, 04 Sep 2025 07:28:21 -0700 (PDT)
Received: from [192.168.0.251] ([79.115.63.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb61377a7sm79031275e9.13.2025.09.04.07.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 07:28:20 -0700 (PDT)
Message-ID: <3cc48a65-5d08-4469-9ed7-f836a2210702@linaro.org>
Date: Thu, 4 Sep 2025 15:28:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] arm64: dts: exynos: gs101: add cpufreq support
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, willmcvicker@google.com,
 kernel-team@android.com, Will Deacon <will@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Griffin <peter.griffin@linaro.org>
References: <20250903-acpm-dvfs-dt-v3-0-f24059e5cd95@linaro.org>
 <175699523574.4060004.693479596122414416.robh@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <175699523574.4060004.693479596122414416.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/4/25 3:17 PM, Rob Herring (Arm) wrote:
> arch/arm64/boot/dts/exynos/google/gs101.dtsi:10:10: fatal error: dt-bindings/clock/google,gs101-acpm.h: No such file or directory
>    10 | #include <dt-bindings/clock/google,gs101-acpm.h>

That's alright, I described in the cover letter the dependency on the patch
that adds this bindings file. Thanks!
ta

