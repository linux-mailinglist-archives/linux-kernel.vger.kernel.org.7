Return-Path: <linux-kernel+bounces-815177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047A0B560C0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 14:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA15565A55
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B282EC573;
	Sat, 13 Sep 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoGxmExG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194F2EC085
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766331; cv=none; b=CBW229tF+30D86UAli6izDcuYzjqgukSsHSf8H5+NH5ct4M6Tlh+YAV06FpywLFJMvKR148UGl4PvB8K41G1hYWh7SVHSYrwsZIZW9fb424p8cjSppyo0/7XPQ/fA9Om99V2Xm/z/1iySaF1AxK/7j2CFgJg51/24PlH+1RWSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766331; c=relaxed/simple;
	bh=6Udm7LDKiV5E/jbo0KJPnlyot4x0PgDq03jR/IZ6S+g=;
	h=Message-ID:From:To:Cc:Subject:Date; b=kryZhLwFuhszM5Mep0k3llc8hpvhg23Nlobu1HtgJ05g+DjPxYLUy7WDWXP/rZJgYCV3ASY37B0uA/9hDXiRSq+njPaOMyb3X/UpcJDj3v8R/r3VeAqYffBhFDAdTIjmNMMWxSoEJjaD9B50lqE/wjiox2kKACHyOOReIbswdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoGxmExG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012FFC4CEEB;
	Sat, 13 Sep 2025 12:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757766331;
	bh=6Udm7LDKiV5E/jbo0KJPnlyot4x0PgDq03jR/IZ6S+g=;
	h=From:To:Cc:Subject:Date:From;
	b=uoGxmExGElhvaxGKFL4PJJscXENHoemAGAseg3mnEGTj9qxzlf3XNUNvB9hLJY3qN
	 a80lXvMy3u9U/kpZGgnuoqrT1wSoz9NJlL2TtXiQwTpgA2br9PzTvhVukryBmdNYhg
	 ukH1xgPFE640PhtITMc0se44Ma877pMB1Y7/b7X7TfaWc7sPuHhtAccK1F4A+5fVSW
	 p7Y4KElY5h2FDsGD36pfxFhR52yXm1eWeLfVL3nnhOR5yYQcwPYdIKrAJsHTNKCfG3
	 BkWarjPSseXchgB20QwNkcHScEqQsHPzc7ZPDv1oqzTY7ZWCxpDiJeNYsAG0rJy3Yp
	 rPKHO7oGS84JA==
Message-ID: <9b157e1eae10b302d050b76d9483f548@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.17-rc5
Date: Sat, 13 Sep 2025 13:25:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.17-rc5

for you to fetch changes up to c05d0b32eebadc8be6e53196e99c64cf2bed1d99:

  regulator: sy7636a: fix lifecycle of power good gpio (2025-09-08 16:33:24 +0100)

----------------------------------------------------------------
regulator: Fix for v6.17

One fix for sy7636a which got confused about which device to use to
manage the lifecycle of the power good GPIO because it's looked up from
the parent device due to the way DT bindings work.

----------------------------------------------------------------
Andreas Kemnade (1):
      regulator: sy7636a: fix lifecycle of power good gpio

 drivers/regulator/sy7636a-regulator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

