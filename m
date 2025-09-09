Return-Path: <linux-kernel+bounces-808505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E584B500A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEF43A9662
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA8B34F47E;
	Tue,  9 Sep 2025 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TltLSQw5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9704E191493;
	Tue,  9 Sep 2025 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430411; cv=none; b=oIRMMKg3SpIilX71WqXP6HinJ2IjcP+HL6tKIL58x0h8c33P8cVyemS1Eq+fsTUUjJFPt4xMwljDoMprFgZ/KHGpFGITKiHJ2NV3e3sh6gnsC74ikDQ3Y72ljt3rdm23yq2kuq9mgMjOOFMsmLKf83p4AS6GufT74EvVfmD6KvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430411; c=relaxed/simple;
	bh=kOVR7WHxan8rVT9s7l+6sOxWMdyB5hFZP9FKY12efew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdtNGPtB+EFQgFEh3rUuOQ52y+KjMfWK+w+xacKznvHyE22+WTyVQyPDDs4mKNGU1GIoO9mUuCC3/RfhmnoUXI6db3mx0eOb1lE6wP7A4EsNsSyOXgBiZVunwbztRANO61imStG/jzDuFpVSXrrHHhMAkjQiIoVDzk/7qF/xL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TltLSQw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E06C4CEF4;
	Tue,  9 Sep 2025 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757430411;
	bh=kOVR7WHxan8rVT9s7l+6sOxWMdyB5hFZP9FKY12efew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TltLSQw5U/tCq48Hc8ZpAKZstPb/k9y+rx9Vt265pjPMmD8X9ttI2PPG5t51n7jyM
	 dItRwqdUERVfLYNaif1JtRRLso6EAn74+X9XOdQ9SmbnCjg3YwfghG6Ges+jwQVx+l
	 pXU3Po5BBzWjnS8LgyodTRPVCvXC5cdX38xSGyrmr07waBBsbY8BEAg+UnUlrQvTV9
	 8GE8QLBIQCvlxoqj40Z4oJrr8PxK5FeLz6nl39B+CMB05LzyTZ/gPaaEieE+4Zb7BA
	 9nYgowVVQlBAgPVxc4ItPgLzPx2PjlNs3a44BcQ5JT04wHxHXzn/h0mGJgZniEQP0J
	 W1sB6y31KOTng==
Date: Tue, 9 Sep 2025 10:06:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] docs: dt: writing-schema: Describe defining properties
 in top-level
Message-ID: <175743040906.3304763.8968694261255382606.robh@kernel.org>
References: <20250904142400.179955-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904142400.179955-2-krzysztof.kozlowski@linaro.org>


On Thu, 04 Sep 2025 16:24:01 +0200, Krzysztof Kozlowski wrote:
> Document established Devicetree bindings maintainers review practice:
> Properties having differences per each device in the binding, e.g.
> different constraints for lists or different allowed values, should
> still be defined in top-level 'properties' section and only customized
> in 'if:then:'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/writing-schema.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Applied, thanks!


