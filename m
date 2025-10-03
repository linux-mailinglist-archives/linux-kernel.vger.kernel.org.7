Return-Path: <linux-kernel+bounces-841120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED31CBB64DB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1AA1AE073D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E546283FCB;
	Fri,  3 Oct 2025 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MduUiZA/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20F1F63CD
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482282; cv=none; b=sJVcETFBHP2S3h2IAm9YPNxtC0kL77Y1xbJx5aEJPGXg+TsQStw0dP9Yd99h1C7tbJGUGjrqaXyB5wSLVr21gn80YOkNt1NLq40ddT4doQFv+N3R7qhRnQFNg/I1xGtPSZXabHkPoKXJ1fWfbOldvIvbkqextA05jmDtSpSD+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482282; c=relaxed/simple;
	bh=BuT24nSXvzllvHpbGMwermrZuD8IyeMFRfXE9Wlb4xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ko1grJCcYXR+v/kw/UZhu00ogmsDHqkVXhFXRDPH3YV521TKzMmaF+ShuUx5cx5V52Kxa773DYsFIZqtT3oWbCAOYL3j9tJXEFE6XXGlT+doMHD6Ixm9zd1YteyJG+/uk842kUY/5SZKOB0eHwDV2f1WDf5pTWUBJJmrSdauNIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MduUiZA/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5930Rovt028774
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 09:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qLWZtUs5fVCswzg3NxSw0ymwhU21Dbhg4Nf1Ubu3B3k=; b=MduUiZA/NDh0Esax
	BTQNOqyqAHSO9Vww0gxpBsbXOIuZarsajaYJ0+bKqzAo0SsIoR361XBB7Q1bb2dv
	cjha7pakwKPu/H8qK/+RQeMyzcDwULQFXUqsYsovoee2e1AgUIFv8ytwfobSQcTW
	bydV0EmrlfK9UojlHtOdWSR87KzUCi1bcRrY6Utfag8uHkTJMif2H+s51F/XXMz5
	KaQ3WIBHJBb6Fd2NvTnZ5EY8X540f4AiwsMVS2P23ThHHUwROzf81d6Ah68OLcb5
	BmVVWLmfr2xAUatTbwu9YL6IE06WhRIXj0ZRNDjEtM526tRKC7X1IDncPLo+kox4
	xpeUiw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59naqc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:04:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2681623f927so19149295ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482279; x=1760087079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLWZtUs5fVCswzg3NxSw0ymwhU21Dbhg4Nf1Ubu3B3k=;
        b=k2DHywSrABqQjxYJ8N6cYpTkurx7M1q4iAxA195jkMpy9GPfkxDOjafIS68GrpqLeK
         OpsR/5eSdQDa9/oq0eQRfJuT/J1iwLzW/Mvx8oqOi2fim94wMqzayxC/s7Ny/MOguss1
         L7RfpMcmkDDQKGaXN7E/gzNsQt6sl6U4HO5TK7a3hT3e8/KT5nn2G5pf2GcmT+q3Oj1F
         sKrcQwmn2A74UZgTT32mo+5KM4/29CGllJ72qLPZbyu0u44Nyc67rzenyRfj+agVJQcT
         Hrk4W5MMHFG9Gwbh5TX4xdAQtdxSFCUO4VIq6YQyQM+BGBrq5q0AfMDF5kS3HxmJH7n5
         nuMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdDsj4zxrnqPMuS4XKxaZPIT5ByxWYHI2Zx13n5Lzr4i0F2Zsvqpwx2ZIg+a/6Z60M2dflacwHj6fDfHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDM4MrgoWm0LuysbIJjAMxdnUwroS8w7V85wRlSfBtWwA4zcFo
	/NeyxRVSz0iWuiWkrI8y1f6kLWUg5Hv9hn23EtSa2sllJ+DmVtRsAAP4wF50pVWTpq/igEAss/6
	XwnEdmMBVugrSiBtdcDemC90fSJBVPtp76+I9q3bAr1D8dSaARA6/bf9BEM+je6zK5NM=
X-Gm-Gg: ASbGncuaiK/Iz6QRo6Mwqb33IEfSVF2fZ+9i2HkbewHhzGwjswLZORPpJMeUwFSFFvK
	aZwpSACac3zeSOmX4qeipHXgdtCvzt0kkCRCrbhpunBtZXHSZZAdc0mCPUEU6TcE7e4g52EB+t5
	kYFKuFy82IofY6SSL49F+UOrU1/MCDXWs1HLdcodrpawgbefR11kzFluQFTClufiJkeb21Z2gvK
	ywg/1HI66b4uRDN0i+Gdb5tbs9lLYS2r30rumpG4+byjgXdrLihVuqw5F+PM/tuqEClaw8mJnjY
	9hmsSZaJWwhNOm3d3C15KFdTubtwzS59gKF3TVmkPZT8etr4mJR1cv6HPT7GRmX5Ygp6+X+qlDx
	dyw/GHo/cj9bXVA==
X-Received: by 2002:a17:903:fa7:b0:256:2b13:5f11 with SMTP id d9443c01a7336-28e9a645c5emr30186765ad.40.1759482278650;
        Fri, 03 Oct 2025 02:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8osZ94IBlmYS6mfN6OxharIdntATWBnaR1H/rolxzIfSfK2AidWvRxzbO2yAgkm6oFVwbqA==
X-Received: by 2002:a17:903:fa7:b0:256:2b13:5f11 with SMTP id d9443c01a7336-28e9a645c5emr30186365ad.40.1759482278141;
        Fri, 03 Oct 2025 02:04:38 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d95bdsm43659375ad.119.2025.10.03.02.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 02:04:37 -0700 (PDT)
Message-ID: <3cb50330-effc-4089-b80c-d454bccc63f3@oss.qualcomm.com>
Date: Fri, 3 Oct 2025 14:34:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/9] Add PWM support for IPQ chipsets
To: george.moussalem@outlook.com,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Baruch Siach <baruch.siach@siklu.com>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Fo2I3DQVvbzGHZ6yEuqHG2ek6uJfYFN2
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68df91a7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=MaTjDNABAf216yt7wJUA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Fo2I3DQVvbzGHZ6yEuqHG2ek6uJfYFN2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX9g7aCgOYhjgF
 wm5x8wUKI8JrTOmcLeBuxRG9jXacQU7lVpsEQ2LSeffen6fPdSIZxeCEl1Umikc2o6Drkm0xRuq
 XD9VebhFocuY/0C0Y4oCPTaoG9tU/xccdkufYTB794z3L0/iAbezpdqBjilwNdl4a1lTScUBOyc
 7zII1F0EWUrlmbt5kRDW1MVT/j+V/kP2dv3JsZujfUWIm76UIjDio9YKrly2orZVBQOMAFjBW9J
 DQFc0/CKWJjT4GE8tW8eZHjEU0qrgfDyjckApIUgPNi/7nR8v1isfi6ZutpWXgWuONJgkStA0dm
 u7PMX/qqKnwUueETJUVOLf/jFR1FbQGzAI6ucRGEkhvgMfnhcMnOSFY/18SBhdDKEfDe1VYQY69
 35zh81FURheywROO+2RUgw2z2PPLgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_02,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001


On 10/1/2025 7:34 PM, George Moussalem via B4 Relay wrote:
> Add PWM driver and binding support for IPQ chipsets.
> Also, add nodes to add support for pwm in ipq6018, ipq5018, ipq5332, and
> ipq9574.
>
> I've picked up work based on Devi's last submission (v15) which dates
> back to 05 October 2023 as below SoCs are still active.
>
> V16:
>
>    Removed reg description in bindings as the offset is not relative to
>    the TCSR region anymore since simple-mfd support was dropped and PWM
>    nodes defined as their own nodes, not child nodes. Updated the example
>    too.
>
>    Dropped patch to add simple-mfd support to the qcom,tcsr bindings

George, thanks for taking up this series.

Can you elaborate on why the qcom,tcsr binding change is dropped and 
made the PWM as an independent node? IIUC, it should be child of TCSR 
node. In V15, I see the qcom,tcsr binding is applied and *dropped only* 
due to dependencies / lack of information on the "pwm-cells" property.

Thanks,

Kathiravan T.


