Return-Path: <linux-kernel+bounces-771554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E47BCB288BC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5401D05AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC02D3747;
	Fri, 15 Aug 2025 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqZ/cddD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADD42D0604;
	Fri, 15 Aug 2025 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300498; cv=none; b=fjyETT6Sx0qDKDnAUUMdzxOgl0upugKAjvNjalPyRtD/fS58XCX8wDQ+dfWn/6zLkELXJ1h2XqbNSApafsxND+KdI8LamUICw8F+hJsQ6iuqwWRi8WKt/xq6OujPc2YpNqUYePRMEwQoLH15m0eATBn4rTOS8wub9RSwHqFokQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300498; c=relaxed/simple;
	bh=yelvL4dmdgGDCuYleeyGfJDg/UCsmwpvJL6w2P4pq9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiM/ud0Wuc7Vp6ilz7O2JP4rBxscY/RZ+FyDCMtP9xaNs7L24vsTiK+WAJLaTjar0NMxwgllvkdEI2Mx+wa3bLz0wZgDfd2I4svx0PhrK0fgSxDLtdEhCOaMzhJDcfxqF/eQvCTWQ7Es6ilUqjvDpE3FBruxW/nc2pmRJDVLKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqZ/cddD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB6EC4CEEB;
	Fri, 15 Aug 2025 23:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755300497;
	bh=yelvL4dmdgGDCuYleeyGfJDg/UCsmwpvJL6w2P4pq9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqZ/cddDsjxUfDISYYsis1AnupksV+QZJvj/YQxMXXKrirybYWyGnqw4PTI0aVdd+
	 pxFnuuiJgd9gmjWa8pYiKfv32etx+dk8lCdNquGmfr1fOoVUhT5fTJ7mrwGhdQv4Ll
	 tfD9RtqC5vHwZnWXxNNm3C90yD6ORuJhYYbS+RjXwvm7+2O1/OVM/silVmrhYWae9X
	 vySHsADtZwuNMD2Y4Cfis2d3DMNyrDy8iHeXTb36Tokv20bn9lLvF697GOZtguRFZX
	 fYGX9qi5NT9pH2dXdHmo+BthrW9mAkS/jAKzuBtZymXoOb73866JopEaRl/xRnv3hQ
	 zY8JPn3asjiTA==
Date: Fri, 15 Aug 2025 16:28:16 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>, Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] clk: thead: th1520-ap: allow gate cascade and fix
 padctrl0
Message-ID: <aJ/CkFlRNFCYNoOS@x1>
References: <20250813171136.2213309-1-uwu@icenowy.me>
 <eedd44480a76840e1fec73d4433c772c5bdc7011.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eedd44480a76840e1fec73d4433c772c5bdc7011.camel@icenowy.me>

On Thu, Aug 14, 2025 at 01:16:16AM +0800, Icenowy Zheng wrote:
> 在 2025-08-14星期四的 01:11 +0800，Icenowy Zheng写道：
> > Current ccu_gate implementation does not easily allow gates to be
> > clock
> > parents because of the waste of struct clk_hw in struct ccu_gate;
> > however it's found that the padctrl0 apb clock gate seems to be
> > downstream of perisys-apb4-hclk, gating the latter w/o gating the
> > former
> > makes the padctrl0 registers inaccessible too.
> > 
> > Fix this by refactor ccu_gate code, mimicing what Yao Zi did on
> > ccu_mux; and then assign perisys-apb4-hclk as parent of padctrl0 bus
> > gate.
> 
> Forgot to mention a easy test of this patchset:
> 
> Just install `gpioset` from `libgpiod` on a Lichee Pi 4A, plug a fan to
> its fan port, and run `gpioset 3 3=1`. The expected behavior is the fan
> starts to spin (because GPIO3_3 is the pin controlling the fan),
> however without this patchset Linux will fail to switch that pin.

Thanks. That worked great and the fan is spinning :)

Drew

