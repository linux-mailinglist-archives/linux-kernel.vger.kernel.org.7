Return-Path: <linux-kernel+bounces-800923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F93B43DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B239A056EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A0F2D63F8;
	Thu,  4 Sep 2025 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uo7/mkCM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67702EFD81
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993959; cv=none; b=rK3LBL13vUIGu2UcvB1cteZRq6yR4jZFMgM4bgVEtsqgwVY56opDyGYQftM6KvMdfzu7ZlPuNM/GPOb/TKbGzvewtMfwzQ+HkZtNiPN2pOflQcFwVdBbMBPwqoZYCG6OYCwFyXZZ1f1AdZhukqtO6F3To59sHE7Pf4xGNPza4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993959; c=relaxed/simple;
	bh=3NwszQXseQQQXeeJGJavuLZanWPf2ITI4unb8s3kOxU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnjLEqQoy0SOLLOSBeRja4XBxtI9UAGgs8ZMkuBIWvmWrbN7VC8f78xMsXzZOEHZhdAONJ62XOGD/+ziCtU6XVjFeBdK2RJFcHjTlkuNd16UIajrhe3DzGFX07DbluFliOg8CZG9IIuhkN7vyTZzMCw0A3PZLYdUFyvBk6EQehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uo7/mkCM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7a5cff3so12562166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756993956; x=1757598756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btcWU0VuzOuAgLeIG+yfqqa6yIJ2YjDjsE9sHz0/HqU=;
        b=uo7/mkCMBMbhmjZXyJZwsb3IMr2GZaUH6Lp1aHCKgd2lgbUDIAQ9HyfeoK89c6mYsV
         FQmIA5itggLEv/2LM+hgXvSG+KJw53C7N+GCGbwLjxs7zb8Aau9QIzAddcXGF8h/NDpp
         iypbsnYk5enf914MUMhdAEHRWbj1uMqCOqTczgn0uK/PgqI/QlbcDWTPCNy/lwp5xnRL
         VRqDjItE5X2masn5RzvRz1hAi/00E2pLYmnDmPhaBhXSohaqc9kPNhKLNa4FN+OIEGsD
         MiW3DZf2mwxY4nKabuBWH+Q9mXDBjshoSZ/OwpNFLsopRLOsx2kdG/Vtmq7fh8zdRKtZ
         Iw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756993956; x=1757598756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btcWU0VuzOuAgLeIG+yfqqa6yIJ2YjDjsE9sHz0/HqU=;
        b=F0wkqqtqgOkAsqFDjCuNuqbVgJpZ1dhJBk21xX0TrVyfLBiynEajbsOUcgx6K7Dz4h
         NVO1Gb28G3Xhfn4XS5oRQ/iZzFp1ss+N724uTd299t+kQIBl5WUzghC/rxe3BPXTYd4+
         Ng4d2Y+RUyqLutKmHAE/ie9Tx0PltdDmEc8JzRfPLFjJljVV9KW8iOC8PdYwH4A3FrpN
         KKpe9Gvtzg+T+eQo+C1SBOMKKD3z38inu7ZvljhXSYh/rpoZGV6FzXoBunoePZQD/mHX
         iQB65PhNpQvUp2s68zr2qIywHoc/MeXpMQMhP2/oHmcLFUkTdedMD+pN8esfR5Q0xBDD
         5ajQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYp1HtU6RWI38NawjcaOfbaOtAEix3z2hQ8SPYu2ZoKfnPNJ4+XqdM5dPnL5BxdBjYPU68+ArfQS1WMJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy75GrNeq4vnDxPkjyzYxh1B1GI1bWEjVquVId44hgkHPf5jf9n
	uoBDPhcf+Yi4nh+xbqySZ+yEfV63gYbm4qfTfGLyt0WYPHZ257ufj2A/zQi/W3Z87bo=
X-Gm-Gg: ASbGncuIYrQHtWrKue/qkmwrDsHx+vXwUixQRwTqlwLLHc0V+5YYd08z+qxRywqIYzZ
	hAINWeYy+WFyxBtMSuZRJz2wacc5ELEn0b3+WuzLXdkTVn96XmpZK/CbztIpXb/xG4eb/pgHr6j
	OmzU6Nskb1I+X4ezrbVBduKTyPdTBCh7hozqNtPQCpy0puCn8LrWjjNav9Age7kT6uY9j07AphT
	eDWAAXX4RUTSrQQLgS9Vv7/VmbM4p3O6OnafmdTb1PNqDtXYV+F+Qe8rZ5qPCjAtgtkTnnzZfpO
	SyM3uyoxbDP+vflv6dhssdzJWcCAR322pI5qHWX87t+GEBVZMyzUApkQRwniUlyqk5YYQKWePva
	RbU6wHziQ4P0hIuSi+O65PbSopuwssKdXTqJNKLub9Zht
X-Google-Smtp-Source: AGHT+IGxy5J+mJ4+0BEKnBNp9VUSoH6e3U4hVID7ehFNf4mXYRzdLprSxcjyWEkmC59UjmMtXNp89Q==
X-Received: by 2002:a17:907:3c95:b0:afe:ee31:4b93 with SMTP id a640c23a62f3a-aff0e28a1demr1113990466b.0.1756993956037;
        Thu, 04 Sep 2025 06:52:36 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0a591819sm1510983766b.41.2025.09.04.06.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:52:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Antoine Tenart <atenart@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] arm64: dts: amazon: alpine-v2: Add default GIC address cells
Date: Thu,  4 Sep 2025 15:52:29 +0200
Message-ID: <175699390854.173213.4164297632935011607.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250822133423.312621-3-krzysztof.kozlowski@linaro.org>
References: <20250822133423.312621-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=krzysztof.kozlowski@linaro.org;
 h=from:subject:message-id; bh=mTvDTEmCZQDDB+2UJw6Cuuz2PPTXZClmk5Fcayc9wdk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBouZmdjVXCiwMI1+8HWYwfY1OmAqwZX2PCuS2Am
 qQA0WNGfUCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLmZnQAKCRDBN2bmhouD
 18nFD/4hacdutq3aPcL/HzldUTkzIr6fLTPd2jMXK7X8qFzeKNFn/bNz+4kXuslVGJM6usDAVEt
 5jaHH2au1HhjqLKmw2m/hHr99ir1A2ttA5MjC1ctaY0RiaCgtyzEdSl5I8zb/ZTOO3YPZ+dsTzf
 pEcKOYUZ7btniQjURKwWK2qtYtbFKvYwgySWtgABKFb2VmNeBTvJs2q0CZat/vFthELkxT+kg2z
 4zisVch7q44u7Ie11kav/Vla/Xfh9eN1iNQCfiw4N4YLrGMEQzG/WaaCBLh6V5+Gq1AadcBktar
 yAyMejJCQ3K6WEjqkRmIhjA6PTNysuXY7iVib0xHWJmfIUTU60KbzMYj7bxP44cg0K2Q7aASStg
 KVO/cS2daFpwl5Fb+pNWawtJh+gc4FUZ2mg/+2Cxrsq3fCblNh7V3qkNA53a0XSqskQPVVfpmXT
 UQquzncilBE9uTFzMVFnS4lAWI6U0maKBz5dvT6mjxL/TQC2pkaX2kKt3MALv1rL7kvfYZLuJtt
 jbzlGx3Aosy6ad5dLqoueG7AGOoyyVa/S5i9fVhYvTTuqeZHzRwkGAyHJDMciP9Zkp5NP3IhY0m
 ji8P6sD5cp+zvFBcNiCoE6hPzLWAhLftpgvhUZQmYonzz1exI8oFxLJHaCUZSh+7rxLkEg2Ci+L x9f85n7Uf9JpsbQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit


On Fri, 22 Aug 2025 15:34:24 +0200, Krzysztof Kozlowski wrote:
> Add missing address-cells 0 to GIC interrupt node to silence W=1
> warning:
> 
>   alpine-v2.dtsi:138.4-139.33: Warning (interrupt_map): /soc/pci@fbc00000:interrupt-map:
>     Missing property '#address-cells' in node /soc/interrupt-controller@f0200000, using 0 as fallback
> 
> Value '0' is correct because:
> 1. GIC interrupt controller does not have children,
> 2. interrupt-map property (in PCI node) consists of five components and
>    the fourth component "parent unit address", which size is defined by
>    '#address-cells' of the node pointed to by the interrupt-parent
>    component, is not used (=0)
> 
> [...]


No one picked these up, so I grabbed them. Please let me know if someone else
wants to take it.

Applied, thanks!

[1/2] arm64: dts: amazon: alpine-v2: Add default GIC address cells
      https://git.kernel.org/krzk/linux-dt/c/b32a24f21283fbc86922006cc7d19fd23f70b8b8
[2/2] arm64: dts: amazon: alpine-v3: Add default GIC address cells
      https://git.kernel.org/krzk/linux-dt/c/3d1963e503d752ba33446ad056435c687f6d8d83

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

