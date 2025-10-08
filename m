Return-Path: <linux-kernel+bounces-845169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 180D2BC3C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61F104F2267
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C192F3610;
	Wed,  8 Oct 2025 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n24/UCeN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752672F28ED
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759910874; cv=none; b=beTNf4FmRevQyoGTSWH6qkUeU6R+JvdzeP29sjtSBoBPjSM05WVhSW3C5Pv5eX8cCip9d2aQbPHRWreK/ZItR+/sUzxsWhngMfLe5D9QaWc979MvJtZVprP1igAmnoCDjkhAsz8Cpd1YUk1sv7A0Jc09c4v12GPw8bfvQV41vAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759910874; c=relaxed/simple;
	bh=GlAS9v82xMR+f+PiIo8yltvT3Yx17cqEy7wFa5tVMM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgWpaa4emiWYFeOodFDg/eWWPSyzTMnCxv2ZJwexAiX9UzwKxVvsEfaEF01vtO9nRSngSpU30fzT28Q0n7OPvHrz46OsFfC4s0UMeuVrqRNbR79sNlRxdYajmirvorGWw2fuVQPWKXM1LkVJqsrYdPWJgg1F0aY+TgHm8YJeyUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n24/UCeN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5987aWM0003362
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 08:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kq4YzR3vhm4SYmSa9+hmdY+KgdgAz/2HcGkjiLTH8wM=; b=n24/UCeNBykD0lsn
	uWQgmoqRqKAf8mxEAXlHA1Y43B1xVByyReP8Gx4tXoa8TNDRIT6PaGof9EE1xYSE
	MURn8tuspJfw6mnWgFR8ZTEW8vNx31lzYgezzL2FlWyT0YUFltqm4HXBpF8NjV1a
	TRyorreuZMviXUiYmMhOv036JYWYCXkZzEEPx7fhS7kL3hLpYK2NZiFx2Uo4E2Ma
	ZmHKsmCMANQsQDUntbehhmOHplcF5urPLPYHzLIxKdxe53ml9o1+HC6WNeP8p0fM
	f0v88S+21dE1tNXmy2RzBL1d4Mm7HaY09k9eLGF/asTzxsaU4DdHrzmG/x5Jz4W6
	Dgr8vg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy71r90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:07:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-819d2492a75so330841585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759910870; x=1760515670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq4YzR3vhm4SYmSa9+hmdY+KgdgAz/2HcGkjiLTH8wM=;
        b=LviO4KKQ6GT9p+kKlHH43R81li/w/3I/DXDXhr5d3/ppGdHaSrNf4NFQSMkDU/2clJ
         q4aDMcDlny06y+NEcqjWYvK6Acd7Q7/yEifzlWr4TH5yVoGZ7KscX59wPcos/RxMU9pe
         MSBbUVPKBKkZ9QdvjnnRWwIMQgDUvlcqqLQLYGoNHjVQN+IgK7mnzO3kfB2bIYD9yg7U
         W47OEBYKko0mw9AoOWYh/ZevCAdb5Q0ftEwF7KGFBu+WRlGlCDwnMswtidHO+Ir54/xp
         Uhgmtgo+1A/vkbhReJPo48NtaBLtlkCHskCX3IU0xAmLAukH1xITT1XAm+dJNM11o5kC
         LV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeRVbjrkePap9+IC7Yg3upw0D96KRU5J131lqEP3El1SSgaa7uqVBYX/F5IR0nM+YvwpFOj3+vD/SCyGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9wGhE3cjgfW8CneH04wouJXk10YRGux3Zz1fag+iW0W9JkOPt
	jqr+FXu++7uSKUJqzj7p1kxCX9TRg6Js7hfgPgYLof4WqLbSUuB7/gNWy57icKvi9pqoCvZPV88
	5/lVrEPzvyBOQ7Q51Lp6fxV9L6gn8fm1cIArU03MABcrpCzMa6vbIs9sKytHdTLIRGOU=
X-Gm-Gg: ASbGncvLNvdWH6SG+vIYdHW+jW1PFX9gb0pyZT+5KPcKHwRQBtAtCbPKKIW9xSvBQvd
	M+1hwCimQN7RrGLptwDrmWf5/YDXInSsZpi6vyjbCYDZBhUMfr3QAHb/zdzw4DdB3WzAwEUEhxt
	eHOQZvCXQNsOeI/qWi0tu3Jbvj71gCFiJQoCFnE3M981+9JietDSnEQfR7vG9ghEGhMegOPU/0i
	BtexPwuBx/YQeNVXOdZO9omfs0DXWviweZdrGj1zZOIxJtjkQpAQ2dF+iLhQemVs/VU1O7CJ9+c
	IqbxnMDH92U/CrarE70iC7O+IWZn6rCaHyahqAfzABfweSjm8ywapWINbp/Vxz3vZcBH2hs3h3X
	wUNBaySBmz27XZPkD17bbu+3udLM=
X-Received: by 2002:a05:622a:4c6:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4e6ead390dcmr23511461cf.12.1759910870096;
        Wed, 08 Oct 2025 01:07:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMbrsiezWEJoTWRCEktTHCv3y9jzulgOOKAyA4HNbMx1IViPW4142QRui1EwQ702G/O1391g==
X-Received: by 2002:a05:622a:4c6:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4e6ead390dcmr23511281cf.12.1759910869563;
        Wed, 08 Oct 2025 01:07:49 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9e66sm1563216966b.14.2025.10.08.01.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:07:49 -0700 (PDT)
Message-ID: <e335be9f-641e-4835-8b9f-69398b131b7a@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 10:07:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] media: iris: remove duplicateion between generic gen2
 data and qcs8300
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-5-def050ba5e1f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008-iris-sc7280-v1-5-def050ba5e1f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e61bd7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=uSlV7dY6_MLFwoWj4ZIA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: y4zHX9v6QDcr0E5F--y5pqXEeaZFeRZy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfX20MsNk6+pnkg
 9cWQnkneHvS/cJuCQYm5//YBTsdO6rvt2Acq0pbPUWcA4ES306zCtXWt+09xeVdhkzr8zydPLH3
 1gLE3cTdkPNtEV4x45leQCfhBYY9s4lZIyvv6Lb+L08ie5tFN4Kp/dGFOcelxBJIh3X4air9hd6
 rjs1jtbyTSyZkUkuOX8NtlCsXDfix49xT3LYtVKSMLFs6pevax/mal+X7oGR5WADc3YpEyR0EQ4
 otYbXosUjPUj7/VRlzGAbL+LXlsPeNArZvgH32ShDBles55HsK8oiYaWRAG/ZYtYli+cwmzubfK
 8KigmuE6a52hRD5rRe8Qv4N9lAaFOgh20FLF0Dk/Q8RUoubnb0NrtsR/uN+itYwT2QcBN5PHIfO
 PWE5utbi5L1nOPHKWkOP1KauMxY/3w==
X-Proofpoint-ORIG-GUID: y4zHX9v6QDcr0E5F--y5pqXEeaZFeRZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029

On 10/8/25 6:33 AM, Dmitry Baryshkov wrote:
> Now as we have removed PIPE value from inst_fw_caps_dec there should be
> no difference between inst_fw_caps of QCS8300 and SM8550+. Drop the
> QCS8300-specific tables and use generic one instead.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> +static struct platform_inst_caps platform_inst_cap_qcs8300 = {
> +	.min_frame_width = 96,
> +	.max_frame_width = 4096,
> +	.min_frame_height = 96,
> +	.max_frame_height = 4096,
> +	.max_mbpf = (4096 * 2176) / 256,
> +	.mb_cycles_vpp = 200,
> +	.mb_cycles_fw = 326389,
> +	.mb_cycles_fw_vpp = 44156,
> +	.num_comv = 0,
> +	.max_frame_rate = MAXIMUM_FPS,
> +	.max_operating_rate = MAXIMUM_FPS,
> +};
> +
>  const struct iris_platform_data qcs8300_data = {
>  	.get_instance = iris_hfi_gen2_get_instance,
>  	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
> @@ -1022,10 +1030,10 @@ const struct iris_platform_data qcs8300_data = {
>  	.fwname = "qcom/vpu/vpu30_p4_s6.mbn",
>  	.pas_id = IRIS_PAS_ID,
>  	.inst_caps = &platform_inst_cap_qcs8300,
> -	.inst_fw_caps_dec = inst_fw_cap_qcs8300_dec,
> -	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_qcs8300_dec),
> -	.inst_fw_caps_enc = inst_fw_cap_qcs8300_enc,
> -	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_qcs8300_enc),
> +	.inst_fw_caps_dec = inst_fw_cap_sm8550_dec,
> +	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
> +	.inst_fw_caps_enc = inst_fw_cap_sm8550_enc,
> +	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_sm8550_enc),

8550 enc data has a .set() under a number of caps (was qcs8300 tested?)
and also additionally defines:

 * INPUT_BUF_HOST_MAX_COUNT
 * OUTPUT_BUF_HOST_MAX_COUNT

values of which should probably be cross-checked (they say "DEFAULT"
so it's probably OK, but just so you know)

dec is 1 : 1

Konrad

