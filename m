Return-Path: <linux-kernel+bounces-870990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772B3C0C2A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8423AD765
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0962E0401;
	Mon, 27 Oct 2025 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TvIKCqW1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB332DF3EA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550843; cv=none; b=k3nDwS/p0MUfAvkyumIjb7aVlJgQYKrgPwcp7hNrzRJv+Q1Z+UcPQdbA9q8Mj1o5Vcho+URw8wC0aUNYK/zvrcVypEcayS2dXPwjQhWIkjFBUxYrlTm6fHKIHdoQ6bIVMyb0sNmzTvCg9mJf620Tr+dfQKSfZQkvlwzQKWA/tr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550843; c=relaxed/simple;
	bh=R0xc1fkhECePL+EIuZZfAKmsmYcMGujOt/70u9Vw3xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1ExMm1JAuSdOonE+2v+Qu3dCrdY/1snPaSS8BAKKyCovFEffTTOPNOAXHRcpXfVKlW8D8kJrIo6zjkBIlkNwpqT7VXxYT1wgRCugYW1lHDoA7ChHD4R4At9I+L5sESRNZyE8p0e+QXYS/zYTdMmWg0zdwLaU34PaDBWx73TKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TvIKCqW1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QLZpEl885330
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SqrygtWmbxodwMNERV43ZieFOArDZxKbypJ6sksUSpY=; b=TvIKCqW1ceVM7uId
	xubtAichxl8OM0aBK5VR5YpS9H01qJMb/typK79zTCKkibljoNs0e0f+WFO8YS10
	toW5czoS2Mq8NhsLvJ2GqdG9d6mK4MljUSQNFNxQA33UxquMXzzO11Mz+IHsb9E1
	xQuFFYVjimLWrjzuGTPvssRaHqhgZF5pyT4E/ynuVZdNTQqkdw8SpNQcCWzAIX3C
	/KuKiCx515XoTOm0fvPVaXAE8sNdI27jB7PNyDTK/q+cCSq+PU6jG2B78Zo7C0n9
	AudbssbWCTjFPZiaTRU9MZ1fb3UcpgP/4w//j060IWWym6OxPKHNMPg5bBDzMnfM
	/tpgBg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p2q3pmw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:40:41 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a26485fc5dso3174601b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761550840; x=1762155640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SqrygtWmbxodwMNERV43ZieFOArDZxKbypJ6sksUSpY=;
        b=ru+9T1fU0BHCH22A89rq8eEZlGVnjNs/On+0b4EU0LDXuRhxxaeRo+qj2wf419Dqvd
         TQV1Py3pwYDzBqVukCr+KMypanW4JXOG2geQIZOcwk748K7n9omUoymwD1J3pjZQyFJM
         W8Hq4Yr804Ra0BoFusoIvPt2YwEkTsGFUstsl2j8iOQ0KrpZ33XAIE35zVNLT0i/uPGH
         O+Qvi1Sr3jWJhBu69ZeN2Q2yOWY3a1Uz2E+5Qw/XJ5ABIxeGByQ2QRtT5CE1aTUlYrzH
         lmn0dc9NahV8gmajl4nVUQR3JMXhaieE4uIq4iaWkKVGN/2wpJVZSNFJEIPp1mls2Qz3
         cz9w==
X-Forwarded-Encrypted: i=1; AJvYcCUajAB84I9VuGp/M/3FpvhuYK+ikIBDSICLRR97C1LpTRJoTdsox+He3tcSp3bNJRLBLzMDMSubzBhG3sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfN0I+Zp0vDglLjLEAXkZuNdCDGy9F2Fh6XhLATRFggTS5KwTl
	142IVYagam9+7XRQ4tH69h2EEGss/JX004cu0pJ0+ZuQlLJ53xRG4nfwa1wrrclk4e2QmToiHEW
	md4q1OcoisXcRkp+PFfqeh8JQvOctz8ogIYWw4IWhqc7qmangk2Lta8CEngYpLNiLX8Q=
X-Gm-Gg: ASbGncsFlTPANx7D70la9Q7mlc+eLza9hBtuMVx4n4hRvzWB2gCFfPwrBTWjySuIAVd
	wmHHtMBVjCduEqN1KZzFUJJtsdTV12/Mj39GoKC6uUf4q7Wdtkxszc/evuOfWQ5lcyhVF9oHHE7
	2nJkb5oJmBWKSl+hgkCF30Eqif6+be6hQNIRuTzkBgIWxuJH8muO3sam7HJjeU8ir4Saoh/Bgwd
	/v1hxAZACFVCw6WsKFJHStKTv7MWOdpYB3aEDB2GiZI93LUF6JZn2DM36gKf9hFf4vjFcqWi6n+
	WNiBX4822iA6MLLdPQmIXNeORlxLo3qlVhxbrhESsziH6E82KAooFIckerQHUqQhN0aEmrX0rNQ
	s1fM9df8bfgyVWf/DsJG2Mxy2mxDUJVyL7bdud1QMmOzQz1ivMwBFP47xrA==
X-Received: by 2002:a05:6a20:3ca2:b0:33b:f408:7b98 with SMTP id adf61e73a8af0-33bf4087ce2mr23084044637.45.1761550840414;
        Mon, 27 Oct 2025 00:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZOuyY4cpAg1wT2GSLAnHjVQYLln4q6dXnReVlre3uLFeYDZTV7RdNNNvWtHVoClqtPBqftA==
X-Received: by 2002:a05:6a20:3ca2:b0:33b:f408:7b98 with SMTP id adf61e73a8af0-33bf4087ce2mr23084018637.45.1761550839923;
        Mon, 27 Oct 2025 00:40:39 -0700 (PDT)
Received: from [10.249.10.235] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712f880ef2sm6307659a12.38.2025.10.27.00.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 00:40:39 -0700 (PDT)
Message-ID: <a57e82c6-9492-4db9-a0d9-a30252d25487@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 15:40:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] media: qcom: iris: encoder feature enhancements
To: Neil Armstrong <neil.armstrong@linaro.org>,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        abhinav.kumar@linux.dev, bod@kernel.org, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
References: <20251015092708.3703-1-wangao.wang@oss.qualcomm.com>
 <23f08812-7890-446e-95b7-4ff5b8f547f2@linaro.org>
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
In-Reply-To: <23f08812-7890-446e-95b7-4ff5b8f547f2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QvpTHFyd c=1 sm=1 tr=0 ts=68ff21f9 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=i98tAzczrWBB9TwQN78A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA2OSBTYWx0ZWRfX/S1GbamCiy0p
 OnSJO6Eex1YTz+U81vQHvxdv7tWsHFh3P2ycBDl+V8HDNqyUOP6E8Y+KwwZPX6PBW1YjoeWoGaA
 bzQ/aiNf6BEfpAO5V+lO1hVicQ0YMalekqHcNDeSmMJoiqg3Hpvwf88ae7nkXzOl+WzsuXRlsU4
 E1gTCPqCECZ7aMS1ayab6+ZYnlq31ZHcTnuSqwarDdFY1u9sDgn6oYzCuIhOJYOuiXU8bWOlKa3
 k1HNttjWCoK4Q8X3tvR3/Qkn9GrF6ikKkAL3LmTtkQGv3IsTIHkZI4r87iY5qf31LONPZvhvunx
 SywWu8UQ1KNkpU0r+B2qts8JiVgZHMi5Hdp1vkbMg7NQy5/LimTD44eZ8917/dND9/wbf6HZyDY
 qTGCZtQp+cRlCADSQmFZHl49eam3dQ==
X-Proofpoint-GUID: HWOXsV40TWpNjuBaYfjFxaIVey9In5--
X-Proofpoint-ORIG-GUID: HWOXsV40TWpNjuBaYfjFxaIVey9In5--
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270069



On 10/17/2025 5:55 PM, Neil Armstrong wrote:
>> All patches have been tested with v4l2-compliance, v4l2-ctl and
>> on QCS8300 for encoder.
> 
> Nice, but did you test those on any other device ? This patchset
> affects all supported HW, so please test on all of them.
> 

Thanks for helping with the review. So far, we have conducted tests on 
QCS8300, SA8775P, X1E80100, and QCS8550. However, I don’t have access to 
an SM8650 device—could you help test it?

> 
>>
>> Commands used for V4l2-ctl validation:
>>
>> Scale:
>> v4l2-ctl --verbose -d /dev/video1 \
>> --set-fmt-video-out=width=1920,height=1080,pixelformat=NV12 \
>> --set-selection-output target=crop,width=1920,height=1080 \
>> --set-fmt-video=width=1280,height=720,pixelformat=H264 \
>> --stream-mmap --stream-out-mmap \
>> --stream-from=input_nv12_1080p.yuv \
>> --stream-to=output/scale_720p_output.h264
> 
> Please provide a way to generate/retrieve this `input_nv12_1080p.yuv` 
> file aswell.

A 720p NV12 file is available here, which can be converted to 1080p 
using ffmpeg.

file: 
https://github.com/quic/v4l-video-test-app/blob/master/data/resource/simple_nv12_720p_90frms.yuv

cmd: ffmpeg -f rawvideo -pix_fmt nv12 -s 1280x720 \
-i simple_nv12_720p_90frms.yuv \
-vf "scale=1920:1080" -pix_fmt nv12 input_nv12_1080p.yuv

-- 
Best Regards,
Wangao


