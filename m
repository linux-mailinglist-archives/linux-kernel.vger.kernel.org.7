Return-Path: <linux-kernel+bounces-747937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AA8B13A71
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B95169AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4076F264630;
	Mon, 28 Jul 2025 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiRdXW0Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CFF264624
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753705461; cv=none; b=l14GCki/E4DXdbWFD63Vfw4yfeRdcedLfupec2A3VnxoZg4C9c9fZbjc5l9fyCx1Dm9ipk5mKEQ7vQIE8LZGUbfLSxsu2xgned9ZexEtxgCxa3PScmAwzfn4z69poDaERsQlYeTev2BvBXoPkw6/RnMgdyFth/+5blrYgh/CIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753705461; c=relaxed/simple;
	bh=AYB54m6MBATkkfTm1k091mB5yAnO5n+iYo9TPzLZjP4=;
	h=Message-ID:From:To:Cc:Subject:Date; b=SaxzB+l/aLXJ/IfevLde11VV9u0oBBQxV9Ep6bgWGkUxxxp5PDzRwkOpBTFTrGhHCcmhMFkLcRP5HxxiJcnsHKkPtgczy0HDnk61tPgiJBO6tcCezC97LxEZLGULCEr5QKtqY/lABkIRdco7sQtS/OVHRzcfjm9MDU4vT/MBrbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiRdXW0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA864C4CEE7;
	Mon, 28 Jul 2025 12:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753705461;
	bh=AYB54m6MBATkkfTm1k091mB5yAnO5n+iYo9TPzLZjP4=;
	h=From:To:Cc:Subject:Date:From;
	b=DiRdXW0Yh1gmNM2ImGGHGEEgVghhJeb/YQM3wjR4hfvSovbW/cd348kmju55cwfNY
	 +m1zYHRshzS4W8bgesRNiTH/Bi0fcwSNtsICFBs3I9Fp5NHqKd6ecTkO9AodgqGjPv
	 NeUeSC/haFPw1+E5GcLDZjNiPI1yLO8LkzXbSM8xvvvAq36uo3VmJ2FxMi5K5UGENb
	 Ro7SzZzUFoh+OlzMkRy0SlwnFGlGdUVFu2eRGHO061/wYQkZsXabuLC3/fh2Z667wD
	 CyGZWixThYeKMO1XgltqWLG8eRh8WFa7GdsEu0Gtw8jN5cHXEu3wb8D1kzNDviyh2A
	 I9nD+jxSRh7Cw==
Message-ID: <322b34fec942b961f17af6f02cb6b6a6.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.17
Date: Mon, 28 Jul 2025 13:24:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.17

for you to fetch changes up to ffc72771ff6ec9f5b431a86c4b00d8ef0fea958b:

  regmap: Annotate that MMIO implies fast IO (2025-07-25 13:44:33 +0100)

----------------------------------------------------------------
regmap: Updates for v6.17

A very quiet release for regmap this time, just two cleanup patches and
one almost cleanup patch which saves individual MMIO regmaps flagging
themselves as having fast I/O.

----------------------------------------------------------------
Al Viro (1):
      regmap: get rid of redundant debugfs_file_{get,put}()

Krzysztof Kozlowski (1):
      regmap: kunit: Constify regmap_range_cfg array

Wolfram Sang (1):
      regmap: Annotate that MMIO implies fast IO

 drivers/base/regmap/regmap-debugfs.c | 10 ----------
 drivers/base/regmap/regmap-kunit.c   |  2 +-
 include/linux/regmap.h               |  8 ++++----
 3 files changed, 5 insertions(+), 15 deletions(-)

