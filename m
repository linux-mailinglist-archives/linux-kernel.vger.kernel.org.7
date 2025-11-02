Return-Path: <linux-kernel+bounces-881890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE29C29289
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 104F54E5F8F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99DC261B9E;
	Sun,  2 Nov 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKgcFFAY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4545E224F3;
	Sun,  2 Nov 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762101615; cv=none; b=fenRVB5bUc2Xfbh3aczAqEJ4lMgLI6WvDNwvLkYndx1MUEi6jqeomU9x2/SjzCyfYvB1vG0V0gCfTNUZ0kHDf9trJiBZYiGLK7+taRcmm92a0wDENDBa+4j0N88tXh2XU/dy85joZrmNAZoWiaIX83gqghYlhh5Wn7rIRggnbe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762101615; c=relaxed/simple;
	bh=Yd304Dsac0JoNdGGDBJBCJMsJt3YXC7HW5YWdLVa2GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4BoXSmfuYNCMPztqL0pRm11TchsV4zfHvayZrMcsyIRhC2BSTMTrWb19J4f13/KY40UWiVa4qqBveicquk4VUgQS01UAFaBmFwPtSasfMm0E+gkN+Acd7v3inFZrlawI4fokAs/Uh/3WamOV963wTcwrihBAjy7sHJg0zpkKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKgcFFAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2523BC4CEF7;
	Sun,  2 Nov 2025 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762101614;
	bh=Yd304Dsac0JoNdGGDBJBCJMsJt3YXC7HW5YWdLVa2GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKgcFFAYPFW9NekrZ+naPFcnHJl90MChFb50AnY0iZ9fhttg5+14LtEJdjl11RUel
	 xwvYstxX+S4CFVEJohVzfnyzmuIIIXrWKbDfnN+HWu/0DwMykEpdhBL5QF4nxLgkhb
	 GAyBeCZIOE3NN2mEPeKhsWoSbO9mZOPd4IO5N2GdFkP/KnapaK+xfE1FeUKPLJdIJ8
	 v30RvKZo74sUkXe8UYhv1L8NFGuBxQ8Z9Hq42GG15cP+oxg7/6ryf/ipSiU1jh6/bW
	 ST3BkneVN9/jcIRrqroJ5o4ODWgJb1h1SMBGG8Bw0ASRtyyPr0iuYvXcK2DMeEIOsn
	 Wklr1sU684V9Q==
Date: Sun, 2 Nov 2025 17:40:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/4] dt-bindings: clock: renesas,r9a09g057-cpg: Add
 USB3.0 core clocks
Message-ID: <20251102-sawfly-of-imaginary-attraction-7b4900@kuoka>
References: <20251101050034.738807-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251101050034.738807-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251101050034.738807-2-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Sat, Nov 01, 2025 at 05:00:31AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add definitions for USB3.0 core clocks in the R9A09G057 CPG DT bindings
> header file.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  include/dt-bindings/clock/renesas,r9a09g057-cpg.h | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


