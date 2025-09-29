Return-Path: <linux-kernel+bounces-836711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FD3BAA683
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCC31C3490
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9059B2405EB;
	Mon, 29 Sep 2025 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVQkZ6y7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5C523A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172880; cv=none; b=HMOahxBhbA+ZluxyMpKCm8+x49pE0mZiBMm+YU7HDgNFtXPflsVUl8m0EkxA44F5ab3+XfAdRBnpdBP2BNMfYUaS5xuomr2fIAeNiaKMQdajcimik95eYHJe0m1eBtGt9zfmN1qhaqwW19wfX6ra3j9qRaFJXMFnL8QCPDUeaM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172880; c=relaxed/simple;
	bh=HKhSr07W/eBJ70+p1aNdDfQ3FMo9W4Y6SCkBGlnkwcY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tkQujDcveKInfaioh2vbFA7xl/tenvpXQTbVfu7o5INviAcMGYF+szZHiIJkQWz3ayRqkxUAz+9mMLqTlEQf/7zaDpe6/P/pm0ajicNrDSPlCJ/RuSMsnuvDXTL0+KKJCUv98zxWCnxh4cXgIWtBm8/DPDF9CFR9uHqANHdPLCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVQkZ6y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5CBC4CEF4;
	Mon, 29 Sep 2025 19:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759172879;
	bh=HKhSr07W/eBJ70+p1aNdDfQ3FMo9W4Y6SCkBGlnkwcY=;
	h=Date:From:To:Cc:Subject:From;
	b=pVQkZ6y7ShAkqGfT3m3e8MjM6EPT7PeyGkkul0KdSx6FXpLqJAWTdf56Be98GT4++
	 VpsunfUnPAVJ05GsbPFtbTawZmW4aWvP+vSrW81OsPGexFOmoVjPinGhy3l7jfHk27
	 4dgNTAK82drt955RjnWzkL2JU65phGnGXL8TMqI6mE+VaDtYAR/KNBeM+wGJIjRpp8
	 FD5HiBKuZwiP7SqLURSkCZd2Mk5DTJeWfeMAepM8hy8Uc858c5coGEAH3pLLImPHsd
	 gFqidI3YRP7jHrAstNQD5LNRnmP0y9Esqj4AmZTAp+NX16g9ljOFTjltZVv5FmJRd5
	 twFD2AzPIWdjA==
Date: Mon, 29 Sep 2025 12:07:59 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Ali Polatel <alip@chesswob.org>,
	Johannes Nixdorf <johannes@nixdorf.dev>,
	Kees Cook <kees@kernel.org>
Subject: [GIT PULL] seccomp updates for v6.18-rc1
Message-ID: <202509291207.66FBEC8497@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this seccomp update for v6.18-rc1.

Thanks!

-Kees

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.18-rc1

for you to fetch changes up to b0c9bfbab925ac6385d4d06a134fd89cadf771fe:

  selftests/seccomp: Add a test for the WAIT_KILLABLE_RECV fast reply race (2025-07-29 13:33:02 -0700)

----------------------------------------------------------------
seccomp updates for v6.18-rc1

- Fix race with WAIT_KILLABLE_RECV (Johannes Nixdorf)

----------------------------------------------------------------
Johannes Nixdorf (2):
      seccomp: Fix a race with WAIT_KILLABLE_RECV if the tracer replies too fast
      selftests/seccomp: Add a test for the WAIT_KILLABLE_RECV fast reply race

 kernel/seccomp.c                              |  12 +--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 131 ++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 7 deletions(-)

-- 
Kees Cook

