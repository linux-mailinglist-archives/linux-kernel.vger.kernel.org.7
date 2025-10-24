Return-Path: <linux-kernel+bounces-868363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3BC050B0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82E264FA241
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBBB3054EA;
	Fri, 24 Oct 2025 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XN2JErJ0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC292EB5AF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294505; cv=none; b=HlngzJhLrz9DCqNgtgPxhwgodYNYUbR6PfMkx44o3AsGZT/j4H/pzwETYc3mkYj8QPrNfhAr2jeO0JDCYAqPVx4AMjT7R6I3vfHRbVQK3Yg0Wq3Bdrfa1ubutDTF0clplaL63/LE/dqBLgRJa6M5p5eipr6e9s0WPah3iySW5KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294505; c=relaxed/simple;
	bh=tYYsV6mTyIUmy9ftJ1Sf7RAebvqW7eDdmrR2fV9OabQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3vA03YC/m0IQ3A6qtdOWQM/k8rai2cctck0fMj9mo3QLoZJjE23Wcg2oP5QIVuBZ/2emyPHzPTY56EfhYK5AfxZFmbxa+Cs5ovwcrQxkzD9lNGDqaBKK9ZtH7jaaxn0q8dIr9MS9KIVkg/G7kFcnDjQ2/g57X/bl9e4KXZ+daw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XN2JErJ0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3M5mb010151
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j6BwMGQuh4fYjTjzXXoN6FQ7oJ09CxLsz69mXHIlrUU=; b=XN2JErJ0t8PbXSdS
	FV35s137Ru11jdPa1QrTuVPHZSmWXb0syHJebyDC4UNJm3LEgwlB640BojDZiEpN
	9NKSTUlVP8WWwtZnRvn7kTU55LMPx69f63qEJ7n+iWAg+HpMrToxHoIUNJX9re13
	groBCvZ9RO3usDSrLh09RT2y6mbdbhGg6hcW+a54fmN9H+z0dLOHd6VnFq6olq6Z
	LBKhhyj/WQhShwZsbNEYbLc/6v8QBsj3K4+THf6xUyPafcoJ5ijkkMZMe1XAx8OW
	nUHbef8M1FQCmhr+o7p5SnPq2EKHwz+uqNc7hXx0II5HgKUOeyEU1yGubFx9ZSy4
	/HkwWA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524djj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:28:22 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87bd2dececeso6089476d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761294501; x=1761899301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6BwMGQuh4fYjTjzXXoN6FQ7oJ09CxLsz69mXHIlrUU=;
        b=bGAiJR0lyQhgMfj77vfRM+5toSUA0TF9VuknMbp6v/Muzjwdv/zN3KLCL33sBy/RxX
         tqIK8wBGemDnwkwAsU5T5Yp7OaLzTYVXLmrOVmPtRscNiRe1nYhLZd1KawMbKwtmL1Nr
         dJNVvlDO4HFP33xWNRiqoM5XMb2gFbQuvkl8nUeRKrJAw3DsRZPUBEak15G/zUJzmYXw
         5UcDFSAByX5KuZdzUJcYZiB/2zLU98jPj8fwGbezVM0Pd7H01ZDP1LVbs7Ijx2QQQNot
         Yl45VlMwLEb6bkQPefPgnDXzdbS3JzVkvWLl2FsCFNb63/ECvyD5WfH0nxfQgVOUUv3Z
         UAHw==
X-Forwarded-Encrypted: i=1; AJvYcCVvGnICUNJgMp/ZyDmOioGODYfPOX9uzSV9tCSGVXCnS7Rgb3Um7ZBidCMV6ETk9ctZGkLYfr6E0TiMe+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEy0F38Fjiflz8vId0F4xzmMIMgmaEenI7R+Rs6x6zLm8733lW
	y9Rv5Cv/EhZoDIxLgvicb1Au6QR/qseaTrAJDM1gsXmHvyb7ytO8jemg6ieO4hkT7BX+OKVNIUY
	9TF4aJCb0H8b5qs2EDwaiULO8Wm9NWZkx2b0mmV6SydFX5rG5KqVj9uSSV8FggyD+Gm4=
X-Gm-Gg: ASbGncvRxyjE0qztMUo8YMxJ+4PaCDXaGCrvqg4hctSi3CSzSHkRjhXc8FZauSXksTe
	uJDiSiOkJ8hC21gL+aNFG93JHRIgzaB2lnTf2hda/xrrrHQalw90FF//jq47G+brr7Qd3omk3w3
	CZMiSZgibkPcMp15Gz3+aoyxFrBts0Iv5AUqtG3TtcOs1QrA5W5vRz/EhF8lPl1e//bj8vbG9MZ
	ALqTjA8rNJ06u3lT5UOCGPJAQc+AaJ5RIThyaP5MWDxKP58qPZXVO3jvYSJixHPbFPvExgKVMOb
	sTlvUHEzdMk4cZog31uQDp4qLtIAkCZAX5txQ4E8ENa12b3qOH6huT73urfLZ+NQP+Rj3o8RUZk
	0rE9zLuXGhNO3kP5SQ4FK53G36l0A+Rqpb+Fok9S2GGy1xYpOzrEtMaUL
X-Received: by 2002:a05:6214:5001:b0:87c:13aa:b408 with SMTP id 6a1803df08f44-87de6ff172amr111258136d6.0.1761294501401;
        Fri, 24 Oct 2025 01:28:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeT9a0G26pmu3kuZNUTSDHdkV6SdMv/bFpa+lk2a30aD/Ti0Uu5aCZLttJNVboHfIaiNKZ8g==
X-Received: by 2002:a05:6214:5001:b0:87c:13aa:b408 with SMTP id 6a1803df08f44-87de6ff172amr111258006d6.0.1761294500924;
        Fri, 24 Oct 2025 01:28:20 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f316d93sm3603580a12.26.2025.10.24.01.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 01:28:20 -0700 (PDT)
Message-ID: <07066c46-4121-48da-846a-3a180d245589@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 10:28:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sdm630/660: Add CDSP-related
 nodes
To: Nickolay Goppen <setotau@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20251023-qcom-sdm660-cdsp-adsp-dts-v2-0-895ffe50ab5f@mainlining.org>
 <20251023-qcom-sdm660-cdsp-adsp-dts-v2-1-895ffe50ab5f@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251023-qcom-sdm660-cdsp-adsp-dts-v2-1-895ffe50ab5f@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfXxY33E8iQkzci
 E/EYi0TV0W5gXbZ5swwNvW0gFxq7xuMv+7x/1ZpC+1w0bbY3kT0ZTJN0muuSQjJht7Rg2yMLXRW
 nglyJxbjPEU80cKdQF60Mw/wBC1FkgW036XFQMPx0IjFL0eaBeIr+sTN96hPBbciiChp7VNo1PI
 W+G7KbF014sUP8GKrMx9B6DJ+btDYr+QGARJ6jgyMm/EvRkGp/vN8iw5G4/ZZ/D6FmcTecWEI4F
 12P919w+FW0dYp5e5gourm7BMpyTQDmIyCv/KgSCK1lzHvAn24JA/EBwXsqGvZacmKkdFRQNEhY
 b0m+3tyjs2NKaiY/Yn1Qeep00DQhKyzkCnxJHxIEiuW4oK15G6g3lviOjlQ9F/ES9d0iZ2gdMsP
 HXLij731Lz8zQSiGYBHNREoDNxK/rg==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fb38a6 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OuZLqq7tAAAA:8 a=7Oru3VZ2rc5tXTzVnmAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: ouXBt1cDTFcWw-X--vHKKuWcBkDRsFHJ
X-Proofpoint-ORIG-GUID: ouXBt1cDTFcWw-X--vHKKuWcBkDRsFHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

On 10/23/25 9:51 PM, Nickolay Goppen wrote:
> In order to enable CDSP support for SDM660 SoC:
>  * add shared memory p2p nodes for CDSP
>  * add CDSP-specific smmu node
>  * add CDSP peripheral image loader node
> 
> Memory region for CDSP in SDM660 occupies the same spot as
> TZ buffer mem defined in sdm630.dtsi (which does not have CDSP).
> In sdm660.dtsi replace buffer_mem inherited from SDM630 with
> cdsp_region, which is also larger in size.
> 
> SDM636 also doesn't have CDSP, so remove inherited from sdm660.dtsi
> related nodes and add buffer_mem back.
> 
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---

[...]

> +			label = "turing";

"cdsp"

> +			mboxes = <&apcs_glb 29>;
> +			qcom,remote-pid = <5>;
> +
> +			fastrpc {
> +				compatible = "qcom,fastrpc";
> +				qcom,glink-channels = "fastrpcglink-apps-dsp";
> +				label = "cdsp";
> +				qcom,non-secure-domain;

This shouldn't matter, both a secure and a non-secure device is
created for CDSP

Konrad

