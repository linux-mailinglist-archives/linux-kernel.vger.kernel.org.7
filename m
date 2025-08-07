Return-Path: <linux-kernel+bounces-759455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8582CB1DDBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78C21AA56FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C9D230BE1;
	Thu,  7 Aug 2025 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyRkxmN1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE321D011;
	Thu,  7 Aug 2025 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596734; cv=none; b=YRy7i9VCj8+2NN5k8Do6tpVq6ALq36C2bMIWbUMINV5jm1f0RNKGKgO0pLKIfBltbeMVGvNsib8H3+SseFHEYVeZu/1P79PwmqncyBmKhz088xXXzDOf4ICrXdsBDOMNuhaYUB6rAlPGJD3IvgDCmSti1cHSaQiG5W1fPvKLqxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596734; c=relaxed/simple;
	bh=jB1BO9WI/0NYrj6GtQegTLC+QGQMiWCE42SUtjzBXbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8NS3UzHZ/4cWA3gw5VkSVbmeHeLITE6XBqSkYTQrll8ll+qqq8ZqmOMx+pQtH+WjRLuceaM6qSRuBCQ8yQ/4kVGpYaTPAQ83amf5d47ZJDV67mW5UV7W9QGtDFDjOFjCqWiR8SlSq5KDK1bC+MlwUDnK5pKJ8PB7Fe/Larh+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyRkxmN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148F0C4CEEB;
	Thu,  7 Aug 2025 19:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754596733;
	bh=jB1BO9WI/0NYrj6GtQegTLC+QGQMiWCE42SUtjzBXbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IyRkxmN1OYdrl2GGb9NUlTEYqBX8jdJNSaLUFYvcxTYcJIirOPYt0LrmxaCWQPG83
	 PMquECB3oJbz8B0Wat7wJS70Ubs01Lk/HVGwAgXFgsYhIgH0ImlIWmaJ4yWrcWFsqi
	 /oX4ObkufWaH2TNbjWAgsW4pkuRkzJdxaqAd95A0mduMad+SAsgmzakrSzMgD6wlze
	 rnfT98cQfC+Ufx4yimw5cZlSvKiMrMS+2oPMosBti6+Z0BZpuqDZjdid4zUF40uktV
	 V6KBB9uhIZYub/rmePw8Vql26ZMFBGuzna6joRZif+R/BUWeM6DF7+I8ZVVd+MbVjT
	 qeyLvvd4oLZfw==
Date: Thu, 7 Aug 2025 20:58:49 +0100
From: Simon Horman <horms@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	"open list:CAVIUM LIQUIDIO NETWORK DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ethernet: liquidio: Remove unnecessary memset
Message-ID: <20250807195849.GQ61519@horms.kernel.org>
References: <20250807124055.495489-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807124055.495489-1-liaoyuanhong@vivo.com>

On Thu, Aug 07, 2025 at 08:40:53PM +0800, Liao Yuanhong wrote:
> vzalloc_node() or vzalloc() has already been initialized to full 0 space,
> there is no need to use memset() to initialize again.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Looking over git, it seems that the last non-trivial change this driver
received was the following in 2018.

8bf6edcd96fc ("liquidio: Removed droq lock")

And moreover this driver is marked as Oprhaned.

So I would say that the churn of cleanup patches outweighs any benefit
to this driver. Let's leave it be.

-- 
pw-bot: cr

