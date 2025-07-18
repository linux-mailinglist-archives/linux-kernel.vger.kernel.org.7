Return-Path: <linux-kernel+bounces-736437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A1B09CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8484E75F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E17124167C;
	Fri, 18 Jul 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btx+EBaX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40D011712;
	Fri, 18 Jul 2025 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824611; cv=none; b=Nd+wAibUSEU6cy8+dcUPR463MmsRAzhyv0XHSx1UZy65sQ9DQYmJMYucrx8WOS3r6kQhHJSC4QeIMLWAc1XqyoDlZ2HftbxLhAYhdJFpu42EWA4y+7OogWyJ3TXjpvGt3VfGL4yfqDNfU6Jm2YSsOHjBLcv7I+2B2aQSOpiVFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824611; c=relaxed/simple;
	bh=VoQq/GDooCJ10CgN0+t5tOPIB+5GpIc0cfgvx9g2O2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDrghQJ/gbgCoxTQC+CBmwUIiJiqmRGQwbfkVioLsL5MmSVZOLMctaT6jlpividQXMT4J2x+rI5wwCs1JruzaDfxD9G10D6B/11XhFR3r7doylv8Ed1AG+1eDIUjaSF/45crlas0bvmXLxWi5PdJJUpQ1l4HuR9WQ/LUxGipB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btx+EBaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFCDC4CEED;
	Fri, 18 Jul 2025 07:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752824611;
	bh=VoQq/GDooCJ10CgN0+t5tOPIB+5GpIc0cfgvx9g2O2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btx+EBaXmqd5aDDm2TyARUMGq3XmU2qy5fsFbQTKA6Io+lhxnDXtAxPeeIwb1iuLx
	 JR4AUMJEyfL1QSHrPEyNDwugKudz3WpIaLU9yAmsJJ88Y+mxo/rDjhmDCFJvvkKMxX
	 7eEzA3C56RVJ9zVpxA70VEc+zjmDcyvj4Lx+3qfA=
Date: Fri, 18 Jul 2025 09:43:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] staging: rtl8192u: Rename ChannelPlan to
 channel_plan and fix index name
Message-ID: <2025071809-sulfur-unvaried-8e9a@gregkh>
References: <20250718025206.171361-1-vivek.balachandhar@gmail.com>
 <20250718025206.171361-2-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718025206.171361-2-vivek.balachandhar@gmail.com>

On Fri, Jul 18, 2025 at 02:52:06AM +0000, Vivek BalachandharTN wrote:
> This patch renames the global array ChannelPlan to channel_plan
> to follow Linux kernel coding style. Also renamed the index
> variable from channel_plan to chan_plan_idx to avoid
> shadowing and improve readability.
> 
> v2:
> - Fixed Cc list to include Greg and staging list
> 
> v3:
> - Removed EXTRAVERSION = -vivek from Makefile.
> 
> v4:
> - Tested and verified Makefile EXTRAVERSION removal does not break build
> - Removed EXTRAVERSION = -vivek to keep version clean
> 
> v5:
> - Renamed chan_plan_idx to chan per Dan Carpenter's feedback.
> - Removed mistaken blank line addition in init/main.c.
> - Removed unrelated changes to Makefile and init/main.c.
> 
> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Again, please read the documentation file for how to properly put a
version log for the patch (it goes below the --- line.)  Look at the
hundreds/thousands of examples on the public mailing lists for examples
of what to do here.

And also, please make sure that your patch actually applies against the
latest development tree (i.e. linux-next or the subsystem development
tree.)  I don't think that's the case here at all :(

thanks,

greg k-h

