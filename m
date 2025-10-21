Return-Path: <linux-kernel+bounces-862650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F59BF5D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4DB405292
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313BB3148B5;
	Tue, 21 Oct 2025 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzCFh0QC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD171DE3A4;
	Tue, 21 Oct 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043147; cv=none; b=bA8ENCCKufrMTN/NF0GPRd4r/z5f2MCTG9HasMgOrtCj525VtTV3QdxIr/AbJLWsP1MY4bF36FCFbA3rU/OX7BNjH2ZubC17BzlbahXiMQndWwJwp99l5k75lrE0tatYkKTdsvElzs/gcFxJvAcNX1pDTyGaOWIj/EPlnXz5az8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043147; c=relaxed/simple;
	bh=3q6sXrG7VRtYkwyyX371flcjfB6mMLFODYR2Y1GJ5ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsEGff+Lw/yR9VIvndhC78tyTQgqg3kdMPzKmbBRcwBdJEeKhFQkCUboWmqpU1qkc5NvGtyZ1T5begPtIfrNkk98eFt4Lp7uwZr7mdQhxKyOKwR6XBMEjUphY3ZEs6RSkWMwi0W1LhkemZmb2TH+BDevwqqChYeyEtzdlKhBF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzCFh0QC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719B0C4CEF1;
	Tue, 21 Oct 2025 10:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761043144;
	bh=3q6sXrG7VRtYkwyyX371flcjfB6mMLFODYR2Y1GJ5ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzCFh0QCeSof5RGIYPgGsaVe+nfXHn62yajRTCSVY6Y5LBFLXL7w8glp6OxLn0Ql1
	 Hc+Wp5iftVS8nioy0xmGRMec1B77StL0+tw4bf91loDKoDzJzgv36l3oX48nXFaQVd
	 o13FxnAfXbR7x5ewNSPsHfi1WVA5GkKcvTNlSIDovjH1rZuBTvOR6T585csT4M9YnS
	 Ke9zX83BafZh1gPaY8LFPoqgsWh2dIlqaw+rW4M86Slz5kU+9fcG+O5piM6SmiTeRl
	 lQulycs9DTZDyOmG9PFRuKgc7yY68DnfnMf3U94ZOUm4fvAbJuvyADTbkM6LDb+Rcw
	 XzfAdkChKjTSg==
Date: Tue, 21 Oct 2025 11:38:59 +0100
From: Lee Jones <lee@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, linux-sunxi@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] MAINTAINERS: Update Chen-Yu's email address
Message-ID: <20251021103859.GB475031@google.com>
References: <20251020045603.2573544-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020045603.2573544-1-wens@kernel.org>

On Mon, 20 Oct 2025, Chen-Yu Tsai wrote:

> The email forwarder I'm using has run into severe problems with Gmail
> lately. Switch over to my kernel.org address for kernel development.
> 
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
> ---
> (resent to correct dri-devel mailing list address)
> 
> This likely needs to go through drm-misc-next following a patch from
> Maxime that removed himself from the Allwinner DRM driver entries.
> 
>  .mailmap    | 1 +
>  MAINTAINERS | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

