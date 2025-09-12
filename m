Return-Path: <linux-kernel+bounces-814742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B20EB55809
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209437AE3A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0695928C841;
	Fri, 12 Sep 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YgG5eUwo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7304334363
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711139; cv=none; b=nldnH08kNLVYUsJQej+n4+lZjvGnkPXGhL2twbCjt2HlnCVLybbFiQCsToQYQq6zf2ig0ZDuG2AZifauU99wirxWQ2BXf15WHPInXkrmCryj3eUCG+2wKS8CAX/WQ9Sqh9KUr6H1j4AQc10xv+ktSuAktOXjcbGS24cA/OkJLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711139; c=relaxed/simple;
	bh=tAKgUDssB2Zg+/L2UJaRq55G33qRsupCF9DvLWF0uL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGPZDQg7gCKbKh89lw/Z0vDOs+wKOkD2wbEHyhvxRNyyGuulUghyEz3XZbiwYTMn30danhk8Qn1fq5w+6eWZYy0jb4Y928NoeAKOsS70KbsI/UKYXiim7Djp3OcFJoSfpqjTm3IAgcyckmwTzg9TOoQ9uiSEEz9TxxZhnWx5Z7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YgG5eUwo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CHNIqm012842
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f6x45dTFSIMJV/gJWuKckpagRMD+esitL+Lw3qTQiUk=; b=YgG5eUwoIypKISQz
	S3iZ8dryEFCU7L9bIY5x1iq3uIv6ymIkOmPeNnHca4X+3aVlPvagBFvQv9khD2f7
	dbviXKSxuMoAaglxDZkFhI/6RweerfDJxanl2R8S/b4UDKBUKuFj5/wXZMVPnvAs
	PkiaULnpAHyFMGtnxEDCIpinpiE8bEJxRgGEZjdQQp67f9hN0Vd6RCC/j5MO48lQ
	McODbKSYYi5XBZ/PtaZyJUd8q6ESW6orIrH1a/MH5BgzwmxP4F2lB1ern6n2Egoy
	0YsUd9GOkgh20tdc8ZZhVa/LiNH7s1gdQuMAgu11leBEqlW1QGkxA2Hk8XGP4N4l
	0d3+Ng==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqgcjkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:05:37 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-71ff3e1256cso66026326d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757711135; x=1758315935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6x45dTFSIMJV/gJWuKckpagRMD+esitL+Lw3qTQiUk=;
        b=to0gAyZME8qUUKdPx18VlwF9wXzWiST4i/J7SLw+mTmMZisNdNgBnhD8p8XHZKzLlm
         yK/1tNspuZmM1qgm/hn3r1myLTysd45Psc1Db/MaW7Dtl5LJuBZZLsq22C4wXndFnKO7
         o1uaKV9F5jw5BMKVscMu641DM+pHr90LjRAde7mRbvFqG3oSCoaILmgDm0cXYWVYIrxw
         lYieQ2Ljrv4U09z9aVFt4FcbmnT2elbucdI5vUOjXPpJlCO9pcyS7vBs3R3OGx0rrCz3
         9nmtyKtOmbGBj5zMEOI0inULY4il1zwqiNLqL7FApFJ1wqy04atrfdViZ0M5TWPH7Lzy
         nnGw==
X-Forwarded-Encrypted: i=1; AJvYcCWxKdOiAblrmmbrpp0UnvhdCnupTLOHgnkaaoZfISX+sfpFXwvky52Wx0bvAuZHJPKGTLJboXK4Xw0UBhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI55IwkFvIuhLUcUo4uFx+xKC5l7bB6i0rJ2+JjK7V40m5kFXN
	CygoSOv/Nx/V+satH+OuPh0khk0wQ1Tnbpaf4klvfZljU0vXsScHh3HHFwDq+rtZyFwOzm1/N+i
	1TqAAdJFtAwAewzJljbhGoObiqxFaBz54JycxUGfhLSQt9d4KiDYJzwu9ChWSx/0g4aySdU3HJm
	A=
X-Gm-Gg: ASbGncvZvIlCCVOnrP3jgk6e4ZXypCUF5ckq2YiaTsLf4/ZXGHuV5enlAhx9Q1GPzD2
	nYMkxznVPL4x9Q9GTFoybTUaX0R8lQtras3k9F0104G5MjivBMV4BJEIUqrwZtePSro7E4Vp6YS
	bQTy26nLavCilZSbVaFHK1B/IdMpRz6wI++IJins89VAeZ+XUg+vLLgsnaAoXgNBukhG+ARiLJH
	nEuulQFh/+4BXrT/DtA6akW3HXhgyithMyv9RVzEtrljh4HbUn4hy/stl6GYcNwnU3+xXoWSt1n
	vrlRd2KSabrqZvKdrvV7yY5lHIc7VztzvvWg71RTt5UVc+Ki/Z5z2PIsdH9hBqTU1grpDOoJhi3
	RKHstKIbXBbdTtwAFYdaAbS9Xmzk9Mw/gMVtNmSMosDQsWB/I8sQX
X-Received: by 2002:a05:6214:5298:b0:72e:d34:573f with SMTP id 6a1803df08f44-767c215fe50mr70481056d6.39.1757711135347;
        Fri, 12 Sep 2025 14:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnPEfmxh9SvYDKqxVQYcOajqc191SHlEL2DXweV7tBIxlxuRMvWPEoACAWRiuFYSJsB6Xgsg==
X-Received: by 2002:a05:6214:5298:b0:72e:d34:573f with SMTP id 6a1803df08f44-767c215fe50mr70479806d6.39.1757711134456;
        Fri, 12 Sep 2025 14:05:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63e47sm1413683e87.80.2025.09.12.14.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 14:05:33 -0700 (PDT)
Date: Sat, 13 Sep 2025 00:05:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric =?utf-8?Q?Gon=C3=A7alves?= <ghatto404@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/1] arm64: dts: qcom: add initial support for Samsung
 Galaxy S22
Message-ID: <sbushql2kigkpuqdgt5w2b5jdim5h2jk3ncestgfgyaloqswpk@gf4pakjdcp53>
References: <20250912202603.7312-1-ghatto404@gmail.com>
 <20250912202603.7312-2-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912202603.7312-2-ghatto404@gmail.com>
X-Proofpoint-ORIG-GUID: pf5ES3Q42lRAl2XgPEzkq1A9ivMa01vj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfXxPKYTd+qJPap
 BYbG77Xrs8OW2WeZ4+AH348zpNx53pANsVTI7kq7Y+iW36mSizN5uls7T4wW76Khp/ZvqyBmRR9
 8lMMuJxK6830uSH7+eqdZ6MAINZ7RhAL6qlMct4+/k4kcwoGoXB1gX1uD7lqqGBklSKHi/K5hlj
 zXYowD80H/BVj6OLFeOh3GgwGU8CubnDLPDOqLiH91zOm+OGEIyGQTHkHucmW9Es5ZfsVYy/+5i
 dmXUuipqiqyBs/GEt+5AdikF3tsQrc+HFlGo6AtzKxoWHJ5Xwt60JBtzxGA4+3CTKbUitJYlZlm
 x77G3+Rvjc7APNEffhuhmqCqS292U6iJ4Onpw9Gacs6+orT53HSuCtm02YeltDSKXb6CHyn8tM6
 sr3ddzNC
X-Proofpoint-GUID: pf5ES3Q42lRAl2XgPEzkq1A9ivMa01vj
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c48b21 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fUB9F6JP8phhdykgREMA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On Fri, Sep 12, 2025 at 08:25:57PM +0000, Eric Gonçalves wrote:
> Add new device support for the Samsung Galaxy S22 (SM-S901E) phone
> 
> What works:
> - SimpleFB
> - USB
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 145 ++++++++++++++++++
>  2 files changed, 146 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

