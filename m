Return-Path: <linux-kernel+bounces-899293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E08C3C574AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F3734E6B06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B1434D3AF;
	Thu, 13 Nov 2025 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/0w29i4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A945033D6F9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035033; cv=none; b=l7+AD1hHQuSpUyzsRkRpX3ZUBjZGyKjhGpTO8egUYw3bAgnZJ+Kn5YmW1G4w4l3WoAe1UESv3dfTRChu4C/mAVS05tx7LS90C7pVx67zSid7CWiKeHJd+9gnCxdrPo5rtencbpZFKgXwQoWoveDoU37s3talTronH/OLQMWcujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035033; c=relaxed/simple;
	bh=5pWJJ2yzTtPBpqwMZa8dZYL5BNi7MQ4FfRbbu/Qtef4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AvlSBB1wIKg2pV7+VuVEg/rKwl4NqHqc8eCrLJtTRHoLXyCuDY2glOkGC2yGQ4R/7/q2oxkHWnFWt28Fn+tmqsanR3Hvi6yAl33wZ90rOY3UgyMGabktopwMj/962q3/SOqjhoardx0xYv9Jai87yUQ369xSDHQb1t9PF8f3hyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/0w29i4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781F2C16AAE;
	Thu, 13 Nov 2025 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763035033;
	bh=5pWJJ2yzTtPBpqwMZa8dZYL5BNi7MQ4FfRbbu/Qtef4=;
	h=Date:From:To:Cc:Subject:From;
	b=m/0w29i4zFCD2PhcHjaupuMQP6SI2okdrG8jfE8bZa69b/Tu86DtrWkvDfatu4EGz
	 pT459YCWghl0spvSli4zU8+zUYZZjv2mkzsNC9WWUQanu/Y0mWoh+KZYUQSuvGMzdU
	 HtYePdvi0vcx1tiRvceBAbBRWBMyoFusnVt8pEkept5SwVkbV8poLhpsblcT35X0Tf
	 eTn2vkM7G4f9Uifnl/9fGpMN9+n8/BG93kY8cICVxp7IJw6OfwR3WcGctAtLuBhqT+
	 kjZGIwHsKmY1Ty7LLezh1unaDJsUGXh0Ah7u9le05E+T/lHMTv6oGHc1zBMn049AZl
	 FEmhoJ5NTY5iA==
Date: Thu, 13 Nov 2025 19:57:04 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Robert Morris <rtm@csail.mit.edu>, Chao Yu <chao@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [GIT PULL] erofs fixes for 6.18-rc6
Message-ID: <aRXHkO5ema3SJwzG@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Robert Morris <rtm@csail.mit.edu>, Chao Yu <chao@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider those fixes for 6.18-rc6?

Two new small changes as shown below..

Thanks,
Gao Xiang

The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc6-fixes

for you to fetch changes up to f2a12cc3b97f062186568a7b94ddb7aa2ef68140:

  erofs: avoid infinite loop due to incomplete zstd-compressed data (2025-11-07 04:10:45 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add Chunhai Guo as a EROFS reviewer to get more eyes from interested
   industry vendors

 - Fix infinite loop caused by incomplete craftd zstd-compressed data
   (thanks to Robert again!)

----------------------------------------------------------------
Chunhai Guo (1):
      MAINTAINERS: erofs: add myself as reviewer

Gao Xiang (1):
      erofs: avoid infinite loop due to incomplete zstd-compressed data

 MAINTAINERS                  |  1 +
 fs/erofs/decompressor_zstd.c | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

