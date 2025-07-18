Return-Path: <linux-kernel+bounces-736317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C543B09B76
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5697A3BFC57
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FC61F3B97;
	Fri, 18 Jul 2025 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LBgRIszX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD519F40A;
	Fri, 18 Jul 2025 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820460; cv=none; b=rM14WOOK/VTqJNylXXaaig8zSksG1rRuDMEwwkMotBEUxBL3bitvXA0SqAYc58/a9rXAFze+H9e2Ud7vgK9Ji2o+L2TA4ysIsw2wAvj2vqR3sm77OwnHOj7mpDpHyKM8tnSOwe3tp/BIHJ4KfOnEf2CAkMwehhlQU4pFc3lYRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820460; c=relaxed/simple;
	bh=kplOQ0YceeBJb3UtPbzCDjGOSXTKgdjKuJ0H8zf+zHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQOn0htJQeox2K6W5hX38+SVDMxCoOXvGIT88uJYlEPyKRNrB92uGOImSdxeL0EMZIXHNseP0yf/Gt+35UtQVP0nQwLsTdzu0/hckb5QjWlOvzobeEKhsrGdgMjYI/JbvUkvHIPx8k1VWf+SOdZFx+7VqGEOdq1+VXBxjS4VOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LBgRIszX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A7DC4CEED;
	Fri, 18 Jul 2025 06:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752820456;
	bh=kplOQ0YceeBJb3UtPbzCDjGOSXTKgdjKuJ0H8zf+zHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBgRIszXOEWkDRDJBvV7DkpR7jkJHXOma/84NrQ04TuXgf1whXAfpQdd8Cddio84L
	 C+Zr6SbqWVbNPuY6BtV/MuITdLxJ3QTnW60kCKrDvzrJYTa/uis7H6Zjovq3uCtOcy
	 /QqT+R6dpKS+KdVWVtWWwgGmXSqayVRuLrjGtJ/U=
Date: Fri, 18 Jul 2025 08:34:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v4] staging: rtl8192u: Rename ChannelPlan to channel_plan
 and fix index name
Message-ID: <2025071803-wrongly-acts-3723@gregkh>
References: <20250718015925.162713-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718015925.162713-1-vivek.balachandhar@gmail.com>

On Fri, Jul 18, 2025 at 01:59:25AM +0000, Vivek BalachandharTN wrote:
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
> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
> ---
>  Makefile                               |  2 +-

Why are you modifying Makefile and main.c for the whole kernel when you
are just making a coding style change for a single driver file?

Also, please read the documentation for how to properly document your
version changes, they go below the --- line, right?

thanks,

greg k-h

