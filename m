Return-Path: <linux-kernel+bounces-844260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E370FBC165C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 458114F5142
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B831E5B82;
	Tue,  7 Oct 2025 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J+33kcrQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42C1E4BE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841119; cv=none; b=LJO4Q33nNMuDhacMsRzdDIhsYdbajcwepBgkDLwGlNNNYCmQJZ8lBr8d4+jIbmNSYcRn5uZpqtWMIFvBN/0hMKbKIox7YJ6MLhUPejs7k9wkXFs9pzEdBGVB5nm9sYM1nyuMmGphf9zvI6T1NfMDANvjhUTtBdwsxTXv8897SFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841119; c=relaxed/simple;
	bh=alp7UMtgHKSKYClZUGh5LReVtGACoWvlTob5sLyVVlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNo4RgNr6NrmbNfnOGCRDZD74ParHl6GZmZImOJpS7/3elDnCD49Rm8zqh53E4hhXhJ5v4xgMFJ+RLFxm5o24lGyOgEWtOtl/ORafSwpHW43+dHtZhA4uxd5jFDFts09HKOiSm/zlt1Bw7yqlAjZ7d6aktbrCVgo+gDnrb1xcmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J+33kcrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B339C4CEF1;
	Tue,  7 Oct 2025 12:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759841118;
	bh=alp7UMtgHKSKYClZUGh5LReVtGACoWvlTob5sLyVVlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+33kcrQo9OOhRQRhkO6QwKe+gv8llpixFggOVtdVgM5y99n5b9xpIqmh+yBg9cAP
	 dGiON//YypYuzkGUpIqde2R6ChD6TFyVFtJVki2dh4E9tjAPvtM+q15YGjAIk1riGS
	 spJx+pQY5LXFZKhFCl2En+z81HJZv7vcgJx/ykAE=
Date: Tue, 7 Oct 2025 14:45:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: misc: Make the code for allocating minor in
 misc_register more concise
Message-ID: <2025100723-ravishing-widget-07b0@gregkh>
References: <2025090910-tactile-devourer-1070@gregkh>
 <20250910014421.2837-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910014421.2837-1-zhangjiao2@cmss.chinamobile.com>

On Wed, Sep 10, 2025 at 09:44:20AM +0800, zhangjiao2 wrote:
> >> On Tue, Sep 09, 2025 at 04:58:35PM +0800, zhangjiao2 wrote:
> >> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> >>
> >> There is no need to check the registered misc dev in misc_list.
> >> If misc_minor_alloc failed, it meens the minor is already alloced
> >> and the misc dev is linked in misc_list.
> >>
> >> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> >> ---
> >>  drivers/char/misc.c | 32 +++++++-------------------------
> >>  1 file changed, 7 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> >> index a0aae0fc7926..fc2f5e8b2f95 100644
> >> --- a/drivers/char/misc.c
> >> +++ b/drivers/char/misc.c
> >> @@ -211,6 +211,7 @@ int misc_register(struct miscdevice *misc)
> >>  	dev_t dev;
> >>  	int err = 0;
> >>  	bool is_dynamic = (misc->minor == MISC_DYNAMIC_MINOR);
> >> +	int minor = 0;
> >>
> >>  	if (misc->minor > MISC_DYNAMIC_MINOR) {
> >>  		pr_err("Invalid fixed minor %d for miscdevice '%s'\n",
> >> @@ -221,32 +222,13 @@ int misc_register(struct miscdevice *misc)
> >>  	INIT_LIST_HEAD(&misc->list);
> >>
> >>  	mutex_lock(&misc_mtx);
> >> -
> >> -	if (is_dynamic) {
> >> -		int i = misc_minor_alloc(misc->minor);
> >> -
> >> -		if (i < 0) {
> >> -			err = -EBUSY;
> >> -			goto out;
> >> -		}
> >> -		misc->minor = i;
> >> -	} else {
> >> -		struct miscdevice *c;
> >> -		int i;
> >> -
> >> -		list_for_each_entry(c, &misc_list, list) {
> >> -			if (c->minor == misc->minor) {
> >> -				err = -EBUSY;
> >> -				goto out;
> >> -			}
> >> -		}
> >> -
> >> -		i = misc_minor_alloc(misc->minor);
> >> -		if (i < 0) {
> >> -			err = -EBUSY;
> >> -			goto out;
> >> -		}
> >> +	minor = misc_minor_alloc(misc->minor);
> >> +	if (minor < 0) {
> >> +		err = -EBUSY;
> >> +		goto out;
> >>  	}
> >> +	if (is_dynamic)
> >> +		misc->minor = minor;
> >>
> >>  	dev = MKDEV(MISC_MAJOR, misc->minor);
> >>
> 
> > Does this pass the new test suite for the misc code allocation logic
> > that we now have in the tree?  Or do we need to write a new test-case
> > for this codepath?
> 
>  I didn't take this new test suite, can you do it for me?

Please test your changes first, don't make maintainers do it for you :)

> I don't think there's 
>  a need to write a new test-case for this codepath. 

Why not?  It seems to be a code path that is worth changing, so why not
test to verify you got it correct?

thanks,

greg k-h

