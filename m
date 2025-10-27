Return-Path: <linux-kernel+bounces-870841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD77BC0BD17
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB75E4E4B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6442D5410;
	Mon, 27 Oct 2025 05:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BgtQPv99"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9035C267386
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761542863; cv=none; b=D0e2vD6HQYRb+v9BklfvBC6+Rh0JlZsvq3kijkcFo0gystR3fPqJ38RJ9jxddvlbkdMujGDyfnl80BwezcxyvLHXkNawBzTtXJCbCFxuh1kl1HHKe67T7g8xYkU8AG5LUf/M6gnjk7nR+dFSUZ/1oU1AOoJEykHaidgGg6F6ZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761542863; c=relaxed/simple;
	bh=qh79cjfHvrOLCxvcq4oI/lS6q5OmL9Fn6ODduBM4yG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vxopun2zHmbJKvyCa0ERto+h7FNPH0KbSXqeOJ0hT8vvdVaukd/qCRe4+T2ZoyZuPq/BcOs7w2LnN07h4GPJ1yot/Bx4ObVyJKN+ftpkmM4/LFr7ye1xkPVLP8qm3ZJ7em38iFsiOdCH3cpWP0uuP7prVRrWdKxGYHaP5dsJ1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BgtQPv99; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso2005826f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 22:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761542859; x=1762147659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMQm/qKPeH1g9CIR6f10NMelAH+jy5bqtx5lzdYvSPI=;
        b=BgtQPv991ykr+JyI16mc3aazZKz2nKl6PYyuef43uLMaE9Lcyrf+UABekbyHVgC7f5
         H0lwbIbmFVFp/s4rGvsSOqeFSftOIlbzlLmpQRZurbiYMW2nBMawSBIVf84QV0IW4FVI
         C/IPOxPeG5VGoL4KPUp6EHkINw2cOCGTB+vT0DG+fhh1oSVGrAVIq/cvqJwWeTvSc6o3
         zySvJcNWYa1D7S6xnvfR7UZ1MWCr/2xB6UODCDHdBdLx5ynu+i0tpKuu9KZBhGuGv4hl
         uwdVR7BMMXuI3+cbDwTxS0ml/w42LF8meAZuIVu0wFmTTUajmOi9Lc98fN8G9glhuKBJ
         S8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761542859; x=1762147659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMQm/qKPeH1g9CIR6f10NMelAH+jy5bqtx5lzdYvSPI=;
        b=luyD8bXEXFTMdqe7Ls6jBvkcNsxZfjjvPeOhuVnn6nRuWOU/YTcRpkW4jLrZ0XbvRq
         sJOhUMmXV6JckeafPfUUi+UGNrY6aGDdCDz7P9CBTLPA/5GVLoGHUS3Sjl7pTYY24hD3
         bqDOOU2cX4Nqpy38zgu+QhVbPYbOSsanzNDcAHt1n74zpZKXFnp81VRHUI0C4ijv5I3M
         KvrwgFlLE1JAOqlqGZOQAm5pg8/QbTMpD4Gc/hEk2U/ei80XnzMDocDMx58R+/KLWaDg
         9zZXLjo2QwQX4AMRstqVUm54J6mlgydFl+M21JI36Iglbi8bLalz2bJbNC5tU3Edw/5y
         ojmw==
X-Forwarded-Encrypted: i=1; AJvYcCV2eWTkXjzW0tAArOJohI3tvuF6cOMYKm+vRLkTorBQSP0I6XjzTZ8EaIpSMKqf7M1ub1OyQM6+1fvK7Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3szogLimDi/r2xIeq4HNdnI/sSsKJPAG318ouJddVNG1XtW9x
	EPhHT4CMoji/rRvLaLy+5T15Z10rr3F9WJZx1Dk9Is59IuPhuZ87ImabVKDDY8xxHZg=
X-Gm-Gg: ASbGnctbKxsZrm6EPsL21XcvtJ8oiY6283+vSsGyW/knDs3vKr77akENWfCPtTokTxl
	hSmm0rDtz+oYE2ZBh4g9gKnPCoGvJ3mnqj/EPN0NydynuL3986BZD5m87s1VFartqfpEzTT8ldu
	jidYnuEU2BSU8O4M4Yi5IBuBNI970csESn5FnJ76CeZsImlsXIzprcs1jnjwy+CpWPyi/59sh7l
	noK34wL8y86EXnncgIUTDNT8NL3safkqj9SgY6Lb/ETZajKYTMsbfTLo50+jKGVM/3Wv5JTuWOm
	PreHCaT4bzCiaSiFh/SRfpC4n4VBN/axSgAjGWH3Fr6LB2FQRtOumpbOVps+D/KdhchaDEY3dp7
	XM6V/qPkbB1kdgYMn83FVuh4R+NBE6O6qgKRu9oth2CArSgiEANcs0SKJPYECvChatxr8Cibbxc
	Q5f+2LjdRoznIoVJeyv3kPFoPNOaM=
X-Google-Smtp-Source: AGHT+IGGMWIW5dTfslm/6ukE4iyqbFwa7B8xtQ/z5FIOwZZue/OCt475nBYcheMy53fO8smuBJDifQ==
X-Received: by 2002:a05:6000:2c0b:b0:427:84a:6dc9 with SMTP id ffacd0b85a97d-427084a6ff0mr24497662f8f.59.1761542858724;
        Sun, 26 Oct 2025 22:27:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952b7b43sm12237102f8f.6.2025.10.26.22.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 22:27:38 -0700 (PDT)
Date: Mon, 27 Oct 2025 08:27:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ally heev <allyheev@gmail.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hunter <david.hunter.linux@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Subject: Re: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
Message-ID: <aP8CxkXYAitKB3vx@stanley.mountain>
References: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
 <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
 <aPvAm1E7CvQfOIuS@stanley.mountain>
 <81e6af8eea5b0399d1685797d0ea6a6ebc273270.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81e6af8eea5b0399d1685797d0ea6a6ebc273270.camel@gmail.com>

On Sat, Oct 25, 2025 at 11:53:56AM +0530, ally heev wrote:
> On Fri, 2025-10-24 at 21:08 +0300, Dan Carpenter wrote:
> > On Fri, Oct 24, 2025 at 10:59:16PM +0530, Ally Heev wrote:
> > > pointers with __free attribute initialized to NULL
> > > pose potential cleanup issues [1] when a function uses
> > > interdependent variables with cleanup attributes
> > > 
> > > Link: https://docs.kernel.org/core-api/cleanup.html [1]
> > > Link: https://lore.kernel.org/all/68f7b830ec21a_10e910070@dwillia2-mobl4.notmuch/
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ally Heev <allyheev@gmail.com>
> > > ---
> > 
> > I don't think this patch is a good idea...  There are two issues to
> > consider 1) The absolute number over warnings.  500+ is too high.
> > 2) The ratio of bugs to false positives and we don't have any data on
> > that but I bet it's low.  It needs to be at least 5%.  For anything
> > lower than that, you're better off just reviewing code at random
> > instead of looking through warnings.
> > 
> > regards,
> > dan carpenter
> 
> makes sense
> 
> General question about the process for my understanding:
> Is checkpatch run on full tree by CI or someone and results reported
> regularly ?

Newbies run it regularly.  Otherwise it gets run on subsystem CIs and
the zero-day bot runs it on new patches but it will report the old
warnings as well under the "Old warnings" section.

> My understanding was that we would run it only on patches
> before submitting them Or we just run it on full tree before adding
> new checks to understand if they are catching real issues

Eventually someone will look at all the warnings.  And probably it's
going to be a newbie and so we need to be careful with warning where
newbies might introduce bugs with their changes.

regards,
dan carpenter


