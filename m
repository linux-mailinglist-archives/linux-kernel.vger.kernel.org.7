Return-Path: <linux-kernel+bounces-757476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84345B1C297
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1B23A7A9D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F9728935E;
	Wed,  6 Aug 2025 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ksDURSDQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C720E6E2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470782; cv=none; b=pc+1p3M8np8pFzPJstpwtGqwmja8yP6ifeGoTs8aRrpuC7L6xQIsUYefCAJpK1bWaPQFoKDFcCxIm23iW7/CpAsSPT6sVzkIhItkZGtcYJ1Qfd2ieL1GSBsLQZofFlPjTmoqoPKLFJ9dXVqT26QPR62e/y5JUmRQWBFxqahNZn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470782; c=relaxed/simple;
	bh=q4t94x/anFdOrgcXsZYc5vYSpEuzz6zj7mjRs/IWGqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhgwXRfZH7+0zAINIBGJ9ya+aT16BS2ZySuOhbmpQITU+frGDQFl27g/6Eg3+/NggZOMaqKhTuQwzwJRrG006gi5V3MTQf0c8OpCO/rhI/xjvVP9eQ5PyoaHvR6Xg6qs07OcYMVjha45TK278wCpQsKjetzZao16bVX6qkDGqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ksDURSDQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766GkPf006708
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 08:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c9I/PRnvwO+XAYuNdl+hXvdMXnF4nGQyuJTKHNoBE+s=; b=ksDURSDQKWTiq7qX
	/VjuPogM6lDUZx4KB/rQ3ZuuzyFazP6W6oIvdTWEdvXbLcbciAnZ+yC0mkyvZmOv
	CjODee7bCnFWdEQ5cum5huQV4ROS4Epy0JIV5H6Tv3GsYrdd6ZccnMPZaimvuOud
	QTdQOMUrCvMf32S4K8BjBRaB64oWJ3cr6ehPaJ4DuYHKvaHFDig41u+Y5xSQSyy/
	QcjICPFmt1qKXOT5rJiZmGTwPg6cslzOpB1tSDgxptiTGakp6qOisi5WZMjpNoxP
	/GK9zkv5TosWv8tAr3SKifv0N4k+x5DeJQlCLwf0ZXyRtcxVIn9EQ1d/nH8CQj/V
	QPDzaw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8a0s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:59:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af1219f29bso4724511cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754470779; x=1755075579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9I/PRnvwO+XAYuNdl+hXvdMXnF4nGQyuJTKHNoBE+s=;
        b=A4AWiVeQuV/CxmAKIjcR5pC4PfHsIuE7ydLtUav0e4LlQNvg+Ep2QihWZgL51gkm4x
         0L1dT+CG6uIDRAtIsnYmE73xqa7w8CtrxvwzCw2KXkfo6RYdEjElIE3Mbx5WIc+k8qVg
         qvq93CxSUs9uMjTkqMzLwNyNdi4byFIoGnHdMBKE74JBBw29O3dtFio1MDEVoOzZUaT+
         TYmRDHawLsD3DmF3higIkK5Ut+wv9lgFWI+2TKKff5CVl6j0l9Z5uyCsGu4fqH+mojYD
         OX5hRRC2NyfWEPLc0CD30aGa/bt9d4cp9LU6CoeIhqHcVkI7h0ezolad+SLLTSTV5jm1
         1Yfw==
X-Forwarded-Encrypted: i=1; AJvYcCWECcNmcfCcdj2g5dkFokSQjCJMkDZhPsmfTlNNYy/MyXEtLUbWPMcEV14gXiYJvBVBBEnB9jzqthlciEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6B60J9H2tgizr6KCXfszzCPc4O1LAxNik+zQ1KLvgTdavJaPB
	klvdPsIscwX0J0rg84vpu2fVNQ4biCM0hY9KfwPbFtPrZ2P2ecXul+3TaYVB6zeZwM0vvrb7mrG
	BZ8gWQvGTdJTrYCCzNgKksWinkDMyQbqY7Hk65mXtcH0CVhGxOplEXvgu1MaHfPk6aPM=
X-Gm-Gg: ASbGncu0N6OySimI/ou1WwKoIa8iT+az2ynmeYzTJPIKSg8nT7G5xtbxAn9LeKxiu1H
	h+FL5c9vdgahOYIKK4gVMTtaK69wbXaeX4+NuGkYNK22Yh5O+cAlajcFmtKlkLpz8GcPp2wDbkf
	P9fQicKNLOh19viNIH7XQu7/3k+sBjexTYZoepdpyICb5/HIrBu9l0obJEAwaqWZesJKl6PTzE+
	JXsIIHzDu0rbK45miz0SpwLAzLx+QwDBjUHVwnTZafpQ21s9GYf8jHczQnrqP6nb2YWYrJHD/qN
	NmuvUPnAk859OyGPKLJov9YvfNc/9R3Qqomyeq/ikHUoP8r6XR4sBBZo8+P/jItQx04gIVX+n3V
	TlK+ip4fNc8vet/j/cg==
X-Received: by 2002:a05:622a:609:b0:4ae:6b49:4d7c with SMTP id d75a77b69052e-4b0915d25a2mr12806331cf.12.1754470778768;
        Wed, 06 Aug 2025 01:59:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdf6mYk0vm8CTUCUOiGdpuR4DjfOcWPVGZsk5L2Aq3igXFKb2AjbidwZTi756A4BnYvppCtg==
X-Received: by 2002:a05:622a:609:b0:4ae:6b49:4d7c with SMTP id d75a77b69052e-4b0915d25a2mr12806081cf.12.1754470778117;
        Wed, 06 Aug 2025 01:59:38 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a076620sm1052660566b.10.2025.08.06.01.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 01:59:37 -0700 (PDT)
Message-ID: <ecaf893a-0c47-466f-b8b7-54f9ad166b80@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 10:59:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] soc: qcom: ubwc: Add QCS8300 UBWC cfg
To: Yongxing Mou <quic_yongmou@quicinc.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250806-mdssdt_qcs8300-v6-0-dbc17a8b86af@quicinc.com>
 <20250806-mdssdt_qcs8300-v6-5-dbc17a8b86af@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250806-mdssdt_qcs8300-v6-5-dbc17a8b86af@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bPl1gtp-vJu8uVBmO-NRMCu9XTNQtV6-
X-Proofpoint-ORIG-GUID: bPl1gtp-vJu8uVBmO-NRMCu9XTNQtV6-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX5G42MCZJkwKv
 MorGD1a6jbDZhd+xUeKbns/7DmgI0c0o+HGuwDofvHpHEBdn/I9lSXrWG/kcJbc4Itsi/DYhwBm
 k83VrRRTiFdpu9KslIP8wKZ7QzdcX/NZN/jszCMlQnfnd3oQZ62V6pVCEsD7YiaDM0R/9PjRDSx
 V7G50hawsRRiz87VX1vEgKboy3Oof/JIGX9xOONujKFuSGj/Vyy+gxO/4MdZ08XIIzNiTg+cWTA
 q7rOtX0mdcMeO2aacmL54P4Vy9Fo/P0r6ex0Qc+xyftaVezQWdw4PA++Au0Pxrnm641csq4NJoy
 eOAY6rwaR66RyaapMAdZ0sMZ/y4T7qSLQYk9Q2Tr9zQge8roHf9y7ddRe4HpWGUDtnAsWRc4Hhh
 1xtWdYKO
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=6893197c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=qcYK-ZiiYIKsHLxbHAsA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/6/25 5:16 AM, Yongxing Mou wrote:
> The QCS8300 supports UBWC 4.0 and 4 channels LP5 memory interface. Use
> the SC8280XP as fallback for QCS8300 according to the specification.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

