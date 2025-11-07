Return-Path: <linux-kernel+bounces-890019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2554C3F145
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC0844ECA0D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99A3316918;
	Fri,  7 Nov 2025 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b="vtQDhEWO";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="7R90nlcQ"
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDC3164D7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.152.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506364; cv=none; b=rvNiA85Khb90l2rZPtIl+ymvn5AI3kQx2GhXFHaYtEGA0MmBEa/e9wlO40EaeYJNtYZZFmmCr4BDOxczXWxRWQjhBkwMpLrrtueHX6K1JlwrPYfrqiMfyCjqVcdCe/2L7HvRvusrnNDzxGhAITC2anBu4Y4WGW6uMxLXl5dKJQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506364; c=relaxed/simple;
	bh=2rYsn65RR0Nxsz8EG1rdcXdtTjD0V5qMuk/Xp2ksw4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtsbjhUF91MdqXJSO/aN3MhQRTSTPAYLE8djjKHrWgWFPQVqOVEQx+QxzvlVkuQpo1MFLXrtGLOFpkTWN1hNSBhm2JxLPFE4z32vKsOtt+KQY5Hv8sIY983/xHTzMK1gs28rUxKfjVOnrB46rGYPPvtNFZWCWq0FY/Hk0CcJAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net; spf=pass smtp.mailfrom=damsy.net; dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b=vtQDhEWO; dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b=7R90nlcQ; arc=none smtp.client-ip=51.159.152.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damsy.net
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1762506344; bh=tTI34LZ3z6i+FtVXKAd28Fi
	8WidGpxoyI6ggyYiU8IU=; b=vtQDhEWObGUg+2qDCPwifV8Rwpaki930n6br/SKWIumecBjOXr
	/wB+2hEM2fphA44YyBUg87PVn/F5L6aOUk3SJjJuee3BkLIlfS4l2QOrJ/QetIquIC/wOe30RIK
	VYnxvVIyVQQS5CUejbmPLJIUrCB/rYJ9GWSj3B/9w+C4RIlrSizrChhXccXI1RAlLU8Qnt1v0Mt
	MEt865qw/K6GyBlTLFWxQgCezqzS4wDyD4CR3Vki62Y1QWSMhM93HtbrvcUIdwBPqcGM7hL1kUG
	3C4GgjP7Buokug3QdsoTVzPBK2M4Lg7C04YWVKsRFVc4lusSC9Gw4KW2q3hFew77lDw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1762506344; bh=tTI34LZ3z6i+FtVXKAd28Fi
	8WidGpxoyI6ggyYiU8IU=; b=7R90nlcQiNFoRgx9aXkOWMa0mCH7i9wTC0VSXvwYR//CFfdguc
	cFKTD4vrOZ8TQXnVZ+3QONOvJJPdIO1a7pCA==;
Message-ID: <4d93fd3b-84dd-45fb-b5e4-a8d8ab38112d@damsy.net>
Date: Fri, 7 Nov 2025 10:05:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drm/amdgpu: jump to the correct label on failure
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251106093933.18859-1-pierre-eric.pelloux-prayer@amd.com>
 <20251106093933.18859-2-pierre-eric.pelloux-prayer@amd.com>
 <63ce6781-439d-4425-a3e9-f1d233a5abea@ursulin.net>
 <a3830a0e-5491-4bb7-8685-3427f4874d95@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <a3830a0e-5491-4bb7-8685-3427f4874d95@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/11/2025 à 11:21, Christian König a écrit :
> On 11/6/25 10:56, Tvrtko Ursulin wrote:
>>
>> On 06/11/2025 09:39, Pierre-Eric Pelloux-Prayer wrote:
>>> drm_sched_entity_init wasn't called yet, so the only thing to
>>> do is to release allocated memory.
>>> This doesn't fix any bug since entity is zero allocated and
>>> drm_sched_entity_fini does nothing in this case.
>>>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> index f5d5c45ddc0d..afedea02188d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -236,7 +236,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>>>            r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
>>>                            &num_scheds, &scheds);
>>>            if (r)
>>> -            goto cleanup_entity;
>>> +            goto error_free_entity;
>>>        }
>>>          /* disable load balance if the hw engine retains context among dependent jobs */
>>
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> 
> Since this is still a fix please push it to amd-staging-drm-next independent of the remaining patch set.

Ok, I removed this patch from v4 and will push it to amd-staging-drm-next.

Pierre-Eric

