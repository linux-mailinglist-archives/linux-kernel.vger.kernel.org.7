Return-Path: <linux-kernel+bounces-760600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A59AB1ED8B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFDA16AF9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D8D267F48;
	Fri,  8 Aug 2025 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKV/EkZ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62615182D3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754672529; cv=none; b=cpfeft1n/nvodpHa5XiFME5S12+NjM+GTtwYmgmg6m8F+enzavxn1KfRhGHAYSEr6icG2uyqupfZYWShDr3ArF1AVpkx1ihouAamD2b25ILX2vjDY8wToAGUZ51FYV/n3T23WW/MM8kXZ0lS4k1dkx7JM6c+uVkZ6m2yw8fmazQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754672529; c=relaxed/simple;
	bh=2LFUPaMOjxrEMXqEHJuPPk0PqNstnOSoSO443f+dgpI=;
	h=Message-ID:From:To:Cc:Subject:Date; b=kaa9fOGFhSSNZ96bO8az8clRVWg3eupZxmkg+CSefCSdp4xnRsOVQDUtLHiwMFUmoWpZbhYOpZ7NccHoxzMgngrqA3m+O1d4A4fmV+YNcLvjPdKVdjcfoh1rHH7QWnErm5vMr+XGa5gcuvRu4Ti8QWwr0JCLVceSWGH8wsEmOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKV/EkZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BB6C4CEED;
	Fri,  8 Aug 2025 17:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754672529;
	bh=2LFUPaMOjxrEMXqEHJuPPk0PqNstnOSoSO443f+dgpI=;
	h=From:To:Cc:Subject:Date:From;
	b=qKV/EkZ2lGhZ90qyr0W9anromWPLuxtbKRQnJhKwNp3obgqP6IVqURKNOgpeGWUwe
	 +iUl1LMgEw42H4/l8soGgzuLVhJjng4z2rBKlgUXIl2Oo1VmN0BPMGQ3BDFpXFRjTb
	 Ab2ofT40A/8bsRSOyIFYi/sin8QRdXUNd1rWI2c4D6Nj60RNQnoGd6jgv+vEntnmcV
	 6BAQG4SdowfVFEgkBmdbd+onRQ/oRGfYs0zIzzDskg6XJCqETdnW2ysRiyaAPs/XpG
	 bdyjNMFqkZiUeghCMIl4ewJqIOczI7MwXNGAbELPeY1blYqabQob3uxz8h6s7X2ucS
	 5WwhgcnAwQfXg==
Message-ID: <ab85dca88a780d53a88965c6700d08bf.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.17-merge-window
Date: Fri, 08 Aug 2025 18:01:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit ffc72771ff6ec9f5b431a86c4b00d8ef0fea958b:

  regmap: Annotate that MMIO implies fast IO (2025-07-25 13:44:33 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.17-merge-window

for you to fetch changes up to 76b6e14aa7b081337d118a82397d919b5e072bb4:

  regmap: irq: Avoid lockdep warnings with nested regmap-irq chips (2025-08-01 13:37:07 +0100)

----------------------------------------------------------------
regmap: Fixes for v6.17

These patches fix a lockdep issue Russell King reported with nested
regmap-irqs (unusual since regmap is generally for devices on slow buses
so devices don't get nested), plus add a missing mutex free which I
noticed while implementing a fix for that issue.

----------------------------------------------------------------
Mark Brown (2):
      regmap: irq: Free the regmap-irq mutex
      regmap: irq: Avoid lockdep warnings with nested regmap-irq chips

 drivers/base/regmap/regmap-irq.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

