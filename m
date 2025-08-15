Return-Path: <linux-kernel+bounces-771560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837A4B288EA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42DC3AE2ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1039E27F18F;
	Fri, 15 Aug 2025 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAocX+1X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B94202963;
	Fri, 15 Aug 2025 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301537; cv=none; b=DdRsoMB7ygBJQPRaKeIZCoG99wIwOFr9XJQQt1X/6ZCZyVHpV+CTRnn7o7kWqJ4h3uV9NaWzJ/EnNrVKiPkwI1sm/XQ+gKq5mQlQkiPQf9zLouaoN+w6iiZONYsjpjOBCz8Wzt6dPTh9+wDL9Cw12XnKqbV7eAATxbR/ybk90Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301537; c=relaxed/simple;
	bh=g68O3WmYOhk4y5L79Ofa0c3kpmvbkMRbUGdK4BAXSrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIpcBBsizvSeEbJB+vDUDhIlvV4bA88i7Y/DIXEKKIa1kZUBm597KQm/sg51kGDofqFR7SRVqZQ21cW0D/CzWoclWebTv30OEOo8xV4PKYdokd3tQkB0HMQgV7cNsLPfVM97fXpAYTHdaXpTtGcSvaM9QZ73TbioMttC+XrF/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAocX+1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB8FC4CEEB;
	Fri, 15 Aug 2025 23:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755301537;
	bh=g68O3WmYOhk4y5L79Ofa0c3kpmvbkMRbUGdK4BAXSrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAocX+1XJ55zDaEfebP8eiItlhPcEHOFkcM8AAnOFUHjfUQZjIHRIu54XvhsRnYLW
	 X248Ua9VPnXnKIUrafSn3+h7l/XhKWoB4eLmAX5wlpzfaH8/0vS0X8czOTA+ASzB0f
	 dm9xpwP9Wdn64dMZkMJQEse9JfdW+abCZXscpSSmwI47YRqgevHpFPs/baByOAIR5M
	 woPb7GKTEm6uWNDgjZJCvIHjGIwfpmBBhrLZGm/7y6YtqpHEDSkU42I1Vx8b+gTZUd
	 bWFtBe7D41YF2EzFcuR1zVWK3CTOoM+L43sG72lVF7tuTGVc+OP56Es5BGtG0Kp9cQ
	 gbHrpTQN6a2Pw==
Date: Fri, 15 Aug 2025 16:45:35 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>, Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: thead: th1520-ap: describe gate clocks with
 clk_gate
Message-ID: <aJ/Gn2BeN4w2Yy9y@x1>
References: <20250813171136.2213309-1-uwu@icenowy.me>
 <20250813171136.2213309-2-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813171136.2213309-2-uwu@icenowy.me>

On Thu, Aug 14, 2025 at 01:11:35AM +0800, Icenowy Zheng wrote:
> Similar to previous situation of mux clocks, the gate clocks of
> clk-th1520-ap drivers are also using a helper that creates a temporary
> struct clk_hw and abandons the struct clk_hw in struct ccu_common, which
> prevents clock gates to be clock parents.
> 
> Do the similar refactor of dropping struct ccu_common and directly use
> struct clk_gate here.
> 
> This patch mimics the refactor done on struct ccu_mux at [1].
> 
> [1] https://lore.kernel.org/all/20250722080535.60027-2-ziyao@disroot.org/
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  drivers/clk/thead/clk-th1520-ap.c | 382 +++++++++++++++---------------
>  1 file changed, 185 insertions(+), 197 deletions(-)

Reviewed-by: Drew Fustini <fustini@kernel.org>

