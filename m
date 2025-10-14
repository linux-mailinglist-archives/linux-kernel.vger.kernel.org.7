Return-Path: <linux-kernel+bounces-852069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E09BBD819E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90B8A4FC375
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E2A30DEB6;
	Tue, 14 Oct 2025 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W78OR81F"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC230E0EB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429208; cv=none; b=mIwExPsexMoz3iE1zv0jPliwjkpQaWHQpFHa2pczmMfVfJG1IIkuxppUldGNG4ju5mkt92PqAQU6EwDR4chv3JpqbgbtW1twGnSh63cXGMJFPXeKCtW9/vv5ZssTo3/2DRwXEsXGKwjs9pY6pZ+B3kNMgM+XNFKBuvJP89x48GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429208; c=relaxed/simple;
	bh=fVlJuu7kx11Q9Cca/sPAmXb5uL2H3gXWKoVGmvXX06I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJTqpPhmYE1A+JJfMVwGiTqZFaJM5k/7SFQuVvPIq6oc8msBnBZfvrrHKpTg/wPn7/1pduhB8OKqvQL7wiqZA/spz1Q8AiYpZkbn2h/tFSTo+08Ed/4g+7DIQrW3ZwzJQ6XwT1rj3v0t1fBjUTCZFVInZ3CM3NLBPFFxR3Z2Y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W78OR81F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E6aP8E003051
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7CdCQL72+wx7fzCdR3aCJ9NPHrR0L8HOD5RG5xmpUQc=; b=W78OR81FAQHK44rz
	bU9UuzuI5MFtyAHtAHZDOuBrxqcYjJgkFikU3BEOPAGu1yXMjL0mIfwoYjT15B/9
	yB/2UWZrtYgXl/arAa2i7OmJtXZ4ZdTmvfTv5bs7fpRoFkQtlgd7BhIw4eHg/aVW
	1VHhvbycrxc04AeK79gGUKjWHYQLQbLryuJ2tdjosz4B2/iHtZ+Rx93mDuqIWfBQ
	+I0FSz+utbXw2rkuyTPkf3CyftslPrKzB/1jIK9ane0DmINXNpCjvQbe4vrYczKq
	/MNBCX8mnPNRNrvskdfckj8kpnF+TCJw3xamnh9r3OuZGu2koDsqobp2/Lq0pkQm
	vOHJvg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0qn2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:06:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269939bfccbso109614015ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429204; x=1761034004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CdCQL72+wx7fzCdR3aCJ9NPHrR0L8HOD5RG5xmpUQc=;
        b=DKLMaGFtwVhYBxu6R4av9XGoCIhz35SNpGCI9Hs4YK7idpZ2uWmBjn2ZcMny2XPwio
         qYwS37WZ+sUmuIqr/j9p4Wjby28uxNIAQzo2NPiUn1NKiksODEDECrN+ftt6/k+vLW+a
         d1AS2i3FYo64iFw9ChShOURnSBmYV2lS1zEs7x0SgFV1c1FkljFSQDDB8FsdH6bhYcDZ
         qBkKwCY2bC6/GT7AxkrOPMrbUcD4OD2lWfTXMy3M2tXdWua1TsDIO6v2MeMsymFZLO51
         Hn1vXX142rnoQXqiZpy55laIi4BHTm7tWDKR/+F4eoZSA9yi/TOfBIebeio52SBX0ZHH
         1vKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtw1Ej/qETzlU3BEXcotqkMzXs4H0GmHKaqy0RCLTaM5v2r7Qbc74zMDRrT82lpnEt9y68Pf7h4Wp2jg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9j/5GjP24i8usJw4E22ti98oc7EmruvfchqpexcZesyPqrY4D
	qiudT6+ODpmjAV9dDynwz2ZOwYM85o1upeUcDIA6V66VDB7YYqe3w1YH09bGqhESifA2wcNMVjd
	nyd8UChQ/PSurEeYOfS3KUK5+MO8QiZaEpLUjLXY+7rpDRqrM+9cBBsFdrvDBrlDBo+o=
X-Gm-Gg: ASbGncsSYYB0LMcXI3vxWrl/Jz1KTYMJiQueiOy7NBc569W81Ct/bg5Sqp4DNFXf2tX
	EVBO1Ehqfy+4XpczYX1aArSnx80LOlURzjOVa34HzZ7ywRZJMfXkVkh876w6QD+yOAgfyQQSG6P
	UVmK7RXLT9RbAfVFimIitKIcAuaGoGb/t7Jplwu4WnyUh5qca7hVGczTYpny/LdbN1c6I4eUvEx
	HUOzstgDGuZGozMS8Y1uBaAOqQoustKldN9Y7De/LbrFiwiwhNgJt8iqtSy6+4Cy+3XUK7g61KY
	85RZdeUN31qqNrje2zi30QSfJJc5nRgSRUzO1Tm47WS5rp5YevAjMJr2usWB6viimipqlWX/
X-Received: by 2002:a17:902:e54f:b0:28d:18d3:46bd with SMTP id d9443c01a7336-2902740089cmr343944375ad.43.1760429204384;
        Tue, 14 Oct 2025 01:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhbY/rsBKCb8k0lEMtnnpbymoDmTuTFFchpcgnd6Bdy9Cz0O1GUjdLwC9fI+/RpmaJj9lk+Q==
X-Received: by 2002:a17:902:e54f:b0:28d:18d3:46bd with SMTP id d9443c01a7336-2902740089cmr343944095ad.43.1760429203912;
        Tue, 14 Oct 2025 01:06:43 -0700 (PDT)
Received: from [10.206.101.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1cbadsm156112245ad.33.2025.10.14.01.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:06:43 -0700 (PDT)
Message-ID: <415b48a9-73ca-3385-4c00-cef091627844@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 13:36:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/8] media: iris: port support for Qualcomm SC7280
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20251013-iris-sc7280-v3-0-f3bceb77a250@oss.qualcomm.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251013-iris-sc7280-v3-0-f3bceb77a250@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX0pt4txlcf/7p
 4avKGPmZSh8+oP1Sr/H4sT+L2tIXHBXLvcKleykL/VI1WiUN8RUleEqGD7xXNugnjFeBRn0/a6f
 NJmxuxQCn1tlBIpnTk1ishDfIiigpvvmr1RfTX5TJzPU3T5yksJkvZDa8eruN0AlMiZsK7ipDIY
 RXmcZajJ7DePxtXEB9e3HoMh/qUl5k7WLmNUeO5HenqgxbuIr0BWb0vg1y0WuIlU6ez2yhOxdZA
 7XTTxFyIAlqjk5yT690y+UKq7hLPxe/2SjIyNJsoHlIYE1LRJwqfppaCB0JSuxqOqjy1CHJFklJ
 WcNJ430Tj4luAjR9ad+m5UVqNpkrAkbxTLTLUcFIftDgD+HLZ7jvSRwez8+QCCeZNRwcpCOasTY
 n1wHwvTQOPIFA7epoQ+nxKlJc1XkWw==
X-Proofpoint-GUID: Nm0WZIEh9VOL3jio7ubtKxQoXt7TAHXF
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ee0495 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iCAh8AotBxNhkk2J9E4A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Nm0WZIEh9VOL3jio7ubtKxQoXt7TAHXF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018


On 10/13/2025 7:38 AM, Dmitry Baryshkov wrote:
> Port Support for the Qualcomm SC7280 aka QCM6490 aka QCS6490 platform
> from the existing venus driver to the newer Iris driver. The firmware on
> this platform uses the older, gen1 HFI, which puts it close to SM8250
> from both the hardware and interface point of view.
> 
> Test results:
> 
> $ ./fluster.py r -d GStreamer-H.264-V4L2-Gst1.0 -ts JVT-AVC_V1
> ...
> Ran 77/135 tests successfully               in 17.010 secs
> 
> $ ./fluster.py r -d GStreamer-H.265-V4L2-Gst1.0 -ts JCT-VC-HEVC_V1 -j 1
> 
> Only WPP_E_ericsson_MAIN_2 succeeds, this needs to be investigated later
> 
> After removing several test vectors and running single-threaded:
> $ ./fluster.py r -d GStreamer-VP9-V4L2-Gst1.0 -ts VP9-TEST-VECTORS -j 1
> Ran 219/292 tests successfully               in 134.749 secs
> 
> Disabled tests:
> 
>             "name": "vp90-2-18-resize.ivf",
>             "name": "vp90-2-21-resize_inter_1920x1080_5_1-2.webm",
>             "name": "vp90-2-21-resize_inter_1920x1080_5_3-4.webm",
>             "name": "vp90-2-21-resize_inter_1920x1080_7_1-2.webm",
>             "name": "vp90-2-21-resize_inter_1920x1080_7_3-4.webm",
>             "name": "vp90-2-21-resize_inter_320x180_5_1-2.webm",
>             "name": "vp90-2-21-resize_inter_320x180_5_3-4.webm",
>             "name": "vp90-2-21-resize_inter_320x180_7_1-2.webm",
>             "name": "vp90-2-21-resize_inter_320x180_7_3-4.webm",
>             "name": "vp90-2-21-resize_inter_640x360_5_1-2.webm",
>             "name": "vp90-2-21-resize_inter_640x360_5_3-4.webm",
>             "name": "vp90-2-21-resize_inter_640x360_7_1-2.webm",
>             "name": "vp90-2-21-resize_inter_640x360_7_3-4.webm",
> 

Encoder is failing with the changes, most probably due to #3 patchset. Look for
the comments in #3/8

Regards,
Vikash

