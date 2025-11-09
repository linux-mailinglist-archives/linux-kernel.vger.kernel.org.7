Return-Path: <linux-kernel+bounces-892203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C8C449D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF5A14E3275
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D74A26FA6F;
	Sun,  9 Nov 2025 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxEWor7G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+q+ymMH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54C423D7C8
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730008; cv=none; b=D6LvycDNnA9HJDJAOiCklej+utm9xolKiVDIoRq5jY9D1xFiKrY9Rsr15hfrLIsoSfiiaGTLTAWppFdGKOaU/NzU8Y10b7E/YSBSv5vzUHCugboIsP49qXbm8bEtat7Rk/d06OpLlCZz208Hxa83WMYWm6oFg1BvVz6GoGw+4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730008; c=relaxed/simple;
	bh=ezJEd6R9FiQdCHths2GNBqoN7Ib3hZg+cfKDo5T6eWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucgX4VuDtRR6sVGYaKEXaj6yP8lhn5Ix/T707jEnjdfChdJcYbSaEMnYrVm1h95bT+4I4Rqza/EObi6je3DznADy2mq3u/89F4o5dyrBCnCcPFt2frLJJllYaf8fslIGnEUkTuQf9NEMglhsySrwqCcF/Sch8QKHotTkTSnS7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxEWor7G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+q+ymMH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762730005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEeIgPWWcPxhEQfZM6jSCu5IBThi/HfESHnYLGFQvAI=;
	b=FxEWor7GqmsJnKwF4+MQma8gsGN+LiWLyXYkvOk+aXlYCtzKR5PN4LahvATwGlp87Yu6ag
	MV6gaNMFa/LcVoMa8Xc9+pIkmI6rDqm3Ik27UM0lY3/sT3e+v/9S8G5EyovZtNmszP3Gpb
	PW/AWYHJQ38ABhX61ND462GUQf3lniM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-ff9Mtd3-NfeNVM3tY_CHpg-1; Sun, 09 Nov 2025 18:13:22 -0500
X-MC-Unique: ff9Mtd3-NfeNVM3tY_CHpg-1
X-Mimecast-MFC-AGG-ID: ff9Mtd3-NfeNVM3tY_CHpg_1762730001
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34385d7c4a7so662379a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762730001; x=1763334801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LEeIgPWWcPxhEQfZM6jSCu5IBThi/HfESHnYLGFQvAI=;
        b=S+q+ymMH/xOo14wnqMMF8IpeDXJi4ymRDWg77L+Ou/GdjMJTY0odR+VSkYEvUP5Aog
         P8iuFH3NQuvn82MectORUfpUajaor0B7KYe56lPfewKMw6S/ZuNInl9vL/Y3Jxu7QDho
         F4yX5vJ1YMBdKfH4q/BZ4UlwKRWPfMU+CE0HprnOd1XIgVV+tgGnUkoo+6Vp8PX+w24f
         hrwXcss2ErmowUbMfemOSw847UemAX36bA6GdnfO9uiwyRPMpr4MslTMSoy0OWO/HgEb
         tFtzBOVMtRA48SE3Bb7UdyzDmhWsWx81CFQSb2vH9uwFaL5rTloVYPWdpH89tAs36U+E
         C9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730001; x=1763334801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEeIgPWWcPxhEQfZM6jSCu5IBThi/HfESHnYLGFQvAI=;
        b=Ky01Eu/+fLYJyTFjy8HQTjUvNgQM5+5WsnzYUBzbwbt3YmeVcFxe7TGeRTZqKzPhag
         pM66vsZzox3HotoCdcIJHHShTalPu6rcvETjnsFft2hPXVK9Y/PNDLfHm8ITwdMYZ+Dl
         jyk/3bXIC+RkNH4AXmNnlV3p2OWV0pfQqXsaALVfxFkpSq/gjV/rARHICUrZ6LBq9sse
         8aiS8dKXWRi7y1KgIsAUhaD6IcektMHY1NOZDv/U44iNvncnm2PSn0jO6F/YxoPLtCpa
         g+36IdY65LxqBn2L7RObZZXN0C3IHrGiUOLSpCAJ5JOwn12RPTuypyrhBqfU/DI1drvP
         Fzcg==
X-Forwarded-Encrypted: i=1; AJvYcCXtC1tCFFidaZOrFuYM4hAUOehvZab+9AecIgIjj67ii9bwaAzb7KGg8+rHopzsHKaWyCMSvSE8WTIiSmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpD+rkwEa0HFOG3XdhdyDg4wcoZh5U7d1jOCvXZP7zwmSQXI+L
	8yVlWx5jgwE1XFn6MNGXyep+4x8H3zOToT1OsQRfIE7f2STCw1I5geY7enktV7WPNKqezCu5H/n
	/Z3dbnDJjX762l1PgOhwpku+crxjMKT0bfJS+37zVuNMmWCOek2TWmyGI0CsACZ4o+w==
X-Gm-Gg: ASbGnctxIPJS7tNR7S8Lvt6nfht1ImL/BWtWnTvnjfeJ6NQeYOPJELxyE9eY5e8bVne
	eIVhxvhTXs/11QNK7PzLf5CZzwy0tHjIkKOIRn2Vb8gE3NHhWfjmcbUr0MvajaSaGQOXtAWIftX
	ZvS4aZAe8IgBCtOsx+2Qa0ISB6GTzPoYfQ2hC/ypgbP3f9qR+teFM3povEvf0GfqyfxC6lPEGaW
	XyM7W30PuuE9zRCrMfSw84ui2VEYVDJopDHE1+iJ+XDR6QtK2MbMGRN6mc9jMHXWG0iRczWCk7s
	P7WRQt6i1drNvUxtaG9mlWbJTaf2nAGsHTTsrO+aGYYWAiejRk7t0NjbYi6fMglaIUOsgnLVPB7
	n9siLW6P+KoEMlLvLzRx0ISmwFDH8qkAJFP9AdcI=
X-Received: by 2002:a17:90b:2551:b0:340:c094:fbff with SMTP id 98e67ed59e1d1-34353674a16mr10207150a91.10.1762730001285;
        Sun, 09 Nov 2025 15:13:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt8iNrPieEZUrHG1EFNiaLkUSXMP7VX/YSKIvQnKZqDjoS5F1ysKVWw5vdZEU+bbAqEe/mjA==
X-Received: by 2002:a17:90b:2551:b0:340:c094:fbff with SMTP id 98e67ed59e1d1-34353674a16mr10207135a91.10.1762730000866;
        Sun, 09 Nov 2025 15:13:20 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c332f1csm8678045a91.11.2025.11.09.15.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:13:20 -0800 (PST)
Message-ID: <61680de1-6732-48a6-a871-9cc9f17f6759@redhat.com>
Date: Mon, 10 Nov 2025 09:13:07 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/33] arm_mpam: Add mpam_msmon_read() to read monitor
 value
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-27-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-27-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Reading a monitor involves configuring what you want to monitor, and
> reading the value. Components made up of multiple MSC may need values
> from each MSC. MSCs may take time to configure, returning 'not ready'.
> The maximum 'not ready' time should have been provided by firmware.
> 
> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns
> not ready, then wait the full timeout value before trying again.
> 
> CC: Shanker Donthineni <sdonthineni@nvidia.com>
> Cc: Shaopeng Tan (Fujitsu) <tan.shaopeng@fujitsu.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Add tag - thanks
> Bring config_mismatch into this commit (Jonathan)
> whitespace
> ---
>   drivers/resctrl/mpam_devices.c  | 237 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |  19 +++
>   2 files changed, 256 insertions(+)
> 

With below minor comments addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index f51ffb1400db..86abbac5e1ad 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -886,6 +886,243 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   	return 0;
>   }
>   
> +struct mon_read {
> +	struct mpam_msc_ris		*ris;
> +	struct mon_cfg			*ctx;
> +	enum mpam_device_features	type;
> +	u64				*val;
> +	int				err;
> +};
> +
> +static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
> +				   u32 *flt_val)
> +{
> +	struct mon_cfg *ctx = m->ctx;
> +
> +	/*
> +	 * For CSU counters its implementation-defined what happens when not
> +	 * filtering by partid.
> +	 */
> +	*ctl_val = MSMON_CFG_x_CTL_MATCH_PARTID;
> +
> +	*flt_val = FIELD_PREP(MSMON_CFG_x_FLT_PARTID, ctx->partid);
> +
> +	if (m->ctx->match_pmg) {
> +		*ctl_val |= MSMON_CFG_x_CTL_MATCH_PMG;
> +		*flt_val |= FIELD_PREP(MSMON_CFG_x_FLT_PMG, ctx->pmg);
> +	}
> +
> +	switch (m->type) {
> +	case mpam_feat_msmon_csu:
> +		*ctl_val |= MSMON_CFG_CSU_CTL_TYPE_CSU;
> +
> +		if (mpam_has_feature(mpam_feat_msmon_csu_xcl, &m->ris->props))
> +			*flt_val |= FIELD_PREP(MSMON_CFG_CSU_FLT_XCL,
> +					       ctx->csu_exclude_clean);

{} missed here.

> +
> +		break;
> +	case mpam_feat_msmon_mbwu:
> +		*ctl_val |= MSMON_CFG_MBWU_CTL_TYPE_MBWU;
> +
> +		if (mpam_has_feature(mpam_feat_msmon_mbwu_rwbw, &m->ris->props))
> +			*flt_val |= FIELD_PREP(MSMON_CFG_MBWU_FLT_RWBW, ctx->opts);
> +
> +		break;
> +	default:
> +		return;

s/return/break

We may add a error message here:

		pr_warn("Unsupported feature %d\n", m->type);
		

> +	}
> +}
> +
> +static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
> +				    u32 *flt_val)
> +{
> +	struct mpam_msc *msc = m->ris->vmsc->msc;
> +
> +	switch (m->type) {
> +	case mpam_feat_msmon_csu:
> +		*ctl_val = mpam_read_monsel_reg(msc, CFG_CSU_CTL);
> +		*flt_val = mpam_read_monsel_reg(msc, CFG_CSU_FLT);
> +		return;
> +	case mpam_feat_msmon_mbwu:
> +		*ctl_val = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
> +		*flt_val = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
> +		return;
> +	default:
> +		return;
> +	}
> +}

s/return/break for all cases, and maybe a warning message for the
default case.

> +
> +/* Remove values set by the hardware to prevent apparent mismatches. */
> +static void clean_msmon_ctl_val(u32 *cur_ctl)
> +{
> +	*cur_ctl &= ~MSMON_CFG_x_CTL_OFLOW_STATUS;
> +}
> +

May be worthy be to a inline function.

> +static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
> +				     u32 flt_val)
> +{
> +	struct mpam_msc *msc = m->ris->vmsc->msc;
> +
> +	/*
> +	 * Write the ctl_val with the enable bit cleared, reset the counter,
> +	 * then enable counter.
> +	 */
> +	switch (m->type) {
> +	case mpam_feat_msmon_csu:
> +		mpam_write_monsel_reg(msc, CFG_CSU_FLT, flt_val);
> +		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
> +		mpam_write_monsel_reg(msc, CSU, 0);
> +		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
> +		break;
> +	case mpam_feat_msmon_mbwu:
> +		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
> +		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
> +		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
> +		/* Counting monitors require NRDY to be reset by software */
> +		mpam_write_monsel_reg(msc, MBWU, 0);
> +		break;
> +	default:
> +		return;

s/return/break, and maybe a warning message for the default case.

> +	}
> +}
> +
> +static void __ris_msmon_read(void *arg)
> +{
> +	u64 now;
> +	bool nrdy = false;
> +	bool config_mismatch;
> +	struct mon_read *m = arg;
> +	struct mon_cfg *ctx = m->ctx;
> +	struct mpam_msc_ris *ris = m->ris;
> +	struct mpam_props *rprops = &ris->props;
> +	struct mpam_msc *msc = m->ris->vmsc->msc;
> +	u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
> +
> +	if (!mpam_mon_sel_lock(msc)) {
> +		m->err = -EIO;
> +		return;
> +	}
> +	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, ctx->mon) |
> +		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
> +	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> +
> +	/*
> +	 * Read the existing configuration to avoid re-writing the same values.
> +	 * This saves waiting for 'nrdy' on subsequent reads.
> +	 */
> +	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
> +	clean_msmon_ctl_val(&cur_ctl);
> +	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
> +	config_mismatch = cur_flt != flt_val ||
> +			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
> +
> +	if (config_mismatch)
> +		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
> +
> +	switch (m->type) {
> +	case mpam_feat_msmon_csu:
> +		now = mpam_read_monsel_reg(msc, CSU);
> +		if (mpam_has_feature(mpam_feat_msmon_csu_hw_nrdy, rprops))
> +			nrdy = now & MSMON___NRDY;
> +		break;
> +	case mpam_feat_msmon_mbwu:
> +		now = mpam_read_monsel_reg(msc, MBWU);
> +		if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
> +			nrdy = now & MSMON___NRDY;
> +		break;
> +	default:
> +		m->err = -EINVAL;
> +		break;

This 'break' can be droped.

> +	}
> +	mpam_mon_sel_unlock(msc);
> +
> +	if (nrdy) {
> +		m->err = -EBUSY;
> +		return;
> +	}
> +
> +	now = FIELD_GET(MSMON___VALUE, now);
> +	*m->val += now;
> +}
> +
> +static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
> +{
> +	int err, any_err = 0;
> +	struct mpam_vmsc *vmsc;
> +
> +	guard(srcu)(&mpam_srcu);
> +	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		struct mpam_msc *msc = vmsc->msc;
> +		struct mpam_msc_ris *ris;
> +
> +		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
> +					 srcu_read_lock_held(&mpam_srcu)) {
> +			arg->ris = ris;
> +
> +			err = smp_call_function_any(&msc->accessibility,
> +						    __ris_msmon_read, arg,
> +						    true);
> +			if (!err && arg->err)
> +				err = arg->err;
> +
> +			/*
> +			 * Save one error to be returned to the caller, but
> +			 * keep reading counters so that get reprogrammed. On
> +			 * platforms with NRDY this lets us wait once.
> +			 */
> +			if (err)
> +				any_err = err;
> +		}
> +	}
> +
> +	return any_err;
> +}
> +
> +int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
> +		    enum mpam_device_features type, u64 *val)
> +{
> +	int err;
> +	struct mon_read arg;
> +	u64 wait_jiffies = 0;
> +	struct mpam_props *cprops = &comp->class->props;
> +
> +	might_sleep();
> +
> +	if (!mpam_is_enabled())
> +		return -EIO;
> +
> +	if (!mpam_has_feature(type, cprops))
> +		return -EOPNOTSUPP;
> +
> +	arg = (struct mon_read) {
> +		.ctx = ctx,
> +		.type = type,
> +		.val = val,
> +	};
> +	*val = 0;
> +
> +	err = _msmon_read(comp, &arg);
> +	if (err == -EBUSY && comp->class->nrdy_usec)
> +		wait_jiffies = usecs_to_jiffies(comp->class->nrdy_usec);
> +
> +	while (wait_jiffies)
> +		wait_jiffies = schedule_timeout_uninterruptible(wait_jiffies);
> +
> +	if (err == -EBUSY) {
> +		arg = (struct mon_read) {
> +			.ctx = ctx,
> +			.type = type,
> +			.val = val,
> +		};
> +		*val = 0;
> +
> +		err = _msmon_read(comp, &arg);
> +	}
> +
> +	return err;
> +}
> +
>   static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>   {
>   	u32 num_words, msb;
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index e59c0f4d9ada..d8f8e29987e0 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -184,6 +184,22 @@ struct mpam_props {
>   #define mpam_set_feature(_feat, x)	set_bit(_feat, (x)->features)
>   #define mpam_clear_feature(_feat, x)	clear_bit(_feat, (x)->features)
>   
> +/* The values for MSMON_CFG_MBWU_FLT.RWBW */
> +enum mon_filter_options {
> +	COUNT_BOTH	= 0,
> +	COUNT_WRITE	= 1,
> +	COUNT_READ	= 2,
> +};
> +
> +struct mon_cfg {
> +	u16			mon;
> +	u8			pmg;
> +	bool			match_pmg;
> +	bool			csu_exclude_clean;
> +	u32			partid;
> +	enum mon_filter_options opts;
> +};
> +
>   struct mpam_class {
>   	/* mpam_components in this class */
>   	struct list_head	components;
> @@ -327,6 +343,9 @@ void mpam_disable(struct work_struct *work);
>   int mpam_apply_config(struct mpam_component *comp, u16 partid,
>   		      struct mpam_config *cfg);
>   
> +int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
> +		    enum mpam_device_features, u64 *val);
> +
>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>   				   cpumask_t *affinity);
>   
Thanks,
Gavin


