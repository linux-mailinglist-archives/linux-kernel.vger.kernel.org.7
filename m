Return-Path: <linux-kernel+bounces-746645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CDEB1294F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 08:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B334E454D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4D207A0B;
	Sat, 26 Jul 2025 06:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U0Hg9kEu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCD3EAF9
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753512834; cv=none; b=pSzLehmITBouZGwUdRqTPygm0xMZ6DLf+On5RvCNTxud627yQUjIi2LpXMiGbAbP7pTbznlKwOQnDONGUxxhZoIh364S4DxmVcdhRYKiM8IuBSIgIM7C4ERLhlVjXhY6sAgmxyfHG8+Qqyw/NfAS04TBjuDVMwgF4vFZH02JCWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753512834; c=relaxed/simple;
	bh=XHCcXNnNu8XELZ5k+oMXtL3W9sjOIpJZTeCJ/OeQyG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dve+YvsqadMLtH3Cd4Vmzwe1RUkVYNEHm0/ul3t2XRfNOk+rCQVUQGBGREp2Q1ch86cEJU6/q5WFZwdsNoF+ZeK3znV9W61noOwD1PiNsSX3klgZjQWnGnIbtSYS0XsoOUfv5X7SUZ97SM/0U1mOo7tBzAQlb6SKvIbnbCFEWnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U0Hg9kEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247F4C4CEED;
	Sat, 26 Jul 2025 06:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753512833;
	bh=XHCcXNnNu8XELZ5k+oMXtL3W9sjOIpJZTeCJ/OeQyG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0Hg9kEuYOI3Bm+e1eRD1kmbYBzkPfevyCt3gTVggoynid4FgHIk2etIdI6PjVgCC
	 Ch1/7eaHxy1tMQW3330tqanXiFic13YmAwNRZkG9fbpWoQF8Hj/OOuEZR+NRfApy9V
	 X5yzSS7IkjZq38/WBexwaXy3UW2ACIiyc9XzZD10=
Date: Sat, 26 Jul 2025 08:53:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for 6.17
Message-ID: <2025072609-knapsack-drinking-c979@gregkh>
References: <15ca3763-45a5-40af-93a8-449a9f1f33a9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ca3763-45a5-40af-93a8-449a9f1f33a9@kernel.org>

On Sat, Jul 26, 2025 at 09:34:47AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:
> 
>   Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.17
> 
> for you to fetch changes up to 5f09caafc652bcee7a5247e40dd34d1de1ad7d7f:
> 
>   extcon: fsa9480: Avoid buffer overflow in fsa9480_handle_change() (2025-07-19 12:39:13 +0900)

My tree is closed now, sorry.  Can you break this up into different pull
requests after -rc1 is out, one for bugfixes, and one for new features
for 6.18-rc1?

thanks,

greg k-h

