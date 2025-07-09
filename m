Return-Path: <linux-kernel+bounces-724074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFE6AFEE44
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC551C449AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DC528DB7B;
	Wed,  9 Jul 2025 15:58:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9B8F40;
	Wed,  9 Jul 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076681; cv=none; b=HN7u2hcCo8hXMTM5S09QdsEyrn4tV2pp1eeSiC/ajBH+mZDVCpYP81ezGefQSV3iCGPnV4QsU8Fq33brBWpp1W5DoI+alFrTHqUUdAIU5U9b/X5TDAOCyJh5jHRX1/VQfRWFLpA4wJ0bpzfajUS1gh8fCPC6+lYwcRWU/LU50jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076681; c=relaxed/simple;
	bh=et5xcV6fCuJA0PRpWVFHA4bGNZcLKwvKMXrwgYqXW+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TrNhEDxVa/savn4qpRPBqAGj69MWRE/CJKsSw8YiS1EwuuYX0IXAh6/DNDVSlg+NM4uKgbq8m8hGzMRM/glIynQsK2hhmd9tHe63aKTjAI+ZoEE/RHv18+9Uolk1Ewe+OX/NbI3H3tRJ1VZ2LJWpg0w6IS2BBZTU2UBbz4ruhH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70383C4CEEF;
	Wed,  9 Jul 2025 15:58:01 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 6E1585FBBD;
	Wed,  9 Jul 2025 23:57:59 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: lukas.schmid@netcube.li
In-Reply-To: <20250706095804.50475-2-krzysztof.kozlowski@linaro.org>
References: <20250706095804.50475-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: arm: sunxi: Combine board variants into
 enums
Message-Id: <175207667942.3765461.12730253143033770336.b4-ty@csie.org>
Date: Wed, 09 Jul 2025 23:57:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sun, 06 Jul 2025 11:58:05 +0200, Krzysztof Kozlowski wrote:
> The common style in all bindings for enumerating similar variants is to
> use 'enum', not 'oneOf', so all boards of same variant or using same SoM
> should be grouped under enum.  It is more readable, more compact and
> makes easier to find actual devices from the same family/type.  Also
> there is completely no point to repeat the compatible in the description
> (incircuit,icnova-a20-adb4006 implies this is "ICnova A20 ADB4006" and
> pine64,pinephone-1.2 implies "Pine64 PinePhone (1.2)").
> 
> [...]

Applied to sunxi/dt-for-6.17 in local tree, thanks!

[1/1] dt-bindings: arm: sunxi: Combine board variants into enums
      commit: 9615e017464dfbe72e12e36592b7c5b65e9203fd

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


