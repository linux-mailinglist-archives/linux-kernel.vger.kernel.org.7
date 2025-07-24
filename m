Return-Path: <linux-kernel+bounces-744093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE73B107ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08AFC7B8E10
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A70268C40;
	Thu, 24 Jul 2025 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZN1duoBj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F95267B15;
	Thu, 24 Jul 2025 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353639; cv=none; b=juMx4Ulf+g5HE++sMZ+uWayBAW0cAsCT/qf9LoeF4xYE9JC1uVrtjbIWeOA6h6ZpZdJqXKpmTbEiubuvUioEXt7qwzP2lH0co3TuKSZPyqKtzHRYncBm5WMwozNwHcuV42W4tb1RbpOf+XHPR7sfWzS2a94aaMMahm5v0YrxkTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353639; c=relaxed/simple;
	bh=gJurIb1RIEAGkbaxSmKkmIKmJ2RmvhU6AMDoRAsfWZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkGGJWEuT7tgpNE+O7y0dwvvXblg8E0xDkucp/PBfRwKdxHVEs4aLRRdsXIXMWmzAwsIon3Fkf0d+vcEOiAdEpoDvmEWGv+cVNB9C1PJK7L9iRj3iwjZsXDNY312H+8QzWbnhJRhiauKfQBdDhD7TH0XUNtQnoF7FDVtc4mrfBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZN1duoBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD985C4CEF4;
	Thu, 24 Jul 2025 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753353639;
	bh=gJurIb1RIEAGkbaxSmKkmIKmJ2RmvhU6AMDoRAsfWZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZN1duoBj1m3lKE5Sw5qm0xhIupBIg1kme8zJjOzDAhtVRNsBAzePss9r+7ng99VSc
	 80jKNE7cV1cTupbYtqPXBZrgNnBOU1LwOqbJTXtR3BBeJ7c3qzdzhJkxX8Nfpzx0X8
	 IWJir+Qs4iDb5QV7hEj9J68TRAEZUz8UgF66bEgg=
Date: Thu, 24 Jul 2025 12:40:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB serial device id for 6.17-rc1
Message-ID: <2025072420-slick-atonable-bf08@gregkh>
References: <aIID41gVBb1_HmxH@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIID41gVBb1_HmxH@hovoldconsulting.com>

On Thu, Jul 24, 2025 at 11:58:59AM +0200, Johan Hovold wrote:
> The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:
> 
>   Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.17-rc1-2
> 

Pulled and pushed out, thanks.

greg k-h

