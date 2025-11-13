Return-Path: <linux-kernel+bounces-899983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2846C59461
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998523AEE9B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38793346792;
	Thu, 13 Nov 2025 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SxKqehLY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D702D0615;
	Thu, 13 Nov 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055880; cv=none; b=ZnI0MBGa3ZDLeIMXOikGMydCR/sWtsupqI2LAtusE9SodLWDwHoUiA9f4agAIbLOBlJl+7DvemmbIU8dlljl6tSrNfI7eYKkMG7jaoDArhgc9xLRsf5i7o7RRvdbNTkMdAlm0LJN5elMDUrCIfQc/PD09hcAjVjoWbmRMo4LIbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055880; c=relaxed/simple;
	bh=SyXQes28BrMHDYFJjh2EyZrY74SxZFP6LaB9NpHOKu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5Z/QV7WUB8VXllFtBoAy20PMlkqvKfncaN3VDoVjGxMJ2I9hmUrknjBNhGEfVZWTZQ/Ij5SrCqPmBzTIy3g+QvJ5rFw3T2jnn0NcLsaFsEGpyRXSLieNZF+Nt04ocQuZnO4ryGPBS+hSuVZMayKjzCR/aM2l7EVtAkNf8m+/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SxKqehLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1378C4CEF1;
	Thu, 13 Nov 2025 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763055879;
	bh=SyXQes28BrMHDYFJjh2EyZrY74SxZFP6LaB9NpHOKu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxKqehLYu0J05748WZVIpO/JK4Q8wvEIUIv1OdbBxjkNJZ1Td4J2Qr8NNmYnWUhGq
	 jyz1BrAgKxxLsCwqowATCG204ZhoWsgydMFgvo+nRtnewD0VgXUndfUKaC978+qCik
	 olnxh7hxfasKe5oOtI84rQHv8vszMmPaci5w7SjM=
Date: Thu, 13 Nov 2025 12:44:38 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chang Junzheng <guagua210311@qq.com>
Cc: outreachy@lists.linux.dev, Vaibhav Agarwal <vaibhav.sr@gmail.com>,
	Mark Greer <mgreer@animalcreek.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chang Junzheng <guagua210311@outlook.com>
Subject: Re: [PATCH v2] staging: greybus: audio_manager_module: make envp
 array static const
Message-ID: <2025111323-icon-reopen-834c@gregkh>
References: <tencent_3725607DD617A567779DEB1BEC7C3B335208@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3725607DD617A567779DEB1BEC7C3B335208@qq.com>

On Thu, Nov 13, 2025 at 10:12:00PM +0800, Chang Junzheng wrote:
> From: Chang Junzheng <guagua210311@outlook.com>
> 
> Fix checkpatch.pl warning by changing envp array declaration to
> static const char * const. This improves code safety and follows
> kernel coding style recommendations.
> 
> Signed-off-by: Chang Junzheng <guagua210311@qq.com>
> Changes in v2:
> - Restored original indentation of array elements
> - Only changed the array declaration as originally intended

The "Changes" goes below the --- line, as per the documentation.

thanks,

greg k-h

