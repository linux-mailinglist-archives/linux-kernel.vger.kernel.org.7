Return-Path: <linux-kernel+bounces-896526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9818C5095D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E848118921DF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47142D73A8;
	Wed, 12 Nov 2025 05:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYvG+vC8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B6C22FE11;
	Wed, 12 Nov 2025 05:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762924383; cv=none; b=FjgWz367K4FMwlCYJuIAiX3kj3AJH/MWWL9JCKOrqM+dGT4GZrWyw0kEc072dPfz+7ByLABgA9Cl7GbFzsaIRFB5cFjKpoBTe7FUqbQDAUV8phMcAZS6RnmsrgRLiS6OvmpPqNBnvPO39B5sF7idXYa/zcXZZjndHtc52yFzrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762924383; c=relaxed/simple;
	bh=RlLRISdcE5p5VLF8WXXHsppZinxHy1Pj3efg9RnzMpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjXpeooc+2ZP8biE6R1e4OVisnWLp14ajeZ0xEM0SVBYgbHjkYJNLEqNHq4+ZIPpKfSYH8TJfQ3BHajGx1zltaUBAWgFPdjNorp+Bp7mTe7QPVNqD9sEzA+ZD5Fkb6tQJjRgpckdi11RNsWNJQ67aPaZ10v18IzLkxmFxUq0QGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYvG+vC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2E6C4CEF7;
	Wed, 12 Nov 2025 05:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762924382;
	bh=RlLRISdcE5p5VLF8WXXHsppZinxHy1Pj3efg9RnzMpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYvG+vC8ljUA907Aogd2J6T9PfCneLXwGhES9B0+CXHZw6pIF/QS5NYw5fa3fOHVt
	 oP8dekkl3uvH5RqJPCncIo/GCk/pvcQq4tZ78U53YbqHQoElL9rZxzT2CEScPGOShc
	 1m+ZQV9yvAyuplSIHewXbRKvhY1VJB/5ZHf/Wdep+2JSR1Kq1/GeyT60fluBh71OsX
	 PjY/qh6bCMVjB/QFiy0D9tB3qJXWvWilZW/E9meZOQxEJlNRmGu3GAy1eoydypFySd
	 +3tsRRzlg9vP7CMcQSxCbg8X9ZwJZOKx0ZaeIhl5ASrlGHL4tzXpcxmTbyOige1Cd1
	 JhJcHxHWBoUPQ==
Date: Wed, 12 Nov 2025 10:42:58 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev, bard.liao@intel.com
Subject: Re: [PATCH 0/3] soundwire: send multi sections in one BPT stream
Message-ID: <aRQXWpLqDm8EduYN@vaman>
References: <20251021094355.132943-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021094355.132943-1-yung-chuan.liao@linux.intel.com>

On 21-10-25, 17:43, Bard Liao wrote:
> Currently we send a BRA message with a start address with continuous
> registers in a BPT stream. However, a codec may need to write different
> register sections shortly. It makes more sense to send different
> register sections in a BPT stream and no need to close/open the BPT
> stream repeatedly.
> 
> This series depends on the "ASoC/soundwire: add fake BPT frame to align
> Intel DMA buffer size" series. Sending it now to get more review time.

I have applied it on top of above series, pls check why it is not
applying in :
error: patch failed: drivers/soundwire/intel_ace2x.c:156
error: drivers/soundwire/intel_ace2x.c: patch does not apply

-- 
~Vinod

