Return-Path: <linux-kernel+bounces-769821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380BCB27414
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA811C26B73
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F7E273FE;
	Fri, 15 Aug 2025 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFcLuPKY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3534319871;
	Fri, 15 Aug 2025 00:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218207; cv=none; b=gVcGWJPmZDsnJB5y0mEqYlbJiKrKBBXKiCuIA70BCxTlGJ9G/POAFXZ4dfMUHAlr1sVhikla8wroNpl8cmMNdR8cqM6TJdIdOqNaB7AIIgqxPk3Je0xHfAwkgKCeanu6SxuFC23uyeEY6N5P/v4YtBGl6kfyTFMmQNHhJlHjtMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218207; c=relaxed/simple;
	bh=tStMn6cXffkABhKDGFsldNpRJKwVGbfiZhtguFPxof8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pg2DUUmaBjbz0nrhuttUN2s2U0Scpyi9eBiJ7OGPAAAbO/X+4VXkYIzZ4acvnednNKlxkVmliyG/4JAFpjtJFj1sRosDJ0THhxncsPMccNIYsP0Ka1QC5oqACB4TTKepzqUwDtHMIgtBr5X54/7d43mf28CeJpcrla9M368zz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFcLuPKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B81C4CEED;
	Fri, 15 Aug 2025 00:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755218206;
	bh=tStMn6cXffkABhKDGFsldNpRJKwVGbfiZhtguFPxof8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFcLuPKYFk93wVJI5GEXM8c8m2Ugh5j3GZ1C9JAfKbdLRjVlDYAZpTFlSRNU4LiGO
	 er6ll6LEi37Xx/PRqbbZbe28rf/YNZM+/6+s9NIf5at3NktUreq4KwXa/0n2yWOCAD
	 Ai4BAf9kDu/HlLmZRZZVpzSJSVqVi3lLKEUsUf9pGS+4NcLTGIuR/wqtKOGJseXTA/
	 qGFTfBxKbZQmDhek4MgeGn20eLb4UPoN8ebpjjjf/ixBYiU1MqTUHd25Ys08DJe6lT
	 nfCt4JrVSME16FsY7d/v0O9i4WS7iAagsVSNg+GZyZ6XP+DnR4q60ef3tp6Q8lDU07
	 OukDmSN1nJ3sg==
Date: Thu, 14 Aug 2025 17:36:44 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>, Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] clk: thead: th1520-ap: set all AXI clocks to
 CLK_IS_CRITICAL
Message-ID: <aJ6BHNcf2e9x8QmF@x1>
References: <20250813072702.2176993-1-uwu@icenowy.me>
 <20250813072702.2176993-4-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813072702.2176993-4-uwu@icenowy.me>

On Wed, Aug 13, 2025 at 03:27:02PM +0800, Icenowy Zheng wrote:
> The AXI crossbar of TH1520 has no proper timeout handling, which means
> gating AXI clocks can easily lead to bus timeout and thus system hang.
> 
> Set all AXI clock gates to CLK_IS_CRITICAL. All these clock gates are
> ungated by default on system reset.
> 
> In addition, convert all current CLK_IGNORE_UNUSED usage to
> CLK_IS_CRITICAL to prevent unwanted clock gating.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> No changes in v2 except for rebasing error fixes (which I sent as FIXED
> patches in v1).
> 
>  drivers/clk/thead/clk-th1520-ap.c | 44 +++++++++++++++----------------
>  1 file changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Drew Fustini <fustini@kernel.org>

