Return-Path: <linux-kernel+bounces-778370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5582DB2E4AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915DD16CA97
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D54273D67;
	Wed, 20 Aug 2025 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+cT0s31"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188C25EFBF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713313; cv=none; b=BkV54F5z/KtAhTkQKSog4G2Z8qgAP6nrDsTxC7+3mFRWN0l1dCOgDPBgQpe7yUBC7x9VZYp/dY/o2vVSOGIPZcH/cLETMVruLfG8L7ijPW6Krdr0BFFhJH2DsFmJqdMv1P789OEkNeOVFX3rIIYWXYBlL8+a7riGe0Tj6wMAKes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713313; c=relaxed/simple;
	bh=B6g3IC9ZXwCV8RE4IXFIyB1k5TWnvLy8l5kQfFovKns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=em/mYraWsoveYdXPcI7MLgOEXgXxCgYXZDshmr2zsTDPAKUxLfUcYjiFm1ru+qZGKTWodHhtDci2fF352qt18cD4LO4ZGPH+W1gnsgg0z4DC9NEV7CK2t6cthFFMUtrv2M9W+T039eOnAFlJP7Rk6CXpFh12NUahzu4MkLYG4lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+cT0s31; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755713312; x=1787249312;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B6g3IC9ZXwCV8RE4IXFIyB1k5TWnvLy8l5kQfFovKns=;
  b=V+cT0s31NLDRWZ6FAPD6R5WIXTGAZW7HFsV1anJnXyoNGtdC5hhlTX1s
   UPSSjMtldfLSq754JkcsN/4OeRKRT8JpHq+w+HdgXzBjJGI0SFckF7B2y
   j7puWIqpZVANVT9tYT5zBGlLV+TKCat3eN/LnhWq1/9ZgKf6z/5Kc5rSX
   UJHoPOBfLh35PKYc6C55bLjxuY4iXpY89r3wy7zImh4Ofkl2EDFZPa7sE
   aRa7F23aU3GiKPGYRvqm5TUKbvbLUHhLhNWqQip3jaB3v7XTIhhmy5WOR
   pr4G57LL8m/+x26jcfnlZQNkRNMNmmIhdw2cbANxHKQM0lKMKZRc+xPT9
   g==;
X-CSE-ConnectionGUID: VHkcmTcQRbqCf5RIc2dKHw==
X-CSE-MsgGUID: alTaeC0VQBqE4uXBbpRVzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="60618540"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="60618540"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 11:08:31 -0700
X-CSE-ConnectionGUID: RBZDKfYpQFWfn1bmQgEmIQ==
X-CSE-MsgGUID: 3mhBVqFyS4SU6UMSRMT6zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="205347077"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 11:08:31 -0700
Received: from [10.246.144.138] (kliang2-mobl1.ccr.corp.intel.com [10.246.144.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id AC66E20B571C;
	Wed, 20 Aug 2025 11:08:28 -0700 (PDT)
Message-ID: <563b1a69-8e4d-4c49-ac46-f5b845452a6a@linux.intel.com>
Date: Wed, 20 Aug 2025 11:08:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 06/17] perf: Support SIMD registers
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
 dave.hansen@linux.intel.com, irogers@google.com, adrian.hunter@intel.com,
 jolsa@kernel.org, alexander.shishkin@linux.intel.com,
 linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com, zide.chen@intel.com, mark.rutland@arm.com,
 broonie@kernel.org, ravi.bangoria@amd.com, eranian@google.com
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
 <20250815213435.1702022-7-kan.liang@linux.intel.com>
 <0ed1d942-5c7a-4cb3-b28b-2177e172f2e8@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <0ed1d942-5c7a-4cb3-b28b-2177e172f2e8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-08-20 2:55 a.m., Mi, Dapeng wrote:
> 
> On 8/16/2025 5:34 AM, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The users may be interested in the SIMD registers in a sample while
>> profiling. The current sample_regs_XXX doesn't have enough space for all
>> SIMD registers.
>>
>> Add sets of the sample_simd_{pred,vec}_reg_* in the
>> struct perf_event_attr to define a set of SIMD registers to dump on
>> samples.
>> The current X86 supports the XMM registers in sample_regs_XXX. To
>> utilize the new SIMD registers configuration method, the
>> sample_simd_regs_enabled should always be set. If so, the XMM space in
>> the sample_regs_XXX is reserved for other usage.
>>
>> The SIMD registers are wider than 64. A new output format is introduced.
>> The number and width of SIMD registers will be dumped first, following
>> the register values. The number and width are the same as the user's
>> configuration now. If, for some reason (e.g., ARM) they are different,
>> an ARCH-specific perf_output_sample_simd_regs can be implemented later
>> separately.
>> Add a new ABI, PERF_SAMPLE_REGS_ABI_SIMD, to indicate the new format.
>> The enum perf_sample_regs_abi becomes a bitmap now. There should be no
>> impact on the existing tool, since the version and bitmap are the same
>> for 1 and 2.
>>
>> Add three new __weak functions to retrieve the number of available
>> registers, validate the configuration of the SIMD registers, and
>> retrieve the SIMD registers. The ARCH-specific functions will be
>> implemented in the following patches.
>>
>> Add a new flag PERF_PMU_CAP_SIMD_REGS to indicate that the PMU has the
>> capability to support SIMD registers dumping. Error out if the
>> sample_simd_{pred,vec}_reg_* mistakenly set for a PMU that doesn't have
>> the capability.
>>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  include/linux/perf_event.h      |  13 ++++
>>  include/linux/perf_regs.h       |   9 +++
>>  include/uapi/linux/perf_event.h |  47 +++++++++++++--
>>  kernel/events/core.c            | 101 +++++++++++++++++++++++++++++++-
>>  4 files changed, 162 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 444b162f3f92..205361b7de2e 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -305,6 +305,7 @@ struct perf_event_pmu_context;
>>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
>>  #define PERF_PMU_CAP_AUX_PAUSE		0x0200
>>  #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
>> +#define PERF_PMU_CAP_SIMD_REGS		0x0800
>>  
>>  /**
>>   * pmu::scope
>> @@ -1526,6 +1527,18 @@ perf_event__output_id_sample(struct perf_event *event,
>>  extern void
>>  perf_log_lost_samples(struct perf_event *event, u64 lost);
>>  
>> +static inline bool event_has_simd_regs(struct perf_event *event)
>> +{
>> +	struct perf_event_attr *attr = &event->attr;
>> +
>> +	return attr->sample_simd_regs_enabled != 0 ||
>> +	       attr->sample_simd_pred_reg_intr != 0 ||
>> +	       attr->sample_simd_pred_reg_user != 0 ||
>> +	       attr->sample_simd_vec_reg_qwords != 0 ||
>> +	       attr->sample_simd_vec_reg_intr != 0 ||
>> +	       attr->sample_simd_vec_reg_user != 0;
>> +}
>> +
>>  static inline bool event_has_extended_regs(struct perf_event *event)
>>  {
>>  	struct perf_event_attr *attr = &event->attr;
>> diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
>> index f632c5725f16..0172682b18fd 100644
>> --- a/include/linux/perf_regs.h
>> +++ b/include/linux/perf_regs.h
>> @@ -9,6 +9,15 @@ struct perf_regs {
>>  	struct pt_regs	*regs;
>>  };
>>  
>> +int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
>> +			   u16 pred_qwords, u32 pred_mask);
>> +u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
>> +			u16 qwords_idx, bool pred);
>> +void perf_simd_reg_check(struct pt_regs *regs,
>> +			 u64 mask, u16 *nr_vectors, u16 *vec_qwords,
>> +			 u16 pred_mask, u16 *nr_pred, u16 *pred_qwords);
>> +
>> +
>>  #ifdef CONFIG_HAVE_PERF_REGS
>>  #include <asm/perf_regs.h>
>>  
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 78a362b80027..2e9b16acbed6 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -313,9 +313,10 @@ enum {
>>   * Values to determine ABI of the registers dump.
>>   */
>>  enum perf_sample_regs_abi {
>> -	PERF_SAMPLE_REGS_ABI_NONE		= 0,
>> -	PERF_SAMPLE_REGS_ABI_32			= 1,
>> -	PERF_SAMPLE_REGS_ABI_64			= 2,
>> +	PERF_SAMPLE_REGS_ABI_NONE		= 0x00,
>> +	PERF_SAMPLE_REGS_ABI_32			= 0x01,
>> +	PERF_SAMPLE_REGS_ABI_64			= 0x02,
>> +	PERF_SAMPLE_REGS_ABI_SIMD		= 0x04,
> 
> Better change the definition to bitmap format, so it clearly indicates the
> ABI is a bitmap format.
> 
> enum perf_sample_regs_abi {
>     PERF_SAMPLE_REGS_ABI_NONE        = 0,
>     PERF_SAMPLE_REGS_ABI_32            = 1 << 0,
>     PERF_SAMPLE_REGS_ABI_64            = 1 << 1,
>     PERF_SAMPLE_REGS_ABI_SIMD        = 1 << 2,
> };
> 
> 

BIT_ULL() should be better.

Thanks,
Kan

> 
>>  };
>>  
>>  /*
>> @@ -382,6 +383,7 @@ enum perf_event_read_format {
>>  #define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
>>  #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
>>  #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
>> +#define PERF_ATTR_SIZE_VER9			168	/* Add: sample_simd_{pred,vec}_reg_* */
>>  
>>  /*
>>   * 'struct perf_event_attr' contains various attributes that define
>> @@ -543,6 +545,25 @@ struct perf_event_attr {
>>  	__u64	sig_data;
>>  
>>  	__u64	config3; /* extension of config2 */
>> +
>> +
>> +	/*
>> +	 * Defines set of SIMD registers to dump on samples.
>> +	 * The sample_simd_regs_enabled !=0 implies the
>> +	 * set of SIMD registers is used to config all SIMD registers.
>> +	 * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
>> +	 * config some SIMD registers on X86.
>> +	 */
>> +	union {
>> +		__u16 sample_simd_regs_enabled;
>> +		__u16 sample_simd_pred_reg_qwords;
>> +	};
>> +	__u32 sample_simd_pred_reg_intr;
>> +	__u32 sample_simd_pred_reg_user;
>> +	__u16 sample_simd_vec_reg_qwords;
>> +	__u64 sample_simd_vec_reg_intr;
>> +	__u64 sample_simd_vec_reg_user;
>> +	__u32 __reserved_4;
>>  };
>>  
>>  /*
>> @@ -1016,7 +1037,15 @@ enum perf_event_type {
>>  	 *      } && PERF_SAMPLE_BRANCH_STACK
>>  	 *
>>  	 *	{ u64			abi; # enum perf_sample_regs_abi
>> -	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
>> +	 *	  u64			regs[weight(mask)];
>> +	 *	  struct {
>> +	 *		u16 nr_vectors;
>> +	 *		u16 vector_qwords;
>> +	 *		u16 nr_pred;
>> +	 *		u16 pred_qwords;
>> +	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
>> +	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>> +	 *	} && PERF_SAMPLE_REGS_USER
>>  	 *
>>  	 *	{ u64			size;
>>  	 *	  char			data[size];
>> @@ -1043,7 +1072,15 @@ enum perf_event_type {
>>  	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
>>  	 *	{ u64			transaction; } && PERF_SAMPLE_TRANSACTION
>>  	 *	{ u64			abi; # enum perf_sample_regs_abi
>> -	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
>> +	 *	  u64			regs[weight(mask)];
>> +	 *	  struct {
>> +	 *		u16 nr_vectors;
>> +	 *		u16 vector_qwords;
>> +	 *		u16 nr_pred;
>> +	 *		u16 pred_qwords;
>> +	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
>> +	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>> +	 *	} && PERF_SAMPLE_REGS_INTR
>>  	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
>>  	 *	{ u64			cgroup;} && PERF_SAMPLE_CGROUP
>>  	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 95a7b6f5af09..dd8cf3c7fb7a 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -7408,6 +7408,47 @@ perf_output_sample_regs(struct perf_output_handle *handle,
>>  	}
>>  }
>>  
>> +static void
>> +perf_output_sample_simd_regs(struct perf_output_handle *handle,
>> +			     struct perf_event *event,
>> +			     struct pt_regs *regs,
>> +			     u64 mask, u16 pred_mask)
>> +{
>> +	u16 pred_qwords = event->attr.sample_simd_pred_reg_qwords;
>> +	u16 vec_qwords = event->attr.sample_simd_vec_reg_qwords;
>> +	u16 nr_pred = hweight16(pred_mask);
>> +	u16 nr_vectors = hweight64(mask);
>> +	int bit;
>> +	u64 val;
>> +	u16 i;
>> +
>> +	/* Get the number of available regs */
>> +	perf_simd_reg_check(regs, mask, &nr_vectors, &vec_qwords,
>> +			    pred_mask, &nr_pred, &pred_qwords);
>> +
>> +	perf_output_put(handle, nr_vectors);
>> +	perf_output_put(handle, vec_qwords);
>> +	perf_output_put(handle, nr_pred);
>> +	perf_output_put(handle, pred_qwords);
>> +
>> +	if (nr_vectors) {
>> +		for_each_set_bit(bit, (unsigned long *)&mask, sizeof(mask) * BITS_PER_BYTE) {
>> +			for (i = 0; i < vec_qwords; i++) {
>> +				val = perf_simd_reg_value(regs, bit, i, false);
>> +				perf_output_put(handle, val);
>> +			}
>> +		}
>> +	}
>> +	if (nr_pred) {
>> +		for_each_set_bit(bit, (unsigned long *)&pred_mask, sizeof(pred_mask) * BITS_PER_BYTE) {
>> +			for (i = 0; i < pred_qwords; i++) {
>> +				val = perf_simd_reg_value(regs, bit, i, true);
>> +				perf_output_put(handle, val);
>> +			}
>> +		}
>> +	}
>> +}
>> +
>>  static void perf_sample_regs_user(struct perf_regs *regs_user,
>>  				  struct pt_regs *regs)
>>  {
>> @@ -7429,6 +7470,25 @@ static void perf_sample_regs_intr(struct perf_regs *regs_intr,
>>  	regs_intr->abi  = perf_reg_abi(current);
>>  }
>>  
>> +int __weak perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
>> +				  u16 pred_qwords, u32 pred_mask)
>> +{
>> +	return vec_qwords || vec_mask || pred_qwords || pred_mask ? -ENOSYS : 0;
>> +}
>> +
>> +u64 __weak perf_simd_reg_value(struct pt_regs *regs, int idx,
>> +			       u16 qwords_idx, bool pred)
>> +{
>> +	return 0;
>> +}
>> +
>> +void __weak perf_simd_reg_check(struct pt_regs *regs,
>> +				u64 mask, u16 *nr_vectors, u16 *vec_qwords,
>> +				u16 pred_mask, u16 *nr_pred, u16 *pred_qwords)
>> +{
>> +	*nr_vectors = 0;
>> +	*nr_pred = 0;
>> +}
>>  
>>  /*
>>   * Get remaining task size from user stack pointer.
>> @@ -7961,10 +8021,17 @@ void perf_output_sample(struct perf_output_handle *handle,
>>  		perf_output_put(handle, abi);
>>  
>>  		if (abi) {
>> -			u64 mask = event->attr.sample_regs_user;
>> +			struct perf_event_attr *attr = &event->attr;
>> +			u64 mask = attr->sample_regs_user;
>>  			perf_output_sample_regs(handle,
>>  						data->regs_user.regs,
>>  						mask);
>> +			if (abi & PERF_SAMPLE_REGS_ABI_SIMD) {
>> +				perf_output_sample_simd_regs(handle, event,
>> +							     data->regs_user.regs,
>> +							     attr->sample_simd_vec_reg_user,
>> +							     attr->sample_simd_pred_reg_user);
>> +			}
>>  		}
>>  	}
>>  
>> @@ -7992,11 +8059,18 @@ void perf_output_sample(struct perf_output_handle *handle,
>>  		perf_output_put(handle, abi);
>>  
>>  		if (abi) {
>> -			u64 mask = event->attr.sample_regs_intr;
>> +			struct perf_event_attr *attr = &event->attr;
>> +			u64 mask = attr->sample_regs_intr;
>>  
>>  			perf_output_sample_regs(handle,
>>  						data->regs_intr.regs,
>>  						mask);
>> +			if (abi & PERF_SAMPLE_REGS_ABI_SIMD) {
>> +				perf_output_sample_simd_regs(handle, event,
>> +							     data->regs_intr.regs,
>> +							     attr->sample_simd_vec_reg_intr,
>> +							     attr->sample_simd_pred_reg_intr);
>> +			}
>>  		}
>>  	}
>>  
>> @@ -12560,6 +12634,12 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>>  	if (ret)
>>  		goto err_pmu;
>>  
>> +	if (!(pmu->capabilities & PERF_PMU_CAP_SIMD_REGS) &&
>> +	    event_has_simd_regs(event)) {
>> +		ret = -EOPNOTSUPP;
>> +		goto err_destroy;
>> +	}
>> +
>>  	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
>>  	    event_has_extended_regs(event)) {
>>  		ret = -EOPNOTSUPP;
>> @@ -13101,6 +13181,12 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
>>  		ret = perf_reg_validate(attr->sample_regs_user);
>>  		if (ret)
>>  			return ret;
>> +		ret = perf_simd_reg_validate(attr->sample_simd_vec_reg_qwords,
>> +					     attr->sample_simd_vec_reg_user,
>> +					     attr->sample_simd_pred_reg_qwords,
>> +					     attr->sample_simd_pred_reg_user);
>> +		if (ret)
>> +			return ret;
>>  	}
>>  
>>  	if (attr->sample_type & PERF_SAMPLE_STACK_USER) {
>> @@ -13121,8 +13207,17 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
>>  	if (!attr->sample_max_stack)
>>  		attr->sample_max_stack = sysctl_perf_event_max_stack;
>>  
>> -	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
>> +	if (attr->sample_type & PERF_SAMPLE_REGS_INTR) {
>>  		ret = perf_reg_validate(attr->sample_regs_intr);
>> +		if (ret)
>> +			return ret;
>> +		ret = perf_simd_reg_validate(attr->sample_simd_vec_reg_qwords,
>> +					     attr->sample_simd_vec_reg_intr,
>> +					     attr->sample_simd_pred_reg_qwords,
>> +					     attr->sample_simd_pred_reg_intr);
>> +		if (ret)
>> +			return ret;
>> +	}
>>  
>>  #ifndef CONFIG_CGROUP_PERF
>>  	if (attr->sample_type & PERF_SAMPLE_CGROUP)


