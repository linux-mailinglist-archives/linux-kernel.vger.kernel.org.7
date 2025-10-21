Return-Path: <linux-kernel+bounces-863308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBF6BF783A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559555475FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C9F3446A7;
	Tue, 21 Oct 2025 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upolYJBS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4281C3306;
	Tue, 21 Oct 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061970; cv=none; b=T4dzBquzLb5riUKRCPexxwIOF0zNCrLmHb38UxkEGK4X+hhnTsJjWdvZyXsM5ZIV5TpzbwLn3ueZWx0EvD9PzICW6SpkyDCbNDujPlYfyEiE9DZiDugt7OvXDnbf8cb81SxSIzZPYy7tD6NZqVFDK+aSRQZRb451NG3RP/oqE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061970; c=relaxed/simple;
	bh=9P/Lr1X/j2n5O/qlIBo0JOjK9tJma3uiZrl+5Xsi0rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPXUvz3qV2L+z8hCp7PQnenHe/S1r4uAQM6rWEsjq5YkL/oZbTGFDm1sIDPN802dNSUCW/J6WVZBdBD/1VXlYxHS3hDXArSHlZKxY1ZkTu7EQPeChDW4U6vZWORntD1OvP99QeX+ijFfPpR//egj0fjvct7zMScOCSdvHwjt8E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upolYJBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2FCC4CEF1;
	Tue, 21 Oct 2025 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061969;
	bh=9P/Lr1X/j2n5O/qlIBo0JOjK9tJma3uiZrl+5Xsi0rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upolYJBSCVJF+eeYRQIYKE+kpNWegk+mfxlJoVJh7A8sVpoL8S/tOLipzjgM4mrTv
	 CjzKe9FpqbmSInniXQu0/MbsOEUBvpysE+hTSjQWDLTivvqIUCgnkKUgODJpByYQ7a
	 BrlRt6p2HWgRwc3c9ndd6aqLHlAJwvR8UfLai/TbQNIeuTtcRypRJwjsX4bosumTZ0
	 ydGix5IsMZ2INTcHC9f8AD9084OP1U0U3b6fQrHD6o9/1F4w4Av40TWSWT7FwtqxWw
	 i6y8c9Rmi+bK1CFR26tL+KOOfqFNrmAlfJvUTdwq9WTqc/dQ6qqhaIeVF2OMEgNKOp
	 qpKnQ/A4bKJaA==
Date: Tue, 21 Oct 2025 16:52:45 +0100
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: spacemit: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <aPesTcpvIS22R8YT@horms.kernel.org>
References: <aPd0YjO-oP60Lgvj@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPd0YjO-oP60Lgvj@kspp>

On Tue, Oct 21, 2025 at 12:54:10PM +0100, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use regular arrays instead of flexible-array members (they're not
> really needed in this case) in a couple of unions, and fix the
> following warnings:
> 
>       1 drivers/net/ethernet/spacemit/k1_emac.c:122:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>       1 drivers/net/ethernet/spacemit/k1_emac.c:122:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>       1 drivers/net/ethernet/spacemit/k1_emac.c:121:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>       1 drivers/net/ethernet/spacemit/k1_emac.c:121:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks,

I was able to reproduce the above build warnings.
And agree that this patch addresses them.

Reviewed-by: Simon Horman <horms@kernel.org>

