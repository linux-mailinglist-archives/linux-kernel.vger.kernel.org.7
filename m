Return-Path: <linux-kernel+bounces-826350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434E7B8E472
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63C117AFC6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B242797AF;
	Sun, 21 Sep 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnGkAfrM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDEA2749EA;
	Sun, 21 Sep 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758484251; cv=none; b=TSfYUCGgnWGpfjzO9X873jzs3J+P4ASZMnZ3Hxr0uDUgPr7CVqIBC8yUqf7n0eQmPEq2HqkZEe0gsoZVJGaSiLds/YCl/9Tmo3zBx6If0X1L10YbJ19Ik6oTG2UZfytSezPtOpCBeudh+vOBtmm2qd/RrPe20+fvA5F0AnTW/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758484251; c=relaxed/simple;
	bh=aqq5HlQvSsqrgTnwy8Gp4tETT69T7rVvT3a5LseiebE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=vEOZv7M9XsCi/kwX1bQAsyrYCabsEkd3LF0yVdFHJvCoHju5A6BEAuRDgkm6fknmwgHG51o0MbVOVx3wF6Xq2eORFLWh1PnrUeaPfSnTbCoHdJgnrWXTAUBjfgb+UbYRMppdWScLgcGr+9kXg/DTOJadHsk0YH86yLm+D7IdmWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnGkAfrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E37AC116B1;
	Sun, 21 Sep 2025 19:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758484250;
	bh=aqq5HlQvSsqrgTnwy8Gp4tETT69T7rVvT3a5LseiebE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tnGkAfrMs7PgdDp2pq/rEz6pz1pCNcbojNU423Ozl/c/3pQu+/Fqkkc20MGu2Bnon
	 WeajK58aDah8L+ucGzef5bH17CEag1pXVB118EOki06246LVF0/cpcVL35gIMmM0yq
	 J4K7xa8FTWfLgF58E5OLbdyb6xo9VERKXnctmXEF0SLecmoQrsVS1ZdwMHr6O8J9sx
	 WxvUdSf1ylXcLqj46+0LIVvsxuSm+4fpyR+jIGGZbEniry33xTxMqjYsCQ0oSP8JNx
	 PQ6EcOa8aInzVqeb7T4r9uBZkEE8WUplbZPzRa8mLQV1gC4vBbE9sRBHuoEo2dudIr
	 hy9+TqbGe7fNg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250919142649.58859-5-ziyao@disroot.org>
References: <20250919142649.58859-1-ziyao@disroot.org> <20250919142649.58859-5-ziyao@disroot.org>
Subject: Re: [PATCH v4 4/8] clk: loongson2: Allow zero divisors for dividers
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, Yao Zi <ziyao@disroot.org>
To: Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Yao Zi <ziyao@disroot.org>, Yinbo Zhu <zhuyinbo@loongson.cn>
Date: Sun, 21 Sep 2025 12:50:48 -0700
Message-ID: <175848424894.4354.833438103816183382@lazor>
User-Agent: alot/0.11

Quoting Yao Zi (2025-09-19 07:26:45)
> LS2K0300 and LS2K0500 ship divider clocks which allows zero divisors,
> in which case the divider acts the same as one is specified.
>=20
> Let's pass CLK_DIVIDER_ALLOW_ZERO when registering divider clocks to
> prepare for future introduction of these clocks.
>=20
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---

Applied to clk-next

