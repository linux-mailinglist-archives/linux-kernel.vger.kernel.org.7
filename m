Return-Path: <linux-kernel+bounces-838902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC80BB0647
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA7A2A2BAA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DE02EC090;
	Wed,  1 Oct 2025 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7XNN/3A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9030D2D2381;
	Wed,  1 Oct 2025 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323362; cv=none; b=Ofuy4SOsHUVWLFDot/lNTPeoOH6r0/ZMWJLnSyflZNPneZPsac0lmJ/q6+SrfHU5lgF8ZafdKCeuCtf0yMKXBP6LbUFPDQsgmI34AZxgt/ifnBtCFgitfVFjZa3rxiBZnkrayLCLb3ldKzyrJhY/aJvX7oqcBwww5J4LK45r2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323362; c=relaxed/simple;
	bh=+xKFI45PTF8KSX2ZGwyuj4KX2LtTG6eIIxgMdws5xt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+Ok0xLj3BGHl1mzr8v15PZqhbyMRNSD5iazeWZS3qqvAod8hc+9nW0O7erx+nJkXp789JRvGBDgyw2UMsvd866E0ubhcs4HpmsMQ97eCyBOGs/LZ6hHy5Ccle47A/uK1WqJHo7qLBucJgNq6U3pWL1p1N3jid0LHENIYvDXZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7XNN/3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6D9C4CEF4;
	Wed,  1 Oct 2025 12:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759323362;
	bh=+xKFI45PTF8KSX2ZGwyuj4KX2LtTG6eIIxgMdws5xt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7XNN/3AHpMVB9h2F3DVLSlT0qyfSPUop+Cw4EdxwZRM7FJ595D7UVtXKxtSi2KtN
	 gbXkvSar7Fw54Mj9hMAZly03em8BiZ/go8xUoPMmgNqxIE7wHwRBYQMT8shBSKPnri
	 H7vwGYCawNENlxWE3WS7eM1t8BmLh+T3iCAopQYjPelTGOoJ0F34l3IwI5+w4EAckd
	 CCvd1nzepj7GQccjmhl/dbb44/1cbAioHRiL8znGpMpkB8pfXcpWAZzdHWTFbCPANL
	 HjC4eHs8fpaumgq1D77SscpO7R86QFY41ZlWmXS55qAf09bDJdrc1vGmeSY6kqlph+
	 AFb3NToKyZW1w==
Date: Wed, 1 Oct 2025 07:56:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] of: doc: Fix typo in doc comments.
Message-ID: <175932334236.1150082.9361612973016720820.robh@kernel.org>
References: <20251001085716.45361-1-bhanuseshukumar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001085716.45361-1-bhanuseshukumar@gmail.com>


On Wed, 01 Oct 2025 14:27:16 +0530, Bhanu Seshu Kumar Valluri wrote:
> synthetized => synthesized
> definied => defined
> sucess => success
> 
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> ---
>  drivers/of/irq.c     | 2 +-
>  drivers/of/overlay.c | 2 +-
>  include/linux/of.h   | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 

Applied, thanks!


