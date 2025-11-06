Return-Path: <linux-kernel+bounces-889252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C03C3D12F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5B93BB87C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C03D33EAF2;
	Thu,  6 Nov 2025 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5aYtNzS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721AE19F11E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453899; cv=none; b=LhrUQ35/31KO7VI1+kmcWTMwPKfePuOpimddpQ5WOIG4MTBoH6cZ84ywFRWUcnA5L0qwMh0MC0R2xW4VCSVXCNISImEGF0UlhlfqReDFprl1HmNd5gyUaGzCL9zzTRC4VbtGgWw1p82FeL4KHuUUP0i2y1bx2aBegshvqUELwkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453899; c=relaxed/simple;
	bh=70HnRDx3FkZUD2hlC+mCI8rhN3NqCBxqmvVYvxqXTD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBpIDj+VODdk/dwbkSKCEZDcpXfrtVw/0A5umECombDluBlG8yo+aoA7/gaEDMrdP5Rq5uStBClIQNZ9gTh1ZI9YMaIn6ydAPH9n15+Zl9DtzdcVaXcUTW8eUu1/AKihpGK6XQj2mgrsrbfDdH+/gDus6wZ1kc5vZ66Gv7zhn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5aYtNzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5977CC4CEFB;
	Thu,  6 Nov 2025 18:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762453898;
	bh=70HnRDx3FkZUD2hlC+mCI8rhN3NqCBxqmvVYvxqXTD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H5aYtNzSRTaTzOKqBlTAo1EwKXonT6gfzejA8KL9YM12/Q/qiABcWJd6z8/B7gqy4
	 OuNY3zS7JM4a41zlbBMleiCiX08DJVGH1h5tjnKvGpASZBLLxxCBMAuY4DODtdNbBY
	 BOxho5bNqlvqtuCYk7/SNEMPvNqVpuhPDyzEtQ7i1R702AXhzLNIDcq1vXK5B5LSSN
	 kuRJ2gQmBb4Y8hOG6JLKGHiU7HCLenjO9bjsQnLI/IKIxZgAtFmuq7XOSO+Y5/XCXB
	 H1C+mn/QlLepKfgPqTnkT+EKXiuGIr0I9YBPF7z6nT+gDFE8wlNPyWIwvm6gVUyP1N
	 ByRsmcBtVUdjg==
Message-ID: <2dcb4668-2c4d-4c73-9805-1af1338c9e7d@kernel.org>
Date: Thu, 6 Nov 2025 12:31:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/amdxdna: Treat power-off failure as unrecoverable
 error
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, maciej.falkowski@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20251106180521.1095218-1-lizhi.hou@amd.com>
 <d21ece5b-d27b-447f-8a8e-5d672fa0c473@amd.com>
 <978dcea6-4d25-3b33-695a-632a9f58884c@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <978dcea6-4d25-3b33-695a-632a9f58884c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/25 12:19 PM, Lizhi Hou wrote:
> 
> On 11/6/25 10:12, Mario Limonciello wrote:
>> On 11/6/25 12:05 PM, Lizhi Hou wrote:
>>> Failing to set power off indicates an unrecoverable hardware or firmware
>>> error. Update the driver to treat such a failure as a fatal condition
>>> and stop further operations that depend on successful power state
>>> transition.
>>>
>>> This prevents undefined behavior when the hardware remains in an
>>> unexpected state after a failed power-off attempt.
>>>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>
>> Presumably all versions of hardware in the wild can handle receiving a 
>> power off command if they're already powered off?
> 
> Yes for the aie2 platforms. This was verified by xdna-driver pipeline 
> tests.
> 
> 

OK LGTM then.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> Lizhi
> 
>>
>>> ---
>>>   drivers/accel/amdxdna/aie2_smu.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/accel/amdxdna/aie2_smu.c b/drivers/accel/ 
>>> amdxdna/aie2_smu.c
>>> index 11c0e9e7b03a..bd94ee96c2bc 100644
>>> --- a/drivers/accel/amdxdna/aie2_smu.c
>>> +++ b/drivers/accel/amdxdna/aie2_smu.c
>>> @@ -147,6 +147,16 @@ int aie2_smu_init(struct amdxdna_dev_hdl *ndev)
>>>   {
>>>       int ret;
>>>   +    /*
>>> +     * Failing to set power off indicates an unrecoverable hardware or
>>> +     * firmware error.
>>> +     */
>>> +    ret = aie2_smu_exec(ndev, AIE2_SMU_POWER_OFF, 0, NULL);
>>> +    if (ret) {
>>> +        XDNA_ERR(ndev->xdna, "Access power failed, ret %d", ret);
>>> +        return ret;
>>> +    }
>>> +
>>>       ret = aie2_smu_exec(ndev, AIE2_SMU_POWER_ON, 0, NULL);
>>>       if (ret) {
>>>           XDNA_ERR(ndev->xdna, "Power on failed, ret %d", ret);
>>


