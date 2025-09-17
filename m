Return-Path: <linux-kernel+bounces-820891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCFB7F9E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEB8189B0F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657AB32898E;
	Wed, 17 Sep 2025 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ctPjgPV/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC38328966
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116689; cv=none; b=jRYfRSJg3v8qXiFnLWnymvYMrrKY8No4pseqBSoE7wp83DgJp/kCjsAm37J8tl0AnylrgxzLNE9RQ4BoyT9Fs2QhAZwrC6TRnyi3yQReUoG1n9kbTkAkkQWxNKvAejTmnd1kb7Ra2NQhB/qkofPBWZaBsitYy8ybIgMESVpPuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116689; c=relaxed/simple;
	bh=vUQvMzwQ3ZD1hwhkE21bB2D3wf/HfeAJ/XRGoPgoT50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c47rwDvqv0BusqhlvKdhlwh/It0RV1q/lc+bcs7r93oTArtPNtOpIXb0LkYJk57GT7Um90Lsubux7Uc7IwuyrxJpJOm+BdV4v8DdXnwFex/MpNIYVMR0wFWmQtgeffPZxqP+W/s7pFCfX8a9pnMpP9TV7/MtYvVJz42tfhqfOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ctPjgPV/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8Xfh5010827
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nzSq6p8Sbr7XpckIwbd1Ueyncy25BkLwVzaplFhdajs=; b=ctPjgPV/kwfpsGp7
	EVBu+xn9lUgayfxTnG+Qe6j2XX/MPJgu15evRp7QuwSwjp21zwuseFjptpJqpqez
	DOTEmBZe4KyqQ20zgUEF5FORo+XyhyI3OdxKC5iVF7OsLVRdP1/IpE0XFcHSlpTy
	6J4pIdR8WyJXbKn4IOzE3E5RGmt1pBVltGoyfQ7VVm/I+TPFjb9RzJu24b0+okn2
	zc+C8kgdX5BPXPcdsCYVRKZOBAvOpQ1TJ+9WAVq3nzBvvPhYOv0nDZ+KehrZn1sU
	yoYGZ29aps9OM9MhU2d7jJTrEhSiILZ+Dh/ZU4yVgn/igeTOADQNSIyrOJ+2ZUeD
	JKvsmw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxthgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:44:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b79d7413eeso6520241cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116686; x=1758721486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzSq6p8Sbr7XpckIwbd1Ueyncy25BkLwVzaplFhdajs=;
        b=A1uC0zXUCnS95s8sY2gmkuUtaveqGTJLnaatssRRMsoC4Ytou83LEA5cjFT5FS1KJT
         Vq+qYLG9OkacQm5PpF1rAYELKNNJ36vCSeJ8FurXLKt65KSn0f8vYPdca7S3ZmkqjLgu
         h0JsuWrgXDrUH7WUYTiPqO8/BPIqfsuNEle+Lp+xAKVgmML4lj1U0TrsaOxMOGqDGbme
         K0Ixwy0fousH1rXqMePALOIBMhmYx+MIUtWCdlB6YD5XhOFGSQMxlIMp51jv2VoOpUGj
         FjXacnHQvZCn/HkRT7Y247GraEhoRk2t1Pt6Hn7c1rLFYRhQJw0BOeCRCeuwAldzfssK
         oWyA==
X-Forwarded-Encrypted: i=1; AJvYcCVQtwwBs1wsAJUkiST0JaDa9TbdxllIydG9YXiNqMJDe+cR++btFOaDzSA1E9YYF6RRnlqbCoe6tucQoMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSlguZhvg4UnKfwymikHfpwIOVFSuvepd6UYLqEYNHcWj+qHeD
	bUL0cvEPhnoDiCAVeUPY3yhdZjS2WZUVvlmLdU/bne2QMZXVxfC1wPBS0IJCaF83PvYROoesnCo
	iPNqfNH+TqpzNHwTyPljyjWrfd4Up7fiWvV9pAmDTxu1peDRbwsnaeBQCOOI01SE+pZY=
X-Gm-Gg: ASbGnct5ehEMI+Nfp00j4N08Vh4lRxtzjrK1NCDfyaNr84t/49k+EqTySu7CP3wTAhW
	1EelfTv64pNdAMzbKY0Wopmc3cINDeDkEP7j1vygHhVp8jrJylXszZ8XWBzZ1DX9qVGETh/IP54
	4lwGegJ7pAUdJk71KW54sselnpSrC7nHNgZISpJAZ5ZfkLes6urUMd6f9JKBezK4nJFmNoPFH0Q
	vy5zvMKsVBX4DwUpzdV4q77LZ8+WRQtCaDUSsM1yV5uQj1RyUoQWi5/BzRSXnpqJ0nqywk40/Mq
	RtI/uh3t1uYvWILURCNu7Samy29pCff/ZqPuKAqm2BgzDYz2Nj6gxfS6HSYAKiGpYeG3+9MHNXb
	iBS5JryVTG65QneTD508hWw==
X-Received: by 2002:ac8:7c4e:0:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4ba6833f385mr16864831cf.7.1758116686098;
        Wed, 17 Sep 2025 06:44:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkIhr8rNJXDx1RAe7AAc2URQZK0PBlD1E0CbqMIoGy9FQdSRFRguiWp/NEMgT3vBZtYX2NZQ==
X-Received: by 2002:ac8:7c4e:0:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4ba6833f385mr16864601cf.7.1758116685387;
        Wed, 17 Sep 2025 06:44:45 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f2122sm1376734766b.85.2025.09.17.06.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:44:44 -0700 (PDT)
Message-ID: <04b9140e-db90-472a-a550-b369670b02c7@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 15:44:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] arm64: dts: qcom: sdm845-lg-common: Add
 chassis-type
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
 <20250916-judyln-dts-v2-8-5e16e60263af@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-judyln-dts-v2-8-5e16e60263af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX078GNvNvrqor
 I3PyXvHN6o6qbZ6qMr+761rs27pOkxTDBvUq9gsOXzrd69IkLbeHgBWUsSkFl8hTKQS6LxHgtna
 Ru7x6SDaHbEBEP/e+xIG2plpuPCDN1fQoFVVFXuDXIRmL/ytnSgpQ50EnDhmWE9D7U4/h5w8aYK
 du1GmbP8yTzQ6+YzoGw46CJMH7dVwMTzMcjqgKTX0gOUA8DVzf1/2jsc09braYd0upGqMxtYQEl
 Q22AR213mxqcLW2ziM9nwuvK9ndE5ioDH1EAcpkB/zW2MiNFZr/5td5fparc0K5pF9v6kTSoswg
 UZxPFBiN01FsQB0KAWMScwpRR7s6lGhpRaPjkrgh/bRSuvJAvkPru1GupRYzTrY9+y4kopYCuHF
 ww+uiVyQ
X-Proofpoint-ORIG-GUID: CRvEg-rt8wRbC-LXnyV25q0NpOeX4jTr
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68cabb4f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Gbw9aFdXAAAA:8 a=EUspDBNiAAAA:8
 a=xpcYJZ5K4HInNErYrfIA:9 a=QEXdDO2ut3YA:10 a=IQdlk4_VRkkA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-GUID: CRvEg-rt8wRbC-LXnyV25q0NpOeX4jTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/25 3:09 AM, Paul Sajna wrote:
> The sdm845-lg devices are all phones, therefore handset chassis
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

