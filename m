Return-Path: <linux-kernel+bounces-862753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD78BF6145
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89006487AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FE132ED25;
	Tue, 21 Oct 2025 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XhBQYYoc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613332E6A8;
	Tue, 21 Oct 2025 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046329; cv=none; b=AyKoyGhGGpHz4FRzN4l7b4gkdHzoRwOWRZn58b6bSH9wBQrAP7Ha9+1t5BoYNX89h9mrgVpstABz+C5i8o7zEHANxX5Umnb6OA12V+XQn/TrbgcL+19a6OXG9cYFXLQAplTbi4dv+6vpZCPnQYFpGJbeWxjkxSO1jP2ooUqhtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046329; c=relaxed/simple;
	bh=V0LzGqlm6ZT2RHcJE0MR9bBz502IUmS+3riFSgA+IaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFGmTqg0Pnf5QiDcIGJ+Ca+eBtp2Zz3Thkpl+8anwyXmnbhTrOxFgREYX8XCRhi4OeqedWyAOyerzqDCSHLQfsTQxKCkXih4Yx9hDGIxDoGw+0tO1lH7+BdSt2j5gtkjIs/Lh4faWSj0oMFH06ovdXY/BMqpzWJaw+3eesGS2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XhBQYYoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC92C4CEF1;
	Tue, 21 Oct 2025 11:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761046328;
	bh=V0LzGqlm6ZT2RHcJE0MR9bBz502IUmS+3riFSgA+IaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XhBQYYocP2zSHNl/y3zc3uCDpEOgRDQ97zRiReFaf36+qgwPO5j/aB9xQSbXr5xRJ
	 KdcMiCxhjyh/zvBNWXUnHINNsm+8qtsAAjbN3vts6WeKzZFXB8rdnUZVsoN9/ORXfh
	 loh/mVozneqCYzBbB5HUx263LPFgyBJ9g7GiAgg8=
Date: Tue, 21 Oct 2025 13:32:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Abel Vesa <abel.vesa@linaro.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] usb: typec: ucsi: Add support for orientation
Message-ID: <2025102129-overlabor-equinox-e24c@gregkh>
References: <20251015-usb-typec-ucsi-orientation-v1-1-18cd109fb0b7@linaro.org>
 <aPdc808hqRH73cjg@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPdc808hqRH73cjg@kuha.fi.intel.com>

On Tue, Oct 21, 2025 at 01:14:11PM +0300, Heikki Krogerus wrote:
> On Wed, Oct 15, 2025 at 04:50:36PM +0300, Abel Vesa wrote:
> > According to UCSI 2.0 specification, the orientation is
> > part of the connector status payload. So tie up the port
> > orientation.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> RFC or not, this looks ok to me.
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

For obvious reasons, I don't apply RFCs as they imply that the submitter
still has some questions that need to be answered :)

thanks,

greg k-h

