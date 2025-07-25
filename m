Return-Path: <linux-kernel+bounces-745201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471D4B11686
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489561CC6197
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D23235044;
	Fri, 25 Jul 2025 02:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qC6IAGoM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9A522DA06;
	Fri, 25 Jul 2025 02:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753410980; cv=none; b=KxwFmK8C+s0hOGDBSzN7QJNJgWbi9qZHoARpOnH1kPrjuTMZFqUGilKjPxNTTERRD9jUY3C0n5qQQ/E1AGHQNmZy0zIz0SYWV/5oZarcPHdxYvJHfTx/cBkuNQ8OrRJmMiKVN0HQA0FnF83wnISyPtk7tiAwYA2TNEVqP74CLvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753410980; c=relaxed/simple;
	bh=PD6yNKlOQ50g3fj8b0UIlHxrb5aRw2tI6N7hOAC57p8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=K8Z0vjETYlLxRN2QbKtVNTVlQDeTyy64b9yHmtHslNIRnjkXpNrcyiIy/pp5rBJBI2hhY2layrbF/+ZoiuOSQEtiksidGIXQP1mlZZKX+dx/FpoOGvRUg09GAKzFZQaKZHlSB4SlyZsrUMY6CMQVwovvaIL949fLqsLkQ25/tyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qC6IAGoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5198C4CEEF;
	Fri, 25 Jul 2025 02:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753410978;
	bh=PD6yNKlOQ50g3fj8b0UIlHxrb5aRw2tI6N7hOAC57p8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=qC6IAGoM+G8TVtULOwiKQ5AsRtfRGXLRrS55E3Yx1n7Neh+BrVVTgodw/mCXSoNhn
	 XbdC/e9jNOCv/sJDEsaHPILKHzsE7BkjKnNG04amtL6pGwbWWE2zPHBRvGKR1E1xmQ
	 p8/sdLJCtCj3zhLTvqAW1oD0lwIWmDQroUDSn1/5NfdyLg7ku13ob6l157bBncDvmK
	 KsVehsHQnqmu50XY6hduGoklsed6kJlkvJ3/GZWiZloX/wfb/f2rAQpOHT3O7K9iI0
	 uynUU+3XXxyUNEVUJ1NX8DnDMrcpfUptNjnsKePBgRsNJ0LKfMWMgz9mEiL3w9hIW5
	 Rue7fw8s3Lthg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aIBzVClNQOBrjIFG@bhairav-test.ee.iitb.ac.in>
References: <aIBzVClNQOBrjIFG@bhairav-test.ee.iitb.ac.in>
Subject: Re: [PATCH v2] clk: spacemit: ccu_pll: fix error return value in recalc_rate callback
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, unicornxdotw@foxmail.com, jszhang@kernel.org, zhangmeng.kevin@linux.spacemit.com, akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
To: akhilesh@ee.iitb.ac.in, alex@ghiti.fr, aou@eecs.berkeley.edu, conor+dt@kernel.org, dlan@gentoo.org, elder@riscstar.com, heylenay@4d2.org, heylenay@outlook.com, inochiama@outlook.com, krzk+dt@kernel.org, mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org
Date: Thu, 24 Jul 2025 19:36:17 -0700
Message-ID: <175341097796.3513.9495899738615799188@lazor>
User-Agent: alot/0.11

Quoting Akhilesh Patil (2025-07-22 22:29:56)
> Return 0 instead of -EINVAL if function ccu_pll_recalc_rate() fails to
> get correct rate entry. Follow .recalc_rate callback documentation
> as mentioned in include/linux/clk-provider.h for error return value.
>=20
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 S=
oC")
> Reviewed-by: Haylen Chu <heylenay@4d2.org>
> Reviewed-by: Alex Elder <elder@riscstar.com>
> ---

Applied to clk-next

