Return-Path: <linux-kernel+bounces-780495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9743B302AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB768AC54AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294F34AAF0;
	Thu, 21 Aug 2025 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kijUHdnT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8D3469F2;
	Thu, 21 Aug 2025 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803499; cv=none; b=AHnYPNLM2Qj4mBxAloNLewpXBSH2F/ARB16cxUxHOA4wAt6SSaQ3VL1PBYldsJewTlML8AN8OlHgeYVf7tCTkR3RS7gxtXez4Kf3DtUEIrqndoUOZHGgUbyZOWGSXjDV9Rh1UKFlpOmhbf7nAQgdqrTvWZS6PkiD3XcFgMfX5bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803499; c=relaxed/simple;
	bh=uBeS+0q2RfC8E0D72PJXd2iaXb6wfvh3yNZW4yspKXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK536ve0tiL2HW6O2NQLm6UJZp/VyiRhOoNI6PPc+Y3O4YAyqP4pbgO9n617p1c4QqrdaGWLO9B6n2TVaU94XP5QOfjjUPocM5Gi2bZgDP/MnTdfmYIy8zxQdM79w8ZExf7hupGWAkz71WRatbQGEIVrMOS0pDjnYcXf22Qh6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kijUHdnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1406EC4CEEB;
	Thu, 21 Aug 2025 19:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755803498;
	bh=uBeS+0q2RfC8E0D72PJXd2iaXb6wfvh3yNZW4yspKXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kijUHdnTxV825tQwAxz4HfPtuqm6T0T+mT+WxRjh/D7F4OUdxWHIfltQsGl5ykAOB
	 dXLvFBd/jI8kX+UJG16ktu8W7D9f+gkrqrFbriO3Oe48JBGRD+2EpCBU/i6KHtzVd2
	 0Om7167ANP4ywCiEhnqwinj5Veq5XWFDPajsolGuZ6y8iO7SzWG4yIRs28/yGby88H
	 0pRNAk3x5WFGhkPzdp7exxe4YVURRBcscfgz9Yq7RvxLlHWJmQIaCY0Pjlv5/RMCCb
	 7g5PwjDM38OaRPoQyON9bTGWdg997vY5agkQO7th9cFDBBZQ2v5yLSAZCfexeNGx/X
	 Se0dkqW6SCUpA==
Date: Thu, 21 Aug 2025 14:11:37 -0500
From: Rob Herring <robh@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl, Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] dt-bindings: vendor-prefixes: add eswin
Message-ID: <20250821191137.GA421206-robh@kernel.org>
References: <20250616112316.3833343-1-pinkesh.vaghela@einfochips.com>
 <20250616112316.3833343-4-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616112316.3833343-4-pinkesh.vaghela@einfochips.com>

On Mon, Jun 16, 2025 at 04:53:12PM +0530, Pinkesh Vaghela wrote:
> From: Pritesh Patel <pritesh.patel@einfochips.com>
> 
> Add new vendor string to dt bindings.
> This new vendor string is used by
> - ESWIN EIC770X SoC
> - HiFive Premier P550 board which uses EIC7700 SoC.
> 
> Link: https://www.eswin.com/en/
> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

I applied this patch as 'eswin' is already in use in several bindings.

Rob

