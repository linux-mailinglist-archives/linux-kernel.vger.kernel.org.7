Return-Path: <linux-kernel+bounces-862529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB095BF588C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90BB8352AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B6A2E264C;
	Tue, 21 Oct 2025 09:36:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CB22C3271;
	Tue, 21 Oct 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039373; cv=none; b=EJ4T3iFIvQYQ6V0MSqy1Kla4K8eSoiUcdBgtvJNS2VPrCaiMLGFuKHmNDd7DWqT40q2LoXb6F1k3xM653Kwtkx/5SjppO5O2NbkwNKl3Lzi6XLHueCXJfp0oI2m+tRGsXwrZuAZXexG2JU9A6ww0l5c1Eu22zVsEj4D+5h4+oKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039373; c=relaxed/simple;
	bh=4zOODg0oy67fGjo10q+UJcg1qHs3HItvi17vHzNvwUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQX6vk5xFFMMUhT62g2h/s2LHVEROSEjn+gCuhEeklfBCalJec+MdFOliEBBoYY41UJ5/TtQvShZAo+/fX1QmQ/mL5Ldlo1swpfz/sNsrc7Dp+6G8D5mvlRawX/mnaMoq0omFYLsB70mBnxumRKBohAsTOQvPWWObThssfaSzJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 817FD1007;
	Tue, 21 Oct 2025 02:36:02 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B2F23F66E;
	Tue, 21 Oct 2025 02:36:08 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:36:00 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH 02/10] firmware: arm_scmi: Reduce the scope of protocols
 mutex
Message-ID: <aPdUAOirD2yodeTy@pluto>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
 <20250925203554.482371-3-cristian.marussi@arm.com>
 <20251017160702.00002af4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017160702.00002af4@huawei.com>

On Fri, Oct 17, 2025 at 04:07:02PM +0100, Jonathan Cameron wrote:
> On Thu, 25 Sep 2025 21:35:46 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Currently the mutex dedicated to the protection of the list of registered
> > protocols is held during all the protocol initialization phase.
> > 
> > Such a wide locking region is not needed and causes problem when trying to
> > initialize notifications from within a protocol initialization routine.
> > 
> > Reduce the scope of the protocol mutex.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> Hi Cristian.  A few things inline and this runs into one of the things
> that is dangerous to do with guard() or the other cleanup.h magic
> (and documented there!)

Hi Jonathan,

thanks for having a look at this series.

> 
> > ---
> >  drivers/firmware/arm_scmi/driver.c | 53 +++++++++++++++---------------
> >  1 file changed, 26 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index bd56a877fdfc..71ee25b78624 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -17,6 +17,7 @@
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> >  #include <linux/bitmap.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> > @@ -2179,10 +2180,13 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
> >  	if (ret)
> >  		goto clean;
> >  
> > -	ret = idr_alloc(&info->protocols, pi, proto->id, proto->id + 1,
> > -			GFP_KERNEL);
> > -	if (ret != proto->id)
> > -		goto clean;
> > +	/* Finally register the initialized protocol */
> > +	scoped_guard(mutex, &info->protocols_mtx) {
> 
> See the guidance in cleanup.h on mixing goto and anything defined in that file.
> 
> In some compilers, if you hit the goto above and hence jump over this
> the cleanup variable will still be instantiated, but not initialized leading to
> a potential attempt to unlock random memory.
> 
> Either this needs more substantial rework, or just handling the mutex with
> out using guards.
> 

Thanks for the heads-up I will dig better into cleanup.h which obviously
I did not enough...my bad.

> 
> > +		ret = idr_alloc(&info->protocols, pi, proto->id, proto->id + 1,
> > +				GFP_KERNEL);
> > +		if (ret != proto->id)
> > +			goto clean;
> > +	}
> >  
> >  	/*
> >  	 * Warn but ignore events registration errors since we do not want
> > @@ -2243,25 +2247,22 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
> >  static struct scmi_protocol_instance * __must_check
> >  scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
> >  {
> > -	struct scmi_protocol_instance *pi;
> > +	struct scmi_protocol_instance *pi = ERR_PTR(-EPROBE_DEFER);
> >  	struct scmi_info *info = handle_to_scmi_info(handle);
> > +	const struct scmi_protocol *proto;
> >  
> > -	mutex_lock(&info->protocols_mtx);
> > -	pi = idr_find(&info->protocols, protocol_id);
> > -
> > -	if (pi) {
> > -		refcount_inc(&pi->users);
> > -	} else {
> > -		const struct scmi_protocol *proto;
> > -
> > -		/* Fails if protocol not registered on bus */
> > -		proto = scmi_protocol_get(protocol_id, &info->version);
> > -		if (proto)
> > -			pi = scmi_alloc_init_protocol_instance(info, proto);
> > -		else
> > -			pi = ERR_PTR(-EPROBE_DEFER);
> > +	scoped_guard(mutex, &info->protocols_mtx) {
> > +		pi = idr_find(&info->protocols, protocol_id);
> > +		if (pi) {
> 
> if !pi we carry on with it NULL, which is a behavior change from
> before where it would be ERR_PTR(-EPROBE_DEFER);
> 
> That might not matter, but it's not 'obviously' a safe change.

You are right...also the Dox comment is obsoleted..I will review this
patch as a whole, since even if probably right in its essence is badly
implemented because I rushed it in in this series to fix a probblem that
popped up on KASAN.

> 
> > +			refcount_inc(&pi->users);
> > +			return pi;
> > +		}
> >  	}
> > -	mutex_unlock(&info->protocols_mtx);
> > +
> > +	/* Fails if protocol not registered on bus */
> > +	proto = scmi_protocol_get(protocol_id, &info->version);
> > +	if (proto)
> Trivial but I'd flip the logic to
> 	if (!proto)
> 		return ERR_PTR(-EPROBE_DEFER);
> assuming a NULL return as mentioned above isn't the intent.
> Then
> 	return scmi_alloc_init_protocol_instance(info, protoo);

Yes this seems a better rework...

Thanks,
Cristian

