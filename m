Return-Path: <linux-kernel+bounces-873769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B11B3C14A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E33EC4F8ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B63A32E159;
	Tue, 28 Oct 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SFo07WM1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A3F314B80
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655060; cv=none; b=pIzCVNA9/jvvkYbqy/qOczbB0WOKrMjSBf2iXPLq6m7sWsQqDWIETWExCJCS024FlNXMnYDQ4HLOWdpe3dAyQlmGPBzn2P3QeZKAMXYEUdstPhLsAzGKdelXgPIqqS9gKwfDcadRjmoNxdCfZEH4+VLSyUuCnDSJaFP32rpCuDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655060; c=relaxed/simple;
	bh=yRm1M4TIBj43blkffZ7nQ2I5bVoIf+kji4IiZpdTrOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkg3bcREYBqoQI7hndhdJdvIZy1CTT8FK7nY2O9r4a3hj6DxvN72UgRnDTY5cJPtaXr4FgB0BWNGK3LPhfVvHg3hAvI5zjsY/Z0dndLha2k3xll0H0bLjV/qOtCw8oQZW+TYu7vrI4StiaJRWaghCcOwdt/IhXkePQPgIhSA+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SFo07WM1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SBVhEc591619
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	99LNhlXT/Af4jWAmqi3dTiwpeXStpX1VM9hPDnHcE78=; b=SFo07WM1xZXvw6ne
	hobDYBjFaEpkuXV1ZznJuQL1JiE3anQ56oEubgn+8M55A2yiJKVrEJ+zq0NriJxb
	znXVVzJSeyR3S/r0JG1odZNBu0DRs1UJ9YZfZhBHwQBNgcppgmIk4gNqdOhxopNI
	gJxV41WpCQbsbavoasXjYTAfTMrpPvzwlSRBbFxx6GUlq4VIZHSp7rLMf6KjE65F
	sTjU1X7DjBb556CrFXH13RqluHulalRcHK6A+YrS1oaOPLbkRCeKgTCfAtuuvjfQ
	Lr/7h2gM4Ox0NEYqYkf5rIw3Tes+zGGFPiSBbXnSHje2+z/nzuJwRTlbfyGD+RO3
	rcC4Zw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2q5u9b6h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:37:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2930e6e2c03so62714445ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761655057; x=1762259857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99LNhlXT/Af4jWAmqi3dTiwpeXStpX1VM9hPDnHcE78=;
        b=OJAEccKPyenNAJTeWysNgVx/LRLs6VvEma2P5PGehScTNX5ZEa8KUcSf6EU1dQKZKd
         c5mE2v7G+4xcEe0JQXZvM6Kh1+O7FSSJ4bdmt5sqYdkjNF6AZMD+2n1FrpnmZJZrQr6C
         pFhcpwuXE5Srbu7gCvL3Bju+2eSCSMbA5q9aMzmActLh8zy81X+LrY7iOVzL4OxJXr2M
         vAZJxRFNZntejbn5BIoqZwcNdOTbQmZk4RK6sLEYpTmSCdaCOa9RThRmNCoiuI574MSw
         260VWvxs0MgCctUWDiT8WOG48ebE0Ids1Cy7soDHrySIQ6U3BFKdEu0q6U3QD5UgLikc
         DZ1w==
X-Forwarded-Encrypted: i=1; AJvYcCXXHiE4OguEckf2bwoL81IWeT9f8d0C1GT/iylaO/21U3ck2gOsLrPwBj2LycKs++7wNrRfDH6gRLfFZzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxihAomfZq0W3IoBWaAccuQr97t//Y16Il0KXcqngkDV2XHdZ7W
	joYfDp60DC/9zGze/f/J6txJcSwurh1KrJiBPSNLjHU3fw6HrnR6G0NWIzliiXVex+5SGB+kENY
	/uvytXuv9qvbJxntO+T9t0+iIa7k1kU5eKh1tMXf6mySs9i2Qb6WBW/pJHZhUZF+2+Nk=
X-Gm-Gg: ASbGncsbrTqg5BIx8PdljMAcz3GEDGntfB6vtWXZ5OTeCS2J/O+Z2nmxyS9voAHQCXR
	k1M8nvwWw4h7TyJDZ2sHHJ8nvMno/30oN+tfOVsnW0+4O0qLSRjHFxBapc+loFqFxsD79QKW7wY
	lkN3RxfZe3VuCE+Ov+I21Rzkj1FTk1V+ra6u4Oi+V+G1GQ8WDngMZQel0K6HO7kzwivmfqfv0ws
	A6ffmt9KCU9xlzCWfEgOILDXbcxFHAwMc9qRDHKrmJsGYjjzL1gVe2FcJh8UipDIsnmIwNR1Lag
	67rh1NUt2JaEMyvW062TwiVFeehg7hk8Vd/ldA1Lqcrb3LfSBLPKtcMGeEX2j81UfqvWOc9SmFB
	tjOBHBVQOW4zsaEn+q6zZtC5tm3nJ2nWQ
X-Received: by 2002:a17:903:1249:b0:290:9934:fd04 with SMTP id d9443c01a7336-294cb4f2ff4mr39101535ad.28.1761655056931;
        Tue, 28 Oct 2025 05:37:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAZgHhxzDexQDBRyUSfiT/26LH8xsFk+GPIEhyz87W5I8sZgDI57uvMcXyG/B24K8RaqV4Ag==
X-Received: by 2002:a17:903:1249:b0:290:9934:fd04 with SMTP id d9443c01a7336-294cb4f2ff4mr39101175ad.28.1761655056359;
        Tue, 28 Oct 2025 05:37:36 -0700 (PDT)
Received: from [10.204.100.217] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d47ffesm118301755ad.87.2025.10.28.05.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 05:37:35 -0700 (PDT)
Message-ID: <90902474-0e93-cce4-0024-9481c6f305f0@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 18:07:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] media: qcom: iris: Add sanity check for stop streaming
Content-Language: en-US
To: Wangao Wang <wangao.wang@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20251027-iris_add_sanity_check-v3-1-232ad24d75d3@oss.qualcomm.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251027-iris_add_sanity_check-v3-1-232ad24d75d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDEwNiBTYWx0ZWRfX0+5Cf2XQcGVR
 R6BMuxxIiRZhuJmZ/9JhR8Nsnmk7ADQO/zoFAe2ZKMw8CYA+O2yhMiZapVPfAEAfsXJX/NWElNP
 XKeGpmBTTX/IycdG5DLhqK6nvdGsaZOWdeTPR+xxGWOTP9WAylHhbI+naEoGZ3lAvfyB0Cm2jNA
 tvTS8LOXzadikMIzisinZ+PXer0ILVaS+OymTyxCuHbWaBUlePMNDY/H8rI97HGr2TWBEERZNJt
 2J8yQvve7QJEAqGqqNgY/CD2V4PmGavfkFKnY4lphOal0Vk1ZyqqbBjPxTlR0o7dQTxZIFjXh57
 KrVRK+XwyE1f9dnPhZeh4uoBiT2eC2pgLQJrnHcCwTzitxbfd3e7iccWNMq8ZPt+sfaFMWRDmoe
 8P9jqCdifmKQIR/MtOd/YPkBgxZ6sA==
X-Proofpoint-ORIG-GUID: qdETeA2GTtVoQJe6JtCw0RExTDg-24M0
X-Proofpoint-GUID: qdETeA2GTtVoQJe6JtCw0RExTDg-24M0
X-Authority-Analysis: v=2.4 cv=c9CmgB9l c=1 sm=1 tr=0 ts=6900b911 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=N8j6xNqZg-U2LBr-iOcA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280106


On 10/27/2025 3:05 PM, Wangao Wang wrote:
> Add sanity check in iris_vb2_stop_streaming. If inst->state is
> already IRIS_INST_ERROR, we should skip the stream_off operation
> because it would still send packets to the firmware.
> 
> In iris_kill_session, inst->state is set to IRIS_INST_ERROR and
> session_close is executed, which will kfree(inst_hfi_gen2->packet).
> If stop_streaming is called afterward, it will cause a crash.
> 
> Fixes: 11712ce70f8e5 ("media: iris: implement vb2 streaming ops")
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

