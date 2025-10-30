Return-Path: <linux-kernel+bounces-878716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B32FC214E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5C51A604FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258122F6193;
	Thu, 30 Oct 2025 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgICsIj8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F3208961;
	Thu, 30 Oct 2025 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843049; cv=none; b=hIwg5oRGq042AMnYk/K4EjBDlg7OcNvNXZdEuJgN1BRWKsT82mbwlTTc/3ejoSaRvzzjuknWY0x/jpO4y9xB/wgyi3qq5WUol104IWwltWJCm14U9rZHZD/iglvKJkFjckZSSy56z9tI12pN0xotnMKywaGIVrRK7Ima/Eh4pc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843049; c=relaxed/simple;
	bh=XOl1BIiIwZMTTJDwcLrnUs9s09D9BbBLlOYuDHjP/eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M469WTjPtMfBE5vJs5BsrkfHAp+FDNw5q8DQPKpIYfc+9P0KYXg1fN10ekhgiK3FqPYCw4/Auwj2ZrAJ03d+/eyWWe514TZR5NNEgGP+tW+5La+v5ABI/UH405ghtTd6bjQFBsXDQzaZsCYygdzFZJtb4eBhHNnIug3DAhiyx1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgICsIj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F06C4CEF1;
	Thu, 30 Oct 2025 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761843048;
	bh=XOl1BIiIwZMTTJDwcLrnUs9s09D9BbBLlOYuDHjP/eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgICsIj8gsPlrJU8iZX1LW/io1YbFjSoc41RFwY4Wj0njX8TJcFygK4qxxRBvLtRj
	 OItqQGl4ACLRMUNDQ+tDT1FonpwFKzfe3+NlJgGdKL41c+FfsFctPaNbiVjIyf1VwN
	 FNN/PyQgrxhiJPubuYGM534Omb4m7jFgh/KEgB0wftfmozm/gMzsoRkX/+AfMI/G04
	 z07njB5JiIpcTEVKCiHRUu9jcmkbjMAosthYJIzJKyU9jI03Aq3CSClHrJamIUZRDf
	 uHIKJwRJ7scUsgO4Z/3/HswlWBoev8/Rrf+a/0S8n1uq+dIuNFudf7elZ6TjiO1sPv
	 6Ef+KumbTNfvQ==
Date: Thu, 30 Oct 2025 11:50:46 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Robert Foss <rfoss@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	linux-media@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Todor Tomov <todor.too@gmail.com>,
	Bryan O'Donoghue <bod@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: qcom,x1e80100-camss: Fix typo in
 CSIPHY supply description
Message-ID: <176184304530.4163875.17235615769011193456.robh@kernel.org>
References: <20251028111115.46261-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028111115.46261-2-krzysztof.kozlowski@linaro.org>


On Tue, 28 Oct 2025 12:11:16 +0100, Krzysztof Kozlowski wrote:
> Correct description of the CSIPHY 1.2 V supply
> ("vdd-csiphy-1p2-supply"), because it supplies 1.2 V, confirmed with DTS
> on the mailing lists.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,x1e80100-camss.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


