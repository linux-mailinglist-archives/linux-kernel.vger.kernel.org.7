Return-Path: <linux-kernel+bounces-604947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B4DA89B09
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 12:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20123AEE87
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DBA28E614;
	Tue, 15 Apr 2025 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iDBuKmGT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9E2957AD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713990; cv=none; b=A7oeBQ6JsSblAUdbTZfnEMeQqkSJRT5LZoIB1zh+mlNBNsEI0oJFzFn3Ewf4yrfI6EUkDuMd/mYa+CWaTH26Now+2Mqk3kZuD1kRcIUNV39U9Xg5fmeKwaZoil0q5oXuivsDoOnxGO211z6U2aBGCSFsf/y/3S6GInpkCbcm6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713990; c=relaxed/simple;
	bh=PqtFIuf2PaqgdiInwLbpBw6+hS8F+gVD8HwKtn8pZqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXDtpv1GMMrraKrlTirQQjIOaVlwzolemEE1kc954PzZLvBuU4ri1oD5j74sSqTs5RcrLtScGNS7S7PVS8zWGDKt6kkZ0fCrJZghnMOXRiAwLRtATJZCeBRaEuEz1bMAqDewOM9hvv2VmL2MwndxgjrkbvGrdZy0z9c35KccPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iDBuKmGT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tMKf002432
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 10:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i+0K8i6mH8nJR7NC8EwJps6/hl4dOeR4gugtJgCdwYo=; b=iDBuKmGTnPTAPIJK
	iqB49HYah+xzD6TOGA/vtjxECuaIU/PEY8AR+ZmhS1vzraTHA3ipfIoDx0vxeUTP
	LJxz3HrRC6WhFcrWRnxDCMkoydTeg1Zl7H35OU6ZgYHcLRSpxU3Zzr++8+fHXlA3
	fcFzq3+baH6i71BOo11/OgUnkE8Z6w+zjzAnvUbM1YfFihiekDkJ60ywOjiQPeq7
	0yV+L3g9ncs9+SgyHtaC7fG9dy7fYvsu7olBMj6NcZRPuz3CYfHhtXb/5ghPAMLh
	up4yTdnyfpd58aaTX6G512GmJFPXk9TyHQWt2AUosaMj0F/FEkLvvY0y/4DsAJvr
	2aUVGA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxjyjv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 10:46:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8f3766737so12276076d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 03:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744713986; x=1745318786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+0K8i6mH8nJR7NC8EwJps6/hl4dOeR4gugtJgCdwYo=;
        b=J6W9AaHPHcT4tJAllQfyNOMNpLQ0aY0CGUFnM7epk2A8h7NVwpJIBl3E5BOMepsV+M
         lDTqW11MF2ZT+zvvOCgC3g/uKUjdL5SGD1XT+Edy63ctAIwDas05DqR+0IWNyJaI9RQo
         JetsunBhAtt7Acm5qu4WLyOpPtp0RjfI4UdmlxyKn6iCbDMhTOghEzSjcGqbuom8t1IG
         nLTZNTsr07oGXzBWv37vctHXdwry+71HPDPbP8upRbv0AhUHJCmgj9M7o9QiIm43gEHK
         LfHr9gDNfF4qRcU8daJrGmISHuKkUc5XqrHMKNGEKzttuuJan8MyNQLwtRxrzzjUbQ/B
         BbQw==
X-Forwarded-Encrypted: i=1; AJvYcCXWDvcKdrBWVZGETkEGFcHSxlmJM8cRDRhWWG8c5xhNHUyKa8oI1eNtA8nF29VzURugyC4BmanfsTUDbZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk3F9V2NGkMxQuw5BAf2U7BtpdWi3nEURrPjvMaNw4/OUKZrRx
	34+UZJvco0s/YbEKBOMjPTcBmfhnr7rML08as6q9/NyuNKdVa+Lkq6yO3oms+NRC3e5fnsAUyJe
	WCvYTXf6fLjq5/wYXUG/SvQXsLOfzpnYOtMIS3C8HL0X1mzMI/J1CSpF3KSTBpUY=
X-Gm-Gg: ASbGncukoXF+WANrBCj8dFEPcMxaPXaQM3oU6u82VyI8jwqOMLCU7/ZFIwnEDoMJzEP
	HhDp1pYcjaKsWSyih4OsJrOshdBmc/3w0Td7dNGUvBdsMM/thQng9cwyUsp07T9V//t8SWUaDPO
	RTlBcDu9+/i8sgcNE9vLWa5YxWBDIXf1dFE9MO8eF1VFmNxMWRMkHtShIPKQcxDyke1NeKzcZ4M
	++ugCBErmANOdcNDqYN7E1lJjw6Udq/G7vU7p0c7zHd2tgHb29bTKkPDazoilXb+5bwE22KVQLi
	WDl4xDpelmniRasQ5vl0f+0Izd/GQjPaOLPVOVxIjI0qsK+OxC+kPwI6Rig6wo97c2A=
X-Received: by 2002:a05:620a:468a:b0:7c5:6fee:246f with SMTP id af79cd13be357-7c7af0ee0f1mr904973885a.1.1744713986661;
        Tue, 15 Apr 2025 03:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqNeiL5ONudZeZEG79p7c+URQGANzTx8RYVhmO+UvRSlx2t8pffd6eodKaeyj2EGeeJC4wZQ==
X-Received: by 2002:a05:620a:468a:b0:7c5:6fee:246f with SMTP id af79cd13be357-7c7af0ee0f1mr904973385a.1.1744713986384;
        Tue, 15 Apr 2025 03:46:26 -0700 (PDT)
Received: from [192.168.65.246] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ef562b6sm6786461a12.24.2025.04.15.03.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 03:46:25 -0700 (PDT)
Message-ID: <179419c2-9422-4487-8c8b-b58524a6135d@oss.qualcomm.com>
Date: Tue, 15 Apr 2025 12:46:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/20] arm64: dts: qcom: sm8250: use correct size for VBIF
 regions
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250415-drm-msm-dts-fixes-v1-0-90cd91bdd138@oss.qualcomm.com>
 <20250415-drm-msm-dts-fixes-v1-16-90cd91bdd138@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250415-drm-msm-dts-fixes-v1-16-90cd91bdd138@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=67fe3903 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=da4WsfccAxvekxWPt1gA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: HvRrsXb_uI7gOzf8oL6YH4HMr7C94PiE
X-Proofpoint-ORIG-GUID: HvRrsXb_uI7gOzf8oL6YH4HMr7C94PiE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=633 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150075

On 4/15/25 12:26 PM, Dmitry Baryshkov wrote:
> Use allocated region size for VBIF regions as defined by the docs
> (0x3000) instead of just using the last register address.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

