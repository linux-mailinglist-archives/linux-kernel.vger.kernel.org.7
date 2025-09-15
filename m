Return-Path: <linux-kernel+bounces-817656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7766B584F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DD31AA7C20
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFC127C872;
	Mon, 15 Sep 2025 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTvpmOt4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AE1FA859
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757962433; cv=none; b=fZTM3nqXjDILhDFLWbnJCiEdSE1rvscJMdqiWRGUpEkXqtfDGElihTICalngKMhaU+PcFnCj8Xi/p3VIO202Adg4WfzMUvhlXpg4PFvJKGXu32mlkT0ugG4ERmXe9VXds9Rac5G9f/hRYdW9FBkl1oX95CIcVRUEINkSk6QKKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757962433; c=relaxed/simple;
	bh=QkzCkqlzGEtis4r7JhP1vhV8hJjpKR9/PYyZ73sKa6A=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MBU/mRsM6/avxPPaetYMqd5rObd1CBKVQ5mUImUy1xenp+02yABL8z14TOVh035tPMnEA3gYfdxor22w4ehzVb3WBievdEvM/x2PzKyvXh9UPTwpNQ+rp7DnFlWDbqWb1PtEQY6m1TXb5ihFi/GqnoqrQ2c0dyY6Xrp+RpKNSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTvpmOt4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757962430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQOD1HrlyQdU3WG5cibV+4OpdKoc/syBueuAerLS0/g=;
	b=dTvpmOt4SvPh2vEVD6eKDzOFtUVDkl0wtUpmAamsoulXEDnbFljlmG7m/ls/ICHQujm4SL
	37qmZtnl7Q9gFh7+Vg//wunLQaeKb0ofTxeX1P5/gNwjKbGHFh/suX45xs3z0UeJqWKtsJ
	u+QGLtE8DEm9KhLNglL/86zlqmYX9fE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-JTuylV9ON-yyOm2XedgaAA-1; Mon, 15 Sep 2025 14:53:48 -0400
X-MC-Unique: JTuylV9ON-yyOm2XedgaAA-1
X-Mimecast-MFC-AGG-ID: JTuylV9ON-yyOm2XedgaAA_1757962428
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-77d39d8f55aso25646836d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757962428; x=1758567228;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQOD1HrlyQdU3WG5cibV+4OpdKoc/syBueuAerLS0/g=;
        b=oxdQ9JDJ/XV5cnvv7NIc0OrfdyUvUgHjgD8gaTljImxDcHWFEZ/A+5WQZRqmwd2nGG
         8fPDnRbJ8zvYjjg78KPxuI9MT8Nfyv1gRkF+iu2/0ZL0dLPj/vxgN+n1Hg2eYymXgsr1
         VtnCjOv46I2iJ9UA+bX4Cv7fHl0eF04hE63RroiFR2rLOKWxA1W+ENar/pPme+/r7ZMP
         GfSyHA0XWBPBbUmojqehppJ7V5byexVxdwuleLm39eWl/loYaF+AKMCCRs0AQK/fFbm5
         fR0cS1K4QqYmPxib6fINpxvIVxut/16MNdO/O5EIAS+knEdUQoP0Xw/9uR9i3PXWqzeD
         6odw==
X-Forwarded-Encrypted: i=1; AJvYcCXT2EZuCw2G0cdTkh+HhfR74dKFkQCQURZn6pcilR+CRKEV2ZlPtfku1zwT1wda7bHTbNKboPxWkoJLOh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx41zEVXfdjGrndLJBs2HyARMvf5H5HJ27nwh1ytVAqhFCTzTK
	J/MeKQATYJ5XtqpCIzk1FPKI/pE6oUCkxQPkN8VWNZw9ZbPL/WvUa4nuj5mpEFN+VtPOQnur0IV
	Hmn2UJiK61csSqzWH/v9xHLoaA2BtVcVRj21NqF5HC4XndylyiiAdaEzjIPjCDWmoBQ==
X-Gm-Gg: ASbGncsIgXBL2Y3g8L7mxEFfZKp/hqarMm4Rx68ekmGa/cDevGp0C+cHOOCsesilinu
	ZlwSlOEFUTHt2ebcN6rC+A9CYv2UrSVIVGmUEmxnQ+IFawDAIzmkuIctTZVE/kdWjOnqHj7IvbZ
	UGq+0mlSZegn9UkCZsvbAxiRock5va0NF9IrQ7oYYIxVGEFDOxIII7gLMvLk1k+z6w6dKaRhwvN
	Yw9Dab8WQA2UMe13c+7xQBcC6etFKC8idg3nn8jHDv/TYyGcDyj3F5bl/KfsdxRNjJ30ExoVuo9
	K1klLlZqEmHr3C8DngOkk73CRmytMUEGPrD4VullhsF3BpjG1rWQqB66wvvostZrFBOe0S0O/7U
	J5XffrmLaag==
X-Received: by 2002:a05:6214:4004:b0:753:c0ea:b052 with SMTP id 6a1803df08f44-767c1aa526bmr199160326d6.32.1757962427688;
        Mon, 15 Sep 2025 11:53:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHppdcMBvJ2WP5Fi36gAhmWPSKLhdFB9UoLjIzluvCGRkdZF8W61RhlzlHJjN8ifFtnRv99EA==
X-Received: by 2002:a05:6214:4004:b0:753:c0ea:b052 with SMTP id 6a1803df08f44-767c1aa526bmr199159876d6.32.1757962427051;
        Mon, 15 Sep 2025 11:53:47 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b54a20b6sm82855186d6.17.2025.09.15.11.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:53:46 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <90fb9914-3c6f-4d2a-8512-cebcaa5ddbb6@redhat.com>
Date: Mon, 15 Sep 2025 14:53:45 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 07/11] cpuset: refactor out
 validate_partition
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-8-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-8-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Refactor the validate_partition function to handle cpuset partition
> validation when modifying cpuset.cpus. This refactoring also makes the
> function reusable for handling cpuset.cpus.exclusive updates in subsequent
> patches.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 48 +++++++++++++++++++++++++++++++-----------
>   1 file changed, 36 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 389dfd5be6c8..770b33e30576 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2386,6 +2386,37 @@ static int parse_cpuset_cpulist(const char *buf, struct cpumask *out_mask)
>   	return 0;
>   }
>   
> +/**
> + * validate_partition - Validate a cpuset partition configuration
> + * @cs: The cpuset to validate
> + * @trialcs: The trial cpuset containing proposed configuration changes
> + *
> + * If any validation check fails, the appropriate error code is set in the
> + * cpuset's prs_err field.
> + *
> + * Return: PRS error code (0 if valid, non-zero error code if invalid)
> + */
> +static enum prs_errcode validate_partition(struct cpuset *cs, struct cpuset *trialcs)
> +{
> +	struct cpuset *parent = parent_cs(cs);
> +
> +	if (cs_is_member(trialcs))
> +		return PERR_NONE;
> +
> +	if (cpumask_empty(trialcs->effective_xcpus))
> +		return PERR_INVCPUS;
> +
> +	if (prstate_housekeeping_conflict(trialcs->partition_root_state,
> +					  trialcs->effective_xcpus))
> +		return PERR_HKEEPING;
> +
> +	if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus))
> +		return PERR_NOCPUS;
> +
> +	return PERR_NONE;
> +}
> +
> +
>   /**
>    * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>    * @cs: the cpuset to consider
> @@ -2401,6 +2432,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	bool invalidate = false;
>   	bool force = false;
>   	int old_prs = cs->partition_root_state;
> +	enum prs_errcode prs_err;
>   
>   	retval = parse_cpuset_cpulist(buf, trialcs->cpus_allowed);
>   	if (retval < 0)
> @@ -2415,18 +2447,10 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   
>   	compute_trialcs_excpus(trialcs, cs);
>   
> -	if (old_prs) {
> -		if (is_partition_valid(cs) &&
> -		    cpumask_empty(trialcs->effective_xcpus)) {
> -			invalidate = true;
> -			cs->prs_err = PERR_INVCPUS;
> -		} else if (prstate_housekeeping_conflict(old_prs, trialcs->effective_xcpus)) {
> -			invalidate = true;
> -			cs->prs_err = PERR_HKEEPING;
> -		} else if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus)) {
> -			invalidate = true;
> -			cs->prs_err = PERR_NOCPUS;
> -		}
> +	prs_err = validate_partition(cs, trialcs);
> +	if (prs_err) {
> +		invalidate = true;
> +		cs->prs_err = prs_err;
>   	}
>   
>   	/*
Reviewed-by: Waiman Long <longman@redhat.com>


