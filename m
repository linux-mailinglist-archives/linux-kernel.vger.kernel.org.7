Return-Path: <linux-kernel+bounces-846978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3BEBC9935
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C747C4FC516
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C80D2EACE1;
	Thu,  9 Oct 2025 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YkoKfHHz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048792EA753
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020867; cv=none; b=TXDjzjyM3CLSr3pUaB+LsqjzDsHrRbmY9FxtHzaPIEAVO4FxovztHEKiQQn/iHyeCuvtyfSoxFprNT8FK1TtJBtO7P20zDy1UzpNzbFJYasAdVmPUVrgd+IuzpTdc9jb970nl1qTT8A19XmO7jAKSNuFq0EpSH02rDdO1IHiRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020867; c=relaxed/simple;
	bh=gJD4F/VUtyf9cPnOh0/z6nqdkyZqGE2442d7pVCtk5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+YsRqa05Fd9p6naRLvezyV83nKLRcqbAiwPmFTzUnSvRrlXYug0WQz08Qi6MC+EdrOp4DgMBk6ONZsY9JPnJ7kzklRjs4BnpjNvNCE4B4ZMS5tSnx0YnA8Qf4er2pUlNsLwFpKnE8x+ast3EDaGHNuBS/Ie+fLE81YMX6pMjVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YkoKfHHz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EXo0011045
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 14:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cE4ZbHCvUDpmT8UVULSVyNyY
	hgMn1RLMHyhsCsq4I2o=; b=YkoKfHHzQPmes5X5Lu7uBUVqJ539HybUmEdJTtNs
	mYRfymI5GNrRBZovHKlnalSNkYlMHKSjqwnoTeJO/1qKHtL27T5x9HHrJZmgiI5e
	M22xHnZS7z3NNq4D8F2wzNqTi5Z5QK0k4ggwg+4tC+j5+2wUtU2OthJvqKUjbNXa
	pFzTLQSFqTahf0gRoxPQgpHQalzx5K5clJ26++Arwh1Lo4yaS/t5/7FBdDE0BWFU
	atFEI2TtmTaL5plnap4dtdza/xhMR1m5MvItzmyoVeOy5pQiEGfvDob11DS4/8oq
	VB89Mc4Th3E2JqlfR96ntjKNXtiE+9qX3UyVwEBipgB0Jg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv9ab72v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:41:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e574e01ed8so33467581cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020863; x=1760625663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE4ZbHCvUDpmT8UVULSVyNyYhgMn1RLMHyhsCsq4I2o=;
        b=JIbDd2yqaDROpUgloZ4Oce/m/Omn8Td2uz2z9lA4COnxfK3BxlM3HTIA1Z5sTpN2xJ
         M7UUmFkavBbRxSnE6d+zqFeYlJ5lme1/Pw8bf3TyLkwymPezE8SwKLljlZjj80KPW67X
         zgQvqpHBXqnIF5JVd8VRTNStvXoYyhvpCkT5LTmEowbDl98/4m9AJdogpT9kfSrso4C/
         dWUPkXkAkaf8B5l+SAZ9ZvFB/FlYND0el6ZLq+OkdQGJh5Lb43FCxbaL94+sqnwWUGOb
         /uMmNsb2l9fbh9sTrTYCAa2wZThDSF+N2zFOFgPVzwTu16nKETRya96f3ZGGIlk59DWo
         4n8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXD86ouJ1rnA9Csl7fvRj3nyrvWMpiJk+8a0tYMA6WkYHnFVLGjcCU8LTniHZZWDV4OjiSc53GG+9sd0QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMa+hz6Wf0/ZnG4B9tvBp02v+XIGDzsxQByNz4Ers56vUuKjWK
	KQi+ktWU/kALc9XQrgRiLdejWSSXS39QMyt4faAPc4WnfXo0tBEuPghYPu9dcEDIJLh9i96fsKZ
	KUPpFuflQGOcNcya/qY4Bkoz4Ds13D//OQd5AHEoaii7pNMjQhxISSlxeUr7moFFWmTY=
X-Gm-Gg: ASbGncvd1OCUIsgSfbUCK35DSSw0RLAMBnpLexQhBz67zW2nxrQGVY0gF8chn1wt3nD
	IGBGyCkxOaD/EN+Y801UL1cFV4auUE7dDNbvLKhNAnFkZZmVSLVLeQR5l9RSC5WuczG377y8hCV
	gMsF+nvtkdQm1rB1J3Kdzd9PRX1M3ngyRy6GKYSxlTftM5eqoGEq1qHSsaGr+rBcq2kzJF4dNmq
	lKEeT5RcfcUuz/5W36NNqRs0wj2nAy01N1Ad2rlT1KK4E/3MnwGbWFZNP237Xw+Du+medqyUB/m
	e8uETTmktpO/YNhp0WjRGYYsfDn765jdV/VW9xx9KEjicvje809Z1mBbm0s946AT+dkD1G2rHtc
	ta+OUcnuLCi8A/BgRx1zCiavlQb5usMMYvB5Z0Zc/+itvqSifzcL0eKyTpg==
X-Received: by 2002:a05:622a:4d0f:b0:4df:45b1:1547 with SMTP id d75a77b69052e-4e6ead64873mr98220451cf.69.1760020863083;
        Thu, 09 Oct 2025 07:41:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm/vMZ4n1+Cr8Xoyx5rH/NZmEs2uEEJqGMiK56k8l9LCNH4tFsaMchJrEpi+ttYXYEnglWzQ==
X-Received: by 2002:a05:622a:4d0f:b0:4df:45b1:1547 with SMTP id d75a77b69052e-4e6ead64873mr98219731cf.69.1760020862443;
        Thu, 09 Oct 2025 07:41:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907adb2607sm1093116e87.97.2025.10.09.07.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:41:01 -0700 (PDT)
Date: Thu, 9 Oct 2025 17:40:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/6] arm64: dts: qcom: qcm6490-shift-otter: Fix
 sorting and indentation
Message-ID: <4zflplcqdjbkplu2pb3oy7pc24svrlo6id5kxr6g4ivvyrxh23@j3bfneurfaza>
References: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
 <20251009-otter-further-bringup-v2-1-5bb2f4a02cea@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-otter-further-bringup-v2-1-5bb2f4a02cea@fairphone.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX6yp9cCzfR00N
 8BvUfgyet5S0KGHj3Lx/IsV/4GvTVtLMjJxxaDCFCQ2sjYRskzmz2r6XYRDsnHV5gsno3dQDoHr
 xdBFcm4FsUuCnw1+hYJsgYSYab1lemSgPvtbAR+mYJZS2INAj66jWmu63P3CYYxgv/51g+LV29u
 igU6ywVR6QdCqRubxoBzMU7z1I4xJkkOghGyMVnB4xU5JRWi+R4aOs6PAPiHnLDIm6Uknuvojx4
 gYEyiuqwss4fXQxBAlDIUpLHQxzGne/zMrSVyqlcldWK8dt4kFlhK8MO5QM/NdkgCa/M6ftii6e
 /NSaQfTNXT1PP4pCUlj+I6+Ff6o91J/N04tpHEJE1Q9pu7v1wFNWsmRQ3sJnl50yc0/3mwWlq4A
 DqP4HwIgOt8ZHVDq7KNHnrSG5tbgbQ==
X-Proofpoint-GUID: b4d8vE9Lc3Ttr0ltsHRlungMHpdKISi8
X-Proofpoint-ORIG-GUID: b4d8vE9Lc3Ttr0ltsHRlungMHpdKISi8
X-Authority-Analysis: v=2.4 cv=JPk2csKb c=1 sm=1 tr=0 ts=68e7c97f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=7Ovdx5uLAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8
 a=0jPwT5uaXyJb8NjaZ-0A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TQZWkJv5rNK5-PaLMsrg:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080122

On Thu, Oct 09, 2025 at 11:06:31AM +0200, Luca Weiss wrote:
> From: Alexander Martinz <amartinz@shiftphones.com>
> 
> Make sure the nodes are sorted correctly, and the indentation is
> correct.
> 
> Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

