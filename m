Return-Path: <linux-kernel+bounces-826371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C9FB8E582
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585F917A3BE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5582951A7;
	Sun, 21 Sep 2025 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6j3ObP6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BBA2765FB;
	Sun, 21 Sep 2025 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758487110; cv=none; b=TYi8lyLDFYfsy9rJ6pKPnxkCjfz5ygVq1IlMthAezpZfNJyW7dZhqq6kl+h9ANBT+44N4lr7ucge+kfRsLH7U7AhtXXMFwHHE8tWDCTuZ8r1c8WruRSkTPpBKJGnkoUCp3rQQQrnQ8/PWsnqunwxLHy38q1mlycjY6ADy6dmHbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758487110; c=relaxed/simple;
	bh=664LabPHOiNvimtsi/IFnBJfHn2xokuoEExuJfQJL7I=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ZNXfxw8NagbwdGyt74VV/dgm1/jmlUIIFLeNOymhNCr+x4ATEHX2QQc7BSLJRlYqyDO0r/f9kXGOYHJ4dWANQSvYPmg/bb3Gb4y6k68H5Hw1H3B0WPbNDC9mmgJxp/0TkmJDwic2wuUCGSBMW3Dy2NzxQBcGTBNpRO6ljpM2xkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6j3ObP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59247C4CEE7;
	Sun, 21 Sep 2025 20:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758487109;
	bh=664LabPHOiNvimtsi/IFnBJfHn2xokuoEExuJfQJL7I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=q6j3ObP6TW154twM40m9wHw5PjCCgK6yRKrCXOqEW6g6oLVAGrf54tkDoaBPw4pyd
	 63B7o2KrcCh+sRjLxBjxt9uYu4WKeGsthUk44e0TR2uE1MPyaabhF+Hj4TAQEQgp9W
	 S/vRV9j4OgzrzAFX8E0cAw/rcQ1ERnA9UNRrp4iqoYCt1vaZkzDjE3MwciKBkEyS6p
	 y2WuFXzqxWFY/4k4IzDchRidSJoYNzSSbHBVH9JFXHQzvTrzLL75p6Kn32fKSAmIHp
	 /Fg0Ezyz4Zr8W+6Pgz7zbhSsrMGkMlkIjrcF8BkVQzYNtpkrFp+ttCEdtILZyqtHCQ
	 6gsJXiDfA41Vg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <175848567705.4354.18321442549280624891@lazor>
References: <20250917020539.3690324-1-ryan_chen@aspeedtech.com> <20250917020539.3690324-4-ryan_chen@aspeedtech.com> <175848567705.4354.18321442549280624891@lazor>
Subject: Re: [PATCH v14 3/3] clk: aspeed: add AST2700 clock driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mo Elbadry <elbadrym@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>, devicetree@vger.kernel.org, dkodihalli@nvidia.com, leohu@nvidia.com, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>, spuranik@nvidia.com, wthai@nvidia.com
Date: Sun, 21 Sep 2025 13:38:27 -0700
Message-ID: <175848710791.4354.5032800251620826265@lazor>
User-Agent: alot/0.11

Quoting Stephen Boyd (2025-09-21 13:14:37)
> Quoting Ryan Chen (2025-09-16 19:05:39)
> > Add AST2700 clock controller driver and also use axiliary
> > device framework register the reset controller driver.
> > Due to clock and reset using the same register region.
> >=20
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > Reviewed-by: Brian Masney <bmasney@redhat.com>
> > ---
>=20
> Applied to clk-next

Unapplied. Found some problems.

