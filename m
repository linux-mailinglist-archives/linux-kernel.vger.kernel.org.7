Return-Path: <linux-kernel+bounces-870879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418CCC0BE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306531895DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC292D97A1;
	Mon, 27 Oct 2025 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CeuiDJ5b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D72D7DE6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544981; cv=none; b=NMyfKHXnpIy3xSGHcRwt4vAaihsigX4wZxWcajA1LB2wywGFGGhTf4DnuroOVCLN/GMJ4uLIylBk5SiDJ9fC0dWkmY/LKSJjaKTQGL/3HG1TMXzPM0HBJ4PeYq8/HW65evl2LKE7SGEfrQ6CmEdD+kZbGXp7dpK/U9tEAHio6nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544981; c=relaxed/simple;
	bh=bvwIDCcanMEtURHXnTtN/W2juldCPpF5y+OVvdunbGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0sEmSL7bK2MeREGyD8IZe6t26APMAME24dQRanIjt2ihHGQQvmFED/X8Nu9XDXyQtp5Ku9pYQwFq2HOh8mRicrVrIgWPv90ANulX6HlTDxz9mQSZotb4DUZWMs9oThwLS/J9jSYLiiNujl/b0JIQMGn3hr5jP8W+B1xtrDPpFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CeuiDJ5b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QLxHDm915959
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	de4ulhNEtyNvb/5bQn2fEOWChZy9TZK00HO7To3mIWs=; b=CeuiDJ5boL559qn+
	+vrbFSa+6aXtfLk0/y9+Z00RDttFxczYJcfLsGejcvInh+nZl1riQ7IxQKrpntgl
	Zzrs7DAUTpcGvDLxDVwrIGt/a/Dmxm+dOZvlNOd+T8s2exUt9mJ7kCAksr4w99jg
	aaCE/bZ/oWk16c/tyO/G/AvK8ZvKx5G0haPc0UTSIJ02frP7Q4JBvxqqoepCSi1o
	VNjMZOQcwgWOq7xSeBNxoN/iZLArC1HC7oCta6vi4BYLMCvLnGOmay5dNiCKCmED
	+T6Xa4R1zKPCKbbjLcv52cUouLX/Tnsc1PpvJGQZ9vxDQMqs0wiqV/0eAgJQzW9s
	PZiCdQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0px6kbdu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:02:59 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a432101881so1255917b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761544978; x=1762149778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=de4ulhNEtyNvb/5bQn2fEOWChZy9TZK00HO7To3mIWs=;
        b=BPTNBkJUXqw6zQI7XTjMn91d+qeGmXN+qnokUG/vt0OFCnD5r50YFRL0K4kyJ+tLg7
         JgRxvjiDC/I/dWgT7ybBTQob/w2S0MW5UxnGbMUvBPZ7BV78XhEhlhthdYRXEOvIYQ1u
         U4Cs1dwW9uwd7uudDEJ3CUwyybqjX1wQq/pw1rGQVj3QR+cnPOjuH/QGROsAz+tJMHeH
         ObYSFSVH1uuoXkFm+r10pveVc35fVgO3oQKEFYmQW6qs4QqrF/1f5lJ9KuMZl1q8HeKg
         wOJGZLHit5UGUvx1lAigPY0udiM89t0iCKePBUtsUh5UPSW8OUgqqh8fS/VmfHCQlm7M
         Ot3g==
X-Forwarded-Encrypted: i=1; AJvYcCUK/4EjvG4hq8k4/sz8I/GTqmf8l5SFr8Mogh7fEtXiEXAjSBvLujYzg+OZzmHkz4K2Yu9EUE/XgFM0wRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhCZx9mawVSWG4xomsk7v7WJY6Fxb4rFxbUNRb/fT+rMLEFRq+
	D/LaTDYRn74tAoYsgwL+uttOLcAc98wPkJgMUs2pAYe57AUdofvYTCcqELFbJRLSVFa1Z4JAaHd
	kXzH48MXPB6tTIdBB+P+PxIJHaCxKugI1CbEgh4ldLvuiplshnASrKGlNuLX2t3F7IUI=
X-Gm-Gg: ASbGncsU/FkrqT3SRZEQ7KWNzoL5X86En2YQUQeKeTluP9aDRx8riGntd3ryWl1IiYZ
	qtLYZISaMPWJkmtRfgf+x72SsG4ZveDdJMGjAKRHmIvPcrYBTFha0slcODKa/wODPPXoJI8WYG2
	YWswOiieqHMOYzkB8ztIydpaVLbs38P69qUFNDkB6+FJVWkkGiuVVfargUlpVDXkLAiWFD1SZGD
	plgr6hqQJnUu8BJm1LPh0ksLPXtVOpqmJT288PiNphYoou35j2i3tI9b0Vk6IqeqeeW/A67LyFz
	op2kkF0CKr4XeFqkkGrEpO/FkMlOaAK0xUiiVip6dkOUXfdWnwhwBXrdHqnjAHeSqGQF+Ceq9QO
	S61deWWu+PZ2GazYe2akqzKSoBQ6JtxA=
X-Received: by 2002:a05:6a00:21c9:b0:781:32e:53cb with SMTP id d2e1a72fcca58-7a220a56abcmr43645518b3a.2.1761544978118;
        Sun, 26 Oct 2025 23:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHwfAnPqw93cbL5ocw3wKit3VtdtBsRsSmslbyIdyckqJJlMfPlIKRQEk88EPRcyArBd6LtA==
X-Received: by 2002:a05:6a00:21c9:b0:781:32e:53cb with SMTP id d2e1a72fcca58-7a220a56abcmr43645483b3a.2.1761544977623;
        Sun, 26 Oct 2025 23:02:57 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049ee0sm6713840b3a.33.2025.10.26.23.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 23:02:57 -0700 (PDT)
Message-ID: <f47c11df-aa70-23fd-03b8-61a7e85ac833@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 11:32:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] media: qcom: iris: Add sanity check for stop streaming
Content-Language: en-US
To: Wangao Wang <wangao.wang@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
References: <20251021-iris_add_sanity_check-v2-1-476b3107a8ef@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251021-iris_add_sanity_check-v2-1-476b3107a8ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1NCBTYWx0ZWRfX7fq7WACQYkSD
 AoYtWSI+BemjmqiSUdl36EcEd9Yy0Z0m68GjdCvw3B5YShKiZ626hALX2ywV9b8XhfjWBZbH4Zg
 OHbVipiQIimGJmRxcfOwGccDua2mgKLUS67u4VRXI9RJbLOsm8M460nM6sHtAqgCW0JTP5O/xQe
 cfe5H6CBe6nh0hWXOVwrs8Wl0T2uNj8M36cehEFTlj6VKVmO9SWUujjlQnZP94WEqR1a11u8XVQ
 TLrZpEghi4o6x2RgrHnnICxd10DZgmqLpOQf/uPmpPtzfw06sJ85jJYf1w0aX5vN+aNuBAIq8Z0
 qEb4cgpBsarKVtS4dMI2AaMaca5U4ahtZxwhT4a0fh7sXtx7CiZO4WjQmk+xgZKpqMfja5/cy7J
 u1IqDzc0nyAKIHPtY6rGkjAiUQDZLQ==
X-Proofpoint-ORIG-GUID: Dls8u-WI4OO4inM_uVmLhTfapNwMFuVD
X-Proofpoint-GUID: Dls8u-WI4OO4inM_uVmLhTfapNwMFuVD
X-Authority-Analysis: v=2.4 cv=WqMm8Nfv c=1 sm=1 tr=0 ts=68ff0b13 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Zn-mxZD67f0sPqOPe0MA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270054



On 10/21/2025 1:45 PM, Wangao Wang wrote:
> Add sanity check in iris_vb2_stop_streaming. If inst->state is
> already IRIS_INST_ERROR, we should skip the stream_off operation
> because it would still send packets to the firmware.
> 
> In iris_vdec_kill_session, inst->state is set to IRIS_INST_ERROR
> and session_close is executed, which will kfree(inst_hfi_gen2->packet).
> If stop_streaming is called afterward, it will cause a crash.
> 
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>

with fixes tag added.

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita
> ---
> Changes in v2:
> - Remove redundant ret assignment in ERROR state.
> - Perform error handling according to the value of ret.
> - Link to v1: https://lore.kernel.org/r/20251016072517.4845-1-wangao.wang@oss.qualcomm.com
> ---
>  drivers/media/platform/qcom/iris/iris_vb2.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vb2.c b/drivers/media/platform/qcom/iris/iris_vb2.c
> index 139b821f7952feb33b21a7045aef9e8a4782aa3c..db8768d8a8f61c9ceb04e423d0a769d35114e20e 100644
> --- a/drivers/media/platform/qcom/iris/iris_vb2.c
> +++ b/drivers/media/platform/qcom/iris/iris_vb2.c
> @@ -231,6 +231,8 @@ void iris_vb2_stop_streaming(struct vb2_queue *q)
>  		return;
>  
>  	mutex_lock(&inst->lock);
> +	if (inst->state == IRIS_INST_ERROR)
> +		goto exit;
>  
>  	if (!V4L2_TYPE_IS_OUTPUT(q->type) &&
>  	    !V4L2_TYPE_IS_CAPTURE(q->type))
> @@ -241,10 +243,10 @@ void iris_vb2_stop_streaming(struct vb2_queue *q)
>  		goto exit;
>  
>  exit:
> -	iris_helper_buffers_done(inst, q->type, VB2_BUF_STATE_ERROR);
> -	if (ret)
> +	if (ret) {
> +		iris_helper_buffers_done(inst, q->type, VB2_BUF_STATE_ERROR);
>  		iris_inst_change_state(inst, IRIS_INST_ERROR);
> -
> +	}
>  	mutex_unlock(&inst->lock);
>  }
>  
> 
> ---
> base-commit: 13863a59e410cab46d26751941980dc8f088b9b3
> change-id: 20251021-iris_add_sanity_check-34a0795745b1
> 
> Best regards,

