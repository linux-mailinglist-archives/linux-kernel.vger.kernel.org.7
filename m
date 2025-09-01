Return-Path: <linux-kernel+bounces-794752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A875B3E6CF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C69617AB44
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1591891A9;
	Mon,  1 Sep 2025 14:15:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1896D1096F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736146; cv=none; b=gdNvS6940Eb/Z4enSvn5hc14IBZGrVblmx/sUABT0Y0TEu5E+08vci0Wd/su32B4EXoBDPQ1U6gr7z8fj7WJvfbWVngj0gIaP9VSP+68V+0O3l9vbPgU6SLSxoRr+/kOO0vGCED9ru+FQht5/MpmrhkgEEoaQOTvmjmje70PtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736146; c=relaxed/simple;
	bh=0sooataVkD+SjnSvblgEpr3BN69d2FLhGG61Js4Y2CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+kVxmWacGzeeXwA++U8ugnbkSxMAV44iMgvGqbswZtDY/0CAxL/embV9g/0q4SauiN+z2O9F94viWAgBjXROvebnyjD14L/3Xd9bY9ItwYWaGFNq+8hzgQMxJHOHrCFwm51DKOEa2FujUvijGYb0Mtb0N7b6D/SZi8lrtQJyTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D705168F;
	Mon,  1 Sep 2025 07:15:35 -0700 (PDT)
Received: from [10.57.4.133] (unknown [10.57.4.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70C473F6A8;
	Mon,  1 Sep 2025 07:15:41 -0700 (PDT)
Message-ID: <85208aef-22ee-4156-bdf9-ea59ce893267@arm.com>
Date: Mon, 1 Sep 2025 15:15:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/panfrost: Introduce uAPI for JM context creation
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com, Rob Herring <robh@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20250828023422.2404784-1-adrian.larumbe@collabora.com>
 <20250828023422.2404784-3-adrian.larumbe@collabora.com>
 <56130662-4768-44ff-829e-9d77258c4342@arm.com>
 <20250901141439.42740449@fedora>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250901141439.42740449@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Boris,

On 01/09/2025 13:14, Boris Brezillon wrote:
> Hi Steve,
> 
> On Mon, 1 Sep 2025 11:52:02 +0100
> Steven Price <steven.price@arm.com> wrote:
> 
>> On 28/08/2025 03:34, Adrián Larumbe wrote:
>>> From: Boris Brezillon <boris.brezillon@collabora.com>
>>>
>>> The new uAPI lets user space query the KM driver for the available
>>> priorities a job can be given at submit time. These are managed through
>>> the notion of a context, which besides a priority, codifies the list
>>> of L2 caches, shading cores and tiler units a job is allowed to use,
>>> for all three of the available device job slots.
>>>
>>> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
>>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>  
>>
>> There's no cover letter for this series, so maybe I'm missing some
>> context. But I'm not sure why we want to expose the tiler/l2/core masks
>> to user space.
> 
> tiler/l2 masks, I'm not sure we need, especially if there's only just
> one tiler unit / l2 cache. I exposed the core mask so one can reserve
> cores for an application.

Reserving cores is tricky because we have limited slots and they cannot
have overlapping affinity. If there's a specific use case then, sure we
can discuss, but generally it's much better to time-slice the GPU than
try to partition by cores.

>>
>> If you were trying to better support OpenCL on T628 I can just about
>> understand the core mask. But, I doubt you are... (does anyone care
>> about that anymore? ;) ). And really it's the core groups that matter
>> rather than the raw affinities.
> 
> Ok, so low vs high bits (don't know the granularity of the core group,
> so low/high might actually bit low/middle-low/middle-high/high) in the
> the affinity register, right?

Thankfully we never had more than 2 core groups - so low/high ;)

>>
>> The tiler/l2 affinities (and the XAFFINITY register in general) is there
>> as a power saving mechanism. If we know that a job is not going to use
>> the shader cores at all (a tiler-only job) then we can avoid turning
>> them on, but obviously we still need the L2 and tiler blocks to be powered.
> 
> Okay, I thought it was more of a "use only these cores, the rest is
> reserved for something else", my bad.

XAFFINITY is really a "whoops we didn't think about that" fix ;) The
main AFFINITY register doesn't have a separate control for the tiler
(the register is shared between both shader cores and tilers), so to
enable the tiler, core 0 also needs to be enabled. And the hardware
"helpfully" also checks that when you submit a job that the intersection
of the powered cores and the affinity register isn't 0. So if you submit
a tiler job you have to power on (and include in the affinity register)
shader core 0.

When you enable XAFFINITY the link is broken and you can specify the
tiler affinity separately. Not that the concept of multiple tilers ever
got seriously proposed. But this allows shader core 0 to remain
unpowered when running a tiling only job.

>>
>> kbase handled this with a "core_req" field which listed the required
>> cores for each job. We already have a "requirements" field which we
>> could extend for the same purpose (PANFROST_JD_REQ_TILER_ONLY or
>> similar). I don't think this makes sense to include in a "context".
> 
> It was more a core reservation mechanism, which I expected to be forced
> at context creation time. I mean, it can still be at the UMD level, and
> we would pass the mask of cores to use at job submission time. The
> problem I see with just expressing the maximum number of cores one can
> use is that it doesn't work for core reservation. Also, I went for this
> interface because that's more or less what panthor exposes (mask of
> cores that can be used, and maximum of number of cores that can be used
> in this pool).

I included my history lesson in the email to Adrián, but panthor is
different because CSF made things more flexible by removing the slot
concept. I'm very dubious it makes any sense to reserve cores on JM GPUs
- time slicing makes more sense as it avoids thrashing the caches
between two different work loads.

>>
>> But like I said, maybe I'm missing something - what is the use case for
>> controlling affinity?
>>
>> [The priority parts look ok here, but that's mixed in with the affinity
>> changes.]
>>
>>> ---
>>>  include/uapi/drm/panfrost_drm.h | 93 +++++++++++++++++++++++++++++++++
>>>  1 file changed, 93 insertions(+)
>>>
>>> diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
>>> index ed67510395bd..2d8b32448e68 100644
>>> --- a/include/uapi/drm/panfrost_drm.h
>>> +++ b/include/uapi/drm/panfrost_drm.h
>>> @@ -22,6 +22,8 @@ extern "C" {
>>>  #define DRM_PANFROST_PERFCNT_DUMP		0x07
>>>  #define DRM_PANFROST_MADVISE			0x08
>>>  #define DRM_PANFROST_SET_LABEL_BO		0x09
>>> +#define DRM_PANFROST_JM_CTX_CREATE		0x0a
>>> +#define DRM_PANFROST_JM_CTX_DESTROY		0x0b
>>>  
>>>  #define DRM_IOCTL_PANFROST_SUBMIT		DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_SUBMIT, struct drm_panfrost_submit)
>>>  #define DRM_IOCTL_PANFROST_WAIT_BO		DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_WAIT_BO, struct drm_panfrost_wait_bo)
>>> @@ -31,6 +33,8 @@ extern "C" {
>>>  #define DRM_IOCTL_PANFROST_GET_BO_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_GET_BO_OFFSET, struct drm_panfrost_get_bo_offset)
>>>  #define DRM_IOCTL_PANFROST_MADVISE		DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_MADVISE, struct drm_panfrost_madvise)
>>>  #define DRM_IOCTL_PANFROST_SET_LABEL_BO		DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_SET_LABEL_BO, struct drm_panfrost_set_label_bo)
>>> +#define DRM_IOCTL_PANFROST_JM_CTX_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_JM_CTX_CREATE, struct drm_panfrost_jm_ctx_create)
>>> +#define DRM_IOCTL_PANFROST_JM_CTX_DESTROY	DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_JM_CTX_DESTROY, struct drm_panfrost_jm_ctx_destroy)
>>>  
>>>  /*
>>>   * Unstable ioctl(s): only exposed when the unsafe unstable_ioctls module
>>> @@ -71,6 +75,12 @@ struct drm_panfrost_submit {
>>>  
>>>  	/** A combination of PANFROST_JD_REQ_* */
>>>  	__u32 requirements;
>>> +
>>> +	/** JM context handle. Zero if you want to use the default context. */
>>> +	__u32 jm_ctx_handle;
>>> +
>>> +	/** Padding field. MBZ. */
>>> +	__u32 pad;
>>>  };
>>>  
>>>  /**
>>> @@ -177,6 +187,7 @@ enum drm_panfrost_param {
>>>  	DRM_PANFROST_PARAM_AFBC_FEATURES,
>>>  	DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP,
>>>  	DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP_FREQUENCY,
>>> +	DRM_PANFROST_PARAM_ALLOWED_JM_CTX_PRIORITIES,
>>>  };
>>>  
>>>  struct drm_panfrost_get_param {
>>> @@ -299,6 +310,88 @@ struct panfrost_dump_registers {
>>>  	__u32 value;
>>>  };
>>>  
>>> +enum drm_panfrost_jm_ctx_priority {
>>> +	/**
>>> +	 * @PANFROST_JM_CTX_PRIORITY_LOW: Low priority context.
>>> +	 */
>>> +	PANFROST_JM_CTX_PRIORITY_LOW = 0,
>>> +
>>> +	/**
>>> +	 * @PANFROST_JM_CTX_PRIORITY_MEDIUM: Medium priority context.
>>> +	 */
>>> +	PANFROST_JM_CTX_PRIORITY_MEDIUM,
>>> +
>>> +	/**
>>> +	 * @PANFROST_JM_CTX_PRIORITY_HIGH: High priority context.
>>> +	 *
>>> +	 * Requires CAP_SYS_NICE or DRM_MASTER.
>>> +	 */
>>> +	PANFROST_JM_CTX_PRIORITY_HIGH,
>>> +};
>>> +
>>> +#define PANFROST_JS_FLAG_ENABLED		(1 << 0)
>>> +
>>> +struct drm_panfrost_js_ctx_info {
>>> +	/** @flags: Combination of PANFROST_JS_FLAG_xxx values */
>>> +	__u32 flags;
>>> +
>>> +	/** @priority: Context priority (see enum drm_panfrost_jm_ctx_priority). */
>>> +	__u8 priority;
>>> +
>>> +	/**
>>> +	 * @tiler_mask: Mask encoding tiler units that can be used by the job slot
>>> +	 *
>>> +	 * When this field is zero, it means the tiler won't be used.
>>> +	 *
>>> +	 * The bits set here should also be set in drm_panthor_gpu_info::tiler_present.
>>> +	 */
>>> +	__u8 tiler_mask;
>>> +
>>> +	/**
>>> +	 * @l2_mask: Mask encoding L2 caches that can be used by the job slot
>>> +	 *
>>> +	 * The bits set here should also be set in drm_panthor_gpu_info::l2_present.:
>>> +	 */
>>> +	__u16 l2_mask;
>>> +
>>> +	/**
>>> +	 * @core_mask: Mask encoding cores that can be used by the job slot
>>> +	 *
>>> +	 * When this field is zero, it means the queue won't be used.
>>> +	 *
>>> +	 * The bits set here should also be set in drm_panthor_gpu_info::shader_present.
>>> +	 */
>>> +	__u64 core_mask;
>>> +};
>>> +
>>> +struct drm_panfrost_jm_ctx_create {
>>> +	/** @handle: Handle of the created JM context */
>>> +	__u32 handle;
>>> +
>>> +	/** @pad: Padding field, MBZ. */
>>> +	__u32 pad;
>>> +
>>> +	/**
>>> +	 * @slots: Job slots
>>> +	 *
>>> +	 * This field must be greater than zero and less than 8 (only three slots
>>> +	 * available).
> 
> Not sure what this doc referred to, but slots is not an integer :D.
> 
>>> +	 */
>>> +	struct drm_panfrost_js_ctx_info slots[3];  
>>
>> We don't allow user space to choose which slot is being targetted, so
>> this feels odd.
> 
> Some of this has been extracted from the panthor-ification of JM, and
> you're probably right that it doesn't make sense to expose the
> subqueues in panfrost.
> 
>> I guess this allows deliberately disabling slot 1 to
>> force slot 2. But the code in this series doesn't seem to implement
>> this. I'm also not sure I understand why you would want a different
>> priority for different slots?
> 
> Internally, a slot maps to a sched entity, which is where the priority
> is defined. Sure, we could have a global priority for the whole context,
> but I figured I'd just expose what the KMD is capable of (per subqueue
> priority) and let the UMD assign the same priority to all slots. But if
> we don't expose the slots directly, we might as well just define a
> priority and the set of resources that can be used by any of the
> subqueues.

Mostly I was trying to figure out whether there was actually a reason
for exposing multiple priorities like this. Since there isn't generally
a choice which slot to target (it depends on the job type) it seems odd.
Generally my preference is to keep the uAPI minimal and add features as
we need them. Although at least for panfrost we don't need to worry
about potential new GPU designs any more ;)

Thanks,
Steve


