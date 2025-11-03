Return-Path: <linux-kernel+bounces-882896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6D2C2BC5B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12B0F34A604
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DE22D8360;
	Mon,  3 Nov 2025 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB3fMYYI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FC32C325F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173668; cv=none; b=bzfWX1f6A8gc/sMtnjj6zjs30gX7nYwGxeN6txo/Iim6yWrfuhrSzJsM7XGLfD78z9RW6ogPSRH/NNwoXTgGv0ej2RT2UqmLhKVYUEQB+ZVhPavLmupTVZGBbC8tYNgSH5mWO6bioWkhB4n2cDTEIeOr/DInFjHsBvLAPVumUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173668; c=relaxed/simple;
	bh=LFNa1RWvyQXfYvHtptsTxiA9gGIdAMdc8de2nTvx2vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tn6yFcHyxxFqC02f2Ts+XUhWTr3L8hIIyCHViDezQlElBayQlBFBnMRwc89p53DygYqDYa8BIWpAzAxYWsjPy871ilv1Ece3CswuqeUYqii2eGmL1A3SbuOqn3Psw2SV3iXy5rCLGVjSiEYHM6/gVaoSoCF2L00rhQWMd/KZ63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB3fMYYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65003C4CEE7;
	Mon,  3 Nov 2025 12:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762173667;
	bh=LFNa1RWvyQXfYvHtptsTxiA9gGIdAMdc8de2nTvx2vY=;
	h=From:To:Cc:Subject:Date:From;
	b=KB3fMYYIaQ3dXXDnbzt+KQR+SqnCLqPU7abJ6yIQHirqBmhgiGIOlNMdcNBWnOlNv
	 nrj4JgiClyDKDzyzf4cowxewLoGzA/Pn2euAYII2Oi+dJDhf/WawRoXtk3xuUlWZ6y
	 mXLUfl/yoH1gyqNnrOpfqg7Au1y9bWaov0j/gkRTtR9+1xAhgFJNKYfZIZav3yW2cS
	 zWGCTV6vOkkBqwbdgCJCyFFpJDDpeyIppRvVOtJeVoexIigqkhcFiNMUR+4tzULgM1
	 bTDOT63uNj44YcVEsF0TMbKwGtIJcllkrsTzm8WPa4/SUwWNVNv+NjNM34YHiv1tI1
	 yZpOTmXNZMB2Q==
From: Dinh Nguyen <dinguyen@kernel.org>
To: gregkh@linuxfoundation.org
Cc: dinguyen@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] firmware: stratix10-svc: fix for v6.18
Date: Mon,  3 Nov 2025 06:41:05 -0600
Message-ID: <20251103124105.34655-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/stratix10_svc_fix_v6.18

for you to fetch changes up to d0fcf70c680e4d1669fcb3a8632f41400b9a73c2:

  firmware: stratix10-svc: fix bug in saving controller data (2025-11-03 06:24:19 -0600)

----------------------------------------------------------------
firmware: stratix10-svc: fix saving contoller data for v6.18
- Fix the incorrect use of platform_set_drvdata and dev_set_drvdata

----------------------------------------------------------------
Khairul Anuar Romli (1):
      firmware: stratix10-svc: fix bug in saving controller data

 drivers/firmware/stratix10-svc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

