Return-Path: <linux-kernel+bounces-881353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7060C280F9
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 880BA4EA86F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5FB2F656D;
	Sat,  1 Nov 2025 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zZmw4Gd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1CA2F5A03;
	Sat,  1 Nov 2025 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007096; cv=none; b=r96707+d3ayGy+/GWpshdHpx24lHQEkRL7AriXRAorZKm0QSoYhCtJOMhmgWtj/Ad/+71R8YtofvKI6BRjCdkFBXmQeelwQUYXkBvPMyexuUIwVj2SdXEYv7jplr0YSjfkiRexMMquuZDSaRTD+YXujfoPYs8Gmxs71yM2We/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007096; c=relaxed/simple;
	bh=iqxvFnNb6/boAaK2Der2ZSOyxGXgApmOzVrQg7jYZEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO9hPvbhFFjPMprhOIoDR6OR3bVjam4R6myLEqzTgPCuTD8+fQXyzBEx6Lu05r05oQ5N9CV8Yt++fLmd3lOvKv2YiAXvAmjNzzmByE+JNu9UkEO4DeLdfmdH8J2qNR2+eeAxaZnLAnsW7qp84QIXHgmuvJgzpf8gMH0W/oWmYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zZmw4Gd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BDBC4CEF1;
	Sat,  1 Nov 2025 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762007095;
	bh=iqxvFnNb6/boAaK2Der2ZSOyxGXgApmOzVrQg7jYZEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zZmw4Gd2ivbmv9eg5yS215S8iN6rflYoEMKeGssf5WLctUPclxh127NL7llkuIFsH
	 uMTsBUmJMqFXS0kgKEljr63u9BRnnZfqiOImRzIIb6URIqpcujTWMfx3yNb84c9ckg
	 eXbfHRU8dtYgvvW7O3XfX6fg8A6UFp77QyQA17Vs=
Date: Sat, 1 Nov 2025 15:24:51 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Staging Drivers <linux-staging@lists.linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] staging: Pull in staging drivers docs into documentation
 tree
Message-ID: <2025110115-nineteen-diner-186e@gregkh>
References: <20251101124053.62544-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101124053.62544-1-bagasdotme@gmail.com>

On Sat, Nov 01, 2025 at 07:40:53PM +0700, Bagas Sanjaya wrote:
> Some staging drivers have documentation that are spread out in
> drivers/staging/*/Documentation/. Pull them into kernel docs tree by
> using the same technique as in 1e9ddbb2cd346e ("docs: Pull LKMM
> documentation into dev-tools book"): wrapping them with kernel-include::
> directive as literal include.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

No, please do not do this.  staging drivers are "self contained" and do
not spread out into the rest of the kernel.  If/when the driver moves
out of staging, then it can be included in the normal kernel
documentation builds and the rest of the stuff (i.e. include/ locations
and the like.)

So leave them alone.  Documentation does not need to be built for
staging drivers, there are much bigger things that need to be done for
them instead.

thanks,

greg k-h

