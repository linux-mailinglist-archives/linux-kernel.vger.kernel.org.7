Return-Path: <linux-kernel+bounces-808242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D68B4FCB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECB234855A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBC7340DA4;
	Tue,  9 Sep 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bCsm+2R2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C0333EB15;
	Tue,  9 Sep 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424325; cv=none; b=UfSLMfXoXUSyQLZYHqyRIYUX8Ha6XS/OWMk+1CP2D/LevJPVKQHeeD8pIJ5LNA888QAj1iIfe3mEqvDBjICDTQZE1ACeEeRQ8HlCYmC8ycPYPgNaq61MPyzD6rwOFZqfRF5hIPhym7ED4bRanjxu84jDU6K/fzTPw4HqnUOiPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424325; c=relaxed/simple;
	bh=oPk44DQS8yhUOAFD00EGVtUnkpr4ITAVEqHGH03U3K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCEzV+wH0BJEEjgJV2IAvKP1vmho0WLkMpIeNO8zcr6tEXKGXDfy6aCuc0RATTL5l+C1XZKLA8b3otlsbFVB1+C+Ers6j6kuBKqOhjTtiteUGv7mWrdXW/vT9iHUFQML1v+VJQdkiXK4upeyJdMhDaE6cgLLUOPpOotP8gYtYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bCsm+2R2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39638C4CEF4;
	Tue,  9 Sep 2025 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757424324;
	bh=oPk44DQS8yhUOAFD00EGVtUnkpr4ITAVEqHGH03U3K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bCsm+2R231pR7pyj/b1tH/hStJwkojpL4xbvCPsy7yu7IeBuY+t4E9XnOY/IGwKXf
	 zymLnCMLXAM/t76Fptirbqoxjs3WZqpfdp60/wksDqOo+iwmg07elehiKOGZ5cTUc1
	 jUhBZihwcfTPKceHr+TrXlzG19qhF07GLCPt7gi0=
Date: Tue, 9 Sep 2025 15:25:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Simon Neuenhausen <simon.neuenhausen@rwth-aachen.de>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] samples: rust: add a USB driver sample
Message-ID: <2025090908-stifling-citric-08ed@gregkh>
References: <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
 <2025090601-iron-glitter-c77d@gregkh>
 <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>
 <DCLQZZHU42HN.4Y4PP0PPR10O@kernel.org>
 <9657C897-087E-4544-849B-964E99D95A50@collabora.com>
 <DCLTJMIAMCVL.35U236MMS5CCK@kernel.org>
 <85B643A9-1657-43ED-BE98-BE7E502D08DA@collabora.com>
 <3aca9e74-b67c-4bfe-a206-9a6eecdf76ab@rwth-aachen.de>
 <77E6BE1A-B928-4A36-98C4-74FB4A7C19C0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77E6BE1A-B928-4A36-98C4-74FB4A7C19C0@collabora.com>

On Tue, Sep 09, 2025 at 09:12:21AM -0300, Daniel Almeida wrote:
> Greg,
> 
> > On 9 Sep 2025, at 08:19, Simon Neuenhausen <simon.neuenhausen@rwth-aachen.de> wrote:
> > 
> > Hi,
> > 
> >> On 06.09.25 17:46, Daniel Almeida wrote:
> > 
> >> As I said to Greg above, I’m here to help if anyone wants to write a USB driver. Those interested
> > are free to reach out to me and we will work together to merge the required abstractions with a real user in mind. Hopefully this encourages others to join in this work :)
> > I had planned on writing a USB driver for TI nspire calculators, that would make them mountable as USB mass storage devices, since they use a proprietary USB protocol, that usually requires paid software from TI. At the time I gave up on that, due to the lack of USB support in RFL, but I could revive the effort using this.
> > 
> > I'll admit that this is pretty gimmicky, but if it helps to get this merged, I would be happy to do it.
> > 
> > Greetings
> > 
> > Simon Neuenhausen
> 
> We apparently have a user :)

No, this will not work as a kernel driver, it needs to be done in
userspace as the complexity involved would be crazy to be in the
kernel, it would be much simpler as a libusb program.

> Would you be ok if I continue this work? I can look into gadget zero as you and
> Alan said.

Sure, but again, we need a real user before I'll be able to take this.

USB's "problem" is that for any non-class device, it should be done as a
userspace program and not a kernel driver.  It's simpler that way, more
secure, and easier to debug and support.  The number of "new" USB
devices out there that need a new kernel driver for it has been very
very low for the past 15+ years.

thanks,

greg k-h

