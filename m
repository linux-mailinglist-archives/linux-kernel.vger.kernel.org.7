Return-Path: <linux-kernel+bounces-836237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A278ABA913F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32F11C0E90
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C55C3016F1;
	Mon, 29 Sep 2025 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ594zXX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780FE19D880
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146144; cv=none; b=hNiJeqaE5BGcVo23unF9/+sRdWLb2BgolrkZAT8dB9E93W+rqWQtosNxPVDLG9XWqcQTgHRIeNCmIqwKXwls1Md9MlMyjyisHr+VJsnM8ToqMdneeqF6JFRNtmCZb0A88GQPVy5HJV5bjc8qkEVMugtzR+uL2wI5YeoXbYL3OKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146144; c=relaxed/simple;
	bh=oE/DGSsBEipnpbQRc2ODPuk2yx1uBnrwc4SXO/5mGRI=;
	h=Message-ID:From:To:Cc:Subject:Date; b=egDpmdZl/j8VWV/fRhyGrz8yeXDPHP4qOFhM/R2svXx/EXXXjr+P7T3rurdZpXHQuq9wU8zWD6TpEXOTcDdoT+ef+2ayWL2stwoXLGdZGWJ7iqXnxaqwTDMBzTLMppKGCYPVfLkImhU9KpfLC5kn1eHh0cktTX0TTYXpdFjC+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ594zXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984A9C4CEF4;
	Mon, 29 Sep 2025 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759146144;
	bh=oE/DGSsBEipnpbQRc2ODPuk2yx1uBnrwc4SXO/5mGRI=;
	h=From:To:Cc:Subject:Date:From;
	b=cQ594zXXcfARJGFDbif+Gud0iR0WfJMkn3jSLEBYpOk4txWmK0Kc/iJHcFHYxED/u
	 kOxgLYNYqIw2nFLnxYhnUKUZgGlTKJSoOUdYQMmEima7nd4yzB7hpqBNtEEcjIVz0M
	 Jo+xcN8VtXDoHzePos5znTV64BIb/84zLqog5OqsCc0CzuV+nyk18/IzCWUimqgqjU
	 KQbzqeFNS90LE8nYL3MVDiGXowvuUTp9omFqDWqn7NeFu4Q7CBVFx2QdfrCJc0g44w
	 +8CSUT/s4PLL6SUwJUPNzPdKN10nTabGVnsUHmPFHD7EMhWCLzjBZRmMerY1stnyyh
	 Mc7hHzo2HbURg==
Message-ID: <0a19a5748ad44f494b94d78a3e35371d@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.18
Date: Mon, 29 Sep 2025 12:42:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.18

for you to fetch changes up to f4672dc6e9c07643c8c755856ba8e9eb9ca95d0c:

  regmap: use int type to store negative error codes (2025-08-28 17:18:40 +0200)

----------------------------------------------------------------
regmap: Updates for v6.18

This just contains a few small fixes, there's been no substantial
development on regmap this release cycle.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      regmap: Remove superfluous check for !config in __regmap_init()

Luis Henriques (1):
      regmap: mmio: Add missing MODULE_DESCRIPTION()

Qianfeng Rong (1):
      regmap: use int type to store negative error codes

 drivers/base/regmap/regmap-mmio.c |  1 +
 drivers/base/regmap/regmap.c      | 13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

