Return-Path: <linux-kernel+bounces-874430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7BBC16505
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A471A263C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605F634C144;
	Tue, 28 Oct 2025 17:52:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D40330B30;
	Tue, 28 Oct 2025 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673932; cv=none; b=M0mN8VdWFWssliMcuSobW87ZFcb7EeI8KluUBdzUugNZXeakCtszDCXkrVoTpy/Wij2qXHOIHyrPhDJbBkO3eUNQ5qmwOKNfRH+/JrtcY4eYU7s575MIUXsVuS18NyjVPYy4Irt3Qusj5j2zKk1+yzKPEgrl+S2Ylbnjm1uWBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673932; c=relaxed/simple;
	bh=et8hH+O817wKSMueqp0Yoxj5U45+BrQA0jLYAMBFu1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDQErCHG1YEzm5kl78+Wa+T3zL32tRUkUv4TFe/iKEKvUqsMfb/kN138/F5rK668XMiyC0Q9a3fRSo3R7v44oewT6XwZiEFy5lpHcvT/nMIqGsO714ImnPKEjlPqH2X2OzDbtf94FdM9Ythj/THNhAWFEVk08TnplN4PGrbqgHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E46AF168F;
	Tue, 28 Oct 2025 10:51:59 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A65BA3F63F;
	Tue, 28 Oct 2025 10:52:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:51:55 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com,
	arm-scmi@vger.kernel.org
Subject: Re: [PATCH 05/10] firmware: arm_scmi: Add Telemetry protocol support
Message-ID: <aQECu03plJtEpM1I@pluto>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
 <20250925203554.482371-6-cristian.marussi@arm.com>
 <e9bf6624-b789-4dad-89ff-731cd62ccd07@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9bf6624-b789-4dad-89ff-731cd62ccd07@arm.com>

On Tue, Oct 28, 2025 at 11:43:54AM +0000, Lukasz Luba wrote:
> Hi Cristian,
> 

Hi,

> This is a first attempt for the review, because there is so much code.
> I might find something in the next step, because for now I still
> haven't built full picture of it...

Thanks for having a look.

> 
> So far some comments are there, mostly about the cometic & structure
> of code changes.
> 
> On 9/25/25 21:35, Cristian Marussi wrote:
> > Add basic support for SCMI V4.0-alpha_0 Telemetry protocol including SHMTI,
> > FastChannels, Notifications and Single Sample Reads collection methods.
> 
> Could it be possible to split this big patch to a few with those
> mentioned features? It would also be easier to review (at least from
> my perspective). If it too complex and interdependent than OK, I will
> just continue.
> 

Usually I try to keep the protocol layer in one single patch, BUT indeed
the SCMI Telemetry protocol is quite big so I could split the protocol
by collection methods.

> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---

[snip]

> > +struct scmi_msg_resp_telemetry_protocol_attributes {
> > +	__le32 de_num;
> > +	__le32 groups_num;
> > +	__le32 de_implementation_rev_dword[SCMI_TLM_DE_IMPL_MAX_DWORDS];
> > +	__le32 attributes;
> > +#define SUPPORTS_SINGLE_READ(x)		((x) & BIT(31))
> > +#define SUPPORTS_CONTINUOS_UPDATE(x)	((x) & BIT(30))
> > +#define SUPPORTS_PER_GROUP_CONFIG(x)	((x) & BIT(18))
> > +#define SUPPORTS_RESET(x)		((x) & BIT(17))
> > +#define SUPPORTS_FC(x)			((x) & BIT(16))
> 
> I would move those defines into a dedicated section of
> 'all defines' which will have a comment for each such group.
>

Usually all over the SCMI core protocols code we tend to keep all of
such definnes near to the fields of the message descriptors that they
access or manipulate....so for consistency I put this here.

> 
> > +};
> > +
> > +struct scmi_telemetry_update_notify_payld {
> > +	__le32 agent_id;
> > +	__le32 status;
> > +	__le32 num_dwords;
> > +	__le32 array[];
> > +};
> > +
> > +struct scmi_shmti_desc {
> > +	__le32 id;
> > +	__le32 addr_low;
> > +	__le32 addr_high;
> > +	__le32 length;
> > +};
> > +
> > +struct scmi_msg_resp_telemetry_shmti_list {
> > +	__le32 num_shmti;
> > +	struct scmi_shmti_desc desc[];
> > +};
> > +
> > +struct de_desc_fc {
> > +	__le32 addr_low;
> > +	__le32 addr_high;
> > +	__le32 size;
> > +};
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
> > +	})
> > +#define	IS_TSTAMP_SUPPORTED(d)	((d)->attr_1 & BIT(0))
> > +	__le32 attr_2;
> > +#define	GET_DE_INSTA_ID(d)	(le32_get_bits((d)->attr_2, GENMASK(31, 24)))
> > +#define	GET_COMPO_INSTA_ID(d)	(le32_get_bits((d)->attr_2, GENMASK(23, 8)))
> > +#define	GET_COMPO_TYPE(d)	(le32_get_bits((d)->attr_2, GENMASK(7, 0)))
> 
> 
> Same here. Adding them inside those structures causes somehow
> complex to read and undertand block of code.
> If you could move it into seperate 'macros' section, would that
> casue you some issue?

No issues...same reason noted above...all protoocls are done like this
(mostly) since the beginning...so I kept the same style.

> 
> 
> > +	__le32 reserved;
> > +};
> > +
> > +struct scmi_msg_resp_telemetry_de_description {
> > +	__le32 num_desc;
> > +	struct scmi_de_desc desc[];
> > +};

[snip]

> > +/* TDCF */
> > +
> > +#define TO_CPU_64(h, l)	(((u64)le32_to_cpu((h)) << 32) | le32_to_cpu((l)))
> > +
> > +struct fc_line {
> > +	u32 data_low;
> > +	u32 data_high;
> > +};
> > +
> > +struct fc_tsline {
> > +	u32 data_low;
> > +	u32 data_high;
> > +	u32 ts_low;
> > +	u32 ts_high;
> > +};
> > +
> > +struct line {
> > +	u32 data_low;
> > +	u32 data_high;
> > +};
> > +
> > +struct blk_tsline {
> > +	u32 ts_low;
> > +	u32 ts_high;
> > +};
> > +
> > +struct tsline {
> > +	u32 data_low;
> > +	u32 data_high;
> > +	u32 ts_low;
> > +	u32 ts_high;
> > +};
> > +
> > +#define LINE_DATA_GET(f)				\
> > +({							\
> > +	typeof(f) _f = (f);				\
> > +							\
> > +	(TO_CPU_64((_f)->data_high, (_f)->data_low));	\
> > +})
> > +
> > +#define LINE_TSTAMP_GET(f)				\
> > +({							\
> > +	typeof(f) _f = (f);				\
> > +							\
> > +	(TO_CPU_64((_f)->ts_high, (_f)->ts_low));	\
> > +})
> > +
> > +#define BLK_TSTAMP_GET(f)	LINE_TSTAMP_GET(f)
> 
> These defines also can go into the 'all macros' section.
> 

Yes these defines indeed are NOT directly related to a message
structure BUT they are related to the above preceding TDCF line
structure definitions...

> > +
> > +struct payload {
> > +	u32 meta;
> > +#define IS_BLK_TS(x)	((x)->meta & BIT(4))
> > +#define USE_BLK_TS(x)	((x)->meta & BIT(3))
> > +#define USE_LINE_TS(x)	((x)->meta & BIT(2))
> > +#define TS_VALID(x)	((x)->meta & BIT(1))
> > +#define	DATA_INVALID(x) ((x)->meta & BIT(0))

[snip]

> > +	resp = t->rx.buf;
> > +	ret = ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
> > +		__le32 attr = resp->attributes;
> > +
> > +		ti->info.base.num_des = le32_to_cpu(resp->de_num);
> > +		ti->info.base.num_groups = le32_to_cpu(resp->groups_num);
> > +		for (int i = 0; i < SCMI_TLM_DE_IMPL_MAX_DWORDS; i++)
> > +			ti->info.base.de_impl_version[i] =
> > +				le32_to_cpu(resp->de_implementation_rev_dword[i]);
> > +		ti->info.single_read_support = SUPPORTS_SINGLE_READ(attr);
> > +		ti->info.continuos_update_support = SUPPORTS_CONTINUOS_UPDATE(attr);
> > +		ti->info.per_group_config_support = SUPPORTS_PER_GROUP_CONFIG(attr);
> > +		ti->info.reset_support = SUPPORTS_RESET(attr);
> > +		ti->info.fc_support = SUPPORTS_FC(attr);
> > +		ti->num_shmti = le32_get_bits(attr, GENMASK(15, 0));
> > +		/* Allocate DEs descriptors */
> > +		ti->info.des = devm_kcalloc(ph->dev, ti->info.base.num_des,
> > +					    sizeof(*ti->info.des), GFP_KERNEL);
> > +		if (!ti->info.des) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		/* Allocate a set of contiguous DE info descriptors. */
> > +		ti->info.des_store = devm_kcalloc(ph->dev, ti->info.base.num_des,
> > +						  sizeof(*ti->info.des_store),
> > +						  GFP_KERNEL);
> > +		if (!ti->info.des_store) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		/* Allocate DE GROUPS descriptors */
> > +		ti->info.groups = devm_kcalloc(ph->dev, ti->info.base.num_groups,
> > +					       sizeof(*ti->info.groups), GFP_KERNEL);
> > +		if (!ti->info.groups) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		/* Allocate a set of contiguous Group info descriptors. */
> > +		ti->info.grps_store = devm_kcalloc(ph->dev, ti->info.base.num_groups,
> > +						   sizeof(*ti->info.grps_store),
> > +						   GFP_KERNEL);
> > +		if (!ti->info.grps_store) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		for (int i = 0; i < ti->info.base.num_groups; i++) {
> > +			ti->info.grps_store[i].id = i;
> > +			/* Bind contiguous Group info struct */
> > +			ti->info.groups[i].info = &ti->info.grps_store[i];
> > +		}
> > +	}
> 
> Could this be changed to:
> 
> 	if (ret)
> 		goto out;
> 
> then the code would be more on the left side not in the if block.

Yes indeed, the classic kernel flow would be like that, but again I was
trying to be consistent with all the other SCMI protocols where usually we
have this kind of construct

	ret = ph->xops->do_xfer(ph, t);
	if (!ret) {
		...PROCESS REPLY ON SUCCESS
	}
	// RELEASE the message xfer anyway
	ph->xops->xfer_put(ph, t);

> > +
> > +out:
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> > +
> > +static void iter_tlm_prepare_message(void *message,
> > +				     unsigned int desc_index, const void *priv)
> > +{
> > +	put_unaligned_le32(desc_index, message);
> > +}
> > +
> > +static int iter_de_descr_update_state(struct scmi_iterator_state *st,
> > +				      const void *response, void *priv)
> > +{
> > +	const struct scmi_msg_resp_telemetry_de_description *r = response;
> > +	struct scmi_tlm_de_priv *p = priv;
> > +
> > +	st->num_returned = le32_get_bits(r->num_desc, GENMASK(15, 0));
> > +	st->num_remaining = le32_get_bits(r->num_desc, GENMASK(31, 16));
> > +
> > +	/* Initialized to first descriptor */
> > +	p->next = (void *)r->desc;
> > +
> > +	return 0;
> > +}
> > +
> > +static int iter_de_descr_process_response(const struct scmi_protocol_handle *ph,
> 
> Maybe break the line after 'int' and gain a bit more space in the new
> line?

I will.

> 
> > +					  const void *response,
> > +					  struct scmi_iterator_state *st,
> > +					  void *priv)
> > +{
> > +	struct telemetry_de *tde;
> > +	struct scmi_tlm_de_priv *p = priv;
> > +	const struct scmi_de_desc *desc = p->next;
> > +	unsigned int grp_id;
> > +	int ret;
> > +
> > +	tde = to_tde(p->ti->info.des[st->desc_index + st->loop_idx]);
> > +
> > +	tde->de.info->id = le32_to_cpu(desc->id);
> > +	grp_id = le32_to_cpu(desc->grp_id);
> > +	if (grp_id != SCMI_TLM_GRP_INVALID) {
> > +		/* Group descriptors are empty but allocated at this point */
> > +		if (grp_id >= p->ti->info.base.num_groups)
> > +			return -EINVAL;
> > +
> > +		/* Link to parent group */
> > +		tde->de.info->grp_id = grp_id;
> > +		tde->de.grp = &p->ti->info.groups[grp_id];
> > +	}
> > +	tde->de.info->data_sz = le32_to_cpu(desc->data_sz);
> > +	tde->de.info->type = GET_DE_TYPE(desc);
> > +	tde->de.info->unit = GET_DE_UNIT(desc);
> > +	tde->de.info->unit_exp = GET_DE_UNIT_EXP(desc);
> > +	tde->de.info->tstamp_exp = GET_DE_TSTAMP_EXP(desc);
> > +	tde->de.info->instance_id = GET_DE_INSTA_ID(desc);
> > +	tde->de.info->compo_instance_id = GET_COMPO_INSTA_ID(desc);
> > +	tde->de.info->compo_type = GET_COMPO_TYPE(desc);
> > +	tde->de.info->persistent = IS_PERSISTENT(desc);
> > +	tde->de.tstamp_support = IS_TSTAMP_SUPPORTED(desc);
> > +	tde->de.fc_support = IS_FC_SUPPORTED(desc);
> > +	tde->de.name_support = IS_NAME_SUPPORTED(desc);
> > +	p->next += sizeof(*desc);
> > +	if (tde->de.fc_support) {
> > +		u32 size;
> > +		u64 phys_addr;
> > +		void __iomem *addr;
> > +		struct de_desc_fc *dfc;
> > +
> > +		dfc = p->next;
> > +		phys_addr = le32_to_cpu(dfc->addr_low);
> > +		phys_addr |= (u64)le32_to_cpu(dfc->addr_high) << 32;
> > +
> > +		size = le32_to_cpu(dfc->size);
> > +		addr = devm_ioremap(ph->dev, phys_addr, size);
> > +		if (!addr)
> > +			return -EADDRNOTAVAIL;
> > +
> > +		tde->base = addr;
> > +		tde->offset = 0;
> > +		tde->fc_size = size;
> > +
> > +		/* Variably sized depending on FC support */
> > +		p->next += sizeof(*dfc);
> > +	}
> > +
> > +	if (tde->de.name_support) {
> > +		const char *de_name = p->next;
> > +
> > +		strscpy(tde->de.info->name, de_name, SCMI_SHORT_NAME_MAX_SIZE);
> > +		//tde->de.name = tde->name;
> > +
> > +		/* Variably sized depending on name support */
> > +		p->next += SCMI_SHORT_NAME_MAX_SIZE;
> > +	}
> > +
> > +	/* Store DE pointer by de_id */
> > +	ret = xa_insert(&p->ti->xa_des, tde->de.info->id, &tde->de, GFP_KERNEL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Account for this DE in group num_de counter */
> > +	if (tde->de.grp)
> > +		tde->de.grp->info->num_des++;
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +scmi_telemetry_de_groups_init(struct device *dev, struct telemetry_info *ti)
> > +{
> > +	/* Allocate all groups DEs IDs arrays at first ... */
> > +	for (int i = 0; i < ti->info.base.num_groups; i++) {
> > +		struct scmi_telemetry_group *grp = &ti->info.groups[i];
> > +
> > +		grp->des = devm_kcalloc(dev, grp->info->num_des,
> > +					sizeof(unsigned int), GFP_KERNEL);
> > +		if (!grp->des)
> > +			return -ENOMEM;
> > +
> > +		/*
> > +		 * Max size 32bit ID string in Hex: 0xCAFECAFE
> > +		 *  - 10 digits + ' '/'\n' = 11 bytes per  number
> > +		 *  - terminating NUL character
> > +		 */
> > +		grp->des_str_sz = grp->info->num_des * 11 + 1;
> > +		grp->des_str = devm_kzalloc(dev, grp->des_str_sz, GFP_KERNEL);
> > +		if (!grp->des_str)
> > +			return -ENOMEM;
> > +
> > +		/* Reset group DE counter */
> > +		grp->info->num_des = 0;
> > +	}
> > +
> > +	/* Scan DEs and populate DE IDs arrays for all groups */
> > +	for (int i = 0; i < ti->info.base.num_des; i++) {
> > +		struct scmi_telemetry_group *grp = ti->info.des[i]->grp;
> > +
> > +		if (!grp)
> > +			continue;
> > +
> > +		/*
> > +		 * Note that, at this point, num_des is guaranteed to be
> > +		 * sane (in-bounds) by construction.
> > +		 */
> > +		grp->des[grp->info->num_des++] = i;
> > +	}
> > +
> > +	/* Build compsing DES string */
> > +	for (int i = 0; i < ti->info.base.num_groups; i++) {
> > +		struct scmi_telemetry_group *grp = &ti->info.groups[i];
> > +		char *buf = grp->des_str;
> > +		size_t bufsize = grp->des_str_sz;
> > +
> > +		for (int j = 0; j < grp->info->num_des; j++) {
> > +			char term = j != (grp->info->num_des - 1) ? ' ' : '\0';
> > +			int len;
> > +
> > +			len = scnprintf(buf, bufsize, "0x%04X%c",
> > +					ti->info.des[grp->des[j]]->info->id, term);
> > +
> > +			buf += len;
> > +			bufsize -= len;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +scmi_telemetry_de_descriptors_get(const struct scmi_protocol_handle *ph,
> > +				  struct telemetry_info *ti)
> > +{
> > +	struct scmi_iterator_ops ops = {
> > +		.prepare_message = iter_tlm_prepare_message,
> > +		.update_state = iter_de_descr_update_state,
> > +		.process_response = iter_de_descr_process_response,
> > +	};
> > +	struct scmi_tlm_de_priv tpriv = {
> > +		.ti = ti,
> > +		.next = NULL,
> > +	};
> > +	void *iter;
> > +	int ret;
> > +
> > +	xa_init(&ti->xa_des);
> > +	iter = ph->hops->iter_response_init(ph, &ops, ti->info.base.num_des,
> > +					    TELEMETRY_DE_DESCRIPTION,
> > +					    sizeof(u32), &tpriv);
> > +	if (IS_ERR(iter))
> > +		return PTR_ERR(iter);
> > +
> > +	ret = ph->hops->iter_response_run(iter);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return scmi_telemetry_de_groups_init(ph->dev, ti);
> > +}
> > +
> > +static int scmi_telemetry_enumerate_de(const struct scmi_protocol_handle *ph,
> > +				       struct telemetry_info *ti)
> > +{
> > +	int ret;
> > +
> > +	if (!ti->info.base.num_des)
> > +		return 0;
> > +
> > +	for (int i = 0; i < ti->info.base.num_des; i++) {
> > +		struct telemetry_de *tde;
> > +
> > +		tde = devm_kzalloc(ph->dev, sizeof(*tde), GFP_KERNEL);
> > +		if (!tde)
> > +			return -ENOMEM;
> > +
> > +		mutex_init(&tde->mtx);
> > +
> > +		/* Bind contiguous DE info structures */
> > +		tde->de.info = &ti->info.des_store[i];
> > +		ti->info.des[i] = &tde->de;
> > +	}
> > +
> > +	ret = scmi_telemetry_de_descriptors_get(ph, ti);
> > +	if (ret) {
> > +		dev_err(ph->dev, "Cannot get DE descriptors");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +struct scmi_tlm_ivl_priv {
> > +	struct device *dev;
> > +	struct scmi_tlm_intervals **intrvs;
> > +	unsigned int grp_id;
> > +	unsigned int flags;
> > +};
> 
> I would also move all such structures into top of the file,
> into a dedicated section.

Yes, this is definitely a leftover.

> 
> > +
> > +static void iter_intervals_prepare_message(void *message,
> > +					   unsigned int desc_index,
> > +					   const void *priv)
> > +{
> > +	struct scmi_msg_telemetry_update_intervals *msg = message;
> > +	const struct scmi_tlm_ivl_priv *p = priv;
> > +
> > +	msg->index = cpu_to_le32(desc_index);
> > +	msg->group_identifier = cpu_to_le32(p->grp_id);
> > +	msg->flags = FIELD_PREP(GENMASK(3, 0), p->flags);
> > +}
> > +

[snip]

> > +static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
> > +					   struct payload __iomem *payld,
> > +					   struct telemetry_shmti *shmti,
> > +					   bool update)
> > +{
> > +	bool ts_valid = TS_VALID(payld);
> > +	struct scmi_telemetry_de *de;
> > +	struct telemetry_de *tde;
> > +	u64 val, tstamp = 0;
> > +	u32 id;
> > +
> > +	id = PAYLD_ID(payld);
> > +	de = xa_load(&ti->xa_des, id);
> > +	if (!de)
> > +		return;
> > +
> > +	tde = to_tde(de);
> > +	/* Update DE location refs if requested: normally done only on enable */
> > +	if (update) {
> > +		tde->base = shmti->base;
> > +		tde->eplg = SHMTI_EPLG(shmti);
> > +		tde->offset = (void *)payld - (void *)shmti->base;
> > +	}
> > +
> > +	scoped_guard(mutex, &tde->mtx) {
> > +		if (tde->last_magic == shmti->last_magic)
> > +			return;
> > +	}
> > +
> > +	/* Data is always valid since we are NOT handling BLK TS lines here */
> > +	val = LINE_DATA_GET(&payld->l);
> > +	/* Collect the right TS */
> > +	if (ts_valid) {
> > +		if (USE_LINE_TS(payld)) {
> > +			tstamp = LINE_TSTAMP_GET(&payld->tsl);
> > +		} else if (USE_BLK_TS(payld)) {
> > +			if (!tde->bts) {
> > +				/*
> > +				 * Scanning a TDCF looking for the nearest
> > +				 * previous valid BLK_TS, after having found a
> > +				 * USE_BLK_TS() payload, MUST succeed.
> > +				 */
> > +				tde->bts = scmi_telemetry_blkts_bind(ti->dev,
> > +								     shmti, payld,
> > +								     &ti->xa_bts);
> > +				if (WARN_ON(!tde->bts))
> 
> Do we have to everytime log this when it happens?
> It looks like more a debug thing, isn't it?

Yes indeed...also the BLK_TS lines are more immature in the
implementation and alreasy changed in the spec...I will drop this

> 
> > +					return;
> > +			}
> > +
> > +			tstamp = scmi_telemetry_blkts_read(tde->last_magic,
> > +							   tde->bts);
> > +		}
> > +	}
> > +
> > +	guard(mutex)(&tde->mtx);
> > +	tde->last_magic = shmti->last_magic;
> > +	tde->last_val = val;
> > +	if (de->tstamp_enabled)
> > +		tde->last_ts = tstamp;
> > +	else
> > +		tde->last_ts = 0;
> > +}
> > +
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
> > +	if (DATA_INVALID(payld))
> > +		return used_qwords;
> > +
> > +	if (!IS_BLK_TS(payld))
> > +		scmi_telemetry_tdcf_data_parse(ti, payld, shmti, update);
> > +	else
> > +		scmi_telemetry_tdcf_blkts_parse(ti, payld, shmti);
> > +
> > +	return used_qwords;
> > +}
> > +
> > +static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
> > +				     unsigned int shmti_id, u64 ts,
> > +				     bool update)
> > +{
> > +	struct telemetry_shmti *shmti = &ti->shmti[shmti_id];
> > +	struct tdcf __iomem *tdcf = shmti->base;
> > +	int retries = SCMI_TLM_TDCF_MAX_RETRIES;
> > +	u64 startm = 0, endm = 0xffffffffffffffff;
> > +	void *eplg = SHMTI_EPLG(shmti);
> > +
> > +	if (!tdcf)
> > +		return -ENODEV;
> > +
> > +	do {
> > +		unsigned int qwords;
> > +		void __iomem *next;
> > +
> > +		/* A bit of exponential backoff between retries */
> > +		fsleep((SCMI_TLM_TDCF_MAX_RETRIES - retries) * 1000);
> 
> This is something that I would like to understand more.
> 

TDCF Shared memory area embed a pair of always increasing SEQ_NUMBERS
that are updated in sequence by the platform when the TDCF data are
updatred...this is to enable the agent to spot corruption due to an
agent read performed during a platform update...so it is possible that 

> > +
> > +		startm = TDCF_START_SEQ_GET(tdcf);

... we read the startm initial sequence number

> > +		if (IS_BAD_START_SEQ(startm))
> > +			continue;
> > +
> > +		/* On a BAD_SEQ this will be updated on the next attempt */
> > +		shmti->last_magic = startm;
> > +
> > +		qwords = tdcf->prlg.num_qwords;
> > +		next = tdcf->payld;
> > +		while (qwords) {
> > +			int used_qwords;
> > +
> > +			used_qwords = scmi_telemetry_tdcf_line_parse(ti, next,
> > +								     shmti, update);
> > +			if (qwords < used_qwords)
> > +				return -EINVAL;
> > +
> > +			next += used_qwords * 8;
> > +			qwords -= used_qwords;
> > +		}

..we gather the data...

> > +
> > +		endm = TDCF_END_SEQ_GET(eplg);
> > +	} while (startm != endm && --retries);

..we read the final seq_num and check...if there is a mismatch we haev
to retry.... 

...the above fsleep implements an exponential backoff timer (ethernet
style-ish) in order to reduce the odds of hitting multiple times in a
row such a race ...

> > +
> > +	if (startm != endm)
> > +		return -EPROTO;
> > +
> > +	return 0;
> > +}
> > +
> 
> I will take a few steps in this big patch ;)

Thanks,
Cristian

