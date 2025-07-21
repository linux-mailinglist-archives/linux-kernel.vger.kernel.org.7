Return-Path: <linux-kernel+bounces-738740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E78B0BC7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E0917A312
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33A426E70C;
	Mon, 21 Jul 2025 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ISWDxkbd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5384F2AD04;
	Mon, 21 Jul 2025 06:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079287; cv=none; b=uR1DEf3lEDhSQe338kVEPr/ru0lx0Wbe083uHQRWpGE6XvWSOE8KVxbe3TClHAD0RpuwBTbQU5v+CndgNU958QDQPDwkFaSD5Kc79rOiR98MqS2ArERpmLpUTdP3yaTgBYmJZ0EaF++ZZtPV/Jj0MSqjY/a0MStklh8+g8OfJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079287; c=relaxed/simple;
	bh=Awf2JlFpZAAsC9E7QRotPEe1MqXcnLj+CinVQpBt/Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsRnh4CdgPefO+bFhqPV9weQ3WnQ4XBmzDASt9Hsd9uZ5UbO5UifpfF6sMLeog/jsDCSv78WB4pw98PyI6CcNGlLVFEHbTllhajJMkyMnLkxTtU5339SF1J9oUZKxUdAXs/xb+x9iuvy+PbqZlI45ua5//Q0PyJxJg9xWTRNDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ISWDxkbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70292C4CEED;
	Mon, 21 Jul 2025 06:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753079285;
	bh=Awf2JlFpZAAsC9E7QRotPEe1MqXcnLj+CinVQpBt/Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISWDxkbdxuxmnslOZpq3ydul88vO17hwI+QjmQ2JQl6ADKw2+HJ61JKHvJWIZaMAY
	 CZYuBSpmXgQ61l8bsPYhb8Kp9hrUvDRg0tGskqF6wgT6VkMzItx6L7fzwhAyZvRaeP
	 wV5VVQaTaZCdLmyOTCzFgl5gsd14uYeqjHG7yPM0=
Date: Mon, 21 Jul 2025 08:28:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8723bs: clean up redundant & parentheses
Message-ID: <2025072108-yarn-sloping-5831@gregkh>
References: <20250720092125.246844-1-vivek.balachandhar@gmail.com>
 <20250721061412.297554-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721061412.297554-1-vivek.balachandhar@gmail.com>

On Mon, Jul 21, 2025 at 06:14:12AM +0000, Vivek BalachandharTN wrote:
> Hi Greg,
> 
> Thanks again for your earlier feedback on the patch cleanup for rtw_mlme.c.
> 
> Since the original version included multiple checkpatch.pl fixes 
> (like spacing and formatting) and you suggested breaking them up by type, 
> 
> I wanted to ask:
> 
> For the remaining cleanups (e.g., spacing issues), should I submit them as:
> 
> separate standalone patches, or
> 
> as new versions (v2, v3, etc.) building on the current patch?
> 
> Just wanted to be sure I follow the preferred approach.

If you were on my side, recieving hundreds of patches a day to review,
what would you want to see?  :)

(hint, a patch series, properly versioned is the easiest.)

thanks,

greg k-h

