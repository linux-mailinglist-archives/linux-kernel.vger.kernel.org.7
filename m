Return-Path: <linux-kernel+bounces-844187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45354BC1413
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9EE3BE478
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296912DC77E;
	Tue,  7 Oct 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="V7qlyaji"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF439FD9
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837613; cv=none; b=OQJZq33sjKFQw1uuxfMhcCAaTUU7Q13pkg1twHi57+SrDDToBSy5//2KfOSmqs+VNb8jE80kX7E1YeNswhBmZCz4DI5rDGUkx843RBwevzP17S0TGv3N90LbMY5XQ/8BvzkuAnO22p5xgmzDhjzdvYaVSxQi/1PJ/p7SNILh1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837613; c=relaxed/simple;
	bh=pnVBgJa5KzXfg9wYzLu70jdwZgFd2XmiiE+but93An0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StPYCiDQiC5OIt6XQn1eWtiB3QSKjZIBOdI/XDiobuem+jjcRKCeqrBEkZ2mpOdb/6C9tK0ohPXjjGuv7SgyzyZ5AviG0ddR3gOUzd/YW+9Q09d77TWBTRsMNrguW3vv728icWMkIr+DG/P6HiLFLZulUGCFccXBZ3YOYxEF2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=V7qlyaji; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-43fb60c5f75so981504b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1759837611; x=1760442411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbRRcOj1nqIqPJK13rY453aAP4zXT3vzbj3Cks+QjB4=;
        b=V7qlyaji20uvx4HriOJEzNG7tZV6M77BfxL/DeLc+W+YBZrDYKnf9wCW20quo+nS7+
         dM1OWlvpPfdFp02jSpXc8Aid8VyXjB9+auoNyqeJ88UotvQqcjedZcO8pnBN/NA3n3QO
         i6v/1INQmQdBhrqulKFPMi+eoL9P1eDw36zAhHl8u3UV2DyQQR5BvwwL/T2MAMcjx3nP
         o+prdVRNbhBcBlM7t+lFZLC7DpipdUGjJ9mCfi33FN+KEc6koUYcqDtXVf4vSg2TOZsS
         jzl7MeGDiUpge/GiR/sb3s2JW8VAjgTHP9H31ECAJTvOJ3tUNIXIiIm6kr2Bsiu3nWyF
         F9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759837611; x=1760442411;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbRRcOj1nqIqPJK13rY453aAP4zXT3vzbj3Cks+QjB4=;
        b=wUMJztSBDP3aTWnI/12Vi9u48qZcZvI9UdmNy8s7BiFNatFB3wrg2vVq4n50S7tNhr
         hUuYUoOLz7eNyvoaWzkLw+1H1N1IHL/SQ1LYd8ADnAKa7r0qqX/0QZ/n+ciQuekWPOuA
         BrhIhxXH+lrL6hL8msnRhmfGRdmnpAZ8/KaocXupe/UWrvZNUIS4B/J7qCWX/S2nUjBV
         uCp2vGbJwih4NG3XvcAHqUCP+3m9X9IUWijJJSr7V4bCprAzUNvNjB3KRRab0Sz2kLWT
         0ghKN+rj66j7GDzG/VycQjSLo71U7GeLBDoaw0UGNkT4HLCl8lYWbZNqPvOF54/rz4Wd
         t95Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/8L1Hd5yUR37+eNrEiiOxcYUCbejMU5/1jm7+zGs4umPyUlk/nxOziQSdXxc3AY405jFiL/ab5hBGbA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsbLdYXpyweQoX21GYBm93/Dx5Tu8U7Ge7FxMt+GSHFAoaCyrC
	ky6PuFD6RPqebP7j3BuWQ8yLWGmAq8gflqdhEExid6FcR95L5BTakTjTvzRrLZpRyB0=
X-Gm-Gg: ASbGncvDFm2vz+ZDuXN0mzoWHXvpLvLuuPT3wIeJ3BDivfxMWBOb9DddGZsaSy7RIGY
	rW/JLqAUZwQjYZCmouw2/nHc7xIAUiUHN97TkAzh+r1DWcd115KUmAeQ4bj/7JL/3vYU3pcu477
	K+nLAynMBIG9RRHcyaI1+qhnCUfScwuAmuPj3Ihjc2maNoHISVQSLemZD2jexs3lN4rP2cDwFZV
	XuunBhhgfu3fgfel00jfMSTQonRB3qS2XP477hfT0o5Zm+kYESv4BTAoPA117hWNwxcKKAnJTUJ
	j5xpriPZc61SfjrXkT1d/WKsZUX28c16NDSuYC4pP+kGW/U0vhhXO5W88NBLQ0WUlAoVD3a88zp
	pQbxK6M03cxRDWd9lAS3MFD4jlva+ofBHeAaIU6H0A6v7TtWGfw==
X-Google-Smtp-Source: AGHT+IEbnElK0cs1/OpdY6EalgLuet0IqHCzk7jU16XFrsS/LpBSpxDz65Oh4Sj8sYpV1NQZHV0mdQ==
X-Received: by 2002:a05:6808:22a6:b0:43f:42d4:acd2 with SMTP id 5614622812f47-43fc18a28d0mr7966900b6e.51.1759837610919;
        Tue, 07 Oct 2025 04:46:50 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:52ef:e8e2:6979:b8d1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43fb24146a9sm3527847b6e.1.2025.10.07.04.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:46:49 -0700 (PDT)
Date: Tue, 7 Oct 2025 06:46:43 -0500
From: Corey Minyard <corey@minyard.net>
To: Guenter Roeck <linux@roeck-us.net>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH] ipmi: Fix handling of messages with provided receive
 message pointer
Message-ID: <aOT9o-IkilgQXktF@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20251006201857.3433837-1-linux@roeck-us.net>
 <aOT9c1ULJolUHPSA@mail.minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOT9c1ULJolUHPSA@mail.minyard.net>

On Tue, Oct 07, 2025 at 06:46:01AM -0500, Corey Minyard wrote:
> On Mon, Oct 06, 2025 at 01:18:57PM -0700, Guenter Roeck wrote:
> > Prior to commit b52da4054ee0 ("ipmi: Rework user message limit handling"),
> > i_ipmi_request() used to increase the user reference counter if the receive
> > message is provided by the caller of IPMI API functions. This is no longer
> > the case. However, ipmi_free_recv_msg() is still called and decreases the
> > reference counter. This results in the reference counter reaching zero,
> > the user data pointer is released, and all kinds of interesting crashes are
> > seen.
> > 
> > Fix the problem by increasing user reference counter if the receive message
> > has been provided by the caller.
> 
> Yes, the only interface that uses this that would matter is the watchdog
> timer, which my tests don't currently cover.  I guess I need to add some
> tests.
> 
> Sorry, and thanks for the fix.  It's queued for next release.

Sorry, it's queued for this release, 6.18.  I'll send it to Linus
in a few days.

-corey

> 
> -corey
> 
> > 
> > Fixes: b52da4054ee0 ("ipmi: Rework user message limit handling")
> > Reported-by: Eric Dumazet <edumazet@google.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Greg Thelen <gthelen@google.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/char/ipmi/ipmi_msghandler.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> > index a0b67a35a5f0..3700ab4eba3e 100644
> > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > @@ -2301,8 +2301,11 @@ static int i_ipmi_request(struct ipmi_user     *user,
> >  	if (supplied_recv) {
> >  		recv_msg = supplied_recv;
> >  		recv_msg->user = user;
> > -		if (user)
> > +		if (user) {
> >  			atomic_inc(&user->nr_msgs);
> > +			/* The put happens when the message is freed. */
> > +			kref_get(&user->refcount);
> > +		}
> >  	} else {
> >  		recv_msg = ipmi_alloc_recv_msg(user);
> >  		if (IS_ERR(recv_msg))
> > -- 
> > 2.45.2
> > 

