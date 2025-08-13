Return-Path: <linux-kernel+bounces-765980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 517BEB240C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3B6726EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A19FF4FA;
	Wed, 13 Aug 2025 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iaheEKzP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500532BEFF9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064544; cv=none; b=VT7CcF0xQryNWBYTlZS7qCthr6ZZQNs+j4tSnQvYGQcJrshzKTUpQf4HmxEG7KuZPU6xfPw/xJp2MijnuB2X15LziUpAI9fXhGcS+sJ4El2MLgEuMYRX5U+gEk2EUX5zqjM1GWoBysWbphHvvTJXO4/AGLO6YOqadZKvNGZFiMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064544; c=relaxed/simple;
	bh=3+UCjNp2P71sZESLCJbR548hn2AjfdJICXkD9Womauo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDUfxNR3djbwJZkmYPE10S+MB50FyDjeLRZpGlEXFzb/Xoxn4NB1+rLgaDDKzDzNeNRhaRzRQRyP+JMGpk2s07/OhzVajcDA+/fnG4yp8Y29bxKYWtDx5+7wDvF50RpRVYxBB+iJji41LiVvVgWXfleTLm0oJGcnXt67Nzjdqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iaheEKzP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D3nXIS006736
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3KHpx4xczwyhMGyk6W3OmOsK7r2nQtCAjXkX3DDdjW4=; b=iaheEKzP4zWC+epU
	VC6Wu0l3O5LUjPqmaHAiXiztUZF0i/NBaRlsEJzvvLvS1Cb7y5FeWt4LVLZ20fh/
	kKBhTFlIGLQLbzkKqrqYgR72GBFW+jxwsaHQ3XG799rVXT3tRa8vSeSf6ZmAWnuU
	FV8f0aVh1OBM/J4G1KGaPCP9NtwayK/B0uW4nlKoe9f10vnxZvssKTKq4Vd5uwlm
	EvpnRBeco+YFDLhDAe11i2JHtjHGH4sJ08FDgqMW17qf/4L3pmM2Do6/Fo7g3Qi7
	m0gsUuyLnoxNMmt/n/Ta2HXTii5YYHhRG8mGeyQHsKZtQnC5vXLcLpFKz0qEQSFZ
	qBcnRg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9sprg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:55:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31f2dd307d4so6333462a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 22:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755064542; x=1755669342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KHpx4xczwyhMGyk6W3OmOsK7r2nQtCAjXkX3DDdjW4=;
        b=NrhR9EMhroz290CXZyaZjgeuKcYAy96nK3bd5ql4j9xT7CCdJyIGFLBoRj6xnfQFbI
         dKadzLLdgdBvfYigYxOAMqDGNh2o0NJayi8NDeQcx7opTYLyndTMwg/VgHifJiKzQV2C
         QKoj47oncxi0oZnFDZQ25BUH2ayEGW6At8iejCPuorOFPO7/BvmiJJH/p07jDmu/9tGq
         0f7ypAHaBU0jpcFozVfN40ie3Mm/CPrl7cObu8eb4AHVh6jEWQdfsAfrRAbPSB8GQM/t
         Z2sx+T9NmoYJY4XnOmb9mqCvE/ABkaGodCgfhmaNl6Bu9CyVnP4S5VbzyQWVdPIofSEs
         L9zA==
X-Forwarded-Encrypted: i=1; AJvYcCV6cxWKKoMXTDpRyhn8K3L2Nv3F+rMetcuvdbwkeHd233FNle/fh8KJTMlvD0Bv4DjdAr4brxmfSp0EXqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmgvKvSkmAVIuS1pSMGJM2dX/mEtTZgD+iPs3DCm1h5fmq09u
	sPPnj0AcJTSkqM7tj6Wnqd5yk6CCszMlUynbKCC3wSI4sKJuuAhcF5f9C34IJ6UljaH1bVkxcK6
	wLtHzM89c3QZfAxhGiUOLPJXlgZNlrmpld2LIfRjFbKFBb0XgGJyJbFtpQ8vEH3TZZ/U=
X-Gm-Gg: ASbGncskxbcBlpLXW7OS4tXObH31x7nEka4UCW8oXkzDUkDdWoNmCt28HM/iH92Tq66
	0UN95zLmZc6RJzHRT7kfueYoaWXrP3MvcA3qC28yxNUBcW3AHGpaHI/dgT5Fk+mIxNvL/8N6j9s
	lGzeaCaKTso3f9k3R63BemD5+lTr+CvrtTo6aKzKaG8/NYwV4EaqTQIptJ3mA4tA/pmzVEuYSpl
	i/8vRaR67f3Dxzq1w9D/bf6j67R8Y35tlJkgADSecz5qV1bv+Fs99JHz1Ejw68GYC4+4vbZJhYZ
	0An/WyOE1Mqv/QaFRN2ryJPJIAkyAme+VhDkkZcSxiaP8LCd9kmEJwqwWcLgYcrQX+HJYp8=
X-Received: by 2002:a17:902:dace:b0:240:3e40:43b8 with SMTP id d9443c01a7336-2430d238147mr29979415ad.53.1755064541632;
        Tue, 12 Aug 2025 22:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjeZLj43GZgvnhVo3O62NOP4Bml3NVZ5MjTOxx/SHNJD2XfpLuuuU0j95oZyQKtcn4cXkmyA==
X-Received: by 2002:a17:902:dace:b0:240:3e40:43b8 with SMTP id d9443c01a7336-2430d238147mr29979135ad.53.1755064541187;
        Tue, 12 Aug 2025 22:55:41 -0700 (PDT)
Received: from [192.168.1.7] ([223.230.83.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef48fbsm316527015ad.36.2025.08.12.22.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 22:55:40 -0700 (PDT)
Message-ID: <28b97952-1b67-411f-a7fb-ddd558739839@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 11:25:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: add clocks property to
 enable QoS on sa8775p
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-2-odelu.kukatla@oss.qualcomm.com>
 <90b51e31-3217-4483-bb5b-ec328665a723@kernel.org>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <90b51e31-3217-4483-bb5b-ec328665a723@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689c28de cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=SiMmawhtwnuHYgKqZ0PRSA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=_8-003QpdazN-62OuQ4A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: lmPz04zF5xgPhFLVdYBG4a7pQONHVHAz
X-Proofpoint-ORIG-GUID: lmPz04zF5xgPhFLVdYBG4a7pQONHVHAz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX3kubKhRwoPmN
 GkOsvqgGECjwYuk+RwZ1PSorlSWnK0t/DU/ieQ2/HferkxLzHGl8ar1Elc8wzvZfpjAGAtL9Us9
 YcBd1HhqYZGHFiq1HKJKh0EaWTfySPQVAARL1Jp2a7UYffEmLRpxIEe00DgnVQ6af+eyfgT5ZRQ
 n2FvAINnmzT2zJZJtITGPgz7AQiKdz40tw0tejrg6naNFWvqvlI+69j5I8AMbkykj+Wgozp01oS
 4GpxvnH3NVnymHr4KmGCE1Ih8DNoKRtmxqImcgNU+OSnxUW3clTXEG+KnOiZY+AZ0Zcx8jNEx8V
 +Rnmg9Ywgaj5wJvtz2bOFM2cZ02HAvThJD1CQZgTV0Qg++wxt+Iw3Kx6R8B9b0diHolDtrbIz9n
 hOUvh/nV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164



On 8/12/2025 3:47 PM, Krzysztof Kozlowski wrote:
> On 08/08/2025 16:02, Odelu Kukatla wrote:
>> Add reg and clocks properties to enable the clocks required
>> for accessing QoS configuration.
> 
> 
> Nothing here explains why EXISTING hardware is being changed. I also
> remember big discussions and big confusing patches regarding sa8775p
> (its rename, dropping/changing all providers), and this patch feels like
> pieces of it without proper justification.
> 
Thanks for the review.
I have added description in cover letter, i will add here as well in next revision.> And this is hidden ABI break, no justification, no mentioning either.
> Again we are discussing basics of ABI breaking patches?
> 
If you are talking ABI break if we load old DT which may lead to crash, we have .qos_requires_clocks flag which takes care of skipping QoS if required clocks are not enabled.we have addressed this issue through https://lore.kernel.org/all/20240704125515.22194-1-quic_okukatla@quicinc.com/ 

> Best regards,
> Krzysztof

Thanks,
Odelu

