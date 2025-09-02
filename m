Return-Path: <linux-kernel+bounces-796490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9C8B40149
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE043AD723
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021512D131A;
	Tue,  2 Sep 2025 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AAXOYCF4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55416296BA5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817516; cv=none; b=DN2hhf5VjWP7OboQ9PGied8XyGSSLO89N2L6uPBNMl5yL3fYFfRXigm+2P0rE/HOw/UPUhuRG/2jikr4Tuht0RMywABFfLvr8TiFEwY0tIxLYi/SY3Vp6y9gvbQBgJ0tklw3Cjk/NCNbjPnADh35TS87c+VB4J5LHTTNxA+c5pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817516; c=relaxed/simple;
	bh=un0az21HkeHI3rQY+acypSnqv1nLRERdFUiVCqJ8TfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbcNO6xwmf/aNSUeaMvKU7siJcxWr64YR2sosl5q13a6aTro8JCjXxMJyMXCZy+wSlkf3XJodpmkDEZ7AzqHG1bfONh68K0ASwILEA8C3LVSWMq/bFNeSv4KUBRkw8MzS3JXXVkxUdjG/S94iKQe7/ikI3bmTz0YAhK9lPG4rek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AAXOYCF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9D9C4CEED;
	Tue,  2 Sep 2025 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756817515;
	bh=un0az21HkeHI3rQY+acypSnqv1nLRERdFUiVCqJ8TfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAXOYCF4xQsvDjHSCB+PCCnDVZ6VEL/et/4u+2i92SE0zeeuq0ErSCl8kOCuFGuaR
	 pwtBMlPXthNYIJ8FlfF2SW5zJdC70baDpwJMt1129JQ8A5ys1rQKChbVU3y2Ynb2hQ
	 FAAYnx4zcck+oH7VxJBwSuoiVajLSuq6md64rmoA=
Date: Tue, 2 Sep 2025 14:51:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: Re: [PATCH] driver core: auxiliary bus: Optimize auxiliary_match_id()
Message-ID: <2025090209-unlinked-remedial-555e@gregkh>
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

This isn't a "performant" path at all, is it?

I'm not disagreeing that calculating this all the time is a bad idea,
but please be reasonable.  If it can't be measured, you can't really say
it will "improve performance" :)

thanks,

greg k-h

