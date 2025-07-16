Return-Path: <linux-kernel+bounces-733259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452BEB07237
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818095649C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D142F2346;
	Wed, 16 Jul 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K8G5rT3V"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDEB275860
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659638; cv=none; b=OJD8g1i4Ou5wXggFLBbxMSP2RLGDgfwMPtRYLIuAdEwyPMVNQpGbK5sEf5xo3/M89te/bVD90N07EeOjo0OsaEhFG5J3Nhfuw0rMbNGIvv7wr8puW7yNqLZ1r/9Wha90krUmlAueD4PTxqWxKPgDXwKjrvKWRnFzNSIXPjMB/fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659638; c=relaxed/simple;
	bh=IPPey8+CpGab2N5ogg1wT1lI6yYs8EVO5/Z23H9KTs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hv4zoUAQ+IypkI1VYtF1hGYSyA7rAL3dWJIRC8FIHZaOgqPEQMICsd9rq4RD7sVszjfWzOUFAhdG20Oj5RfsZ2bJZLQoxCW9C3eHySFBSGDlKYEwgH/peBp2t/rUz6kmMhIN+m5uKfFlbwGQASeXosmbMcTVs6xsB13Cywpm1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K8G5rT3V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G5qJkp023949
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BrRuWIrtJJsRpQld/wY76CeJGwT/OepkhOwph9UVdAc=; b=K8G5rT3VZqEf1Xsz
	L2slA5Scj2znACUJCnn1os3ea0JrtuofpHDS1HGmWV762DG14K0RBeW0OpHrlJG4
	/8zB7xOEFC6ER+rGOYjiFJX1NF5GTwCBe3ckDzwMxd7d2uiuXZ2ESduVj+NGZPsc
	kZygABe/78Kk3d3e1lkcIu+HLNpZhjcd9dsipjdP1HzyFGZsKk0AEjyhm9GvynDi
	zhK4bW6VQsRF350uyZ3MrOasq9Do3YON2XMkEd+7PHGRFxxoo+Do70eqbGyfjZ5e
	jIbooR/RsXlpQ+KkKhdFNJhuY2oY2PfGj7cjNoR1QUuOCoeLCESnryhNi31gfmTH
	DdbZtQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wkrum4b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:53:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a58580a76eso2631811cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752659634; x=1753264434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrRuWIrtJJsRpQld/wY76CeJGwT/OepkhOwph9UVdAc=;
        b=namLuvWiWxhRQlHLCuPJuCvqkT11XRRnrFRCW+GewfnkTRjOOBvywwYDwcsHn33AMR
         /zc0awsPigYjil8/mNwvNY2VSN1aOZZDR/AWV3haxfle1adBSYupgq76HYF62py3bZbH
         ZKOeKGinxcYLt4XcWpbqh3XfiZCae+h6+VxwfSvl9jKJojuXpvwRnM0Ns9SUthV5ePvq
         j6/lYIv4rXpgmlJRIFThpxy/5zRnoyiOUp9F8QqW6AMvtZ3oBAh0W8Tzd2FQEpcp5/pj
         HRzUb3pzrwe2nZrPjlUEmluKzUI+8HZ9AsMkJV7XhSu/eE16hZxIy0eIO7eys1b4aUn6
         5ryw==
X-Forwarded-Encrypted: i=1; AJvYcCUK0or4+Ya9j0d5SwTUyCfxXhfWen321sauke0fb3U4mzUulMtXtHWxY7naY36nA1TariaYS6bxwGiKHkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGPyIfb3l5lF95ed2Y05ZH00q1AHJdxYVCXKsFNsDIrIcb27f
	M/XzPEGdYjmN2gsQj8UmG6EZUnzSU2DUbxfwvT9vZRgXu/W/gXzKNR2t9f6oGGg3tNZZyS6hMz2
	ZJQ0E91l62xYZVDgsJ7yDTdLJcfdAW0Sa2jbGfRVWdu6/+jlsbjtOFNs5Qixf6J7X78Q=
X-Gm-Gg: ASbGncuxZ8QiB2VJX5t4Kx0C5a1NoEQDxnJI0oA1pfpaCL1ZI8+MyBlv5c1x7GrRHuk
	qKQe9sWO8R3dz6FmtZ8gbuwMLLDFSDwGo2IgE5O6wiKqPAernWEPRai3EQ51e4hopq1sK2m7tgR
	DMLZbqwObP2hAtQIXcAKMqUa/0lOkQpvL0dpX/RIqY+O8BAYfwknnCn4TWYQgfb7tM9DOPGYqbn
	qtkqR5uoVTfgSCcU5kEKer3agP6tkVNvaH47ic7v3VUmyHcvxry8IwhtFpdVA5a6zygn0Adn3ma
	uV2dGylEg9YS9D5SVJHE5RmAIv2Gfd0P9IoI/OiwNLS57SqmlpYbgHe5JbTTOOGK8qFcL9YB96Q
	5YkFQamVS4ysoGZ26JrsE
X-Received: by 2002:a05:620a:2949:b0:7c5:8f36:fbeb with SMTP id af79cd13be357-7e342b5cf66mr131696385a.12.1752659634369;
        Wed, 16 Jul 2025 02:53:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkLEZzcnbHfPM3SUr928KwExQhJl+kNQoZGqThwXwhpNJlenla0nHYpg95UHWVYUVk0gHrQw==
X-Received: by 2002:a05:620a:2949:b0:7c5:8f36:fbeb with SMTP id af79cd13be357-7e342b5cf66mr131695185a.12.1752659633784;
        Wed, 16 Jul 2025 02:53:53 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82669cfsm1147729066b.83.2025.07.16.02.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 02:53:53 -0700 (PDT)
Message-ID: <273b7fd1-2554-4466-baeb-792fd7967209@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 11:53:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: correct dpu_plane_virtual_atomic_check()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20250715-msm-fix-virt-atomic-check-v1-1-9bab02c9f952@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250715-msm-fix-virt-atomic-check-v1-1-9bab02c9f952@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7USUJwziFxK6_hrIVe0Je5IFpRQY6lVY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA4OCBTYWx0ZWRfX0DKEG4LG6kxx
 ftLMszCM9uzCp5k/8xpoQvAxlDmOQv8j5T/3U2Umm32LikgiiSWVsLPUdF7X00jZC7Zr5Uoz4l4
 3UEfQuBdniw7Q6FKukgRxBJTqBDRJ5HkS6O/RSyshPAbsO5K5Gv1cNkSeB6b9h5suIbYvuoSw3A
 CYawtEEjwLhpKfw7+HyT7n4I9skYK5rnxa1vbQse0wIOpJ5HV4C6IrI/GWpVzoG7qhvFMrifC3Q
 xgv1Ffp+8I+3HgBIaeue2TamwLui29XNPZdRbtxwsdx8EOY6TyETIbkWnQQ3W5QkkJKPTwWpdE1
 feG+vzF0eTETDV4gzvtsW+OJWjb0rD60KeFZVVsjTacJjsoW8SitR4eJXAvMtsJlfvRSESJMavP
 O++69eQ6VJiavt/ShxhKUu7cglSV3DmgM7y3uGc58Lly4LwoFhJO5DFiwrHC0qVtCORS3JNc
X-Authority-Analysis: v=2.4 cv=WqUrMcfv c=1 sm=1 tr=0 ts=687776b3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=GHZGt2_Oay3Cuwp2bz4A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 7USUJwziFxK6_hrIVe0Je5IFpRQY6lVY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=533 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160088

On 7/15/25 7:28 PM, Dmitry Baryshkov wrote:
> Fix c&p error in dpu_plane_virtual_atomic_check(), compare CRTC width
> too, in addition to CRTC height.
> 
> Fixes: 8c62a31607f6 ("drm/msm/dpu: allow using two SSPP blocks for a single plane")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507150432.U0cALR6W-lkp@intel.com/
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

