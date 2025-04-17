Return-Path: <linux-kernel+bounces-609520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734BAA92335
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 18:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB023B4A23
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CF32550A8;
	Thu, 17 Apr 2025 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+FltTPv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB7122371B;
	Thu, 17 Apr 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908991; cv=none; b=jV/Wb9YZRt6vspXZJe/oSEr/pOHn/vMFW3kyYgfZCjZSkRCYayN3lId6R/HeVfVybThfHOwHkLcSOlyTEWaOdy3zf4Eud5t9rNR6TLR1aMhFSIcm3Iih2AzUyYw04HQPr7uXeHb7vhpyIHD8LH5Ld3hBVHSI61uDVEACoJR/WEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908991; c=relaxed/simple;
	bh=QigbjyF+t0Z6PQcSIRp3970jNHZy/ytiz8YNIxK//H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flnSOPja8JQHldBJfUV9LqH2UIPT6rgULdY/C8B/34oRLgGjmqh+Y6JgOOpBv3Nk1UTA4EuiYJDnPXox9YuOT8b/MblwM3sHLjbNUJq0w3dkwd9DWRso6Vy7UJnv1Y5tFOeTNnmFVnXaeHQlspUKS6xXE3QFQruu65JlttCgMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M+FltTPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A023BC4CEE4;
	Thu, 17 Apr 2025 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744908991;
	bh=QigbjyF+t0Z6PQcSIRp3970jNHZy/ytiz8YNIxK//H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+FltTPvn7KizO4GfcXDl5jJHv18I+ozrx3j8pwLBolOwLqlL4dE8vEM9RMCq6jiT
	 4GCiYo+3xOq+JahgHM6I6RpcX3kHzGZBYdJGaixOdy/GEAmh0wgCFYK5c68VRDb4lf
	 9NHlz+ric7y1j4YeXNM9dVdXCIZMuDbOc3Yzwaxw=
Date: Thu, 17 Apr 2025 18:56:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Samuel Abraham <abrahamadekunle50@gmail.com>
Cc: julia.lawall@inria.fr, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com,
	dan.carpenter@linaro.org, andy@kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Replace `& 0xfff` with `% 4096u`
Message-ID: <2025041709-brick-unplug-c155@gregkh>
References: <Z/bA4tMF5uKLe55p@ubuntu>
 <2025041402-colonize-rocker-1db1@gregkh>
 <CADYq+fa18G25hfTeWTxwyxc+A=xHmk_je_9kjWbDdwbo0seaZQ@mail.gmail.com>
 <2025041448-destiny-hate-1b70@gregkh>
 <CADYq+fYWFqPQTJABt4sKo3NsENLrDbVh7Sn+uu9sLNumc0wt9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADYq+fYWFqPQTJABt4sKo3NsENLrDbVh7Sn+uu9sLNumc0wt9w@mail.gmail.com>

On Thu, Apr 17, 2025 at 05:33:30PM +0100, Samuel Abraham wrote:
> On Mon, Apr 14, 2025 at 10:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Apr 14, 2025 at 08:38:53AM +0100, Samuel Abraham wrote:
> > > On Mon, Apr 14, 2025 at 8:23 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Apr 09, 2025 at 06:48:02PM +0000, Abraham Samuel Adekunle wrote:
> > > > > The sequence number is constrained to a range of [0, 4095], which
> > > > > is a total of 4096 values. The bitmask operation using `& 0xfff` is
> > > > > used to perform this wrap-around. While this is functionally correct,
> > > > > it obscures the intended semantic of a 4096-based wrap.
> > > > >
> > > > > Using a modulo operation `% 4096u` makes the wrap-around logic
> > > > > explicit and easier to understand. It clearly signals that the
> > > > > sequence number cycles through a range of 4096 values.
> > > > > It also makes the code robust against potential changes of the 4096
> > > > > upper limit, especially when it becomes a non power-of-2 value while
> > > > > the AND(&) works solely for power-of-2 values.
> > > > >
> > > > > The use of `% 4096u` also guarantees that the modulo operation is
> > > > > performed with unsigned arithmetic, preventing potential issues with
> > > > > the signed types.
> > > > >
> > > > > Found by Coccinelle.
> > > > >
> > > > > Suggested by Andy Shevchenko <andy@kernel.org>
> > > > > Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> > > > > ---
> > > > > Coccinelle semantic patch used to find cases:
> > > > > @@
> > > > > expression e;
> > > > >
> > > > > @@
> > > > > * e & 0xfff
> > > > >
> > > > > To ensure this change does not affect the functional
> > > > > behaviour, I compared the generated object files before and
> > > > > after the change using the `cmp` which compares the two
> > > > > object files byte by byte as shown below:
> > > > >
> > > > > $ make drivers/staging/rtl8723bs/core/rtw_xmit.o
> > > > > $ cmp rtw_xmit_before.o rtw_xmit_after.o
> > > > >
> > > > > No differences were found in the output, confirming that the
> > > > > change does not alter the compiled output.
> > > >
> > > > This is version 11, right?  What happened to the list of previous
> > > > versions and what changed down here?
> > > >
> > > > confused,
> > >
> > > Hello Greg,
> > >
> > > I collapsed this patch to the previous patchset I had worked on that
> > > made the same changes to the same driver.
> > > So this patch was collapsed into PATCH v10, which is the last version
> > > for this change.
> > >
> > > The change log in "[PATCH v10 0/2] staging: rtl8723bs: Improve
> > > readability and clarity of sequence number wrapping" explains this.
> > > This patch was collapsed into patch 2 of this patchset.
> >
> > Think about it from my side.  I get hundreds of patches each day to
> > review.  If I see a v10 and then a patch with no version at all, what am
> > I supposed to do?  I would assume something went really wrong and just
> > delete this "obviously old" version as it would have been the first
> > version of the patch, especially as there was no version information
> > below the --- line.
> >
> > So, what would you do in my situation?  What would you want to see if
> > you were in my situation?
> 
> Hello Greg, I'm sorry once again,
> Please, do I send a PATCH v11 for this change?

Yes please.

> It seems my mistake had made you delete the PATCH v10.

Yes I did.

thanks,

greg k-h

