Return-Path: <linux-kernel+bounces-838680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A85BAFE93
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63A416C2CF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F426CE0A;
	Wed,  1 Oct 2025 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow246EWQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0831E8331
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759312036; cv=none; b=PCxDnrg4e5XTHlzCwZZE3VmwEAlzdL/s2KsCA8dihlyGy7wGOyVOoX2E9pp9DoZdr3bOYZmkTqLnZ5aiRcRoq5DwsHVESYgL8e/B9DNYjC4v14SeSkNu3sGmDmxWD/Ih4EXka7JKbdhdeWF/4HbN2GOnMavPle3Q/0RUs6cF1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759312036; c=relaxed/simple;
	bh=AJHFbPJq68Zx8blt7UCVBEy7fUQCPK2OQPYpQ/itWjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g2vgEEi2o5LRaKsBt1aoJVVHTWV3tvUijkSIFQwSEsp6GULswLpx7KF72P5f1PAyD0y+t67TWSyiWvouOAgZmOeRrFah6+fMxBldTk63LEI5EcwX8VjeQzYPmBoHdfDSXQbcbuIxz8iahR0MAey/MRJ09U6ax1V3SodAxvkjgzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow246EWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3F6C4CEF4;
	Wed,  1 Oct 2025 09:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759312034;
	bh=AJHFbPJq68Zx8blt7UCVBEy7fUQCPK2OQPYpQ/itWjw=;
	h=From:To:Cc:Subject:Date:From;
	b=Ow246EWQsVODsgoLjQPX6+okAmX9id2ACLak5uukRdrL8hMLjFweY36Nlawi5Ycl3
	 qNoV9gFg67IZgI4cQs9rZiiVR7Sc8xnY0gakJBPqnr1yuB07n5sYZQSS7FYP/Ep4rl
	 8uzPb3PStsySjLN0OWm6q5HEvMmd5mpcxcOTDaN25MMwpU3lXUfEkapKwxq7ig3MET
	 2f+F6GlPlwl5YGlf+jlBC2N5AxIZR1y+XgH/pIcTLH6DpA1uJa/Fu0Dbdr0Jh+sEz9
	 ZmsoEZWUllt7tjlpRnUQXTBl1c+uJhE8DO3CfG7Jh8epo12yrne4TQjIbgCEKhgexm
	 z0zEVT1h8Q8TA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Breno Leitao <leitao@debian.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] configfs for v6.18
Date: Wed, 01 Oct 2025 11:47:04 +0200
Message-ID: <87jz1fvtrb.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Here are the changes for configfs for v6.18. This time it is just a very
small refactoring to use PTR_ERR_OR_ZERO().

Please pull for v6.18.

Best regards,
Andreas Hindborg

The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  ssh://kernel/pub/scm/linux/kernel/git/a.hindborg/linux tags/configfs-for-v6.18

for you to fetch changes up to 462272dd734b568f0190d01e24f5257c1a763fae:

  configfs: use PTR_ERR_OR_ZERO() to simplify code (2025-09-04 16:49:17 +0200)

----------------------------------------------------------------
configfs changes for v6.18

----------------------------------------------------------------
Xichao Zhao (1):
      configfs: use PTR_ERR_OR_ZERO() to simplify code

 fs/configfs/dir.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)


