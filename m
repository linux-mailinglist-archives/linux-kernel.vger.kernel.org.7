Return-Path: <linux-kernel+bounces-778288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D483B2E3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E71A2410D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C945B34166E;
	Wed, 20 Aug 2025 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QZGc/RFP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F36C341663
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710344; cv=none; b=hUwTwKzIDpg2RozIiMV/t16ue2RFxMJc1ImBSNjSS36rNBeDz1mHaQxCiuLTPX1wHVkIvucrjkdLNQtgaWTyOPMI1yl3nF1pDPWETccnZ5faRs0BBTdkBrZwTurxtt3p6AsgCkr4gl/5HL8cNBJOAw4LHwTvSx21cEDL5XB36oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710344; c=relaxed/simple;
	bh=G6X07DMJoJGHfvSbycLea+tudvMXf5oz0RpWYgY0qMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiK73rkaXuD0ra6OQglrlHjd4wG+03ZPBEv8vKQcUL3IR3WOYv0wk5SNciT02WqB1t0HQCViBZazC12q8YK12jh+wLQFC7LMAsGWLG+O5sLC5S8k9EUQQt+G0ZLj8ppy4k6ljenL7dJbC/pTddE0lJwR+GhoksHfPSAS5EX6Yq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QZGc/RFP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KGmsnc015598
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=D4c6VjJCxHwNMdHY8pDWjWO0
	85ZA1m3/u33QomEdPGY=; b=QZGc/RFPA8AMae48g6OvIQGNkf3YiSAQVucXFO9f
	qtb6l585YnHzzGlmjmWsDrhEn4ljF3RlTZMZwyDgvNxpaxLVFcZTfiJQqdMOeH9E
	FLbM6mlrihlzrxjId669nd16XbZ/JXe2WZMfIoZdB8hMXUtKy9o6pMX3QK1djRnI
	VWF3/Rgc8XR88Oa2wHM0cAbOKcf4q2GgmRbYrVNeadAytIG8kLefHEhOu69ks0j0
	BfEcx8akS2rRni/0wFmPEbuQHp9JXEJP06aepQFrYYoJcto12jqPOGup+dXQmFEm
	9MNZhdNAqpib46BnlhCMJJnT82u+/sN7ZeKtbxMS3HHCqg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528tghr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:18:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d7c7e972fso2662576d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755710334; x=1756315134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4c6VjJCxHwNMdHY8pDWjWO085ZA1m3/u33QomEdPGY=;
        b=k4e+V7s98Na89H5fyOWH45bo78cqp159BbKrZ2XXfBoz639cg2PTF5Ua7Q3mmtShGt
         FOsXEDnERm1XiUhtVOwvvKBUIzlheexvmrbTn8vgTgMRuO9So6u6+vF9MJUvS0nSJzHr
         RnqICdkrf8H3/Zd+TfI3NKg9oZmM++GSlYZ3eTXmTeAUL8fpYY4/77Og+AIN440N31Lc
         UdQH5CcNx5LcDXbhmmBQCWBYU/5o1ctHidyTAcT8QCm2c4OSxLmFqoAX+JQgWS8g3qiN
         f4cCObC/pJxyUWeWW4eej1ecDWqCFkYkK6lgrrrEboEkwO6AVG/SSWwpUBYCKZ6QolLE
         Z7HA==
X-Forwarded-Encrypted: i=1; AJvYcCW3YU2zEj9B4q4/iNWBJtDTh6Nxa+xDsagc3T/noAX8SE/wVxs/OVfV9JRHWF40Gy9unWW1DesFiMSw0gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTeMtSQ0W6/3LlBfe2uqP8D90cX+j9Czkh5SFBoTogVhhRWDMD
	/onsiIzDlz3xyCHL/0bdCHLytuVbpT2VpAjmlq4hr2hszVYwY/oYZksqctstD0OyPUo5HeB05/X
	ykEYwu6DEO4NW5HTpi7ajyr/2j0yHHSe7KvRPfHBJsh1qDgwAYG8PIgazakVRz3GB0P8=
X-Gm-Gg: ASbGncsV1Wcy6YANqhqoTYhyzUttLrtvsPpe9rFIeu7+RM1EK+gDlhUqUl5+1/lcIN4
	s5x24eejEJhfk13OcUNepQdvdK4/tGGLn546gYlAg5jEzNKXurzivZ84glx1PBuHFoDapb8N/hr
	Ms0R80E8AxtIbRQALVk8VlRuIaf6SPsF3Ja8buvWW7LN2UHIx7BBSIzkGX1HmVRjNcAgg61+RW7
	JcEjFI536FjwnM6ChRRgTzGfJ3ITGE/af+KwBbej4ti37lYzDWOj/zifWj66Neen3Fl7Yl5YbQn
	EKP1HpV0UM7luABS2EFoVaLiUz+1tG56xFrL4IE99dYtYLUkEdrXWmUjItxvRjLswOUqLawMKLR
	monSO3sKLYzT23FBAvaxa1Zkwnp4pn9uLGKSq9ztvYYVkTomYfJQh
X-Received: by 2002:a05:6214:21e8:b0:70b:af9c:d0ed with SMTP id 6a1803df08f44-70d770ec90cmr33161676d6.32.1755710334173;
        Wed, 20 Aug 2025 10:18:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJMbKVOPkMoNV4lYsAx4gpHUcgozCfe+fx8N/3mB2f42zwfWVqWvV8n+duLWyQQLwTizWwFg==
X-Received: by 2002:a05:6214:21e8:b0:70b:af9c:d0ed with SMTP id 6a1803df08f44-70d770ec90cmr33161366d6.32.1755710333680;
        Wed, 20 Aug 2025 10:18:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f481esm2666722e87.126.2025.08.20.10.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 10:18:52 -0700 (PDT)
Date: Wed, 20 Aug 2025 20:18:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2 4/4] remoteproc: qcom_q6v5_pas: Drop redundant
 assignment to ret
Message-ID: <5eh6q3hry4zchaptogbxykiiuaul7dkrshzlmfay7w7tondues@irxamm7vt6en>
References: <20250820-rproc-qcom-q6v5-fixes-v2-0-910b1a3aff71@linaro.org>
 <20250820-rproc-qcom-q6v5-fixes-v2-4-910b1a3aff71@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-rproc-qcom-q6v5-fixes-v2-4-910b1a3aff71@linaro.org>
X-Authority-Analysis: v=2.4 cv=I4c8hNgg c=1 sm=1 tr=0 ts=68a6037f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=gpV1-yxKdiVEvkH9OoIA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: v4mW4h1TjZ36yrWrYMR5WlZK6Ka4FAug
X-Proofpoint-ORIG-GUID: v4mW4h1TjZ36yrWrYMR5WlZK6Ka4FAug
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX/Py+rAQg75mq
 d5bLbSsd5WGuBSZ+qRa0flilSnwVwFrrOHCEqUxJgrzp1tosC3dKWcfXYYcAiHdY0lnr80npgum
 yRWzmjqpfvnNwv792/FRwk+xupSruhGkbYPRY6cwMXIRViRNJlnDeedh6Mfu//196mS3xGTH72a
 hy3GEQpTsqfXXDoUJUXN5AIquouITX6EOJqMegoMAFyLPocesolqkNy27GJKlTqE9GJlES9luws
 7nxxqI3u4KEc/LlVJAsfoIiQdkOdRfe35H7aSbXxpleHHj2NwfKukc4UxUCshX8UhVa7IMkAvHz
 +DAE4/tpUZT0UZUdoluFnLi93Hzugr5uHgrzlb1MPfdI1k8u+k7dpuey4Pm/P0nn049zXz6DVoq
 6LusaUsW1Ik1Ikbz/ogH6vy2H5cq8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 06:02:36PM +0200, Stephan Gerhold wrote:
> We don't have a way to detect if the lite firmware is actually running yet,
> so we should ignore the return status of qcom_scm_pas_shutdown() for now.
> The assignment to "ret" is not used anywhere, so just drop it.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

