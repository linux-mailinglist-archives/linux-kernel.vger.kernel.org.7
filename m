Return-Path: <linux-kernel+bounces-832890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E31BA0AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09B91C241EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304430AAC6;
	Thu, 25 Sep 2025 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fzcuw2Ph"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A263074AA;
	Thu, 25 Sep 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818492; cv=none; b=KkJROwI6BrevutfJhKg8LGnuxkWBYWOuLx77iNJFlorMQnYYBQElC0xqfy3QSOdmLfUrTteWBaEPHwQN9E51OUd7D5TcNzCYFYVwEqXmcTqAtxdwQXTwSFT/sCNWQD8DADwh9GqQhm4azVnm2hdswauOY0qg04Wi6CbUcf347Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818492; c=relaxed/simple;
	bh=WCH9ubWv2L5gJ+B4k8HXlXgELNN8Q2NknuyOvCSCCJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyN/UAtbArrNIlZZQJea6vwCHmwPLIu9lC9w/ai0w4byS1IIc8Mh2kyVScyddyERCJRoauPy+ljnJz9Mt6Ou/nE12XHTfn7AtcHEW6FvaE5pLUJPRo45uDiODS51tdTu1z7FNqk7+L5Un+8Wah2yfOnkTqnoC7Y4b/Fhrt3e5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fzcuw2Ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C7CC4CEF5;
	Thu, 25 Sep 2025 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758818491;
	bh=WCH9ubWv2L5gJ+B4k8HXlXgELNN8Q2NknuyOvCSCCJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fzcuw2PhpJxZUcOYhprRjyaK6OEPIoT4RgFwr/fBRmOFtVR7qZSaRPMWk5/6T5hlh
	 k/Wlbsdc5np2cEGpc6ifHk7H0Cqil74At6rtCdE8wyWLbmPiVBl+hsUICvy1pTbw6A
	 XdsaC7ZlVu2wLHRKWBAcFfH+Px7nTFaOyqRWcqZs=
Date: Thu, 25 Sep 2025 18:39:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB serial updates for 6.18-rc1
Message-ID: <2025092532-aneurism-ceremony-04ef@gregkh>
References: <aNU3y3Cs54wkdhLY@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNU3y3Cs54wkdhLY@hovoldconsulting.com>

On Thu, Sep 25, 2025 at 02:38:35PM +0200, Johan Hovold wrote:
> The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:
> 
>   Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.18-rc1

Pulled and pushed out, thanks.

greg k-h

