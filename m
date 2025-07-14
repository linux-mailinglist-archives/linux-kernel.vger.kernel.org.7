Return-Path: <linux-kernel+bounces-729971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0A2B03E73
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A4267A67D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7261C80B;
	Mon, 14 Jul 2025 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KfbNB7i9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74D1991B6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495372; cv=none; b=JdggbwvdN7lt6nCYBv3MKqXulcJXUHnR+8axt3T2IYaFKhJtkYBw98EUOhGp7ZKVwE5y/VAh9vNYMwtApc0CyoOFY43CEKVpVkovbl9hCl2ufZARowVNCFdpyspcf9bTS0bq+n5ktOIq/NRDXKYtKvfO2HNDeD4DR6u9tvSqIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495372; c=relaxed/simple;
	bh=Vyeu+QiMbOwu86RKcH8fkphcLeAnnuEM9Fw6UpjuzrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pl2lvIqVwXoyEe5EljqTem4xOjbTFHBcbc/0FBIDPwqYRA+f1QjWSPDY5gKBV2PScAwDHGv6RTz+xZUw8pm3DJEpCTFR3YoWjl7mQdC3k/xuH86vLAfECWqfNQN1gGQncCMu9ftG8Cmkrz9UQvl25/heNEZi+PD8zhhuF6hTKAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KfbNB7i9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9iI9D005981
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EdRSmpVGBOQnwqugOp0k7YiXL90KQtzCPk+rW9r7tLA=; b=KfbNB7i92g6NJVhk
	DwC2UKjJSwnQnDOMTnDM2yXjXmWcY4hTWJPdpAZEuDVVz1mT9BtyvFkqBgh8BqvI
	uX3rQhQhy2WU0BkwcDrrm2L6HGUW1KbC4ZmpkFNKkYVdArwymUOD5fBPgzZPLf/G
	nzzYSqib0jkA6sqMg2jqHv+SRY3GIF2wN4ZedhSgB4gDPLr0EgiYTSntSIUP4v43
	6637o5qF8mYRxM9hsD3Letj8A82ffEF33pjwF0mv972pou7B7kejqT9edMVUKwei
	f9wcWkntVnGEvz84ntmCPJupYleEa/iWiQ67sKi5D5T1ffA1OJnY+bKRn6syKTkf
	oKJMqw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxavnbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:16:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab5e4f4600so860941cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495369; x=1753100169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdRSmpVGBOQnwqugOp0k7YiXL90KQtzCPk+rW9r7tLA=;
        b=K+d9FIzJzwW0VuZ8uQCh3odEUHPbXnJOwWbgkQNo/iC6gM2CJNSQtjzzJAyoZ/bztZ
         lSq0KSUji9SOf9pw19F5DoNY5r+QQWuuFIuVxW+KaP98QWsvO1Nll2yFsz1jel+iGa5i
         75S6BkHnsbJPipPQX9mOxsdI/SweUosayYfb5uS5PP04c2gsosPG/8sCzZ/Uly+vGbfu
         ys1dmPCJRnrSZpYBILDtbnYCS+KkZ0PHAF7hbwJ/zWDxh/WOFnzdaa6WWYRKoMv1K9ep
         XTgq2B3dySsYJBDprhNqA1mVSvtfn3sW6OmsKXjMUk+nuD7iDiPX6rDaYyIYJNvmQ/Bx
         VliQ==
X-Forwarded-Encrypted: i=1; AJvYcCURUjoHgVbiFUzfdn6kUuNs6vYT+MACK+/OYsnuMkjGAUq4GdB9060HDxt/9/yqJBxO8EajOJGh1WokX9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLkytdfYTD37vp1DSKn42TuvTUE+yEhdnjqCQytXUESWq//7QX
	KjGMH7Bp3gJHblM79R3J3Kh3XlEWVzFbXjkU/3H6xRAI6zHnvI9wgc66mAQyBuwPpMXcTBchY8N
	7ts8ldG1sfikvHtdCURzOd3D9UcquCIojZkGjOR3m9B3OBBUOJdqw1W6JvwTATWJexVU=
X-Gm-Gg: ASbGncuqilPCO3H2DRPcPmrLLm0NYabQb5Km/R8NRD5tHGb+5xzB6EjSDQg/KtcR8Qx
	+zP6Cfdt+wLtXqzwBGQMBGtcqXoG8b9Kvpu2AI8hXG2FB9eTXW6f0s7dunkiphYVJcQYkNDRCja
	cpQ/UbH5cgYO4/v2l4D72yrDELmYxqamvaDfgXN3Uc57JmtyfzYkZ3k4NfFqmvnLTxXOl5FzfuA
	kkW9x6S+M2fHq4hgTwyY4ZWR+BeVK+6saW0vqqi1tZJYcneeVrLD+8y+iHASy+hw6sjIVOtiOMm
	mf7cmS4x600MgigmksieM9tBo9iS2BJKgh5Daoy60Mur9h4uB4Ouh6vu8HUcRU4ePxC2fDixizP
	kg2GZezgJxKcKl78eari3
X-Received: by 2002:a05:620a:a003:b0:7d5:d01f:602 with SMTP id af79cd13be357-7ddebf7dab9mr655449485a.14.1752495369214;
        Mon, 14 Jul 2025 05:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqDFY2LUDJWJKJDllYLF4aFMaNOU6OwD93goYemebkVnOeOPXbah23nYaZ32vbmOeya/kHoA==
X-Received: by 2002:a05:620a:a003:b0:7d5:d01f:602 with SMTP id af79cd13be357-7ddebf7dab9mr655446585a.14.1752495368724;
        Mon, 14 Jul 2025 05:16:08 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8313036sm799472766b.180.2025.07.14.05.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:16:08 -0700 (PDT)
Message-ID: <0d60632e-ad2d-4dbd-bf48-7daca73b6347@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 14:16:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: x1e80100-crd: Add USB multiport
 fingerprint reader
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
References: <20250714-x1e80100-crd-fp-v2-1-3246eb02b679@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250714-x1e80100-crd-fp-v2-1-3246eb02b679@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OolEHZSmtOEAwL-7yzCUXQr5exTaHpAO
X-Proofpoint-ORIG-GUID: OolEHZSmtOEAwL-7yzCUXQr5exTaHpAO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3MiBTYWx0ZWRfXwlNM7/eycWfd
 qxwO/3gcFFr3y3ObwStNUjpFU1eHpUANc1caq9gDtZjc6q8ghYqAzgHT1r6zdZKxIZ+GKJQYll8
 9B/c6hV/GDufDWUw+ltZ3PTS8fhOSTcT8TGxs+b7uAB3fdOKVD17K8+iedQB3j9llxckPjuzW6K
 Cr61Ib7n3Hp0EdCdfzOJ6V5xxUEMZ9WSLxBACMpL33K2icDTOMIfs8Gs+SBiSehRpMoJc7Nq1Tn
 uyfJ2oyIXsvpmTZ8OpOomFBcBBION0/MTjn4qjrPef/6ua08/ZqY7OlBQim7e2IGpdKK/H2y81z
 AJU0ehvLG/iiOYNpR//XrIeKfdVoMbvyjDcHVquKIags6/hWofqwBTQtxTJoYFp+Pk4QLPqsxSu
 7nu11a6O0UE2cVXf7qzoCRctwFzwPU7FMhmHqhfP+ALiL5EnauYZ3bVoJBbuHDuVzmvDrkXU
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6874f50a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ZM3GxCyrS3NlQnMyuMUA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=528
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140072

On 7/14/25 1:48 PM, Stephan Gerhold wrote:
> The X1E80100 CRD has a Goodix fingerprint reader connected to the USB
> multiport controller on eUSB6. All other ports (including USB super-speed
> pins) are unused.
> 
> Set it up in the device tree together with the NXP PTN3222 repeater.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

