Return-Path: <linux-kernel+bounces-604010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A45FA88F27
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 00:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032983B2910
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 22:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52C11F3D5D;
	Mon, 14 Apr 2025 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eEdtaClR"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53CDDDDC;
	Mon, 14 Apr 2025 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744670135; cv=none; b=LY/L3j5CdBfomVb/7uIFb9Epq2gC4Vc+lnz/BCxKsFy8zgMDZKHZqNkBwuZ5pzf+CHI0rarboqhcFDP9g0uJqSvV3frezTVJj0h65Sob443K+r3HDjUWMpf2TiacakdxNoisqCzIUiXxtNZhSi+rI193dI7U0jSuJia4hMTATgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744670135; c=relaxed/simple;
	bh=/XGmdNiibWO2IHTa0LRzfz9FUyqaG49cAYuyxNtUi+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYQknYmp4YG6gkuRuKsNckDYrePt3EHaH4eyw4LBYsFe8YJfahNftJ43PsuhFXaTBYB/0FZdhMXAYe2YUgWNMDZ42lnEgkaF01t0TbbKz/86d7Z0Fa6th+5XyKAK4AJ2VBSGy+j1V4gmkTsMxeShzZUckvtdCY2KhTAdHo5lpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eEdtaClR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z5ZWyMJeDSIku+/c7EXs/sv1y4i2/yGsW907J4qohhk=; b=eEdtaClR7lRron5CCMPxujJHLu
	ZYnOZzRN7CPrH58dK59aLUEfAUTRHzyEcgi3SfOGOcbjzTh+QuoZWpakuj/YFPj8tG+qsif9LsGUV
	2B47IL4Z3Knpkl3kxU6OVd2JuhkWRU1dRzdEscYoN5pyXCHB5TJnj8asZ2BE+f8c/w6g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4SOi-009I5g-Ox; Tue, 15 Apr 2025 00:35:24 +0200
Date: Tue, 15 Apr 2025 00:35:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Qasim Ijaz <qasdev00@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] ref_tracker: add a top level debugfs directory for
 ref_tracker
Message-ID: <a6f00284-adfb-4589-a0fd-2c0ef13545ee@lunn.ch>
References: <20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org>
 <20250414-reftrack-dbgfs-v1-1-f03585832203@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414-reftrack-dbgfs-v1-1-f03585832203@kernel.org>

> +static int __init ref_tracker_debug_init(void)
> +{
> +	ref_tracker_debug_dir = debugfs_create_dir("ref_tracker", NULL);
> +	if (IS_ERR(ref_tracker_debug_dir)) {

I'm pretty sure GregKH will tell you not to check the return
code. Nothing bad should happen. Yes, it takes a while to get used to
this, but that is the way debugfs is designed.

> +		pr_warn("ref_tracker: unable to create debugfs ref_tracker directory: %pe\n",
> +			ref_tracker_debug_dir);
> +		ref_tracker_debug_dir = NULL;

No need for this. All debugfs_ functions are happy to accept an err
pointer and do a NOP.

	Andrew

