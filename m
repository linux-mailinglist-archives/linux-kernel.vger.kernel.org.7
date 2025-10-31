Return-Path: <linux-kernel+bounces-879582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0493BC2382B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D95C44E32C3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EFB327205;
	Fri, 31 Oct 2025 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lVV3yd2J"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000C3271F7
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761894858; cv=none; b=fkHJGVnvm3aaKbAbxNVkal+5QsQXewyRr3KrEyLBgIduieXgMERxQi4nDWlOREU1UpjFX0iT4d56ZbVSLqZi+qXcRgbCLikgrzYAaHi/2YTrc8RDsm6RxMxq4n6yF9Spjw2xSPTsnLl7XrjIihMahtqjHQlG37DGnRZCI2ltf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761894858; c=relaxed/simple;
	bh=8+WhJyitrbTeGgxZoKEsA3Xi9RoN5HyOhUdLoDNVsaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEdIohCup7aZ0f6eNh6Fl/5APxRgHVb2s7Vf0drxOPLB7DNfLewvhazuFmCEzR90uUTEtEQkCHLpr0kKVtLSlhg+12seDMV+mBp4RZdaxa8QBaVTbZ+xretsp6eKAUzmkPYAmZtQf2Hm+k2Z7gu4K+7RSq+h5l5WxUadSFPYi2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lVV3yd2J; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429b7ba208eso981955f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761894855; x=1762499655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F01LUjN81T2gEebzFvJeRYUSPOsICmfNBzp6TVdzeN0=;
        b=lVV3yd2JyyAbEBkevywl1AinDE47ZC4SaYnmFPu577PBVp7aktF9rXCtMEjm3PphFz
         G4mIjC4PyJRmwB8VP20Btq2pE9FylDJQ32kng+SWijQltfPu0gF3Dk0sve5+nnPFuMFj
         TkTf5ARVcDUkV9eup3RCSkvikx9xuAvlrWvlT+U+DrgxM1otiYsMEEX0VXLjhlOy/c10
         eiYRrnQU3AQH/VHOq88jGD4FCDGeWdWOmmD+iIHC4w8XbfIV5QmDA04HUMVLn7gFvody
         VOmeDZ8z9uqz52KmS38WpFvActV0cU4PDXeAegYzV7UBuqkgwT2yn7joe/l1RrTJIVhq
         PUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761894855; x=1762499655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F01LUjN81T2gEebzFvJeRYUSPOsICmfNBzp6TVdzeN0=;
        b=ubobwKnUR7VSRK1BinI0NJLdSUXXlhJgFs1xX2Ai58u4FljFvY9h5U5HTSGYtpjZrF
         rIkiYoM8EcKzffdgWsZso5Qvr6sQ3p7/yvl4tUW14CdLmSwQYQfHXrtKCy9VfqOWDBW2
         eT/wOxxcnOUy65Bhbp5QHm+g4z2Bdz0gFRj55GbJBR4SLqWgDANbi5d0LlG3S8HCqky1
         HQGDqkFM7Stif0wRYtxyugCAOlq5mm+gi6b3REljs4OcvO887GrLvx+T33sfiCwbfkdB
         35MbovoQhzDvXGIO+c35063IhbfHGnVsdEcsOzvlfyeXSuRlO2d6cXHttJa9wY/itOj3
         8iRw==
X-Forwarded-Encrypted: i=1; AJvYcCU0/JvMeHq7aV3XYWxTSbPFeBrL5x+5132M8DVNXnLxhPd2KjshOh+sXNIUNAHLCOPNc2bKmGIaXGvdq+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3OI2x3zVIm0ToX26iNY1yWcbG7CcU0Y6bp9U1BKSOcu9xqGI0
	zvZ4GLAWHJjgPqcb5WAbX0hPhOq9nR3VQPeDCrbZCTchZuzHVSkWuI4MXybGBZu7OpI=
X-Gm-Gg: ASbGncvfefCNLif98KuM6eXloMVWCj9Py/cknH2G1KSzsziIGrQ/VzGMCLRhH8bUooI
	FTm20RdX0DDGfomJDEz7v/BaOlK1X1hvFoxxNysNxIln4dSf/mRRAMe5baYgw/+0pf67omufWUK
	EV3Ib0rXn15cut7+XYlBib7NL9F0NT5ALWiXCYGrhT/UCuFPf6hD/Im8at4psWkzhKcKHAhYeW3
	Tl81K9GxAMvH0OVnSzFTK4UN+LwHsxl4x0r2RD1NFaE7RHLZdRPv+lZI6w3U++5ITyevhaOoOP3
	Xa5w/MnW1GoTPMwopuWS0p9TLpMstyhCs9LEg/mAOD+zRDZyQDnE2jJklHU+t02EoTFez/Fapy2
	CsUpd6Ki5cSze0iVIje0rH3YjpsOCpMiXSXvHv4Miey+aLUuNMtQb8o3o2BK81hO3mJ1Ny0Kg66
	ad5dKtRs0=
X-Google-Smtp-Source: AGHT+IGFXoXIYQM0033JrSO0/egQMm5kDokRkBfCt8uk6iJ6QGivvStg+2qhnCmO5P2IzbdiAPo8og==
X-Received: by 2002:a05:6000:2288:b0:427:5cf:a284 with SMTP id ffacd0b85a97d-429bd6c2d51mr1752732f8f.60.1761894855232;
        Fri, 31 Oct 2025 00:14:15 -0700 (PDT)
Received: from [10.31.13.216] ([82.77.28.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c114c944sm1868250f8f.20.2025.10.31.00.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 00:14:14 -0700 (PDT)
Message-ID: <62133fe3-cce8-4405-82b9-8ded092c7eea@tuxon.dev>
Date: Fri, 31 Oct 2025 09:14:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] clk: microchip: mpfs: use regmap for clocks
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 pierre-henry.moussay@microchip.com, valentina.fernandezalanis@microchip.com,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
 <20251029-surfboard-refocus-ca9b135ab123@spud>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251029-surfboard-refocus-ca9b135ab123@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/25 18:11, Conor Dooley wrote:
> From: Conor Dooley<conor.dooley@microchip.com>
> 
> Convert the PolarFire SoC clock driver to use regmaps instead of iomem
> addresses as a preparatory work for supporting the new binding for this
> device that will only provide the second of the two register regions, and
> will require the use of syscon regmap to access the "cfg" and "periph"
> clocks currently supported by the driver.
> 
> This is effectively a revert of commit 4da2404bb003 ("clk: microchip:
> mpfs: convert cfg_clk to clk_divider") and commit d815569783e6 ("clk:
> microchip: mpfs: convert periph_clk to clk_gate") as it resurrects the
> ops structures removed in those commits, with the readl()s and
> writel()s replaced by regmap_read()s and regmap_writes()s.
> 
> Signed-off-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

