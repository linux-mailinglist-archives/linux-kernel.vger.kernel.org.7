Return-Path: <linux-kernel+bounces-751665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FC3B16C15
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C204E2518
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB0F25A322;
	Thu, 31 Jul 2025 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qws2gpyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D451E32C6;
	Thu, 31 Jul 2025 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753943581; cv=none; b=YdDRmVGqL6yh1QNsxzaa7P6QMY+3wueCBL4bNn/uFPshb+aYG9ZWSQdhUdfmU9tnjtZCmB6dML3HqU5Sm1GMqiuLmdNqtbHYYeqJKhbvN1V+MRomx0o8PNJEx4wuFWqlOO6YgBNq0kRyU+bJO/6Ggw491UAWX2Ft8i7WirxKyEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753943581; c=relaxed/simple;
	bh=10nRDdbRtJZpHUKeiyBjTnyVRKN1Tb81tLf8PDNnHBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ok0EhqPGWG7PuMCHlXC9xau0J2OTuLN3mDs51phEggi4JhjXIghcTpbG6pnfWqVL8gqw3uarjcg+dmt2CVT8tgq9Q6eAyjA9FLhm2RWV8bKipAb3RAajkr5d+AtgAiDgpJ0Ia2GI66Aqt4YsG+f6n91xintfs20iCTIqxjokiOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qws2gpyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F7CC4CEF6;
	Thu, 31 Jul 2025 06:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753943579;
	bh=10nRDdbRtJZpHUKeiyBjTnyVRKN1Tb81tLf8PDNnHBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qws2gpyyV9j+BYOBQcfUihn50ogp1E76SRWdvRY5sivhOzlu55L+gTg7zdkawi0Cq
	 9V7bw5Qn69XjBc2KXcsXrbTJc7vn57Yjt5Uhe1TL8hH7NdpRbhXJQxmzBKUhn3XAIH
	 gqDz81yxQHsmzE0cSqqwM1WHIakZFoqVfYBYugtyYxs/xQkPEdYzs3Cv4e5LiMhouq
	 I+0Q9ACzC/Dk/pdabZXRkANb6chMAZ0QHpH9XdcELC2iKB9CY0NrdAp4Ocl3xP+zDF
	 K6CpzFjnXD+Q9hLDVfGrlEpDiv1tAlxD56K+nCteqTYUvHvUKaVoNCkpbcF75Lw3PK
	 pyfWNc24urbXg==
Date: Thu, 31 Jul 2025 08:32:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: fsl: fsl,rcpm: Add
 #power-domain-cells
Message-ID: <20250731-funky-crab-of-defense-7cd658@kuoka>
References: <20250731055806.2265628-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250731055806.2265628-1-alexander.stein@ew.tq-group.com>

On Thu, Jul 31, 2025 at 07:58:04AM +0200, Alexander Stein wrote:
> dtbs_check for ls1021.dtsi warns about unsupported property:
>  power-controller@1ee2140 (fsl,ls1021a-rcpm): '#power-domain-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 
> But if removed the check warns about missing property:
>  power-controller@1ee2140 (fsl,ls1021a-rcpm): '#power-domain-cells' is a required property


And if any other warning says something, are you going to do that as
well?

> 
> Given commit 8bcf67b8d893b ("ARM: dts: ls1021a: add #power-domain-cells
> for power-controller node") explicitly added that property, add it
> to the expected property list as well.

No, commit does not explain why! It's one of this NXP commits without
explanation, doing random things.

No, explain why do you think this is a power domain provider - fast
look told me that it is NOT.

Best regards,
Krzysztof


