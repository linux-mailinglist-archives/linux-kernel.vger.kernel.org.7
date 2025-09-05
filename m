Return-Path: <linux-kernel+bounces-802943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9252BB458A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901FE7C37C2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3893C34DCD2;
	Fri,  5 Sep 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kSBe4BfI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05727AC5A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078375; cv=none; b=QcNUgDFDDIPgN3ZOL6Exy/YK0kbzyb8JSZmoxlqguzr4kfkyKbB3ixa5QisRlb+wS+N0WnEcCS45a/1Pr/mNFVjVh9TI5iUrYj4SCh9pExF/aifZMKvgEcfJr/aWoxixZ94VQpIKZLSqs8tFE5PP+d4q8ccYtCHR+XYz1qGOojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078375; c=relaxed/simple;
	bh=f9dg9f79cEQYwrNo5ZvWpn7K6mPR3qTgf9FIhmyJUKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDhtLm+kulp9htID2C7bcAE53p2KQTzWLSG/6IlIkWX5oTQOp+yhWgH2bGpUsnJ6XKlc2wtJz4yYl/WV+CIdCgkXsdF2id55scJbzyrtnpmqMaA2oIbvfGQnq9bb6X2QpQZYC8sNUoG8R9hO7buWKM+Mn6iBVG9IeE7NYILsBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kSBe4BfI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856LKbE004616
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 13:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U0Bhjhxk+tpvajQc7hWGH3X0z8vhyfUm5KLA3GKOkgE=; b=kSBe4BfIxrRDISVO
	fFe1nqQ9zNjhlm6th8gyoWVyI7V85NuzBr3Vm5oSs7ci1nl/zp7b5t4tYmZFJDUL
	a3K4lGv5PTGcaztAUitXrmzCXGVQXcFERsolprSG64IGIdwzjdx4f4ZlPA+q0gpN
	m4Sf6SyfcUCG1dmW4os9pGizcTIcWDwthvm+8W7EAW+CKGIyLmb5GdIuu4ETcxJO
	/tIlmoZv+U/vhOVBpHEM5TVsE03LxGC2sZQQFKK6qpT5OI6BfMOxSOk8pmKFPHej
	aSAMk81jLkrNyekRvUCxSjZQiQXD2liJdo4FRBTOsQ2lfOzWWtdO6pASOUY9qwi2
	uYoZTg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8sbb2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 13:19:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b4bcb1e32dso9741781cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078372; x=1757683172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0Bhjhxk+tpvajQc7hWGH3X0z8vhyfUm5KLA3GKOkgE=;
        b=bdGbGzJsHl/cJttwrl1dckG4XxCtxnO9h4loAMQ9UGGgl1HPEOXDs9rcI1dTBw3d+M
         FvMELnB7zNiaDs740Vx9JlKCwWxfgLb7Y/QJ71ooLv21oXSfo3QyXc8f5QBv44aKlzi8
         qki7/aUSyClM6BGtv+qsQpahEKakaBW48DGSKiuVsDU0Rbi+FDpbRy9O5LrE2W8p3ikQ
         SavdfSWpMVkxIGcgIPk/iQf+wW5Q1q+fWzznHz1iqR+CH1knODT5okvGEPSXk/GLBlSj
         RvDu/i8+52hSQSyXmSGy7wj412qF2rmVyQh7duwMWGtm28GrPaA35CiMtRMRoZLngK2C
         RScA==
X-Forwarded-Encrypted: i=1; AJvYcCWP1E4SDKkhwZ+zrj1by+d8tePK0cPqcm4cgYNA/t7mUQ/YcovK3IajqrJqNSA+4yBlPWxWIDwUGwv5o5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgDzm7KDbrKjcNyZJzsWme2E7PZGRHaJv8uE2XXAzz+QSUaGj
	CWU4e1bNn7IdChkC/7clnUYzjFqWrDrq3Z8tF94sxdQASsxYzi9KtzKr209YxABUbiNEao2OC3l
	HyMj/+tSRA56np/sH2QUIDlxMt5VIBARGKfKfzSLSk2uySxNUCA/5R3xyLBcNJmqixH4=
X-Gm-Gg: ASbGncuRDb5ujFUE6oB4i04hEBnfK6OVgiHu0E5nIgm4tIwNNZUCMuT/57hEjQHU9Cp
	uWJl0xMvh+rNROTP6nXPQJH0b3wA7KTXfpgBePZBoAJ7KdNY3ARXApX9AjSv9h4RPGQueMpm335
	9xN3UL43E3XJm4N4MgxRlkqlRrrNS9/gk5itnjqEkgLM+/8IAa174hBoVeoATjH65OxBbcTTO7d
	FtbFGs4ZedKQB9Ey3NyAcwGk76P86qWP1RBgxOB8JS5bzIHWOmSmU8iskc96KOVgl2QzMCAVFT6
	i2ZGtal5+ILzAnA2LrY5kByDvz+f04EycqieX5oZP6L33Pdt0jhst4MFg/L+7iHPimjtPVCHpDY
	mrI6tXQrOC9Bl6oWkbJLSsg==
X-Received: by 2002:a05:622a:1a1e:b0:4b5:eb40:b1c4 with SMTP id d75a77b69052e-4b5eb40b475mr15321821cf.10.1757078371975;
        Fri, 05 Sep 2025 06:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuoHXh+KD08XcnAE/jgm1vEO0s+IDJTiD+07YDOxNry7G/om/NzxaG8um/RprAJT1rWU9rbA==
X-Received: by 2002:a05:622a:1a1e:b0:4b5:eb40:b1c4 with SMTP id d75a77b69052e-4b5eb40b475mr15321611cf.10.1757078371453;
        Fri, 05 Sep 2025 06:19:31 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5306e6sm16320205a12.47.2025.09.05.06.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 06:19:30 -0700 (PDT)
Message-ID: <91fd1e35-7e3c-44ca-9ffa-9393dc9e904e@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 15:19:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8953-xiaomi-daisy: fix cd-gpios
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Alejandro Tafalla <atafalla@dnyon.com>, Luca Weiss <luca@lucaweiss.eu>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250903-daisy-sd-fix-v2-1-e08c50f3be57@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-daisy-sd-fix-v2-1-e08c50f3be57@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX3TwgsFO1J2nI
 8YZA+ffzRVFz6+HQXNdubkBkN6duiUjrW7Pi6YNSUtsOqJ0g9scS1pr6zuHijMgU5NHAF/TI+e4
 bJA3n/LbSAgdS/kHJv7tUQM+vfaEpn1XETDNfwz/VB86xGVTKtrkyM9nr1pHISyKD6KsGlUYywX
 hqMDexDj+vmToHE3PQWmXy1ZCp8mdPLcqbcOJo/+/ufHZIrijwEoXF8RZPxCQA6twBVft518FOD
 Ii5NdulWheHcXb1FBrEeQMnh52rJT4ksteB01p5KiTpDLclhxgrmlR+aSNFDg8dlziha9Anf34m
 glX/tPng0lVPvc3eEVdWSYIr95ylKY8GDMKkaLVFW2aqImKawhyLX9sPUg77z5knw7ygxAVH3+e
 uUL9MYsM
X-Proofpoint-GUID: 1IJ34ZpRrGk3bB7oig72lj--S0eYEec7
X-Proofpoint-ORIG-GUID: 1IJ34ZpRrGk3bB7oig72lj--S0eYEec7
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68bae365 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=P2Z3rHzvZxtGOU_tVGkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 9/3/25 11:27 PM, Barnabás Czémán wrote:
> SD detection was not working because cd-gpios flag
> was wrongly configured, according to downstream sources
> device is using GPIO_ACTIVE_HIGH.
> Fix SD detection with change cd-gpios from GPIO_ACTIVE_LOW
> to GPIO_ACTIVE_HIGH.
> 
> Fixes: 38d779c26395 ("arm64: dts: qcom: msm8953: Add device tree for Xiaomi Mi A2 Lite")
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

That's better, one can now reason that the change actually works and
is not only made to make the DT inline with downstream

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

