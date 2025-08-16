Return-Path: <linux-kernel+bounces-772292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D138EB290ED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 01:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E50377ABF04
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 23:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7621D63EF;
	Sat, 16 Aug 2025 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTI2DQ+Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F453176E9;
	Sat, 16 Aug 2025 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755386201; cv=none; b=U3LIOXNkYoK6skO39kZzASNGP7B6UDWq16MfAUc1nCc29s3KGHVAoPqLKAHUv0GweJOe4/iZMFHrjFWLoiAQpse2+Uq6atzE1HCGayT2nzwryolNRBG0m7tX0XJhnVdT8u880dzM5fCh17YUeRkdDDFVWJ/iLwLopb5NM7Awe4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755386201; c=relaxed/simple;
	bh=OHkAbGlDKsYvfqX+OzqqHwvaoFnMvxEZtaai09lKiY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpDXqD4ymFKdKnJQqoBgFFIA/cgYT7OrLGmqyb3gyvp67d/nBnQjbI1QXD6xdelBYBeceMso9Wh8b+echdbtHxJdTtQso9bCjeadGdw+yf8hn+gD4YngAQgxo8/NMtwyEkvaY3r3bGnU+NtbJi+IC/AufeD3NnuMUBOv+Qu7Sdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTI2DQ+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F6BC4CEEF;
	Sat, 16 Aug 2025 23:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755386201;
	bh=OHkAbGlDKsYvfqX+OzqqHwvaoFnMvxEZtaai09lKiY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTI2DQ+ZYBGZ3nagYB/0VvE8BZYgTsR+poCS+c20iBCA1LNtz+awi6X/uTLW93f4H
	 CTkmgeiWSyzoFRonRwF4lsgq8AqO1GWTfsRmrAEHJ8Sb/rCuj33jBhlVFIqNuvZ/zP
	 FGrl1zqsKj7JsawWickGyKG5x1qZhpK5RClHKalq9jt4WxY6ro7Qe2Z5BnepSjaj66
	 5NweiLL0qJiSbwQV4W6JhM1HYu97aoaL3MTtKqMhBD2eB5QrwV7G3T24r8+DFgjvYR
	 0Ha1aQKx5sODtppA0Lr4uZQttGLIab42iBgSCxky8bzF9hFajM6ljHVYJQvBywwoQ1
	 t8d3LpALm9LKQ==
Date: Sat, 16 Aug 2025 16:16:39 -0700
From: Drew Fustini <fustini@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.dev>
Cc: Icenowy Zheng <uwu@icenowy.me>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>, Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: thead: th1520-ap: describe gate clocks with
 clk_gate
Message-ID: <aKERV0c7jat//279@x1>
References: <20250813171136.2213309-1-uwu@icenowy.me>
 <20250813171136.2213309-2-uwu@icenowy.me>
 <aKA9QxKo3fg-bdNa@troy-wujie14pro-arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKA9QxKo3fg-bdNa@troy-wujie14pro-arch>

On Sat, Aug 16, 2025 at 04:11:47PM +0800, Troy Mitchell wrote:
> On Thu, Aug 14, 2025 at 01:11:35AM +0800, Icenowy Zheng wrote:
> > Similar to previous situation of mux clocks, the gate clocks of
> > clk-th1520-ap drivers are also using a helper that creates a temporary
> > struct clk_hw and abandons the struct clk_hw in struct ccu_common, which
> > prevents clock gates to be clock parents.
> > 
> > Do the similar refactor of dropping struct ccu_common and directly use
> > struct clk_gate here.
> > 
> > This patch mimics the refactor done on struct ccu_mux at [1].
> > 
> > [1] https://lore.kernel.org/all/20250722080535.60027-2-ziyao@disroot.org/
> Should we remove this link to the cover-letter?
>                 - Troy

Good point. Yes, I think this would be better than a link as it is now
in master:

54edba916e29 ("clk: thead: th1520-ap: Describe mux clocks with clk_mux")

There is already v2 posted so no need for v3 just for this. I can fixup
when applying.

Thanks,
Drew

