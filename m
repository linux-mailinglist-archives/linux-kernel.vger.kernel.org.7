Return-Path: <linux-kernel+bounces-744994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77F0B11391
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603E23A9AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635CA235C1E;
	Thu, 24 Jul 2025 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksI732Z4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F8230BCC;
	Thu, 24 Jul 2025 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394820; cv=none; b=NxapVaGFer6Lh6DDFPn3BW8894qM8yjE2p7Zn7ONlI1ex/p5X9icLjaP70gjW8joEFNVTHCDBkIfrXPREceayXSDkBOcy153mWqUWeKJpN83yawksyBsWutjK8nJBb2X3onKofdx1HP9IU3VcR6uVx5r3nnIQ4baP4mcS5q9NMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394820; c=relaxed/simple;
	bh=H4bI8MigaMkypNpkii9+xYRtzoc4ShGUP1lY8l1HJE4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ZkOKQ3QI5LgJ8jNXobpSF1lbQ5eG9idYOo6Mic7+fHr72jpcj3MUyvF8gg6WEL3qqqkhzc4fgwVNHURRDpaCSbYKVz4TzwPZXnGhENYkb3wQqfqTp5U+sumHUF/s4U1k11aPtTiq4PgzQbigy/sTS64b/PUCtkyhPWcv5i6NXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksI732Z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEF4C4CEED;
	Thu, 24 Jul 2025 22:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753394820;
	bh=H4bI8MigaMkypNpkii9+xYRtzoc4ShGUP1lY8l1HJE4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ksI732Z46/mkBky8OU6QC/3H2CN751lTILAbTuLw6NiZGamBTd1OUolE0tXAR4/6C
	 fw059+tkbgkFjNHv5H7qVTdtJSD2udS2vVY5LeJr75oeUtESTg82jCFe/KLzIACpnR
	 w56OsBpfZs41hMG4VbdTc1SIPCjVmsnmLgYJTcZmGBKyHsF05KaZWELHF43jOeYfuw
	 ezlp3wsvZ7x/ceRFeX5ZLyDWGPF9wQuwfLhjMnMnZfTe/GmHkyi8YpSETZVXnnq2nl
	 McadAsd+WCHeHnE6RkNIzDYll06qorlWxiklF7dOnNZpHMGXFNPAhYz6QlmTF1J+mw
	 U1ajbwJndOmoQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aIKcFzsCvvz0PCBW@x1>
References: <aIKcFzsCvvz0PCBW@x1>
Subject: Re: [GIT PULL] clk: thead: Updates for v6.17, part 2
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>
Date: Thu, 24 Jul 2025 15:06:58 -0700
Message-ID: <175339481888.3513.6668397032978631593@lazor>
User-Agent: alot/0.11

Quoting Drew Fustini (2025-07-24 13:48:23)
> Hi Stephen,
>=20
> I'm sending this followup PR in case there is still time to include it
> for your 6.17 PR. Yao Zi refactored mux clk registration which fixes an
> orphan mux clk issue which would occur when booting with mainline uboot.
>=20
> Thanks,
> Drew
>=20
> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd13544=
94:
>=20
>   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git tags/th=
ead-clk-for-v6.17-p2
>=20
> for you to fetch changes up to 54edba916e2913b0893b0f6404b73155d48374ea:
>=20
>   clk: thead: th1520-ap: Describe mux clocks with clk_mux (2025-07-22 15:=
40:54 -0700)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into to clk-next

