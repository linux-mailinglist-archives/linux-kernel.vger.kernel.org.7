Return-Path: <linux-kernel+bounces-865594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62457BFD8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28AB3AFF60
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8442882D6;
	Wed, 22 Oct 2025 17:14:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3D27A123;
	Wed, 22 Oct 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153279; cv=none; b=t00k7PFfwyDN/AdSBmgjAxyi33wbd3OEG7LKNLAXr5z2fjbx+tmoZ/TNXekZwsfFIMdzUD/hbZhMrNF01cgDRJcVLY9m3I2TsruTmVP47ODR6SOWWHla4DFOZK8iwKnP//1XQzzp2NLE1TkY135dDlrLzbi3js5gbzVGMRCYPFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153279; c=relaxed/simple;
	bh=TVw6eUPd/IdSv4xSEFuVcWFxlM0qldVlgu7N1I1A+NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWBkApFdH3Va5NDv6GygShNhZKiy2TAY10n+LBwBCPKSGLqEp4eVLj+0gZEaj7iQ3s5L57+sSkFi/eO4JcRCPemiHl2nOXy4xO6mfRCvNuDqSdRTvSJ2dfN1OADE7mc/g4X7PG3qzlTolEbv7eTwXgf/M2rs3UafjWkUeTkY7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A0BC4CEE7;
	Wed, 22 Oct 2025 17:14:38 +0000 (UTC)
Date: Wed, 22 Oct 2025 19:14:34 +0200
From: Greg KH <greg@kroah.com>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] USB: serial: fix TIOCMBIS and TIOCMBIC
Message-ID: <2025102220-starry-squeak-e5a4@gregkh>
References: <20251022152640.24212-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022152640.24212-1-johan@kernel.org>

On Wed, Oct 22, 2025 at 05:26:32PM +0200, Johan Hovold wrote:
> Asserting or deasserting a modem control line using TIOCMBIS or TIOCMBIC
> should not deassert any lines that are not in the mask, but two drivers
> got this wrong.
> 
> Included are also some related cleanups.

Nice catch!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

