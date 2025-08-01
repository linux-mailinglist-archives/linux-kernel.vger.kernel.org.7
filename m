Return-Path: <linux-kernel+bounces-753223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DEDB1803D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0FFA80ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26402239E69;
	Fri,  1 Aug 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eNKtvjkd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341982356C6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754044295; cv=none; b=E3/q2dZNglL7gjHbWzI3Pdmq9WIkIQU7IO2yhHEIL96Fai5hJYSWwqVhcaEuPBcukBYlFX3Dqyy2sEmw3udBvpNH+Z2Bn8Y8gR5zfKmR0KqRBWeCcAqa6OstSYAA4434BEVqw/ULkaRsr2IK7SOXBee4ik0ILLCUfnluy++NQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754044295; c=relaxed/simple;
	bh=PTbICM3KD1c/dD+m/u0pUtSXhH+t/xx6pVlt+7dCQ0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkE0FAH75EHAavFyuIb5IWwhh//UWMhJB+r40bYq4gBpgdvAH4yaQO1YXGnANUjOTJTqqtfHgp8fB4GJsQUZhI7ol8Ty3CRByBj00Rw5jzezuDARZWaqhHBqfuDpuTjoPLXNhbEwdbnDmPty+ZUrmkf/s3/ZrqNRsnf8w1uy1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eNKtvjkd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719BYvL005014
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 10:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iAOI0lIToQBsUNmMs7cWc7T3lg4pZZarBoVCwRquAEs=; b=eNKtvjkdSEG8Njxt
	42CIm+sYEB4KP7xN5xai1SgDtQAmT/OzYvG6B+xgcZ2Y6LGLfqil2uKir/hXVRx5
	/bvmZ5SW8mqJYWh6DkKqTx7r19qzocersKz9Daw/gSgpmdjdwzxl5OQmLdZKUHGf
	u/RydiUfEXkHinCUS1bdR9msnhPRwXE9fnToeIsIrXQN2K7GqmWBYuylksWcmPhY
	X6oHWwjYfHuR+T90eUHh2+aP/Bt2GlOeT/TuP8SjAu2uqv7XHCaZE3bDSLkPYNmm
	0rKzVbZok6spl9ZpjvJ8ubGXdLSe0rGkKxkb/pZC07z8f0V4DJK59HkGg22vb8Rh
	Xd7gHw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q86btkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:31:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4aef8afd26bso3799131cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 03:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754044292; x=1754649092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAOI0lIToQBsUNmMs7cWc7T3lg4pZZarBoVCwRquAEs=;
        b=qh0TejGQBaM1Z7JxOW3vRXzo9JQH1ryd5USWTDSykGx6XrdBkxSUo4ewnBFTkMabDg
         ppeSi52TdG8fsVDk1+lIQJJLmEzgSgVmfQK85D44oyRecitHFtWuPBm5j7zS89I3z8cy
         56CNJaJRXdRSAEiCOuV1tt31dFTK3QAYAzpOmqJOazWJFqNTcexCMgGynKoV8dKL+R5E
         7xqNj4XqrkgKmQFxXEVQYHb8jbmCdCI7jX865z4Q5qo42zSomdanrOZOKb0F8oTCwdGN
         Bt9m/7vGTR+91lSFYqzlCl1GxzlDnbdGinj50YwBaUBv/jomrbCb15QWNfC65lpwSazn
         9VJw==
X-Forwarded-Encrypted: i=1; AJvYcCXCJ+7qJ6Zzysz+tWeka4gFk0WlO8wsuKYxgTAix8ILnqzGv36ANGm6W6B7TqczwL3+TzgLHpZChHMLkPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuK6LxarPKwsdmRL0626AQdy5G4yHxyliZ98f9UK7FkBTBBQpY
	vi4gitJTkwpEHzK2UZclvis/SDem+8+c8tu7SZERh+H1YWdaKXPHHtK3jq3wvWkgvww7pLunkqP
	4H+/R/UhwixU/adtKpAwlbW+1KwaUjCUm23Epx+RLDaIfZxE+VtZ9f1rDzpPcd95dqQo=
X-Gm-Gg: ASbGnctngpMqy9orYKU0O98tOXum9KvfjusAY9VeO5Ghb2Onl5ZI8V9QU03n4rLnTuB
	9s97/ldRoDSMQ9HnwnaXSdkbE/9uyL/VYexzXh7atQvLd2/hDu5ut9L5SfHeJfO4o7q1jyaGMMb
	RYIKtLdo16cz24DAx8v105YtGgaL+/Z3504q9Zq3URp4Y+SvxdVqxip6lXHpk5kmjrOtSYvgxtj
	WXOnEEBi+bSYCbVgjWN2uoIb49BcRkvgV6gfchIaw/YFeImiU6uz4owyx9jV766vxbfOTHO0XHH
	iy7BLudrwK1a64jk0et01IPEJzHW5+QtOfhfzNvXKuCnVbXPzEij76ecbbTerxWTpHWQMb87sWF
	JxRsa+axGJJ/zMsdx3g==
X-Received: by 2002:a05:622a:199d:b0:4a9:7fc9:d20d with SMTP id d75a77b69052e-4aedb96542amr77804251cf.5.1754044291334;
        Fri, 01 Aug 2025 03:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMBGkw0kJFBAVj6S3Vh+cLP8EoE+iTjRUAr+2UL7FVHEhgI/GeG8+ip/Jd2M6IsRnvbxbPiQ==
X-Received: by 2002:a05:622a:199d:b0:4a9:7fc9:d20d with SMTP id d75a77b69052e-4aedb96542amr77804021cf.5.1754044290720;
        Fri, 01 Aug 2025 03:31:30 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af919e96050sm267725666b.0.2025.08.01.03.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 03:31:30 -0700 (PDT)
Message-ID: <bceeb55c-daaf-411f-8bf9-9f2dd06527c7@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 12:31:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sdm845-oneplus: Deduplicate
 shared entries
To: Krzysztof Kozlowski <krzk@kernel.org>, david@ixit.cz,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250801-sdm845-msmid-v2-0-9f44d125ee44@ixit.cz>
 <20250801-sdm845-msmid-v2-2-9f44d125ee44@ixit.cz>
 <a51a9efb-67b1-4607-bcf3-8be70a9d1c24@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a51a9efb-67b1-4607-bcf3-8be70a9d1c24@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3NyBTYWx0ZWRfX3ncvjRvO58lg
 gcemfC2in3R51t0D0veKUL8xe8aAS2LLSKSRijyUfdsdbku27k+7MHd9YDaOhCvXIz7pos/I/1V
 DoK6dV573b8wB1yF8zpZRWpnJKG+USIRUkcrfGVd5Xhb7g7QgwCNDisYLpofJhnA//BCmvWkVUj
 9sHkxDpk+tJwZzG+fGSx7DFzUyrM9bwMLux00CO5LbvN+RuyX3c9gGJDDcZAqt7eF97a8OcDO4f
 ocx5YqA+H9iQ9JeW+V21EcskjtWMtHTcZ43A47hl5ILkLwHgyyXfw35pNnXgZY0FbgXe2OwBuHB
 hr5b9KIx91mct3E0Y1TxZ6gGODI22Q8z9aB/s8eDfvKWuO3EPl3nxGR+nF3iw3GhIvg+dTRpVQv
 vAVOd9QbDc5oNK5MtJnb2xLIpkOaUcwVrwdWpL325llu0/4fNUr+dsCQ+ovPU3I1knpqJBPg
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=688c9785 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gv1wxAXu273yGl5PTI0A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: fy83v5-Z48pXKYOy632DLN5LYW5bMU9B
X-Proofpoint-GUID: fy83v5-Z48pXKYOy632DLN5LYW5bMU9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=634 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010077

On 8/1/25 11:08 AM, Krzysztof Kozlowski wrote:
> On 01/08/2025 10:21, David Heidelberg via B4 Relay wrote:
>> From: David Heidelberg <david@ixit.cz>
>>
>> Use the definition for qcom,msm-id and put them into the common dtsi.
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> Interesting that they use same ID...

msm-id is the SoC identifier

Konrad

