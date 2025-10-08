Return-Path: <linux-kernel+bounces-845332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D928CBC47EF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D786A19E0A50
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA572F617F;
	Wed,  8 Oct 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tti3X3Yv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80D29A31C;
	Wed,  8 Oct 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921504; cv=none; b=BNk+uWDbHO7tVbc8upaoCzdtEkdBpadH8ziVu4pieSdZEDwHAPJiBieUvRKlzL3MnCGACfpw0HB3/8XRFZkVdvZ3Fmi7HuD1Fqu/eeTtTcWyLfYLpfCzBDKKejWG6iTgRRWEZLB/q4XxWG/5n8iBB3zB1jv2VKYmLrs3BEkXUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921504; c=relaxed/simple;
	bh=7YhuHDXts0caEWp6/79IMFuRIujYEB/9dEevCXZbYB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h92IoO/+J/LVWwKiD7pKPxxen8QhUy3J6PvB39we8zKJF87EsyYVl7WIGCCsiDbyw4ut/S2qEQPfOpmUXRrkP/2qE16EFFpRjh9xaAhUdw/E/b4fxqnqeWskDR9fMsHz7qlj3ZLoNkXtcgD+7niifjKcZ1AztK+t4HaLoMOUbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tti3X3Yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C37C4CEF4;
	Wed,  8 Oct 2025 11:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759921503;
	bh=7YhuHDXts0caEWp6/79IMFuRIujYEB/9dEevCXZbYB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tti3X3YvEzNPRSCsbSFwWwm5jLRpsOZujUFbVy71fVdWTbEXgO/XZPHqMhbFUs8c/
	 s1IOrLnqqKD/TGIS+fdRrPDAoMWD+dC0hz4mytVtdp70X7JhapFjoZXUcmUBzzu928
	 wDLBv6ExzmFTcbftjztbXZoCNThyjA0lTeERWJX8=
Date: Wed, 8 Oct 2025 13:05:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Rex Nie <rex.nie@jaguarmicro.com>, Jann Horn <jannh@google.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: core: replace memdup_user with memdup_array_user in
 proc_do_submiturb
Message-ID: <2025100824-payday-anemic-b179@gregkh>
References: <20250919122601.1094728-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919122601.1094728-2-thorsten.blum@linux.dev>

On Fri, Sep 19, 2025 at 02:25:57PM +0200, Thorsten Blum wrote:
> Use memdup_array_user() instead of memdup_user() in proc_do_submiturb().
> Compared to memdup_user(), memdup_array_user() automatically checks for
> multiplication overflow. Remove the obsolete local variable 'isofrmlen'.

But there is no chance for overflow here, right?

I'm all for using "proper" functions, but there is no need to go and
rewrite existing code for them if you can't test the results.  Did you
test this?

> Return early if an error occurs instead of manually setting 'ret' and
> using 'goto error'.

There is no need to do that, please leave the code flow alone as we
"know" it works properly as-is.

> No functional changes intended.

"intended", but did you succeed?  :)

Testing is good, please do that.

thanks,

greg k-h

