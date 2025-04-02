Return-Path: <linux-kernel+bounces-585434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E5A79366
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 18:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BEC3AF971
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B265190051;
	Wed,  2 Apr 2025 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QV4LwqRB"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8844C7C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612228; cv=none; b=gM9cnjGZqMKwMlkBK9bP+KVIbrmRtgw/cuCkuFRSxyCIZcfQ5q+G31R1QLTNcUaM/gTLAhOqNdOLUv0tCPziOSkt4OtxlKL9kL1FOSYqHjA0pEqtNN+NjfBlu3UUI9mslhT5DXcpFpSuCIapzQyiaKUTnI9rZirVi2iS/u67gGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612228; c=relaxed/simple;
	bh=0+vjMn6MGe4SGiHigLwAz6N84qzUSCpdnJ+Gv3PVWQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jurEQAIpvJLlwr0mwsQ0w8DYXh3BBWdcp9I+6dCgA8ESuUZBC7xjbzUGc8ry+9fuDsBRiJ4kE8uimFizUcMM4/CF/2/qQkflCDMx2FOVwEIY3CvVQKw7Cib128Cj1rzpB13pvRz8fakjKAA+++vGzyo3eZSLzY4zwcY9PtzKoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QV4LwqRB; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Apr 2025 09:43:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743612225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dC2BktL2U1qJZpOkA3oSO/rhAVApRNRqpBDF3LmdFzk=;
	b=QV4LwqRBXE/ZSwab145rZFh2Wh+9zagi8movC6n+xstcXwajIwpREX2Apbkb/XDWXiomdO
	Xvog9Upf8soPxXuBVSgRYIDNIqdyYyB0pF9fYyUy0nYrTBl8OAigLiFODBzCaoJApVPYv+
	Q+i1Ib8wS96p36xm0dkeJ7LBnEoUSM0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	maz@kernel.org, mark.rutland@arm.com, lpieralisi@kernel.org,
	catalin.marinas@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smccc/kvm_guest: Remove the accidental semicolon
Message-ID: <Z-1pPLI8HRjg-bSx@linux.dev>
References: <20250402134401.146156-1-shameerali.kolothum.thodi@huawei.com>
 <20250402-independent-hyrax-of-honor-4515fb@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402-independent-hyrax-of-honor-4515fb@sudeepholla>
X-Migadu-Flow: FLOW_OUT

Hi Sudeep,

On Wed, Apr 02, 2025 at 02:58:06PM +0100, Sudeep Holla wrote:
> On Wed, Apr 02, 2025 at 02:44:01PM +0100, Shameer Kolothum wrote:
> > Fixes cocci reported warning:Unneeded semicolon
> > 
> 
> There was similar patch on the list [1] few days ago.
> 
> > Fixes: 86edf6bdcf05 ("smccc/kvm_guest: Enable errata based on implementation CPUs")
> 
> ^^^ Is this really necessary as they get backported as well ?

The blamed commit was introduced this release cycle so no concern about
backports.

> Since, KVM maintainers are in cc-ed, let me know if you guys want to pick
> this ? Else I can send it as part of my firmware (ffa/scmi) fixes.

I can grab the fix here in a moment, I've already got one queued up [*]
for the KVM guest driver anyway.

[*]: https://git.kernel.org/kvmarm/kvmarm/c/acfcaf90db1f

Thanks,
Oliver

