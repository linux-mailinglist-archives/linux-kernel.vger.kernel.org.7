Return-Path: <linux-kernel+bounces-896939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B013C51965
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66ED189BE04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17002FFF94;
	Wed, 12 Nov 2025 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsFw02eZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF229A326;
	Wed, 12 Nov 2025 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942269; cv=none; b=FXjfH2ZIPgV/ZNqvqNgNYsdUrfExNtGKRIC4+xykiHcalLCadkVBhmYGjKMwoV3An/NKOdzuRrzwyuRazzE5f17+rb/ebQfuu7c3m3NJtZPDyKCv1VxE1r4sqfyMK9Auli9RRTInlVkgowHhhnTX7udTfVWLsR8BesO6Eb3ZbrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942269; c=relaxed/simple;
	bh=67K+zUYP/aX07sPx28wY3sUmjVIxiApKZNs5WbP/U/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lf/yJQwgE+HXmUST41i5+GqO9FlAVWgXAdpo/Gx2+Err4Re40rO/DXEhTvab0FCUxAn778wxgjGq0itMr9ElsG+ELJbKMZZ2gBDw3hcD5EFm9vd6wmC5OQiBmV58QE9MbPuB4ASkafUYyO0DSmkUn7StaBmfr+iRO+5huOVv3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsFw02eZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24445C16AAE;
	Wed, 12 Nov 2025 10:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762942268;
	bh=67K+zUYP/aX07sPx28wY3sUmjVIxiApKZNs5WbP/U/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsFw02eZhsIPw+FfG11keYy8dCIECtSNGvyD+WPxdkQesFL6xRcwuaZ4wghA5HKT6
	 LaSlvWi4cRWWWLMmgzqwOlqzVRzO7lZLLwofPFRej3C2JevpIiRqg3kPmc8UoX8vOJ
	 XOJBPp4Bf42kezFpeQDGQYrGWjFnhAt/P9wReRuWGotHHidZASLq2m6ymwwAU2NaAW
	 A8gzJ1aS5FNm+yMpaS1C95OCNLJkfrIdAetAvdGsv4rDTleZiOuZ4i2973aRiXPNTu
	 WB0xggNCqMw+R6Y0P4VGJnUOwowBLdSGzCFJhUjQhr0npfC5qFTTR+8Aumke1zSV+s
	 wZK3WwYSM2d9A==
Date: Wed, 12 Nov 2025 11:11:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: michael.opdenacker@rootcommit.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: riscv: spacemit: Add OrangePi R2S
 board
Message-ID: <20251112-devious-devout-urchin-86634a@kuoka>
References: <20251112044426.2351999-1-michael.opdenacker@rootcommit.com>
 <20251112044426.2351999-2-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112044426.2351999-2-michael.opdenacker@rootcommit.com>

On Wed, Nov 12, 2025 at 04:44:40AM +0000, michael.opdenacker@rootcommit.com wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> Document the compatible string for the OrangePi R2S board [1], which
> is marketed as using the Ky X1 SoC but is in fact identical in die
> and package to the SpacemiT K1 SoC [2].
> 
> Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-R2S.html [1]
> Link: https://www.spacemit.com/en/key-stone-k1 [2]
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


