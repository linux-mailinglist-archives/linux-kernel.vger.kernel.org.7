Return-Path: <linux-kernel+bounces-852292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D074BD8A04
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69211543C39
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078F4308F26;
	Tue, 14 Oct 2025 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wh4QxIL/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A132F5A1F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435959; cv=none; b=PRcJ3hw19MnYiQU41RJBB3njm8ZPxzkkCUGOSbCQPgiE8jmnOWm5GsEUrINpndhDnJR+YDRZEFBKF627aCs66H6XAH2N0Ztg0IwzeDo30FoQ3mL8semSs9x772N0gSiqCCXuLJzGZsFk5Smex2crbCZ+fqc8sjWywXtSKenkFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435959; c=relaxed/simple;
	bh=GpI/jVWA1HQ8B8zZbIRCyIhWFL7UNuSPmhtgPuRgUBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVzJuf9RLy7o5UIgAK35zo+SY58kWLX/5VEpyj0cmd9fqYOSNiypesjhgGfYI6LcIDq3Hhndk4IPC4ZIX1ukN6kDxSXeuE8VaZ69Omg0yyO3xPicm9Tk/yJ4PX9mF6W9cQtaRyHGjdhBJGJiYt6SKFR/djpEnxD+2bFLhKyKIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wh4QxIL/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87JGh031017
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZiM+msz2/xu7IuhsRR5eS2JwAIpcWvTBpY6mVrIXXx8=; b=Wh4QxIL/w8P0pDUb
	RQNyBsR0DixeIN4SDnrpiRguB9XB3E1DNfRULVf8/XUSiGe7lwe6zgWP561GVtiU
	MsYYb9PQHUJHq3mScnUT1iMWt1I7swlAsRnStm7I6Q9NMvjYWXOXG4ySBsVRQEYT
	L7MG4TEKaCeIjMKTV4zebeRWxHySCezsPxC3EsGE0ydifOey6t4HdNuaIamDC6Ca
	OKuoWfxcH2PSbYV/7LJ2C1mBdypHXDYS6gnG4XTkG5ttuD9T2mgeTYr45kpLglzX
	g96NkwNm2t3+OyYCxAnDI8t/C6Q64ILiIJhHlgl5sawYf2n8Z2At8uHI2piV1Nqu
	73mbMQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0r058-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:59:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8703ba5a635so255231185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435956; x=1761040756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiM+msz2/xu7IuhsRR5eS2JwAIpcWvTBpY6mVrIXXx8=;
        b=AwlEy7JJ04iu5mOQ4yv1ZJl65lXL3miUgyKNpOd12iHsv6Qti250HrUtYPg+t3bX7K
         FyB/bv+JVVUqqFeNteFQKDC8oTNyH+RUdFRu/GiNfwu1lMvOoQC2CUWMrz+Wqyc18ZUj
         2Xtb7AG5Xv38DKLj6W3Rsk765MnPT7sfk50l0kNXw/9QqnGekwBXuN9gxKxlm3jbr1Zw
         6Fy9YmHmyGlipyif7gt96db6PoFIV7b26ntJ9MYX5fg+0kOh/SJT+4vRnU+EdsyM3oGe
         w3YA3rkVS+mGrq4rAkTXRKKF53t5IIFtRwDH4snUkyidzqQ8QJCIfhAoEeekonCAkagM
         N0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWan1O2fjDE+pL+4JieFMHifLVYcynl5npu6gcdId9dNVN6dEIHmAWopQ+pMpklwBohJT4W5so9WoZ2sTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YweUxb7g4FaT120PBkn9j2sJmHExdTd/2cTHIjXs2JsFfPR7GqD
	TzLpbocrzNDV+murz/AVilFLKzPmW/ux0uTan1lWBBo2fRNTByQwwrCk9cCC7zO0aau8xPC3/+n
	UVGXNMxgspy8ZFz10KJW6psU9TCiRkwnk30t09q+NXcU4F3isU40X38AKD83Z1K7jbxY=
X-Gm-Gg: ASbGnctsU11UTSqDzvy+Oj6Y900w9MVMPFggNDNle84qK3dfzK0jVu6EIhVx7zt7fEb
	C5fI+nZWsMR6SbWgYX7vs7z5FeadfqETXyAkPxS8/fcHYd8LOAH5BGykzWYHdsaj48oIIc38qy+
	lE/9lu7Dl6KgXr0VwJ8wkl7q2XtPq0OvsSZQdXNjGOFnjSokBpqt/QN4KPMYHER9kzCJLEkJknI
	sZ6spKYIitERK8j1uIOS2tSz8h2LZ/nsB2cOk89a+ldwgeRVi83X8NdIhOCIPc6owG93F3xkGlh
	vvl8SOJZ8f+T43CGM8ei+Ju3kyCQ+kmpPr7cJtmhu1MJF7bpSSL1kmkvrQJnGsRVB3yfxZUyIQk
	hjZ6dxkDM9AWl1iIFFPUw+Q==
X-Received: by 2002:a05:620a:7014:b0:864:a09a:e860 with SMTP id af79cd13be357-88353e1debcmr2106195985a.10.1760435956018;
        Tue, 14 Oct 2025 02:59:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVHkA1lSvpK0GyjJ8jKaSkv6pRKShgtaR7/kW4udBNApVj/YUAiOSDrO/HaCh3UHQSF3UsJw==
X-Received: by 2002:a05:620a:7014:b0:864:a09a:e860 with SMTP id af79cd13be357-88353e1debcmr2106194185a.10.1760435955541;
        Tue, 14 Oct 2025 02:59:15 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9113a67sm1136953966b.70.2025.10.14.02.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:59:15 -0700 (PDT)
Message-ID: <16170710-63eb-4292-a519-f9daeb222e49@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 11:59:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: r0q: add gpio keys
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251014044135.177210-1-ghatto404@gmail.com>
 <20251014044135.177210-3-ghatto404@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014044135.177210-3-ghatto404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX7nirHnCSqX1i
 SyHNmzAVmBoX1w5wRev/nwupV60lpLn9TPpSfTCcbfZUxJD7BT8rzmPcuWqeAcQbmCPAi6srLCB
 M7gVCADjdSJ5pejEiMS6i2Zz9+2QVlz5jiEtJ8J2IckxxflvOiPrfwTb3KwCMdMZuudeSiW1Y00
 1RfGS6At+qNtZY3FVh0IvKAUYuJuBx2fa44gymFTNiDbdAEQSZk1lgZQWGFeb7BDGhOg0PB5KHR
 0J3u2ujp3Awt/QA4JPP5bP12FcFrILg19m8xesdQJKHCkCxiPcQ9dmQXie7KuR9Sk0FWMI94Xv6
 9P8jj0fWthskjljUCAYJysphI9dtaPROL5+qbo3OMTx++k4u4CP4lOVITX33yXnJHs1zDEPn3II
 RJ8X4kRDuu9hKedxEXq6cAhG+GIYOQ==
X-Proofpoint-GUID: QkiRLAz0U4rXdRIO1vs7losNIA6_i5oo
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ee1ef5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=qz-H3Q_c1Qorb1ohe4MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Up9iDE1rbAkA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: QkiRLAz0U4rXdRIO1vs7losNIA6_i5oo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On 10/14/25 6:41 AM, Eric Gonçalves wrote:
> Add GPIO keys support to Samsung Galaxy S22 (r0q).
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

