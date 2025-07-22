Return-Path: <linux-kernel+bounces-740020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5983B0CEB7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FF56C2798
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2A335977;
	Tue, 22 Jul 2025 00:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEv/04ix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44BFF4FA;
	Tue, 22 Jul 2025 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144127; cv=none; b=IRgEuVvo+T6CjuwIIgYGbJvlDBVbtLmcwV0ADuWYfWieo+VfPEyxlir4LtAtF1DLokDmOtswPoGysd1Zl5jJnR/GnHtj2Y4MjrQSgGAQIbupI641TwX38o1mbGV+sjApiy+wHk9knti6fXHscYuAyOFhACuYJLyYL4er2pVuv9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144127; c=relaxed/simple;
	bh=lkj2iz50e05gBdLMWwNIikXAisnhw8Y2ADazq8uUrJk=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=h/0r61C1Ejn4wJse9UyRGTixJl6lUp/MWebaoBottGhC1IFRZUGSD1Vadz0RZVFqcO7r79boE+3w5JywhjMyujsPlHuv7jse/JlAZH5IV559Wr8HdvGogaDcBV4aEZH6cOyPdMNmTPwxFyoRW62rBispT2dYD4JdqN23t9SivBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEv/04ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD274C4CEF5;
	Tue, 22 Jul 2025 00:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753144127;
	bh=lkj2iz50e05gBdLMWwNIikXAisnhw8Y2ADazq8uUrJk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kEv/04ix+WN83EBGQ2ITPE7dRRqyn2TYr0hPFBeC1uwEEbUPIioGTnHk+ZPypCgTR
	 ndhYPeDwg1XyOtwSM85mEoXm63qiQNSQrTwlukrFvF7uD2IPucXTSb8eocJOBHw04r
	 s2QbWCygpfMvGuhOZN5t5jwSO1ZQ4mQc4e8Da6cwktHK6AP91guOOthb8fZnBLV4Wv
	 QDmANOZpvpwipchlDrekCi62O1zIPzNcmMFzrh8znGhbcKBHCzakM/pyBM1oHuQAmw
	 t0mRBLhqF5RjOa3FiQIE5HjgDv3fi98lrmfFkTdECD3GjDwFxvZxrvXuVUiOq2FjhK
	 9FKAX0T72D4NQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aHt0ojYyO1OEZTmG@x1>
References: <aHt0ojYyO1OEZTmG@x1>
Subject: Re: [GIT PULL] clk: thead: Updates for v6.17
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal Wilczynski <m.wilczynski@samsung.com>, Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>
Date: Mon, 21 Jul 2025 17:28:38 -0700
Message-ID: <175314411891.3513.15061789735684884470@lazor>
User-Agent: alot/0.11

Quoting Drew Fustini (2025-07-19 03:34:10)
> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd13544=
94:
>=20
>   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git tags/th=
ead-clk-for-v6.17
>=20
> for you to fetch changes up to d274c77ffa202b70ad01d579f33b73b4de123375:
>=20
>   clk: thead: th1520-ap: Correctly refer the parent of osc_12m (2025-07-1=
3 12:46:58 -0700)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into to clk-next

