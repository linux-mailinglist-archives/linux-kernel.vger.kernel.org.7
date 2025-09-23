Return-Path: <linux-kernel+bounces-829715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE9B97B28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7AD37AF664
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578B62FFDF3;
	Tue, 23 Sep 2025 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F/h0kwTp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3527A47F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666049; cv=none; b=TXOCyu5kpNCKvPbnBIcm1GG+sZFJrcXrTvHX9mzEV/wKdt1SQcHVba3QjciHIS5NJoUGbgrEHEopSOag9HGn6LQ6Gh7lQflt5Lo9ZE4VfSsvOTssaOSYaNOWB1YOvxozZXl/hLfSi2cXwTbit3c1fWz1fYoBaI3x3VYnQtOxNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666049; c=relaxed/simple;
	bh=pM6SrP+KFWtAPLiu/qBEKPbBVnygt7Ql8aDnlXuXu8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqQPmoADXoVe8vZv4CGKs9ESLpoeA5OcDItDVhVq39+EmO+tiFRULvppH2xt3UJjKA9G98TVnzrnKB84EovQOqCDZBZzhH6U8EIrIG/rku1YzZMIem5xbnrz4kEFAosEJ0cvZmKvFPHImNOtPFqEZ7G39twtKPjkaEcE+0QOAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F/h0kwTp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NFuutu023758
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XCqgOa0zMg3bAGkPnVwXTeYirB6xruRZWHedTA8lg7c=; b=F/h0kwTpuzKJK9Si
	C/vHQHBGXHXHcpUGOYGpWXmSYEgDE3kQXgXBZXjBZRqWKVAwdmfXBOk1F1Kmsirm
	uEAScIhViYBsKBb6KarpaHr+0uWwz8czX2/9RqgY1YDFmb+ej+4IgAEkOz2hg506
	RS0z876GscswgrouDyiwKBaZgIRbYbAL3aliex+xmh/gfvERGfOJQTaZrB6/X00P
	zFoFuaotLPLHPa+lrD/ynOGx9YOBRvpa2+pYbQK5vtLiHMjQztJJ7kBYhJ6XJg5o
	hhTbqhVIKPDW53cHFvasOg3/LupMjWsBw84aysd/4Oe9OBpQhYAsWnX7AXzwxWYP
	hwQG9Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nye0he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:20:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4f87c691a7so9976153a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666032; x=1759270832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCqgOa0zMg3bAGkPnVwXTeYirB6xruRZWHedTA8lg7c=;
        b=sKKqGslD3nySJhb7XMoZhxFBsJr7gdQBHdM3cpQAiOKqEv3nXoQmuLaInKEr3AWHpN
         RWZWDYZAgetqkbXTCDDAh2+S2GuOpyLCexGx5yhg5PoB9JvhTPdXlavq8er1/8lBI69I
         NNwqgbZl1vzcO7xCiznui1RNBugpgFKSf/hrMUzZKtjh6TCN6f1loILpmafVVeHc1rmX
         TkXYJZL4FlIbb1CtOcaoExJDKwm9kSay1PWZV3HEIFoAew4fQdtj7mpjYsMdSgNquYLy
         OJLfzTxRD0mjdoktZBxZ015KN9KFCUNiKzuhiSqFcTUldtoVwP6cxEPB6ztadnDb783l
         yb6w==
X-Forwarded-Encrypted: i=1; AJvYcCXbnNHuHLnmPwIjEWxOBcj3jU4ABWmGy2tovk1JNqMkow52FCxHBfJ4LyYEJDqhwdrrnSi/2hYevDNSeoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJp1UKK0rIaGl8TUXdZ3sSvPzZNRBRSVyQQSX4JVtaZicPXLsW
	LhHuqXrGYXf2ukgbRR3SuSit+SrYuFj/hFsIDd8/Yo2pcktP9tA3eeVnbvVd/NwnjKKKVryzqGZ
	j9XDJvxh6aRKEkxEK5sCkXQhwYvWUVN6hM8148yt0ADz/9CD5/uhaqaFuReyJYC0+22M=
X-Gm-Gg: ASbGncunUhbNOhADl7G2ut/TsULJaZTgYZ3MGP3s1sEy8TmPxtIDVejcLzdYgtgyKwr
	wijGm00mm3gZ7xcPqjwehTXEqsZHz3+hoFFE+yOJn5Q62fs98gWg5bnqilAEEedEeS7aZOaZc6v
	JcS6OiuQGtViFQZswmaDRJ0fHdSSCPwyKYzLQR4p/LznyB7FWRE3F06hQksUvxdGvlR0s3/NM/O
	4pgo5oZ2WfrorIJem+nXoiMOYsES4Wb8q/Ye39/YdHq8FXakvq0IM7Sh/TG01ygBAYEL+G4bF1P
	2JYg0H0J4zPjrWOY0mpAkV50tMi+3HuivN78wvVSMROJDs8vlqa/wHL1Gb9KSTya3tYI4OlWVgI
	RB3ViwQIDYcKBsKj5CPODQg==
X-Received: by 2002:a05:6a20:72a7:b0:2cc:692a:3a2b with SMTP id adf61e73a8af0-2cfdcfefdcbmr6109105637.16.1758666032109;
        Tue, 23 Sep 2025 15:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrs2A71G+cFUsubAv+Vc1pQAa4dVVMm+2irnjFOxF6C7V/RXWnkIMo3dVaiu2z3htTxPtYpQ==
X-Received: by 2002:a05:6a20:72a7:b0:2cc:692a:3a2b with SMTP id adf61e73a8af0-2cfdcfefdcbmr6109080637.16.1758666031687;
        Tue, 23 Sep 2025 15:20:31 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b554aa612e7sm6897265a12.8.2025.09.23.15.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 15:20:31 -0700 (PDT)
Message-ID: <19bf97ed-3cb7-4b69-8d54-3cfef15f93f8@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 15:20:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: Don't adjust mode clock if 3d merge is
 supported
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
References: <20250922-modeclk-fix-v1-1-a9b8faec74f8@oss.qualcomm.com>
 <cjoxzwkvzjv7pqelcxcepafanauxjt7p5b3qevjdr5bsomifce@i67l2hzavctj>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <cjoxzwkvzjv7pqelcxcepafanauxjt7p5b3qevjdr5bsomifce@i67l2hzavctj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d31d3e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=1kqHEmTGbaOex8fRdXYA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LTQbkZQtCk9hMOS4_ddEewMKfhYh5M5w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfXwCsyK+CmcEQ3
 FzRb17fofvALiSoJqni3CxsgrvpWp+gc1QMYqpqXYBp5tQHeNrD0ZVIjoZYxpxaMVy1yV5BMXEY
 OSh7G0uJ5AK5TcNzD9zueiMbiPyOFFZTaeWBy24AXrLWJPC7ReInpPEDFxDfv/pH+4OSDjF3gcT
 9NlcMBSQxWIEg1d/gcxvaUInN0mUsWF6TA5MwRlYkHW/c+oF1Sl4k3COB4G+GI1HFGncLioDftg
 VYZNoOSmnS3q5993/DrR9eg+jUF7FOcYuMjPBc3pKmQnjNHvRgvsHcEBuwOaQ+dVuPmCFLC3mnf
 s1GtbaBNpr/szTiKaJvhkVA6AsJpCJzH96cAM44aF0pom3v/kOJ4NcmwFiSIfupZy6/ovXWPWWo
 ifRzjQB9
X-Proofpoint-ORIG-GUID: LTQbkZQtCk9hMOS4_ddEewMKfhYh5M5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_06,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090



On 9/22/2025 4:50 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 22, 2025 at 04:32:39PM -0700, Jessica Zhang wrote:
>> Since 3D merge allows for higher mode clocks to be supported across
>> multiple layer mixers, filter modes based on adjusted mode clocks
>> only if 3D merge isn't supported.
>>
>> Reported-by: Abel Vesa <abel.vesa@linaro.org>
>> Fixes: 62b7d6835288 ("drm/msm/dpu: Filter modes based on adjusted mode clock")
>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> index 4b970a59deaf..5ac51863a189 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> @@ -1549,7 +1549,8 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
>>   	 * The given mode, adjusted for the perf clock factor, should not exceed
>>   	 * the max core clock rate
>>   	 */
>> -	if (dpu_kms->perf.max_core_clk_rate < adjusted_mode_clk * 1000)
>> +	if (!dpu_kms->catalog->caps->has_3d_merge &&
> 
> Well, not quite. If 3D merge is available, we should allow 2x of the
> clock, instead of skipping the check completely. I don't think that we
> should allow 8k or 16k just because the platform has 3D Mux.

Hi Dmitry,

Ack, I'll fix the math here.

Thanks,

Jessica Zhang

> 
>> +	    dpu_kms->perf.max_core_clk_rate < adjusted_mode_clk * 1000)
>>   		return MODE_CLOCK_HIGH;
>>   
>>   	/*
>>
>> ---
>> base-commit: b5bad77e1e3c7249e4c0c88f98477e1ee7669b63
>> change-id: 20250922-modeclk-fix-a870375d9960
>>
>> Best regards,
>> --
>> Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>>
> 


