Return-Path: <linux-kernel+bounces-813516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B51B5469A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27763AD972
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A2D2773D3;
	Fri, 12 Sep 2025 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dyh4kkX1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF682765EC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668436; cv=none; b=lDOSmmeSUvN5+H48jgVSY7T4XH1QgLMnmYj8vDqsSAFRVJny25Ti9jxF/T8w8JKUoq1pyVlTs8jKyTKQXvvF2zkc6a6gTowov+jstyUiE/CpWJJLIf9dxU0PnRcqvUM2vwuCujWHSHQ/gsdjUSt+6ktFRYEhDXV3ChS5ajYy5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668436; c=relaxed/simple;
	bh=ldXbC9SMsBCqpgzVecPRyoZxT3Gxq+D1+RjXF/SLglI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jr2Gro+pXi2E5a0QBh3RDW8qOxbgMc8vXM/7UsdYE1QKY2P1ff3yo+Xv52zGTeCH/tLAaRa/teuTysUPcHsnlgn/G7XaloCfOMTzWGhqLJm1Z2GtBKBSbdM1CFNm531rDavl2lU+DeJgvSJ5mkdZnjHuz6x58q3xbVoKRxUHME8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dyh4kkX1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C7vCEY015932
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l03jg7XbVLsjzyUA/wauJ2yxOhp32HR/FKDFzMmGCMQ=; b=dyh4kkX10GImy1g6
	qT///8wU68rLVT4rOhh37myDhMV0hftZLPbqNVX6jVm/STd0UKQzgqM6XnxzyahL
	dKFfjZ8KUSyV7ksNl1tA43kyxAV+NVB+gXC3RgsGtynm9i/7FX1Y7FFjx7sOuBEL
	KQ6OkwtUL9cBmFqEVgmiqDLEvIDP497JHCkeS9r9ljkwyYvm7wqTdu8u82kabmFd
	DEBCqOLnulI1grv0eP1D98lo5rxDXRnIhsB9FVgXf21THLJudu9j6sUJUGAfY/XW
	NOJn0jBiwYlJfeY+/wpd5n23tb2qxgBdPo9uanhHLe3z1yOtkNsjU2wbMIqVr2g4
	T3v12A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4maspb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:13:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-80e91c02c8cso45946085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668433; x=1758273233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l03jg7XbVLsjzyUA/wauJ2yxOhp32HR/FKDFzMmGCMQ=;
        b=TY5ZobqPw8oYNiDnkdbrhSQu3ZURKo+OVqPUcAuAU5Ao3ci8BUsyUyAlfk4+jd9xK8
         RWfmeRvwXKFtN31lD4Ubfle3n6tBiaCOhFy0dOVMwyVtZXre5vQpo3hC++2hEL02TmgV
         W2lpNDBo1PceSiWzD98B5JdAlxE8CV/Kw20nYrN6HWUUHFkAOA3SzsttH7LYG7aFjxsq
         HEhhoi8FmVCsypmWEJXHfJLB4rOvgLyXxkHER4OrNOa0DXhm7iKJp/5VuJkp6Nuw1eMi
         QFO9gzLw1FVgWlZsdZyOBimyb0igqQjpJE0lEeZfSsk36/n/wPQdC4ptmWZjKiDcWg9Q
         MV6A==
X-Forwarded-Encrypted: i=1; AJvYcCVuLRHr40VRl84qivvZGPJOb0i4av3YVhS5Yc30+anNEkCgHxcSr2y9nQxyZSTox0QqRnANMFVeuvknf+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKwTx1X3XAFDiQiWukVWBzXmRl/djVv38nXwa3PDWn9HryCAH
	MATx0Pw6YvoQG8D0NUhAlGRdahVbptytzwwQE+3oLlThmdEqw0qZdhflRZDHvuWWlzs1Kze++H1
	kBJ4ph7mStmeJ1c7+DKvO+PVIwgELylhyXja+Wpie9zLj+/DWiGf0yZZL8JsyNNOfZGc=
X-Gm-Gg: ASbGncsY0HsuMJhOdAE5Ofar5Zczc93unDRscVHe5CiCTdihivszyQ0UcApw8rKi6Tr
	wJN9Z9WXhY7IXVTLxJVKHUOdNp6cKpacMQY+/dBrFNhpNOn/hSg7PNxE/wfkJobOdkiXWAvAkSg
	hgt9v08ap09KEokbr0/U/l84BWA6FFjmQTXL04kFg4C/4cEvwV28/HXFyFT1X9e/hsC1hh5Ii3o
	YF7I/BvEI/oij+XkdO3Zm0AYnJLkV+BVON2ulxz9zLtvFjFBl7j2DkkwWXxCRG+ZQkk4TC/l/60
	zJHl61Sp7EQ7tgNBohi+aPxlTyUaOA+mp6yLzDkyyAEB5rGAk6p+E0xkqAvJq1vQRlqtA7pkd1E
	uXNeFaQD4b5Bgx8gKZmGnIg==
X-Received: by 2002:a05:622a:491:b0:4b4:8e4d:6671 with SMTP id d75a77b69052e-4b77d08479cmr19485891cf.13.1757668433120;
        Fri, 12 Sep 2025 02:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV8TvRgejfYIcKWS4JnF+RVS5QxXiaupLov7itJ0nYjCvvDQfhH2p7vyIIoxHj+cjEPYJlEw==
X-Received: by 2002:a05:622a:491:b0:4b4:8e4d:6671 with SMTP id d75a77b69052e-4b77d08479cmr19485701cf.13.1757668432570;
        Fri, 12 Sep 2025 02:13:52 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e76dsm332163866b.102.2025.09.12.02.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:13:52 -0700 (PDT)
Message-ID: <2951b362-c3c1-4608-8534-4d25b089f927@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 11:13:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] dt-bindings: clock: Add required
 "interconnect-cells" property
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
 <20250909-qcom_ipq5424_nsscc-v5-2-332c49a8512b@quicinc.com>
 <20250912-nocturnal-horse-of-acumen-5b2cbd@kuoka>
 <b7487ab1-1abd-40ca-8392-fdf63fddaafc@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b7487ab1-1abd-40ca-8392-fdf63fddaafc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX5ZT258o8udYH
 HHWPcOq8/cmHyf30spEtikS6+NR/UNvrzysewFk4bz42khj5kmjO/AGhrnuEnodgDl3AVP8m1Ct
 wpWLfup9JvfMz/LSHdXlsBd9zr5mTWRrDDTpKVSWMlwgUcxUIrOiQiqBozT0wPWxH+RWfgoDsVi
 XKzc61SPlA51xGEnK4xtWv7OzvvsOCeT0cX4U70If96q5esg+5DvFW4TA2nHQTcefgNsdymSTnp
 gkAyQrppBtNcUtDO01Qsl9Qus8GZOxDD44h7zcOOYCSWkplIaM8as0cwp2SSblg+t/J8Stn9oY9
 MRPgbxFMEapG9Oj6hU57TDlarxgdHHEvlkKpBxHdIwgIVxh6bLOvzzPRqhbjseG7tcSB19UZWiY
 /+NaU5lY
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c3e452 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vpsw6NEknGMoy4p6atIA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: zQBTCddMfqIsrKNRDfNS-0LZ3DyimIYy
X-Proofpoint-ORIG-GUID: zQBTCddMfqIsrKNRDfNS-0LZ3DyimIYy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On 9/12/25 11:13 AM, Konrad Dybcio wrote:
> On 9/12/25 9:04 AM, Krzysztof Kozlowski wrote:
>> On Tue, Sep 09, 2025 at 09:39:11PM +0800, Luo Jie wrote:
>>> The Networking Subsystem (NSS) clock controller acts as both a clock
>>> provider and an interconnect provider. The #interconnect-cells property
>>> is mandatory in the Device Tree Source (DTS) to ensure that client
>>> drivers, such as the PPE driver, can correctly acquire ICC clocks from
>>> the NSS ICC provider.
>>>
>>> Although this property is already present in the NSS CC node of the DTS
>>> for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
>>> omitted from the list of required properties in the bindings documentation.
>>> Adding this as a required property is not expected to break the ABI for
>>> currently supported SoC.
>>>
>>> Marking #interconnect-cells as required to comply with Device Tree (DT)
>>> binding requirements for interconnect providers.
>>
>> DT bindings do not require interconnect-cells, so that's not a correct
>> reason. Drop them from required properties.
> 
> "Mark #interconnect-cells as required to allow consuming the provided
> interconnect endpoints"?

"which are in turn necessary for the SoC to function"

Konrad

