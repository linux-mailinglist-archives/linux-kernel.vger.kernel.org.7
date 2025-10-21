Return-Path: <linux-kernel+bounces-862626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560C7BF5C87
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033183AAAC7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4FD221FC8;
	Tue, 21 Oct 2025 10:30:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AF9354AEB;
	Tue, 21 Oct 2025 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042625; cv=none; b=auNLJ2FbJBRltoxhbgvbni1PeQT7xJM0eD+vDfxQQC8q5cLLPRVUZ/rB0WnehtaRoCvVV5mCC48xGuh4v09dvgofdzfhhvtTqVBeX8oxs4Vq1nHnaLgMTvjuZYYujV/hnt364fqKrrHhUtA8NN+RYv1edTQSYOP3Jpx2mcRdonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042625; c=relaxed/simple;
	bh=P66ClT1fWhQjf6Qvs/MOrFEm/tds42Eov2fDYBRqHZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flTiNsfg5Xy7W2c2s++Yh3mVCO+4oBeupaZMMngxAvAgDYWCs32xcYhhbMFjjAupZrtO8+CLY2ml/jBWe+/nNyy/Ev6FH9Ct1Y6+uMQpZZdTNUnMvcKridUqbfXUPhGZOd8Kh+Ar906inh9RVyYKjUm0JOmc31HXhOAWhWGsJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DC221007;
	Tue, 21 Oct 2025 03:30:13 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72FA43F63F;
	Tue, 21 Oct 2025 03:30:18 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:30:16 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH 07/10] firmware: arm_scmi: Add System Telemetry ioctls
 support
Message-ID: <aPdguGJ-fZFF7L3Y@pluto>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
 <20250925203554.482371-8-cristian.marussi@arm.com>
 <20251020173034.00005c15@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020173034.00005c15@huawei.com>

On Mon, Oct 20, 2025 at 05:30:34PM +0100, Jonathan Cameron wrote:
> On Thu, 25 Sep 2025 21:35:51 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Extend the filesystem based interface with special 'control' file that can
> > be used to configure and retrieve SCMI Telemetry data in binary form using
> > the alternative ioctls-based ABI described in uapi/linux/scmi.h.
> Why you say alternative.  Why do you need both?
> 
> That's in the cover letter but I'd put something here as well.

Ok..indeed all my babbling in teh cover wont be anywhere once merged.

> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  .../firmware/arm_scmi/scmi_system_telemetry.c | 402 ++++++++++++++++++
> >  1 file changed, 402 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/scmi_system_telemetry.c b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
> > index 2fec465b0f33..f591aad10302 100644
> > --- a/drivers/firmware/arm_scmi/scmi_system_telemetry.c
> > +++ b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
> 
> > +static long scmi_tlm_des_read_ioctl(const struct scmi_tlm_inode *tlmi,
> > +				    unsigned long arg, bool single,
> > +				    bool is_group)
> > +{
> > +	const struct scmi_tlm_setup *tsp = tlmi->tsp;
> > +	void * __user uptr = (void * __user)arg;
> > +	struct scmi_tlm_data_read bulk, *bulk_ptr;
> > +	int ret, grp_id = SCMI_TLM_GRP_INVALID;
> > +
> > +	if (copy_from_user(&bulk, uptr, sizeof(bulk)))
> > +		return -EFAULT;
> > +
> > +	bulk_ptr = kzalloc(struct_size(bulk_ptr, samples, bulk.num_samples),
> 
> __free() would help here.
> 

Ok.

> > +			   GFP_KERNEL);
> > +	if (!bulk_ptr)
> > +		return -ENOMEM;
> > +
> > +	if (is_group) {
> > +		const struct scmi_telemetry_group *grp = tlmi->priv;
> > +
> > +		grp_id = grp->info->id;
> > +	}
> > +
> > +	bulk_ptr->num_samples = bulk.num_samples;
> > +	if (!single)
> > +		ret = tsp->ops->des_bulk_read(tsp->ph, grp_id,
> > +					      &bulk_ptr->num_samples,
> > +			  (struct scmi_telemetry_de_sample *)bulk_ptr->samples);
> > +	else
> > +		ret = tsp->ops->des_sample_get(tsp->ph, grp_id,
> > +					       &bulk_ptr->num_samples,
> > +			  (struct scmi_telemetry_de_sample *)bulk_ptr->samples);
> 
> That is very unusual code alignment.  Drag 2 lines above left to match one line above.

Trying to please checkpatch while staying under 80 cols...BUT I know is NOT a
good reason for the above mess...

Thanks,
Cristian

