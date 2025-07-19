Return-Path: <linux-kernel+bounces-737627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C367B0AE95
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD211AA70B8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE42236424;
	Sat, 19 Jul 2025 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="synFpZG0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B961DE3D6
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752912777; cv=none; b=LheRoIPSnGRzXrqke+4KN1CQowRuKDyrH74i/IY7c/xiUBwa1dY1hqVCYQL+SDG8B64ZF0Jvn90nph6Drx1gwfwJOpHFdQ1DhkibkMUVcwr29VT5GHmdBZLk5pqhNCHySrH/WlJviM4srnYgA/NvuC1RiRDVfc74lWNNSMFut9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752912777; c=relaxed/simple;
	bh=0hbvNtiBoFkwoRVsjhqpzO9gDJvxtwSp4CqwML9IaOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPxLOPfHtTxZKZPkk/ZvHCpui26rM0am/08v5kbNJxBRV5Ae7blPXfsFUPns/2X0RhA/Jf0KYNIIl5B0JYQwZGn0XapgKwNWhQozuF0tTphLbr76WHYAprz0gW0oKQENSX5Y/JdqQlXVpwcE0ws9OwLipIqfuyvZb5TU35U1pU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=synFpZG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22471C4CEE3;
	Sat, 19 Jul 2025 08:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752912776;
	bh=0hbvNtiBoFkwoRVsjhqpzO9gDJvxtwSp4CqwML9IaOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=synFpZG0CL0XJLO9dfYIcE9NZPEswHfeeJx9Gp6AzES+Ghzo9TURiqOPuloz8+qo1
	 RrNvWDPPYMbvslyKm+FnM50x0r+Ju8ys89Ie+mGtQj9RNSTTElSe26/9DbEIHN1sBV
	 gqLfz1JrGUFlGVgXarMLPQxMlTgGfi6f3FdymtYQ=
Date: Sat, 19 Jul 2025 09:58:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next v4 0/3] mei: fix mei_device lifetime
Message-ID: <2025071911-banker-skewer-ae65@gregkh>
References: <20250717141112.1696482-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717141112.1696482-1-alexander.usyskin@intel.com>

On Thu, Jul 17, 2025 at 05:11:09PM +0300, Alexander Usyskin wrote:
> mei_device data structure is allocated using devm_* functions
> and hooked to the parent device.
> It works for client systems where parent device is pci one.
> When parent device is auxiliary bus device produced by
> graphics driver, the parent can be destroyed before child
> and on the way it cleans all allocated memory.
> This leads to use-after-free if mei character device is
> opened when parent device is destroyed.
> 
> Connect mei_device structure lifteme to mei class device lifetime
> by adding mei_device free to class device remove callback.
> Decouple character device lifetime from parwnt structure lifetime.
> 
> As dev pointer in mei_device structure is converted to non-pointer
> device all dev_* calls should be touched in this patch series.
> 
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14201

I took the first 2 patches now, as they are "simple".  Give me some more
time to get a chance to review the last one, thanks.

greg k-h

