Return-Path: <linux-kernel+bounces-862540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 239F0BF58F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83E93352A68
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6382EBDFB;
	Tue, 21 Oct 2025 09:41:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D527F284B2E;
	Tue, 21 Oct 2025 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039665; cv=none; b=GWcDUOGWqAgghihJS3bPcQNKeK1ToHbBiy+tMeD6y3cUGJ91DVSP1DKG2CcrdcErHVDksTNyiCpW3XfSHP+opxkVXF9v564NnRjIyRszz4JQIqd/gQa8u9lylQPM2DRndOFX+zMuWVfJ/pdfI8Wb6+3L3S60WZecKaxaQ52S7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039665; c=relaxed/simple;
	bh=4Tnnto2TH1IHey+e0OhwvysQGLzs8Abf1kUmbRf+ytg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0eMu5zGYycrVujtBI6NYGPR7Ahjt2otO+czwRlpFk4kBHqkSpJjevJTfUdhXOPAU9SfGyxMNdYxng6kApFXOQjD9VJI7SPxxfzomFPkGU1Ee3xqVUz9Y8huTSyCobER1Q5GTIqw8RTVxw0d9JOFxZ5rm1dzcCTMkqsaXB05LYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 628911007;
	Tue, 21 Oct 2025 02:40:55 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD5523F66E;
	Tue, 21 Oct 2025 02:41:00 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:40:58 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH 04/10] uapi: Add ARM SCMI definitions
Message-ID: <aPdVKtKWNqB5dzkE@pluto>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
 <20250925203554.482371-5-cristian.marussi@arm.com>
 <20251017161401.00002891@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017161401.00002891@huawei.com>

On Fri, Oct 17, 2025 at 04:14:01PM +0100, Jonathan Cameron wrote:
> On Thu, 25 Sep 2025 21:35:48 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Add a number of structures and ioctls definitions used by the ARM
> > SCMI Telemetry protocol.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> Hi Cristian,
> 

Hi,

> Main thing in here is request to add __counted_by markings for the flexible array members.

...right...missed that completely...

> 
> >  SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX Extension Message Protocol drivers
> > diff --git a/include/uapi/linux/scmi.h b/include/uapi/linux/scmi.h
> > new file mode 100644
> > index 000000000000..b1a6d34fee4a
> > --- /dev/null
> > +++ b/include/uapi/linux/scmi.h
> > @@ -0,0 +1,286 @@
> 
> > +
> > +/**
> > + * scmi_tlm_config  - Whole instance or group configuration
> > + *
> > + * @enable: Enable/Disable Telemetry for the whole instance or the group
> > + * @t_enable: Enable/Disable timestamping for all the DEs belonging to a group.
> I'm fairly sure that even for reserved the kernel-doc script will complain if no
> documentation.  (I haven't checked if it special cases that though!)

Right..

> > + * @current_update_interval: Get/Set currently active update interval for the
> > + *			     whole instance or a group.
> > + *
> > + * Used by:
> > + *	RO - SCMI_TLM_GET_CFG
> > + *	WO - SCMI_TLM_SET_CFG
> > + *
> > + * Supported by:
> > + *	control/
> > + *	groups/<N>/control
> > + */
> > +struct scmi_tlm_config {
> > +	__u8 enable;
> > +	__u8 t_enable;
> > +	__u8 reserved[2];
> > +	__u32 current_update_interval;
> > +};
> 
> > +/**
> > + * scmi_tlm_grps_list  - DE-groups List
> > + *
> > + * @num_grps: Number of entries returned in @grps
> > + * @grps: An array containing descriptors for all defined DE Groups
> > + *
> > + * Used by:
> > + *	RW - SCMI_TLM_GET_GRP_LIST
> > + *
> > + * Supported by:
> > + *	control/
> > + */
> > +struct scmi_tlm_grps_list {
> > +	__u32 num_grps;
> > +	struct scmi_tlm_grp_info grps[];
> 
> As below on __counted_by

I will add.

> 
> > +};
> > +
> > +/**
> > + * scmi_tlm_grp_desc  - Group descriptor
> > + *
> > + * @num_des: Number of DEs part of this group
> > + * @composing_des: An array containing the DE IDs that belongs to this group.
> > + *
> > + * Used by:
> > + *	RW - SCMI_TLM_GET_GRP_DESC
> > + *
> > + * Supported by:
> > + *	groups/<N>control/
> > + */
> > +struct scmi_tlm_grp_desc {
> > +	__u32 num_des;
> > +	__u32 composing_des[];
> 
> If we can give this a __counted_by marking please do.
>

I will.

Thanks,
Cristian

