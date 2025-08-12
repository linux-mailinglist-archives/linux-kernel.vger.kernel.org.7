Return-Path: <linux-kernel+bounces-764034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BB5B21D05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC27668305F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B892D3A86;
	Tue, 12 Aug 2025 05:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE8wz8IM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F147D296BCA;
	Tue, 12 Aug 2025 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977198; cv=none; b=HYa+80ntUMz6T93BvyGeYtWCQMip8/hGjnbKXmeK2PYdw+xGmGkFjsDGBHmmo3OekfaFQJtfx2EQqUp4SUtD7nNrr0DFhshqhRdPi3jO+VIkTaRef8G2j4zw5O7HlfdeocZAG9otYqfIoXFaR2GOuvCpkBTSIHMmCc3c01Y6Hfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977198; c=relaxed/simple;
	bh=8Ka0sd8FxkjIz00jjTcMx5oRTqQPN4HlysV+S/vVdgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvbtHcFzx5a3A7e2F4qFP6M8Dq1Y08z9lEX+zMBz0EK3fmDKtiPcvq0wd3W1dVggY8gCnddM7LE1dGRbaw/1uDo1YPugrTI9UlFy9sBJgzhM8niHb3+O8KBxvXcfP2m5ungggTUzMCOlDscq9VZfimlMrqD+Xf1Xw7+KYaLKDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE8wz8IM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A546C4CEF0;
	Tue, 12 Aug 2025 05:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754977197;
	bh=8Ka0sd8FxkjIz00jjTcMx5oRTqQPN4HlysV+S/vVdgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GE8wz8IMlrQ5frhZwhslxoZ05i34brKKZumRyQwF689QOSgTaFZ4QOtiuRFdLkKFo
	 T8FdEaLYiDtcdg0jBvfLspbmGk3B0Yvqb7JT8CYbJtUfaRLpE2UKWKHbihYErODUOt
	 BmPxM+qVmzdAwUiAch8OuSyRWgCO22dYFAbTPgOokj78zRc+EgY2yNpJkv90wiMYqu
	 /T6uG+wHR/R6gjdsAA8gftXTQmDlP8R+2BICsqJFlhtZfJVid+ODeHsFKviFyG0/Ud
	 HGDQkXVlBYcqGDPh8zSyl8U1T0opdAmMP1VLxRSuluHHibY1+mNyteI4yg644FX8XU
	 i9FhMfDk8ObzA==
Date: Mon, 11 Aug 2025 22:39:55 -0700
From: Drew Fustini <fustini@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH] reset: thead: Scope TH1520 reset driver to VO subsystem
Message-ID: <aJrTq775sXTrsepl@x1>
References: <CGME20250810211419eucas1p173e5fefcfaae437d8b5531d1406ff6a6@eucas1p1.samsung.com>
 <20250810-fix_reset_2-v1-1-b0d1900ba578@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-fix_reset_2-v1-1-b0d1900ba578@samsung.com>

On Sun, Aug 10, 2025 at 11:14:19PM +0200, Michal Wilczynski wrote:
> The reset controller driver for the TH1520 was using the generic
> compatible string "thead,th1520-reset". However, the current
> implementation only manages the resets for the Video Output (VO)
> subsystem.

Looking at Section 5.4 on Page 451 of the TH1520 System User Manual [1],
it does seem like we would ultimately need 6 separate nodes for reset
controllers:

 0xFF_EF01_4000: AP_SUBSYS
 0xFF_EC02_C000: MISC_SUBSYS
 0xFF_E404_0000: VI_SUBSYS
 0xFF_EF52_8000: VO_SUBSYS
 0xFF_ECC3_0000: VP_SUBSYS
 0xFF_EF04_0000: DSP_SUBSYS

Maybe we should take this opportunity to document the bindings for all
the resets that the REE (e.g. Linux) can control?

It seemed like that was overkill for the 2 resets needed for the GPU,
but, as Krzysztof noted in this thread, problems arise when bindings are
introduced that are not complete.

Thanks,
Drew

[1] https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf

