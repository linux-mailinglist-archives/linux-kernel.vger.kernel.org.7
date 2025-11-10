Return-Path: <linux-kernel+bounces-892291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239BEC44C76
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99A73A9CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6EA2236EB;
	Mon, 10 Nov 2025 02:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XunadcEX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IbMV/9Sw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA201553A3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762742110; cv=none; b=VmGQSRSHNknFbxbHBg9pd39eaHj7g+xWWPYmVyGVgMRTQJSciY1kDSME7uRRjigQ+4OdSrEm1Hwc86T26k7Gm1VtcOWLwxoUp/XP/EuZpEB8jztQiwH73EZCOInc7dKMHDjzm3XCypcVSwLSwGkHTW/wyAc+ajXiSXdpMkr/4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762742110; c=relaxed/simple;
	bh=FWvVEmepI+ORVK/x9yXbzQd4Ox1Gvv7bysnMPtT2MKA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tKh09eCJYJaCbtTRfD0J9sbpBadPZAY8JAFsgSjWLwHbN1fXpIvPlgGgO8xgfeshAUtcnq64sbDDBtvqG70qijNtPQcPBCg5QdNAUzDtRIl8r5nQC2u4Ir9cGjju11NHqwe1uIJoQv2tUntRxtnSp+ZOLVIY207aKycwcmFtQr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XunadcEX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IbMV/9Sw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA2Mu491883295
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K5D6ZGrmC52DvawP2bZ8gsaexpKm30yHpnNBshUX6AA=; b=XunadcEXMce98rG6
	uzR2LNXD8LpoFfMu48X0p4DtmAbM2Qq4rZC7EfxSBuSwpgdhWx1UFyV4x383J/3J
	B/vzaJnq1Yv/0FCbJUfbkRDh9F/kGVcjI/+mTeIrlA0BTEJ3FTfzE9+d3CPnl0vr
	Rr7gKVC0ezu8MC5iDvbeumf0kQTEH33EUMgZK5XOQUqCel3RoyizbIqVKQ+kDYlb
	jO1e+BhOt9SxwKWpNEWpoZC1CdZIU3+0yoAJXrVIFnS4mcHdIP4gUFvnrbsbDuGQ
	rlbv0VoUJGYHXDYs1QMprY7B6rrhBD4fmXioxQDcbPiwEvvFJxwp5cyAXz2AP43E
	eUgIDw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab76vr0yv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:35:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2955f0b8895so32541805ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 18:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762742105; x=1763346905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5D6ZGrmC52DvawP2bZ8gsaexpKm30yHpnNBshUX6AA=;
        b=IbMV/9SwNoX1K6cZDI6eieeuPJ2eX9dKryUybyFlbL1mGHaUWXkyD8Z0u/7pVWkHQO
         +hugrKDpgEVUGJVhCo2JDDigAe62mbTmUqenG6XmXTuPkHLVMKCr9KrfhZqKZv7Sg3Gt
         N9T4SS9xJqQW21IykKmpnnNxQCeWSJFC+KQYgRpCNI7NhMF9fm8voSn/91YeV4qd8/Pp
         IVx3IJttpEB4JElpE7pTDW54JOn1o0NEA++OruTy9GG1L3L4DyQS2gXUUDSbfJe9+kma
         InPHikudwd57ZgfBfx6IfPSAq1/YTSa6kOyiDjwrd8kK5PD+YzOefqJ242vPBK71pqsL
         SsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762742105; x=1763346905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5D6ZGrmC52DvawP2bZ8gsaexpKm30yHpnNBshUX6AA=;
        b=CuUyYx5JMZUvYTQLa4I9tnAcma/7g5CbOKCkmczf1ny/qY4qVm0VCwWmrhECuV5hoj
         YVs9d8zO+tmWbatSt5obueHma0ykwZLrd4cuG8DC1jY4vKxwRoz8rAivf2d8e6dBTSP6
         cEMOR9yri2lmVGbPpaYIyX2WxwX5XXD7Mf1gLhSUb4v35TDqbh8i4SU9BfpeEglMKrzI
         uwDf2pG/tM/CqvQ6CXDoMv0qpJJcoKSbNEHz6/W46WOdaV2QKYHK//mtPTAERjLIKyCu
         dp1vgAUfgix6jBtghTrODzQ4NpYwylTvdv6cKiQCoCnVYeGkpfei0XQRQzp68g6XDc2b
         2+ww==
X-Forwarded-Encrypted: i=1; AJvYcCVlP1nvjZzPPBgChEKdicphLES0b+ZskTysJLmXsz7OmwbB3PJyYOfb45nQGIEiPKhk3w932SoNYgRyhRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpu+HxcUa7beui/a23Reo8N8OQ796VbsV/FuQyEgL6lGXHu38H
	AF9HzzUthljTFBYICMWJdiVBibwEhxkEaCixJsbt1dtitB5Cg6fnBc4hzdeQK8DV2UjaHBQu60Y
	GNbXegvGF/92h5x79nTQDVK1V4laPkslCbkO1YUCpUNY3Jzzx464Wf5TTMMvbnueS5p4=
X-Gm-Gg: ASbGnctd92SmyIQ9GrvXA53OroKjsEyZS8VircsAe+MyqsjLGr5D6CnjGPOO6YiCmkJ
	yZj2M4NMRbW6YbArBourU8/I3ZmJNwXdCQY6QE/+ywHslBAEu4cwiXN9oNXzKMXkqydy400V0Pa
	YYg1Q87GKbgHXj6N6QVS1t7UOnmOCJB7IHV4TrhdQtCthDggsgcuO4gYvD1QOWdcGSpnY1x1fGl
	esWMxUFV2mzyzURyVETUaef/xobQhD/tubtQNNHXAQN6xbOQtFawHw/w6TFvUCLjYqhSPKZH//s
	J30W7ENWIpKe/TlG6HZUtaZz2DBg0+QRMezv9bOrImbcfjDba7oGkfEa0l4dpVM8WArw6QTFZT3
	ugHV704GQXr2Pnt961fklMRr4dMHd6qTRKz67v5p0rLGAMa72DAvpHDAjpFfY7eQ4//PjQw==
X-Received: by 2002:a17:903:37d0:b0:297:f2c6:8e05 with SMTP id d9443c01a7336-297f2c68f6bmr61548865ad.6.1762742104872;
        Sun, 09 Nov 2025 18:35:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH97XC5ddthR7Ydja0T+XyG+55lI/1s75GAyjkmHkqkHI4eZFrTDzVTzip2JG43DVoRzGmkpA==
X-Received: by 2002:a17:903:37d0:b0:297:f2c6:8e05 with SMTP id d9443c01a7336-297f2c68f6bmr61548585ad.6.1762742104386;
        Sun, 09 Nov 2025 18:35:04 -0800 (PST)
Received: from [10.249.28.136] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436c27a999sm3185823a91.4.2025.11.09.18.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 18:35:03 -0800 (PST)
Message-ID: <e72f3d55-9d1a-4e10-b9f6-5f1162064982@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 10:34:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: wangao.wang@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
Subject: Re: [PATCH v4 1/6] media: qcom: iris: Improve format alignment for
 encoder
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20251106-iris_encoder_enhancements-v4-0-5d6cff963f1b@oss.qualcomm.com>
 <20251106-iris_encoder_enhancements-v4-1-5d6cff963f1b@oss.qualcomm.com>
 <df169cde-39db-ec6c-7294-04939575498b@oss.qualcomm.com>
Content-Language: en-US
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
In-Reply-To: <df169cde-39db-ec6c-7294-04939575498b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8gs1_KawgO-J8hLJXxjq78KSvYuHvbDM
X-Proofpoint-GUID: 8gs1_KawgO-J8hLJXxjq78KSvYuHvbDM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDAxOSBTYWx0ZWRfX9ndwYa6G90yP
 G4wqXk69M2TGUYRiQEImFQqOBHp3yejyfLBwigrcdnHB27bAP2monudNOgPIc20UYAb/rReu3k3
 RxS8sKdvIi/35sIpBh/ls22jmXEzcGP8w1y9Pnshn4SsepnKTHc852U0Qwct96RsP4P5L6gFYfE
 1whmr2/FLhO/AKGlELVWpePyeJbFZkWC6wC8OOQAPejShumZWBYUbUFzEKXhUkFBQAZj2mJYUp5
 LWkJ+ws5Qj9fHfmK/QpNHNqvWyaSVHzueBvL72GPFan5tEmEF7guCStf3ha5ZbQay2oPBR3dzTE
 kGpXVKRK0kuY3K5XLhTS/lcJD03CqYsFhZYfpbsC5k5Jt7bxSOlq+5f2lm3MAmeBnSgFYfTUvgX
 omurfCsRZUe/2vvuWnHsdvSsNGg9EQ==
X-Authority-Analysis: v=2.4 cv=LvyfC3dc c=1 sm=1 tr=0 ts=69114f59 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WNGIKuW-4MPZ4T8x7xwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100019



On 2025/11/7 16:42, Dikshita Agarwal wrote:
> 
>> @@ -231,8 +230,8 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
>>   			top_offset = inst->compose.top;
>>   		}
>>   	} else {
>> -		bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
>> -		right_offset = (inst->fmt_src->fmt.pix_mp.width - inst->crop.width);
>> +		bottom_offset = (inst->fmt_dst->fmt.pix_mp.height - inst->enc_raw_height);
>> +		right_offset = (inst->fmt_dst->fmt.pix_mp.width - inst->enc_raw_width);
> 
> This should be move to 2nd patch where you clean the CROP offset property
> setting.
> 

It will be modified in v5.


-- 
Best Regards,
Wangao


