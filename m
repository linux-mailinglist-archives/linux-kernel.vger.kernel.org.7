Return-Path: <linux-kernel+bounces-729524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106B1B037DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B83D3B78C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40B233739;
	Mon, 14 Jul 2025 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLQ0jOfM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9661DED5F;
	Mon, 14 Jul 2025 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477901; cv=none; b=LKNNBagRvkZqkbmcmBoWJrgReI6UFovXByOvpzr/ecS6cFN+I7owRw9Sq5rXNJxtL5uCCWSyFJwrhRJCn6sjYt+MFW1P4MrDVbAb4XbPeiilkaXqGUE1jQTchjzG4Up7vLsHg5QpZfU5sYeOGS7hduNycHcg4Kz9E/B8uar7eWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477901; c=relaxed/simple;
	bh=31raCFaPiyp00m3OmWgEiPWHrGfyp5cb3Vqu6ClBwy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9ONZCSAxTYqnuJNcnMC6Zxyu1vW19llfn8Bwe9IYdbZHrEbX6pk7K5aA7yEpmGaPTdunYEpBZxJ2IeRTzBPIbzkpDtSz//KNlPswmsgGpD4ZtnwjC4s2RxyS2Rfe7Byv79nbNugtqzv4ONHpWaMxPzgaevS5rlmR86StfeoyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLQ0jOfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13425C4CEED;
	Mon, 14 Jul 2025 07:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752477901;
	bh=31raCFaPiyp00m3OmWgEiPWHrGfyp5cb3Vqu6ClBwy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLQ0jOfMS16iIpKY3iy/6tIxYMplbIH1puaye44hDB8n37iovnzkVEn/MTuohsSyy
	 vXI7urple0C8RgdJFmA3+VG3ZHZJILNoxO4WMxmMNo2Gt8CP5VWISCxG7ePj58U/WX
	 brlPq2X52GlXcMGzKcmNcLr05wG56OKb9z1T82a8SZtrcGL7T86zlst+l6oIhXChp9
	 ebCCjZDtT5BU41T4SCrnUvxZHGA0xq8qE8U2LQwM/8QZnLZ+n14dayDn35wjwDjYHr
	 Ly+qwO7mQKLHP67tYRO+ttq+0CfWsQop0brLNXXwKZR8zaUR9xT5Cjx1M3324oEdRm
	 +dHh/dMZAauYA==
Date: Mon, 14 Jul 2025 09:24:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Djordje Todorovic <djordje.todorovic@htecgroup.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: timer: mti,gcru
Message-ID: <20250714-wooden-ebony-turaco-a0accf@krzk-bin>
References: <20250711-riscv-time-mmio-v5-0-9ed1f825ad5e@htecgroup.com>
 <20250711-riscv-time-mmio-v5-1-9ed1f825ad5e@htecgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711-riscv-time-mmio-v5-1-9ed1f825ad5e@htecgroup.com>

On Fri, Jul 11, 2025 at 11:56:45PM +0200, Aleksa Paunovic wrote:
> +$id: http://devicetree.org/schemas/timer/mti,gcru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GCR.U timer device for RISC-V platforms
> +
> +maintainers:
> +  - Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> +
> +description:
> +  The GCR.U memory region contains memory mapped shadow copies of
> +  mtime and hrtime Global Configuration Registers,
> +  which software can choose to make accessible from user mode.
> +
> +properties:
> +  compatible:
> +    const: mti,gcru

Is this architecture? vendor prefix suggests not. So is this for SoC?
Then why there are no SoC compatibles here instead?

Best regards,
Krzysztof


