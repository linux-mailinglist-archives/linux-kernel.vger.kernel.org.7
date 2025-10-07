Return-Path: <linux-kernel+bounces-844280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C88DBC1709
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08B5434F041
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4719B2E03FB;
	Tue,  7 Oct 2025 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H20xxQjK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974AC2D46DA
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842557; cv=none; b=h2cSv+OVWsW0wptxrKyRETH4655Cd2WTrv8SjqWcef36nAIK6SlxhEsoMW2qgKg526KO01wFSwR8KJnu5LmNxrOtHFbwsijw/lrmmjlUG2izhqeqpxUL2vk3pYy1/pYAQKV9Cgr7u6Y1g28zeeWb7kd3BSmP8ZcmCjAlozYwQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842557; c=relaxed/simple;
	bh=7+b9mzhZhGk7teWQIGJV14rPQT890YkHjeZnN4mso5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ueed9q+b8/0xoIU7EpPGPQP5BETqGZP5bY1bYE9NAZ43Wppdzg7+t3XyRLUJMY7rpOtt9BjvMj8gprmz95rbC10mfpGJQiaEGEtTtE5gQk5vn3mnRSwpldxl6heBvvwXNfOdHVdNNrk3iJ/a71RuN77aCKTACx3w3w992aGDLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H20xxQjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C265BC4CEF1;
	Tue,  7 Oct 2025 13:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759842557;
	bh=7+b9mzhZhGk7teWQIGJV14rPQT890YkHjeZnN4mso5M=;
	h=Date:From:To:Cc:Subject:From;
	b=H20xxQjKB9z2HFIztG4EkN9Trjp3luqgLpEM8kkI+Cw7NlprWNzxOGHNdHhxTm6S3
	 WK3cYx+Oojvf/5KYtlEetmP6Yii7Fety1PiS8vNEiZ3SOQVt064087fIZYSUAIEMKC
	 7wibWcvMQO7S6K9eSoO4M5gOaIXA7T8L2GjKDhME=
Date: Tue, 7 Oct 2025 15:09:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc/IIO driver fixes for 6.18-rc1
Message-ID: <aOUQ-nATuR-NzHLE@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.18-rc1-2

for you to fetch changes up to 10df039834f84a297c72ec962c0f9b7c8c5ca31a:

  misc: fastrpc: Skip reference for DMA handles (2025-09-12 16:34:10 +0200)

----------------------------------------------------------------
Char/Misc fixes for 6.18-rc1

Here are some small nvmem and fastrpc fixes for 6.18-rc1.  They missed
the cut-off to get into 6.17-final, due to me being slow in getting them
out, my fault, not the maintainers of these subsystems :(

Anyway, better late than never.  Changes included in here are:
  - nvmem fix for automatic module loading
  - fastrpc driver fixes for reported issues

All of these have been in linux-next for weeks (4?) with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ling Xu (4):
      misc: fastrpc: Save actual DMA size in fastrpc_map structure
      misc: fastrpc: Fix fastrpc_map_lookup operation
      misc: fastrpc: fix possible map leak in fastrpc_put_args
      misc: fastrpc: Skip reference for DMA handles

Michael Walle (1):
      nvmem: layouts: fix automatic module loading

 drivers/misc/fastrpc.c  | 89 ++++++++++++++++++++++++++++++++-----------------
 drivers/nvmem/layouts.c | 13 ++++++++
 2 files changed, 71 insertions(+), 31 deletions(-)

