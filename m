Return-Path: <linux-kernel+bounces-840925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEB2BB5BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07F954E7790
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0552836B4;
	Fri,  3 Oct 2025 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SU60i7k4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DB12AD00
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759455084; cv=none; b=O0qEbouI5eFUptBPHeguO7OnnqGpjjIrOhKXFBXtgjBoXoQuSVGUraDIe/qVaNcW/ikYUHwerL3U+r48wn/4jK2PsYZPaaeozG7LaKHqB8574yZK7tXOlnflMO/ZYCvI5KjTeFCi00I3Tm/CQERQRwHcEcVzwA2CIzVpMYVLjq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759455084; c=relaxed/simple;
	bh=a9FkrWyOH5WfgbO8iL/H4O75+4Iab83fXgGTDnad02U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FL672uen+WK72J2IbKDh+U9gvwoHzWBsUis4uL4WjV5uv74qbfqPitSd8IbUj8VEa8ECwQ9vJ3zrsDzPA1yYyqZZ4wm4apAB5MQYYd9EFNEGClXIQNeXD74iDGVz4rIpLaBUEZ2Ws++FnomchKCJdJHOLMxcJb1t+iAEBPsbWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SU60i7k4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592HJx8v007817
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 01:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZUor1GGEeb/RyaDdlp7uKfdhC1u50vkNwD9/2IV9XEY=; b=SU60i7k4P4K+3P6A
	5Gl+1FnQf51S9cNmaOZndeBtnzfFASHWYUfm63imI3LLrwAAekOiini0OIRvYuI+
	Yv2Zsqbfq+MUTLEVPIJlcq5MMOIruLpLl8n3Id/7akROVi9qOWW0VQO0oKt/fJp0
	DikaEnn/iLCBjQE/nTGVXu3X/xbAfT0kAp3TVmkJDKQExi7aMNUXAo+a17rxUNkM
	HB2+k9Qd2kqDSS7eUIykaoaFC9+fqpHYSZUI/JDjjfurzuVjfJGi6mTDmE5Zx566
	W4E+761yca4tsDEnR/TfM7OYY8Y0nK4cov+X9aMBBHRAbcSaE5TH99573+Fz1iJD
	FiV8ww==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49hkhh2n3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 01:31:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d7f90350f3so35856681cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 18:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759455077; x=1760059877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUor1GGEeb/RyaDdlp7uKfdhC1u50vkNwD9/2IV9XEY=;
        b=GOlXiNRqp8My+VbARhVCXI9N5s6V9Ly/6RFzGY3/L12Kg/CIwCBN1sIlp27rR+g0lx
         RahtJlN4Kfif47OBqw8mNbfNQwT86Ax4bKhKhTEGxdjNG5jhjr5nR0BmYyXvEeFAY4Dp
         a9tEzY9gUUwZgsCcW+XQpbTSEspO9qr1sa6u1510QLhBWG0HB7rZfPX5nxYmz3FAYJup
         fNiUTGwz7NWaQYN+Vm9XttY9ES0FL2zKttez5Kcn972H8bePPCYembmFcOU5+TB6iWKG
         piUfLBiJAMYr5FClVyHibcxNqO2SmeVvKd5edc2CoJDYEzO7iBFCU6vANiieVSeW6I3Q
         C9XA==
X-Forwarded-Encrypted: i=1; AJvYcCU2RPBk5et446wgbjuNztxTsCnE+3IAyI3i87jzxoEFZzG9aPcavsiV0QrGx6B6mr4dxSxYGv6WFArQGYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzurR4UJneb76smCy5dTFovuRtqRc20E0ko/ED2054xqvstLiFL
	RewEbQh0jZ6m51PtJTHjE2o3zhFLrOB/lCIh/wSsrrFU1KEbfbRdAx17OmNm5biWjOqhidF88DL
	4Hu3yCBRA7Ox2yguwHCgQlw/AAvJH0mHWGq5kT4YBAaiB1yeKMwjygrvEULqUj8O0Uco=
X-Gm-Gg: ASbGncsFvEtrujaW25ErH5aK4+VbvVSX+JiyudQS4MAKuofF0x1urrqXRES/lO5/RrQ
	HkyXgBZmphMZeKOzBphVFEiuyb8oF5ZcWd+5AD3HenyA3+U7dgDsWZepYiT07OHyQu9lYTH13aX
	x3WYXApBaF0Daw19ssH/d4WuDAqx6CCM99QW2kSfa5X3z7afHZ2pe6422Rx1GhL7088qykgUtn/
	+nCyBCVNq1msmY9nD8XyALG+eglqYqaSOsNI3hauimqk3T9pTVt+NmuN1Fz4YxYiljSCwZiDwvv
	I/AeSKjDsAFre6WqEENCxe+JOa8R1go9LzOKuJZg9EvKU+us4NdHtw/Fkbo5O8LwSFTl5EKtkUt
	sUSqEUVyueif7mgVoeJVFiBCr1cjWHUjLbtFMIvuTLT3gj9zqmPb5C7R0/g==
X-Received: by 2002:a05:622a:40b:b0:4e5:6e0c:d214 with SMTP id d75a77b69052e-4e56e0cd7c7mr56727121cf.3.1759455077121;
        Thu, 02 Oct 2025 18:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe+bomof5ILxDfg2K8tXvUmU+StpWFDgcoN3h5HBzXv4s84eHcidVP/7kQ2fVYyiZVmTXOLQ==
X-Received: by 2002:a05:622a:40b:b0:4e5:6e0c:d214 with SMTP id d75a77b69052e-4e56e0cd7c7mr56726761cf.3.1759455076552;
        Thu, 02 Oct 2025 18:31:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f1b4sm1323179e87.47.2025.10.02.18.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 18:31:14 -0700 (PDT)
Date: Fri, 3 Oct 2025 04:31:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric =?utf-8?Q?Gon=C3=A7alves?= <ghatto404@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: qcom: sm8250-samsung-common: correct
 reserved pins
Message-ID: <ksuinz6djsj6t4r26rpmrybw2cwqkqyv5kec7yvs3hvz4kq2qb@cker3eya22op>
References: <20251002184459.15742-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251002184459.15742-1-ghatto404@gmail.com>
X-Proofpoint-GUID: 0EAOkp3Srmka_K5L4jB9yQj66CYgOk4W
X-Authority-Analysis: v=2.4 cv=cILtc1eN c=1 sm=1 tr=0 ts=68df2765 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=18LQLPnI8caj5Q-2E3kA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDA0NyBTYWx0ZWRfX6Bxc4s02k7nZ
 RpoS+wBb5VrK9aAJKdEgFQA4es15uWu/3LnGjy1L2yIOuOBsQIpOXQNv6d/XPzxzPVhD1C+Cg5M
 ZdmEBENvufeqs4k9favYgU+t2FNTi6jtAFnJSe5gJF1qGAkU7Z7Edu0p8FrGz5LMoZFIz3GZqUe
 DDxyhoAYXp84eLMuOTEKSGA5SdN+fwbp6zSsYjtMqhy7kwMLn5oYU3zOZip2ZrRGCs+U+cRaXu8
 g7egNXnSeq+lDTbXTlSJcbS49/31OlipUejWnVR1XjM1LTZaFMfuG/In9BX1zME4+k5mDdK2AU5
 WEAXFMH6AcvrG9vxeyl78DZRXFQnj5v4NSOIEb7XGxLmVSrk1HoJiNsocUKLU/Hzh681v8ty5Qq
 SKinnikFewnpzp0IGkDE7RY00uqW9w==
X-Proofpoint-ORIG-GUID: 0EAOkp3Srmka_K5L4jB9yQj66CYgOk4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_09,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510020047

On Thu, Oct 02, 2025 at 06:44:59PM +0000, Eric Gonçalves wrote:
> The S20 series has additional reserved pins for the fingerprint sensor,
> GPIO 20-23. Correct it by adding them into gpio-reserved-ranges.
> 
> Fixes: 6657fe9e9f23 ("arm64: dts: qcom: add initial support for Samsung Galaxy S20 FE")
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

