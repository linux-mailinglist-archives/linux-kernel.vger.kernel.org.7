Return-Path: <linux-kernel+bounces-778111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777F8B2E17E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA3A3AD274
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFDF322552;
	Wed, 20 Aug 2025 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwCiAApP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33342E0411;
	Wed, 20 Aug 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704908; cv=none; b=EBygAgOPFQ5DbhAQ9BRkyC54Rpf8+t3kzHOnPv1KFra0zcNHPsYDkYqBxsMgD5rM0/VN2RRY0b7eLknTzVh3iGbL/AunOX8ZR1mgk6DNccd0e6LDO08ovl7blJY+B+aYbX7ZBeQHuHhd8A5Ta+U6bIh4GtuhRR/7GM80k8NFT0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704908; c=relaxed/simple;
	bh=A+KOnzffe/CC4whw0Q8qXyrcSzZ4ed38V0Fl5eGAIAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pR6nXwEauQD8TZ54Rw3Vo/xORWV3sjRx/sWgYQzKAf8HPD9v/ndB730evbEJGtsgt7/Pp10R6ufk9B1GGrzCoG96yrHsnaD9YkjwdYmaCmbPh8APNkJTYqggjhHaT7tmQUzSRIPiIotrWt4t/ypehmKu4M5DfNgkJJDCVnGjRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwCiAApP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646C7C4CEE7;
	Wed, 20 Aug 2025 15:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755704907;
	bh=A+KOnzffe/CC4whw0Q8qXyrcSzZ4ed38V0Fl5eGAIAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwCiAApP88cTa6AH54PNXEB+2NSS+UugUb63QH+zHCu9EEHDH06an1izgkcuZYggx
	 /nFTJZn4XFR4iIbJ/GRVclNViSOC/Y0MGeIxYhZZiwN3lJoTJhOhKePI4+9UN9XSjX
	 prjYMUOAUa34UXQW+8Z8tI4lhIvt701GHpWL/kEiFbG5tzL4E/+wLFldzqew8sOvZP
	 IL1XgL2EchJm2aK9z8SVDmh8xBOPqe19FTd9Zb/Ft03heymW2APZ4RgQIQd7lgenYF
	 QLy7ozMEBHENQ5Z+e2gNs+O2MIvJDSMkM2nuMclWAMjOg6f6+oL05Zvnv3syFwselv
	 HqBy0BQuKcYCA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uol33-0000000AkBw-0geQ;
	Wed, 20 Aug 2025 17:48:25 +0200
Date: Wed, 20 Aug 2025 17:48:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kfigure.py: don't crash during read/write
Message-ID: <vedoha3v6rf3zccoyvyh67bvqf7sjlezc6jm7kncvmcpoqdkzj@jp722nkrfei2>
References: <df1602df0da3a6254d58a782654e7f2e60512dc8.1755680997.git.mchehab+huawei@kernel.org>
 <87wm6ytb9m.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wm6ytb9m.fsf@trenco.lwn.net>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Wed, Aug 20, 2025 at 06:42:29AM -0600, Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > By default, Python does a very bad job when reading/writing
> > from files, as it tries to enforce that the character is < 128.
> > Nothing prevents a SVG file to contain, for instance, a comment
> > with an utf-8 accented copyright notice - or even an utf-8
> > invalid char.
> 
> Do you have a locale that expects everything to be ASCII?  This seems a
> bit weird.  I would expect utf8 to work by default these days.
> 
> > While testing PDF and html builds, I recently faced one build
> > that got an error at kfigure.py saying that a char was > 128,
> > crashing PDF output.
> >
> > To avoid such issues, let's use PEP 383 subrogate escape encoding
> > to prevent read/write errors on such cases.
> 
> Being explicit about utf8 is good...but where are the errors coming
> from?  Is this really a utf8 file?

Unfortunately, I forgot to store a note when I got it the error... 
heh, I almost forgot to also write/submit this one ;-)

Yet, see: kfigure.py reads a .dot or .svg file. both may contain utf-8
characters on strings. For instance, they may have an accent inside a
copyright comment, a greek letter, a math symbol, ...

So, IMO we should change read to work with encoding and have a
fallback like PEP 383. 

Now, I did a git grep treewide at svg and dot files. Currently,
they're all ascii only. 

-

That's said, I guess the error I got was during write. This script
tries to write in "w" mode, instead of "wb" (it came from python 2.7
times, where Python were following the typical standards for write
in Linux). 

Anyway, let's not apply this one for now. It will require extra
changes.

I'll return to this when I have some time.

-- 
Thanks,
Mauro

