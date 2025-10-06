Return-Path: <linux-kernel+bounces-843050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A45BBBE4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC1B64EDEB4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAA42D4B71;
	Mon,  6 Oct 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EpwVL745"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2A19E7F8
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760128; cv=none; b=eTpsiFQm/vvq6bfQ3K6P7jL98hTWS/God5Pp2aocehCRf3opzIALgqPrAy1+Dbyw4uzvXG2ptDVUpGqpoA2dRBD2sroedjmQ4GMoWhO5jZMKHAiEZI4O7p6WCoVxsvdNvbGPKCnsun8cB2rXRzk+mxgp7+zZB9+f6H8bJZVAzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760128; c=relaxed/simple;
	bh=ok4AtDYMOOhFNXyAmFF74kRt5VF7Vljw8v+VdN/XZbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBSbYxyGZyMGGUFkj0h5okdjezMnjS95Wtp1ORF6oSOAAqLHVSdhHfhNFlMCDiM9Es2x2fkY18T9wMPwadTqRhWFg1AVSz8tOekvvcAKRYbFxzJ8sB1hRlN3jYp4vBLjl5ZjUMaLwnaw5e11x3iZf9hgSE5g5bw7z+I2Mh3y8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EpwVL745; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5960wYBg020690
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 14:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2oRfqLxti2zi2W/CuLcC7pD7vVbdx7nMsq75v+U2kTk=; b=EpwVL745J2Yku7HA
	Vj3t8daPxlh5Xj+aE0q2GZDoUWUPlcJcT0fDqgmju44GXi1G2KSRSMRYhCdeb9xw
	PNTj0FLABa7LHjvI1RVyZzQViP0cIheiSW4tNykOWHhQwJu2Xso8aw+ROINwZXIy
	oqQ9a1bPcw7yd3zN2hATt2O3uFzMe32KVp4Ba3/V95+VgMvXfzJxBedX3jTrpJDu
	qoOwGsQ6T4gsvtCVOQSPafn3GLdoTQTK3QSo9KLosSvcDqKDsDAPocnLzEYZQuSP
	/NCP1Cil56jxm+1Etcj/qU7B+1pKcN0eocXwYnQ7I0lWpRO3D56w2ZWoZh8pIaIg
	JkX5Vg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy6v07v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:15:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e56b12ea56so10246171cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760125; x=1760364925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oRfqLxti2zi2W/CuLcC7pD7vVbdx7nMsq75v+U2kTk=;
        b=rTxB8zPLBGGXtMtJQSljQXkJkSlsLaKxJoMyLnKtGr7PGa4mS0kgqTIz2Iv/JQTkup
         BS76NIW+IPdBOHsXQv4QdpMo7v1BsIrKb86CPwpiyOs8YwReRo5BKokQj+3S9F9Mu/Fr
         AsuzCTuSVKYZYDecrLessdA2z+YC+5t+yV5v0qkwJ0MnFW7XOwUtol9i1h25EDopGJ9a
         gutx/wQQS8wK3MQlOTieKaQ9527M3FPM5VzVIWzyvvY2SdMceSVCjrwV8lcIX369jEzI
         p/3dxyhS0+i6uQACLk7x1+5BzXpxpW9W6FYztSO6FlYMXZq1/re460wP3T31QvMidkTJ
         dGbA==
X-Forwarded-Encrypted: i=1; AJvYcCWj6knTuyA2d81E8zPBN2SBSSNNb4FC91d3/xDI7hGYxfXy3IAVTJnLbD6phxuK+SbAfTojYJZ8+pXxn5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE5tTltjAaLSwE1wRysAmd2YG75DVDFepIYPJ+cUMGSkqpfBwb
	9Tdyrogu9dJWuA941leBM7jJHCBa4iTRsGBS2IT9ILsaNa4ueF97jfnDos7D037Cd/91nlAL33s
	vgi9t/YVHtgSn6eYMr+88tV7L2o0KPHgJLLhpQ2jH+UpMRqPU9UPZTvYP+sFzMw5ms2I=
X-Gm-Gg: ASbGncvFl4gEaWKMUp5LefeMg6s7UJjXMhH18DmNBZx7tU4Lt7vWXdh1qzUu4mUC37m
	Ni84vJCfLpXbaGKt0CGpPm9ayR1Dex/d9AAL4Na45Sozg9BVWQeM/YJ9RltuHirxGiSgvYXPk/l
	fH/JdaZtXZH6mnOVLJAIW+wofaU4APVl7PztS2DiHN4nztgy6xnQB477E6+NElvgnVeEajAyUsf
	cpJEICoCp53sfsiJ7FoVahwsoVUrKPDLDHkaAsH6YX5Tmu+MANhNNSuT4T0PqNzdwbOGZI4aKvj
	PrFyTFCRXgjdWRMS3D9j65m02DAOfdxsLbc0NvNKUtIfhqjS52RC49GSB8tfuxYHIJXLiMfEKhQ
	s7LoxxDpL2RyyNULm189bFKK1ciM=
X-Received: by 2002:ac8:7f87:0:b0:4dd:3948:3380 with SMTP id d75a77b69052e-4e576ac46b6mr96308601cf.11.1759760125093;
        Mon, 06 Oct 2025 07:15:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwO6cT4VTIUAGRglYg90QhjFzsOQ/k7qqX61THmdRovAb2bINmuVNJNYjeOMblpYuxHE/ASw==
X-Received: by 2002:ac8:7f87:0:b0:4dd:3948:3380 with SMTP id d75a77b69052e-4e576ac46b6mr96307981cf.11.1759760124328;
        Mon, 06 Oct 2025 07:15:24 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a174a6dsm1161275266b.90.2025.10.06.07.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:15:23 -0700 (PDT)
Message-ID: <babe2e5e-87a4-4871-a836-ddbd9cc8d868@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 16:15:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-oneplus: Correct gpio used for
 slider
To: david@ixit.cz, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
References: <20250927-slider-correct-v1-1-fb8cc7fdcedf@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250927-slider-correct-v1-1-fb8cc7fdcedf@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e3cefe cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=t6YKEHOi2jImhN9rZ5cA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: kG52DXY1X_9bhOwyochE9pAVKSk90S7R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfX6ox1lSoRr+SL
 teG7E/ZzjsCiSBj5OIujRUgYYoqSwGAGb4E49ALKMS2vdHd1PyR8241QTionouaYTEYhLhU4nct
 TCR6m/WbAPN6UfpDfWskam4B+8cWye1uGVZNgNy8ZAZb+0Y5Qv75oHDtI0UVpuzv5j1U43e3c9N
 77QgFw35DXjsaEvJR2A4Ah/LbDdfEsZTn4HdzQdX1QjQlGFvTw2mf5u/DrFFN+GcqroOivJBr4q
 rVAD+FqZaA99lsPKQBRCOD075ozbqvnBxlYoOfvNr8+eyQdp1eTZs4+RwNqKlyxroEmc+NM5wtG
 2RuMdQXGJbDb68HKahKTdYkYqJd7LObcYNPFt9G/8r1lZ7lCrwijCI12PT4nIyrfSrU1dkbV5l7
 uJBGFvuEjzl3+8EqVDLUeK0MPMuhHQ==
X-Proofpoint-ORIG-GUID: kG52DXY1X_9bhOwyochE9pAVKSk90S7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029

On 9/27/25 1:20 PM, David Heidelberg via B4 Relay wrote:
> From: Gergo Koteles <soyer@irl.hu>
> 
> The previous GPIO numbers were wrong. Update them to the correct
> ones and fix the label.
> 
> Fixes: 288ef8a42612 ("arm64: dts: sdm845: add oneplus6/6t devices")
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

This is currently unused, can you bundle (or squash?) this with the
"add slider" series instead?

Konrad

