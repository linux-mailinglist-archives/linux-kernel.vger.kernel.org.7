Return-Path: <linux-kernel+bounces-806388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E5AB495F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C433AEC29
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA5B211A14;
	Mon,  8 Sep 2025 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ORj47Ymd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D71189F20
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349985; cv=none; b=YkdpQJjMtbePdFwqK2daZ7bDM1jMFoddgzkqaQoWiuestGpVklOuxd1Zj0XvyKR6VYrE67zcthhYBwtKNtSii+4mBXHVxNcA15ho3QrUdi5uuYcaULfD5e4GnpBGoOlalwhM6d3dyv/5B7QudBeD66/Yj99uYVopctxAkP8wOqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349985; c=relaxed/simple;
	bh=SXOk90LcmLsd/exMj7f1c86NiExUYAyfoTzveKV0lqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCVPpg1Mvk7YODdE6cQYJWcCsM0I4xS6vZ0Qhfz07miWXY13QUvPVyd3jk/PLfhBW1GzeabWS6q56EL+pxx+8JyckbaGbTQkfML/UdiMVzI2cnDs7hWOCKf/siR2ms5+Ldt/eZNQo1nMV/SEXZwCyOo8+ZMMnS5J/LS/xkhlo/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ORj47Ymd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889bFFA029084
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 16:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R9pcsmAoSHVDbbzIiULdZ8NEWiWLl5JSAmvUzsmuP4E=; b=ORj47YmdAQmkECZh
	tOfrKf8nCXKCdNzCXBdWdwAUyakfGyQ8gZ9viFQ4kXjpuL3huEUZi8QaLPT4nh17
	Hdf7ezKPZSsrD+4AM4zDjfHYxLyLtIAS2rakmgdnfR/mdITP5F4lctw6u2Ym82DW
	x2F01btgRZWuoaCv75Ui8L9EVVNzY52dM6sinUtKj+ejiHiu7b55zU4tqZZw3WRP
	QjF2TCjrPeKOFsFy9XlqqFugNDzWJGnEaqBx1yfuWI//T/UESts8+lgohR2FIQdw
	WuDEXXDdOA37GMbeHmTgYs6m3CoMULT8H4CbGEkb+4UAT79tiWX81m9NliCjmytp
	N/6t9w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by8wdnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:46:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24c99f6521dso58022885ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349982; x=1757954782;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9pcsmAoSHVDbbzIiULdZ8NEWiWLl5JSAmvUzsmuP4E=;
        b=Dc7UBNgAol8N5hkmiKOAhv/vJDRnfgFVLajnfZHkgps1lc/TM9ZWOMh17zp6RmPqIQ
         9rRo3fLWnX0Jiea31HMP5f7PHT2qVxEWx/oDRMP2GgWU2mRX6CY7AKgNP4Aj2busZ0k+
         Bx+Xvpj/qIKDs5koVqNn0qPn53TlLBh3Qxm8lzSMM248FhCNGrrHyv3MJxVWY0CZMcpC
         L+NAlBwYkfs4ugbkGyNZ0VUeBcX+YWEKMG9BCZDo7oFgB6Fw5CykHx41iE+6PepwLnuu
         DtbTVgJBnR5YAGMKny3Qa4gMDHiwDXFBXOZWSGHx4xgXsbf0MMjahU21Q3DXcoEVc421
         H0SA==
X-Forwarded-Encrypted: i=1; AJvYcCU40Ebfq0lNOMyIUY/IHK+FtogLcorxp4EJXxKhWhuEbcjSxvc4cPAhnmkfZX4iaWLIjNM46cmheEYT6dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDv12NryRnJw73Ab2Z0BTU1fXGyc728zyDwejQTPqE60PzudTV
	g+BDDotUv+kpaXZnL0pEIhP0BYUR+OZfBpiqPjhk9ZEozoA11gaggp4HTBe0ck6qKSBWyFiejO8
	HdQCCF8i/Ttp/yPANx71MG+cMu7IjfHhkX7hII/3sXYHG004oNMDl+nEuwd4/KHeR+IE=
X-Gm-Gg: ASbGncskrRh4+eyZ+QxGPl/66ILblRuHX0GtzyC4cw3PcWziWBu3IqhF5kzHqwXMJfT
	AM16WL86Coxrz6+OnyL4xm+xaYAloKUPTQR4tEu3S6F1IMQNqyzX3j0j8+jeIbL9fgSaqNvOE9c
	2EK6rwrzWKdwpPX7FVc6e6kg+psJTKl2NwOASlaqeE2p79EkkMreVL1FwThI9UCIjMojZuIK7qa
	ehsKid7jjLk7l25qYgiLRxiwCXub/DvNH+fOScnh1+1AAKEceD6/f62ms4XvM9lOlkXfP2IvlRI
	2t7Obf1mj1ykOFjIxnGtDdp8Ig7LLLR5lFdOAiVLZ81FuQuJUQ6z7Kruz8qFWA==
X-Received: by 2002:a17:902:f787:b0:24c:d33d:417c with SMTP id d9443c01a7336-2516e889ac6mr88938285ad.9.1757349981547;
        Mon, 08 Sep 2025 09:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5C6a21lbY10oE/GGVNO4fuDADuEXCbELslzfbogJaxrkiWAbotF5cys8mh6IlE2CkL7wfVQ==
X-Received: by 2002:a17:902:f787:b0:24c:d33d:417c with SMTP id d9443c01a7336-2516e889ac6mr88937985ad.9.1757349981002;
        Mon, 08 Sep 2025 09:46:21 -0700 (PDT)
Received: from [10.91.118.43] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d08a36b3sm20306144a91.25.2025.09.08.09.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:46:20 -0700 (PDT)
Message-ID: <e72188ac-d680-42c2-81be-eb17bea8e94a@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 22:16:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] drm/msm/adreno: Add fenced regwrite support
To: Connor Abbott <cwabbott0@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
 <20250908-ifpc-support-v2-7-631b1080bf91@oss.qualcomm.com>
 <CACu1E7H_K0WbWsHDqD44YfyMvc9bfZon-Tx75LkBFqWdG2YZ=Q@mail.gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACu1E7H_K0WbWsHDqD44YfyMvc9bfZon-Tx75LkBFqWdG2YZ=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68bf085e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=YtVMwAlMLTXNks-BDvIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 7RmkRbPs7yo9MDHiAXjIb1m46ncqqkNy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX4Nfsldg9/6Mj
 x0/WjeqQokna6C0wMdhc/7JNDZs4qQ8GVMyrkgkt77EbbalSUUkJzIByK3UsKNO7Prm5Cfkzaqo
 FHKy5kOqZsbCA40v5qUGXSkirNMD7DFTBkqfX1iNrSMwKbDLyanrCBdmCT2wwXmRvIiDxMDXDou
 9LYQWVTuaBFNkxKFBmKt/27/sCfeWpO14DByVpDUyJQqCvhloDzqS0tfMjk6o+Jaj620jnq52tQ
 jCzAViZ54h9Qleo4966GGcdkhNudmQ+EehsTfnEDfqZQAUIqSON80yIw/htjxEVEtWM472ryoA5
 74SpE7dPceEAcbsQr628mn56zympHHZfrYk2XM38vxMrP42cYa6ENH00O9FW5x4C6eho1E7IkGW
 zehob9sH
X-Proofpoint-ORIG-GUID: 7RmkRbPs7yo9MDHiAXjIb1m46ncqqkNy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On 9/8/2025 9:24 PM, Connor Abbott wrote:
> On Mon, Sep 8, 2025 at 4:27 AM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>
>> There are some special registers which are accessible even when GX power
>> domain is collapsed during an IFPC sleep. Accessing these registers
>> wakes up GPU from power collapse and allow programming these registers
>> without additional handshake with GMU. This patch adds support for this
>> special register write sequence.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 80 ++++++++++++++++++++++++++++++-
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 ++++----
>>  3 files changed, 90 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 45dd5fd1c2bfcb0a01b71a326c7d95b0f9496d99..a63dad80ef461da45d5c41a042ed4f19d8282ef5 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -16,6 +16,84 @@
>>
>>  #define GPU_PAS_ID 13
>>
>> +static bool fence_status_check(struct msm_gpu *gpu, u32 offset, u32 value, u32 status, u32 mask)
>> +{
>> +       /* Success if !writedropped0/1 */
>> +       if (!(status & mask))
>> +               return true;
>> +
>> +       udelay(10);
>> +
>> +       /* Try to update fenced register again */
>> +       gpu_write(gpu, offset, value);
>> +
>> +       /* We can't do a posted write here because the power domain could be
>> +        * in collapse state. So use the heaviest barrier instead
>> +        */
>> +       mb();
>> +       return false;
>> +}
>> +
>> +static int fenced_write(struct a6xx_gpu *a6xx_gpu, u32 offset, u32 value, u32 mask)
>> +{
>> +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>> +       struct msm_gpu *gpu = &adreno_gpu->base;
>> +       struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>> +       u32 status;
>> +
>> +       gpu_write(gpu, offset, value);
>> +
>> +       /* Nothing else to be done in the case of no-GMU */
>> +       if (adreno_has_gmu_wrapper(adreno_gpu))
>> +               return 0;
>> +
>> +       /* We can't do a posted write here because the power domain could be
>> +        * in collapse state. So use the heaviest barrier instead
>> +        */
>> +       mb();
>> +
>> +       if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>> +                       fence_status_check(gpu, offset, value, status, mask), 0, 1000))
>> +               return 0;
>> +
>> +       /* Try again for another 1ms before failing */
>> +       gpu_write(gpu, offset, value);
>> +       mb();
>> +
>> +       if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
>> +                       fence_status_check(gpu, offset, value, status, mask), 0, 1000)) {
>> +               /*
>> +                * The 'delay' warning is here because the pause to print this
>> +                * warning will allow gpu to move to power collapse which
>> +                * defeats the purpose of continuous polling for 2 ms
>> +                */
>> +               dev_err_ratelimited(gmu->dev, "delay in fenced register write (0x%x)\n",
>> +                               offset);
>> +               return 0;
>> +       }
>> +
>> +       dev_err_ratelimited(gmu->dev, "fenced register write (0x%x) fail\n",
>> +                       offset);
>> +
>> +       return -ETIMEDOUT;
>> +}
>> +
>> +int a6xx_fenced_write(struct a6xx_gpu *a6xx_gpu, u32 offset, u64 value, u32 mask, bool is_64b)
>> +{
>> +       int ret;
>> +
>> +       ret = fenced_write(a6xx_gpu, offset, lower_32_bits(value), mask);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (!is_64b)
>> +               return 0;
>> +
>> +       ret = fenced_write(a6xx_gpu, offset + 1, upper_32_bits(value), mask);
>> +
>> +       return ret;
>> +}
>> +
>>  static inline bool _a6xx_check_idle(struct msm_gpu *gpu)
>>  {
>>         struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>> @@ -86,7 +164,7 @@ static void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>>         /* Update HW if this is the current ring and we are not in preempt*/
>>         if (!a6xx_in_preempt(a6xx_gpu)) {
>>                 if (a6xx_gpu->cur_ring == ring)
>> -                       gpu_write(gpu, REG_A6XX_CP_RB_WPTR, wptr);
>> +                       a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BIT(0), false);
>>                 else
>>                         ring->restore_wptr = true;
>>         } else {
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> index 6e71f617fc3d0d564e51650dfed63a18f31042ac..e736c59d566b3fcf8c62a212494e3b110c09caa9 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> @@ -295,5 +295,6 @@ int a6xx_gpu_state_put(struct msm_gpu_state *state);
>>
>>  void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
>>  void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert);
>> +int a6xx_fenced_write(struct a6xx_gpu *gpu, u32 offset, u64 value, u32 mask, bool is_64b);
> 
> "mask" makes it sound like it's the mask for a masked write, which it
> isn't. At least in the public API I'd name it something more explicit
> like "fence_status_mask". Also it would be nice to add defines like
> GMU_FENCE_STATUS_WPTR/CONTEXT_SWITCH to make the parameter values in
> callsites less magical. Finally, this might be personal preference,
> but it's not immediately obvious what the "true"/"false" in callsites
> mean, so it would make users clearer to add a separate
> "a6xx_fenced_write64" and make 64-bit reg writes use that instead of
> is_64b.

I agree about the BIT definition. Will update if I send another
revision. Same for the 'mask'. I can see the confusion due to write and
mask in the same line.

64B fenced write is used only at a single place (in the preempt trigger
call). So I feel it is an overkill to create another function for that.
I did weigh that option earlier though.

-Akhil

> 
> Connor
> 
>>

