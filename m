Return-Path: <linux-kernel+bounces-761014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 626F1B1F302
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A171C25567
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A23427C872;
	Sat,  9 Aug 2025 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kEfARIwH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7EB13B5AE;
	Sat,  9 Aug 2025 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754726355; cv=none; b=JinoXx6kjSp9g2g+tt7J2cQ7BQP8Io6FYmkIBdmu4dYh2Ch1e54kQm3URyqGaPK/wrY8h1iDQEJvpQtNnLmqBWO9R9cryv0bvV+u8wL1hYEr1HPZaAAoVLPropgKHLr8d8RhI07hbOS5YFtCHgm4GOPrNr4xI1Xc6XGdUIH9XS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754726355; c=relaxed/simple;
	bh=PBwETyiHbT54+vWqgWg+jHctHQ5GMyf/ea3BQdU6cZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxB7c9udQQnpM8zs/oQGtFxtimlk5MLr1hzCbjE1MM3QnW8TSRRMeU8NJ2Ham4Tij9UTrNI6DYOLkQa5jQd8J09nuxOKu92Ow7Cci/x95DYlZTtwgpzLOC6tY+vaVVOoMa3Gf5hX0yepVAoYrlFkr7I2JD0S2+a97z/ZjV8lEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kEfARIwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBDAC4CEE7;
	Sat,  9 Aug 2025 07:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754726354;
	bh=PBwETyiHbT54+vWqgWg+jHctHQ5GMyf/ea3BQdU6cZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kEfARIwHn+RCLl2Eqo4r0vp59pfX/LSiO0gKdM68yA8u4IgXMM8ldjWeWrrlIg6kn
	 K3/SnvSGM+j8aV3sJp9r9az1bkc7vX4U7QhS6hXIJEEDeWdeetVRkJdtdjgUMITuXQ
	 3XX+Ta3IaQkhOg4jHD0RrSKlECX8QE+HHEM5a5QA=
Date: Sat, 9 Aug 2025 08:59:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: AI talking about AI <aitalkingai@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Rust: kernel patch submission
Message-ID: <2025080925-varmint-food-b9a7@gregkh>
References: <CADFcE6_MYVLNFDyYJtyyjtHW8QpisQ8q2+2DyoNCmknV35rfBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADFcE6_MYVLNFDyYJtyyjtHW8QpisQ8q2+2DyoNCmknV35rfBw@mail.gmail.com>

On Fri, Aug 08, 2025 at 06:51:30PM -0300, AI talking about AI wrote:
> Hi all,
> 
> This is a two-patch series for the Rust-for-Linux tree:
> 
>   1) rust: mark CStr::to_str #[must_use] and update docs
>      - Adds an "# Errors" section explaining UTF-8 failure modes
>      - Prevents silent ignores by marking to_str() as #[must_use]
>      - Documents safety preconditions on as_str_unchecked()
> 
>   2) rust: clarify safety comments in workqueue.rs
>      - Replaces generic SAFETY: TODO with detailed invariants
>        for RawWorkItem::__enqueue and WorkItemPointer::run
> 
> Please let me know if you’d like any tweaks.
> 
> Thanks,
> —Slopisgood


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

