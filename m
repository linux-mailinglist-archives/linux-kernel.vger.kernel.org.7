Return-Path: <linux-kernel+bounces-875237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD7DC187B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346A01C6022B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7063A30170D;
	Wed, 29 Oct 2025 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Up7l6ERY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F721ABDC;
	Wed, 29 Oct 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761719543; cv=none; b=ikEApOoMMaj/4Eh6BQXhW8RJuBslQI22Tq3s/549wtcwvtQev2LEHEkTIutuhmftBIPiqvnMmyBheV1mBGH2lfifDCyfYX+LLZB4DGwR3EClK5eWVda6BR93c2HS/5Mgr0t0TfyAU4B6n+JbS9QMBBUpFHbw5usZO4o6tkB6fkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761719543; c=relaxed/simple;
	bh=2NVMd1Mrg5ehWgzP0DXSjNidcji7ITP24vV1FomOXVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk9x0r0YIWHVJyriRjobvsJoivXK748lls97SwNBp/CLt2RdH2uZtKzA0/Y0EWCllEMLzDGYGwuYGPsWjBRVXy7VLVSJ7V3XHYaJSuVwzvGrO9ByOTH4D58usVFhuzLIs/gStpYaZNwOtZ/kjQQtv//jkOaBcsErLdumI0MWA5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Up7l6ERY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BCCC4CEF7;
	Wed, 29 Oct 2025 06:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761719543;
	bh=2NVMd1Mrg5ehWgzP0DXSjNidcji7ITP24vV1FomOXVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Up7l6ERYVPvw19r57nPHCqYLYbOY6fBS8aSEOdAbvHgPwhadBOTLerRQz61v8HVKK
	 b05i36j/sZUX3TmczwhbvphMsr0M+UwXNd0+P5kfyyilAAQgARqXa9EuCrWC8Aw1kq
	 ZzZ7pv3v4yZ/kl8FkHrVuJANzVDPAiheEkUOXyQ7azTi/eGeJKWadzuLzahTFv7C7Q
	 BCy+/7Hq8I3J1z5+/7SiZQC8HsLlk99UN7qtOmS619Co+/JJsAPS16NkPfVP0yfGEo
	 KmceacLFSvn/XJcqITq62QIC1BESo2i/r5erCNYA3FH8ON5axMQS5gnTRIoyOlSV9n
	 TCKp4AVbZzudA==
Date: Wed, 29 Oct 2025 07:32:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: eeprom: at24: Add compatible for
 Belling BL24S64
Message-ID: <20251029-sloppy-brainy-coua-b8b04f@kuoka>
References: <20251028-msm8953-cci-v2-0-b5f9f7135326@lucaweiss.eu>
 <20251028-msm8953-cci-v2-3-b5f9f7135326@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028-msm8953-cci-v2-3-b5f9f7135326@lucaweiss.eu>

On Tue, Oct 28, 2025 at 05:40:48PM +0100, Luca Weiss wrote:
> Add the compatible for an 64Kb EEPROM from Belling.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


