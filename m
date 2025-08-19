Return-Path: <linux-kernel+bounces-775496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EE7B2BFD7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744541BA8352
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3E9322777;
	Tue, 19 Aug 2025 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dMIMJrgK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B2931A042
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601678; cv=none; b=Wi1YwxjEsMRKWc6KDJ2LlW8/EQGI85wIP7qgs7Nl2DCtjjjlG8aJyT/b66ZXQzkJcajTe4BxLc85aZq2hmMTHUPHISl7IJ8DHilI8Vsus3XTXr0zmt2MkzuHHvZz52taBFYmFg6JB5apQLsqzCPaBXiUmDeWzxbusx/FEFRtPGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601678; c=relaxed/simple;
	bh=FXiZtyqE5apeJ07hHwEMPumoZ7w+wJ2JnZg2dBaJ1GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpZLwrLigR0J/hNMhu23TeYxsGu/4yQNt2XVoq53JWDl3Z0dMnrX6fG0SG8YEItKribRBursyfD7j2yROsx3kemEJo6ypOaJwdutOvaL8I/qBTgSKrHasIUtdRQGQ4JQThBfRApsUemPOl1I/S1T1riOt9cjwlMg91EroVw7vJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dMIMJrgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870A5C4CEF1;
	Tue, 19 Aug 2025 11:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755601678;
	bh=FXiZtyqE5apeJ07hHwEMPumoZ7w+wJ2JnZg2dBaJ1GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMIMJrgKhZeQdTAibJpxJi0YWF7AXwtVhqG77uuNRxa36ASWATt+4Dq6L/2/803/i
	 AFNe34V9Dhf3A3lr4ErDCMsC0tlEu0nTz9ia76bNhyE0r40c5EF4Hw2PlBhLAwTmNg
	 awi8MrjhWIGUOFAKaOUUKbN10rOGzElUGwpxRbwk=
Date: Tue, 19 Aug 2025 13:07:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mahesh Rao <mahesh.rao@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH 2/5] firmware: stratix10-svc: Implement ID pool
 management for asynchronous operations
Message-ID: <2025081926-choosy-femur-9765@gregkh>
References: <20250722163045.168186-1-dinguyen@kernel.org>
 <20250722163045.168186-2-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722163045.168186-2-dinguyen@kernel.org>

On Tue, Jul 22, 2025 at 11:30:42AM -0500, Dinh Nguyen wrote:
> From: Mahesh Rao <mahesh.rao@altera.com>
> 
> Implement ID pool management API's which will be
> used for Stratix10 Asynchronous communication with
> Secure Device Manager. These API's will be used
> in subsequent patches for ID management in
> asynchronous operations.

Please don't "roll your own" id management.  Use the idr data structure
instead.  It's simple, it works, and we don't have to review your
hand-made version :)

thanks,

greg k-h

