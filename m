Return-Path: <linux-kernel+bounces-842476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98202BBCCA3
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 23:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 119F2348317
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 21:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A844239567;
	Sun,  5 Oct 2025 21:38:58 +0000 (UTC)
Received: from mail.treewalker.org (mail.treewalker.org [78.47.88.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17462156F20
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.88.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759700337; cv=none; b=mlb5bDvoZO0N63gIcDe+yYhHgFRkaRcZAeb9je49P/IpaobqAk6Hg2Gdd7QNn1D2lDH6/Vl9YZFU2UBL/wrOLBR3jZ7PL/AFMkx0HDugQ7oWehVed75h7FktPCLMzXnlvWSq1JvQdljQDB5UvtE41VrZCMA3W98g6fTlbmLCAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759700337; c=relaxed/simple;
	bh=/vXPd85vKu1f7zNLV2mMdyJ32zm5bBgngP0fpCo/7iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sML0n1qAZr1D4BBU2Adj7tIOsoaI4nOm48xWPxslG+I85+/qEf2yHIky0XaTwWG8o7e/dQoCrjS4JMu4cbzfMao+zOiAPJZ4RUDiX5LwX9xjdY8gXy/2DeFmpXzTg2f7U9j16dr4SK41nfXcnlQSQwF4r2U17iGR2PWV6q6go1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=treewalker.org; spf=pass smtp.mailfrom=treewalker.org; arc=none smtp.client-ip=78.47.88.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=treewalker.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treewalker.org
Received: from hyperion.localnet (unknown [IPv6:2a10:3781:5345:1:a81:e1dc:2665:ea0c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.treewalker.org (Postfix) with ESMTPSA id 8EB611FDC2;
	Sun,  5 Oct 2025 23:31:04 +0200 (CEST)
From: Maarten ter Huurne <maarten@treewalker.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 John Hubbard <jhubbard@nvidia.com>
Cc: Dave Airlie <airlied@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] drm for 6.18-rc1
Date: Sun, 05 Oct 2025 23:31:03 +0200
Message-ID: <3771775.lGaqSPkdTl@hyperion>
In-Reply-To: <bd004ac5-9e51-4e90-a3a4-025d74941a38@nvidia.com>
References:
 <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CANiq72kq5YHovH=_a9c0JQgfrAx9gRsQvVo1VfHd-FaupOp7rQ@mail.gmail.com>
 <bd004ac5-9e51-4e90-a3a4-025d74941a38@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday 4 October 2025 03:53:34 CEST John Hubbard wrote:

> The main complaint with rustfmt is that it is extremely twitchy and
> unstable with respect to one-line, vs. multi-line output.
> 
> *Especially* with "use" statements.

The Black and Ruff formatting tools for Python use a "magic comma" rule 
that works well in practice: if the last item has a trailing comma, the 
items are guaranteed to be formatted multi-line, while if there is no 
trailing comma, single-line formatting is attempted.

I couldn't find documentation of the feature itself, but there is a 
settings flag to turn it off that contains an example:

https://docs.astral.sh/ruff/settings/#format_skip-magic-trailing-comma

Bye,
		Maarten




