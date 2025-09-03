Return-Path: <linux-kernel+bounces-797831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03736B415E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06C71B62897
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBC92D9ED0;
	Wed,  3 Sep 2025 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XsIYEA/b"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BCA2D94BC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883460; cv=none; b=VA0qAAEXrkpw5VPHhGGZ9gUhhqjEDH9Guse6rU2tyHPKI2zDjFY+y5TKjVojCivF/pkFkDJHbdIYC+hfpQrt/6r2zzVLD/wti4MBpZivHFa3wskjV/sMdE/1DWp+oeI/l8Ilap1UneYT5tEqjSStwStU1BIBRt6yac6Yz6cZf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883460; c=relaxed/simple;
	bh=NkJDUgCFlbUdgLwbxb1k7PnToJXeJ3p25k8wOV3yMxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edVZY2rfYT7f1WtA2OqqeKwv40C8v6tB7k6te76YLj+CVO6uHt13KRy4Mk/CLC236Q6OfzB5EO0KBZtcHvoRgID/klXjGzsE3b2XNboE5iLWZtVr1QwpJDuF4ZGyqMop92KoLRRjojGaUa+JIZ8DiowErZJpPX8lquVW+oZ6QK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XsIYEA/b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832OMUr012689
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 07:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/dDVWY2+oCb5XWd4OqmdYITmU2/sa3YvmpoTH2f3ZDM=; b=XsIYEA/bw/FQm4mH
	Cu/ZwP2Q2zw5O5Z4lyp+Y1rWQoA07Ts0eraA/CfvJq0UAjKfrUQ1o0RmoM/6LFgL
	s84d98lIwd4y5dWq4vxtooRg8avR/A6jJAvu1wud3yxW/jBMDbfCPSAnsaIi1KcD
	VLyonCzLe/dYADYhCDD03kiJg8okuKahc3ZpKSVurkZ36KO9XjygiMijnfwx4gND
	t24bqGNTbdkf6jqLZehx9z9MCJ+rtExy5zJ8WGFOTAVRdHi/bZPDUgMuPDeAWX0+
	UCOHD6b8o3jZXYChQGOGcfmt9KOrP+XAjjovYPoq6rXj8vLwkJ8+ev8oQFhxBg0x
	vIDlFA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk92cav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:10:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77250d676b0so805719b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756883457; x=1757488257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dDVWY2+oCb5XWd4OqmdYITmU2/sa3YvmpoTH2f3ZDM=;
        b=LuFlSNKK/MyJYoIv/7KpJS5AOSP/+S37Tl8X6p8OJi2cqZGKq7N/dqtbOvLohDuYWR
         dav5FIr+QMZkyHfQXGWKsnWSNekufbR2skrX+HRx99DpCq0qvAoGmsRBJdDkX0QlplsS
         +6SjyjQB/vdTX+CJeRYzXAX5/IqFRQS6i1NgevC3yas9hUz8u5ZU94uQt7j8V6fsWc3F
         eJcoai7C38Khw7Z3YUBbKVqyWc7kgKftfaVpIxMUKIvks3CIV5bMb76/LrSnfFB2K1Np
         bte8LInpprDfpFjIhVkWQkddtfTVgnowdsGmy0VebW2TWukGsAIfprAget2BbpwisO/d
         6FUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPVSLAWuyEK1YaR1Ufk7A5cdQlXj5atm8vUYI2ghBp9YQEE/RdJPgsdOn+UgFru6YcixWXIa45stP4ur0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVCttzMrHV5IaTGCZ5ZOv9V+/oQkZEuiNKFYJVpz05bNSrCji
	cMYB4uv5hIAQvhVmZsn8oZyqG57Ctuz0+bYHnORUwol6EdiESSUO0ZIG4o+/zICMofJE862ZV32
	QjT9iLqqnOye/bREzYnlNrxcLof5oU1b5FUsOcIB9Jrs+M1S5byIRv5gc5pITqhgv52U=
X-Gm-Gg: ASbGncu8p4RrEQYw4Ig11JP3aZoJXv8l/unniuxX6sm8SRIw6I4cGKu0CdP2jFgfP2R
	xMvFyIAGoNi2BESIdyJTTgsaGdUG42oGciMqImAUO+5rBNr5P9D2vdMm1BIGVAxIH96wGse8Ztc
	uz1wQP0kZpI2Z93Qj7dt0DYoGDmQh7JTS2ztsfsUsugjQ30h7lIggEUTAKqYniAwtq+cO4t/rLB
	+3heVu8dTd3EBpCWRO7oXm4UcIGsTvtJWZMeUHtcBJyZ/YyLwNSO9l7lJ7/+/ljMTThhhs7a7um
	GPfKyeN8wjFcR6D1Q6RCe22V6giI3YrKBQ0z2uDSWU6pHnTEen9/0ohxc0WnUYZ1WCFwiClEbv8
	ZhwRGR2hXFHjuBV3xxxkZGGthSbhq
X-Received: by 2002:a05:6a20:a9a9:b0:244:aefe:71f6 with SMTP id adf61e73a8af0-244aefe7619mr5585796637.19.1756883457298;
        Wed, 03 Sep 2025 00:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+djaLJqUygkmqEGXB5M3J6WOaqKxMcULLmnz7boTMV0+9fLiRCsdhUkH3DfauU6APsZUMAw==
X-Received: by 2002:a05:6a20:a9a9:b0:244:aefe:71f6 with SMTP id adf61e73a8af0-244aefe7619mr5585763637.19.1756883456801;
        Wed, 03 Sep 2025 00:10:56 -0700 (PDT)
Received: from [10.133.33.19] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3298520c7d0sm10207741a91.3.2025.09.03.00.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 00:10:56 -0700 (PDT)
Message-ID: <07d8fbd5-54b1-49c2-a12a-c9b44bf1b1f4@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 15:10:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: ufs: core: Fix data race in CPU latency PM QoS
 request handling
To: =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Cc: "tanghuan@vivo.com" <tanghuan@vivo.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "quic_mnaresh@quicinc.com" <quic_mnaresh@quicinc.com>,
        "ziqi.chen@oss.qualcomm.com" <ziqi.chen@oss.qualcomm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "quic_narepall@quicinc.com" <quic_narepall@quicinc.com>,
        "nitin.rawat@oss.qualcomm.com" <nitin.rawat@oss.qualcomm.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "huobean@gmail.com" <huobean@gmail.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "liu.song13@zte.com.cn" <liu.song13@zte.com.cn>,
        "can.guo@oss.qualcomm.com" <can.guo@oss.qualcomm.com>,
        zhongqiu.han@oss.qualcomm.com
References: <20250902074829.657343-1-zhongqiu.han@oss.qualcomm.com>
 <d8be2a553690ebcf915cd1ad395c3394158abd58.camel@mediatek.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <d8be2a553690ebcf915cd1ad395c3394158abd58.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: c1HhEXA_ynInEgbhxkDDaV7hpYX-fNkW
X-Proofpoint-ORIG-GUID: c1HhEXA_ynInEgbhxkDDaV7hpYX-fNkW
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b7ea02 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=I3z-T-4cxT6kGIpvpuIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX6ArDzRtu4NQ7
 0zZYoFXftP5JiXNPie+XH2qqvLdSP7zT4M+d4+7x/r3BiDFgrnAu1z88an7q7ksHxM9oGxWfnQf
 RQcBCFDio8+oKcncrylsbTST6Oq3ETVa08RQHkm9+jNQ9lsdE87oGU0lBLmIIWmymr+7f8TCsRc
 beXzEVu5QfA3WZwHk4s+yZvCl0rKS7+xzNQbncTKbhJm6f9D6Adzy+cKe04EHAqw9N/K/zfpuhV
 lZT3qQPFfYO00iQzPNaYa2FKp6KqIaCw1U2V64M6lVQg6a0KAlOMUEeqAyMKOVa9Bgf5ajmdOhh
 BEFcotCjcifqZ0hgRy7BRR2jbBjdLHtIkRmqLFHNMHeUVxuEKruln+10NM7+4tqeV6bsRYcauI3
 ioTMjJ36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On 9/2/2025 8:39 PM, Peter Wang (王信友) wrote:
> On Tue, 2025-09-02 at 15:48 +0800, Zhongqiu Han wrote:
>> 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>> 
>> 
>> The cpu_latency_qos_add/remove/update_request interfaces lack
>> internal
>> synchronization by design, requiring the caller to ensure thread
>> safety.
>> The current implementation relies on the `pm_qos_enabled` flag, which
>> is
>> insufficient to prevent concurrent access and cannot serve as a
>> proper
>> synchronization mechanism. This has led to data races and list
>> corruption
>> issues.
>> 
>> A typical race condition call trace is:
>> 
>> [Thread A]
>> ufshcd_pm_qos_exit()
>>   --> cpu_latency_qos_remove_request()
>>     --> cpu_latency_qos_apply();
>>       --> pm_qos_update_target()
>>         --> plist_del              <--(1) delete plist node
>>     --> memset(req, 0, sizeof(*req));
>>   --> hba->pm_qos_enabled = false;
>> 
>> [Thread B]
>> ufshcd_devfreq_target
>>   --> ufshcd_devfreq_scale
>>     --> ufshcd_scale_clks
>>       --> ufshcd_pm_qos_update     <--(2) pm_qos_enabled is true
>>         --> cpu_latency_qos_update_request
>>           --> pm_qos_update_target
>>             --> plist_del          <--(3) plist node use-after-free
>> 
>> This patch introduces a dedicated mutex to serialize PM QoS
>> operations,
>> preventing data races and ensuring safe access to PM QoS resources.
>> Additionally, READ_ONCE is used in the sysfs interface to ensure
>> atomic
>> read access to pm_qos_enabled flag.
> 
> 
> Hi Zhongqiu,
> 
> Introducing an additional mutex lock would impact the efficiency of
> devfreq.
> Wouldn’t it be better to simply adjust the sequence to avoid race
> conditions?
> For instance,
> ufshcd_pm_qos_exit(hba);
> ufshcd_exit_clk_scaling(hba);
> could be changed to
> ufshcd_exit_clk_scaling(hba);
> ufshcd_pm_qos_exit(hba);
> This ensures that clock scaling is stopped before pm_qos is removed.
> 
> Thanks.
> Peter
> 
> 
> 
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including its
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or believe
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
> 

Hi Peter,
Thank you for your review and suggestion~

1.While adjusting the sequence of operations may help avoid race
conditions, it is not a reliable solution and increases the risk of
future maintenance issues.

2.There are additional race paths beyond the one discussed. For example,
user-triggered sysfs interactions pm_qos_enable_store can occur at
unpredictable times, potentially leading to concurrent access to PM QoS
resources.

3.The critical section protected by the mutex is relatively small, so
the performance impact is expected to be minimal.

Thanks again for your feedback!


-- 
Thx and BRs,
Zhongqiu Han

