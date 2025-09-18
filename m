Return-Path: <linux-kernel+bounces-759885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D96F0B1E3F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8634189C3A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A63425179A;
	Fri,  8 Aug 2025 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZ2MAqel"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B9578F39;
	Fri,  8 Aug 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639931; cv=none; b=dZOE4xt1/dDRcW3gJjfSbGcwSoDYgPu3GbVSxS+4Ok98W24VTUH7D+Ljq2jto1j0Bsvf2PKglmlvrBCsoEkMuNw36x63hoW6XqcHIpvjA5665jMiqMjupx/Dm+QIOrL5/5JWtnzWiW8xWAraDuypweck4iiLGnRPl2nEYO2bn5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639931; c=relaxed/simple;
	bh=bhYz0q7sZmksGxtqrz5Z9izdRimJdpZwVcCdQnTK6+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzwTF96uu7tC0DOnbyiQKoFGWosLOra7ADzCm6n7Xj84Ng5ZB0KUQI1FnXWoB1+WDTQ4lfhuU43gKlaj64VYhqYEvUrke2mH86jf9blwfGs/65kKt5EWXbgdppiMPfAunjfGuqaDD5+R/LxBQllec3Tr20Mkqs6O9ljJ7yGfsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZ2MAqel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF26C4CEED;
	Fri,  8 Aug 2025 07:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754639931;
	bh=bhYz0q7sZmksGxtqrz5Z9izdRimJdpZwVcCdQnTK6+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZ2MAqel0O8SuouEJlBD0NRUR0D89he19cH5jWtUYyHwWCg2Yz8DO9SXgjIeDZd+y
	 08od+i1Nr52Vf8xefFUv6zBJAlslkMjGanYsbRt+klaK5B006boeiCkfNFE+3by4F9
	 LlSpkU0BXQzItv7AzoPiWYHTZisBzcUvjQv7tq0GztWAVvkSdrAnJvtpxIVJKyl0Et
	 YZv1PZZl9sJGHuAmb3LispoeizFPKz4tMfziyI7hxPvWHVsrFYMW+Hyqw4YmVUjFRf
	 XhyRE4MdvGWedowvfZ79iJmjU680KcM2Hs8Y84LpgbL4vs4rw6mfgM5hs+i6hxa0ld
	 XsBRpCQtcD7rA==
Date: Fri, 8 Aug 2025 09:58:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: Drop duplicate
 moxa,moxart-watchdog.txt
Message-ID: <20250808-tidy-ambrosial-okapi-e5249b@kuoka>
References: <20250807214222.4170236-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807214222.4170236-1-robh@kernel.org>

On Thu, Aug 07, 2025 at 04:42:21PM -0500, Rob Herring (Arm) wrote:
> "moxa,moxart-watchdog" is already documented in faraday,ftwdt010.yaml,
> so drop the old text binding.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Fixes: 289660a4af0e ("dt-bindings: watchdog: convert faraday,ftwdt010 to yaml")

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


