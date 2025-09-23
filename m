Return-Path: <linux-kernel+bounces-828082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB59B93E68
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D5118A37FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681FC26F2B3;
	Tue, 23 Sep 2025 01:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oFZBk5Ph"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138558635D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592172; cv=none; b=L66T4WmamhqQ5UxgDx3XKXEOm0plr46Mbyicizam1WaTA3Vl3/jlQF4sGsPaTCJM11javG5SncEMn5QUd/JwHUOYKE2Y29X3OBPbnbWWq+jb06JTs335VPlSNKFxmL1UZpggie4hejxS/coVvaOOT3G+3qvQNcmZbt6rma1F7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592172; c=relaxed/simple;
	bh=YQfkd4dJsej8GctBwGdXWmCDunJVVmOD/UiO2iYsea0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BT5xOgrUMnfnhIQtvIoRFDpPw0Y+mW4cFQn5QZ5fNYhYWKQZJf0f2ytdDjRLv5QLiDyICAZT+EisE+850eiTedhywSbKeWETXyD4uCt2XY4lu+2ESzsIcaFKQN0SsGyReJd2GKaHzDRvH8IKRv0nFzKiQK85yEDMTIuVXNB+nyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oFZBk5Ph; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MIWxkB017962
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RqnAkPOsKwygUdduVzkxqejyVHLb05PYDmmJ4BQXCWI=; b=oFZBk5PhCGGu26qN
	jB2k9lLR0R4dRmagRBpE/GB95zC06oxNDHSlvmplZYSgEFSEUyI8Qp8ZT4pLMioc
	cOVXxGGU3wZ0njV5dfZ6PJU0SMekoI1vL0b5zG3wP10PJPiJF8iaV1h0leQ5ejCH
	PBo14WnigEvA2MSYK3S7eGpydUkrMAK5BUGAd3Mfd0M9hrWGiXyKQd6kZdzxDbPN
	05KxFQi4+Ys+Pm05xQL7k+QNpTk2soKeBnJ6jRRb9t2T/C6M1xcA/97LM8Q1nynS
	HnMl4r9b1GZrXsLcshujddVrp7+mEAPJBQjr80xgCvklp58NUbNZQ2hKCd9kYLPU
	QORiXg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0xrsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:49:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-248d9301475so69421765ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758592167; x=1759196967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqnAkPOsKwygUdduVzkxqejyVHLb05PYDmmJ4BQXCWI=;
        b=M20GRFC6FxiqekrfQvenSq0/bC0Y9gychdibLhghWl7DdkzlB8L5rdZ4q2jkwCUcmz
         A16kvbcwbQe4cS1xjajFu3CcaJYIxxNFN0VP+F2Weg/G22/rsjNjeK0SWZoXhBlRqddf
         ALu00kPQ2n2jjBEivbrE98joJy5WO+jvhXy+03t8w2Dflm13OynomYny2CJW7Yfsy0QO
         u14lEw4rHb74jXOY/YG5koq0JACpCZXHy96EI35r6vx9JLhx6FEW5Tn4xlFNtVeKYDkq
         bRpOtZQr8tmdO6SmYVSVbBLUI4jr6J7wfKLjAcJ0fo8jSxkDgijw/pWOyu+CSNVV3knR
         WvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaLd9kIOvjQCO7d/ZNip3UjzVLOwiqrtGoYlIKR/xYDTh4AqCAIoCo9Ads5Y7a23TuOaSt1Q4ZrhrffHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySGJHBd4+QGbODbjQiQjA7m/k6xKXQs6SArMJm3oADxcEr/Quo
	SyEuoVm0k8R/FE52Mx2OWDrcni1kD5eetKokcSfL4YOb/oij4Ej1JpjSU/pMpO530JMq9w1g8Px
	xgAsmVhwi/lC7HVmD3qB1m12Br/tSj0C7nN00M2rG0Arve8o+ba08KtfcuoEyOsCp984=
X-Gm-Gg: ASbGncuVnKNRUe5npqi/ALFA8znUQhCoEXYNT/uHaW/tzFeb0ophe4obWkxIrFDHpe+
	Oa1fs8kBrgOTymO55NUsL8arAY/tOFk8HJjKyf8Ws8iihfp+rS/GwV7+Bs9ObnrVZF3SE6z1JUr
	ljwFR08QaVn45oZ5YD+/zSGeZM63V5k678RpJ2Wm38yvNLLDTjomvKpkqguvBdccYYlkH00v5eG
	P4a/xH8zjG1fConUQjhYXrNV/eC/padS2HN7N9OivPjceY7ImDfoMPgdLupebZ2X32B18mtUXgo
	/DVR2UqaOTdHzeKwcJXV2wkXuCbOnx8GUM/z0VKf1wLbM5kJvtGUfqVGNCdcoUrmgwrngCG+c+F
	CpAG8wI3KtD9mx9/xmVM07BIWKZvw
X-Received: by 2002:a17:903:fa5:b0:269:9719:fffd with SMTP id d9443c01a7336-27cc28bbfcdmr10366565ad.1.1758592167312;
        Mon, 22 Sep 2025 18:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT5CdMHBfAlbN0dyDAVUJLxDBheFXKrvsbf1/f0gg+rnfUpig+w4SPjSUuiWXkm4QLYPE32w==
X-Received: by 2002:a17:903:fa5:b0:269:9719:fffd with SMTP id d9443c01a7336-27cc28bbfcdmr10366385ad.1.1758592166875;
        Mon, 22 Sep 2025 18:49:26 -0700 (PDT)
Received: from [10.133.33.94] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de979sm146799845ad.69.2025.09.22.18.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 18:49:26 -0700 (PDT)
Message-ID: <f7be3833-9b33-4935-b821-a2e0000a2557@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 09:49:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] coresight: tmc: add the handle of the event to
 the path
To: Carl Worth <carl@os.amperecomputing.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
 <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>
 <874isuo0m2.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <874isuo0m2.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rGjAA_Aq5ngsMJZujirml63yOmPhEKa7
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d1fca8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=ck2vDrGU2QCsmqff:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8
 a=vzhER2c_AAAA:8 a=3561TshI6JjcMm11RPcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX17bgAT4TtG90
 nKFnONu/o7ezCicYSvQcixtY/MpzmKlq4deV19OEstnHgK2M0UtRdg/cmxHxoLQWB1kpNgjOtS9
 2J0Mg1Sr5jUQeEtraaLR9kIL5Sp1kNqGSG+S6XOyyx8dXf7kGbBomPN7JT1SDi9+QRa2wharKU9
 lhHubQEWCIncuCrjDiaEdQaFLknJJ5I7uGPNzsD3oHeE4d1TCTBGbCF87OyXsJA5yiWFvXAImCD
 IScBNefZc/nW3Vg3VGGTdPMtZ/mOtyLJHOvxuYOrbvhdX0dNJhah5KuTWOncgik3+FQMbG4dmSJ
 +tcUu0EaTJvKUzs2sD2dnsfZ3CDByWMHlngUhA/UrLMnZYETPiKRdgHcCGOLeFK+YFFMdxWNeXB
 zzW1lDJt
X-Proofpoint-ORIG-GUID: rGjAA_Aq5ngsMJZujirml63yOmPhEKa7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025



On 9/23/2025 1:31 AM, Carl Worth wrote:
> Jie Gan <jie.gan@oss.qualcomm.com> writes:
>> From: Carl Worth <carl@os.amperecomputing.com>
>>
>> The handle is essential for retrieving the AUX_EVENT of each CPU and is
>> required in perf mode. It has been added to the coresight_path so that
>> dependent devices can access it from the path when needed.
> 
> I'd still like to have the original command I used to trigger the bug in
> the commit message. I really like having reproduction steps captured in
> commit messages when I look back at commits in the future. So, that was:
> 
> 	 perf record -e cs_etm//k -C 0-9 dd if=/dev/zero of=/dev/null
> 

Sure, I’ll include your commit message in the formal patch series, I 
think it's V3 since you have submitted two versions, if you're okay with 
me sending it out.

>>   /**
>>    * struct coresight_path - data needed by enable/disable path
>> - * @path_list:              path from source to sink.
>> - * @trace_id:          trace_id of the whole path.
>> + * @path_list:			path from source to sink.
>> + * @trace_id:			trace_id of the whole path.
>> + * struct perf_output_handle:	handle of the aux_event.
>>    */
> 
> Fixing to "@handle" was mentioned in another comment already.
> 
> Something about the above still feels a little off to me. It feels like
> we're throwing new data into a structure just because it happens to be
> conveniently at hand for the code paths we're needing, and not because
> it really _belongs_ there.
> 

The core idea behind coresight_path is that it can hold all the data 
potentially needed by any device along the path.

For example with the path ETM->Link->ETR->CATU:

All the mentioned devices operate by forming a path, for which the 
system constructs a coresight_path. This 'path' is then passed to each 
device along the route, allowing any device to directly access the 
required data from coresight_path instead of receiving it as a separate 
argument.

Imagine a device that requires more than two or three arguments, and you 
want to pass them through coresight_enable_path or similar functions...

For certain coresight_path instances, we may not need the handle or 
other parameters. Since these values are initialized, it's acceptable to 
leave them as NULL or 0.


> Or, maybe it's the right place for it, and the cause of my concern is
> that "path" is an overly-narrow name in struct coresight_path?
> 

It defines the direction of data flow—serving as the path for trace data.

Thanks,
Jie

> But if a renaming of this structure would improve the code, I'd also be
> fine with that happening in a subsequent commit, so I won't try to hold
> up the current series based on that.
> 
> -Carl


