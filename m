Return-Path: <linux-kernel+bounces-615119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 210E6A97828
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 23:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADD007AB977
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 21:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61BE2D868A;
	Tue, 22 Apr 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAg4NmgM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D578223DE0;
	Tue, 22 Apr 2025 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745355893; cv=none; b=QPKfbx5OsF3L4mMj+TZp5bEP1KECUWlcePdT7GNwIjOCs8or6oxMQwqEsbefXbnG+m16Ea5aSixZeyLnmtMfyjuP7Z7ePmpOZRepGENyeKUILEx1dcLesPCdaeNLRy+E50w1PQ/N1uW23wpchEJVTswooJV3HSPm0GUi2PcDUck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745355893; c=relaxed/simple;
	bh=OfMRn5cKPjqwkvIxOVvn4Ays7J1E2hH2e0sfXVPWnkw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BDT1wpA4O2CGjt8xo2SEavBUvmcZUZaGGd8G5OxN81eRU0WPsWdq8wk7QrTFYz521PwMMg8486As5G6I7lrFb4MR9vegGsUn/pM46eOAOVTPph6Sf+QoR2llN5AIvgz5LsU2EUAKYn6VsTENdY86g+qmcEUUtIiYF0NF+bFBfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAg4NmgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CE3C4CEE9;
	Tue, 22 Apr 2025 21:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745355892;
	bh=OfMRn5cKPjqwkvIxOVvn4Ays7J1E2hH2e0sfXVPWnkw=;
	h=Date:From:To:Cc:Subject:From;
	b=SAg4NmgMQrd4wuSXD6kwJqOqvBPSHoeL4cH+3n0Xv+A+wRdkpv0G68Pp/46eTtjHl
	 hkWk5XUrM0h8BYqz31HcVL+tYGdweQG92e7CvqzjeNas1+tBJs4uIhRAnsTu7nBfGZ
	 e4Bg2+q8iSuM0mrXSPmUEynshsqLAEzecJGzGOiKBEAKVUDbxP7vpN57OBHzbImaor
	 pQEBoZxJbTZpmmREQSc9v1Vn6gNftPQIBuPrYkJtw302JvNXxDgsR7Ab6WEX4QpcJs
	 NkGp7FfIkaJZHIOXBRHzNLZZang3c+xInqKdiUCRkpcK3UPV7oTGxcXdfTihIWhyb3
	 Z1UeDR74kJYHg==
Date: Tue, 22 Apr 2025 15:04:48 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2][next] Add STACK_FLEX_ARRAY_SIZE() helper
Message-ID: <cover.1745355442.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add new STACK_FLEX_ARRAY_SIZE() helper to get the size of a
flexible-array member defined using DEFINE_FLEX()/DEFINE_RAW_FLEX()
at compile time.

This is essentially the same as ARRAY_SIZE() but for on-stack
flexible-array members.

Gustavo A. R. Silva (2):
  overflow: Add STACK_FLEX_ARRAY_SIZE() helper
  kunit/overflow: Add tests for STACK_FLEX_ARRAY_SIZE() helper

 include/linux/overflow.h   | 15 +++++++++++++++
 lib/tests/overflow_kunit.c |  4 ++++
 2 files changed, 19 insertions(+)

-- 
2.43.0


