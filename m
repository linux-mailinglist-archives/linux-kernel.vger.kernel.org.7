Return-Path: <linux-kernel+bounces-628662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5651AA60B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 17:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212BA4A807F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 15:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF3920297C;
	Thu,  1 May 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ik23JtSB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D7933C9;
	Thu,  1 May 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746113118; cv=none; b=uLYUmqVxRE3akpnYTdrcMQuRdij6KD3mtgFu+9qxFfN1pTGyEkqVf4iYNNmhvjh9rbI2fLz7sBCjEGN53x2f/0E61P9Kov0IiIIu/qRiaQONqlR0lZ5U/82LMUhc55rNuMcrR8guKEmgHa2YHYBavdVPlj0YEWegB7YYHCG9z5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746113118; c=relaxed/simple;
	bh=loo+Slr2A+pXdv7N1jw+wAJL5btGqCUSbVMFSMoTyKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEH+lKOfqFQ0c1vGuWXGx/nECjTvs5JP4LklcwzDtCJyziVsg+aW3BVfoR6gcTT5TR4fwkk0V8iP1/sYIH0tj0ldH4NXOJCG5+zOd4jGWpSggRErjPxMCZ44RpItR61mcoLDddA9kJ1fS+8cZYnk36jGdUuJmvYixHv0moxydvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ik23JtSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD940C4CEE3;
	Thu,  1 May 2025 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746113117;
	bh=loo+Slr2A+pXdv7N1jw+wAJL5btGqCUSbVMFSMoTyKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ik23JtSBwkvFFRZ8PYjE6Sl1GflZbhWiYyqfmWUw90eIlTSRm+fmqNqjB05owIw2D
	 awHP36bC81dog9e9g+t8QU9JfU8t1iRxQRtBeBfUE4TqrYL6rNswHjq8mFTlkBUPz3
	 Y9Tf6xnvTJRWbb+m1YxFBjppvs8aByIJ27ilES9TyPSy6IJcLfvdlcKh93oMnpisgs
	 nc0xei3cfwZkxp3yEvcYPF2X/3mleXUrVVg+AFaXMso74VDJ2PrzbE3+j+oSBch0IS
	 iZxW05NKmLcWXCgiXDM8PZsdLipCXWoiBV14qgrL6c551Ja2iEf7RGMK+px3498rVr
	 cnv8HvwS1x9AA==
Date: Thu, 1 May 2025 16:25:13 +0100
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] strparser: Remove unused __strp_unpause
Message-ID: <20250501152513.GB3339421@horms.kernel.org>
References: <20250501002402.308843-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501002402.308843-1-linux@treblig.org>

On Thu, May 01, 2025 at 01:24:02AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of __strp_unpause() was removed in 2022 by
> commit 84c61fe1a75b ("tls: rx: do not use the standard strparser")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


