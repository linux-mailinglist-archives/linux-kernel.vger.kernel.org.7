Return-Path: <linux-kernel+bounces-779490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A12B2F4B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822BE189BBFB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4592E2DC9;
	Thu, 21 Aug 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Olv3mpHm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2602DCC04
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770347; cv=none; b=hGOCjwyNyf98AdNsRRJzYM9JabEJr3i0RMUYneqk0FUtLLNPIJ1tSykWH/7gRTVToHm1RIBcdqAxJpy8jT/+vBXYiLHrT/Xsr/ILX52FpqxBbEWjYCI016qbCxJvDALYu/+LflI2MrtfbPHtT/IRmZWjcduf/YU5ag5SkJ3ZBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770347; c=relaxed/simple;
	bh=l/NtW7cb578qaTBDBvJ9NTzgh/dMB9sTnHrrP8fSiPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChkqN25NcD943PP7vY0tGn/HQo5Jv9QI1rsMixoJOo1AiCpnc6MdVjKJ7f8Jv5CNBath+YS4rUvFM00mQLCFdccmcRX9p+HQA4B1mlN4EW3Iwi4Gtyfce0MHZIXQ73GpKItuM082aLwYcvEUn4FCR4TJQ6pGssJzHoY0WDMQalc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Olv3mpHm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bEv3015298
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FXI/5DT/xtHLK1kpectqnLhs
	A6LswuB1tPQGIZ/4VWo=; b=Olv3mpHmutfPHl8XlYtnzDTAF89dQW4YttwrDlZZ
	yQSOeJ5l3SFRS97WeBNbHFLw0Swk+Gwfhq7+72YsypR7b6K343IVAzfbzui077gt
	rEO4tcZwGd0RRLNsgYI18yUWsTc1AzQLLdm/+P7vPXXYI/fJgO2AYYumNYb9u2D2
	jwIP44CSHhAAETjrjgPAj7Q9wvw7qrn446Hm5fmcUAArqVUqQkQz8B6hM4gi8pQA
	GpWrSyxXvlHpAEMDVLtdmIkQnaurg3x2Fxdd98+EtfCTf4J59dWswTWiYml/Vep8
	P1mufBaz4vRAvctFqD+pnyiZW+sviS+CD/JwTK7Vs/76TA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52cn0qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:59:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c4d944so21205611cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755770343; x=1756375143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXI/5DT/xtHLK1kpectqnLhsA6LswuB1tPQGIZ/4VWo=;
        b=Mw7z9/anxtfqafZW/2NumTmChOYoK2St9gU8pSEuXn09UstN0Cr48IJ0UW9PNufb4x
         2UfZtBplsqN1AgULxsuKWfvHbJ9Mq7ta1eRintbqWxOOPKrYwo/b70aHF4b9EVgneYSN
         RZgiwAUFGIRLGZMDHa9eqlxW5GbMfzI5onlcOjF5ZDLLGlQxkd93kuDEdUVj9jlO99Pr
         9Y2OhjvG6BJcT1v7SaqeM68xwyELg3MjjdvCWpV5fTm0zLKxunAi54psJBKl5V+ea67+
         Sy7x/b3exmeMu5VuA4ceL45i+BITe1qE/AF6AdOTXMYfcTDhlmiyqMqWK5RORzU3HnQh
         EXwA==
X-Forwarded-Encrypted: i=1; AJvYcCVQF30bbpGh9bV3R6oI58CeDGPv0v8ENHCJKehSGU5pRAhhV9q5adcoNJJqWlg7HMPZBLGU2nx8UFjm4nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQSMth6AL+hYbjMgKTUv+XH3CkBaMT/uus0XfzzjMoaYjAzD9
	G/qWr64dhDeBJ2L1Hh8+WCV/uYKN1rN+WC9rbZlFeceH/0t6z3yMyjd3SF2/KcdkkhOnS9x6eP6
	vExTmMlWFMgFZt1MNkQmyu7yv3z7hAXA3rwdAk0orQ6G1/5EBowxACPtmUtn69Yn/Bzc=
X-Gm-Gg: ASbGncsUC876pIfIeHsKU99iJ9XZUE2Ez67KFKAyWvpA4aB1ZC0kF4H58wM9/vpncXM
	l0lRFtnm0W6D0mob6lM3NgZVJaSFNV8Y82ufZyCllDuZU61zHGkfGHAPb31FJUlSYOPKsJN43Ub
	4PPvO1LHhRnKuGzI/TQgOAp0M7kLOSwedIA04jlIugCAhLKiIqWV8EagR/T3HVqp/rX/u/8XdGk
	0rdqAoz7Nekgyh4tO+N4uhNqSmTLAZGR272ax4D+5uuUfKj2nOEhEhzxZygXjXDUUusTaND8zlX
	AHviChtilIlyIhzt88PocqW0fClWNAKCOvjmnYrCPIU2hHxdMaUjmu1bSF6vpS5UOwSiJJ4Y15L
	JQr917SOqdyp4IMwJJ79he64oEtd0MDzqvU6J4sgAYuW2eiXz9eXj
X-Received: by 2002:a05:622a:15cd:b0:4b2:9ba2:fc62 with SMTP id d75a77b69052e-4b29ffba308mr16012161cf.79.1755770343005;
        Thu, 21 Aug 2025 02:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElIYmr0N0AiGl1wu6IE+VRHpKcfdrAf0kSH18uoQLdDO6TswnURy3mcmPxlB62zWOgBhITRA==
X-Received: by 2002:a05:622a:15cd:b0:4b2:9ba2:fc62 with SMTP id d75a77b69052e-4b29ffba308mr16011971cf.79.1755770342560;
        Thu, 21 Aug 2025 02:59:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef427218sm2947556e87.143.2025.08.21.02.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:59:01 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:58:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Fix slimbam num-channels/ees
Message-ID: <n7wtrddc73fn2g3kh3gre33vhr5o6qjajqooczt4h64n64u7bw@tztkbyk2l7dp>
References: <20250821-sdm845-slimbam-channels-v1-1-498f7d46b9ee@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-sdm845-slimbam-channels-v1-1-498f7d46b9ee@linaro.org>
X-Proofpoint-GUID: RpGFxtQJ1zhaZ-nUtAYg6OzXrfYQ4IzF
X-Proofpoint-ORIG-GUID: RpGFxtQJ1zhaZ-nUtAYg6OzXrfYQ4IzF
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a6ede8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=olf7o6MLa9eKRqKXNWwA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+UyQ/AuSZidp
 0eY45TWAY9c4/5gguMgRg/6RSp00rYuuIo4LzdLQZdfA0jHdRwyg3svbSvqnt7WGZT/oHQOElte
 4uu5SdQS/0yNG+MVb3MJWORNMtyHCR+dEDa0nnCvT+QKNG/KmVBaTd1AFCr99+hcxMc23eGmpJ6
 Ld+p04dsH37tnazWxeQKCEPNTkq3YC85WkXozRxc7aOfC5kK8g2874Bsb6FYSHUvFZUXMrKb5L3
 tHWKR7nMAQbntVke+NtSr2zl7E/AhmpMfNM2Iwv+Q5rUtBuPAixbdHQyKQjvh1wf1AEMG+dxyBM
 YpxmfttoLAl763eEFZb7s7FJ/dpMyjdEMrTqe9e+CjozEcU81F3MvvYna1Ibht2bu3pc891ohvO
 a72bO1s5SAkTluCGuEzMSin0usDIbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 10:15:09AM +0200, Stephan Gerhold wrote:
> Reading the hardware registers of the &slimbam on RB3 reveals that the BAM
> supports only 23 pipes (channels) and supports 4 EEs instead of 2. This
> hasn't caused problems so far since nothing is using the extra channels,
> but attempting to use them would lead to crashes.
> 
> The bam_dma driver might warn in the future if the num-channels in the DT
> are wrong, so correct the properties in the DT to avoid future regressions.
> 
> Cc: stable@vger.kernel.org
> Fixes: 27ca1de07dc3 ("arm64: dts: qcom: sdm845: add slimbus nodes")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

