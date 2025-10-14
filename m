Return-Path: <linux-kernel+bounces-852569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1224BD957B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 323AE354272
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D324C85;
	Tue, 14 Oct 2025 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jJ17PiJS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FC241C72
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445079; cv=none; b=N8qX4GGTLf1hmMiy9ILhCYXwBSIRmBZVzQQQQRza5MxoPmqxX1SvKywDqN0eoYq/ONNOVnWuPg/4EdNRLK7TQq0VH/j0Da05Mg83GYcCnF2sc9RN31fNsG3/+Ldh5E5JoRp693sIgsqM3zXOmLv3ejsMV1HyNq5jEI0W2q+kWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445079; c=relaxed/simple;
	bh=TKC6A17tydWDC94IwMFkA9hnSrTjZmAGq8YUv4bHuWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeXEaQDhZfV4FYY0K7nPUR7WsJOQb++yxNNZnIGkByxDxU3NYeC3SuTmVcx5ndfGfJkDVx0M9Chg7K3HAaRYlIirvA3l0Ds7dJ6v9+fqAID1uDNGCft0yPqu2B3lOz2wXvulo+enInM4rDaTs2dgIt1lQydRyAFL2zhcyv1OnSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jJ17PiJS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87LPl008659
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ID2HJsJjmIngtB20ldfJiYb99xBQYJlyyVG2gHKSJJI=; b=jJ17PiJSuBQ8dVQl
	xg4qUWAegEIlqeWHWI6uogEggRvOYUOL98bF2Q2wmf5ZpymZieWrhvzG2KyE1fCe
	ZoRdaQd79T4kB9h2Wxe7LOfhq8upL/azQIBBt01p+7dr1bCwzfk8pju0VV3O/lnm
	d4F9TV9/ybycVMCTt6P4tvBLtIwVwIe3Nuwg5zk0AlCVeSBStPfRXW/WlBzAwftX
	crCZWDEfbJqHyGbvzyuapEIPIuUiDhIK7SgYZoE5ohuz7aBupRR3vVKn4FtSEOS5
	aztb7LfZceVoCPjkohlZ6M1dAgxYA2fF3Srl2b1yEymwKqXW/Wk/djC0cu9cW8uI
	j2vKYA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt59g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:31:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8572f379832so243483685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445075; x=1761049875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ID2HJsJjmIngtB20ldfJiYb99xBQYJlyyVG2gHKSJJI=;
        b=oVvig2/gPug6vgJU2O1oNBXRFSxGsGnXBTlhfQ4RVK3CK9pQ4lYH/W6+T6IilkmlVB
         GMr134ijvbzdgV74AF5WeGZqvlxOVCavYVZ3AeDUzAgMvKtJnZb2g+NB7ZKQQKsyCLEH
         Pb3gcpQJHyvrZh8CvqXrBFA3sLCSUdshq0KGkKCA1nMv5XY1zBzjui6S+YnCZYlHnOhu
         LE6r8UVnVjOSRBOzZDC66xxtQn7yaLTjYvA1wWXU0RkxBVcsMwIXZeOKmf6dJSo2ztU+
         NNAO6RPy/Cg7VzhFmYw4eS9t4Jbfju8XZFGpjlP7/mdhrNSpWl2YTvO8kUocaQIwUo0Y
         5XyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvTPkRvNpb7DjZs7lVILmD3WLQ48BxngxkUxuFA8FMz/pKk27ebudHuz/X0QeI9/W7bexTmPYh5M4iusA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0sQs5e6uwKKn7gx89nHq9WYCzszPLq8GLCum+JXqMByQ0b4M
	C2lWkNiwYRq1/1OTv7kwdN3n2IHlyjsZSuhJ8vXphC6KV4fBYfcSgxbWpTqCza8YaNUhPC/Lb2p
	pSgotgUeN2RdbnVRzVvc7Wr8yCtJG7wCetMgOUzAAKrpuGxF4ItYyfIuTBAfZjoZTg+K57kfJ3y
	U=
X-Gm-Gg: ASbGnctomytt6bPIlQB5CvDtSpfCuZ8UmEt+6lTnmcB65LBchiuPKfBEXgJILPWyeCn
	QlXmYSLhAR2m2MnDXWprzfgHQwjq/9Xt929AKsJLVzQttxBVL3ATFdtAQOrfwQRwRNNwXiMzTos
	4jf1A4bSI6a3P8GBSLFdpiEkjhFjEvI97aaCZz+PPDBXKh9qPNVt9Lxrz5eNMqE7XnqaoDbWH1W
	mgqjIz/q2zMeUl13S00xa0lDucs7ah3z6karE084+6SWclxNvRL+WvUA7PCA47pV0A5afpe1jmj
	6AzcqSpHkhT1LY+P8z5Rew/7v4FcYTjUdXb+9K0Q1TBZHL/ZfDc0jI8WNNk5LwVToiWLgw6Fa4N
	UFqPee08aw+5WV0ly6Syqmg==
X-Received: by 2002:a05:622a:8f0f:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4e6eaff3f88mr165143631cf.4.1760445075141;
        Tue, 14 Oct 2025 05:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+j4D2FNO9vuOjT1YgWIBgUGvxk/FKtuOcXceOGc4py6Qj9TBJaMty1wCNCO5mmpGa1FyaIQ==
X-Received: by 2002:a05:622a:8f0f:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4e6eaff3f88mr165143241cf.4.1760445074624;
        Tue, 14 Oct 2025 05:31:14 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm1135306266b.38.2025.10.14.05.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 05:31:13 -0700 (PDT)
Message-ID: <87af3cf9-7eb1-44f8-853c-d6bf973040c1@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 14:31:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable configs for Fairphone 3, 4, 5
 smartphones
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251014-arm64-defconfig-fp345-v1-1-53fe1eeb598d@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014-arm64-defconfig-fp345-v1-1-53fe1eeb598d@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JXSHc1LYMlENu4dEghoOvRA7PvmllVTA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX1cJOhtCM6VEg
 GlccY/CcUQvrVViwbDv2Ch19i4b6O2tzMmQT5tFXKAlELtRUtxWS0PaOyrc+htpljZzZczOWgr5
 KcZ/e7djhPaV5YlEUDBj+sv8tNc584pPsg3dlvEQXjP6ohSYKfs1B3slv8A8suutie6bpffTYpc
 P6LF5qDrcC09ymbkkQUu6FdfsDN3VrMfgnUAZV6qAgodhM7KDy26INTCtbyfPx+oamhq57OHWRP
 y5T1SJ8kC4xn2S3dbeq8Z7zjNfKsvl+dwyN2iiUTmkV+Tvdeq4a/G3jh1nUQ0AFsjeu5Gq3WKsz
 kYh+acY1rcqv39xWB6N1jckCW03UFWMPs6QXUiB/bkXjhQzBo5mgOEzOOjWWAXE7LXMnub9vj7p
 swJrbccTJRltMtVG89hSNVOHwGg9Jw==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ee4294 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=AqWm8137HdW1rLVHM9EA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: JXSHc1LYMlENu4dEghoOvRA7PvmllVTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

On 10/14/25 2:11 PM, Luca Weiss wrote:
> Enable base options for MSM8953 and SM6350 SoCs and device-specific
> options which are used on the Fairphone 3, Fairphone 4 and Fairphone 5.
> 

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

