Return-Path: <linux-kernel+bounces-871035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 072D8C0C488
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34B484E7D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2E92E7BC1;
	Mon, 27 Oct 2025 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9Utb09i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2129993F;
	Mon, 27 Oct 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553440; cv=none; b=nrukMJLZgFFM01/z5UPAn7h0pI2Uvg6RuMKeh5UmvemofEWmLDi2MQ/rq8FirDm/ic+4KxNhFl6pXepqhijP50aH9yFpXnNptViN4dpJQCRWphqE/ewKbIzD34HbrJb9oKC42KREq6mX4Htwlsjja0efcsQgzikTpwtkf1rRQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553440; c=relaxed/simple;
	bh=Klm03t/2WrmEzt3Q3aVRbMQi2y9puZc0QaXCY/aYM/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/dzjYarYBTvOZoN3iS/khnBRwa5qssjpTrCLPhJ3g2Q9MorvmciPNGc2/6DiEFH1l+h568q46ns6oKevuxhOJJWYn1xLPFyRq882EmpWFhZo1OvWEJ/FEcHtW8onueGsWZ6Aro7QOXIogA9j4munmh53mgkW7rFu7Hm8DWiTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9Utb09i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC93C4CEF1;
	Mon, 27 Oct 2025 08:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761553439;
	bh=Klm03t/2WrmEzt3Q3aVRbMQi2y9puZc0QaXCY/aYM/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t9Utb09i58YDFG/RMzFCm+7rrXDfGmhH1n2zsj1Ar5CffapoYI6/AWHhHMJtWauqu
	 d1M3kWgp3QBqd+o/6jUTAcJSpZJ4JPl5mjOnOdqDtnG6Rcr9hOptfsVNi34HFGhJKY
	 ZPftLQdUpyc2GdcgXK19FfTIG9SdQOsUNZNDC1Lr9+s9/zqXcGIrVrm8mlojxKS+lb
	 f6FD7bJaOaE1jlqTECO0pSaPA9ySnM9YEfiZd858MYeYjA6atSLNMKVznTKfc2vC3W
	 09pbzh+zL9VF/pcXVL3QS2eqAeiNNQ02CQ2so1HFASAUmX5voxdaADjrei1wWdI8aQ
	 hBcmDgYI32B4A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vDIWH-0000000085j-3OR9;
	Mon, 27 Oct 2025 09:24:02 +0100
Date: Mon, 27 Oct 2025 09:24:01 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] USB: serial: fix TIOCMBIS and TIOCMBIC
Message-ID: <aP8sIQDvzAUI2Ara@hovoldconsulting.com>
References: <20251022152640.24212-1-johan@kernel.org>
 <2025102220-starry-squeak-e5a4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025102220-starry-squeak-e5a4@gregkh>

On Wed, Oct 22, 2025 at 07:14:34PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 22, 2025 at 05:26:32PM +0200, Johan Hovold wrote:
> > Asserting or deasserting a modem control line using TIOCMBIS or TIOCMBIC
> > should not deassert any lines that are not in the mask, but two drivers
> > got this wrong.
> > 
> > Included are also some related cleanups.
> 
> Nice catch!
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for reviewing. Now applied.

Johan

