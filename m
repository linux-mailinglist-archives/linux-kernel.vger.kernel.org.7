Return-Path: <linux-kernel+bounces-876065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC465C1A8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE520189EB91
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250EC32721E;
	Wed, 29 Oct 2025 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR089nn/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E820297E;
	Wed, 29 Oct 2025 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742342; cv=none; b=n+yH3+27KYbYg4tWagR1vC2+QDsnFp0s3PckHL+HDeJh1jwMYZ7OuHNriQQ60372uL7vyHiCmTC/zaDgfpS8S35J5C9fjQxXOLa3Wf42YBuUjItyKjatPGEhD37WmNhMa7bzY04GWIZiCt6QIKB/Yf/t1Yx4UP6YtXinRIA4FEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742342; c=relaxed/simple;
	bh=1HAJ1BJ3hJr4rMA1mSnM4Z+EA/gpodPOwk5FC2dXS+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhMVYMTBSGc7S9VH+e45U1t2IAvUKu5v+ijowcdP9gMEkXFw4Hl5OuY0bnyqllnbsYB5QI4p1TtZMStSCshsM0C7io8yshXrkzB0wu9uNi2DI1xgebnFb5fdXEBwN9r08IifAG8TXIFlM9AII+weQ/0vvQt/SQLWXzaUd3RztyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR089nn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F402C4CEF7;
	Wed, 29 Oct 2025 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761742342;
	bh=1HAJ1BJ3hJr4rMA1mSnM4Z+EA/gpodPOwk5FC2dXS+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eR089nn/rglpiimPihlYCj2SAY7spC2qAj5Lr7H6Goy6akWpAa25G5+gOrKYvQ424
	 MoaGPeC0uz358YVaYuA68Xmgpu+OTQO3hZ+xSYhXinicU4oLgbMDuN+tndeRCNsWki
	 jenc5xV1wdfqBHdaxOJ/1pv+/eQyxjndYz45Qi7IYLuuxgRKGVSe1TbkSVX1e2PYmq
	 2jq5hqWLHMD4bRNG6H/vlmS8WV618g19vR/E5AeXpInNitu+gGfbaXJW2HSbfKCIjG
	 OuafbZLakfKlxk7EWUkm24lWPX9UccCbRtdWTLxiIH0RxWJD31ryDwlbS3NcZR4sSf
	 7h6QQMFcwwLsw==
Date: Wed, 29 Oct 2025 12:52:14 +0000
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH v3 4/5] reset: th1520: Support reset controllers in more
 subsystems
Message-ID: <aQIN_lVnn3wcwBCg@gen8>
References: <20251014131032.49616-1-ziyao@disroot.org>
 <20251014131032.49616-5-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014131032.49616-5-ziyao@disroot.org>

On Tue, Oct 14, 2025 at 01:10:31PM +0000, Yao Zi wrote:
> Introduce reset controllers for AP, MISC, VI, VP and DSP subsystems and
> add their reset signal mappings.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/reset/reset-th1520.c | 793 +++++++++++++++++++++++++++++++++++
>  1 file changed, 793 insertions(+)

Reviewed-by: Drew Fustini <fustini@kernel.org>

