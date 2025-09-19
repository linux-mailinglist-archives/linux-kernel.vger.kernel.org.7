Return-Path: <linux-kernel+bounces-823856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AFAB8795E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AED1C87A95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1A224AF0;
	Fri, 19 Sep 2025 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g5fWk5s7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7257189
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244866; cv=none; b=O6Odoa/Le+P30H4NjSpR2pjwmNClqO9yNmuxaTG6fcMooa5rtwzfZRHoVQsbG3dk4pZLuFttGqkskqlMDy+ngkThRW2veZtWr/SRxO0Qq9aATARbymiXS9RIWp8h6A+BDwr7kdgGINGZLNZwToSqY9dIE+/0iSxjny7kP7j/Uqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244866; c=relaxed/simple;
	bh=TDXr9RZYBsnb84JdhwB14ihZZZ1JARhypvK36tnOLrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/GZpiBKGsAHMNGrjK7wGGGXw7gLWYL6v9gDq1LlGLjask0LDfUARCriIH/Wf5I8fpIwfNSPNZaSbh/pI4/OaEwLtU+Bgv0v7SqyfoQta5B0kCGJ/h8NGJnAZjBuw5SW5216Zq8rzm/NmfJu0j0bRsJhLKG+yRvcYArCjIgtZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g5fWk5s7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IJHhMH011237
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Foo3ySYo6EFjJPBK6U7dkab2RZtqehrfT72uvB5IuYY=; b=g5fWk5s788taeLoq
	KLEjbHyp0IJogJaIwIh/OegyxSBw5pQyI3XLFNn6w0T+l8tWChmvtSk70Qncdns9
	hNyGJ2Ch1mrJPLZUJoSBP5AOVCf5YRa1mjiqXWzy75tKgUVrQPF+/x8XVRG2RG4l
	Js60roBPVI9OkTuHnjfpIp3cgNkJ2mJLOZlCr+crAgDnPQQo3rwsZq+/L2CXao5i
	36hIZiHU/fZc7lWuwPPoxdWlcPmEnq3rve+I9mDnDgUtNRT9XgG9BKW2DkeErIQC
	0EOWZ9gmDwH/kyn9NW73ogpAX7ROJWSL9Txo/GRtT1ru5HDcHWq2kse7Z06yRklk
	Uv5CHw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxy0ht0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:21:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77daad52913so848862b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758244862; x=1758849662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Foo3ySYo6EFjJPBK6U7dkab2RZtqehrfT72uvB5IuYY=;
        b=Aa9zsFG00Vqk6L1wX3HX0dB1EDGWDYv4DnCQjnQ0TnhB7XFFI4Jg8k39JccohvMfDv
         ckpNw4hkzOMOehKAe3MBL9WjUM4nCE4J7vyNDrmha2LofBXyGLQlgwhT1HIJYKzJgI/R
         EICFbN/O6J0UK8TB+heivwONiOU3kpn7OYe0mpV6FcIteI9CLVPnWq1pSFXkGMvmhujI
         Us75GC+FG1jnivL6Ds1xqS55K8ZXemJmSuGxqWLXrQR2VRBwEK0OW7kFI8o00FuWX4Iw
         6BePjTpGNze7sRnx2LLseFSz2bYEPFBJIPk1iuS4saUOhk4ltsNmbRtWGZ3nWK8+sPzv
         8D4g==
X-Forwarded-Encrypted: i=1; AJvYcCXDmHK1zYY3dnLV+Rx+WLNZfuotP1PAzWgev5ffRk9oMGux76UNX07tEPUMIfqYIVXTZmDkJSvLNqI141Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu4tc1RbFxVGXzJwIP0+rs1ge1JKWOGkY2ydB0uyI65oRcZA3T
	dXgSjMf3IMPqVfLiGb6DYEDRlfbTAusNs9uoXGIX4vryVTOmf/O+pGCkfh3QPsc17FzQcw0Cb9v
	uHXQHkTzhDlcW1B48nqDmbDZC8Ep6Xs5j8LxCLsALUH1tNB0Kv1i0ix+dXN/5170mYryyFd7tVy
	27dg==
X-Gm-Gg: ASbGnctiEuVTDrwwjy4GoQte6lk8AO42LxOKSW1NwseWEMVksoKUACOncHmCuyHGR2w
	zmN7uJKH92+42DXfmVgJ5raRnM31/sOKLsG0fcuguysFbbcsEeK6C5iP3PkvyHj5yCM+xJM1Zr+
	78QuS+mbNiAbUnVi9uxooSQW0Qb3mKhw5ZsI+4a6E34bO44QprC29ds+0K/oLuXAHsxMkEw2aTh
	7YKQCa9u/b9FJ02/Ikwk5jcks0gZMSvE2OD2TpZ10yAAhwcNVMDjrcPlG3UAQ+wgv/FHWBzracd
	U7FyrHsT8YH5ei32R9+oW7sHgidZVrlatCBYhqQEmrogwKXFzyT86pYYV8H0adqe6A7lY0Q87Pw
	5tCWVJKGWTzMTVz3RJyrcgeG5tLAd
X-Received: by 2002:a05:6a00:3e0a:b0:777:8ba9:d200 with SMTP id d2e1a72fcca58-77e4d70fc5amr1411177b3a.10.1758244861566;
        Thu, 18 Sep 2025 18:21:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeT8sKUNUHwVzOX/zQmHzWTxKFmgwaOXcBYgKmhEiz68/Qtj1ou1dKF/mr96j126elpztJPg==
X-Received: by 2002:a05:6a00:3e0a:b0:777:8ba9:d200 with SMTP id d2e1a72fcca58-77e4d70fc5amr1411157b3a.10.1758244861129;
        Thu, 18 Sep 2025 18:21:01 -0700 (PDT)
Received: from [10.133.33.50] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec3f84fsm3578203b3a.79.2025.09.18.18.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 18:21:00 -0700 (PDT)
Message-ID: <e1a2ee99-07bc-40f3-8742-a0cb1c273350@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 09:20:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: Fix data argument to coresight_enable_helpers
To: Carl Worth <carl@os.amperecomputing.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250916224441.3008824-1-carl@os.amperecomputing.com>
 <a331eceb-ec49-4396-a61d-78a75789b090@oss.qualcomm.com>
 <87frcj8kw7.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <87frcj8kw7.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXxWI4jRXsBbC0
 fRwBeO9oEAZJ3NdKaXfl9tgmctmna90ccwnxCd853eSM8fnK5jejF28eTxqcHdjEcAY2W75m4nJ
 Ae7vkrPSM6bxKZlb5ldii1P7x37g1I/MfAeaGvUMJ52YrHh5C20160Bg8RsyXWKV93dNBJhGUoU
 8siZ8FvBK60DBTE/nFVEZV1Iu1GPWuhQyXymmiBc9qeE+zf2SeILAfmViC0nTJa2wyX5StcWxrj
 Ljaf4qFh1BgFqjtELq5RENRYnpb26khUWu6H52bhlKDlxJ0A+sx9EuKMLR/SCh8TRbzQwQcpHpH
 onxbklEdeJKufU4khYVcNwAayqTnB4JNrOjupJpvgwvopIwdUJz2qY6lVLeGenhqi49DAuFkjYc
 b4EdNyUW
X-Proofpoint-ORIG-GUID: qEIYdssP7hlk_Jr2b8yP5-unjfOvvyb4
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68ccaffe cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=YdNVS5wT9Qrk6_kBnO4A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: qEIYdssP7hlk_Jr2b8yP5-unjfOvvyb4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/19/2025 6:18 AM, Carl Worth wrote:
> Jie Gan <jie.gan@oss.qualcomm.com> writes:
>> I dont think we can change back to sink_data since we introduced
>> coresight_path to wrap 'data' which is needed by the path.
>>
>> I suggest you to add the struct perf_output_handle to the
>> coresight_path, then retrieving it with data->perf_handle in
>> tmc_etr_get_buffer.
> ...
>> We can assign the perf_output_handle to the coresight_path after we
>> constructed the coresight_path in perf mode.
> 
> Thanks. That much makes sense to me, and I'll put together a patch along
> those lines.
> 
> But, further: with core coresight code assembling into the path all the
> data that is necessary, is there any reason to be using void* in these
> enable/disable functions?

In my opinion, yes, we can change void * to coresight_path * for 
helper's enable/disable functions since we have everything in path so 
the cast is not necessary now.

> 
> Could we also change these functions to accept a coresight_path* and
> actually get some compiler help at finding mistakes like the one we're
> fixing here?

That's the only benefit in my mind so far.

Thanks,
Jie

> 
> -Carl


