Return-Path: <linux-kernel+bounces-876062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF503C1A8EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A418588199
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E0C2BEFFE;
	Wed, 29 Oct 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HuSrHF1g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0FA2BEC2C;
	Wed, 29 Oct 2025 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742286; cv=none; b=dFW0b5KXZ+1LzKC96qfAmUx3tfpMKPzVyYvkrjhWnw2+0XZ1r7ieJc37slUkutUJD+zMfr4i/OpehmIZplkw+BceABwHsfkiFcV5SOtOF16vQ9Toc+cWuKHOWO8tB//0h+Sey5vEiMH1BtblohMDzDLw42Q8LnEySwog9CDkqsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742286; c=relaxed/simple;
	bh=IA6/gMGcF2fDDfJ6rUgbwhSBCtmCKF8Pfd0AulLr3Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPLvjyyJ1L+HEedQ19s4xyOV79kbVxZfjsACAQC4zDI4jA3ZvCWTBnBXiGJ8u1d+Q5dDsk62cPJEiYV7euAoOlFbNNMvRtgH9Jby0FECyASicmd41uGitz2Qet6xipRK8c+zDfL6C+GXotU3xPn093Fwz/xSImm5Y9ua0kc6450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HuSrHF1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6B3C4CEFD;
	Wed, 29 Oct 2025 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761742285;
	bh=IA6/gMGcF2fDDfJ6rUgbwhSBCtmCKF8Pfd0AulLr3Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuSrHF1gX5xHlhJoXyI/WY4pftAPLZ3a2C8f/v24Nza6ZVNCJUK6/eEGOAWWYWQFc
	 AjhuK/TnGwS4AZG3U1QvnJ8MBLM3izyqYIScijTTQvAO3Ks6fmnrdNC948qkDi7KKQ
	 9YSnHDbNVIyZZLK26V2C9VREfS0z1hCt24z3fQM4=
Date: Wed, 29 Oct 2025 13:51:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: uttkarsh.aggarwal@oss.qualcomm.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, mathias.nyman@intel.com,
	wesley.cheng@oss.qualcomm.com
Subject: Re: [RFT PATCH v3] xhci: sideband: Fix race condition in sideband
 unregister
Message-ID: <2025102956-daunting-roping-a987@gregkh>
References: <2025102948-trickery-creative-417e@gregkh>
 <20251029122436.375009-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029122436.375009-1-mathias.nyman@linux.intel.com>

On Wed, Oct 29, 2025 at 02:24:35PM +0200, Mathias Nyman wrote:
> Uttkarsh Aggarwal observed a kernel panic during sideband un-register
> and found it was caused by a race condition between sideband unregister,
> and creating sideband interrupters.
> The issue occurrs when thread T1 runs uaudio_disconnect() and released
> sb->xhci via sideband_unregister, while thread T2 simultaneously accessed
> the now-NULL sb->xhci in xhci_sideband_create_interrupter() resulting in
> a crash.
> 
> Ensure new endpoints or interrupter can't be added to a sidenband after
> xhci_sideband_unregister() cleared the existing ones, and unlocked the
> sideband mutex.
> Reorganize code so that mutex is only taken and released once in
> xhci_sideband_unregister(), and clear sb->vdev while mutex is taken.
> 
> Use mutex guards to reduce human unlock errors in code
> 
> Refuse to add endpoints or interrupter if sb->vdev is not set.
> sb->vdev is set when sideband is created and registered.
> 
> Reported-by: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
> Closes: https://lore.kernel.org/linux-usb/20251028080043.27760-1-uttkarsh.aggarwal@oss.qualcomm.com
> Fixes: de66754e9f80 ("xhci: sideband: add initial api to register a secondary interrupter entity")
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---

Looks good, thanks for respinning this.  I don't know if it fixes the
issue, but it looks sane :)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

