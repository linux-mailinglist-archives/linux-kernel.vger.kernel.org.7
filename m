Return-Path: <linux-kernel+bounces-885395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEC6C32C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE3F54E92A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A685A20A5F3;
	Tue,  4 Nov 2025 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXW4Ffaq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020858F54
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284619; cv=none; b=bthO1gIMcolq6DaX9MWhnbLJhUz8DQd0aqlVDS+PzEl7szf9+9O2NvzUeMgSH17DtKJ8Nuo4w+u4ncFncHOAu45DP0XouJMMYFblQoXFw/fBkeIbSbbECXcB3lgd5o2dEOD8SBpPIh6fHHuOEejyE4uW0uspQn1OSgugh6/i88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284619; c=relaxed/simple;
	bh=U/KGUor/VNiZLGidOo6/Q8mO/zTffjjiZGcdhtXLPbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKTXPQPB/e3qrh2EMPzgEj0MqSpLyStIk4deZ21Yv21MGXZZbzJPuDD8H2/GekcXE51MlVpibZxHEU1j5//LYKF4CoXwH1TQKC72BdHL1HN3NzzaWkkvpxbqFacd9rHYeu5zHiHqfmvX9tGrg280ll8OIdiz6Dj0JyzIzXGZatc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXW4Ffaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ADDC4CEF7;
	Tue,  4 Nov 2025 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762284618;
	bh=U/KGUor/VNiZLGidOo6/Q8mO/zTffjjiZGcdhtXLPbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qXW4Ffaq4Mbr+c1FU+fOa0/3NZ/eeD/vlFPCR7XLLO1hCLjdDMjrBjZURf6Z7gXQ7
	 S58nlhGdpriXW3mPLQhsSjvngic5xrg4BBPDof2bE8o4F1XWi/EYuFz1gRtHgyff4S
	 ioamNxjwzTVvQ5FD6c0CuZPAAkQqTPdbjCJ3anq/ZCg4Z8uVP+jBYqQrXnDZmKBKXF
	 KgwFWnFCz3mK6GPSl15+PS8ehdbQWnZMwgYt8LBO6QCsiVP4DF7l7k3VAoAjFTO9Ce
	 c2q6rqkT3NYQfBj34CGpwdoT3joyulLpt6fyXKNlv0VomEO7YUXTmMJN5XuBi5zewZ
	 p6RvvVK0xt3Qg==
Message-ID: <851cd32b-e64e-4e56-bf49-7c8b3336815f@kernel.org>
Date: Tue, 4 Nov 2025 13:30:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Support preemption requests
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, maciej.falkowski@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20251104185340.897560-1-lizhi.hou@amd.com>
 <6011b225-ac26-4e64-ae35-db35055f7552@amd.com>
 <8c9b2d14-96c4-d917-226e-b1422d1390c8@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <8c9b2d14-96c4-d917-226e-b1422d1390c8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/4/25 1:28 PM, Lizhi Hou wrote:
> 
> On 11/4/25 10:58, Mario Limonciello wrote:
>> On 11/4/25 12:53 PM, Lizhi Hou wrote:
>>> The driver checks the firmware version during initialization.If 
>>> preemption
>>> is supported, the driver configures preemption accordingly and handles
>>> userspace preemption requests. Otherwise, the driver returns an error 
>>> for
>>> userspace preemption requests.
>>>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> ---
>>>   drivers/accel/amdxdna/aie2_message.c    | 95 +++++++++++++++++++++++++
>>>   drivers/accel/amdxdna/aie2_msg_priv.h   |  3 +
>>>   drivers/accel/amdxdna/aie2_pci.c        | 63 ++++++++++++++++
>>>   drivers/accel/amdxdna/aie2_pci.h        |  8 +++
>>>   drivers/accel/amdxdna/amdxdna_ctx.h     | 17 +++++
>>>   drivers/accel/amdxdna/amdxdna_pci_drv.c |  3 +-
>>>   drivers/accel/amdxdna/npu4_regs.c       |  4 ++
>>>   include/uapi/drm/amdxdna_accel.h        | 16 ++++-
>>>   8 files changed, 207 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/ 
>>> amdxdna/aie2_message.c
>>> index 69cdce9ff208..d493bb1c3360 100644
>>> --- a/drivers/accel/amdxdna/aie2_message.c
>>> +++ b/drivers/accel/amdxdna/aie2_message.c
>>> @@ -210,6 +210,14 @@ int aie2_create_context(struct amdxdna_dev_hdl 
>>> *ndev, struct amdxdna_hwctx *hwct
>>>       hwctx->fw_ctx_id = resp.context_id;
>>>       WARN_ONCE(hwctx->fw_ctx_id == -1, "Unexpected context id");
>>>   +    if (ndev->force_preempt_enabled) {
>>> +        ret = aie2_runtime_cfg(ndev, AIE2_RT_CFG_FORCE_PREEMPT, 
>>> &hwctx->fw_ctx_id);
>>> +        if (ret) {
>>> +            XDNA_ERR(xdna, "failed to enable force preempt %d", ret);
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>>       cq_pair = &resp.cq_pair[0];
>>>       x2i.mb_head_ptr_reg = AIE2_MBOX_OFF(ndev, cq_pair- 
>>> >x2i_q.head_addr);
>>>       x2i.mb_tail_ptr_reg = AIE2_MBOX_OFF(ndev, cq_pair- 
>>> >x2i_q.tail_addr);
>>> @@ -601,6 +609,11 @@ aie2_cmdlist_fill_dpu(struct amdxdna_gem_obj 
>>> *cmd_bo, void *slot, size_t *size)
>>>       return 0;
>>>   }
>>>   +static int aie2_cmdlist_unsupp(struct amdxdna_gem_obj *cmd_bo, 
>>> void *slot, size_t *size)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>>   static u32 aie2_get_chain_msg_op(u32 cmd_op)
>>>   {
>>>       switch (cmd_op) {
>>> @@ -621,6 +634,8 @@ static struct aie2_exec_msg_ops 
>>> legacy_exec_message_ops = {
>>>       .init_chain_req = aie2_init_exec_chain_req,
>>>       .fill_cf_slot = aie2_cmdlist_fill_cf,
>>>       .fill_dpu_slot = aie2_cmdlist_fill_dpu,
>>> +    .fill_preempt_slot = aie2_cmdlist_unsupp,
>>> +    .fill_elf_slot = aie2_cmdlist_unsupp,
>>>       .get_chain_msg_op = aie2_get_chain_msg_op,
>>>   };
>>>   @@ -680,6 +695,74 @@ aie2_cmdlist_fill_npu_dpu(struct 
>>> amdxdna_gem_obj *cmd_bo, void *slot, size_t *si
>>>       return 0;
>>>   }
>>>   +static int
>>> +aie2_cmdlist_fill_npu_preempt(struct amdxdna_gem_obj *cmd_bo, void 
>>> *slot, size_t *size)
>>> +{
>>> +    struct cmd_chain_slot_npu *npu_slot = slot;
>>> +    struct amdxdna_cmd_preempt_data *pd;
>>> +    u32 cmd_len;
>>> +    u32 arg_sz;
>>> +
>>> +    pd = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
>>> +    arg_sz = cmd_len - sizeof(*pd);
>>> +    if (cmd_len < sizeof(*pd) || arg_sz > MAX_NPU_ARGS_SIZE)
>>> +        return -EINVAL;
>>> +
>>> +    if (*size < sizeof(*npu_slot) + arg_sz)
>>> +        return -EINVAL;
>>> +
>>> +    npu_slot->cu_idx = amdxdna_cmd_get_cu_idx(cmd_bo);
>>> +    if (npu_slot->cu_idx == INVALID_CU_IDX)
>>> +        return -EINVAL;
>>> +
>>> +    memset(npu_slot, 0, sizeof(*npu_slot));
>>> +    npu_slot->type = EXEC_NPU_TYPE_PREEMPT;
>>> +    npu_slot->inst_buf_addr = pd->inst_buf;
>>> +    npu_slot->save_buf_addr = pd->save_buf;
>>> +    npu_slot->restore_buf_addr = pd->restore_buf;
>>> +    npu_slot->inst_size = pd->inst_size;
>>> +    npu_slot->save_size = pd->save_size;
>>> +    npu_slot->restore_size = pd->restore_size;
>>> +    npu_slot->inst_prop_cnt = pd->inst_prop_cnt;
>>> +    npu_slot->arg_cnt = arg_sz / sizeof(u32);
>>> +    memcpy(npu_slot->args, pd->prop_args, arg_sz);
>>
>> Am I following this right?  I would think this should be:
>>
>> memcpy(npu_slot->args, pd->prop_args, npu_slot->arg_cnt);
> 
> npu_slot->arg_cnt is the number of u32. So arg_sz is used for memcpy here.
> 
> 
Got it thanks.  No other concerns.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

