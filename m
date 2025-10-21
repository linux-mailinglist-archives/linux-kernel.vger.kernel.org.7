Return-Path: <linux-kernel+bounces-862532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE19BF58B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460E9426C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84292E1F0A;
	Tue, 21 Oct 2025 09:37:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E40F2EBDFB;
	Tue, 21 Oct 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039459; cv=none; b=fqo+10rE62h+dzBA9ZlrmDGDNpW5aUTc26BQg3+yDhNSAatbJOLMvprHFGYhb3wfq9Oa/AwqJWF35gRZWrZJZR8Bmb4CNph40qQPsWH4LXdOv7BM4nSSz2HWicuTN039AJQDKxsYGusAPDwXvZBkXXWxymP99oBo1o16KMkzBow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039459; c=relaxed/simple;
	bh=0C7yi5X5N64VqnLTrnEdPerCniDmfPL8ucAx64o1Ass=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMWk836DwSdw0qkEiCnGEonaAHL+UtYIgk4ZpsEelwSkGU4SmWgLFoCqf0GIS5PDyYsReioXGauezm8juk584qQH11DXRDhKxDRdkuBDg+k76uf7WOc+eTjcy3X6V/Jd8PT+5zGfe/xWAVe5DazQxgJwXXwSWw4MnUSuH2dzAJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC6391007;
	Tue, 21 Oct 2025 02:37:28 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 415CF3F66E;
	Tue, 21 Oct 2025 02:37:34 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:37:31 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH 03/10] firmware: arm_scmi: Allow protocols to register
 for notifications
Message-ID: <aPdUWz8DkYp_Xooy@pluto>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
 <20250925203554.482371-4-cristian.marussi@arm.com>
 <20251017161014.0000347c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017161014.0000347c@huawei.com>

On Fri, Oct 17, 2025 at 04:10:14PM +0100, Jonathan Cameron wrote:
> On Thu, 25 Sep 2025 21:35:47 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Allow protocols themselves to register for their own notifications and
> > providing their own notifier callbacks. While at that, allow for a protocol
> > to register events with compilation-time unknown report/event sizes: such
> > events will use the maximum transport size.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> Hi Cristian,
>

Hi,
 
> A few drive by comments...
> 
> > diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> > index 78e9e27dc9ec..3e623c14745d 100644
> > --- a/drivers/firmware/arm_scmi/notify.c
> > +++ b/drivers/firmware/arm_scmi/notify.c
> > @@ -593,7 +593,12 @@ int scmi_notify(const struct scmi_handle *handle, u8 proto_id, u8 evt_id,
> >  	if (!r_evt)
> >  		return -EINVAL;
> >  
> > -	if (len > r_evt->evt->max_payld_sz) {
> > +	/* Events with a zero max_payld_sz are sized to be of the maximum
> Local multiline comment syntax seems to be
> 	/*
> 	 * Events...

Yes of course...

> 
> > +	 * size allowed by the transport: no need to be size-checked here
> > +	 * since the transport layer would have already dropped such
> > +	 * over-sized messages.
> > +	 */
> > +	if (r_evt->evt->max_payld_sz && len > r_evt->evt->max_payld_sz) {
> 
> > diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
> > index d62c4469d1fd..2e40a7bb5b01 100644
> > --- a/drivers/firmware/arm_scmi/protocols.h
> > +++ b/drivers/firmware/arm_scmi/protocols.h
> > @@ -161,8 +161,13 @@ struct scmi_proto_helpers_ops;
> >   * @dev: A reference to the associated SCMI instance device (handle->dev).
> >   * @xops: A reference to a struct holding refs to the core xfer operations that
> >   *	  can be used by the protocol implementation to generate SCMI messages.
> > + * @hops: A reference to a struct holding refs to the common helper operations
> > + *	  that can be used by the protocol implementation.
> 
> @hops isn't added in this patch so either it should be handled in where it was
> added, or if that was missed a precursor patch to this one.

Indeed.

Thanks,
Cristian

