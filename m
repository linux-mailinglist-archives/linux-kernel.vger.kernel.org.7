Return-Path: <linux-kernel+bounces-796149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D512B3FC8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A224E344F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907C32EBBAC;
	Tue,  2 Sep 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHlSbO4n"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5332820B9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809184; cv=none; b=uiQHbYBsEntWP3l5JbHW/EYVB6Qp+5wIccPH6SM9ixnHBN1GZf5spCnGVHzIKGP0IB000box+2NKkXWT/4clLRrnUhhH6+4y3o5yqp8NA6rdj1iq+FWXz34WFkJxLewHIzb5SjoyjWpBSxZkxycMRW1pn/BTjeurtucaUmxHomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809184; c=relaxed/simple;
	bh=D6kMRVNdjTsHxomh8Umwb4E3q6zvSzEKkpefTTT/TzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UcYRtn7//6g7t/C5f5KFHNKqQHWawCzUxmOxWUMS+C7XcgJF+IjmrfU4SsGL8DIv4CjY8CG2ohXkIHm5J31I99KbgFWU7ox6uqd6lWHgr8huiRiW8VgzgNDXuiecVFeO1DJEii9SP0h+8kOVb2vx6DLV3rRwF586HYB/+23c6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fHlSbO4n; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61ebed1e37fso41393a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756809180; x=1757413980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+2RmtyC5BdrhVnYkf0pE1bp+20qsxwnCUP1SaL1uDE=;
        b=fHlSbO4nvFRetVrpPRB6bgLDTOjU/qdzNl0rZ71B3InipDSZ1MMMwMdo0PGcfEL5fs
         LFcViE5hQl7oi3c1I/H42PHnYeiW0RuhqNAB5gBMg8GmrETEHccPan1j+rJbMaGascMK
         iKCzMW4cWTyLr91cs1atbLg6ElGZxk3WSWlILzBttnb9qbrHQ1vOBbfwNU05b1Yc7NFu
         MybDLmgRpIhGt7xwGNl86t/MBneCuXcCAA6indKsJqmAb2qxeVk5NCbjQuzqrXzDVBQy
         md6/0xArDSxaVZtTZgD3+dLVg3dnnldtBI2PxQur+Ids+bNhFw/evhQ349llSXscnzJV
         Itwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756809180; x=1757413980;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+2RmtyC5BdrhVnYkf0pE1bp+20qsxwnCUP1SaL1uDE=;
        b=cDVBDcUErN6DSP60BX6i7/MTLn4HyD8glETkEaUtjUXUVPPpFGI2B2ZXGGn646Lecr
         LdFh0qXq/QfOcKLyr6PsL5rCnG/9ZtzNhwdQ8PkZKBc+qur+gs522ZEhvVQSmvdek+V8
         cphK/48HysLK19uLunK+CaQDZE+igyDimXiDpRcMRJf6E+ooVlyUV69T/gujEJFLVK18
         nkrM/xqZfWc2MM9K3DE7WeDC52mqGxfbwEr2BTgyeeHKw8rG01HOSIfNU8F1ZasrzTN8
         GukIr7QDxu1f4KDMaQnN1cXB0/rx3ncnsOR0+zcU1nvaPiHHP3b3+czqRaUtjOHSsmLn
         vnOg==
X-Forwarded-Encrypted: i=1; AJvYcCVXkkfc+KRvFW1R6ELyx9RTyQKXDGJBgltq6xWiO+0DjnkeMzhI9aWzrZz3t1gXdUet6OSW0Jx+SSAuHew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPIbW0nFDmVBqguCLV9wDyBcxLAioti6s9CbvLxmVtgp1B7G++
	FigE0+ePMjG8BWfi+RbehWwTipprP2zmbBC5fIHvAA7apVfWW6r9MLk8znd4mEaeCEU=
X-Gm-Gg: ASbGncs1VWDKmAWY9XdVegSA11Cf3EGAAJ0TfadqfvLN7bvJLIac2TRDWsKXdxo4X/Z
	cc+gVBYr/kEsORmn6PdnHGP77Vu55gnIPKaxkASE+bmhPYGTixYCK1qNSZqnYehOIYkdg4ku1QG
	PmBl0bCPBFiY0KmwtSFUcUQjxvma6FhjvIoJI+J7HWXo9YH+bjDJzkb/7kZPf2K1gO1N4MCIxa4
	OT08BkSg3wudS6fLRA3XRjodmz/Frn6tTiI6qX7ToieYz98qzZNmqyPm64SkfxMhfD+VS74NEbT
	NDq4fBuzY1CG1RmWEVBBvUa1XrfXv1W+P7paUV3n3V12XkS6A/2qk66m0dY0rDbsNBmkh0erL2o
	IzJ6dizpmVZBpbinSQjfxbZjkigtQPEsHXYAYHtt+JNtD1OjxWA==
X-Google-Smtp-Source: AGHT+IHAsN/656NaYDyz43thubEPzcHhs+/jF4e7qFvC7WKngX9lMBJC+gCJOclV74lgolxYOi8bDw==
X-Received: by 2002:a17:906:690:b0:b04:1457:93 with SMTP id a640c23a62f3a-b04145702d1mr390858166b.3.1756809180009;
        Tue, 02 Sep 2025 03:33:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0423ed35e4sm516431766b.25.2025.09.02.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 03:32:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20250830111657.126190-3-krzysztof.kozlowski@linaro.org>
References: <20250830111657.126190-3-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] pinctrl: samsung: Drop unused S3C24xx driver data
Message-Id: <175680917816.135692.16731223900572881206.b4-ty@linaro.org>
Date: Tue, 02 Sep 2025 12:32:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 30 Aug 2025 13:16:58 +0200, Krzysztof Kozlowski wrote:
> Drop unused declarations after S3C24xx SoC family removal in the commit
> 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support").
> 
> 

Applied, thanks!

[1/2] pinctrl: samsung: Drop unused S3C24xx driver data
      https://git.kernel.org/pinctrl/samsung/c/358253fa8179ab4217ac283b56adde0174186f87
[2/2] dt-bindings: pinctrl: samsung: Drop S3C2410
      https://git.kernel.org/pinctrl/samsung/c/d37db94b078197ec4be1cadebbfd7bf144e3c5e4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


