Return-Path: <linux-kernel+bounces-808458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC30B4FFF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A185E3808
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F19341AD2;
	Tue,  9 Sep 2025 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH4+FR/0"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639E341643
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429303; cv=none; b=aK4L3ige40nodXXFXMf1u8tPV0isG/J0kv3Dvt8s3BoJRBpqXp1VZJbiLIjEJ0HxhvWPaI+ABIQLcFWu0pdX4FT2/HlqVchHrjvMhSl1mvBiZB/uCByYt5/MSCie86H+MsV5XcfGPbcD45T9TivYnJklutsvYys0BD+otOvgYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429303; c=relaxed/simple;
	bh=qeFBiCCMd0NN/EaY4Oj44Sbt1RY3NQlb4g0NqAuemFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUPAVLn6SJWXvBNeDPz88DOQSg98eZVJZCEc/qhm6kn1amygB894pYeqA3B9Z/YXGGLTPfwsQIkZwxWTi7gvFQno59ibazAuXdqiUPGKGTAZHmUTmADvUhnylrfiJf3Uo4C+Zs/9eJMhAUGG2feB0ZPvNfXu0BylBdnG6PNbd6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH4+FR/0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so36335475e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757429300; x=1758034100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zbI93laRlNgIRcKRGecsho/v9toZeJCEiFVnSaQwrVA=;
        b=QH4+FR/0HAuMorMdrZV7QgtqwB3l3IC80M6u2/7Swii/NL5QGDSpjnDPZDZhKUPY6d
         RWdFDCCE3x59U8DPgxVhdUKp7IOC0YRHLJamqHkf1MuWGCRx4aShZO/Lk97SH2/OjGTD
         Hq58F6PxSgdNpyHzJ12oYnzZIVvdT7+diwYLef+6QogaZWWQxQSnm1G5F8rglpTy8Dm0
         33LqwtxQ9+WuAVHjwRw6tBF5m9S0NGOst301BFrvoJy3zbUEUgQkzb5OGNJpiDGVQOao
         EFECAB1T3vMx6XDsl0DU+2WuT74EjEYwhy0GqnqEwlbNg1nA5e2Bb80ktiNJtJvA5tQ3
         jVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429300; x=1758034100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbI93laRlNgIRcKRGecsho/v9toZeJCEiFVnSaQwrVA=;
        b=Q4SsWgNs8MSOcYNobMUPJuLoSR5czTQQ9OmUISZytASRV1CsC8VR+T63pIGjLR8YcY
         UMTmRtlm9DI4NqeJhqQG1krsDMNONS0MPqYUYXjqBWkzqTVRmlGM5ZfZaBdWuzUtHF0O
         L84IbuxrIseakfO8wMwyl/9sXAtrx30cxhzsjTOSpah9WAFO6D9JBQECESYyXbh3kFGG
         1VBZi3fIzYeFVMiC4lcVH+53PnCXk4aABZ+rqA42TXNMnVGA++THkAbHD0Jm08GfLprF
         nIGMz4J4Ww5qm4tY9IlMp2iQdf2Z5W0ZCTTFd465NmfZHIgUr4XMYB5/QyBPuDPtYBKM
         K90g==
X-Forwarded-Encrypted: i=1; AJvYcCX9YfCXkDpIvpz/2zegoAEGBojlHPNp8Z5BG8SWZ1MS+w1mdXiKM+gAUigZDFtX047X4iG79yeIQ+b2KKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym5kXQYfaMbKDmWM93o0pe4bEIhqBtpweAXVSlXKoXza+ogy91
	i/5Rdlu8SqNp1nVFbEDG/pxQMlpk7Rum3MJx0K0wi7JLOu52oykMucQq
X-Gm-Gg: ASbGncuqm46Pf4O98ywoVQoPO7MAIiI4BSVSsw8q95Ng/uA5hDH2sXXPLOyttacMFXO
	fuBFdw3na9tUTPJce7bbB7YczEQXtD0dsds701YdANKXDAq2qh0iJ+fCDju/uWUfIAOC4kkSxxB
	Xc6167oI+Zo0bnFOT3KELgwKvET9gEZtyBLgxdcPmr1WCpAckhea7v+Reu1ESu0fvUoMy71qLMB
	6jCiVLNueaurHPTDoCbubGYJE+Ipj7EZ0/EpLTPqIULRL9ff4eaPAiSokzamVorxd0CCvwkrAmz
	M7qzcFATEwPyomqbUFrEHHBjTiQwpcsitNn80HSsVjyl0nsXv3Sym52BlIw5L2xKomE55F4Q0Le
	1kyv3WVv0ADL3J1kFZWDdOYln2lNkQKqu5RJ0gw==
X-Google-Smtp-Source: AGHT+IEdh8354eQN9A5Sng+jnPw+cbisVt6PO5x7gvAVRbMfR/z03XAWKcqmiMVY1oeoI3wzWdTYSg==
X-Received: by 2002:a05:600c:1991:b0:45b:5f3d:aa3d with SMTP id 5b1f17b1804b1-45dddeee57cmr95952195e9.21.1757429300065;
        Tue, 09 Sep 2025 07:48:20 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df14dc4e7sm12217285e9.1.2025.09.09.07.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:48:19 -0700 (PDT)
Date: Tue, 9 Sep 2025 16:48:17 +0200
From: Dave Penkler <dpenkler@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: GOPI JEGANATHAN <ggopijeganathan@gmail.com>,
	Michael Rubin <matchstick@neverthere.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Declare processor directive as
 CONFIG_TNT4882
Message-ID: <aMA-MelgO2yaxnUs@egonzo>
References: <20250909041707.3001-1-ggopijeganathan@gmail.com>
 <2025090940-backyard-mud-253a@gregkh>
 <CAGt2Sa+MriEYjPOFGmKWuHXabwkJeWn7q9o8U14B7o3QY4xmyg@mail.gmail.com>
 <2025090945-ecologist-gravel-d028@gregkh>
 <CAGt2Sa+tKAmxspYX=iyihmZYxWg0=xOJPW+J0h=9rTG8E99AAg@mail.gmail.com>
 <2025090945-yearbook-busboy-2b28@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025090945-yearbook-busboy-2b28@gregkh>

On Tue, Sep 09, 2025 at 04:40:08PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 09, 2025 at 07:56:07PM +0530, GOPI JEGANATHAN wrote:
> > Hi Greg
> > 
> > I just saw the warning message in Checkpatch.pl file. It's says #if 0 is
> > something wrong so I just change the processor directives properly using
> > #ifdef CONFIG_TNT4882, Is that change is wrong!?
> 
> #if 0 is a way to comment out code, you just enabled that code to now be
> present.  That's probably not the correct thing for this driver, right?
> The whole thing is already using CONFIG_TNT4882, so declaring it again
> would be the same as just removing the #if 0 line.
> 
> In short, only change this type of thing either by removing the code
> entirely, or figuring out why it's still present and then fixing it up
> to actually be used and remove the #if 0 lines.
> 
> thanks,
> 
> greg k-h

The code in the #if 0 scope in question can be removed entirely.
There is no call to make the driver it into a pnp driver.
cheers,
-dave

