Return-Path: <linux-kernel+bounces-853172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B515ABDAD93
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B50D19A0545
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA1B3016FB;
	Tue, 14 Oct 2025 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fMH2q/eL"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3626724DCE6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464359; cv=none; b=LuJNjKOkzJMVRX7u3hJtN9rJugB89XFhzf9F2I7KHpT7d2ICUvQGeWbU11BbamgKgvN+YmLU7lvwt8P7IjDBNicutCQkG2GR0X/VfhNX5AVGDOQeEj3VJ73LktazoNP+XooJ2oXH9QVzHgXVQdruLSXseq0XrsMOau2o2qVPqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464359; c=relaxed/simple;
	bh=FmjjXyYDKE/Yk7fJkAB+drvbulYa9bzAOTeJfv02M+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmEVuLfZx78zzHeV3UPPj0ud2si/Z9CvbkPj/DUT2leDBT3KeDuQfyuyrpidf2x889XzEGbFuLmKMzIrRk6rOkH17pLpJZLkWiR476GO/Wt24nANJudCuRJ3wy3hs/ktyvpza1bmmtlLLLCQ4GEwa8iEVHyJY267BWQc2mfQ8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fMH2q/eL; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-184.bstnma.fios.verizon.net [173.48.113.184])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59EHqIud022805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 13:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760464340; bh=YsCObiDZn6NMNieiulOH3PG817/IZ49leYxhOnoaZrs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=fMH2q/eLPINH4uQNwqu7tmB76SAQn3RBLsxgQAU/Bd97lgA0BSLKgMlnIbUHpanyJ
	 fWP4vQJ4NVu/v+CFqw2tuJVIO5z+YdXB7WkeH1enRdKLeRgxp1oP/yDqStk1Q+WEZH
	 9JeDZwjWUkfU7WtuOaMZYwFlbyilxzCJQdhhFs+X9a+kS0cFdH2A5YwbfXYreAgVYM
	 iaPZkp7Vo4+QE6mIEfwy5JlNdMuSSdFbHVBtZwxoNtiz0hOmYLexK5NM9y5sBpUgTj
	 jzWV+OVWxYRJgBlWRKJlxc9CCiCh9OPze+xez5mToDDyJFLXhZcoBDXC2sCpibvt9e
	 V0Nm/YwFL5onA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 2A7942E00D9; Tue, 14 Oct 2025 13:52:18 -0400 (EDT)
Date: Tue, 14 Oct 2025 13:52:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Stultz <jstultz@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>, Tyler Hicks <code@tyhicks.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ecryptfs is unmaintained and untested
Message-ID: <20251014175218.GB566507@mit.edu>
References: <20241028141955.639633-1-arnd@kernel.org>
 <Zx-ndBo7wpYSHWPK@casper.infradead.org>
 <ef98d985-6153-416d-9d5e-9a8a8595461a@app.fastmail.com>
 <20241029043328.GB3213@mit.edu>
 <CANDhNCpsoPcotnrjH6y0yEBf43652DRasSsEnAyEbrKN=tjEfQ@mail.gmail.com>
 <20251014143916.GA569133@mit.edu>
 <CANDhNCp=06eNkOqNX2dFrnYhpZX0xsEd06U1xCwORk1mwt=MCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCp=06eNkOqNX2dFrnYhpZX0xsEd06U1xCwORk1mwt=MCw@mail.gmail.com>

On Tue, Oct 14, 2025 at 09:38:52AM -0700, John Stultz wrote:
> Yeah, though to my understanding fscrypt complicates backing up the
> data in its encrypted form.

Unfortunately, yes, that's correct.  Michael and I did throw around a
rough design for doing encrypted backups and saving the encrypted
per-file encryption key.  Actually doing the _backup_ wasn't that
difficult; but doing the *restore* was very tricky/painful.
Ultimately, we never implemented it because it wasn't necessarily for
the Android/ChromeOS use case, and because we weren't getting a lot of
interest for the desktop, without which having a better
general-purpose backup is lower priority.

> I've wondered if maybe something as simple as fuse mounting a password
> protected zip file would do, but I'm guessing something a little more
> modern like a fuse + age approach would be better. Unfortunately I'm
> not finding anything so far.

Darrick is doing a lot of work to significantly improve the
performance of fuse2fs.  So perhaps fuse mounting a dm-crypt device
backed by a loop device might be a possibility?

	       	    	 	      	   - Ted

