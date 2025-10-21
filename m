Return-Path: <linux-kernel+bounces-862590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF92BF5B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12C7F3435F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797EA31329A;
	Tue, 21 Oct 2025 10:08:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02D21DE3A4;
	Tue, 21 Oct 2025 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041303; cv=none; b=iEhMeY9ffgTeaTIlrpR8qQPni+qPdQat40VCeBrRDf+0Rf+lo57ILA+YMjbMW8qiIfBXXmCFzs1XzanCYggEKzeSRFNp8tmOxn/+q70RFSSCUHJilBpeh5ye/Z29JM4LzHGEUBT7+DaaTE0mlnRd7qe5/dqcGlhFTBVshhlJV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041303; c=relaxed/simple;
	bh=5F/pG4fVXXeht79zb9qGffvhKHMbfDy4Mh1CYkQ96qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4G1wtOo9yCwvG9HUNWzR8dzsKBaqOEtnsJDRPE/HTtmGkyGmXDYoPK8PPjKwQ4M1y23xOeMe8mGrn7lq82RW7Vft8P6EJt5svTf1Zu9lTySKmo7KEFqvUuXhLQOQvM6Nms68hXmRssu0uiUJUX1UExqCdQ2HB99NpUtUN9wZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21CC01007;
	Tue, 21 Oct 2025 03:08:13 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 871993F63F;
	Tue, 21 Oct 2025 03:08:18 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:08:16 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH 05/10] firmware: arm_scmi: Add Telemetry protocol support
Message-ID: <aPdbkHixRsWjsZ3d@pluto>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
 <20250925203554.482371-6-cristian.marussi@arm.com>
 <20251017163725.0000149e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017163725.0000149e@huawei.com>

On Fri, Oct 17, 2025 at 04:37:25PM +0100, Jonathan Cameron wrote:
> On Thu, 25 Sep 2025 21:35:49 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Add basic support for SCMI V4.0-alpha_0 Telemetry protocol including SHMTI,
> > FastChannels, Notifications and Single Sample Reads collection methods.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> Hi,
> 

Hi thanks for having a look

> This is very much in the superficial drive by category as reviews
> go.  A few things noted but I've not looked at the code in enough
> detail.

...this is still very early days as a series since I moved across a few
different implementations in the previous RFCs, so as noted in the
cover-letter there are in general lots of open-issues...

...BUT I am sure there will be more after this review :P

Thanks for the feedback in the meantime.

> 
> Jonathan
> 
> 
> > diff --git a/drivers/firmware/arm_scmi/telemetry.c b/drivers/firmware/arm_scmi/telemetry.c
> > new file mode 100644
> > index 000000000000..f03000c173c2
> > --- /dev/null
> > +++ b/drivers/firmware/arm_scmi/telemetry.c
> > @@ -0,0 +1,2117 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * System Control and Management Interface (SCMI) Telemetry Protocol
> > + *
> > + * Copyright (C) 2025 ARM Ltd.
> > + *
> My favorite trivial comment applies.  What does this blank line add
> to readability? I'd drop it.
> 

... I would say..at the moment felt right :P ... but there is no need
and I wil drop it.

> > + */
> 
> > +
> > +struct scmi_de_desc {
> > +	__le32 id;
> > +	__le32 grp_id;
> > +	__le32 data_sz;
> > +	__le32 attr_1;
> > +#define	IS_NAME_SUPPORTED(d)	((d)->attr_1 & BIT(31))
> > +#define	IS_FC_SUPPORTED(d)	((d)->attr_1 & BIT(30))
> > +#define	GET_DE_TYPE(d)		(le32_get_bits((d)->attr_1, GENMASK(29, 22)))
> > +#define	IS_PERSISTENT(d)	((d)->attr_1 & BIT(21))
> > +#define GET_DE_UNIT_EXP(d)						\
> > +	({								\
> > +		int __signed_exp =					\
> > +			le32_get_bits((d)->attr_1, GENMASK(20, 13));	\
> > +									\
> > +		if (__signed_exp & BIT(7))				\
> > +			__signed_exp |= GENMASK(31, 8);			\
> > +		__signed_exp;						\
> > +	})
> > +#define	GET_DE_UNIT(d)		(le32_get_bits((d)->attr_1, GENMASK(12, 5)))
> > +
> > +#define GET_DE_TSTAMP_EXP(d)						\
> > +	({								\
> > +		int __signed_exp =					\
> > +			FIELD_GET(GENMASK(4, 1), (d)->attr_1);		\
> > +									\
> > +		if (__signed_exp & BIT(3))				\
> > +			__signed_exp |= GENMASK(31, 4);			\
> > +		__signed_exp;						\
> See below for sign_extend32() using code to replace these.
> 

Sadly enough, in the past I am sure I have also searched for something similar
and did not find it despite being merged since 2010 apparently... :<

> 
> > +
> > +struct scmi_msg_resp_telemetry_reading_complete {
> > +	__le32 num_dwords;
> > +	__le32 dwords[];
> __counted_by(num_word);
>

Mmmm, this is really used to cast to a variable sized received message
payload..is the __counted_by gonna work as intended in this case ?
..because this means a bad sizing could be triggered by a bad FW...

(I suppose I will find my answer looking better at __counted_by inner workings...)

I will check anyway the processing of this var size message...
 
> > +};
> > +
> > +/* TDCF */
> > +
> > +#define TO_CPU_64(h, l)	(((u64)le32_to_cpu((h)) << 32) | le32_to_cpu((l)))
> Some of this stuff sounds very generic and isn't at all.
> 
> Personally I think I'd just drop this one as it may be better to see
> the implementation wherever it is used.

Ok ...it was to avoid a bit of duplication in some macros down below
and made the intent more clear from the name..

> 
> > +static int scmi_telemetry_tdcf_line_parse(struct telemetry_info *ti,
> > +					  struct payload __iomem *payld,
> > +					  struct telemetry_shmti *shmti,
> > +					  bool update)
> > +{
> > +	int used_qwords;
> > +
> > +	used_qwords = (USE_LINE_TS(payld) && TS_VALID(payld)) ?
> > +		QWORDS_TS_LINE_DATA_PAYLD : QWORDS_LINE_DATA_PAYLD;
> > +
> > +	/*Invalid lines are not an error, could simply be disabled DEs */
> 
> Check for inconsistent comment syntax etc.

Ok.

> 
> > +	if (DATA_INVALID(payld))
> > +		return used_qwords;
> 
> > +
> > +static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
> > +				     unsigned int shmti_id, u64 ts,
> > +				     bool update)
> > +{
> > +	struct telemetry_shmti *shmti = &ti->shmti[shmti_id];
> > +	struct tdcf __iomem *tdcf = shmti->base;
> > +	int retries = SCMI_TLM_TDCF_MAX_RETRIES;
> > +	u64 startm = 0, endm = 0xffffffffffffffff;
> 
> No one likes counting fs.  Use a GENMASK probably.

Yes definitely better, even though is not really a mask but just a fixed
invalid value to use at start...

> 
> > +	void *eplg = SHMTI_EPLG(shmti);
> 
> 
> > +static void
> > +scmi_telemetry_msg_payld_process(struct telemetry_info *ti,
> > +				 unsigned int num_dwords, unsigned int *dwords,
> 
> I'd kind of expect something called dwords to have a fixed size. u32, u64 or
> whatever.

Yes I agree.

> 
> > +				 ktime_t timestamp)
> > +{
> > +	u32 next = 0;
> > +
> > +	while (next < num_dwords) {
> > +		struct payload *payld = (struct payload *)&dwords[next];
> > +		struct scmi_telemetry_de *de;
> > +		struct telemetry_de *tde;
> > +		u32 de_id;
> > +
> > +		next += USE_LINE_TS(payld) ?
> > +			TS_LINE_DATA_PAYLD_WORDS : LINE_DATA_PAYLD_WORDS;
> > +
> > +		if (DATA_INVALID(payld)) {
> > +			dev_err(ti->dev, "MSG - Received INVALID DATA line\n");
> > +			continue;
> > +		}
> > +
> > +		de_id = le32_to_cpu(payld->id);
> > +		de = xa_load(&ti->xa_des, de_id);
> > +		if (!de || !de->enabled) {
> > +			dev_err(ti->dev,
> > +				"MSG - Received INVALID DE - ID:%u  enabled:%d\n",
> > +				de_id, de ? (de->enabled ? 'Y' : 'N') : 'X');
> > +			continue;
> > +		}
> > +
> > +		tde = to_tde(de);
> > +		guard(mutex)(&tde->mtx);
> > +		tde->cached = true;
> > +		tde->last_val = LINE_DATA_GET(&payld->tsl);
> > +		//TODO BLK_TS in notification payloads
> > +		if (USE_LINE_TS(payld) && TS_VALID(payld))
> > +			tde->last_ts = LINE_TSTAMP_GET(&payld->tsl);
> > +		else
> > +			tde->last_ts = 0;
> > +	}
> > +}
> 
> 
> > diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> > index 59527193d6dd..6c6db95d0089 100644
> > --- a/include/linux/scmi_protocol.h
> > +++ b/include/linux/scmi_protocol.h
> 
> ...
> 
> > +#define	SCMI_TLM_GET_UPDATE_INTERVAL_SECS(x)				\
> > +	(le32_get_bits((x), GENMASK(20, 5)))
> Why is this one little endian specific and the next just uses assumption of
> CPU Endian?

Mmmm is not becasue the next one extract a 5 bit value that being < 8bit
has no endianity issue ?

....haviong said that...I think this version has a lot of endian issue to be
fixed as pointed out also by the kernel bots...

> 
> > +#define SCMI_TLM_GET_UPDATE_INTERVAL_EXP(x)				\
> > +	({								\
> > +		int __signed_exp = FIELD_GET(GENMASK(4, 0), (x));	\
> > +									\
> > +		if (__signed_exp & BIT(4))				\
> > +			__signed_exp |= GENMASK(31, 5);			\
> sign_extend32() from bitops.h should work here and is much more self explanatory.
> That would then make this something like
> 
> #define SCMI_TLM_GET_UPDATE_INTERVAL_EXP(x) \
>  	sign_extend32(x, 4);
> or you can mask it first if you like but I don't think it makes any difference
> in practice.

Yes using well known helpers is much better...I will rework and
test...just in case :D

> 
> > +		__signed_exp;						\
> > +	})
> > +
> > +#define SCMI_TLM_BUILD_UPDATE_INTERVAL(s, e)				    \
> > +	(FIELD_PREP(GENMASK(20, 5), (s)) | FIELD_PREP(GENMASK(4, 0), (e)))
> 
> > +
> > +struct scmi_telemetry_update_report {
> > +	ktime_t		timestamp;
> > +	unsigned int	agent_id;
> > +	int		status;
> > +	unsigned int	num_dwords;
> > +	unsigned int	dwords[];
> 
> More places where __counted_by is appropriate. I'll not comment on any others and
> just assume you'll add them wherever appropriate.
> 

Sure, but, as said above, I will reason a bit on the places where the struct is used
to cast a received FW payload (which is NOT the case in this latter example...)

Thanks,
Crisian

