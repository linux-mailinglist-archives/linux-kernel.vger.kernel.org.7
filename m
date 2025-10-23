Return-Path: <linux-kernel+bounces-867055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A82C01774
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF9D1508F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F112315D2E;
	Thu, 23 Oct 2025 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="reJdxXwR"
Received: from smtp72.ord1d.emailsrvr.com (smtp72.ord1d.emailsrvr.com [184.106.54.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1428530B527
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226278; cv=none; b=Ync5uvZemauPgNGhqDKKA6iuGlSjMymldrFzKRWXdZQLnJjweitgObsAGjS2cgEt10/UJvg8pWQrtFs/rBTzCoHfnKEPf7QSSVmr8e5lq3+9mnFSX5ms0xg0L4zOBP6slAw2DJDkiyRSMSvYdfAPKzJRxFJbJm0h0+PprdUGxzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226278; c=relaxed/simple;
	bh=AjvD6E5DxGjC8FjVAXMd7fROHx2OLDQ+ie9jtVc/HF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLaWsnskw0QS3B9t1RGsEqy7efIQpAaLDFSn3VIj5YmeLCPxazYQnXojZXK9PGUEoo0ZLrkEOvyRbblQMu+irz48IurXhes6ZFA5BC939EzA7uEUYD81f163j7Rm68+yh+SsJw7FxtuUp9zgF/n9S5lT7Diym60mOsycV6cBtAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=reJdxXwR; arc=none smtp.client-ip=184.106.54.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761226276;
	bh=AjvD6E5DxGjC8FjVAXMd7fROHx2OLDQ+ie9jtVc/HF0=;
	h=Date:Subject:To:From:From;
	b=reJdxXwRySyZXm8FNW7Rzq1cczOG4DvMlrtkZUnwNnHfCnxOVp/aYPEW1n9H1DUQN
	 JHP7e/7glWogdQerNupU5Bkh2/z1Vs2Idx4KI+xQwP9O3zw6uMersLxs8yTtkihvux
	 8vtk/cf3/MtKhn3/ETcZPoEvXnOt728BjS2asJ7Y=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 3DB41A02CE;
	Thu, 23 Oct 2025 09:31:15 -0400 (EDT)
Message-ID: <1d416774-596e-42c4-b458-da1f7cb89f36@mev.co.uk>
Date: Thu, 23 Oct 2025 14:31:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>, lvc-project@linuxtesting.org
References: <20251023132706.7983-1-abbotti@mev.co.uk>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20251023132706.7983-1-abbotti@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 8b417956-c629-4bd1-8779-d4fd0d8cb256-1-1

On 23/10/2025 14:06, Ian Abbott wrote:
> Comedi allows legacy devices to be configured manually (with sys admin
> privileges) with ioctl calls at run time by specifying parameters such
> as board name, base port number and IRQ level.  If not done correctly
> for the actual hardware being configured, there could be problems caused
> by unexpected interrupts (not to mention problems due to reading or
> writing incorrect hardware registers!).
> 
> These patches protect various functions in the core comedi module from
> these problems by adding checks that the structures that the function
> uses are in a valid state, and remain in a valid state until no longer
> required by the function.
> 
> Some low-level Comedi drivers use these structures directly outside of
> the core commedi function calls, and may also need fixing.  That has not
> been done yet in this patch series, but it provides a mechanism to do
> so.
> 
> 1) comedi: Add reference counting for Comedi command handling
> 2) comedi: Use reference count for asynchronous command functions
> 
>   drivers/comedi/comedi_buf.c      | 274 ++++++++++++++++++++++++++-------------
>   drivers/comedi/comedi_fops.c     | 134 ++++++++++++++-----
>   drivers/comedi/comedi_internal.h |  12 ++
>   drivers/comedi/drivers.c         | 134 ++++++++++++++-----
>   include/linux/comedi/comedidev.h |   7 +
>   5 files changed, 401 insertions(+), 160 deletions(-)
> 
> The alignment of the diff output in the second patch turned out a bit
> wonky due to similar changes in different sections of the files.  I can
> split the patch if deemed necessary.

Sorry, I forgot to fill in the subject line when composing the intro. 
I'll resend it.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

