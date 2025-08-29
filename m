Return-Path: <linux-kernel+bounces-791436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBF3B3B6B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EEB1C8409A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B142E9ED2;
	Fri, 29 Aug 2025 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcXvvHUc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38F328032D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458602; cv=none; b=E97cZl8FhgYEIzjbqoLywzcwuZkYH/tpuUK7ZCdRNyYrlcULvZSTDcLt9fDkAofxEDwNaH9FWkLQJEfdOV6rjQuJl5HbnG/S9fAqnepvMPS2EmpjS/8ikXgsdsH58HMcIaTszWFiAxYhiYJAtS9qZi+bYPBylnZYng5sg2dJIP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458602; c=relaxed/simple;
	bh=VBF/DMw0Iok6rhj1tIAStutQjyne0q8/Xrs2Iz9Ehxk=;
	h=Message-ID:From:To:Cc:Subject:Date; b=AJyGjZGVkrzoNLtw+Q8GndBIHBzFzgrp0rAfmaYsvarf9wkimOR3VeVCuRDgqwXzTbLXakJP5Wf9Jwu66JpO66tNLYtXvVJ3P3lquBLoDvAzZ36nrSEqM1qSO2Yz6RsnFuj6tlwHZs+4unWueBRBsq6aTE13NBqGn7X3um3jjY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcXvvHUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACF9C4CEF0;
	Fri, 29 Aug 2025 09:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756458602;
	bh=VBF/DMw0Iok6rhj1tIAStutQjyne0q8/Xrs2Iz9Ehxk=;
	h=From:To:Cc:Subject:Date:From;
	b=jcXvvHUc5o7AfyLRqOM7RdTYjYUYIf41tozRJjC6G/1shAIQd1XKfjblKzCnd9rnU
	 /aO3f0IJwziMjvKKzXeIU25NvfcpUUXh3Zrca4wbB9OqGagNxTsnHx3JDx59gtwFgD
	 +0heXIC71Dbj10uhYUZs/c/8CtZMd/pfIdic2KlXgoh4rmNmQ1TjdunnkYnrJZdMKb
	 noEIWguFFkSSc02YOtPPIiW4Bjege7WcTWj+C6l1ttDrdslVXEXeOUPkPnqQdkItvL
	 v5qhVREwrFJo6ke2wytyCbKqGuP2p1RMJ5EXF3y5oh0wER00pJR/nS3iA4df8/UH0k
	 g7QzW65I0xL6A==
Message-ID: <95ec661014b45484c239a057b6d954c0@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.17-rc3
Date: Fri, 29 Aug 2025 11:09:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.17-rc3

for you to fetch changes up to ef3e9c91ed87f13dba877a20569f4a0accf0612c:

  regulator: pm8008: fix probe failure due to negative voltage selector (2025-08-24 22:41:04 +0100)

----------------------------------------------------------------
regulator: Fix for v6.17

One simple fix for the pm8008 driver for poor error handling, switching
to use a helper which does the right thing in the affected case.

----------------------------------------------------------------
Kamal Wadhwa (1):
      regulator: pm8008: fix probe failure due to negative voltage selector

 drivers/regulator/qcom-pm8008-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

