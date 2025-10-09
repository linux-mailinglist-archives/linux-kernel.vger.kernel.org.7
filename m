Return-Path: <linux-kernel+bounces-846983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B80BC996B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0E63B301E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D899E2EB5CF;
	Thu,  9 Oct 2025 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pSnJCb/8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39E12EA72A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020932; cv=none; b=iOhnXjMiTN8+TQVUD3u5l2ez/xcbQ33UTwTGZ1LfH7F2tio386f0v5FQ6+zc8TFuiL02O6nGdVEp2jquLPC5MrGH/WLapxmJoVTPY9hu93J3heeXSs1dM58tdQg/CUq//Fr079lQ5RTKN0frs2py/XH+nLp7wuHc1wlyl5GxjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020932; c=relaxed/simple;
	bh=QZx4nVpAC3vRxTaSdKPSim4kZsjFCKfjifLXoOWygnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3bJRxEBTxK3u97VO9rV0jFwCa7pViYoK4bHmU6zctCeq2OuWdrXoODSBOH8NUIvDw8FKzzzyQXzJL+veFKPIdNO6vPc4ZetA3hh4z2y1+9IC7iXaPyv9CxgJpSuBNhOHSn7TjOWW0WjI5YC0y02oYaLpTjXnIyxSmqUo7svFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pSnJCb/8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EO0e029759
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 14:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jJVTkHydqKBrCSgwLkXUZtm0
	Z8WJjCWEqwuofJXX3rc=; b=pSnJCb/8DG/0imYlcFsnOQfpkVy0tPFrexiM27Es
	VwcAVfuKZcsW28YbjfY3vQeTC+4jNhfUITg0FTmcYCSN2jPbp8EkUf/UpIsf/ccf
	JaA30ZkS9Hajd8P9dDBfeuYv73sNe899yjgqxFijOnC+vcTVTdUv2MgD/6TFH5Qv
	XcmEez6z88xhOlvKhsgbzDNb3FAZoXYiz0aiVrc3oZomrpWgSl64UbaCyck92DLn
	O4PzzeBfDuXWu/Af+lU+FunV40heM5uZHW7lUM4t8aP0XD8yfuzo7/T4CjBwsXI2
	i1kvBccJ9G9JpM+/n4z8dBywPjLlRUknlSEpi5iLG1+Veg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nb814-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:42:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e576157d54so39638011cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020929; x=1760625729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJVTkHydqKBrCSgwLkXUZtm0Z8WJjCWEqwuofJXX3rc=;
        b=vtG/y4mjuQKRcw+39Et5pLAMN1Dk25B6k0poTw1BESAQfGXW5o6w/uRTbjXZQHfjJJ
         wBP/CdHv86oH2tM4MYFUtU7F3P01yGMpKP2pqnRVjqcdli4lgQbtAFAe6BKyWDak6xCt
         /Cg08D3ozoRaGabXZrP/vkTtdJgbst9GMe1K8pRgUKgNOJO3qMsAsbKArlEvX83rH5gB
         U9s4fhqOADRA0Uqtsl3U3J8RYyJeRpjoikGX1hcBizAdSnF+tK+Sromx/b4SEMpvAu14
         IPQ191gYHEilqhY+uFQ3RMFCMgAUJETD1leTGe9OS3Z+Xcfl2qap5VSH5vgQBCcQvm75
         G93g==
X-Forwarded-Encrypted: i=1; AJvYcCUlcKS/SM3P3oP1GzJi9qyXAnZyq5t4IpmbXEzjA0h1tfn4z682qbzmHC9X4wfJ5IpW7fs/OhiSR0rjmCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdQZdLJdkZEj9/MJl+DE4ggB5yIpUbAseVb3R3ntS5nVkPJ+Xa
	CgvM+nAudXGi30NkpYuzpReO0rsaJ3fuo4FB94+tkhBvEii9BbQE0uABIdk8WOPKb201M4feoyE
	/v+4pHwSPbcS1Z12ZhydEXpVNQxCsYGWyk2aSPKoOQO+jphuYjVCFsGLrir9OJs1t1Qs=
X-Gm-Gg: ASbGncuxITG1o2Mwjb2kwYb8ZRStxOJ0tBLWEOELP2xG5IWx37j4P2sP1nPYBujDyCX
	lPUr6rM7wPi4Mcncb1lID09sKFwdNhRMFz/28DzjOXTY59fzddPOXgXBoigs87ziw2zQ/h34CHz
	reSbL6IszrWoNs1tOhl5lih2JmVfyEvLi4T4vXRtOEFAgWJgzZfM9cqPq8qISnLOWvkec53k0yR
	MhSIFqaHqB6PfzyZTwmTsq5+z6wfS4lZFfFivRBve89vtoVU8XOT98TPJjSgOc0z0t9lVeLK2CA
	5UbxXJx0jtQHxePq2BquG2cwiQi8Qh/zdyB/EwcHsBkD8yrF3IV6TcjcZWBT14vv8PNiU3xBmYJ
	PsU401PK6cmq69PsgmXXH8yFMTSjZdoX8ZbaNVaH+PdfzIKhCmJKG1dbZjw==
X-Received: by 2002:ac8:5d53:0:b0:4db:347d:edb3 with SMTP id d75a77b69052e-4e6ead712c7mr91268461cf.80.1760020928672;
        Thu, 09 Oct 2025 07:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNa4QnjcuKYB3jwjG7GLdf7ymSiMVsjch3Pok5PTchB2g1Op9BuA64It2GGfI8BAkwpNNtAQ==
X-Received: by 2002:ac8:5d53:0:b0:4db:347d:edb3 with SMTP id d75a77b69052e-4e6ead712c7mr91268131cf.80.1760020928280;
        Thu, 09 Oct 2025 07:42:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ad9e55esm1097574e87.78.2025.10.09.07.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:42:07 -0700 (PDT)
Date: Thu, 9 Oct 2025 17:42:05 +0300
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
        linux-kernel@vger.kernel.org, Luca Weiss <luca@lucaweiss.eu>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: qcm6490-shift-otter: Enable RGB
 LED
Message-ID: <rnlkxpm6crulpvfleclkszio2fms7t3ulc3rpsdozteml2bak2@zvfuyc33ohez>
References: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
 <20251009-otter-further-bringup-v2-5-5bb2f4a02cea@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-otter-further-bringup-v2-5-5bb2f4a02cea@fairphone.com>
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e7c9c2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=dlmhaOwlAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8
 a=_tRjzsPFGxlTNT5lhXYA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=y4cfut4LVr_MrANMpYTh:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: rg1jx2BzHyBpF1LhRsu1SzX65tsuj_sG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX119o2HdwiKlf
 WnyRSPoq/t+f+EfICVgq4WWxID8EeMyhXozbIqubcFho6XZwO/qICRPWgoZlxmq/X9iUeQLIhBy
 ejEKYY0kcjTkxwiidSdnmXotNS8tqFt9OvZ2Jj9E8Z30fGi1fhu4EiZmgYOtBLYrxl8AAaf/VdU
 tQBvbs7Opdai6mC+De9nVzjZlHtx7Zw3zq1JtQKMkyWlPdMzAvjL/jn0vqjynznQ048p8xevcge
 gv1owhtUotjpAYSkfGiGa0c/A/nh9NA3+YyCx3t7WUUqOlsRDPCxanfq5+A0tyqfU3Ipzs4OP0p
 33K9/28JmMCh3bZNivXqPq4IPS4q1JUJSoYgg6RtYPfbzl3FCw81odz8FrO64YIB/fH5esyZmzB
 wX9C54TAVgezAT3HbQyR7lpMGQqQAA==
X-Proofpoint-GUID: rg1jx2BzHyBpF1LhRsu1SzX65tsuj_sG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 11:06:35AM +0200, Luca Weiss wrote:
> From: Luca Weiss <luca@lucaweiss.eu>
> 
> Enable the RGB LED connected to the PM7350C (PM8350C).
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 27 ++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

-- 
With best wishes
Dmitry

