Return-Path: <linux-kernel+bounces-865484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E4EBFD692
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEA34001D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53C34EEE5;
	Wed, 22 Oct 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c4wsam94"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6834C28C00C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149616; cv=none; b=gWniTaQyAVCQp1+QTFR6vFbl032eQ3bDRB80HQq5m102xt+vhzfmGOS2eXwbEH/sTTiIlgN7FPFpC7PPVg25Jvn1Rs1lvBZPbcgN4LcA/qz4ysFC7VFaFZTBTDwDRMTCAtHreRZhcmi1yNK4XrLztxX6DHhkKD8JaG6s39tnKko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149616; c=relaxed/simple;
	bh=hrAdyqmnbORphsl8iKrOSD8immxlH+jgdAkkdcSEhJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tnGmSpydDcAyhgpCLytk4XWd+wRRf9YASWh3UrBdX5vuFHCkSlKsXOM5zaepsS6LW9VZju1/AY/SL7ugpdi9s+r9/uMUvmnDDhU589mpUDgonXmItZd64ZfHN3Iq9kY1dLISJDceIWK+xGenXiZ8DHaoTyL/+77UVzomBoL4CCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c4wsam94; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBMxmj031508
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uwOfoThWrQGJmwa8H4o/SymLUn5pkqKkfYkaRMBxxVc=; b=c4wsam94Jh1Bqcwo
	Y1pTkg2h9eDNoBzgBLGqyXvvs5fKrjjorBgaBudnJaMh5PLcFQ7zV4qwyAB/wCMW
	iR9N9PhOpNqwZi5LVqWKWKZPivkanTfTwBLZMaMC1fGaIbNTAbeVYg4moONGIZrW
	SjJUQMJIoF1Z39pFCS8jfJon8dSozrwyG0kyhwBAis5D002kZ1WELyKpTi3uBjLa
	M/u55nIpTSIyqKuA4YB443TV4ciWNVnojZSW/aqW6OAyS1EtzvHDiWfiXMykipHI
	y7YX9COMRJlwWeHM8v79LGxagf4zf6X6KsjgOfsFDRPTic4y7vlxMCpA7aQ4ZUmw
	eHrx8w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kd409-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:13:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8aab76050so4705111cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149613; x=1761754413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwOfoThWrQGJmwa8H4o/SymLUn5pkqKkfYkaRMBxxVc=;
        b=qwAOisEK2LlyyIQmKn9u+AvTk6AIaX4DTCU5N0+puCCBiq79OrxeoAEoOeWO2c97dK
         zZ8Nh3UsstzRGpe4NLHYbjn9/Fu34dLn7Donc0HljrdQXQMeAfbT5Xif601q2VYzz3E9
         7wIhJ38DNeV1yXxvcS+xAIHr6+ACRBqLAXd420xBox78U1W0NFJ4gwn7C8yPeVR6f7uv
         iX6xxcKrIhBy7GjivMRPNQcHI9BwejuOtoaPK2szEzmBF9KsBhfo1sxCTTo5ONu/rA40
         BAJ1Pr3CpfZWJlxVM0GD50q1MdjN0HfOAy86k716VxWSyLiMkMCZapICxhTqxgTUXGpy
         KLQg==
X-Forwarded-Encrypted: i=1; AJvYcCW3uTyfB1IKbqE8AQGxOn4v7ktw1IKLZ42g4k54/mWTd28Wa2RaDt56h/IdvZu8Taw3UB7aw+2Iq1gtSP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj5gw0yqrWGYT14v8Lt0em9Io+tc3r9iRH0GrqsosIsGayFum5
	SF++Z5BXFvRFEhGU9+AUz+v9imBqhpSQwnt71NNng4o5JQrwYfrMUExLbPv4LQ62+bdKYkCA7a7
	hz/AKD7Q9bnfIf5i7fWhIN7c8jYmE4YWwedbTx53ICNgxERJVTPTG1Icgr3/Nxzp4qfE=
X-Gm-Gg: ASbGnctTdueZCUGA2ex7tuExDvTLIlODrSqMUlWEGszBYNFsTdMlPd0eUAaEHMi82U7
	p+ESKfzC5AJQ8g2fpV0iiudyVZBXCVKqPn7TDHBad7upGKV6nae80ccLbVDR9FOEZU4XjpKyv8j
	e1fAlXt6rP7lN7tjiT5fpCnzhvOPDjW0RZeEtgHLzRAtTlvDwY/wBObAyDCMm1u05LKn+kaf6P9
	zArv1vJjJyuiJdUlUTx7nHIAR/BATDbdvDEcXtBySEuXx+Vrf5YiXoXuUOewnty6NlxnUVxifER
	3XtWYHrw9JiA0NkJK6usPQ0v5GNE90+A7q3WEGFCEb4zbumjHu1rE1zKRXwfAanX3dlEhoMHFwM
	q6TkCiRHeDqqVn8gWoaBIA5vlB+UmZ66ucrapDYM1qVmeYPQFuA5vRtOx
X-Received: by 2002:ac8:5fcb:0:b0:4e4:a58e:9505 with SMTP id d75a77b69052e-4ea117dae47mr65534021cf.12.1761149613209;
        Wed, 22 Oct 2025 09:13:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5DVwt2kzigfetQGsDzASKN6va4Dtb5+lbF6ZqHWsnGkk5NTAYapVVBrFqGQGYhyiuWSEQ7Q==
X-Received: by 2002:ac8:5fcb:0:b0:4e4:a58e:9505 with SMTP id d75a77b69052e-4ea117dae47mr65533681cf.12.1761149612727;
        Wed, 22 Oct 2025 09:13:32 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83937a3sm1393835466b.23.2025.10.22.09.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:13:32 -0700 (PDT)
Message-ID: <aa705253-2d4a-401e-984d-5378d49aa672@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 18:13:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq5424: correct the TF-A reserved
 memory to 512K
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251014-tfa-reserved-mem-v1-1-48c82033c8a7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014-tfa-reserved-mem-v1-1-48c82033c8a7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fS3euv0fK1P-V0se49GeUi2-rtZ9Xcra
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX1ecNVgCy7J/M
 9D5LikLgd5ZsqFxbQTHAzUUws586TmnvtWA45wwdfFe2Gdpr96cEMEEJyWivhKxlJJs62nTk7oO
 Sd91cNcWmCJ8mywP1GzQ+i1JW2Nw6dPH4m59HXQEN65hdjK+T4TM+mt+a7qluOqCch9TREhxlZo
 TWMppDZYaGH7ZYUNvw7d2VMWFeTD0ynTMcd4qvMBOwHxPD3cQD7Y7J9O7xDzRu+lmUkbq85iHnj
 se7AZAZ/0BLEw4CINh/aVEbFPtak+jpdedzlmDPGK7ftUJY9/rZNsuIvXH4Rr9MSKWvM+6gV40w
 LD+xnhm571w0JOPFmVTUhp1h++hjt7A/W3sc/SRleSfrWygPBeRPM1OFaIp4wwjmubm71wxnmEm
 Y3rzx7NAtkps7u3A6bVe+zON1HVjWw==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f902ae cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=vol1V-uZCnnJZBBYJhsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: fS3euv0fK1P-V0se49GeUi2-rtZ9Xcra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

On 10/14/25 6:55 AM, Kathiravan Thirumoorthy wrote:
> Correct the reserved memory size for TF-A to 512K, as it was mistakenly
> marked as 500K. Update the reserved memory node accordingly.
> 
> Fixes: 8517204c982b ("arm64: dts: qcom: ipq5424: Add reserved memory for TF-A")
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
> Bjorn, this needs to be pulled for 6.18-rc as well.
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

