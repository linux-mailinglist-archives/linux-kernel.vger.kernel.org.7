Return-Path: <linux-kernel+bounces-844279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB5BBC1706
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 466094E0EC4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81042E03F3;
	Tue,  7 Oct 2025 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lTGdHFT4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D7D288529;
	Tue,  7 Oct 2025 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842541; cv=none; b=sM3SxpDnKlxZDxeztbwt6iWDpPHG/qB7NfMqGfOPeaVntBvGLTfJTE1yx01BSPIpcSzNe22BaHGl+OJyR3FNwlYy2WgboJZtE00+V7MbZ+qcLkUPbruXHyKkGVbWvHMH08Z0AqFf3XOj1evZ7lcSX7vnw5C3odkeB3giq2sdyLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842541; c=relaxed/simple;
	bh=dnXJrhA1Du/5HdpoGQzTQcx+O1dHLx0aLKCzq5hkRIw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dCWran0GMEdw4n3ZIDjOjHfng26QIiUNBK9+sL359V3E1PWAwP8yqKCngT6FoiSOE9qmAQ3l+UKQp7T1jY0MbUPm4AI3aQWd8H2cD3zDqdQ5st2v9HWhdLn/MHJSgKhpIaL1wjY8H+aJcinewNr1R4yKP4fRjDynPCPZ1Yvh4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lTGdHFT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C38DC4CEF1;
	Tue,  7 Oct 2025 13:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759842540;
	bh=dnXJrhA1Du/5HdpoGQzTQcx+O1dHLx0aLKCzq5hkRIw=;
	h=Date:From:To:Cc:Subject:From;
	b=lTGdHFT4zaeGiG2J+Oo8pvjlmQQKl2llvQcgtuevRSFcINtjQTef8OnU/NfDri0sq
	 Fy7h5yleV5k0i9koGkawdGEnIBU7OezNwc1vRkIlBA6csIZLxSGvg9XKddujk2vbr2
	 T6VZZEL7KM8bbfCUPxOmGVJ4JOIzT7Mc0ofvCJKs=
Date: Tue, 7 Oct 2025 15:08:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes for 6.18-rc1
Message-ID: <aOUQ6d4me_xFTEwJ@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.18-rc1-2

for you to fetch changes up to 82a051e2553b9e297cba82a975d9c538b882c79e:

  staging: axis-fifo: flush RX FIFO on read errors (2025-09-12 16:21:46 +0200)

----------------------------------------------------------------
Staging driver fixes for 6.18-rc1

Here are some staging driver fixes that missed 6.17-final due to my
travel schedule.  They fix a number of reported issues in the axis-fifo
driver, one of which was just independently discovered by someone else
today so someone is looking at this code.

All of these fixes have been in linux-next for many weeks with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ovidiu Panait (3):
      staging: axis-fifo: fix maximum TX packet length check
      staging: axis-fifo: fix TX handling on copy_from_user() failure
      staging: axis-fifo: flush RX FIFO on read errors

 drivers/staging/axis-fifo/axis-fifo.c | 68 ++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

