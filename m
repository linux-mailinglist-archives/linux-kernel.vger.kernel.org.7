Return-Path: <linux-kernel+bounces-856430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E09BE427B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF938584770
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B38345722;
	Thu, 16 Oct 2025 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VEu6WyfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516063375BE;
	Thu, 16 Oct 2025 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627489; cv=none; b=V2/dk2osszC/cF5i/J4g3f2AtQSy1xJmV7NlAgbioqqo89YsFJjCODUGTSmBFtIEGyreXVSSFk7TgAwPaTT2LsZgeooNuA5Rlnlm0xldKAtX6LQgh7EiUIRuz2DLdR/VpcgmdvsRvHOLKm4e4q1HiSSlqwN8ebQw1nB4pVPUAyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627489; c=relaxed/simple;
	bh=vBLUTjIvPSHDCeoOugC1wlQNqMQ/LTwY9D4e8ev8Trs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LweV+zrHMn1rA1LHNQ9rt01PLKLx7TkdcgR6TOXysQwKE6YAa3OfnivR2Es82uSnU9GsBl6kgHf8xdYTD2iJBxP0ViQ7fVcDg3p+nU+fXN2sySNUnBvpDYaNQh0yMiOkXk9VLMPU4oN85cdwQ/WKXzpEQiH6CEHI3SftkrXbncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VEu6WyfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8CAC4CEF1;
	Thu, 16 Oct 2025 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760627488;
	bh=vBLUTjIvPSHDCeoOugC1wlQNqMQ/LTwY9D4e8ev8Trs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEu6WyfSQGEPJWcUV8eMno+zO0EtJ2yevlYQWmOcwpBOvs7kbvO4D2jtC1WB4Jh9s
	 zNPmP5Z1hmUcQfTGOnwiRpz5DXTUJQsQu3Hy9ODi+ryl9tixYOBT5OD0+qz23qIcHf
	 ur04tVPckGgdPIkqM9BI6lUhMXsDarUQFA9eMyEA=
Date: Thu, 16 Oct 2025 17:11:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Frank Li <Frank.Li@nxp.com>, linux-i3c@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Boris Brezillon <bbrezillon@kernel.org>, imx@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, Shuhao Fu <sfual@cse.ust.hk>
Subject: Re: [PATCH v3] i3c: fix refcount inconsistency in i3c_master_register
Message-ID: <2025101616-marital-reflected-a030@gregkh>
References: <20251016143814.2551256-1-Frank.Li@nxp.com>
 <8b9e079f-c119-4dc9-a489-9cfc8e322c27@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b9e079f-c119-4dc9-a489-9cfc8e322c27@web.de>

On Thu, Oct 16, 2025 at 05:07:38PM +0200, Markus Elfring wrote:
> > In `i3c_master_register`, a possible refcount inconsistency has been
> > identified, causing possible resource leak.
> …
> 
> * Can it be preferred to refer to the term “reference count”?
> 
> * Would it be helpful to append parentheses to function names at more places?
> 
> 
> Regards,
> Markus


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

