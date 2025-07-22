Return-Path: <linux-kernel+bounces-741246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E42ECB0E1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36ED43B3305
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C2C27AC35;
	Tue, 22 Jul 2025 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzfIGf7F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581AB372;
	Tue, 22 Jul 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201986; cv=none; b=S99d+Ef/cVXerPxXqUEZlwwaXmGv86jXng50yZW7rde7cXdcv73fY0rug9B3Xq7qboLMlIV65FM4EOAeCn8UMKZI3SAgWBQfIA3xkJZ/xoKMp/w8FK0SiYrkOl29wxNkJQeB3urJq4kBEFnjVWegib8O0suhBU1UMq2nJFlzcG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201986; c=relaxed/simple;
	bh=HOrXnADP7UreaaGT5Tj68vMJPVVKA1rs/NitPY59mv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OoeTlXr9O77Ox1MxYDpyvxP9MOq9Y+s5rcI1Tdar7u23deztgxAXQe+G+MUe8RmAS9j5kSDPjsARmUhtUrEY4uJoS1RtmWgUpfWprKyf9ZXtPAx8wg05r67Hk9T9BhcbC8qKNk9dGQ3TaQsEMyKKqZ/YpU2bFpty+HrNgaxJUpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzfIGf7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EF4C4CEEB;
	Tue, 22 Jul 2025 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201986;
	bh=HOrXnADP7UreaaGT5Tj68vMJPVVKA1rs/NitPY59mv8=;
	h=From:To:Cc:Subject:Date:From;
	b=SzfIGf7FM2DDMqURKHa7wAoobKre8lX1YP9pa7QJ18b/2Y5p5q0jtHbdBMrXz70b1
	 oEKItR04r1mR8v0TwXieEJY5MqhEoVLrYQnoZks6AT4DZsshLfk9/HunQlXRGaXtYJ
	 2lBkANT7kP/fBEcg9nblZqhllpNs9I8ilXmWPo/0rOyODzGgpjkdg8ajT339w0r7uV
	 S5DYn0GaMm7eg85m0FEJAOFNWt3RqfyMS4RAU8IIl4u1jYA8wSWK7XKgDij/uHE9XP
	 lXVLJj1UO6n5qY7f+TssU0993Gg3O+YV2gJ6ufG00WgPq/duNq07SH3DaE+TwaPHiA
	 +5uA4qxAICnbQ==
From: Sven Peter <sven@kernel.org>
To: soc@lists.linux.dev
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sven Peter <sven@kernel.org>
Subject: [GIT PULL 1/2] Apple SoC driver changes for v6.17
Date: Tue, 22 Jul 2025 18:32:57 +0200
Message-Id: <20250722163258.62424-1-sven@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Arnd,

Sorry for the very late pull requests this time, last weeks at work have been very
busy and I wasn't able to find time earlier.

This time we have two PRs for 6.17, the details are also in the signed tags:

- Driver updates which include making a rtkit memory management callback
  optional and dropping default ARCH_APPLE from our drivers in Kconfig.
  I wanted to instead select these in defconfig but that change isn't ready
  for this cycle.

- Device tree updates which include the bindings and nodes for our GPU driver.
  The driver itself isn't ready yet mainly due to rust dependencies but we're
  confident about the bindings and want to commit to keeping them stable.
  Otherwise there are a two smaller changes: removing another W=1 warning
  (which required a change to the binding itelf that'll also land in 6.17
  through the NVMEM tree) and adding a missing touchbar framebuffer node to
  the Apple T2 SoC device tree.


Best,


Sven



The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sven/linux.git tags/apple-soc-drivers-6.17

for you to fetch changes up to 0445eee835d6e59d635e242ba1d9273f168035fa:

  soc: apple: rtkit: Make shmem_destroy optional (2025-07-19 14:52:36 +0200)

----------------------------------------------------------------
Apple SoC driver changes for v6.17

- Dropped default ARCH_APPLE from Kconfig
- Made shmem_destroy for coprocessor-managed buffers in the rtkit
  library optional since it's not required for e.g. SMC

Signed-off-by: Sven Peter <sven@kernel.org>

----------------------------------------------------------------
Sven Peter (2):
      soc: apple: Drop default ARCH_APPLE in Kconfig
      soc: apple: rtkit: Make shmem_destroy optional

 drivers/soc/apple/Kconfig | 3 ---
 drivers/soc/apple/rtkit.c | 3 +--
 2 files changed, 1 insertion(+), 5 deletions(-)

