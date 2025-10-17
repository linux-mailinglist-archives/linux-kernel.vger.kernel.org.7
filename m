Return-Path: <linux-kernel+bounces-857318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78933BE6808
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28361A65370
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0A330F536;
	Fri, 17 Oct 2025 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CedNOCEh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6430F527
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680492; cv=none; b=Vc/4zviXtsL8bJKVE5SgKr4I5iNtS9IZ25o/ztVdfLPnZBTNSWqgI/ScmQCiX8h6a1rvYZKFbZpqBIPCmxfMr/zP400TZA3LeG8aUYUYSIb40iVes0w5sdnPb1wdwB4EMtE0O24YSppPv6yvcO3OJo3/sEfr5jqeKz+nXk8pN8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680492; c=relaxed/simple;
	bh=SNmMw0sTgquEx0KNzWAeChkFRwGDfFp1CMVORD7GjL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAj8mi9QgQgRwKuG+2PpaNf5JuQmgo/qI74IGJkaK/lgVSBV2MQzhA+jxzutXf8ZrelZDWFioxT5pSWa8kEY9/W4ohv76+a156S61f5Wk9VJE6oRTeYq+v7ejU3op5EASadn7I4fAiFIVT0f5JPGRKgJMtqSnGPMqsC3uRs8tbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CedNOCEh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLLQ7006088
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VkqSu9s5dxWjR7I4tDBayWcEUvhFWsAikTkxnFFF10w=; b=CedNOCEhG5heA1Ze
	KebbOO8GsfEj6SNrJBu5xNiVfOS2i4XEfoF0cn/bOauvSah3QOgNG0c21Y8Pr6g9
	0DT/PGsurHsMhS+1uvtx20w/oKTiuwiugetgXvBnNMsLxrogNF4KT2CTS8mH6rpl
	KmbsoSf/630/Wqq5+wwfIEfLTub/+mzl2CrGJdgD/4egpsBUCaiG3SzTrkVwUG5u
	NUiZ8Rhc57eVhdGAuHBAhsJT8ySTxwrFLbnJSvB4dwmPH+HkoRhfUl7ikElVUcFv
	iEZYMufLap/+rA++dEE2d+vzrZin7E8cXW1g7wGgWbxkDBLJYPbH+INWu9YHnmjJ
	GlM74g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwwbck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:54:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28a5b8b12bbso34439355ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760680489; x=1761285289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VkqSu9s5dxWjR7I4tDBayWcEUvhFWsAikTkxnFFF10w=;
        b=rtaPaPGyVllTThPJ94bg/vNZ1zuN4WH/40OQhQ5PzBgieS62vYX94pdgPJNGtLO+pL
         d3/qkqrHEj8lb5EEpae2Y/ZxUqD74oL+GawZ8DG/nquKJpzo3Z8E5sHUsvjtTvI87Usm
         hCRXTIh3JiTyAGALec0F/9LP+vK6MO+kzT2a/XHAqQBo8uAc/OkDzk3PZDdaBIzgA4HS
         UsfJoC5/IbPCqceOrj/H/pP7XQesCMZ83kpq3hQAwk1GFLLD6EqMjqtLmF1NyDnpDdoi
         7y32A7fiefmbfHZhm9XDCJGO+PCUhU5y0pyD9FFt9o4BXjO8lzSiwUkT+A5s++4+7ET/
         rlog==
X-Forwarded-Encrypted: i=1; AJvYcCU9l6nhcFFNj/WDdIek9xklNxlg1ly3mhUY3gub95Y7S6t8DNSExHY/vjQVC5ys2dPGWc7PccG4v9PxFFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNk7s3gvUZyG/Z2ugt7FpKUbgN8/poe0pqtDMFKNFjWj3ndSI2
	23j/xf7Km08g9ox5P6/U2WNQacYZHxXkEBSWsw8j/ceMt/jiADP2JpilFfCUtNxReIDGy9WtcLI
	LGcdD5CkU+JVJPO0IQg/AQMc8ggwunH7oFzEvJI9T9w4R/bvVhEkvHTvZ+62l4cq+7Io=
X-Gm-Gg: ASbGncu+gX0Y/vEinvUwjL85DL3qSdpBjx80gA10nSHrpWUj1Y+6BKpgshK7D2HABtF
	v6SkffdN39zC3jZuWWlLGMi13+voLDi7rFlLemzAjF8UqOl4i9cHnbIxtj6NcYnNjbPedF2cwhd
	P7Ttq40kMgYdz16HCEElfss6htdj2hVaugq+B6ApWPO4wqfTO6uzgmY1HBORMp815Vgia52hagX
	H/urQUPcJeUcDRufJMYYgnJz19TDfWI1ziK+UW/cJM5RE0zMdYQqx9LM2pB+2k1Rss40FkGDfqg
	Dt2Tr8ELjrrn+Gt4XZnl0XehDYfswP9iW6YHD6uAFhU3hJ8Pxc1sOA9cHyfxu1GWhsYZaz32sV3
	wL136PqPYduDPLNd4Eb4OoOH/4xGahuf+wXPAhaSfrHSbEta0wgQGbFwbyBAJOVU5+IEIWw==
X-Received: by 2002:a17:902:f693:b0:265:47:a7bd with SMTP id d9443c01a7336-290c9cf8efemr23014725ad.4.1760680489227;
        Thu, 16 Oct 2025 22:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd8a0IlV6YWKUfG9MbGZ0cIY2N4OtBfpsKGv/NleymxB5I+xnN9bB5sCluTNXsZQxkWj93rg==
X-Received: by 2002:a17:902:f693:b0:265:47:a7bd with SMTP id d9443c01a7336-290c9cf8efemr23014535ad.4.1760680488823;
        Thu, 16 Oct 2025 22:54:48 -0700 (PDT)
Received: from [10.249.28.124] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7b4a2sm50581445ad.67.2025.10.16.22.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 22:54:48 -0700 (PDT)
Message-ID: <c18043c0-253a-4681-8ade-659b8652a90e@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 13:54:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] media: qcom: iris: Add rotation support for
 encoder
To: Bryan O'Donoghue <bod@kernel.org>, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, abhinav.kumar@linux.dev,
        mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com, Wangao Wang <wangao.wang@oss.qualcomm.com>
References: <20251015092708.3703-1-wangao.wang@oss.qualcomm.com>
 <VvDBI2gT4oH7ZFT0ooUS3sR8qVBmREmQCBoO6TyzK-3QbZzvQP6xByAlET8sWzpVPkJEeoa8pOCgjIHmayqBug==@protonmail.internalid>
 <20251015092708.3703-3-wangao.wang@oss.qualcomm.com>
 <437c380e-885e-4458-9913-788ece5a4ecc@kernel.org>
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
In-Reply-To: <437c380e-885e-4458-9913-788ece5a4ecc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX1+7IrKpm7sum
 Y0qW2vlY4d+5dgY2zbrk56vkxEssE53luk4K6jPQVDmWz1c1ZkzBO+SOVctGTx0EHJpcc6dk2am
 LBG8yQee4dvRBM0ZiZWo2wn4pVnXjAFFEeFtTC93jeueW8jGAFVolyLW7chy5lzkMysPUgwFH+Y
 LTlQk1qEuy//EJ9flJEa/MbMHIxr1VQDynWo8F4HFYZjrm4dyqMK8tPilF8DIaic8KBeXANJSgL
 l6tR/yalc6ltfTlAl254vxy+Lx4erEL/I75Pj2B6ixmVxclVebwVogghjFaR7XsL+u9chUikPHS
 CZuReR+VOs3feLc87ygMWH3yMaezjq63mRjxg3SIhREseb7iM8JIC6u+RxssgMoGJqN6Q6y7hl1
 Qh/kgWGcoXMMClqxgV1KQuuQB/Wt3w==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68f1da2a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=sT30tPJYCz54KknbIz8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: zvZYP5Khy5TZOCsvy7aGr530DqMFDd1F
X-Proofpoint-ORIG-GUID: zvZYP5Khy5TZOCsvy7aGr530DqMFDd1F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

On 10/16/2025 12:08 AM, Bryan O'Donoghue wrote:
>> iris_hfi_gen2_set_bitstream_resolution(struct iris_inst *inst, u32 pl
>>           payload_type = HFI_PAYLOAD_U32;
>>       } else {
>>           codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
>> -        resolution = ALIGN(inst->enc_bitstream_width, codec_align) << 
>> 16 |
>> -            ALIGN(inst->enc_bitstream_height, codec_align);
>> +        if (is_rotation_90_or_270(inst))
>> +            resolution = ALIGN(inst->enc_bitstream_height, 
>> codec_align) << 16 |
>> +                ALIGN(inst->enc_bitstream_width, codec_align);
>> +        else
>> +            resolution = ALIGN(inst->enc_bitstream_width, 
>> codec_align) << 16 |
>> +                ALIGN(inst->enc_bitstream_height, codec_align);
> 
> That complex assignement can be expressed as a macro, static inline or 
> just a regular method instead of copy/paste the same code with one 
> variable changed.
> 
You're right, this code is reused in several places. I will address it 
in v2.>>   inline bool is_scaling_enabled(struct iris_inst *inst)
>>   {
>> -    return inst->crop.left != inst->compose.left ||
>> -        inst->crop.top != inst->compose.top ||
>> -        inst->crop.width != inst->compose.width ||
>> -        inst->crop.height != inst->compose.height;
>> +    return inst->fmt_dst->fmt.pix_mp.width != inst->fmt_src- 
>> >fmt.pix_mp.width ||
>> +        inst->fmt_dst->fmt.pix_mp.height != inst->fmt_src- 
>> >fmt.pix_mp.height;
> 
> These long chains of indirection make the code not very readable
> 
> Please take pointers to &fmt_dts->fmt and &fmt_src->fmt and reduce this 
> clause.
> 
Sure, will update in v2.

-- 
Best Regards,
Wangao


