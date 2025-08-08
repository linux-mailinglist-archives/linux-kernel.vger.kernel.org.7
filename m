Return-Path: <linux-kernel+bounces-760601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595D2B1ED8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6938F3AD192
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A61275B0A;
	Fri,  8 Aug 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQDucPrn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313321C2437
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754672541; cv=none; b=bdGOpRkNFZBhWTY3fUmOYYTNOfAwttS09G3EBXBFxFCzvDkkyhgqI8dU9ydYMotyYK+CyrOO8h1RffDAm3uV9akVxaVlSEzWlEmpsbwjd8moX35YHllbDHGfMUIGt230tFqMXZ81pPaltQvpdWm2SQFENw5eO5Lkeg8+4z9ByZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754672541; c=relaxed/simple;
	bh=oJzoTxS631acuj8FGtZqJjejRBjVTWQrJNllFyMwELM=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Axe6GEyWKqBje3jG62WXABXQCq5n/vecj2cqHcNwqRtYR5MTsSQGW1I/3rggqfstuu13PQi4ZmuxEEpihkL71GnDO/3onfhSX5N4v+0iFSKZ7MCVobFv2CFSZTpTy6kZU4pNj7j/6NCe48YDsj4q+++kW+6+ZN3TT8X6O2xP7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQDucPrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D865C4CEED;
	Fri,  8 Aug 2025 17:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754672540;
	bh=oJzoTxS631acuj8FGtZqJjejRBjVTWQrJNllFyMwELM=;
	h=From:To:Cc:Subject:Date:From;
	b=jQDucPrnN4KIapzSE0DefKelsiZ3RTxs5kOv49SFNeEmHH6J6dqCNI4YuPLhhZ425
	 Pwzz0zjHBmEHYGJQDRrbEvD28Bj57maz/14vgN5gg/xxXmCFRVkzlG5s9fShvZneMh
	 Te4x4XBRmfxffSAQ4IE9J6tTLGfvlGMUYt3RImJNvlx3IPENYviaeIkfkSxB+VIg0s
	 5OlMePkxxXSTuKjcKvrVMY18D8mwavwYHjYhXCVe+MOhBfXttZxpCLeganVbPeAuiD
	 jaXSxZqcpddE45ki60YMkqESteSTqzgPVzhiPHmyHWMaPOv1MdRsRmVGEnuf9tWsbI
	 pqIP5e4fSt+JQ==
Message-ID: <c52bdf1f3fbc97fe64dbfbb27d34749c.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.17-merge-window
Date: Fri, 08 Aug 2025 18:02:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 0bd042ae771d61ef7ccd5882f7aeca59a25f71d9:

  regulator: mt6370: Fix spelling mistake in mt6370_regualtor_register (2025-07-24 18:04:38 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.17-merge-window

for you to fetch changes up to 10dfd36f078423c51602a9a21ed85e8e6c947a00:

  regulator: core: correct convergence check in regulator_set_voltage() (2025-07-29 14:56:39 +0100)

----------------------------------------------------------------
regulator: Fix for v6.17

This fixes an issue with the newly added code for handling large voltage
changes on regulators which require that individual voltage changes
cover a limited range, the check for convergence was broken.

----------------------------------------------------------------
Romain Gantois (1):
      regulator: core: correct convergence check in regulator_set_voltage()

 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

