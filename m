Return-Path: <linux-kernel+bounces-815374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1A9B56378
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288957A4427
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5A62BD012;
	Sat, 13 Sep 2025 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyuZs716"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6D29D29E;
	Sat, 13 Sep 2025 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757800824; cv=none; b=Fyed4gUpWJlGXeEIowLS+O0AYmR2bibS68rlUmGCSz7OrpA4DPujMFcpPBuITZGHnR5YCwYwjdFtScGyeHJs3GuXJxx8aNl3cmzjy9SqHKJVoThE1zV90W0rfeI0QgHAkRrHTOByxmKu8/7dETUcPcqmAEIYq0rz/fZMa5D4NH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757800824; c=relaxed/simple;
	bh=zZ1OUc3zM/Cg73rU6Gn5fHp1VQlbaJwqo8Lcfm2ews4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=aJw6gkqlRL88GtwZPz1U1+9hfrTdv4EuZRJIn888jW5cScY9JLS0EOXdHfC3rw493cQxNs2C4PuYEkuLeJHu8owacVYoldcwrjcsZYxHKUhX2IAONjM6bnbDqlHSZbuHLJZJaBJDryoU/fHzosd8i2SsAorjufqohE2sek+WJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyuZs716; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E69C4CEEB;
	Sat, 13 Sep 2025 22:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757800822;
	bh=zZ1OUc3zM/Cg73rU6Gn5fHp1VQlbaJwqo8Lcfm2ews4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fyuZs716eTJ7WPS2GiS4TdLlvTBU5QH2yzss1KHabropYqAQ3mFpYndd3B7HsP1K8
	 DUHqzSxnUcS6JF7Q2E8xc4tUTV2tPVPVaMgpSxGV5fWl+0ZQuV5+jYVTYKs8pnyI0K
	 5WF2hDgQ0mnCS6OFHAqJnb0RUFiQmAnA+5j1mtzz5joiP0/HPeLFyeO5NbL5kZZsw7
	 elz9WmuogeE/UTKHpTHOk/WQz2o9X7hNvFi0LZpshjLdzpfwr6tVeNVFLICYdDZSnf
	 VBuiipeKzSFzh0wHNk/WlDvwvbiPb/tC9CAEKJDufyKhWKTWOwpAD9jUg+0cBii9RY
	 vR4ZI9RlvvJag==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aLyHtxrU4mGFfnFs@x1>
References: <aLyHtxrU4mGFfnFs@x1>
Subject: Re: [GIT PULL] clk: thead: Updates for v6.18
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal Wilczynski <m.wilczynski@samsung.com>, Yao Zi <ziyao@disroot.org>, Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>
Date: Sat, 13 Sep 2025 15:00:21 -0700
Message-ID: <175780082175.4354.18337386109597093831@lazor>
User-Agent: alot/0.11

Quoting Drew Fustini (2025-09-06 12:12:55)
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d5=
85:
>=20
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git tags/th=
ead-clk-for-v6.18
>=20
> for you to fetch changes up to c567bc5fc68c4388c00e11fc65fd14fe86b52070:
>=20
>   clk: thead: th1520-ap: set all AXI clocks to CLK_IS_CRITICAL (2025-08-1=
8 14:58:23 -0700)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into to clk-next

