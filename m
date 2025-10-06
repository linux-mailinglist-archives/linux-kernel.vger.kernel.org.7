Return-Path: <linux-kernel+bounces-843061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C387ABBE556
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2C924EE479
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02D12D5943;
	Mon,  6 Oct 2025 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="htMZl+Dh"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C91244661
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760859; cv=none; b=c2vM5qYwyGgN/5fi1JwWA8km/gvYV4eqg3Oa4E0m+7sv+FS/+Edy68l4tisiRd0tUW2ZPGAeULmPwAvCZqKpMK49boRsQrKcJR5uAx8s1wL/DVxiWlKb1g/qpTZxTjiX3FPUqboOYhAD3T/tCkBTMv3Qc2DQ4/D759DWIad0gBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760859; c=relaxed/simple;
	bh=XtbGRIF4gT5uM/n2mxz/cQrBhqED7sPvDwW1IjYpLuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1EaSBQwsHPcflLibz2qWYYjNhlPYHyFd2mWpska3OztLrP0gNi93uQNVIQmr1F8BU292WSTM+QrhwHrRbmm06t5sTaMcyGzknCn6Tk/51dfLXSq1Id7vzfP71df10w0Di5NF2iQlJArwEGFX5QjQEpG6sURzhG84Q7lGBySMPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=htMZl+Dh; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7f04816589bso522168885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1759760856; x=1760365656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKuCXNlJxbIFYSKZrbgbsXO7VC1GY1uVsRjrnOFmk/o=;
        b=htMZl+Dhuv+UtCj5Xpu4JCn7Ikq6vh6vu27T22Ar/esPMFF6m2Xcnsm6YxS0ao4I5Q
         Fo4X3A4aDtuwALGQPXj0e8RdS2cLEG1j6tz7wOXUmjPizLAS2yuS8JfGleBBfXxzf5b9
         r1nqEGoh+HPPX/9s+y9xoIuf+9mJ5tiJtTTxp50rh4yhGJedp9c9if45NHn3LBzcUc8Y
         QWFYrDo+vDQrbXMId/SJcryLr7i7WMbPy2sd60vAW7mHVuICmlm+5bw3ftylC2J2ZuoH
         9dqGX09Wb0RBcr3QqddodxZZg0xBYFkpO4B+KEnC0vT3Oo3BzGyn9vILoA6Tjxc1e5/b
         apFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760856; x=1760365656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKuCXNlJxbIFYSKZrbgbsXO7VC1GY1uVsRjrnOFmk/o=;
        b=AidJe6zZc2FaG7SF7eq6o+KsUKFiHb6q1wmVyZaYEqGWRrzdR5Fn8d0Ynk25sLfSMg
         WMWTonlO/Gdt3hCrhqMnoWGh4sGOk562fn2pCPSMCPQZDAP5MpmYFc9BlU/PkiRwe6Zw
         IRqD13co8uq841NZUHB9UApZudelmHh+1eh00ElUt8dMpJxEF3D24lpl5RVhVTmW8bZQ
         iK0ATR6pHKq23sJ+uJhQjKBWFv8Pib9mbo5MxSSf4DZLy1XQ/p1kKyLxsG002bjVjfEd
         Mey1GvGCYKM5cFVBODSymI8277MYZKs28/gGccyuV8IMi8UGpsOw2FQEZLn5OaLn/rGl
         Foag==
X-Forwarded-Encrypted: i=1; AJvYcCXbgnQqr71ejThF5o+vW2roGZsB70E+XPGbWYqQxrQtaUgb/Zc6TD/WCBBpHJdbJJkhokTta0BdbAiE+Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+PApTU/jO3Kg1Gb6LghW6jtJihMRX8gGhh2wQ4b2wQE7y6bhQ
	ze+Dv2xP8dgULlkxKGrRd9ImDn+U34ysx9WqnpToPkM+x6OFGMqr230oS7C6SchhGw==
X-Gm-Gg: ASbGncv0X2CuudBOdOrAUrKJ6mRjVbfNczdgY1f12a39hYaKUiicMwBOHWoYxC7Tkqt
	xyvCC9V7teq3m/wmKAX2ssUpw26A2JG81j/m+TmnYTa2me4bYaN5goMlHxvVq+LsovTw5pnQpBC
	XcbQvrfxvOkDmPhMlzX/yARg3MFd1Utmbp7i+EA58nnYZ5aJi5WpK8COZG0UpjcawfMca38y9dz
	7Cv1VsmkcSHLjEWiM+jJkY0NjUG6lJuOpfJsnWzYS4n/+n4ChdmJRV/Z+UuKlfOP8ubv1xnEoo/
	3gYOLp3FJmB6sBUHaMaBWOmCznm1Smatu3/ugUIjm4mrgRbSYz2N5zZRTrBOP5kEoeF/Twj7sjm
	waN+wiZWffzusCeQOxgpem8zz2nmS9cPL5oY9ITJPZnyvgaHJNmfITfmhi0h09JRiWIQk8ELI
X-Google-Smtp-Source: AGHT+IGJ1eNcdTcVqRN5asKLKh/FjiIP0AjK4POtkbQXsOZaVfRPmuAlzT2Hi7kcf2MSf6xzx2nHJQ==
X-Received: by 2002:a05:620a:4110:b0:858:f75a:c922 with SMTP id af79cd13be357-87a36778c74mr1730491285a.6.1759760856108;
        Mon, 06 Oct 2025 07:27:36 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777865073esm1321704485a.35.2025.10.06.07.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:27:35 -0700 (PDT)
Date: Mon, 6 Oct 2025 10:27:33 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Korsgaard <jacmet@sunsite.dk>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] usb: c67x00 - fix potential division by zero in
 c67x00_end_of_data()
Message-ID: <4bfd6615-a0c0-4433-94d9-b9356bdcbffe@rowland.harvard.edu>
References: <20251006140631.1406643-1-Pavel.Zhigulin@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006140631.1406643-1-Pavel.Zhigulin@kaspersky.com>

On Mon, Oct 06, 2025 at 05:06:30PM +0300, Pavel Zhigulin wrote:
> The function 'usb_maxpacket' relies on the value of 'epd->wMaxPacketSize',
> which can be zero if the device reports itself as an eUSB2 device
> (see 'usb_parse_endpoint' in drivers/usb/core/config.c). Under normal
> conditions everything works correctly, but if a broken or malformed
> device is handled by this module, a division by zero may occur.
> 
> Fix the division by zero by checking the result of the 'usb_maxpacket'
> call.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

This should not be necessary.  usb_submit_urb() already checks whether 
the endpoint's maxpacket size is 0, and returns -EMSGSIZE if it is.

Alan Stern

> 
> Fixes: e9b29ffc519b ("USB: add Cypress c67x00 OTG controller HCD driver")
> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
> ---
>  drivers/usb/c67x00/c67x00-sched.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
> index a09fa68a6ce7..3211843497cc 100644
> --- a/drivers/usb/c67x00/c67x00-sched.c
> +++ b/drivers/usb/c67x00/c67x00-sched.c
> @@ -868,6 +868,9 @@ static inline int c67x00_end_of_data(struct c67x00_td *td)
> 
>  	maxps = usb_maxpacket(td_udev(td), td->pipe);
> 
> +	if (unlikely(!maxps))
> +		return 1;
> +
>  	if (unlikely(act_bytes < maxps))
>  		return 1;	/* Smaller then full packet */
> 
> --
> 2.43.0
> 
> 

