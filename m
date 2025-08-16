Return-Path: <linux-kernel+bounces-772204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82871B28FE0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E6F173DAD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19A91D63E4;
	Sat, 16 Aug 2025 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K9x/O6jT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D7A54918
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755365483; cv=none; b=V37jbdUJR083bTNjt+yPjDPb/BPTkRQMLkBDzm8kYhlm2Cj/+O4hTJdOh3WQ9MDb+07wLMIvPcjFuHNl5gMUiypz/24tNvjeeM7sZmF889SYeMHDJq8i8f6Y4VnStTRCKqDs2xJPffxzdHyp8Ia8FhhExeY3uTYVemNHGPErCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755365483; c=relaxed/simple;
	bh=ZpPmqZhczkPNSF7ccPVPUtsfa/m9V9kfZ5ueEFTu+88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF8kOOod001VJFzT0unQLrbOGaQTFrvFtRMc/oFrfuugIwe6eS2Z6L+9f976Zyjwy6i2plrf9cId3lQlP1hh6htDf7iiErcYD0eaTQwAjXy27t2b23IMLEomXo42nsxZVL6JuONEAd7eHNUlUKkwkgGg3yMbpK7lLXwbIaIhkz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K9x/O6jT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2160C4CEEF;
	Sat, 16 Aug 2025 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755365482;
	bh=ZpPmqZhczkPNSF7ccPVPUtsfa/m9V9kfZ5ueEFTu+88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9x/O6jTr/Jnlrsj+nUQYA2eleM+Sabs6FqykMSKcH6W74JnQLmJSouA6aOjlgnGg
	 18T7s3qkQBtFo3knd2tqA4/GZ7p0LH3gq8eAG7t3ab4RJlbOOiHV1vmdr561+8laD0
	 Tl4CdmJogqlwLcxpdz/sXmxAZygXAy45ZqVe2BPI=
Date: Sat, 16 Aug 2025 19:31:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Todd Kjos <tkjos@google.com>
Cc: Diederik de Haas <didi.debian@cknow.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: RFE: Make ANDROID_BINDER_IPC tristate
Message-ID: <2025081607-crank-expenses-942e@gregkh>
References: <DC3UBQJQJ2SN.3B2AJHOP3933Z@cknow.org>
 <2025081642-viewpoint-exemption-006f@gregkh>
 <DC3V792JTD1J.LB1A657GBFQA@cknow.org>
 <CAHRSSEyxcqydwbEHHLzHKar9AaQAjACFuM0CnBxN5XrvFQdBcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHRSSEyxcqydwbEHHLzHKar9AaQAjACFuM0CnBxN5XrvFQdBcw@mail.gmail.com>

On Sat, Aug 16, 2025 at 09:37:35AM -0700, Todd Kjos wrote:
> This is not feasible since binder relies on many kernel internal functions
> and data that cannot be exported for loadable module. Patches for this have
> been attempted in the past, but soundly rejected. You can see some of that
> discussion at
> https://lore.kernel.org/lkml/20180730143710.14413-1-christian@brauner.io/.

Then how is this working in the Debian kernel?

confused,

greg k-h

