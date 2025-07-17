Return-Path: <linux-kernel+bounces-735432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1DBB08F36
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBFB16BC13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D042F7D02;
	Thu, 17 Jul 2025 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AuuI6zuY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FCC2D8DC8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762460; cv=none; b=Qtikg6ANkMDHwcJWuVUD44cS4w53pvNw+hxl0B7PM7kUd92z8rsBWeNZgsuj3RYePQDTQ/hOpOKRzsBmVyVCFue/PZXqh4yo8Ht7XwoNWmB1AV7QCy2gGtrAY41qDkxtT28avoElsZAxPj9Y7UBDU1cN7Cd3Cqo020DhFBulhpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762460; c=relaxed/simple;
	bh=Giia1zcux7YT5W/j1PgJvxHqUXQxyrJ3hWTfSdKmYTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFyU6USx48o136Y3pZwdZpUq5HG8tJ6tJdZOJbeKvNS1OlUe+nRtyh/VhfNWKu6RIayaEoMWrFo0drd7FXEcLhn8I7qfHH1oyfvTgkKHmUHf05WOXY/dtLDyMBBrgcMVERYVdSYATWhGe3YjoLmt4joeFfEI88DoS9b7jNGZe3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AuuI6zuY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBjQID002924
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jBFJBbIapGojYSgQNuCXD6Rtrv4L7r+GtYk2FLS75D0=; b=AuuI6zuYN+331Q/N
	pya2ZupuYLuIBMdhuMlE/67DY6ORp7pUXZtWz4iWRACZQmLt35M7X7S2jmEc4kmD
	hXucqj2X9hdozji9PzquDvskzBwD7w3AT4H8gVXj1zCqz4f1scQIk5vFGQohUXel
	tAeKwtvoBJqafkZ/LszLGyqC6n5uLWepTNLFdtAuU9Z2qRKRHcIm9NQuu0FzEjgf
	Yxj+oEweL83WV7sV5i7tB6fwlDz2s0Dpx7SXwY9p2xPc/2RRYlNLMDZJmcw8hIPR
	ZP3vz1+Myd4IXFxg9d4jGPxWAcVywmCuQHNm6kj4uwixv+lOW3wItQaIyW/qULUL
	oGY3DQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xsukstmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:27:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6facde431b2so3016146d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762457; x=1753367257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBFJBbIapGojYSgQNuCXD6Rtrv4L7r+GtYk2FLS75D0=;
        b=c0lOd7r9q7hZg7RLw/aUXBXFy9vh7ljbOAdJbAN/dG+dvaER4egAJmfECOs9ZR8SIb
         cIXjfBVVuWUTlJRmA48jCxxdvFiH5KaNXAAp4JO01MgZwoTUjOf/HmEkavqZI07e/YIe
         OnTb7DIKw45/dTC2BBQluLiDC+xrt5S+zXgZyfqL5a8Wm4VkRM/wouMSlFDLWw3faZkU
         cGrP4Kt9vTjSKvwjXa8uCBi9jKd6OSKFmjTDQg8rbR2AaJbkJVFIYxrYyA9uAJHVrcSy
         lfc/jUWWVvhYGBvNPHlF4xSn3XKmvitwzek7CUPMTOLPkjX2zpmmTwDXbwdOA/QDV3m9
         o+RA==
X-Forwarded-Encrypted: i=1; AJvYcCXW7nNrwXLkjzAZl9I34lrVpub2x7ufPha09/tJ8TIWNg6JD6DEUateawH6ouGtlqp3hmS2hVC5Ikjp/u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYTorJdArfO2rXs7wwj7FmPqBw8qp61fQkBgNqW8oGvJYrgZh3
	uH6waZPb50pa/unPzp5bVJD7Bqex6ZkRcBMyByYoMS2qjhaGIBz51H5JUoh0PkYk5gvhhaDEMB/
	iHDYORNZULKV4QkyaesLXEo9TiMSUV5UujwJORmExN+ux6EWPGLJ4NR+f9wXYj7PvyR4=
X-Gm-Gg: ASbGncuydBSLRBwWINooZ3nMRrSh4dqjmeu43fqtYiwHByqlNrCokty81glPNrZZKrU
	38kVtZtm55fdb8zEskLcsxUIc9yJUj/H9LPPUBgfQ6vcwSU6a+HEcGi+FmliNk1BYWKhwWCK0oW
	2tSrLp0RFo3ja8sK0mWCPhnwF6DW3Uu760BR4hY+O0C8nYyN8MXYrTDrmOD/4h+ngsR6tYxAVfE
	6amXNh6nlCgg4RP3CJlwUCGeBl6OmPpOOKcVSttYlfIy4a3OBtPpTSs9AK2yKHHIR1698WOimf9
	XkVYh6Suy02T0E0wzGFs3NE+DKNvDtNFo21QxrVfxun8HgILMDIUv9mJsRFd55bNitiJCwGBwGP
	WW2vTKYdHkae02b9/Jc7b
X-Received: by 2002:a05:620a:1a9f:b0:7d4:4353:880 with SMTP id af79cd13be357-7e342aa89e3mr435558185a.6.1752762456659;
        Thu, 17 Jul 2025 07:27:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwTD42e+PjHQyFrj0UD6uthkWAeqqyE1yXMhHiDxTiWgju1pnmMocBVblEWVBkf05S3h1Gbg==
X-Received: by 2002:a05:620a:1a9f:b0:7d4:4353:880 with SMTP id af79cd13be357-7e342aa89e3mr435554385a.6.1752762456010;
        Thu, 17 Jul 2025 07:27:36 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7c09dfdsm1361278966b.0.2025.07.17.07.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 07:27:35 -0700 (PDT)
Message-ID: <2ed06cfb-2b06-41ae-ace6-b404878a97dc@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 16:27:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm8150: use correct PD for
 DisplayPort controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ling Xu <quic_lxu5@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com>
 <20250717-fix-rpmhpd-abi-v1-2-4c82e25e3280@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250717-fix-rpmhpd-abi-v1-2-4c82e25e3280@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IPARD1TlONGQUn6na9v_BT_RPGoE4wKG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyNyBTYWx0ZWRfXyTSPQTVkdiYB
 paFnWuP2Kh66f5KdlRpQNTA0eVd3I7hDzyasqJGEu+TQIg8iz/bt7JcgRApNebdEo4Gg/LH8YKB
 JfdwqgXTmZQQ5AllmJuIUx5l/wu/Q0KUtSErHQUNd6VbtEzKOsq/eWm401ZqsLpqN/ZEYMaDjP5
 gHdK21E5IYss8OG/YgsrS/rpFAgOsZzOeFf2Z4XQN1IJaAv+l/7YY/okTvGeQAiFxsEjEAgwi9L
 VT+IU4gK7c99kE02lwTNKdjDSa3vJlxwSOy5N99aCcN3DaP1O/9pknzS4d9lEBNO+ME+wi6UjqM
 D7+53Tmsd3u+vSyECf7aBg/AEG29lPQ4jHoJohotiSsRWAWMrxbnQyzPtDOdoIKuYx+A/IJM0MS
 1h5/wkei6tgb8ZBe2zlG8uEV8aEA0UYEQ3zDQV8SFyhwdamNd2IU6iiLMoKQCDGN/7JDWSfB
X-Proofpoint-GUID: IPARD1TlONGQUn6na9v_BT_RPGoE4wKG
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=6879085a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=3MXfoZClvQzxQ6RW9QYA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxlogscore=774 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170127

On 7/17/25 2:48 PM, Dmitry Baryshkov wrote:
> Commit 5dd110c90a50 ("arm64: dts: qcom: sm8150: add DisplayPort
> controller") specified SM8250_MMCX for the DisplayPort power domain,
> however on SM8160 this indices maps to SM8150_MX_AO. Use correct indice

81*6*0 typo

> instead (SM8150_MMCX).
include/dt-bindings/power/qcom-rpmpd.h
90:#define SM8150_MMCX  9
91:#define SM8150_MMCX_AO       10
109:#define SM8250_MMCX 6
110:#define SM8250_MMCX_AO      7

(i.e. the commit message is misleading)


Konrad

