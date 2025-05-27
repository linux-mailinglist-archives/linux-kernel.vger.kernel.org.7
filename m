Return-Path: <linux-kernel+bounces-663903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622A4AC4F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 14:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AD6189FD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ECA26FA46;
	Tue, 27 May 2025 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGEVK+5W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A9A212B0C;
	Tue, 27 May 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748350785; cv=none; b=EEeWEZbiNbxkfy0rJ+UG5au+fZrKuLuCpHE9NBoV/iw7+H4yyLUQFDxesNFWGCOHKPoGCjC8zkqjVKcwehj++BfPlpgw90dlJ9k41loXFv0kMo7G17IOFDFKZlXymB/nTJp7RKZvFeJC31+SBoHRy1WWT6FhlzaskvU/4ojuAUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748350785; c=relaxed/simple;
	bh=G/1KIyH80nzu3tilmQtmDuLXk1YCEor3aOc7I81yUtE=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=rgzntGl2ZW/qWTS78bQ+KONjZUoxWM40YLVzbuvN1qzEePAnX1llpYVniPH4YZNvP85KHGoKdhbrB5UWx0K12guHtbOzzF+zfll1DPDVlgx/Ozv2iFMZ8iE1wx2w7QZhwHnuNpdh9pxaDVMbI0q5AyWOi0jSrixNSBPQ478eWQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGEVK+5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD79C4CEEB;
	Tue, 27 May 2025 12:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748350784;
	bh=G/1KIyH80nzu3tilmQtmDuLXk1YCEor3aOc7I81yUtE=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=nGEVK+5WcSP6gw5lYN53GnJvNCl0wmH7+luQtkCuTFmxUvzkU0JApCpHcBw2H+e8X
	 J1kwhMPO0k4acu7J4zg0VLh044d4MlqsVlhW7yGUg2xy9rqxW+TMYTtQXkM8Y93EI4
	 BfaivoB49rOs179bGLe6/uLn+ZpSpttyp37YG5Ckfl37R5Hwin6/jLsav0TmUwW3pB
	 dzAnn2QoYtWZ6cW78sIs43M4goOHHck/RYjxXTpfTbcVo/Q+IBw1+gbSfn1+ibCr+3
	 LFTQg6aGc1RlMl0Ru3f9p8sbtXTNg6+sq4zdFZ/T+aqkBwXfZFXG+MbRGs0MNjDKmT
	 DjhcRnqywdabQ==
Message-ID: <b1b422178ef37cf1629dc18cbe5344c6@kernel.org>
Date: Tue, 27 May 2025 12:59:41 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Jared Kangas" <jkangas@redhat.com>
Subject: Re: [PATCH v3 1/3] Documentation: dma-buf: heaps: Fix code markup
In-Reply-To: <20250522191418.442390-2-jkangas@redhat.com>
References: <20250522191418.442390-2-jkangas@redhat.com>
Cc: Brian.Starkey@arm.com, benjamin.gaignard@collabora.com, christian.koenig@amd.com, dri-devel@lists.freedesktop.org, jstultz@google.com, linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mripard@kernel.org, sumit.semwal@linaro.org, tjmercier@google.com, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Thu, 22 May 2025 12:14:16 -0700, Jared Kangas wrote:
> Code snippets should be wrapped in double backticks to follow
> reStructuredText semantics; the use of single backticks uses the
> :title-reference: role by default, which isn't quite what we want.
> Add double backticks to code snippets to fix this.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

