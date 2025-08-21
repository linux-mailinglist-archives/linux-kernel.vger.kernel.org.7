Return-Path: <linux-kernel+bounces-780500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84339B302C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6B95E6A04
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A8134AAE1;
	Thu, 21 Aug 2025 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfXC6fjE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28361341672
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804081; cv=none; b=DQcXRMGgmSnq1w4Srlr/Zbf4sj+wZn+uCtdK1A16P1+fIyYfBlW+fSBZ774UbtN6ezBJhNbufoQm/H+Gh2Zg1YehYWZvu25Xib3T+f4o27g90qbl/MQkqUOgSUdN8AxaGH0C4jNS/XF1d1JOnjU37NKdn3j7m6Wla8cfdGPMM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804081; c=relaxed/simple;
	bh=tTMLN1hLL7mzTvUXYmqK/xzvHH7ZwyHy0lG3dgPosTw=;
	h=Message-ID:From:To:Cc:Subject:Date; b=vEPmmR1cFrcoZr2Mnf3RU3ovkaW5h/t0b51gsvg6mIdcsasREXDtb+XrBh7CWfbGFjRY7LfnlckoaIAhw8hmS/OKto7bW/sXfyZsFFufKsv55We8keexmq4HMEF7/hXq2tWmvO2xiDI4QEt6w2iohchvGBOHUuXe9P1U46128TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfXC6fjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0E5C4CEEB;
	Thu, 21 Aug 2025 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755804079;
	bh=tTMLN1hLL7mzTvUXYmqK/xzvHH7ZwyHy0lG3dgPosTw=;
	h=From:To:Cc:Subject:Date:From;
	b=LfXC6fjEWqZzJdQUzHVkCRabahb2SJOez+NIOlg0Xto1bOPhMdV4Wsu6bdWAfeFq5
	 WdQOMv+XDPB7bXBT3fii1LXVQXZAmmLEnUAM/DXqDtqbLyQJEphdSnOfPTvIkZsWFh
	 KQPKFWL+gRHyVNXlzGcSpiBPz1oHP4bN8TW2nAp8dvYT/ogELyVlTcmDSiU90TiPTe
	 xJT2TBEwoTOYCirWvrDYDrITFYuo0pu/PRi3hX6wXSb+W5+WI7a8RfL/BEkMW7Epco
	 M5DcPfsCYyfsQ3EDptKltq1/WIpkWKArfaU3jJND21IKY11uS74fl6TUHx8uVG3M8e
	 npzT2IDPcYrRg==
Message-ID: <a9cdd0f4b5e54e9caecde69764cc7ecc.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.17-rc2
Date: Thu, 21 Aug 2025 20:20:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.17-rc2

for you to fetch changes up to 11cd7a5c21db020b8001aedcae27bd3fa9e1e901:

  regulator: tps65219: regulator: tps65219: Fix error codes in probe() (2025-08-19 16:51:03 +0100)

----------------------------------------------------------------
regulator: Fixes for v6.17

A couple of fairly minor device specific fixes that came in over the
past week or so, plus the addition of an actual maintainer for the
IR38060.

----------------------------------------------------------------
Dan Carpenter (1):
      regulator: tps65219: regulator: tps65219: Fix error codes in probe()

Krzysztof Kozlowski (1):
      regulator: dt-bindings: infineon,ir38060: Add Guenter as maintainer from IBM

Peng Fan (1):
      regulator: pca9450: Use devm_register_sys_off_handler

 .../devicetree/bindings/regulator/infineon,ir38060.yaml     |  2 +-
 drivers/regulator/pca9450-regulator.c                       | 13 +++++--------
 drivers/regulator/tps65219-regulator.c                      | 12 ++++++------
 3 files changed, 12 insertions(+), 15 deletions(-)

