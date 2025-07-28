Return-Path: <linux-kernel+bounces-748298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04607B13F31
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24521665A7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4CD272819;
	Mon, 28 Jul 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UA7db/0Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898D926FA6A;
	Mon, 28 Jul 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717677; cv=none; b=hiXL1XbD98LeJdt+lXz30XGof5jiMga00zKsulVGICHf4+1hG8yMYk9mBqRTlxnQpNQiCs0N4A/QMc37duXRjWMwqVYVF8KXllG/6X/yaECpdHDrUc/5lmTMaDFu0OB5qfxgVu5SvXYf0uttFNLYM1VEwlFIIUQfxxLo0Q2nv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717677; c=relaxed/simple;
	bh=Vpr1e6NmDO0zcMg4pbHnj+HTs48wUbI1Rb/JHzcIqnk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jHqkx4dZEcdurcQrzeskQIQt/vaN7EjxeFtFQ8n+TEgN+yweavFlR9zcRGTrykUu7lfRTRul8C8wxxQT13Jie4D9pTN4whCg3x0GSuvQyqgBFRmPre7qQhTbBChMzsOl2vz0k/Jjmr6EfZtryee1AyI5ibB/gszbSlW6asgHpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UA7db/0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F723C4CEE7;
	Mon, 28 Jul 2025 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753717677;
	bh=Vpr1e6NmDO0zcMg4pbHnj+HTs48wUbI1Rb/JHzcIqnk=;
	h=Date:From:To:Cc:Subject:From;
	b=UA7db/0YAkld33v1+a1kEe3GwXnttFB4Bs31eZARp7mhFkSU+JXetadPJSnPWJq6s
	 GrNR7YPwJaLGILKl4AcLNFFiEJevIxGHa9m3RuSQjbYNl8wVQ8+K28v6POpRvH3ToM
	 YtmkvBVjjdeGFZ+Les/15atRgQQb71uHykCc6K+w=
Date: Mon, 28 Jul 2025 17:47:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-spdx@vger.kernel.org
Subject: [GIT PULL] SPDX/LICENSES update for 6.17-rc1
Message-ID: <aIebqSE7UXDL-jeN@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-6.17-rc1

for you to fetch changes up to 06a9a4408697aaf0b4bd88936a3075a9a0b30124:

  LICENSES: Replace the obsolete address of the FSF in the GFDL-1.2 (2025-07-24 11:15:39 +0200)

----------------------------------------------------------------
LICENSES update for 6.17-rc1

Here are some small changes to the LICENSES files, removing the physical
address of the FSF as the old one was incorrect and they finally no
longer have that listed in the license files.  These updates come
directly from the FSF copies of the files, so they mirror what they want
the files to look like.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Thomas Huth (6):
      LICENSES: Replace the obsolete address of the FSF in the GPL-1.0
      LICENSES: Replace the obsolete address of the FSF in the GPL-2.0
      LICENSES: Replace the obsolete address of the FSF in the LGPL-2.0
      LICENSES: Replace the obsolete address of the FSF in the LGPL-2.1
      LICENSES: Replace the obsolete address of the FSF in the GFDL-1.1
      LICENSES: Replace the obsolete address of the FSF in the GFDL-1.2

 LICENSES/deprecated/GFDL-1.1 |  2 +-
 LICENSES/deprecated/GFDL-1.2 |  2 +-
 LICENSES/deprecated/GPL-1.0  |  6 +++---
 LICENSES/preferred/GPL-2.0   | 10 ++++------
 LICENSES/preferred/LGPL-2.0  |  5 ++---
 LICENSES/preferred/LGPL-2.1  |  8 ++++----
 6 files changed, 15 insertions(+), 18 deletions(-)

