Return-Path: <linux-kernel+bounces-813067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773E0B5405E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC8E7B19D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB811F4161;
	Fri, 12 Sep 2025 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Wfq4yWJ/"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418C14A4CC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644216; cv=none; b=EOH03POHDT+BR6n9+iLGmzPWiAJJ25Gf/2B/FCsYy3ybkBCeeYigxcebEZq3AiWZtrDk/tQLyFaVVkt4xNH0hYJCJYXE4OWDrh2wSaH64QnzToDIwoKknstt0Y0WPz8oHXK4Yaog7lopKZf8pKnY+ujYfya8WVvjIV+Ga1BFBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644216; c=relaxed/simple;
	bh=vQQIU6ckHc2+RvHHnlo2eleJNpXZev81qLhetlXEw2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2CJnfuzkIAkB63I636GzHoZhBiDGboVKsAdujZnMBF6PU6fXJ2C8eiz6RDi3nGNDjjwfef+4C94raAf1O/fljQTJx/sLWUj8+8f3Hs2GMW67ZZLrCTIqdfTjUoRtRfPZyL9OmWc96GOfAeH7CmnID1UmTsFIeBTbpXUD4U1jwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Wfq4yWJ/; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-72374d6a6caso15208336d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1757644214; x=1758249014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bOcBl4BVZOSZI/RGkDZyOTuzjiM4ERqznZpinFtbvyg=;
        b=Wfq4yWJ/5fRvTYXWHplP2tcJqgI4K5WhBq7exprxaW8O9GnbMVmnQ+WyHtXgyGfoZm
         qFaaMQ3X/vTI0zZA/7YyhB6ZxyrqgXvEr495XVxOxW0xNtX/Bh+JDkwP4P+neeOQQiHi
         dXPIgz9l7wEbaiUNqzp+UbdFXOlWSiLmBnjtVwHpkga+6vplDydwiVbt1v323n9qIixg
         /mzQlk81GgqKDqfrYI7Z3150UXzl6iBlAUkgNfY8oO0K/hz9Mf4vGjCd77NKUlo9MFkU
         trZdi5ItiDQeB4+ODoTvYS9SJtB1+4dqL7oyaYH3kSDQcHLFwh0/eNK9g9fviC2SVJZs
         q6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644214; x=1758249014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOcBl4BVZOSZI/RGkDZyOTuzjiM4ERqznZpinFtbvyg=;
        b=RvJXmNE1Ov0PNd/VNfWwFLLDYap4uY9pIy/XOqG9Kmo8eSO7cAqrP/kNX/bhKfkMa/
         UxZHS/2d0ltULvJk6tUhXzi/1KaVTnkv6uhW+xStqMFDKBPsdJ3CXX70SH+YLQA6OaPQ
         TdwSXGmdhsjWCA5aY2sX15cxe4YoDwHfg3q0MY2O9cv1q2ktyEFQR9k1JwlzP4/XmN7s
         0qnu2xlcMjQ3cunyFZwt2e0p2FMLbZbVv3Qselsi8S249wgAsEd9+4D9AnR01X526O/G
         MtrstbyLfYHtrnLHA7HDIkamXthjTZ1HG/TpLWdBcIpFl7hhbokglxczi/pHsyRuQiFA
         1sKw==
X-Forwarded-Encrypted: i=1; AJvYcCWzvsnWqPE/IFRZUv3SjEfrIs2dmO1r6WvmDSMiiEoT5rsdLCZUhf8/kdTtofivszSHPbSYDgW633roHsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOi+/CUJO4sA3mNXfJTiYoOW9efPFtzZbcLl4zC0D5gjJWHxdC
	aV59qkhXtP9im22xC19SYIcfVx81n6C+ozXxmdahGf5b3hn/KEQjjJ9nKKQZv1CXvQ==
X-Gm-Gg: ASbGnctB5fIT1oICJ401SMbmCNmt2exbozrwD8UOg5vyKqbCByxc5F4MObZOXyI+Qtv
	LKir91YijZJP2WjgyclILW6oJ5kbIcR3OnAjQnjIb08pfWRUSJAX6YwemEqJ5fT3FrNjate3xk8
	gxNLyPpzxwhy3UX3enAzfK7dtHDexZ42PFsNrx+umDJW7CMvlmWlteJgDyYx85NvtXvLTCrY80W
	Zm6NntIkTcusowXR6vXPXk51F+qF+pVo0DdsvfrLkFGUqqQIpxM8hiQj1qVaEzNoor9Ed1Xng6t
	K39i2yt4h07DbNxkCsTxBM/zmWfB1jeKrgXeO3HH5ObvSfgYU26pRVVCbKBvP92KmIb2lZjUd9w
	Np+/F9T8V4oCVN9md1/Wla5MGt4fvHCMiU7s=
X-Google-Smtp-Source: AGHT+IF3YJcN8fftkWAXBvp5e8ChiQTwvDs2PYP+e/p5pRC3qGnSYo/pJ7OVH35ncvR4Bc8YEDrv+A==
X-Received: by 2002:a05:6214:230c:b0:70d:b2cb:d015 with SMTP id 6a1803df08f44-767c88fae6bmr22357036d6.67.1757644213876;
        Thu, 11 Sep 2025 19:30:13 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::6aa9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763bdd3773bsm19545826d6.36.2025.09.11.19.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:30:13 -0700 (PDT)
Date: Thu, 11 Sep 2025 22:30:09 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <22773d93-cbad-41c5-9e79-4d7f6b9e5ec0@rowland.harvard.edu>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
 <CGME20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94@eucas1p2.samsung.com>
 <b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com>
 <aMLfGPIpWKwZszrY@shell.armlinux.org.uk>
 <20250911075513.1d90f8b0@kernel.org>
 <aMM1K_bkk4clt5WD@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMM1K_bkk4clt5WD@shell.armlinux.org.uk>

On Thu, Sep 11, 2025 at 09:46:35PM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 11, 2025 at 07:55:13AM -0700, Jakub Kicinski wrote:
> > We keep having issues with rtnl_lock taken from resume.
> > Honestly, I'm not sure anyone has found a good solution, yet.
> > Mostly people just don't implement runtime PM.
> > 
> > If we were able to pass optional context to suspend/resume
> > we could implement conditional locking. We'd lose a lot of
> > self-respect but it'd make fixing such bugs easier..
> 
> Normal drivers have the option of separate callbacks for runtime PM
> vs system suspend/resume states. It seems USB doesn't, just munging
> everything into one pair of suspend and resume ops without any way
> of telling them apart. I suggest that is part of the problem here.
> 
> However, I'm not a USB expert, so...

The USB subsystem uses only one pair of callbacks for suspend and resume 
because USB hardware has only one suspend state.  However, the callbacks 
do get an extra pm_message_t parameter which they can use to distinguish 
between system sleep transitions and runtime PM transitions.

Alan Stern

