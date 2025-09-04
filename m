Return-Path: <linux-kernel+bounces-800925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48553B43DC5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F925A3962
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0C4307AEA;
	Thu,  4 Sep 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8msqeS+"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC62307488
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993963; cv=none; b=iBbMdk9X/scZgjFpFD0fWxko4PvMfQ4Sknz9mm4s5oA3AQiRR2ISoUzlutXbM/mVPI3PzmckC8cxEAfnyK2W3gJN9n/LUFOAvY+/qUMqkP1mgynQ1FW4xf1dzPV9EIxF+3pTh2YjLPCiki91KNoQEnf3lxuJWnDsAibNaQoPcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993963; c=relaxed/simple;
	bh=azzF6D1Hdr2J15DBAunoU08XP5o/DuQKJToDYFBh5ow=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRYrgKg7K1m8vD4JbfWBwAgQ/Y7Yqg6cfCIOzP5UlrFL4sHMCNhts6gZ3quYedbFqQbegRa/uL1j8Ud46rzCYZVsOcE6ov+bkhKmPvlBrtdfSAnXbiSOw/9gtrOlVfwykaRq+nu+zo0yQPVS/AuV6N4TFnSOYKbAmrJV2XBmXHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X8msqeS+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b041264542eso12470966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756993960; x=1757598760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgeGgsFM+rQArXvxzAToJZRLnYQpJqlxlgbUcOeTf/U=;
        b=X8msqeS+dg2LWZq7e35Yr/gne8Q0jp7vNVBFqfrqxvlYEc5O4UhFiPQSst4IhTB8EF
         7dG+4tnSwaTiQMomcB0q8gmVhw3FDEzJD0zOq04sw9V/VUAim77L218cLqslUlUQZcXO
         99IQvgYV4QkjcjQmZ/GUuBsNCc5mDsIIwdtt2kgS2lkItBXu+qSbDxfErkyxsMWLfEyK
         0J8oORbzKlOOyHFg+vEvrN6CeTxkULfr49PPdTpPqufj6UzWnPG8WcfN/L8JUaw2IzJd
         qIkdWpZ1ZvL3yUviEIQpnH7YzbaUuuodyOnMxQt3ZE2HHM3AXax+Ig6XLG77/rc+fV6y
         +tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756993960; x=1757598760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgeGgsFM+rQArXvxzAToJZRLnYQpJqlxlgbUcOeTf/U=;
        b=UYbdzouh/PaRqRU6Ih381YmyKTKI1FSf/Dp8uxwSR9VBoa19yfOcatkGqAQHZfMwpj
         jcVNa6qRSq0k3Mm66K5Ta7mMEVMJLu90JYPNhnsmiWTtMkilOiS8dm+jqtQLLynlj1vI
         u0Ex0THduPngJYo+gSxepkzUciY2OTOyL3kPfLUZdUFdliWnaPzS/m381zoFWWos4R6R
         ZVW74sGY6GxgZs+y3YAQBN4L6RVYAlWd4O1zvrBhWn5LAy0bwWafHI1GOUVzakkKNfn5
         JAFLKuqtHR5GUSweWkOA7ay4ZmQJ/xcd7ysQP6iWHV6UXtesDA8NBNFQta5OU8crrhO1
         tLyw==
X-Forwarded-Encrypted: i=1; AJvYcCUmU4V4duRcJWalmoACfRiVze0reCccNlp1V0D4s8CDX6t2SlQInv8TXkrU8EBHizv8AftVma9ZWPHfuqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyedGz8NMPgDNRhq7iUvds6Nlots1ZXp8V0EuDoIHX0CHvjjZoe
	l9bpNHRKihfwV79RwIziY3Trk0YS5Xxbl2jJnLYWTcl1Xnms6X/H1fRolHyAAGDzos4=
X-Gm-Gg: ASbGncscxiMyy+kbi/wbmiKPPLSmxiyfBBdOYoazdCsd20012GvGNd/kFmRN5IBT8eM
	cka0MAQAt1i6TCcm1pdFpv35xdUgIRJP9VBmdOZ2jnD6VncN0czTk/DGgjM6Nrdqz32GgdUBbMv
	sXijfyxCEQcNrkjCRL9BeIl2lnYsIWMHBwB5g4i2aoQ2SmbFwJ+ROs69WcDgbmna1f0cr1xo1eZ
	Bmakc2BTpUDcvxQXMW1snHvSIRQY64DO/lSt3QHczS7H+Wa/kPnED3+1yR4TfDaExD1POTlD7hp
	eqKd0Tc63ts6eomc2LuZXRRejzhKCuQGSAKpLVNZitofYt+QDWuUnwhImSjB6SlJZ2ocbQWMaQD
	3elfWbtmU43pB1q4ag0FwxRp5Eqrx606fbA==
X-Google-Smtp-Source: AGHT+IENiGowH65uqsGasImJfhU5ju4Jy1wXyVGZWUIgsAvpgpMXFrjAosxNPFmKdbC/U5NW3+rMwg==
X-Received: by 2002:a17:906:ef05:b0:afe:872a:aa5d with SMTP id a640c23a62f3a-aff0f022fa9mr1200463066b.8.1756993959596;
        Thu, 04 Sep 2025 06:52:39 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0a591819sm1510983766b.41.2025.09.04.06.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:52:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: toshiba: tmpv7708: Add default GIC address cells
Date: Thu,  4 Sep 2025 15:52:31 +0200
Message-ID: <175699390854.173213.7488244114872177547.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250822133340.312380-2-krzysztof.kozlowski@linaro.org>
References: <20250822133340.312380-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=krzysztof.kozlowski@linaro.org;
 h=from:subject:message-id; bh=JAwT2iPNt0TjVzVINIBUXGLhXR1IIpvFzujMO5pZKB4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBouZmfDWRJhl6b8w/8lg/0UJorn6ZScQfnQoFSS
 VWnfGSa3qKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLmZnwAKCRDBN2bmhouD
 19qHEACHjaZQXOJurWs1+uc09ch7Ro25A/y9Bw7jFLvs2B+A3naqZxaF0gxgKyx/cMCr/T9u61z
 HY/rzoIoXsmYL/Sqs6mX35jtP6tktdeTB7H3db5EinZo4t8DoUTomfVTMtS58dGp04zT/tJQ9w6
 Iw1B5u4x5BlxEXcoumOakBjn5X7TmVm4LkqB/wEneETqCqGQlbHOPy4s5Z0DlgKYfTrbQy6XQ6M
 wsTP7BEQ/EomzGk9NHtWsfkVCdYfrugM5NRgxBjxIcC8bXzpqjDOO1rrU+HNBrv4PyEejQmhGKv
 UbpGUVFjEFZBFUnQjjLeWErR/YnJM6WgsXXl8v0GHuUYHPsBj2hRA7O2ZJ0awPdt28c69dGJSKS
 2PTvO8L+KUYX4bJFJC12BNIn5IsyLtbtVrkj/1IsepHQwjd0RcSAYXLsE+Ho8CuO+B3YUjHNj/R
 keyRvrG/6gJv1g+givKQbePm2rW11cBf2/yrwYtO13swEjRizbuABQZnEkyr/l4s+Zxdn0DpmCl
 /Vbt5vLYw+uQsCEHjiy+V6VOaF2xhCMdDhur/avNDDwoPOQgvMMKHlXKn1FY7l2ZdlF1qef88Qb
 rs9kR5ZY2v3lGUjp4EnRD2ezJ+R77Gdlq/jG5kWSlKgzxebKx0SqqTSOWKr20bbZP50nxc2chNF 53z2xcvrrvHjXTg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit


On Fri, 22 Aug 2025 15:33:41 +0200, Krzysztof Kozlowski wrote:
> Add missing address-cells 0 to GIC interrupt node to silence W=1
> warning:
> 
>   tmpv7708.dtsi:503.4-507.28: Warning (interrupt_map): /soc/pcie@28400000:interrupt-map:
>     Missing property '#address-cells' in node /soc/interrupt-controller@24001000, using 0 as fallback
> 
> Value '0' is correct because:
> 1. GIC interrupt controller does not have children,
> 2. interrupt-map property (in PCI node) consists of five components and
>    the fourth component "parent unit address", which size is defined by
>    '#address-cells' of the node pointed to by the interrupt-parent
>    component, is not used (=0)
> 
> [...]

Applied, thanks!

No one picked these up, so I grabbed them. Please let me know if someone else
wants to take it.

[1/1] arm64: dts: toshiba: tmpv7708: Add default GIC address cells
      https://git.kernel.org/krzk/linux-dt/c/7ee0f223cabe9b9384250024fec577c731cbcf72

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

