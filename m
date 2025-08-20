Return-Path: <linux-kernel+bounces-778333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C5FB2E441
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163F85C6AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4159C261B81;
	Wed, 20 Aug 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/QdQHi1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DC372634
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711881; cv=none; b=bHQF6BjgP7btEyRWVOce0L6bxPlXyHASYrhuwBjB4dm+cUXMMEidNgj1q+QZlbhYg4jyAgyWv9EseKlhlHT+AWFSnRoJSa5WGvc7TSIw41xSIHDElXyP16af4VAdY2Lg+kgDIkwDM/B8hxAHNKFPL8SrIj0XU8kI3IJw5FPhCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711881; c=relaxed/simple;
	bh=OuwMD01vwGnn8S744iD11gw41Q7InIVrJolg3lPlQS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INvqWdyuqbsd82TCAdovpFIj4CgKyA4n7ReBBQyZvKbUj1dEdQnaHU5WK9NK8MkBksZAXjDDnfWHbRFNPoazCJclqKjzjFai1t+d5OGsNMlXIukZ55bM5bLUG+IcoDZhfQLJLKhfQaB8oAUDinSIxmk3DLQ8js6QIDZjx5Jri8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/QdQHi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35D1C113CF;
	Wed, 20 Aug 2025 17:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755711880;
	bh=OuwMD01vwGnn8S744iD11gw41Q7InIVrJolg3lPlQS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l/QdQHi1ke8bbF4UY1epgxkbN2tghghXqnCWYKQQKOoLBBdubXMUFNvA6BlMpOfuR
	 Rnrnh3SAlL3mgaEWNjc5W/jmhQAyT5RpgGlGD5nQhqJ+K+U9cnR+w3/1jMqgRsc+6+
	 zWT6FFxviit9J3/W3iY3YLfxxtP9u+IVzlEWGHq7PV7vhm4ribK+erkyFN6qkERd36
	 cuYREuwdzpyPl4+0PNnU9LyQ6/6lwR4uWRCx0MP7RBXbepSohda54UlpP+eC/JulTi
	 XlmZ1aCIAF1VbayGQnuPZM0utceCx6ZrHoJjZscOfaYCIb47OBKZbyTHzXGK/L9CBy
	 P1UkaLNI/5QLw==
Date: Wed, 20 Aug 2025 17:44:38 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: "mason.zhang" <masonzhang.linuxer@gmail.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: fix CURSEG_HOT_DATA left space check
Message-ID: <aKYJhtJRuszUhj37@google.com>
References: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
 <cd82a673-aa43-46bc-be67-6924500376ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd82a673-aa43-46bc-be67-6924500376ef@kernel.org>

On 08/20, Chao Yu wrote:
> On 8/6/25 20:32, mason.zhang wrote:
> > This fix combines the space check for data_blocks and dent_blocks when
> > verifying HOT_DATA segment capacity, preventing potential insufficient
> > space issues during checkpoint.
> > 
> > Fixes: bf34c93d2645 ("f2fs: check curseg space before foreground GC")
> > Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
> 
> It breaks f2fs/005 of xfstests, can you please take a look?

Ah, this was why I got failure. I'll drop this first.

> 
> Thanks,
> 
> > ---
> >  fs/f2fs/segment.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index db619fd2f51a..d8dae0049b6a 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -649,7 +649,7 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
> >  				get_ckpt_valid_blocks(sbi, segno, true);
> >  	}
> >  
> > -	if (dent_blocks > left_blocks)
> > +	if (dent_blocks + data_blocks > left_blocks)
> >  		return false;
> >  	return true;
> >  }
> 

