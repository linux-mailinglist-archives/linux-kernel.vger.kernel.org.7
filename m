Return-Path: <linux-kernel+bounces-873681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA94FC146D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDC819813D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C4E3090EA;
	Tue, 28 Oct 2025 11:43:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188E2E6127;
	Tue, 28 Oct 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651809; cv=none; b=e2cI1f30LSPXCT4qq4FyXfM1nKX/PubruByVBroJk5ajPqK26IcFxMIWFwOtqG/nz7AhRIuqZ2haQaX++G4A01yo0M4XRRN7gEiuAFuu5dd/sWYRZ2Q3C4lkUdplqS50nEboX6VwZ51NSko+J1Ypgf49TMRstaZ4i1PQmDX/h0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651809; c=relaxed/simple;
	bh=Fuq1RBGzV4iEUfEPG4R/pEcstDZjHcroAqxtEYsVdak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVrXaOrORJOe5p7dvu4Y3F9CbnLe8vRxr9XWK6yaPNbawVmptEVM/Mv/u3G4ymq2EEG4pbwJX80Axf0+M+CkygGAvdjYo5Dv8VYoWlmgHYOFxodqK521c28jpnHZgoGMU/RkE2p2yiqmeoJftzLOXLEwGspCbQh+gADZk7CRqzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E88B1692;
	Tue, 28 Oct 2025 04:43:16 -0700 (PDT)
Received: from [10.57.39.55] (unknown [10.57.39.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCD183F673;
	Tue, 28 Oct 2025 04:43:21 -0700 (PDT)
Message-ID: <e9bf6624-b789-4dad-89ff-731cd62ccd07@arm.com>
Date: Tue, 28 Oct 2025 11:43:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] firmware: arm_scmi: Add Telemetry protocol support
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 f.fainelli@gmail.com, vincent.guittot@linaro.org, etienne.carriere@st.com,
 peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
 dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com,
 arm-scmi@vger.kernel.org
References: <20250925203554.482371-1-cristian.marussi@arm.com>
 <20250925203554.482371-6-cristian.marussi@arm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250925203554.482371-6-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Cristian,

This is a first attempt for the review, because there is so much code.
I might find something in the next step, because for now I still
haven't built full picture of it...

So far some comments are there, mostly about the cometic & structure
of code changes.

On 9/25/25 21:35, Cristian Marussi wrote:
> Add basic support for SCMI V4.0-alpha_0 Telemetry protocol including SHMTI,
> FastChannels, Notifications and Single Sample Reads collection methods.

Could it be possible to split this big patch to a few with those
mentioned features? It would also be easier to review (at least from
my perspective). If it too complex and interdependent than OK, I will
just continue.

> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/Makefile    |    2 +-
>   drivers/firmware/arm_scmi/driver.c    |    2 +
>   drivers/firmware/arm_scmi/protocols.h |    1 +
>   drivers/firmware/arm_scmi/telemetry.c | 2117 +++++++++++++++++++++++++
>   include/linux/scmi_protocol.h         |  185 ++-
>   5 files changed, 2305 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/firmware/arm_scmi/telemetry.c
> 
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index 780cd62b2f78..fe55b7aa0707 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -8,7 +8,7 @@ scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
>   scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
>   scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
>   scmi-protocols-y := base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
> -scmi-protocols-y += pinctrl.o
> +scmi-protocols-y += pinctrl.o telemetry.o
>   scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>   
>   obj-$(CONFIG_ARM_SCMI_PROTOCOL) += transports/
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 8f969d8b86a6..801d59e6b3bc 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -3468,6 +3468,7 @@ static int __init scmi_driver_init(void)
>   	scmi_system_register();
>   	scmi_powercap_register();
>   	scmi_pinctrl_register();
> +	scmi_telemetry_register();
>   
>   	return platform_driver_register(&scmi_driver);
>   }
> @@ -3486,6 +3487,7 @@ static void __exit scmi_driver_exit(void)
>   	scmi_system_unregister();
>   	scmi_powercap_unregister();
>   	scmi_pinctrl_unregister();
> +	scmi_telemetry_unregister();
>   
>   	platform_driver_unregister(&scmi_driver);
>   
> diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
> index 2e40a7bb5b01..edd83a02e272 100644
> --- a/drivers/firmware/arm_scmi/protocols.h
> +++ b/drivers/firmware/arm_scmi/protocols.h
> @@ -387,5 +387,6 @@ DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
>   DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
>   DECLARE_SCMI_REGISTER_UNREGISTER(system);
>   DECLARE_SCMI_REGISTER_UNREGISTER(powercap);
> +DECLARE_SCMI_REGISTER_UNREGISTER(telemetry);
>   
>   #endif /* _SCMI_PROTOCOLS_H */
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
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/refcount.h>
> +#include <linux/slab.h>
> +#include <linux/sprintf.h>
> +#include <linux/string.h>
> +#include <linux/xarray.h>
> +
> +#include "protocols.h"
> +#include "notify.h"
> +
> +/* Updated only after ALL the mandatory features for that version are merged */
> +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
> +
> +#define SCMI_TLM_TDCF_MAX_RETRIES	5
> +
> +enum scmi_telemetry_protocol_cmd {
> +	TELEMETRY_LIST_SHMTI = 0x3,
> +	TELEMETRY_DE_DESCRIPTION = 0x4,
> +	TELEMETRY_LIST_UPDATE_INTERVALS = 0x5,
> +	TELEMETRY_DE_CONFIGURE = 0x6,
> +	TELEMETRY_DE_ENABLED_LIST = 0x7, //TODO IMPLEMENT
> +	TELEMETRY_CONFIG_SET = 0x8,
> +	TELEMETRY_READING_COMPLETE = TELEMETRY_CONFIG_SET,
> +	TELEMETRY_CONFIG_GET = 0x9, //TODO IMPLEMENT !
> +	TELEMETRY_RESET = 0xA,
> +};
> +
> +struct scmi_msg_resp_telemetry_protocol_attributes {
> +	__le32 de_num;
> +	__le32 groups_num;
> +	__le32 de_implementation_rev_dword[SCMI_TLM_DE_IMPL_MAX_DWORDS];
> +	__le32 attributes;
> +#define SUPPORTS_SINGLE_READ(x)		((x) & BIT(31))
> +#define SUPPORTS_CONTINUOS_UPDATE(x)	((x) & BIT(30))
> +#define SUPPORTS_PER_GROUP_CONFIG(x)	((x) & BIT(18))
> +#define SUPPORTS_RESET(x)		((x) & BIT(17))
> +#define SUPPORTS_FC(x)			((x) & BIT(16))

I would move those defines into a dedicated section of
'all defines' which will have a comment for each such group.


> +};
> +
> +struct scmi_telemetry_update_notify_payld {
> +	__le32 agent_id;
> +	__le32 status;
> +	__le32 num_dwords;
> +	__le32 array[];
> +};
> +
> +struct scmi_shmti_desc {
> +	__le32 id;
> +	__le32 addr_low;
> +	__le32 addr_high;
> +	__le32 length;
> +};
> +
> +struct scmi_msg_resp_telemetry_shmti_list {
> +	__le32 num_shmti;
> +	struct scmi_shmti_desc desc[];
> +};
> +
> +struct de_desc_fc {
> +	__le32 addr_low;
> +	__le32 addr_high;
> +	__le32 size;
> +};
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
> +	})
> +#define	IS_TSTAMP_SUPPORTED(d)	((d)->attr_1 & BIT(0))
> +	__le32 attr_2;
> +#define	GET_DE_INSTA_ID(d)	(le32_get_bits((d)->attr_2, GENMASK(31, 24)))
> +#define	GET_COMPO_INSTA_ID(d)	(le32_get_bits((d)->attr_2, GENMASK(23, 8)))
> +#define	GET_COMPO_TYPE(d)	(le32_get_bits((d)->attr_2, GENMASK(7, 0)))


Same here. Adding them inside those structures causes somehow
complex to read and undertand block of code.
If you could move it into seperate 'macros' section, would that
casue you some issue?


> +	__le32 reserved;
> +};
> +
> +struct scmi_msg_resp_telemetry_de_description {
> +	__le32 num_desc;
> +	struct scmi_de_desc desc[];
> +};
> +
> +struct scmi_msg_telemetry_update_intervals {
> +	__le32 index;
> +	__le32 group_identifier;
> +#define	ALL_DES_NO_GROUP	0x0
> +#define SPECIFIC_GROUP_DES	0x1
> +#define ALL_DES_ANY_GROUP	0x2
> +	__le32 flags;
> +};
> +
> +struct scmi_msg_resp_telemetry_update_intervals {
> +	__le32 flags;
> +#define INTERVALS_DISCRETE(x)	(!((x) & BIT(12)))
> +	__le32 intervals[];
> +};
> +
> +struct scmi_msg_telemetry_de_configure {
> +	__le32 id;
> +	__le32 flags;
> +#define DE_ENABLE_NO_TSTAMP	BIT(0)
> +#define DE_ENABLE_WTH_TSTAMP	BIT(1)
> +#define DE_DISABLE_ALL		BIT(2)
> +#define GROUP_SELECTOR		BIT(3)
> +#define EVENT_DE		0
> +#define EVENT_GROUP		1
> +#define DE_DISABLE_ONE		0x0
> +};
> +
> +struct scmi_msg_resp_telemetry_de_configure {
> +	__le32 shmti_id;
> +#define IS_SHMTI_ID_VALID(x)	((x) != 0xFFFFFFFF)
> +	__le32 tdcf_de_offset;
> +};
> +
> +struct scmi_msg_telemetry_config_set {
> +	__le32 grp_id;
> +	__le32 control;
> +#define TELEMETRY_ENABLE		(BIT(0))
> +
> +#define TELEMETRY_MODE(x)		(FIELD_PREP(GENMASK(4, 1), (x)))
> +#define TELEMETRY_MODE_ONDEMAND		TELEMETRY_MODE(0)
> +#define TELEMETRY_MODE_NOTIFS		TELEMETRY_MODE(1)
> +#define TELEMETRY_MODE_SINGLE		TELEMETRY_MODE(2)
> +
> +#define TELEMETRY_SELECTOR(x)		(FIELD_PREP(GENMASK(8, 5), (x)))
> +#define	TELEMETRY_SELECTOR_ORPHANS	TELEMETRY_SELECTOR(0)
> +#define	TELEMETRY_SELECTOR_GROUP	TELEMETRY_SELECTOR(1)
> +#define	TELEMETRY_SELECTOR_ALL		TELEMETRY_SELECTOR(2)
> +	__le32 sampling_rate;
> +};
> +
> +struct scmi_msg_resp_telemetry_reading_complete {
> +	__le32 num_dwords;
> +	__le32 dwords[];
> +};
> +
> +/* TDCF */
> +
> +#define TO_CPU_64(h, l)	(((u64)le32_to_cpu((h)) << 32) | le32_to_cpu((l)))
> +
> +struct fc_line {
> +	u32 data_low;
> +	u32 data_high;
> +};
> +
> +struct fc_tsline {
> +	u32 data_low;
> +	u32 data_high;
> +	u32 ts_low;
> +	u32 ts_high;
> +};
> +
> +struct line {
> +	u32 data_low;
> +	u32 data_high;
> +};
> +
> +struct blk_tsline {
> +	u32 ts_low;
> +	u32 ts_high;
> +};
> +
> +struct tsline {
> +	u32 data_low;
> +	u32 data_high;
> +	u32 ts_low;
> +	u32 ts_high;
> +};
> +
> +#define LINE_DATA_GET(f)				\
> +({							\
> +	typeof(f) _f = (f);				\
> +							\
> +	(TO_CPU_64((_f)->data_high, (_f)->data_low));	\
> +})
> +
> +#define LINE_TSTAMP_GET(f)				\
> +({							\
> +	typeof(f) _f = (f);				\
> +							\
> +	(TO_CPU_64((_f)->ts_high, (_f)->ts_low));	\
> +})
> +
> +#define BLK_TSTAMP_GET(f)	LINE_TSTAMP_GET(f)

These defines also can go into the 'all macros' section.

> +
> +struct payload {
> +	u32 meta;
> +#define IS_BLK_TS(x)	((x)->meta & BIT(4))
> +#define USE_BLK_TS(x)	((x)->meta & BIT(3))
> +#define USE_LINE_TS(x)	((x)->meta & BIT(2))
> +#define TS_VALID(x)	((x)->meta & BIT(1))
> +#define	DATA_INVALID(x) ((x)->meta & BIT(0))
> +	u32 id;
> +	union {
> +		struct line l;
> +		struct tsline tsl;
> +		struct blk_tsline blk_tsl;
> +	};
> +};
> +
> +#define PAYLD_ID(x)	(le32_to_cpu(((struct payload *)(x))->id))
> +
> +#define LINE_DATA_PAYLD_WORDS						       \
> +	((sizeof(u32) + sizeof(u32) + sizeof(struct line)) / sizeof(u32))
> +#define TS_LINE_DATA_PAYLD_WORDS					       \
> +	((sizeof(u32) + sizeof(u32) + sizeof(struct tsline)) / sizeof(u32))
> +
> +#define QWORDS_LINE_DATA_PAYLD		(LINE_DATA_PAYLD_WORDS / 2)
> +#define QWORDS_TS_LINE_DATA_PAYLD	(TS_LINE_DATA_PAYLD_WORDS / 2)
> +
> +struct prlg {
> +	u32 seq_low;
> +	u32 seq_high;
> +	u32 num_qwords;
> +	u32 _meta_header_high;
> +};
> +
> +struct eplg {
> +	u32 seq_low;
> +	u32 seq_high;
> +};
> +
> +#define TDCF_EPLG_SZ	(sizeof(struct eplg))
> +
> +struct tdcf {
> +	struct prlg prlg;
> +	unsigned char payld[];
> +};
> +
> +#define SHMTI_MIN_SIZE	(sizeof(struct tdcf) + TDCF_EPLG_SZ)
> +
> +#define TDCF_START_SEQ_GET(x)					\
> +	({							\
> +		u64 _val;					\
> +		struct prlg *_p = &((x)->prlg);			\
> +								\
> +		_val = TO_CPU_64(_p->seq_high, _p->seq_low);	\
> +		(_val);						\
> +	})
> +
> +#define IS_BAD_START_SEQ(s)	((s) & 0x1)
> +
> +#define	TDCF_END_SEQ_GET(e)					\
> +	({							\
> +		u64 _val;					\
> +		struct eplg *_e = (e);				\
> +								\
> +		_val = TO_CPU_64(_e->seq_high, _e->seq_low);	\
> +		(_val);						\
> +	 })
> +
> +struct telemetry_shmti {
> +	int id;
> +	void __iomem *base;
> +	u32 len;
> +	u64 last_magic;
> +};
> +
> +#define SHMTI_EPLG(s)						\
> +	({							\
> +		struct telemetry_shmti *_s = (s);		\
> +		void *_eplg;					\
> +								\
> +		_eplg = _s->base + _s->len - TDCF_EPLG_SZ;	\
> +		(_eplg);					\
> +	})
> +
> +struct telemetry_info {
> +	bool streaming_mode;
> +	int num_shmti;
> +	struct device *dev;
> +	struct telemetry_shmti *shmti;
> +	struct xarray xa_des;
> +	struct xarray xa_bts;
> +	struct scmi_telemetry_info info;
> +	struct notifier_block telemetry_nb;
> +};
> +
> +#define telemetry_nb_to_info(x)	\
> +	container_of(x, struct telemetry_info, telemetry_nb)
> +
> +struct telemetry_block_ts {
> +	refcount_t users;
> +	/* Protect block_ts accesses  */
> +	struct mutex mtx;
> +	u64 last_ts;
> +	u64 last_magic;
> +	struct payload __iomem *payld;
> +	struct xarray *xa_bts;
> +};
> +
> +struct telemetry_de {
> +	bool cached;
> +	void __iomem *base;
> +	void __iomem *eplg;
> +	u32 offset;
> +	/* NOTE THAT DE data_sz is registered in scmi_telemetry_de */
> +	u32 fc_size;
> +	/* Protect last_val/ts/magic accesses  */
> +	struct mutex mtx;
> +	u64 last_val;
> +	u64 last_ts;
> +	u64 last_magic;
> +	struct telemetry_block_ts *bts;
> +	struct scmi_telemetry_de de;
> +};
> +
> +#define to_tde(d)	container_of(d, struct telemetry_de, de)
> +
> +struct scmi_tlm_de_priv {
> +	struct telemetry_info *ti;
> +	void *next;
> +};
> +
> +static int
> +scmi_telemetry_protocol_attributes_get(const struct scmi_protocol_handle *ph,
> +				       struct telemetry_info *ti)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_resp_telemetry_protocol_attributes *resp;
> +
> +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
> +				      0, sizeof(*resp), &t);
> +	if (ret)
> +		return ret;
> +
> +	resp = t->rx.buf;
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		__le32 attr = resp->attributes;
> +
> +		ti->info.base.num_des = le32_to_cpu(resp->de_num);
> +		ti->info.base.num_groups = le32_to_cpu(resp->groups_num);
> +		for (int i = 0; i < SCMI_TLM_DE_IMPL_MAX_DWORDS; i++)
> +			ti->info.base.de_impl_version[i] =
> +				le32_to_cpu(resp->de_implementation_rev_dword[i]);
> +		ti->info.single_read_support = SUPPORTS_SINGLE_READ(attr);
> +		ti->info.continuos_update_support = SUPPORTS_CONTINUOS_UPDATE(attr);
> +		ti->info.per_group_config_support = SUPPORTS_PER_GROUP_CONFIG(attr);
> +		ti->info.reset_support = SUPPORTS_RESET(attr);
> +		ti->info.fc_support = SUPPORTS_FC(attr);
> +		ti->num_shmti = le32_get_bits(attr, GENMASK(15, 0));
> +		/* Allocate DEs descriptors */
> +		ti->info.des = devm_kcalloc(ph->dev, ti->info.base.num_des,
> +					    sizeof(*ti->info.des), GFP_KERNEL);
> +		if (!ti->info.des) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		/* Allocate a set of contiguous DE info descriptors. */
> +		ti->info.des_store = devm_kcalloc(ph->dev, ti->info.base.num_des,
> +						  sizeof(*ti->info.des_store),
> +						  GFP_KERNEL);
> +		if (!ti->info.des_store) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		/* Allocate DE GROUPS descriptors */
> +		ti->info.groups = devm_kcalloc(ph->dev, ti->info.base.num_groups,
> +					       sizeof(*ti->info.groups), GFP_KERNEL);
> +		if (!ti->info.groups) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		/* Allocate a set of contiguous Group info descriptors. */
> +		ti->info.grps_store = devm_kcalloc(ph->dev, ti->info.base.num_groups,
> +						   sizeof(*ti->info.grps_store),
> +						   GFP_KERNEL);
> +		if (!ti->info.grps_store) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		for (int i = 0; i < ti->info.base.num_groups; i++) {
> +			ti->info.grps_store[i].id = i;
> +			/* Bind contiguous Group info struct */
> +			ti->info.groups[i].info = &ti->info.grps_store[i];
> +		}
> +	}

Could this be changed to:

	if (ret)
		goto out;

then the code would be more on the left side not in the if block.

> +
> +out:
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static void iter_tlm_prepare_message(void *message,
> +				     unsigned int desc_index, const void *priv)
> +{
> +	put_unaligned_le32(desc_index, message);
> +}
> +
> +static int iter_de_descr_update_state(struct scmi_iterator_state *st,
> +				      const void *response, void *priv)
> +{
> +	const struct scmi_msg_resp_telemetry_de_description *r = response;
> +	struct scmi_tlm_de_priv *p = priv;
> +
> +	st->num_returned = le32_get_bits(r->num_desc, GENMASK(15, 0));
> +	st->num_remaining = le32_get_bits(r->num_desc, GENMASK(31, 16));
> +
> +	/* Initialized to first descriptor */
> +	p->next = (void *)r->desc;
> +
> +	return 0;
> +}
> +
> +static int iter_de_descr_process_response(const struct scmi_protocol_handle *ph,

Maybe break the line after 'int' and gain a bit more space in the new
line?

> +					  const void *response,
> +					  struct scmi_iterator_state *st,
> +					  void *priv)
> +{
> +	struct telemetry_de *tde;
> +	struct scmi_tlm_de_priv *p = priv;
> +	const struct scmi_de_desc *desc = p->next;
> +	unsigned int grp_id;
> +	int ret;
> +
> +	tde = to_tde(p->ti->info.des[st->desc_index + st->loop_idx]);
> +
> +	tde->de.info->id = le32_to_cpu(desc->id);
> +	grp_id = le32_to_cpu(desc->grp_id);
> +	if (grp_id != SCMI_TLM_GRP_INVALID) {
> +		/* Group descriptors are empty but allocated at this point */
> +		if (grp_id >= p->ti->info.base.num_groups)
> +			return -EINVAL;
> +
> +		/* Link to parent group */
> +		tde->de.info->grp_id = grp_id;
> +		tde->de.grp = &p->ti->info.groups[grp_id];
> +	}
> +	tde->de.info->data_sz = le32_to_cpu(desc->data_sz);
> +	tde->de.info->type = GET_DE_TYPE(desc);
> +	tde->de.info->unit = GET_DE_UNIT(desc);
> +	tde->de.info->unit_exp = GET_DE_UNIT_EXP(desc);
> +	tde->de.info->tstamp_exp = GET_DE_TSTAMP_EXP(desc);
> +	tde->de.info->instance_id = GET_DE_INSTA_ID(desc);
> +	tde->de.info->compo_instance_id = GET_COMPO_INSTA_ID(desc);
> +	tde->de.info->compo_type = GET_COMPO_TYPE(desc);
> +	tde->de.info->persistent = IS_PERSISTENT(desc);
> +	tde->de.tstamp_support = IS_TSTAMP_SUPPORTED(desc);
> +	tde->de.fc_support = IS_FC_SUPPORTED(desc);
> +	tde->de.name_support = IS_NAME_SUPPORTED(desc);
> +	p->next += sizeof(*desc);
> +	if (tde->de.fc_support) {
> +		u32 size;
> +		u64 phys_addr;
> +		void __iomem *addr;
> +		struct de_desc_fc *dfc;
> +
> +		dfc = p->next;
> +		phys_addr = le32_to_cpu(dfc->addr_low);
> +		phys_addr |= (u64)le32_to_cpu(dfc->addr_high) << 32;
> +
> +		size = le32_to_cpu(dfc->size);
> +		addr = devm_ioremap(ph->dev, phys_addr, size);
> +		if (!addr)
> +			return -EADDRNOTAVAIL;
> +
> +		tde->base = addr;
> +		tde->offset = 0;
> +		tde->fc_size = size;
> +
> +		/* Variably sized depending on FC support */
> +		p->next += sizeof(*dfc);
> +	}
> +
> +	if (tde->de.name_support) {
> +		const char *de_name = p->next;
> +
> +		strscpy(tde->de.info->name, de_name, SCMI_SHORT_NAME_MAX_SIZE);
> +		//tde->de.name = tde->name;
> +
> +		/* Variably sized depending on name support */
> +		p->next += SCMI_SHORT_NAME_MAX_SIZE;
> +	}
> +
> +	/* Store DE pointer by de_id */
> +	ret = xa_insert(&p->ti->xa_des, tde->de.info->id, &tde->de, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	/* Account for this DE in group num_de counter */
> +	if (tde->de.grp)
> +		tde->de.grp->info->num_des++;
> +
> +	return 0;
> +}
> +
> +static int
> +scmi_telemetry_de_groups_init(struct device *dev, struct telemetry_info *ti)
> +{
> +	/* Allocate all groups DEs IDs arrays at first ... */
> +	for (int i = 0; i < ti->info.base.num_groups; i++) {
> +		struct scmi_telemetry_group *grp = &ti->info.groups[i];
> +
> +		grp->des = devm_kcalloc(dev, grp->info->num_des,
> +					sizeof(unsigned int), GFP_KERNEL);
> +		if (!grp->des)
> +			return -ENOMEM;
> +
> +		/*
> +		 * Max size 32bit ID string in Hex: 0xCAFECAFE
> +		 *  - 10 digits + ' '/'\n' = 11 bytes per  number
> +		 *  - terminating NUL character
> +		 */
> +		grp->des_str_sz = grp->info->num_des * 11 + 1;
> +		grp->des_str = devm_kzalloc(dev, grp->des_str_sz, GFP_KERNEL);
> +		if (!grp->des_str)
> +			return -ENOMEM;
> +
> +		/* Reset group DE counter */
> +		grp->info->num_des = 0;
> +	}
> +
> +	/* Scan DEs and populate DE IDs arrays for all groups */
> +	for (int i = 0; i < ti->info.base.num_des; i++) {
> +		struct scmi_telemetry_group *grp = ti->info.des[i]->grp;
> +
> +		if (!grp)
> +			continue;
> +
> +		/*
> +		 * Note that, at this point, num_des is guaranteed to be
> +		 * sane (in-bounds) by construction.
> +		 */
> +		grp->des[grp->info->num_des++] = i;
> +	}
> +
> +	/* Build compsing DES string */
> +	for (int i = 0; i < ti->info.base.num_groups; i++) {
> +		struct scmi_telemetry_group *grp = &ti->info.groups[i];
> +		char *buf = grp->des_str;
> +		size_t bufsize = grp->des_str_sz;
> +
> +		for (int j = 0; j < grp->info->num_des; j++) {
> +			char term = j != (grp->info->num_des - 1) ? ' ' : '\0';
> +			int len;
> +
> +			len = scnprintf(buf, bufsize, "0x%04X%c",
> +					ti->info.des[grp->des[j]]->info->id, term);
> +
> +			buf += len;
> +			bufsize -= len;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +scmi_telemetry_de_descriptors_get(const struct scmi_protocol_handle *ph,
> +				  struct telemetry_info *ti)
> +{
> +	struct scmi_iterator_ops ops = {
> +		.prepare_message = iter_tlm_prepare_message,
> +		.update_state = iter_de_descr_update_state,
> +		.process_response = iter_de_descr_process_response,
> +	};
> +	struct scmi_tlm_de_priv tpriv = {
> +		.ti = ti,
> +		.next = NULL,
> +	};
> +	void *iter;
> +	int ret;
> +
> +	xa_init(&ti->xa_des);
> +	iter = ph->hops->iter_response_init(ph, &ops, ti->info.base.num_des,
> +					    TELEMETRY_DE_DESCRIPTION,
> +					    sizeof(u32), &tpriv);
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +
> +	ret = ph->hops->iter_response_run(iter);
> +	if (ret)
> +		return ret;
> +
> +	return scmi_telemetry_de_groups_init(ph->dev, ti);
> +}
> +
> +static int scmi_telemetry_enumerate_de(const struct scmi_protocol_handle *ph,
> +				       struct telemetry_info *ti)
> +{
> +	int ret;
> +
> +	if (!ti->info.base.num_des)
> +		return 0;
> +
> +	for (int i = 0; i < ti->info.base.num_des; i++) {
> +		struct telemetry_de *tde;
> +
> +		tde = devm_kzalloc(ph->dev, sizeof(*tde), GFP_KERNEL);
> +		if (!tde)
> +			return -ENOMEM;
> +
> +		mutex_init(&tde->mtx);
> +
> +		/* Bind contiguous DE info structures */
> +		tde->de.info = &ti->info.des_store[i];
> +		ti->info.des[i] = &tde->de;
> +	}
> +
> +	ret = scmi_telemetry_de_descriptors_get(ph, ti);
> +	if (ret) {
> +		dev_err(ph->dev, "Cannot get DE descriptors");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +struct scmi_tlm_ivl_priv {
> +	struct device *dev;
> +	struct scmi_tlm_intervals **intrvs;
> +	unsigned int grp_id;
> +	unsigned int flags;
> +};

I would also move all such structures into top of the file,
into a dedicated section.

> +
> +static void iter_intervals_prepare_message(void *message,
> +					   unsigned int desc_index,
> +					   const void *priv)
> +{
> +	struct scmi_msg_telemetry_update_intervals *msg = message;
> +	const struct scmi_tlm_ivl_priv *p = priv;
> +
> +	msg->index = cpu_to_le32(desc_index);
> +	msg->group_identifier = cpu_to_le32(p->grp_id);
> +	msg->flags = FIELD_PREP(GENMASK(3, 0), p->flags);
> +}
> +
> +static int iter_intervals_update_state(struct scmi_iterator_state *st,
> +				       const void *response, void *priv)
> +{
> +	const struct scmi_msg_resp_telemetry_update_intervals *r = response;
> +
> +	st->num_returned = le32_get_bits(r->flags, GENMASK(11, 0));
> +	st->num_remaining = le32_get_bits(r->flags, GENMASK(31, 16));
> +
> +	/*
> +	 * total intervals is not declared previously anywhere so we
> +	 * assume it's returned+remaining on first call.
> +	 */
> +	if (!st->max_resources) {
> +		struct scmi_tlm_ivl_priv *p = priv;
> +		struct scmi_tlm_intervals *intrvs;
> +		int inum;
> +
> +		inum = st->num_returned + st->num_remaining;
> +		intrvs = devm_kzalloc(p->dev,
> +				      sizeof(*intrvs) + inum * sizeof(__u32),
> +				      GFP_KERNEL);
> +		if (!intrvs)
> +			return -ENOMEM;
> +
> +		intrvs->discrete = INTERVALS_DISCRETE(r->flags);
> +		/* Check consistency on first call */
> +		if (!intrvs->discrete &&
> +		    (st->num_returned != 3 || st->num_remaining != 0))
> +			return -EINVAL;
> +
> +		intrvs->num = inum;
> +		st->max_resources = intrvs->num;
> +
> +		*p->intrvs = intrvs;
> +	}

maybe:
	if (st->max_resources)
		goto out;

	.....

out:
	return 0;


> +
> +	return 0;
> +}
> +
> +static int
> +iter_intervals_process_response(const struct scmi_protocol_handle *ph,
> +				const void *response,
> +				struct scmi_iterator_state *st, void *priv)
> +{
> +	const struct scmi_msg_resp_telemetry_update_intervals *r = response;
> +	struct scmi_tlm_ivl_priv *p = priv;
> +	struct scmi_tlm_intervals *intrvs = *p->intrvs;
> +	unsigned int idx = st->loop_idx;
> +
> +	intrvs->update_intervals[st->desc_index + idx] = r->intervals[idx];
> +
> +	return 0;
> +}
> +
> +static int
> +scmi_tlm_enumerate_update_intervals(const struct scmi_protocol_handle *ph,
> +				    struct telemetry_info *ti, int grp_id,
> +				    unsigned int flags)
> +{
> +	struct scmi_iterator_ops ops = {
> +		.prepare_message = iter_intervals_prepare_message,
> +		.update_state = iter_intervals_update_state,
> +		.process_response = iter_intervals_process_response,
> +	};
> +	struct scmi_tlm_ivl_priv ipriv = {
> +		.dev = ph->dev,
> +		.grp_id = grp_id,
> +		.intrvs = (grp_id == SCMI_TLM_GRP_INVALID) ?
> +			&ti->info.intervals :
> +			&ti->info.groups[grp_id].intervals,
> +		.flags = flags,
> +	};
> +	void *iter;
> +
> +	iter = ph->hops->iter_response_init(ph, &ops, 0,
> +					    TELEMETRY_LIST_UPDATE_INTERVALS,
> +			     sizeof(struct scmi_msg_telemetry_update_intervals),
> +					    &ipriv);
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +
> +	return ph->hops->iter_response_run(iter);
> +}
> +
> +static int
> +scmi_telemetry_enumerate_update_intervals(const struct scmi_protocol_handle *ph,
> +					  struct telemetry_info *ti)
> +{
> +	int ret;
> +	unsigned int flags;
> +
> +	flags = !ti->info.per_group_config_support ?
> +		ALL_DES_ANY_GROUP : ALL_DES_NO_GROUP;
> +
> +	ret = scmi_tlm_enumerate_update_intervals(ph, ti, SCMI_TLM_GRP_INVALID,
> +						  flags);
> +	if (ret)
> +		return ret;
> +
> +	/* A copy for UAPI access... */
> +	ti->info.base.num_intervals = ti->info.intervals->num;
> +	if (ti->info.base.num_groups && ti->info.per_group_config_support) {
> +		flags = SPECIFIC_GROUP_DES;
> +		for (int id = 0; id < ti->info.base.num_groups; id++) {
> +			ret = scmi_tlm_enumerate_update_intervals(ph, ti, id,
> +								  flags);
> +			if (ret)
> +				break;
> +
> +			ti->info.grps_store[id].num_intervals =
> +				ti->info.groups[id].intervals->num;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int iter_shmti_update_state(struct scmi_iterator_state *st,
> +				   const void *response, void *priv)
> +{
> +	const struct scmi_msg_resp_telemetry_shmti_list *r = response;
> +
> +	st->num_returned = le32_get_bits(r->num_shmti, GENMASK(15, 0));
> +	st->num_remaining = le32_get_bits(r->num_shmti, GENMASK(31, 16));
> +
> +	return 0;
> +}
> +
> +static int iter_shmti_process_response(const struct scmi_protocol_handle *ph,
> +				       const void *response,
> +				       struct scmi_iterator_state *st,
> +				       void *priv)
> +{
> +	const struct scmi_msg_resp_telemetry_shmti_list *r = response;
> +	struct telemetry_info *ti = priv;
> +	struct telemetry_shmti *shmti;
> +	const struct scmi_shmti_desc *desc;
> +	void __iomem *addr;
> +	u64 phys_addr;
> +	u32 len;
> +
> +	desc = &r->desc[st->loop_idx];
> +	shmti = &ti->shmti[st->desc_index + st->loop_idx];
> +
> +	shmti->id = le32_to_cpu(desc->id);
> +	phys_addr = le32_to_cpu(desc->addr_low);
> +	phys_addr |= (u64)le32_to_cpu(desc->addr_high) << 32;
> +
> +	len = le32_to_cpu(desc->length);
> +	if (len < SHMTI_MIN_SIZE)
> +		return -EINVAL;
> +
> +	addr = devm_ioremap(ph->dev, phys_addr, len);
> +	if (!addr)
> +		return -EADDRNOTAVAIL;
> +
> +	shmti->base = addr;
> +	shmti->len = len;
> +
> +	return 0;
> +}
> +
> +static int scmi_telemetry_shmti_list(const struct scmi_protocol_handle *ph,
> +				     struct telemetry_info *ti)
> +{
> +	struct scmi_iterator_ops ops = {
> +		.prepare_message = iter_tlm_prepare_message,
> +		.update_state = iter_shmti_update_state,
> +		.process_response = iter_shmti_process_response,
> +	};
> +	void *iter;
> +
> +	iter = ph->hops->iter_response_init(ph, &ops, ti->info.base.num_des,
> +					    TELEMETRY_LIST_SHMTI,
> +					    sizeof(u32), ti);
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +
> +	return ph->hops->iter_response_run(iter);
> +}
> +
> +static int scmi_telemetry_enumerate_shmti(const struct scmi_protocol_handle *ph,
> +					  struct telemetry_info *ti)
> +{
> +	int ret;
> +
> +	if (!ti->num_shmti)
> +		return 0;
> +
> +	ti->shmti = devm_kcalloc(ph->dev, ti->num_shmti, sizeof(*ti->shmti),
> +				 GFP_KERNEL);
> +	if (!ti->shmti)
> +		return -ENOMEM;
> +
> +	ret = scmi_telemetry_shmti_list(ph, ti);
> +	if (ret) {
> +		dev_err(ph->dev, "Cannot get SHMTI list descriptors");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct scmi_telemetry_info *
> +scmi_telemetry_info_get(const struct scmi_protocol_handle *ph)
> +{
> +	struct telemetry_info *ti = ph->get_priv(ph);
> +
> +	return &ti->info;
> +}
> +
> +static const struct scmi_tlm_de_info *
> +scmi_telemetry_de_info_get(const struct scmi_protocol_handle *ph, u32 id)
> +{
> +	struct telemetry_info *ti = ph->get_priv(ph);
> +
> +	return xa_load(&ti->xa_des, id);
> +}
> +
> +static u64
> +scmi_telemetry_blkts_read(u64 magic, struct telemetry_block_ts *bts)
> +{
> +	if (WARN_ON(!bts || !refcount_read(&bts->users)))
> +		return 0;
> +
> +	guard(mutex)(&bts->mtx);
> +
> +	if (bts->last_magic == magic)
> +		return bts->last_ts;
> +
> +	bts->last_ts = BLK_TSTAMP_GET(&bts->payld->blk_tsl);
> +	bts->last_magic = magic;
> +
> +	return bts->last_ts;
> +}
> +
> +static void scmi_telemetry_blkts_update(u64 magic,
> +					struct telemetry_block_ts *bts)
> +{
> +	guard(mutex)(&bts->mtx);
> +
> +	if (bts->last_magic != magic) {
> +		bts->last_ts = BLK_TSTAMP_GET(&bts->payld->blk_tsl);
> +		bts->last_magic = magic;
> +	}
> +}
> +
> +static void scmi_telemetry_blkts_put(struct device *dev,
> +				     struct telemetry_block_ts *bts)
> +{
> +	if (refcount_dec_and_test(&bts->users)) {
> +		scoped_guard(mutex, &bts->mtx)
> +			xa_erase(bts->xa_bts, (unsigned long)bts->payld);
> +		devm_kfree(dev, bts);
> +	}
> +}
> +
> +static struct telemetry_block_ts *
> +scmi_telemetry_blkts_get(struct xarray *xa_bts, struct payload *payld)
> +{
> +	struct telemetry_block_ts *bts;
> +
> +	bts = xa_load(xa_bts, (unsigned long)payld);
> +	if (!bts)
> +		return NULL;
> +
> +	refcount_inc(&bts->users);
> +
> +	return bts;
> +}
> +
> +static struct payload *
> +scmi_telemetry_nearest_blk_ts(struct telemetry_shmti *shmti,
> +			      struct payload *last_payld)
> +{
> +	struct payload *payld, *bts_payld = NULL;
> +	struct tdcf __iomem *tdcf = shmti->base;
> +	u32 *next;
> +
> +	/* Scan from start of TDCF payloads up to last_payld */
> +	payld = (struct payload *)tdcf->payld;
> +	next = (u32 *)payld;
> +	while (payld < last_payld) {
> +		if (IS_BLK_TS(payld))
> +			bts_payld = payld;
> +
> +		next += USE_LINE_TS(payld) ?
> +			TS_LINE_DATA_PAYLD_WORDS : LINE_DATA_PAYLD_WORDS;
> +		payld = (struct payload *)next;
> +	}
> +
> +	return bts_payld;
> +}
> +
> +static struct telemetry_block_ts *
> +scmi_telemetry_blkts_lookup(struct device *dev, struct xarray *xa_bts,
> +			    struct payload *payld)
> +{
> +	struct telemetry_block_ts *bts;
> +
> +	bts = xa_load(xa_bts, (unsigned long)payld);
> +	if (!bts) {
> +		int ret;
> +
> +		bts = devm_kzalloc(dev, sizeof(*bts), GFP_KERNEL);
> +		if (!bts)
> +			return NULL;
> +
> +		refcount_set(&bts->users, 1);
> +		bts->payld = payld;
> +		bts->xa_bts = xa_bts;
> +		mutex_init(&bts->mtx);
> +		ret = xa_insert(xa_bts, (unsigned long)payld, bts, GFP_KERNEL);
> +		if (ret) {
> +			devm_kfree(dev, bts);
> +			return NULL;
> +		}
> +	}
> +
> +	return bts;
> +}
> +
> +static struct telemetry_block_ts *
> +scmi_telemetry_blkts_bind(struct device *dev, struct telemetry_shmti *shmti,
> +			  struct payload *payld, struct xarray *xa_bts)
> +{
> +	struct telemetry_block_ts *bts;
> +	struct payload *bts_payld;
> +
> +	/* Find the BLK_TS immediately preceding this DE payld */
> +	bts_payld = scmi_telemetry_nearest_blk_ts(shmti, payld);
> +	if (!bts_payld)
> +		return NULL;
> +
> +	bts = scmi_telemetry_blkts_get(xa_bts, bts_payld);
> +	if (bts)
> +		return bts;
> +
> +	return scmi_telemetry_blkts_lookup(dev, xa_bts, payld);
> +}
> +
> +static void scmi_telemetry_tdcf_blkts_parse(struct telemetry_info *ti,
> +					    struct payload __iomem *payld,
> +					    struct telemetry_shmti *shmti)
> +{
> +	struct telemetry_block_ts *bts;
> +
> +	/* Check for spec compliance */
> +	if (USE_LINE_TS(payld) || USE_BLK_TS(payld) ||
> +	    DATA_INVALID(payld) || (PAYLD_ID(payld) != 0))
> +		return;
> +
> +	/* A BLK_TS descriptor MUST be returned: it is found or it is crated */
> +	bts = scmi_telemetry_blkts_lookup(ti->dev, &ti->xa_bts, payld);
> +	if (WARN_ON(!bts))
> +		return;
> +
> +	/* Update the descriptor with the lastest TS*/
> +	scmi_telemetry_blkts_update(shmti->last_magic, bts);
> +}
> +
> +static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
> +					   struct payload __iomem *payld,
> +					   struct telemetry_shmti *shmti,
> +					   bool update)
> +{
> +	bool ts_valid = TS_VALID(payld);
> +	struct scmi_telemetry_de *de;
> +	struct telemetry_de *tde;
> +	u64 val, tstamp = 0;
> +	u32 id;
> +
> +	id = PAYLD_ID(payld);
> +	de = xa_load(&ti->xa_des, id);
> +	if (!de)
> +		return;
> +
> +	tde = to_tde(de);
> +	/* Update DE location refs if requested: normally done only on enable */
> +	if (update) {
> +		tde->base = shmti->base;
> +		tde->eplg = SHMTI_EPLG(shmti);
> +		tde->offset = (void *)payld - (void *)shmti->base;
> +	}
> +
> +	scoped_guard(mutex, &tde->mtx) {
> +		if (tde->last_magic == shmti->last_magic)
> +			return;
> +	}
> +
> +	/* Data is always valid since we are NOT handling BLK TS lines here */
> +	val = LINE_DATA_GET(&payld->l);
> +	/* Collect the right TS */
> +	if (ts_valid) {
> +		if (USE_LINE_TS(payld)) {
> +			tstamp = LINE_TSTAMP_GET(&payld->tsl);
> +		} else if (USE_BLK_TS(payld)) {
> +			if (!tde->bts) {
> +				/*
> +				 * Scanning a TDCF looking for the nearest
> +				 * previous valid BLK_TS, after having found a
> +				 * USE_BLK_TS() payload, MUST succeed.
> +				 */
> +				tde->bts = scmi_telemetry_blkts_bind(ti->dev,
> +								     shmti, payld,
> +								     &ti->xa_bts);
> +				if (WARN_ON(!tde->bts))

Do we have to everytime log this when it happens?
It looks like more a debug thing, isn't it?

> +					return;
> +			}
> +
> +			tstamp = scmi_telemetry_blkts_read(tde->last_magic,
> +							   tde->bts);
> +		}
> +	}
> +
> +	guard(mutex)(&tde->mtx);
> +	tde->last_magic = shmti->last_magic;
> +	tde->last_val = val;
> +	if (de->tstamp_enabled)
> +		tde->last_ts = tstamp;
> +	else
> +		tde->last_ts = 0;
> +}
> +
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
> +	if (DATA_INVALID(payld))
> +		return used_qwords;
> +
> +	if (!IS_BLK_TS(payld))
> +		scmi_telemetry_tdcf_data_parse(ti, payld, shmti, update);
> +	else
> +		scmi_telemetry_tdcf_blkts_parse(ti, payld, shmti);
> +
> +	return used_qwords;
> +}
> +
> +static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
> +				     unsigned int shmti_id, u64 ts,
> +				     bool update)
> +{
> +	struct telemetry_shmti *shmti = &ti->shmti[shmti_id];
> +	struct tdcf __iomem *tdcf = shmti->base;
> +	int retries = SCMI_TLM_TDCF_MAX_RETRIES;
> +	u64 startm = 0, endm = 0xffffffffffffffff;
> +	void *eplg = SHMTI_EPLG(shmti);
> +
> +	if (!tdcf)
> +		return -ENODEV;
> +
> +	do {
> +		unsigned int qwords;
> +		void __iomem *next;
> +
> +		/* A bit of exponential backoff between retries */
> +		fsleep((SCMI_TLM_TDCF_MAX_RETRIES - retries) * 1000);

This is something that I would like to understand more.

> +
> +		startm = TDCF_START_SEQ_GET(tdcf);
> +		if (IS_BAD_START_SEQ(startm))
> +			continue;
> +
> +		/* On a BAD_SEQ this will be updated on the next attempt */
> +		shmti->last_magic = startm;
> +
> +		qwords = tdcf->prlg.num_qwords;
> +		next = tdcf->payld;
> +		while (qwords) {
> +			int used_qwords;
> +
> +			used_qwords = scmi_telemetry_tdcf_line_parse(ti, next,
> +								     shmti, update);
> +			if (qwords < used_qwords)
> +				return -EINVAL;
> +
> +			next += used_qwords * 8;
> +			qwords -= used_qwords;
> +		}
> +
> +		endm = TDCF_END_SEQ_GET(eplg);
> +	} while (startm != endm && --retries);
> +
> +	if (startm != endm)
> +		return -EPROTO;
> +
> +	return 0;
> +}
> +

I will take a few steps in this big patch ;)

Regards,
Lukasz

