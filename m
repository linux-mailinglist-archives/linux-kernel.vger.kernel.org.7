Return-Path: <linux-kernel+bounces-892196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CFFC4498F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3857C3B048C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C0426ED36;
	Sun,  9 Nov 2025 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CwRFBIRj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWe/CUBU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11F21C861D
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762729197; cv=none; b=r1oSVtNR5iYyD9YjFKHEN6xI+E+PViRcGrcAGoVqV5p6FUGoNFsYzsxEFRfW1TxDnC/An5msPAhbWeQBPuprBufsYDPoh3JfTD8dmDFhal81y4FUTPSkLmKyHOpqVDYlWvgkP9adPmk1l2bfbiCY9UadFtedub2P9glXyRUbPqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762729197; c=relaxed/simple;
	bh=lVXRTPlTxPAijL8xTEEFXxrnxnD5S/Rd3PoPKk/8/3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9bAKiZTECIst9JvHZ9WdZI/h3ObC62PopB2KiAeGLMfaXbdA5V5BjcCtMfR0FusGlVukSfr6YSy/Tin/ncipf/J6A9xig+Q7U8FVTL9Vi06kJAHRECISpH59ciZ0qd+h7qn6QL9V1qjSKWqmKp7vCJqrNV3KMUVEvLXxCJpbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CwRFBIRj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWe/CUBU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762729193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sw8CrBV05AO5Nvkk8UzNDcbqjB36gaK/xhWONAU3tk0=;
	b=CwRFBIRjPVd2xvMe8ybVd+RFnnqsSZWaVjwnte3sEeZoGmVZg3gGF95voXUTV2qEl1cYEV
	HvgV29HcCtuz1B+WrDFBgg4o10sl2ocJz23SrthNln1kVcz9fFv6aOOu9rD1GHOL+Qor5p
	oEq22c6Eyfu0YOpvJjWBz/QIF/hv+q0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-iLHMp5S6MuWtpKtNhOwY_g-1; Sun, 09 Nov 2025 17:59:50 -0500
X-MC-Unique: iLHMp5S6MuWtpKtNhOwY_g-1
X-Mimecast-MFC-AGG-ID: iLHMp5S6MuWtpKtNhOwY_g_1762729190
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340c261fb38so5326835a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 14:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762729190; x=1763333990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sw8CrBV05AO5Nvkk8UzNDcbqjB36gaK/xhWONAU3tk0=;
        b=cWe/CUBU0FrmbGE6YWBbHP84M9WbfY5jQ23KFyldKY2vqCbglaArYLnY6bk9j7nItH
         h24GxPP0YFZz7Xsz8tBw/qt5cqtsuEQ/Tu4gQZpDpHHRUg55CjivQ9Aq23wpRcw7gMiV
         rco9uvLS8OVefKGpmz8Tu8IClW1ID4i5a9d2/aJxai06ugCCwhJ6v6mS1C4KvdtCUNT4
         mdCycYN0Nwx7n2268GVB82RBwjMWkgKO2WUvoSONGaZJRw9vwCg2lluqaAiaJvTY4Xg4
         ZojYQQ8rH+IVSL4HhG1zTfNIey5Rx/Ja8V/H8R8EoH84FilG8+s/IQWfXUJ771hVHauB
         YM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762729190; x=1763333990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw8CrBV05AO5Nvkk8UzNDcbqjB36gaK/xhWONAU3tk0=;
        b=fW5S6HjCD77O5HQkCjKQAsdfXvw0jUkvhh5Ie3GnGx/2dKpSajZnqDL/BxyMd/4OWO
         TJzhRxJ0eIhWkGiljvvJWGW4tvAS8F/GXnmHQ7wIxne/vdDYS9hy317NwKxesFPXu4l4
         6dLvVd4JCrTqhvlyfmEfTVQifFP2OrVZ0GkDhSTp3i1pXQJC8r1qf2PvDijIcg1g6JGn
         pJI343KbhwQ1Ho3mnnBL3wECbDKLfX31odRkUgZ/ifsrIQOgj0drncZFBILFmL61Omw8
         4wEMIeyxoZDSB1S+wLdVszDAXKUYDF2m7jNtWvozfMzR4CyRW18P9JsbpMYfCzFUMjmQ
         ON3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhIeISHfjQYO6q9jAz/df68r+sUzt28/VpcwVAOXgaTPFKZGg51MxKL6lzdOCVCWuuDs+UBYD88rTcQ6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5Yra7a65R9bw6i+HdeTCjyl0C2o3mtmjce0CRumPiXKKNuzS
	fYQKCbQ2qssuXpooQ+Cn5U/aw/huYkc5aRPviGkFiZR7PWnizNYhR6bL7iFLenBw3PbJsTx+LK1
	dj6kJUviqWFFwhTmMLVFm7gFxcpnRua/TK2fLRJsy1IJ3njqFN4bc4FXqSFtSFmHRdg==
X-Gm-Gg: ASbGncsidPD0ZJdEC9wXmMHsnuTEpWBiBPGBGEUFdcxBXVEXZY6ltCriN5fTCepInd2
	fTUUNqu6WHiEmWl7O0q3CDXDoqo3UPgrnTQ7in55GerBytKk+EMe90JjSAsh9whdc8/jaMM0muI
	jPiYKf6O7vw0flQgQusj0ZyQfPPcRYwQ4GFbtCDh5tCjcJOulMjge0GIgoygFpWHAp2zsLvpraj
	PpxN32+SagmriXd9jsUQ1tngwtQQ7vVnds5AxR4mHQ3qT4/Mp8zWlejO2pjt7rzKpE3yn2zJRDL
	TrIEwGi+hWF6Hx4Q3ByLjkYB7GeJPYb0zlsJOk8Lismb7NYo69AysyNwk6EUoROTsLT/IWU6AhX
	Gp796rk3Mket57UY8Ob+SHm/THkt9T15l3+TAFak=
X-Received: by 2002:a17:90b:4b0e:b0:33b:bed8:891e with SMTP id 98e67ed59e1d1-3436cb91e05mr9074466a91.19.1762729189566;
        Sun, 09 Nov 2025 14:59:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy1VWfCk2l3lGJLjo1ywotcoYT+aMBtO2f4pshYG3XVzKJ/TOFfY9N9+JauCQiTd0Felft1A==
X-Received: by 2002:a17:90b:4b0e:b0:33b:bed8:891e with SMTP id 98e67ed59e1d1-3436cb91e05mr9074424a91.19.1762729189073;
        Sun, 09 Nov 2025 14:59:49 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8d7eedcsm10930841a12.2.2025.11.09.14.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:59:48 -0800 (PST)
Message-ID: <07acf54a-231f-428d-ac94-f4f9ec95de21@redhat.com>
Date: Mon, 10 Nov 2025 08:59:35 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/33] arm_mpam: Allow configuration to be applied and
 restored during cpu online
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
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-24-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-24-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> When CPUs come online the MSC's original configuration should be restored.
> 
> Add struct mpam_config to hold the configuration. This has a bitmap of
> features that were modified. Once the maximum partid is known, allocate
> a configuration array for each component, and reprogram each RIS
> configuration from this.
> 
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Shaopeng Tan (Fujitsu) tan.shaopeng@fujitsu.com
> Cc: Peter Newman peternewman@google.com
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Drop tags
> Fix component reset, otherwise cpbm wrong and controls not set.
> Add a cfg_lock to guard configuration of an msc
> ---
>   drivers/resctrl/mpam_devices.c  | 268 ++++++++++++++++++++++++++++++--
>   drivers/resctrl/mpam_internal.h |  27 ++++
>   2 files changed, 280 insertions(+), 15 deletions(-)
> 

With the following comments addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 3a0ad8d93fff..8b0944bdaf28 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -144,6 +144,16 @@ static void mpam_free_garbage(void)
>   	}
>   }
>   
> +/*
> + * Once mpam is enabled, new requestors cannot further reduce the available
> + * partid. Assert that the size is fixed, and new requestors will be turned
> + * away.
> + */
> +static void mpam_assert_partid_sizes_fixed(void)
> +{
> +	WARN_ON_ONCE(!partid_max_published);
> +}
> +

Would be worthy to be a online function.

>   static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)
>   {
>   	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> @@ -343,6 +353,7 @@ mpam_component_alloc(struct mpam_class *class, int id)
>   	return comp;
>   }
>   
> +static void __destroy_component_cfg(struct mpam_component *comp);
>   static void mpam_class_destroy(struct mpam_class *class);
>   
>   static void mpam_component_destroy(struct mpam_component *comp)
> @@ -351,6 +362,8 @@ static void mpam_component_destroy(struct mpam_component *comp)
>   
>   	lockdep_assert_held(&mpam_list_lock);
>   
> +	__destroy_component_cfg(comp);
> +
>   	list_del_rcu(&comp->class_list);
>   	add_to_garbage(comp);
>   
> @@ -820,31 +833,59 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>   	__mpam_write_reg(msc, reg, bm);
>   }
>   
> -static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
> +/* Called via IPI. Call while holding an SRCU reference */
> +static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
> +				      struct mpam_config *cfg)
>   {
>   	struct mpam_msc *msc = ris->vmsc->msc;
>   	struct mpam_props *rprops = &ris->props;
>   
> -	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
> -
>   	mutex_lock(&msc->part_sel_lock);
>   	__mpam_part_sel(ris->ris_idx, partid, msc);
>   
> -	if (mpam_has_feature(mpam_feat_cpor_part, rprops))
> -		mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM, rprops->cpbm_wd);
> +	if (mpam_has_feature(mpam_feat_cpor_part, rprops) &&
> +	    mpam_has_feature(mpam_feat_cpor_part, cfg)) {
> +		if (cfg->reset_cpbm)
> +			mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
> +					      rprops->cpbm_wd);
> +		else
> +			mpam_write_partsel_reg(msc, CPBM, cfg->cpbm);
> +	}

{} is needed by 'if (cfg->reset_cpbm)'

>   
> -	if (mpam_has_feature(mpam_feat_mbw_part, rprops))
> -		mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM, rprops->mbw_pbm_bits);
> +	if (mpam_has_feature(mpam_feat_mbw_part, rprops) &&
> +	    mpam_has_feature(mpam_feat_mbw_part, cfg)) {
> +		if (cfg->reset_mbw_pbm)
> +			mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM,
> +					      rprops->mbw_pbm_bits);
> +		else
> +			mpam_write_partsel_reg(msc, MBW_PBM, cfg->mbw_pbm);
> +	}
>   

{ } is need by 'if (cfg->reset_mbw_pbm)'

> -	if (mpam_has_feature(mpam_feat_mbw_min, rprops))
> +	if (mpam_has_feature(mpam_feat_mbw_min, rprops) &&
> +	    mpam_has_feature(mpam_feat_mbw_min, cfg))
>   		mpam_write_partsel_reg(msc, MBW_MIN, 0);
>   
> -	if (mpam_has_feature(mpam_feat_mbw_max, rprops))
> -		mpam_write_partsel_reg(msc, MBW_MAX, MPAMCFG_MBW_MAX_MAX);
> +	if (mpam_has_feature(mpam_feat_mbw_max, rprops) &&
> +	    mpam_has_feature(mpam_feat_mbw_max, cfg)) {
> +		if (cfg->reset_mbw_max)
> +			mpam_write_partsel_reg(msc, MBW_MAX, MPAMCFG_MBW_MAX_MAX);
> +		else
> +			mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
> +	}
>   
>   	mutex_unlock(&msc->part_sel_lock);
>   }
>   
> +static void mpam_init_reset_cfg(struct mpam_config *reset_cfg)
> +{
> +	*reset_cfg = (struct mpam_config) {
> +		.reset_cpbm = true,
> +		.reset_mbw_pbm = true,
> +		.reset_mbw_max = true,
> +	};
> +	bitmap_fill(reset_cfg->features, MPAM_FEATURE_LAST);
> +}
> +
>   /*
>    * Called via smp_call_on_cpu() to prevent migration, while still being
>    * pre-emptible. Caller must hold mpam_srcu.
> @@ -852,16 +893,19 @@ static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
>   static int mpam_reset_ris(void *arg)
>   {
>   	u16 partid, partid_max;
> +	struct mpam_config reset_cfg;
>   	struct mpam_msc_ris *ris = arg;
>   
>   	if (ris->in_reset_state)
>   		return 0;
>   
> +	mpam_init_reset_cfg(&reset_cfg);
> +
>   	spin_lock(&partid_max_lock);
>   	partid_max = mpam_partid_max;
>   	spin_unlock(&partid_max_lock);
>   	for (partid = 0; partid <= partid_max; partid++)
> -		mpam_reset_ris_partid(ris, partid);
> +		mpam_reprogram_ris_partid(ris, partid, &reset_cfg);
>   
>   	return 0;
>   }
> @@ -894,6 +938,7 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>   {
>   	struct mpam_msc_ris *ris;
>   
> +	mutex_lock(&msc->cfg_lock);
>   	list_for_each_entry_srcu(ris, &msc->ris, msc_list, srcu_read_lock_held(&mpam_srcu)) {
>   		mpam_touch_msc(msc, &mpam_reset_ris, ris);
>   
> @@ -903,6 +948,61 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>   		 */
>   		ris->in_reset_state = online;
>   	}
> +	mutex_unlock(&msc->cfg_lock);
> +}
> +
> +struct mpam_write_config_arg {
> +	struct mpam_msc_ris *ris;
> +	struct mpam_component *comp;
> +	u16 partid;
> +};
> +
> +static int __write_config(void *arg)
> +{
> +	struct mpam_write_config_arg *c = arg;
> +
> +	mpam_reprogram_ris_partid(c->ris, c->partid, &c->comp->cfg[c->partid]);
> +
> +	return 0;
> +}
> +
> +static void mpam_reprogram_msc(struct mpam_msc *msc)
> +{
> +	u16 partid;
> +	bool reset;
> +	struct mpam_config *cfg;
> +	struct mpam_msc_ris *ris;
> +	struct mpam_write_config_arg arg;
> +
> +	/*
> +	 * No lock for mpam_partid_max as partid_max_published has been
> +	 * set by mpam_enabled(), so the values can no longer change.
> +	 */
> +	mpam_assert_partid_sizes_fixed();
> +
> +	mutex_lock(&msc->cfg_lock);
> +	list_for_each_entry_srcu(ris, &msc->ris, msc_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		if (!mpam_is_enabled() && !ris->in_reset_state) {
> +			mpam_touch_msc(msc, &mpam_reset_ris, ris);
> +			ris->in_reset_state = true;
> +			continue;
> +		}
> +
> +		arg.comp = ris->vmsc->comp;
> +		arg.ris = ris;
> +		reset = true;
> +		for (partid = 0; partid <= mpam_partid_max; partid++) {
> +			cfg = &ris->vmsc->comp->cfg[partid];
> +			if (!bitmap_empty(cfg->features, MPAM_FEATURE_LAST))
> +				reset = false;
> +

s/!bitmap_empty()/!bitmap_full (?)

> +			arg.partid = partid;
> +			mpam_touch_msc(msc, __write_config, &arg);
> +		}
> +		ris->in_reset_state = reset;
> +	}
> +	mutex_unlock(&msc->cfg_lock);
>   }
>   
>   static void _enable_percpu_irq(void *_irq)
> @@ -926,7 +1026,7 @@ static int mpam_cpu_online(unsigned int cpu)
>   			_enable_percpu_irq(&msc->reenable_error_ppi);
>   
>   		if (atomic_fetch_inc(&msc->online_refs) == 0)
> -			mpam_reset_msc(msc, true);
> +			mpam_reprogram_msc(msc);
>   	}
>   
>   	return 0;
> @@ -1125,6 +1225,9 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>   	if (err)
>   		return ERR_PTR(err);
>   	err = devm_mutex_init(dev, &msc->error_irq_lock);
> +	if (err)
> +		return ERR_PTR(err);
> +	err = devm_mutex_init(dev, &msc->cfg_lock);
>   	if (err)
>   		return ERR_PTR(err);
>   	mpam_mon_sel_lock_init(msc);
> @@ -1585,6 +1688,70 @@ static void mpam_unregister_irqs(void)
>   	}
>   }
>   
> +static void __destroy_component_cfg(struct mpam_component *comp)
> +{
> +	add_to_garbage(comp->cfg);
> +}
> +
> +static void mpam_reset_component_cfg(struct mpam_component *comp)
> +{
> +	int i;
> +	struct mpam_props *cprops = &comp->class->props;
> +
> +	mpam_assert_partid_sizes_fixed();
> +
> +	if (!comp->cfg)
> +		return;
> +
> +	for (i = 0; i <= mpam_partid_max; i++) {
> +		comp->cfg[i] = (struct mpam_config) {};
> +		bitmap_fill(comp->cfg[i].features, MPAM_FEATURE_LAST);
> +		bitmap_set((unsigned long *)&comp->cfg[i].cpbm, 0, cprops->cpbm_wd);
> +		bitmap_set((unsigned long *)&comp->cfg[i].mbw_pbm, 0, cprops->mbw_pbm_bits);
> +		bitmap_set((unsigned long *)&comp->cfg[i].mbw_max, 16 - cprops->bwa_wd, cprops->bwa_wd);
> +	}
> +}
> +
> +static int __allocate_component_cfg(struct mpam_component *comp)
> +{
> +	mpam_assert_partid_sizes_fixed();
> +
> +	if (comp->cfg)
> +		return 0;
> +
> +	comp->cfg = kcalloc(mpam_partid_max + 1, sizeof(*comp->cfg), GFP_KERNEL);
> +	if (!comp->cfg)
> +		return -ENOMEM;
> +
> +	/*
> +	 * The array is free()d in one go, so only cfg[0]'s structure needs
> +	 * to be initialised.
> +	 */
> +	init_garbage(&comp->cfg[0].garbage);
> +
> +	mpam_reset_component_cfg(comp);
> +
> +	return 0;
> +}
> +
> +static int mpam_allocate_config(void)
> +{
> +	struct mpam_class *class;
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(class, &mpam_classes, classes_list) {
> +		list_for_each_entry(comp, &class->components, class_list) {
> +			int err = __allocate_component_cfg(comp);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static void mpam_enable_once(void)
>   {
>   	int err;
> @@ -1604,15 +1771,25 @@ static void mpam_enable_once(void)
>   	 */
>   	cpus_read_lock();
>   	mutex_lock(&mpam_list_lock);
> -	mpam_enable_merge_features(&mpam_classes);
> +	do {
> +		mpam_enable_merge_features(&mpam_classes);
>   
> -	err = mpam_register_irqs();
> +		err = mpam_register_irqs();
> +		if (err) {
> +			pr_warn("Failed to register irqs: %d\n", err);
> +			break;
> +		}
>   
> +		err = mpam_allocate_config();
> +		if (err) {
> +			pr_err("Failed to allocate configuration arrays.\n");
> +			break;
> +		}
> +	} while (0);
>   	mutex_unlock(&mpam_list_lock);
>   	cpus_read_unlock();
>   
>   	if (err) {
> -		pr_warn("Failed to register irqs: %d\n", err);
>   		mpam_disable_reason = "Failed to enable.";
>   		schedule_work(&mpam_broken_work);
>   		return;
> @@ -1632,6 +1809,9 @@ static void mpam_reset_component_locked(struct mpam_component *comp)
>   	struct mpam_vmsc *vmsc;
>   
>   	lockdep_assert_cpus_held();
> +	mpam_assert_partid_sizes_fixed();
> +
> +	mpam_reset_component_cfg(comp);
>   
>   	guard(srcu)(&mpam_srcu);
>   	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
> @@ -1732,6 +1912,64 @@ void mpam_enable(struct work_struct *work)
>   		mpam_enable_once();
>   }
>   
> +#define maybe_update_config(cfg, feature, newcfg, member, changes) do { \
> +	if (mpam_has_feature(feature, newcfg) &&			\
> +	    (newcfg)->member != (cfg)->member) {			\
> +		(cfg)->member = (newcfg)->member;			\
> +		mpam_set_feature(feature, cfg);				\
> +									\
> +		(changes) = true;					\
> +	}								\
> +} while (0)
> +
> +static bool mpam_update_config(struct mpam_config *cfg,
> +			       const struct mpam_config *newcfg)
> +{
> +	bool has_changes = false;
> +
> +	maybe_update_config(cfg, mpam_feat_cpor_part, newcfg, cpbm, has_changes);
> +	maybe_update_config(cfg, mpam_feat_mbw_part, newcfg, mbw_pbm, has_changes);
> +	maybe_update_config(cfg, mpam_feat_mbw_max, newcfg, mbw_max, has_changes);
> +
> +	return has_changes;
> +}
> +
> +int mpam_apply_config(struct mpam_component *comp, u16 partid,
> +		      struct mpam_config *cfg)
> +{
> +	struct mpam_write_config_arg arg;
> +	struct mpam_msc_ris *ris;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc *msc;
> +
> +	lockdep_assert_cpus_held();
> +
> +	/* Don't pass in the current config! */
> +	WARN_ON_ONCE(&comp->cfg[partid] == cfg);
> +
> +	if (!mpam_update_config(&comp->cfg[partid], cfg))
> +		return 0;
> +
> +	arg.comp = comp;
> +	arg.partid = partid;
> +
> +	guard(srcu)(&mpam_srcu);
> +	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		msc = vmsc->msc;
> +
> +		mutex_lock(&msc->cfg_lock);
> +		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
> +					 srcu_read_lock_held(&mpam_srcu)) {
> +			arg.ris = ris;
> +			mpam_touch_msc(msc, __write_config, &arg);
> +		}
> +		mutex_unlock(&msc->cfg_lock);
> +	}
> +
> +	return 0;
> +}
> +
>   static int __init mpam_msc_driver_init(void)
>   {
>   	if (!system_supports_mpam())
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index c6937161877a..842d32f148b5 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -91,6 +91,9 @@ struct mpam_msc {
>   	 */
>   	struct mutex		part_sel_lock;
>   
> +	/* cfg_lock protects the msc configuration. */
> +	struct mutex		cfg_lock;
> +
>   	/*
>   	 * mon_sel_lock protects access to the MSC hardware registers that are
>   	 * affected by MPAMCFG_MON_SEL, and the mbwu_state.
> @@ -180,6 +183,21 @@ struct mpam_class {
>   	struct mpam_garbage	garbage;
>   };
>   
> +struct mpam_config {
> +	/* Which configuration values are valid. */
> +	DECLARE_BITMAP(features, MPAM_FEATURE_LAST);
> +
> +	u32	cpbm;
> +	u32	mbw_pbm;
> +	u16	mbw_max;
> +
> +	bool	reset_cpbm;
> +	bool	reset_mbw_pbm;
> +	bool	reset_mbw_max;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
>   struct mpam_component {
>   	u32			comp_id;
>   
> @@ -188,6 +206,12 @@ struct mpam_component {
>   
>   	cpumask_t		affinity;
>   
> +	/*
> +	 * Array of configuration values, indexed by partid.
> +	 * Read from cpuhp callbacks, hold the cpuhp lock when writing.
> +	 */
> +	struct mpam_config	*cfg;
> +
>   	/* member of mpam_class:components */
>   	struct list_head	class_list;
>   
> @@ -247,6 +271,9 @@ extern u8 mpam_pmg_max;
>   void mpam_enable(struct work_struct *work);
>   void mpam_disable(struct work_struct *work);
>   
> +int mpam_apply_config(struct mpam_component *comp, u16 partid,
> +		      struct mpam_config *cfg);
> +
>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>   				   cpumask_t *affinity);
>   

Thanks,
Gavin


