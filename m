Return-Path: <linux-kernel+bounces-802879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C45B457E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139803B69A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E7134F485;
	Fri,  5 Sep 2025 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dkhVojmV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1734DCE1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075295; cv=none; b=f8RcrBCpJ/tucWm6oQ6xWflf/t0d0S2aJUdb6vnHqg+5n63Icc/Xgyrhby5+/830iMXtcVq47MPNRaa4ILR4Xo+gmqQBJwGMC93jNcCxVCPnKAQpKNHf+OUi7ZenbZw0sPEQhqWJcvdD5KNNpO9OENnktN6e+xM9boBJaGKdGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075295; c=relaxed/simple;
	bh=uDpudofOkYBdbeH6V9Y+kTFhVPT5jO4rSOKc/EyVu/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NlkxapeBiVkjNMOPlMFzY4o+y2yw696eOeVBBgmDEFeceXloJEFH4ZHkkui5SB5IPlfLx7cSVsO78uLMtUcZX5AaADbBvOPWN9idVu9YNE3HYOPZBmqw/A+U27RO8GlXm3WWmorvabe7I2g6xI/f6giJvfhVoqvTAwxs1+ERBxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dkhVojmV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857ZPxa023892
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 12:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eajFPWn1xdqMoWwy/ddDT0Q7ux3XoVox+4G1phz/d6g=; b=dkhVojmVX4VHTs4G
	OryMgMrveKpyHaaD1gHSf1OsDuVwfd5Q3FYNga+eRnhpR7iKI6FtQCT3gD3Lbavj
	K6rDQbf+bk14Y1Bw+R/azPFYH/jNDMQFo8HGYMoyo0zS+/StU2qgGVhiJIDFvXTz
	yW2SPXi3NQRn3J0+83tmP9Kug94w8vRMoz7Jt8jMiXoO0Iab48qGPIysJptyi1A9
	JzUioUnBLQyboraA/sS+gr2ls6IkdWCVwnJ4bcptDQY1Hgr0R8radtWdmPJJc/lJ
	kLWXGxp3lZ7cmTL2viOk0tIuWVHWr0vSiwCwpGSnVw73kEDQ8a7Ov+1sS+xhOc08
	EELPYA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fty5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:28:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b307e1bef2so5859761cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757075292; x=1757680092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eajFPWn1xdqMoWwy/ddDT0Q7ux3XoVox+4G1phz/d6g=;
        b=Ogt3KfW7+ASoenFkmQs3LbT4H6QOL5/tzpFEoXOLK5HgolD/s2vv3MJFr0NM6KL7Nj
         VGDWz/q+nZRP/FGF9gFfexnguEws+TM9xJdlrSIGe3BqlDNAiUwDqGQfiVfJrv20vL/Q
         oS2vh8MofXynuCENAGXqB+/wVd/0NiZmWNvhXirwisPUpGl1RqOZAJCnh5mvCFlLnfAV
         iawIVsnMpCT/o/r3/BABBANqWFpFkTWBNpz2oi5okr1zXONtIvfcY7ZmA95otl3kayxg
         pwcuBCERxlQVU/7Snt8JpRopYW2gkDPY5hy/R9P+uSP9+NKep0iLvC/XtjXYJldAUeao
         zhug==
X-Forwarded-Encrypted: i=1; AJvYcCVVCxUwOXQkfoRTXZ908k2WumXWQNCnFTU0FL0SDsTP/flL4pGUNYckyo5aG8UwO5cwh9cbGZ8RyPES6Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwwEIRetA0LeUDftQPIwCBfud+fRl98VofAC7PCnppVN8Kli7A
	/RVL320IsZmlFBoDoKvx4liYSLUFXieawbXtY3vpHQh+Pn3IP0iSF+pLZF6BpZeWhd3ZZcC2oC3
	poFOI14X9islLr6u17+TgQDd9lcpMDgdOwdyLUdI14FqgLRzeRFb3huGn56i5WinejeBieQxnaG
	U=
X-Gm-Gg: ASbGncuP0/q+L4pQnUVlnwlQZt1SLwufmngAo2I78o734jJee5EdJZOvLh7wA6csJNf
	7zDC1jc/r13Qg4FgeOpL82WCX3rvd8JNWyGa2hfmi7pJqAI8W05SxPFacxqXMrmLpQOzoiIrZkX
	TXQZiXjju4wvLyhB+yCN2EVCOhoplseh0FXtB5pJjY1o0/snAXFE3XvgNKhUoXR9m9wfxdov5+7
	AwOSmWHM20aqzufFx4tqlVY22aas3S3AHSchIUFdJzwQLeanlV123kxzAzBCtxjiztDTCrPTEzO
	4RJ0wx7WKO+b9Oh9CoTL5mbrGQnjQcekGoRk6yERUN9UGT48blqMQJuutD1NMBZiefOdzmqxXHN
	MEwLsx/LUXbFWAiv/oHHxYA==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr60552251cf.2.1757075291645;
        Fri, 05 Sep 2025 05:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWg77L4QqQOKdAgOxGg9M+otrPnQYWNj7jNcsX5+drgBYt19UXWJz+PIWIgaNs5LHPYJywFA==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr60551941cf.2.1757075290926;
        Fri, 05 Sep 2025 05:28:10 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0cb2cb07sm1724345966b.16.2025.09.05.05.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:28:10 -0700 (PDT)
Message-ID: <a54442d0-a22e-42f9-889c-4bec128b3b58@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:28:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8750-mtp: Enable PMIC RTC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250905095353.150100-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250905095353.150100-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX44ZiZZLqwAlZ
 YWJ0OfAUsmlsyfIABJpiPVeKoP1x/Lnu/J6JB3u+zH78eivp0/ObAZX9zVPz9ysCdHMAIYv8v7v
 D0NSqVPMVeof14cmZ19LnQiPtNvCqQVnQkd1p2/cdxhMkN3TMmaQahz7/ens+7L5mDohPt/ldMu
 ilJ1uJVKVr6ucAC15rXlIM4y0Ctyzqo036tQGQfkp196QTrw7qitMpeWvndu0ux3ZDnVXBqez60
 RtNFid0P01Zw5of20fed5HN493lkATlZ/SoUG4PTgLz/H0g6UyJXheTahKNtS29QKgISxEg+AzP
 dIoFrvmPoH1iEZTjYTBQv+h3mzaprrwIAiUybvo3fBLcvfqb/zi7WRbkHvWMZeJwN2unUC8kxzv
 /fHAnRH6
X-Proofpoint-ORIG-GUID: ueOL-t5x_LJAeoV1yFF-sizcHxLJRPGS
X-Proofpoint-GUID: ueOL-t5x_LJAeoV1yFF-sizcHxLJRPGS
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68bad75d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=HTN6E6hfFVIKqq8n5ioA:9
 a=QEXdDO2ut3YA:10 a=AdHoc0ENqhcA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On 9/5/25 11:53 AM, Krzysztof Kozlowski wrote:
> Enable the Real Time Clock on PMK8550 RTC.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

I think it makes more sense to enable it by default instead

Konrad

