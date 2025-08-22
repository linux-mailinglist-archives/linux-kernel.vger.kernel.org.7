Return-Path: <linux-kernel+bounces-781501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24739B31348
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35042AE663A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99632F3C27;
	Fri, 22 Aug 2025 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="fHpzJPtq"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B22EE294;
	Fri, 22 Aug 2025 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854913; cv=none; b=fQTnBZnQdmutf7KmLYZB5+8DD/3Lo0ABbfCXNzOydpZdsSeOwYpO7qu4rma6oag7WUesfA2nGN7Z/K6DbysjuCPQni7kYs+2wnwv64tzZ0OXIH7TYi8gQVvE9X/LNcWKte00lJ7fYCPLEmZtObU7/Omzrpi4baM4uet/uxJX1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854913; c=relaxed/simple;
	bh=IsNj9uInZkrMsaoaUxUhUuHNenZprupXfruqUfNmiUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCcRDjlAx70Yng/yj5cFcfF8Aoty+N/Uln8Zxnhxp9C9KN1G7GjzU8WZECAeJbmkSgX6YdJftoYgVoCxFwkBzG0kj+rkyQSLbeTBuroxqRTtJ8VjPGRsbXn6Rus7A0h9WQOI0pX2rc8Hlafds1mZ4qXwGv4jKgi27r6GVPJIsRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=fHpzJPtq; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=aTeBCNJiDt3v1ve0MlkfHgac60e/CC7BZoKpC+WEhvA=;
	b=fHpzJPtq6stk8SPQu4lRtLezJcNXTwTYyc6+wmgIwj2wl+ImFeTuEAAS3dvY2u
	Zf8hqpa1dyh6XWVdp0wYdQoGb8ELgyYXVgrissmSztP9Ll9GC+uch8cqlneXnQ+H
	iN4INmWzs1cLuIYljhwy6nroIQp7lG/LlUCPiILd7yORc=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgBHBW_9N6hoN_AVAw--.14855S3;
	Fri, 22 Aug 2025 17:27:27 +0800 (CST)
Date: Fri, 22 Aug 2025 17:27:25 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: nxp: imx6ull: Minor whitespace cleanup
Message-ID: <aKg3_XjbcZFruQiP@dragon>
References: <20250819131800.86990-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819131800.86990-3-krzysztof.kozlowski@linaro.org>
X-CM-TRANSID:M88vCgBHBW_9N6hoN_AVAw--.14855S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUO7KIDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgyxZWioJsEtvwAAs-

On Tue, Aug 19, 2025 at 03:18:01PM +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '='
> character.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!


