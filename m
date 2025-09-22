Return-Path: <linux-kernel+bounces-827903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0DAB9363D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FB63AE69C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B153168F6;
	Mon, 22 Sep 2025 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKEShl0Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A030C3148D8;
	Mon, 22 Sep 2025 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577028; cv=none; b=MX0P1v2ZNo4p8Zo0jHDl9gq6Mc5s6AkYovHr+9Sdnxy5Cy4jT/886jtvqa3kzrnCkHuR7cAY7FrrJDKIohFxF2sHfzSxVRhoN+zXMnBfcH72r1zWS/zjtdOHMX3IiQaJgWi2Cbjsp2iVkm5yiqzoPAGahS7hEn9dIvskwhBcdU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577028; c=relaxed/simple;
	bh=ytQiOMDYQ9dkGbpxIB1MofeTOavaLydtQ6lbz76xAH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/ILR2kXo4VH0yXdlxFNo01Xs9MXa0nT8jlqablTTNfT+j48l3C/n7icfOO5iGWCOw9PSVC4VDHt+HgEXeSXK2+QuQSjoBcPZjg4AevoaJLbWAMt6rMSB2T3lD9BEbMkUr36CIQJWC2NGnNzRbKLaGi2Gl514ni0yUCnnvfWz7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKEShl0Y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758577027; x=1790113027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ytQiOMDYQ9dkGbpxIB1MofeTOavaLydtQ6lbz76xAH0=;
  b=DKEShl0YMKjcH3c1hTyLO1foiqbTABf8byHJDIhqXqaTfrGnHzHAvK8Z
   6P1jjQ4icEke77u05MTOA6BWZtTPbZiKCoZPgIMAKlzJgj90W8tTIPeaj
   +GMDV0iB1QVvmmdcmiZdrU83mnmdJXzJIbg4u2tlNwwelhG2P69MpbdEt
   4aPa2QVTYgZfIHdQNwU1SiwqN1KDZGT6VSRqgDZtBWHeJoNOd2I+UfX2/
   IhWKXp2Ols5eA/Hm5PleZGD0pY4gEEv5KIR0429CuMQuvAKt0bJM9A9Bn
   JL3TmhGDx+DEQpUe8czZsYqkuRUEHUx5b44e/iuEOhDeiGcaftZ/a9jmq
   Q==;
X-CSE-ConnectionGUID: SLet+z9mQyeG/7zGrg/VKg==
X-CSE-MsgGUID: QaqK3FObQHqKFjNa4SBFxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60066394"
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="60066394"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 14:37:06 -0700
X-CSE-ConnectionGUID: s589GuYYTrmf58lysNC+9g==
X-CSE-MsgGUID: 7NcUJS24QQKBUDsHWBKriA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="176645980"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.132]) ([10.125.108.132])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 14:37:05 -0700
Message-ID: <77672d54-8133-4324-9ae7-39d11a335cb2@intel.com>
Date: Mon, 22 Sep 2025 14:37:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 07/20] nvdimm/region_label: Add region label delete
 support
To: Neeraj Kumar <s.neeraj@samsung.com>, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, gost.dev@samsung.com
Cc: a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
 cpgs@samsung.com
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
 <CGME20250917134142epcas5p49d85873cf3ea5f3166c63381ab668fc7@epcas5p4.samsung.com>
 <20250917134116.1623730-8-s.neeraj@samsung.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250917134116.1623730-8-s.neeraj@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/25 6:41 AM, Neeraj Kumar wrote:
> Added LSA v2.1 format region label deletion routine. This function is
> used to delete region label from LSA
> 
> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
> ---
>  drivers/nvdimm/label.c          | 79 ++++++++++++++++++++++++++++++---
>  drivers/nvdimm/label.h          |  1 +
>  drivers/nvdimm/namespace_devs.c | 12 +++++
>  drivers/nvdimm/nd.h             |  6 +++
>  include/linux/libnvdimm.h       |  1 +
>  5 files changed, 92 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
> index 209c73f6b7e7..d33db96ba8ba 100644
> --- a/drivers/nvdimm/label.c
> +++ b/drivers/nvdimm/label.c
> @@ -1126,11 +1126,13 @@ static int init_labels(struct nd_mapping *nd_mapping, int num_labels)
>  	return max(num_labels, old_num_labels);
>  }
>  
> -static int del_labels(struct nd_mapping *nd_mapping, uuid_t *uuid)
> +static int del_labels(struct nd_mapping *nd_mapping, uuid_t *uuid,
> +		      enum label_type ltype)
>  {
>  	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
>  	struct nd_label_ent *label_ent, *e;
>  	struct nd_namespace_index *nsindex;
> +	union nd_lsa_label *nd_label;
>  	unsigned long *free;
>  	LIST_HEAD(list);
>  	u32 nslot, slot;
> @@ -1145,15 +1147,28 @@ static int del_labels(struct nd_mapping *nd_mapping, uuid_t *uuid)
>  
>  	guard(mutex)(&nd_mapping->lock);
>  	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
> -		struct nd_namespace_label *nd_label = label_ent->label;
> +		nd_label = (union nd_lsa_label *) label_ent->label;
>  
>  		if (!nd_label)
>  			continue;
>  		active++;
> -		if (!nsl_uuid_equal(ndd, nd_label, uuid))
> -			continue;
> +
> +		switch (ltype) {
> +		case NS_LABEL_TYPE:
> +			if (!nsl_uuid_equal(ndd, &nd_label->ns_label, uuid))
> +				continue;
> +
> +			break;
> +		case RG_LABEL_TYPE:
> +			if (!region_label_uuid_equal(&nd_label->region_label,
> +			    uuid))
> +				continue;
> +
> +			break;
> +		}
> +
>  		active--;
> -		slot = to_slot(ndd, nd_label);
> +		slot = to_slot(ndd, &nd_label->ns_label);
>  		nd_label_free_slot(ndd, slot);
>  		dev_dbg(ndd->dev, "free: %d\n", slot);
>  		list_move_tail(&label_ent->list, &list);
> @@ -1161,7 +1176,7 @@ static int del_labels(struct nd_mapping *nd_mapping, uuid_t *uuid)
>  	}
>  	list_splice_tail_init(&list, &nd_mapping->labels);
>  
> -	if (active == 0) {
> +	if ((ltype == NS_LABEL_TYPE) && (active == 0)) {
>  		nd_mapping_free_labels(nd_mapping);
>  		dev_dbg(ndd->dev, "no more active labels\n");
>  	}
> @@ -1198,7 +1213,8 @@ int nd_pmem_namespace_label_update(struct nd_region *nd_region,
>  		int count = 0;
>  
>  		if (size == 0) {
> -			rc = del_labels(nd_mapping, nspm->uuid);
> +			rc = del_labels(nd_mapping, nspm->uuid,
> +					NS_LABEL_TYPE);
>  			if (rc)
>  				return rc;
>  			continue;
> @@ -1281,6 +1297,55 @@ int nd_pmem_region_label_update(struct nd_region *nd_region)
>  	return 0;
>  }
>  
> +int nd_pmem_region_label_delete(struct nd_region *nd_region)
> +{
> +	struct nd_interleave_set *nd_set = nd_region->nd_set;
> +	struct nd_label_ent *label_ent;
> +	int ns_region_cnt = 0;
> +	int i, rc;
> +
> +	for (i = 0; i < nd_region->ndr_mappings; i++) {
> +		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
> +		struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
> +
> +		/* Find non cxl format supported ndr_mappings */
> +		if (!ndd->cxl) {
> +			dev_info(&nd_region->dev, "Unsupported region label\n");
> +			return -EINVAL;
> +		}
> +
> +		/* Find if any NS label using this region */
> +		guard(mutex)(&nd_mapping->lock);
> +		list_for_each_entry(label_ent, &nd_mapping->labels, list) {
> +			if (!label_ent->label)
> +				continue;
> +
> +			/*
> +			 * Check if any available NS labels has same
> +			 * region_uuid in LSA
> +			 */
> +			if (nsl_region_uuid_equal(label_ent->label,
> +						  &nd_set->uuid))
> +				ns_region_cnt++;

Why not just return -EBUSY here immediately? It seems the code returns -EBUSY as long as there's 1 or more below.

> +		}
> +	}
> +
> +	if (ns_region_cnt) {
> +		dev_dbg(&nd_region->dev, "Region/Namespace label in use\n");
> +		return -EBUSY;
> +	}
> +
> +	for (i = 0; i < nd_region->ndr_mappings; i++) {
> +		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
> +
> +		rc = del_labels(nd_mapping, &nd_set->uuid, RG_LABEL_TYPE);
> +		if (rc)
> +			return rc;
> +	}

Can this be folded into the for loop above or does it a full pass to check before starting the label deletion process?

DJ
> +
> +	return 0;
> +}
> +
>  int __init nd_label_init(void)
>  {
>  	WARN_ON(guid_parse(NVDIMM_BTT_GUID, &nvdimm_btt_guid));
> diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
> index 284e2a763b49..276dd822e142 100644
> --- a/drivers/nvdimm/label.h
> +++ b/drivers/nvdimm/label.h
> @@ -238,4 +238,5 @@ struct nd_namespace_pmem;
>  int nd_pmem_namespace_label_update(struct nd_region *nd_region,
>  		struct nd_namespace_pmem *nspm, resource_size_t size);
>  int nd_pmem_region_label_update(struct nd_region *nd_region);
> +int nd_pmem_region_label_delete(struct nd_region *nd_region);
>  #endif /* __LABEL_H__ */
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index 559f822ef24f..564a73b1da41 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -244,6 +244,18 @@ int nd_region_label_update(struct nd_region *nd_region)
>  }
>  EXPORT_SYMBOL_GPL(nd_region_label_update);
>  
> +int nd_region_label_delete(struct nd_region *nd_region)
> +{
> +	int rc;
> +
> +	nvdimm_bus_lock(&nd_region->dev);
> +	rc = nd_pmem_region_label_delete(nd_region);
> +	nvdimm_bus_unlock(&nd_region->dev);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(nd_region_label_delete);
> +
>  static int nd_namespace_label_update(struct nd_region *nd_region,
>  		struct device *dev)
>  {
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index f04c042dcfa9..046063ea08b6 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -331,6 +331,12 @@ static inline bool is_region_label(struct nvdimm_drvdata *ndd,
>  	return uuid_equal(&region_type, ns_type);
>  }
>  
> +static inline bool nsl_region_uuid_equal(struct nd_namespace_label *ns_label,
> +					 const uuid_t *uuid)
> +{
> +	return uuid_equal((uuid_t *) ns_label->cxl.region_uuid, uuid);
> +}
> +
>  static inline bool
>  region_label_uuid_equal(struct cxl_region_label *region_label,
>  			const uuid_t *uuid)
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index 2c213b9dac66..bbf14a260c93 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -315,6 +315,7 @@ int nvdimm_has_cache(struct nd_region *nd_region);
>  int nvdimm_in_overwrite(struct nvdimm *nvdimm);
>  bool is_nvdimm_sync(struct nd_region *nd_region);
>  int nd_region_label_update(struct nd_region *nd_region);
> +int nd_region_label_delete(struct nd_region *nd_region);
>  
>  static inline int nvdimm_ctl(struct nvdimm *nvdimm, unsigned int cmd, void *buf,
>  		unsigned int buf_len, int *cmd_rc)


