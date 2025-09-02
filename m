Return-Path: <linux-kernel+bounces-796482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE55B40130
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFFE1B28482
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A772C15AC;
	Tue,  2 Sep 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG4bJ7HE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099F17A306
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817369; cv=none; b=M7kFSRMY56Bd2NSpZzu1XfBo8MPTvINfhNHpE5iB+5EdTtdhMAbxp45km0hLcJzm2imQ97PmvSeTCltEIFat42VSLkl2eu0wEuZG7r5b+snLTNadKqB5aiE1UbCAA8zw6v9hnrER3Ao0GFgAMeukSi5ucC/wnFhGeVpWJLCCf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817369; c=relaxed/simple;
	bh=EMB2T5DafQl3006WrGmts6TrJuWyhS9XIdiD6sebMx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vv8JT8Oiqh3tCbQT7KfEccLWXip9drDeacjFZ3iMxYdE6hWJZpnao5EX8J5bJOs7AebmH0vj8IZARKcVsG6STb9+7/D0e/lOCSGO/8OguKhOZxdHBc/edOw0M0cKOBKTy0d5yqIXvgWofmf7ineO4ShE6klJpGtkNSaSAErSyfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG4bJ7HE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C045BC4CEF4;
	Tue,  2 Sep 2025 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756817368;
	bh=EMB2T5DafQl3006WrGmts6TrJuWyhS9XIdiD6sebMx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KG4bJ7HEGPmFMMWKkXK+2g45j8kML/9k8d5OnIqDFblKLw7H9deOBC3DcHju32WQr
	 miVwv73YXioiMir3HcA0eNP+y1iPFtilO5fUjUQ99e93GDgcxiECUXhqJQI7JagTbZ
	 T/ahPr3kxjha1jMBUgCrUDE93QpBK7bnZ0nbXhIMP2nPHFjv4jqUfMFbKrTXJD8zRT
	 m+GKvczE52qSBXGURGGTi8Ls10VEX8PuF0/YqIN1uzNhRKxW7ZBoM4ZCB0Y+0EXpdM
	 Twnsi4hTtlceBUnaXwjWwv9v/kOrOm3S8MyNE3HG45zL4JCDBFbqvxtyXA1Bgd6hdf
	 AXvYG9Wh53UYg==
Date: Tue, 2 Sep 2025 15:49:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: Re: [PATCH] driver core: auxiliary bus: Optimize auxiliary_match_id()
Message-ID: <20250902124923.GG10073@unreal>
References: <20250902-fix_auxbus-v1-1-9ba6d8aff027@oss.qualcomm.com>
 <2025090222-darn-tweet-739c@gregkh>
 <f01e5ce0-6e23-4d1e-bd3a-b4e18bb3286b@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f01e5ce0-6e23-4d1e-bd3a-b4e18bb3286b@icloud.com>

On Tue, Sep 02, 2025 at 08:42:24PM +0800, Zijun Hu wrote:
> On 2025/9/2 20:20, Greg Kroah-Hartman wrote:
> > On Tue, Sep 02, 2025 at 08:05:32PM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <zijun.hu@oss.qualcomm.com>
> >>
> >> Variable @match_size is fixed in auxiliary_match_id().
> >>
> >> Optimize the function by moving the logic calculating the variable
> >> out of the for loop.
> > Optimize it how?  Does this actually result in a difference somehow, if
> > so, what?
> > 
> 
> auxiliary_match_id() repeatedly calculates variable @match_size in the
> for loop. however, the variable is fixed actually. so it is enough to
> calculate the variable once.
> 
> Optimize it by moving the logic calculating the variable out of the for
> loop, and it result in:
> 
> 1) calculate the variable once instead of repeatedly.
> 2) it will return as early as possible if device name is unexpected,
> namely, (@p == NULL).
> 
> so this fix will improve performance.

While the proposed change is valid, it is not a fix and unlikely give
any performance benefits too. First, smart compilers should optimize this
code and perform single calculation instead in the loop and second the
result will be in cache anyway.

Thanks

> 
> > Please be specific.
> 
> will give more commit message in v2.
> 
> thanks

