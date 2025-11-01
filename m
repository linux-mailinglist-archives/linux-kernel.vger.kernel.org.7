Return-Path: <linux-kernel+bounces-881271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA293C27E0B
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C40918991D3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71F02C3260;
	Sat,  1 Nov 2025 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiF+yqzF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111EB2F39D0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000203; cv=none; b=A/MvYjGU4+XIWJ3SD5+7OtKo7N2EWXAbJjSTdH+VQM2Uy/9z7DDGFmkogAeKBFFFR7hjl6ckMrhiw3dIPHI3xU6lEN3kIE6e6CCzvDvtQjU0rXnpIKMYKpqBlX9PsgQ2L8eMjO7Gs30Igd5ff0DX70ub/NDCX+kepp3J+GPg0N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000203; c=relaxed/simple;
	bh=V3oxF2yLy+rayXHj/xV7YvsnlyQSDR3R4rl2pS9Ha4Q=;
	h=Message-ID:From:To:Cc:Subject:Date; b=K1fBTNd8IsxC6yj5ryxrM2sQuMGsDfw7rZbQysCFe0a87oKnBBW6W9Hc6b7jezyTsOPcnB9hlDTcmk/YHklwrYPpNiVUAC+MPWB+PvWIZ5VOVTwnMkLjCfbUnhTr7ZdHntClVksdEzCrU4oXtUOU7E57NhkYV1l+dEG16BXTBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiF+yqzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD50C4CEF1;
	Sat,  1 Nov 2025 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762000201;
	bh=V3oxF2yLy+rayXHj/xV7YvsnlyQSDR3R4rl2pS9Ha4Q=;
	h=From:To:Cc:Subject:Date:From;
	b=eiF+yqzFGwPAzVE5VDCUDZCGd79TjNhN1n+XMIGDICPaWw6jI5ImTAAdiaN5G1bQg
	 3DRax73hUFmY+EI6ipjrYw/jEhyVIfPPLLjz8SGv/F4Dh0TYrtMUoXKrrOApy0IZC7
	 RJcKH5nAeZ/0vPOr5Rvpa50RHMU8lPEeYD10eur5TRhgeql2TgMxdUuUYTcLefYl7R
	 5Ltd33P9dbQZenHSnxNxkNfwui/Myuf6TzrYdFfio3oyaIxJxXS1ca2Xh4S++4/AhB
	 2q6LU3gLJhlQJN+FQPsYQfUHGjFz5aV7DJ1yTgqxAK8LBxxjVxTXGioIJdATwQeq8Z
	 RDJSYzrTJaizg==
Message-ID: <3a91deb5123e4918a27d974dc0085011@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.18-rc3
Date: Sat, 01 Nov 2025 12:29:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.18-rc3

for you to fetch changes up to 47a0925ee4bd2689f0aef4dbd67dd46442fe1ca2:

  regulator: bd718x7: Fix voltages scaled by resistor divider (2025-10-30 11:30:23 +0000)

----------------------------------------------------------------
regulator: Fix for v6.18

A simple fix for a missed part of an API conversion on the bd718x7 driver.

----------------------------------------------------------------
Maud Spierings (1):
      regulator: bd718x7: Fix voltages scaled by resistor divider

 drivers/regulator/bd718x7-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

