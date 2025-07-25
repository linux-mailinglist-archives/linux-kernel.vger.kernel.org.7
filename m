Return-Path: <linux-kernel+bounces-746022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67309B12202
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787E81892455
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8049D2EF291;
	Fri, 25 Jul 2025 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+jZQ1Ih"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8451C5D44;
	Fri, 25 Jul 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460893; cv=none; b=TMe8RuauQIipkjeACJ9kzoH+AOYHG/LigIY9ao0A2VFer+Z6nAxPK5EYXGs+aXJ6uLY/b3SJ/8340hn8pLGN67zcZfVyL+TGg8UuLD48h5z0kuu+jBb4usrCI/KF7LKEZW/pxw9PvVG5YimF6xNxQTSIXQyb3hqjg89+M29CpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460893; c=relaxed/simple;
	bh=w29K9r8yaMUigBvQHZUSSKxxwFzlcVcY/Lc5OPjGzGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrXjS4gKP+KiFR0+Tqq4C8BJPLyOZ4GF66YixWhjyUzbUFUrO+/jfOzVKZkIdk/tpCIbs4uh1O7Fv2rHuiAEf/rhq2QM34jhd2RViTDeh6rclNN3kBuNHUF79bGJBC4QWsxLuzhMnYMpFzyn1Vg6358is3ayaeBYKTPKBRStcco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+jZQ1Ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01B8C4CEE7;
	Fri, 25 Jul 2025 16:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753460892;
	bh=w29K9r8yaMUigBvQHZUSSKxxwFzlcVcY/Lc5OPjGzGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+jZQ1Ihokb90254LTCJxfz1/RjnUKcwJxAnF0/oaFooA7p4hZXjOrqyg0kD3nwPS
	 hBCOlZf9EaFHXuefETDuuEzITyiDWoLE6m1+uGQVf7cgkQIY33VHsBKQtYLQ+Xspq6
	 9sRBam5vVRcMNiinRiNHk4v4GmsJpILwuCirTT+JsurLAnttYr+n3uvrHY+DvQBSfo
	 jcEFzHhQqmumGynUTW3mkpu5uOcGRP+U62y1QIMUFEYeqxYSTD4MwUNrQoI4Sa9zHQ
	 1O0mWDIccZMsazeQzuwmcLIfmjeUafcxiXDE+HkPPTOm8i4/8oEmoXThYw5RoNf4AW
	 MJV9i1IhtfhFQ==
Date: Fri, 25 Jul 2025 17:28:08 +0100
From: Simon Horman <horms@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] net: Fix typos
Message-ID: <20250725162808.GG1367887@horms.kernel.org>
References: <20250723201528.2908218-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723201528.2908218-1-helgaas@kernel.org>

On Wed, Jul 23, 2025 at 03:15:05PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos in comments and error messages.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I was able to review this in a way that made sense to me using
git diff --word-diff

The changes look good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

