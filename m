Return-Path: <linux-kernel+bounces-731517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3138EB05596
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723DB170BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183D826D4D9;
	Tue, 15 Jul 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NK23MFNS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6562D29D6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569824; cv=none; b=GAA37+E/rPbwLPdYsSjiPId1G64JrqemnuEW/dTSHptEuPHZe3BBjGBwbHllzoI/NBc44IIpaK9YKs+BWUs4HRJB+bNT6wQWW9eUz9W469Appb56NvCjFxwhEfLZD6QMlUuPy6T7uotoJVPdf8PuYTAHv+0KIVTNcCYtXeAY4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569824; c=relaxed/simple;
	bh=KNhNv8iL1vW/f8y+mhCAJJMrpgumlNJWf31iX1TRgS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2Z0RC8mQUQweMEAeIvsXeeeX7fdH9rG25CVndpoUB9SaoVRBv8mrIR7MN33+u0PWlVVSU07prrLVEUW06Pg6MiPkMKTKc6YRaUa31Q7fTF3XAHRcezAHiAQLVfRfsNwuMo1qMbRyveWoHpfPoVIp1zUCO9sUPaRAgiGM9w7YYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NK23MFNS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7slGA022513
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Ir21lKeD+kOQr7Em6XEQjan8Fha+E8C4JGKluz1QbQ=; b=NK23MFNStuBsOBSl
	Xh/xvsLx9AQjGrFXD53eJdCu5zef9aRIgbuPnjQ0WoD3jj/1oFsfe/SgNokCNCHQ
	WnwNEwFykOKplX4po92s1PHsd1HBWRQGtCNSBeaufHNLZiq2ly9RHuVtwXr3Grfh
	pjRPEbh5TLFWmxprHJ0kzfRFdLGFonhr1L0jANJGTov04tX6u20RIrPbBwn2vjjV
	j2bSWV2PxnK5Gk8zAboavkh+JT/jJlUPTwwAxuytCnDAfXBsG5ocZf6bTiWjZqpY
	d4RZWmImUqNR6vOtcOq506EAOW/T7nFdkZcqg//wFAiKmfroRpKV6UP1iSEUSeo7
	4uDfCw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxayjpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:57:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7dfd0470485so110024885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752569821; x=1753174621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ir21lKeD+kOQr7Em6XEQjan8Fha+E8C4JGKluz1QbQ=;
        b=xQ3y7MpTxutdXYD7/CEQNqnZmb5Azv3D/4MaWRmP2hf88UFc/8Y9svM+FpJUqanu+j
         lV09X3FlxOuR7iaqMGoZIQ7UDLOSkEQLGR5jT0OC43ml0XNu1/naVXnQPebN7UPUQM/f
         gHyb/D83JEb/8VW+veaQGBfvh3qoFHl3GQF8P4nBVZ4QJMrMOFNscR68mMGCV5VxPuhJ
         lT3w0R35sRfBdH9h42W7LVrjhYE94LnHRPhDonBYn269YcTRQJWd97X+fdHjejC3vjf8
         RmbYEAzDSabEbLJLtdJW91wcY2/WTrD/gYdU6kK/FckxFL3q1QrG7Dmbe79awTDBydz6
         BWkg==
X-Gm-Message-State: AOJu0YxsKbXRJL/+6gWehIl3XMEIQxZTmpKRR/o82URtWfbIDFQv7AbF
	FHtVZVnTdW4huN4b+PTE/Q+GZ9Xr/6Dpe3FKnmMNPiknt00A7II9q0OHoWO7ufRW4QFU9B/Huyz
	PnlFxNu2Hb4q7z2y0mgfAKUqOv8BkAW3ARm40APZ69D1r1W442BQZSdIl1QyDhvHeO3I=
X-Gm-Gg: ASbGncs2mk/Aka9phjLw+hAmi5hH8c6qPEv7fYXr11I2+y6onfiQLOAweJkZEsSB6hb
	aCZ8NXVLBZui77oKHrcGrYfYWqcDly+ED/kCZihIYStUgpw/w5JE8SUTrtgf9/bHmvRZgXQjXWX
	UXiPah/B5sNvDDeqxF6c3Le8DMrUH+kObFmHKzRYt5K52f/t4cCOn08Mf2h2xzldfKnuIT01WAg
	GnlzDpLS5Ceoe1kwgGoQaMRZtD5mLHUK1tODo1/Kem5lLS/e3xm0Vynk0/q4by6KGOnwK+EOPqv
	bRnmkKFUOWwkBGgH3tvOh2W18YboNXYgqDh3kEVhhBog24I653/vVXbBHib2GtpXwI/4ibuj5oK
	Ll2Pugb5L4KPb32oXFEhn
X-Received: by 2002:a05:622a:60a:b0:48a:80e5:72be with SMTP id d75a77b69052e-4ab86eb948fmr4403791cf.2.1752569821038;
        Tue, 15 Jul 2025 01:57:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECkT4UhGrfWPMRKyPC4KgJcc4XfSCXn+YJKNfJmaD2D4nOlGaLwwKXRfhVvXE2pLYC810o/g==
X-Received: by 2002:a05:622a:60a:b0:48a:80e5:72be with SMTP id d75a77b69052e-4ab86eb948fmr4403631cf.2.1752569820407;
        Tue, 15 Jul 2025 01:57:00 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91bd0sm969967166b.33.2025.07.15.01.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 01:56:59 -0700 (PDT)
Message-ID: <d073cedd-838d-426c-b134-8e5dee939813@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 10:56:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: sm8450-qrd: add pmic glink node
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, neil.armstrong@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250715052739.3831549-1-krishna.kurapati@oss.qualcomm.com>
 <20250715052739.3831549-2-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250715052739.3831549-2-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1GL3NvJI3pf0VfWiag8joxtOATUJgWml
X-Proofpoint-ORIG-GUID: 1GL3NvJI3pf0VfWiag8joxtOATUJgWml
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA3OSBTYWx0ZWRfX660VB7tf5jsc
 XetE51w1X7W40ANPptCvhDkwMBxbj+RqFuhKfiqzwgKOvpq0zMeb4whu8B4USUman5PRI/4K/l9
 qpYEHwSaZQANRnuSO+SwhBfXOdv9YhvgTsnmNMnKNtnxhYhSJNklX+ltQIq0Qe2T1aQybMVqONd
 fSBjLYL8M8IlYC8niZXaGAZ+gd7/U08ZitimoHGJVTbTqbwo9Uana6CbZ5Y15wNPoNKSnnibrHt
 1+JbDDng3iPDlAc3LLMlMtvjSXakTu5Ib5Hndgr5YDIJKAaB+f+2stJvW4XjYnZTTFQ3pvhZySL
 vBdVUIbWXZuHIxJoQiX5PCqvIToffEDiapZ1SkePYrT+k9dWt4L4Y+kt6BgBaTU4sRuQzNRuCd+
 VNFj9Vdiv+W8qvaEsDkUCptMMM+pzP+Mdf3zglMbL0DYZtg+OuATK3YVyaYQ+IjKlAWD0QVr
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=687617dd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Ipc7ZzALqdnyyRpRyTMA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=796
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150079

On 7/15/25 7:27 AM, Krishna Kurapati wrote:
> Add the pmic glink node linked with the DWC3 USB controller
> switched to OTG mode and tagged with usb-role-switch.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

