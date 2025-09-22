Return-Path: <linux-kernel+bounces-827574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BA0B921FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7682A4439
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4931631065A;
	Mon, 22 Sep 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNEhAO9a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142B2EA75C;
	Mon, 22 Sep 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557144; cv=none; b=rZ/gUBFE6cPWH5Kh2tPlaqcwJ1zNyardIUiDFbi5+lgzm4ecazyVbTfLnpdqg2j0vgvndnp5XsLy5bizTdsAw5pnI8ehXu1FzBisufcOooXygkYiXH+EgaWkHC5u5qb38g4+OrwHSYerdB6xo+FtgDGVJfQP3dZXdiTo73xSS1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557144; c=relaxed/simple;
	bh=JPkZxdmSLhErHT2r6+C3wkfctmMfikaGR/BNm9a5YNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNBPdC+vKB3deYgvriw8RNj/riTHn3SdmCKAYHs7xrvDiXgA8WZskDY3QI14yBgIfI8FrnzE2zhJscRPBB2GJBYqRiVWDtfaEBGV4CLCfOpAMgd8XUlPq/bnMbwUc3bu2MENmfEqOat1MrTnFMmbOmG8otahs1/L4HY2RbE22eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNEhAO9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14679C4CEF0;
	Mon, 22 Sep 2025 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758557144;
	bh=JPkZxdmSLhErHT2r6+C3wkfctmMfikaGR/BNm9a5YNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GNEhAO9aBetiLDHu8K9co2Qyo5AsQg6T/SupFrIVQSWa3I3reOQFVWsEYJapeiMoN
	 5cCsYyagEi096PoQPTkMz0vEV06YJTqmb661KvwQnc7vM400S6qrWy4qGwe4ESp2Wl
	 VsgI5kqtZVoXkObKtO4kKkE3JgxUE8PIJ4UyoB/VKFg8C/SGEHvYYWXy2mguMxA/Fc
	 lM54ZW8AOLU43HrYaF+3lfcp1/ES/ucuhvpaAycZSTCdNV8XRKgLUdC8ww7gNkrTGR
	 u71vKSP1hjUkuv9jtNAZAhXCKN2NpfERCQxVbQf7Q4NSyhk25OmhMmi1SHtU0DYIzt
	 oGy7oEnybRyhA==
Date: Mon, 22 Sep 2025 11:05:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>, Icenowy Zheng <uwu@icenowy.me>,
	Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
	Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <fustini@kernel.org>, linux-riscv@lists.infradead.org,
	Fu Wei <wefu@redhat.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: reset: thead,th1520-reset: Add
 controllers for more subsys
Message-ID: <175855714271.140455.3621528471565311357.robh@kernel.org>
References: <20250915095331.53350-1-ziyao@disroot.org>
 <20250915095331.53350-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915095331.53350-3-ziyao@disroot.org>


On Mon, 15 Sep 2025 09:53:28 +0000, Yao Zi wrote:
> TH1520 SoC is divided into several subsystems, most of them have
> distinct reset controllers. Let's document reset controllers other than
> the one for VO subsystem and IDs for their reset signals.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  .../bindings/reset/thead,th1520-reset.yaml    |   8 +-
>  .../dt-bindings/reset/thead,th1520-reset.h    | 216 ++++++++++++++++++
>  2 files changed, 223 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


