Return-Path: <linux-kernel+bounces-798133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8829EB419DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0685622F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7512EFDB5;
	Wed,  3 Sep 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VsczgInH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B892F0666
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891557; cv=none; b=KOxihIy0ejuvtkJm9awaP19AoaU4C9MHvSUsH3EQKhtdifm8IUapFFXXZ775YaPUweXTTJ0qw5W5Cct/zRZJLW4GsBCZ0gOPqGueGzY+Y4aTTh6vOJ0ZhPeipM0+339KgA00lsn2g/V32dKAWHLsEe68iJ82PAexFNb+I5Fz/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891557; c=relaxed/simple;
	bh=tQi2QB0QE+ylzKAWeOhCAaWxxpDIYV9un1Qgsckd9hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ae+K44rFWlml5w5P9mvXXVGVYK1UGz9taFe748UuexXE/vT0CWiinMTfM67NWw8IA3YPq3293kL2THpP4soAA+ol2iynYISZ5d32spGgIqcE4DcKPaxAdURnfmHabeGU0ILYtCjRzO4ANfL+XQVUvUJ+Z6Xi+jtBmNCbnDVtZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VsczgInH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5831vc2O021832
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 09:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V8xcTnmvm8vaCs5GzeHhTc9j2HG7qNwDmT3oTLQQlSE=; b=VsczgInHphxWEvck
	od5TCtrl9ghVLbLTHWdb0twQmaBhz6ybE47LtAXoOdfY9++I8DJYxKsiud5Xn55O
	vfkjfXP7jf/+n9Q6rxnluj9I9cPujwDFDSC0Pr171/rktCL7xfvGMvZpEUv/qEyo
	6Lh6EcvbFpcbMqwoCfAJRc8kPR22oA2yUuu9MYDEwZ8f90Py1i3848QbbqgrXSF/
	QjcPKVSflYpDj++vKFOvi467eEmg2eoISAXepz9skJQrqWPgB4+pLHDTLqQecBuL
	fYY4Ha8IpO7bvph/u9CawZB0Z9dbRZaG0m97e6Y77SVYnikut8A7jZ3m9sORz9FJ
	ISXUSA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s33gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:25:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b307e1bef2so17002861cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891554; x=1757496354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8xcTnmvm8vaCs5GzeHhTc9j2HG7qNwDmT3oTLQQlSE=;
        b=XUh7Jo3I/ql1H/kjVKqZyYg7fu2SwVMdudYHhwC79j3VLF2QhEBfKaWU+2AmSkroNe
         /f5nGsY+qIgCU6DZglR1vKDKgmPxS8LGRCt9sQWYwdbmcgIBNvWsHp5dRIrOb8DOPozl
         uvuGSXN6YfY96bG6dOvOi8+8sPtdAe7I2JBrdSj6xJkzKeoYjAt6vSL2VAGhA7gG4l43
         efcWWJO5AiqxVwxU5xrEqFJCum/xj3Zr+jVRGaO641i7cm4eRdxlkI3bgPQ3SwCV7PWR
         FQgkANHD1yD1uH5iGrKH8UFheuPpqlwquzj24IFbitJY5FajVWqduATW1xfvMMciUypK
         muaw==
X-Forwarded-Encrypted: i=1; AJvYcCVXUs8ViCmsBQK7KyElt15JkIJ7PYHaeMNBpLa/ZDb0GPHiL7PwzVwZymkOzT0mOfkLrHfaYRJx1jp6ARA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvC6T24JCl0aZG8VPWQYDWieGkMfG69D9vHmRrimKNqLsFSjU
	/zqYT7b96eL2hnUPo7jo7e0fRFKRLq54gQz8ifGJyAbQoPcIVFrlO0FIOvdLaM/gel14wxOURBd
	ShhON7ZSXoiWR7lvN/Qn9US16XdzOUKvMi4U+IGx6gbezzBSPcZPR7irJLd+aur9XtQ3E28lGpE
	k=
X-Gm-Gg: ASbGnctpwdERy3cc/wrAuXqbeMoMbSugG+HG298dovVquzyyRZ9BtNE+RUO9TCweNb5
	W8LAADnNeagKfxhOq3E5KVzLyVgNXZVbwwwGE8N3sRjytRcX8SPjYC2XhnEaXNc0DA3HPAbWDH4
	n9k+fDoT+kp05tYqIVGe3M8qOVnh/lmG08pt7YWDb4hhQj4iLQbujqmRS+xBorit0KCtx2FpmMQ
	rOuVp0oaGZwDtDRXVGEKlA1DVDXWpf0qihF4aMXQEFqbVzpbngsp99mIoMy5x9VpREYKwMhq8C6
	e02GSwXz1KmI2MqYzK45LsGXX8H9jSbBzwdzE4xnWW6nANtmfOIpf+q+0msT0dm2RVWH7Ob2Qg/
	mW0ouXx4nKIksSdEYqnSgaQ==
X-Received: by 2002:a05:622a:15d4:b0:4b2:d8e5:b6e3 with SMTP id d75a77b69052e-4b313dfd74dmr139717881cf.1.1756891553762;
        Wed, 03 Sep 2025 02:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtzVlVNKODIar3OKV1Dpdt4jlT/5/HUDsUa/mjebH6AoF7OB+QsQV0PuV0R4ZhtiSsPcI5mg==
X-Received: by 2002:a05:622a:15d4:b0:4b2:d8e5:b6e3 with SMTP id d75a77b69052e-4b313dfd74dmr139717631cf.1.1756891553148;
        Wed, 03 Sep 2025 02:25:53 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046af12536sm102654566b.100.2025.09.03.02.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:25:52 -0700 (PDT)
Message-ID: <b7a1b89b-54dd-4d02-afcd-0144df5a6d57@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 11:25:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/msm/adreno: Add a modparam to skip GPU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek
 <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com>
 <20250902-assorted-sept-1-v1-3-f3ec9baed513@oss.qualcomm.com>
 <a701e4f9-57b7-46cc-b42f-f1a4a902fbbb@oss.qualcomm.com>
 <zmaphb3douzah5m447naluu7cjrwieb36uznjb7uamblxduira@xhtklqmy22tu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <zmaphb3douzah5m447naluu7cjrwieb36uznjb7uamblxduira@xhtklqmy22tu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX3DdXVQJpM+vc
 5rPZ54LAZZwp7DKszb6nWtYTsdWU6x1Y4F/Otb0VsNhETKxox+dn3t7p0FN4H9AOdYnFwYCycT1
 +mISrwm2dnCBqlLFdsS3hpd+kjxm2mFjLf0XJ2xuyAB7kqnQjQ+S2Whx35GgdREy1K+geSiw/rg
 IhboMHgGN5VpIb0KzJeyULLHApcB/A94hRBj851v7MgpmKNY0xyI87oZH8CXCSeIhCPnG96S1h6
 pe8GQK/gDMy7p/owbM/gwmiH5tnW8jy0cYpjR166psS/Q159hOqYxIcaCpkIxWDGlOTw9FMmV3W
 qHdAtga0oBZY0frrMsTx+AAXUFhS5AWvaTRNuyi0+B5b2w4ug0Nmt9uC2lw42SHMx0XHroeVIe+
 6SAnnKrB
X-Proofpoint-GUID: yVKTZzNGhOdAvi8jT8a04M8ml7V_rqbd
X-Proofpoint-ORIG-GUID: yVKTZzNGhOdAvi8jT8a04M8ml7V_rqbd
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b809a3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=q_ebNChVWJ_O0X_IP0EA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 9/2/25 3:02 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 02, 2025 at 02:30:48PM +0200, Konrad Dybcio wrote:
>> On 9/2/25 1:50 PM, Akhil P Oommen wrote:
>>> During bringup of a new GPU support, it is convenient to have knob to
>>> quickly disable GPU, but keep the display support. This helps to
>>> fallback to 'kms_swrast' in case of bootup issues due to GPU. Add a
>>> modparam to support this.
>>
>> I'm not entirely opposed, but slapping a // in front of the compatible
>> in the dt works just as well
> 
> Which requires rebuilding and reprovisioning

Fair

Konrad

