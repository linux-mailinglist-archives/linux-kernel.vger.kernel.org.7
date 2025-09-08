Return-Path: <linux-kernel+bounces-806744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B14B49B41
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23DD4E44B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286572DCBFC;
	Mon,  8 Sep 2025 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e3WAj8hx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7FC2D24BA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757364786; cv=none; b=jlyevGxEyGluzhT2qeE8jNEufCXc/H0vki+AXUcT7XGesHsLkWbHOaY9J4cf1KA+/X0f5VuDbB5iFNJhOrSpGBkzImRj3M2FYufApaLF0sNZ/2gxs5da/dq+aSxtEUcR0kVGaaXSBwM1WCgCiET1KyFUrBG2Cfe8lEZBpG1CZ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757364786; c=relaxed/simple;
	bh=LEPVDJM5KJBRhq5C3sgsbrdDWUsFbSlaXmV6QC8esSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpQcMYT7604DBxssPcw5lb7HDBmyhnBJv3XIW+2XUqkssnuBuzQEMsfuHFiGXrRJrijx/fvN1bDOIZXDR7Q9o/i/pEd8xFVDuyUvGm0babLMN3Hl14KRzTiiaXBAzq9h53Gymcj+zDt3Yxk6CmvqcEvgxR/Niqw0UDbsJjU9DEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e3WAj8hx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588DAteB004031
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 20:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2cwBnJZmqQBEZM73zk8hQa/m
	ZMI37HHNaj/5XDzx4Kk=; b=e3WAj8hxbQLWGuEpn6EP2MS45wz6U/HtBBCgJeR+
	TEsLeWpp9R1O7BPEX9HdSMDwrY9J5qmh/YVNGulPoFHdYE5695FDV7ivU25y+lX1
	9s5qpcGUeKir5n7SVSIIAT7KGP9LR95hJBV8jKwjTA1ic2chaoLWfHx0fv3vRN8t
	tgj6H3Ilz1jEVzDKO0wiOH8XnffhXZo4XM11sMLsUAZWXHweyFCYJVVVfU9NBNTT
	KBz9Yfhse0E4FLYs+iGS/zTnEkhn78EZy+JeM9YQbRN3LgPotYrwRJ0C67qwJi8M
	XX7i7OjSkql2xvVIEAQWBPKh0ROJSBsf7U2PQBcpXdBg6g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37tdbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 20:53:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5d5cc0f25so104794811cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 13:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757364783; x=1757969583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cwBnJZmqQBEZM73zk8hQa/mZMI37HHNaj/5XDzx4Kk=;
        b=i4MHlMZvbyqWWdORUogmQvHmgS/6Z37VXLPDAIs74toa1CJbCPL7r8j4EBvWb8QD+t
         IX3GplncW4itmUbQ1WkaBihepMHQCnMh/JY2gOXSBenNJNmzbv7Bi/bKjv3srWvtHooA
         0x/dVRBoBRXKbNICuMV1MJe7wLXGYqPMa/E8apBb7/g+3VtWY1L/uEl1UpzLsHxRp7x3
         ycXtSz4nTM/UT1cVTvkPjXSNKQn+5K0GsVmgzMLciLobqpT/bCRLySpkr6R0biaAtmVt
         JrJQ21A6Xy6xbYe3E+oSIvS73owP5KWE4s06m2GTe29QBsVsJf2nOt2LEUXJGi6Js0Dn
         zCRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZXUkN5HjnNNnBPl4Jl/aeOgYtdKzrKdyobW+roQrXPYnnLwRqr+wx+fimPKqPR/WRqAgtMMxa4I/taZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhm4LJ4NALipJi0hjB6/Gt3OMbJsDYeCx5Zei/61QVZ7Mwrx18
	hZJhJp2ZansFsEXfjRKD0M6qpTo05Gzl6qVb9OnD993SPYgko9QKJpwlYu0ZemK1NjLYkQDHoYA
	isz7P4oDFGEGPxlmQLzu5ZkqceuxJMkVcSukipXBAgniwhhrj1/jkh6LfyUbY275wnLE=
X-Gm-Gg: ASbGnctsVS7QrNX5lKsirelBlXozysrKITs1t+Ch/VfbZRNwF48sYjxgNj32Fq5hXFA
	wI0l2/8HwJANbgsdwWXsbuKF02+MDXpDrO8oup7B7C/cY6+bSlT4ujT4/y5etrIp8Avf2+SesHH
	Y47M3vM9MCjUuXspaR3Uawqmafpw4hb07I4VrxPqUM0xBlNvUi1NKuNPU/yYyaWikTLeiTqXDxD
	D0teTgsLok6iBT5N/5xGp69g7WlcTCLhnh1domHC68sSLhCaRHZGiaOK4KkXqhwBCKLY5iQufJv
	Q5OVouSdUvctFYB4+iRE3EcoVXwZYOYXa2Ew0bXlFeoPMY/uAMXf/1G2sVEFp6BkXqy+hIQ3IC3
	XzDFKo/QOUP2eEDRgX6R1L+hUAYpxcKqrHueDFMl75QO2sXFLzSrh
X-Received: by 2002:a05:622a:104:b0:4b0:6205:d22b with SMTP id d75a77b69052e-4b5f844db47mr118280351cf.52.1757364782716;
        Mon, 08 Sep 2025 13:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbgttt18cresQ+Ad/zQLdvrRN/v/9ChJ+Ozvktu88IRLlutb625Zv06Rrpn/u1jzrCVt+Q8Q==
X-Received: by 2002:a05:622a:104:b0:4b0:6205:d22b with SMTP id d75a77b69052e-4b5f844db47mr118280001cf.52.1757364782156;
        Mon, 08 Sep 2025 13:53:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680cce9f3csm19629e87.52.2025.09.08.13.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 13:53:01 -0700 (PDT)
Date: Mon, 8 Sep 2025 23:52:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Introduce support for Monaco Evaluation Kit
Message-ID: <sftju3vzmxu26yeldakj7ksih7x53d7jdmw7ninjhmfmjc2bci@hizerlnne64q>
References: <20250905192350.1223812-1-umang.chheda@oss.qualcomm.com>
 <175735727830.2621347.7880458499216772171.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175735727830.2621347.7880458499216772171.b4-ty@kernel.org>
X-Proofpoint-ORIG-GUID: PzmFohpKKqQ1awj4FAa1RwqpvhW4prJp
X-Proofpoint-GUID: PzmFohpKKqQ1awj4FAa1RwqpvhW4prJp
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68bf4230 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yfUVIRKG-kQQsbwJQfoA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX7d5Tot/Wea/f
 bAXhtewN38d51s7aoxWVL0yqhgaDY/Q50oY/kRyYLceWNCQPq80M2UJjKp9EOgjHEQJNriSL11k
 ZZVU+o+mnF2hMh22YdmEK6i/gvVsuz8m1ACPUmdMXd6RHesRsV8IsCTKvbuTFsezoxOUZahICp3
 poBycvHCHV3xDIruAPBrZP2yWef2Cr4r1MYeaFmxd9n5SCLIOvJfBBoGuKLPQCT8RLJqVJf2Q3w
 n42PGSO0gYtap1ESbGX1D2tyuQ0ntsuOUEv1L2EzK7TOAQTF7yM0cAneNTutuMXZtCgOOUOPUSV
 NYIKB+zNP+xA5D++wSMcKIcY/zEy6U2NGuHU5teGW3TnNhmWsM4vv0zLqH3i8ofAqW7XWXCpljH
 yM+XK4sR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

On Mon, Sep 08, 2025 at 01:48:00PM -0500, Bjorn Andersson wrote:
> 
> On Sat, 06 Sep 2025 00:53:46 +0530, Umang Chheda wrote:
> > Add support for Qualcomm's Monaco Evaluation Kit (EVK) without
> > safety monitoring feature of Safety Island(SAIL) subsystem.
> > This board is based on Qualcomm's QCS8300 SoC.
> > 
> > Monaco EVK board is a single board computer (SBC) that supports various
> > industrial applications, including factory automation, industrial
> > robots, drones, edge AI boxes, machine vision, autonomous mobile
> > robots (AMRs), and industrial gateways.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/4] dt-bindings: arm: qcom: Add Monaco EVK support
>       commit: 49e55bdbcbe0abf04d7c8c882d69755ecf43d878
> [2/4] arm64: dts: qcom: qcs8300: Add Monaco EVK board
>       commit: 117d6bc9326b1ff38591289f9677e273a9a467ae
> [3/4] arm64: dts: qcom: qcs8300: Add gpr node
>       commit: 89c85214735b633e846d8f6473fa57ba4cc11b81
> [4/4] arm64: dts: qcom: monaco-evk: Add sound card
>       commit: bb12da95a183253b619ca1691d6fd320b7e445e9

Just to check: did you adjust it to be qcs8300-sndcard?

> 
> Best regards,
> -- 
> Bjorn Andersson <andersson@kernel.org>

-- 
With best wishes
Dmitry

