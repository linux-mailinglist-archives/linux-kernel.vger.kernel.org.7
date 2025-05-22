Return-Path: <linux-kernel+bounces-659935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13791AC16FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 00:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62DFB1C02C03
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 22:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10210299946;
	Thu, 22 May 2025 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9SBvD25"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8C1E5202;
	Thu, 22 May 2025 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954062; cv=none; b=P0NSCqYroxvuflOdv/op8fNjw3y0YldeBzzdFvUinuTrIL8q4yNqtdlNZYZhr1STBRoSJqdHNCcvHsqWIOlMv1gAbo3QJLRHpLinkaQQysG4hO3EdRowWjKZyFbtM/dcu3DizvfABEbYJHbqpSw9VmlBO6OWmPyvoMWIrn7HWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954062; c=relaxed/simple;
	bh=Kqb87YqrH7GgbRIjtu3CSrvC/nfpw9kj2G/CS9u5zDI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=mBCeRVsAvSRC/jRlZPffsiUwwsoJ1GKf1EF/PA90f+hvTzFP5IZOlYYebsLJZvknTwv5ARgUc5kCualkk7LMUwF5lnpIHveM1rdmh/AZmnrJMq892zhq728DYOo4T1OrCgtJUgfzsBznjWa/LmCkrkCZMoimFjo2CvQ3Y4aG+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9SBvD25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6CEC4CEE4;
	Thu, 22 May 2025 22:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747954062;
	bh=Kqb87YqrH7GgbRIjtu3CSrvC/nfpw9kj2G/CS9u5zDI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=H9SBvD25Q2PU4UflB41Gd97nlaKsoI8SbBuXLVrsWgQJPn08cEjwwG4+hn50kJ/mF
	 +Z3oRbYBMY03HCGgKutmjHhfiUkuBI/7FY5lGlF6yzUk4kYDCEzMUyQRG2+xGQRh6I
	 ypc76/fUP4HHZcvpaE3jJebn/F+jehfq3+LJdpWrHwTCSN1E+9Iyk07a+qUqA/GIEs
	 9bCbllTUz/giCzT9FLWPNXCMP7WArMCddkmI8VxxxEBrH6Rj95veyfF1C+WK+9XgWL
	 auPisFZjm08OSeq5/vytZDsxymD08ImPmYr3Qkmqh/dhSGlOBCg4UIdrZ8sEXu5aMd
	 WzE6SNvlg7bXQ==
Message-ID: <4932d11de93098b86e3f18e858930388@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250513101407.22233-2-krzysztof.kozlowski@linaro.org>
References: <20250513101407.22233-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL] clk: samsung: drivers for v6.16
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-clk@vger.kernel.org, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette <mturquette@baylibre.com>
Date: Thu, 22 May 2025 15:47:40 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Krzysztof Kozlowski (2025-05-13 03:14:08)
> The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089a=
c8:
>=20
>   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/sam=
sung-clk-6.16
>=20
> for you to fetch changes up to 81214185e7e1fc6dfc8661a574c457accaf9a5a4:
>=20
>   clk: samsung: correct clock summary for hsi1 block (2025-05-12 08:30:06=
 +0200)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next

