Return-Path: <linux-kernel+bounces-858327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0ECBEA434
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7474943810
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2789D32C93B;
	Fri, 17 Oct 2025 15:37:35 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390A9330B01;
	Fri, 17 Oct 2025 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715454; cv=none; b=PKW3j+U25fU88vNSeBXDPyqgJ1l/EONKgNcyqZ26p4+9LUwfSmgV+qTWq0sO4wY6Jhom6l3Zffl/GEeuXq3P2fkA2YGhea9WuXV5ZOuPYhiO/0Sh817wDAXzj1G4mHEA2WDrriEOvlE3+hslLtzWfulrivbNs6nJS3d0eI1J5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715454; c=relaxed/simple;
	bh=EayoAPJw6grlDitBvTA/40wyIhYeHzapzOAUVqQ4WpM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJkt2TurILS2cVyAhyN/khbmH8ZcpvCDqn+pNZ0iwNvUDCjMl4EJIOCIugJvBbEjwst/llK2qRn8MyEfV+dm4SjhYnmbH7WApw+ImXZ4A5iV1l1z4HsvRbu8WddZF4cQBLrYXKWJB1cI9uGkl7mZ97oxVt76Rg/Kn9d8Ij7iTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cp87775kTz689xS;
	Fri, 17 Oct 2025 23:36:19 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5848C1402DA;
	Fri, 17 Oct 2025 23:37:28 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Oct
 2025 16:37:27 +0100
Date: Fri, 17 Oct 2025 16:37:25 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<arm-scmi@vger.kernel.org>, <sudeep.holla@arm.com>,
	<james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
	<vincent.guittot@linaro.org>, <etienne.carriere@st.com>,
	<peng.fan@oss.nxp.com>, <michal.simek@amd.com>, <quic_sibis@quicinc.com>,
	<dan.carpenter@linaro.org>, <d-gole@ti.com>, <souvik.chakravarty@arm.com>
Subject: Re: [PATCH 05/10] firmware: arm_scmi: Add Telemetry protocol
 support
Message-ID: <20251017163725.0000149e@huawei.com>
In-Reply-To: <20250925203554.482371-6-cristian.marussi@arm.com>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
	<20250925203554.482371-6-cristian.marussi@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 25 Sep 2025 21:35:49 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Add basic support for SCMI V4.0-alpha_0 Telemetry protocol including SHMTI,
> FastChannels, Notifications and Single Sample Reads collection methods.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Hi,

This is very much in the superficial drive by category as reviews
go.  A few things noted but I've not looked at the code in enough
detail.

Jonathan


> diff --git a/drivers/firmware/arm_scmi/telemetry.c b/drivers/firmware/arm_scmi/telemetry.c
> new file mode 100644
> index 000000000000..f03000c173c2
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/telemetry.c
> @@ -0,0 +1,2117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Management Interface (SCMI) Telemetry Protocol
> + *
> + * Copyright (C) 2025 ARM Ltd.
> + *
My favorite trivial comment applies.  What does this blank line add
to readability? I'd drop it.

> + */

> +
> +struct scmi_de_desc {
> +	__le32 id;
> +	__le32 grp_id;
> +	__le32 data_sz;
> +	__le32 attr_1;
> +#define	IS_NAME_SUPPORTED(d)	((d)->attr_1 & BIT(31))
> +#define	IS_FC_SUPPORTED(d)	((d)->attr_1 & BIT(30))
> +#define	GET_DE_TYPE(d)		(le32_get_bits((d)->attr_1, GENMASK(29, 22)))
> +#define	IS_PERSISTENT(d)	((d)->attr_1 & BIT(21))
> +#define GET_DE_UNIT_EXP(d)						\
> +	({								\
> +		int __signed_exp =					\
> +			le32_get_bits((d)->attr_1, GENMASK(20, 13));	\
> +									\
> +		if (__signed_exp & BIT(7))				\
> +			__signed_exp |= GENMASK(31, 8);			\
> +		__signed_exp;						\
> +	})
> +#define	GET_DE_UNIT(d)		(le32_get_bits((d)->attr_1, GENMASK(12, 5)))
> +
> +#define GET_DE_TSTAMP_EXP(d)						\
> +	({								\
> +		int __signed_exp =					\
> +			FIELD_GET(GENMASK(4, 1), (d)->attr_1);		\
> +									\
> +		if (__signed_exp & BIT(3))				\
> +			__signed_exp |= GENMASK(31, 4);			\
> +		__signed_exp;						\
See below for sign_extend32() using code to replace these.


> +
> +struct scmi_msg_resp_telemetry_reading_complete {
> +	__le32 num_dwords;
> +	__le32 dwords[];
__counted_by(num_word);

> +};
> +
> +/* TDCF */
> +
> +#define TO_CPU_64(h, l)	(((u64)le32_to_cpu((h)) << 32) | le32_to_cpu((l)))
Some of this stuff sounds very generic and isn't at all.

Personally I think I'd just drop this one as it may be better to see
the implementation wherever it is used.

> +static int scmi_telemetry_tdcf_line_parse(struct telemetry_info *ti,
> +					  struct payload __iomem *payld,
> +					  struct telemetry_shmti *shmti,
> +					  bool update)
> +{
> +	int used_qwords;
> +
> +	used_qwords = (USE_LINE_TS(payld) && TS_VALID(payld)) ?
> +		QWORDS_TS_LINE_DATA_PAYLD : QWORDS_LINE_DATA_PAYLD;
> +
> +	/*Invalid lines are not an error, could simply be disabled DEs */

Check for inconsistent comment syntax etc.

> +	if (DATA_INVALID(payld))
> +		return used_qwords;

> +
> +static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
> +				     unsigned int shmti_id, u64 ts,
> +				     bool update)
> +{
> +	struct telemetry_shmti *shmti = &ti->shmti[shmti_id];
> +	struct tdcf __iomem *tdcf = shmti->base;
> +	int retries = SCMI_TLM_TDCF_MAX_RETRIES;
> +	u64 startm = 0, endm = 0xffffffffffffffff;

No one likes counting fs.  Use a GENMASK probably.

> +	void *eplg = SHMTI_EPLG(shmti);


> +static void
> +scmi_telemetry_msg_payld_process(struct telemetry_info *ti,
> +				 unsigned int num_dwords, unsigned int *dwords,

I'd kind of expect something called dwords to have a fixed size. u32, u64 or
whatever.

> +				 ktime_t timestamp)
> +{
> +	u32 next = 0;
> +
> +	while (next < num_dwords) {
> +		struct payload *payld = (struct payload *)&dwords[next];
> +		struct scmi_telemetry_de *de;
> +		struct telemetry_de *tde;
> +		u32 de_id;
> +
> +		next += USE_LINE_TS(payld) ?
> +			TS_LINE_DATA_PAYLD_WORDS : LINE_DATA_PAYLD_WORDS;
> +
> +		if (DATA_INVALID(payld)) {
> +			dev_err(ti->dev, "MSG - Received INVALID DATA line\n");
> +			continue;
> +		}
> +
> +		de_id = le32_to_cpu(payld->id);
> +		de = xa_load(&ti->xa_des, de_id);
> +		if (!de || !de->enabled) {
> +			dev_err(ti->dev,
> +				"MSG - Received INVALID DE - ID:%u  enabled:%d\n",
> +				de_id, de ? (de->enabled ? 'Y' : 'N') : 'X');
> +			continue;
> +		}
> +
> +		tde = to_tde(de);
> +		guard(mutex)(&tde->mtx);
> +		tde->cached = true;
> +		tde->last_val = LINE_DATA_GET(&payld->tsl);
> +		//TODO BLK_TS in notification payloads
> +		if (USE_LINE_TS(payld) && TS_VALID(payld))
> +			tde->last_ts = LINE_TSTAMP_GET(&payld->tsl);
> +		else
> +			tde->last_ts = 0;
> +	}
> +}


> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index 59527193d6dd..6c6db95d0089 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h

...

> +#define	SCMI_TLM_GET_UPDATE_INTERVAL_SECS(x)				\
> +	(le32_get_bits((x), GENMASK(20, 5)))
Why is this one little endian specific and the next just uses assumption of
CPU Endian?

> +#define SCMI_TLM_GET_UPDATE_INTERVAL_EXP(x)				\
> +	({								\
> +		int __signed_exp = FIELD_GET(GENMASK(4, 0), (x));	\
> +									\
> +		if (__signed_exp & BIT(4))				\
> +			__signed_exp |= GENMASK(31, 5);			\
sign_extend32() from bitops.h should work here and is much more self explanatory.
That would then make this something like

#define SCMI_TLM_GET_UPDATE_INTERVAL_EXP(x) \
 	sign_extend32(x, 4);
or you can mask it first if you like but I don't think it makes any difference
in practice.

> +		__signed_exp;						\
> +	})
> +
> +#define SCMI_TLM_BUILD_UPDATE_INTERVAL(s, e)				    \
> +	(FIELD_PREP(GENMASK(20, 5), (s)) | FIELD_PREP(GENMASK(4, 0), (e)))

> +
> +struct scmi_telemetry_update_report {
> +	ktime_t		timestamp;
> +	unsigned int	agent_id;
> +	int		status;
> +	unsigned int	num_dwords;
> +	unsigned int	dwords[];

More places where __counted_by is appropriate. I'll not comment on any others and
just assume you'll add them wherever appropriate.

> +};

