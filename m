Return-Path: <linux-kernel+bounces-853288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4087BDB1E0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6EAB4ED306
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CCB2FFDC6;
	Tue, 14 Oct 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WFhYfeFz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2A2FBDE5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760471427; cv=none; b=Gz63NKfMm+VIf43NPqh1IFIVy+UHGmfZVjGWUUrCZ0YjkZk6pm9aJBa2dDdF3zmnIDW0GCLzjSvJ/NRlQCfOyUW1pbBf7VcqV4e8lQ9J41ohZbY0Z0jg7NvZsSIwjb05Fj6ekeaLS1tGOTZRVuLdXlmSGjTTU3taAsR+h1xJGf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760471427; c=relaxed/simple;
	bh=kvdd2VQ7EmZ8FVKXUCYA/Pag/CRKLVkhbOU8rp/HZa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/aE7fQx/Rk9EGXqwIXYiMaJtEWbl99sMY+KnGm2X16G/8BnKWY+d1gn2aMQ+8VvyZBeZDZSCWWEAOv47La1Vmy7KaO+jfQ5mmcjPO3QyYH+ABLzBFZ12gpbSGOnO3+iKAMpxyOkYPTY2GqfpR8bACt09Snj8xL3oSEUTdpow34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WFhYfeFz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EGGE3X016458
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hoXaxxAh8HM/NnL2U+whNfVg
	Ynbh9JZ3GGYiHNKdMQw=; b=WFhYfeFzTO9webJ7RVqkMZsclTvhFb+CfHvDOT/R
	GATWvzYy0L23twFn/CAaFdL8QwkfRZ77CZIoeiYSX6d3rTn2zn4naA/mWoLCb7N8
	z2RX3Dw/WocYxrfhlwbERqirPMwpAXQ8XyIMVQZ8Ic/e+eDDOn/T2b9sUqbTsZnI
	XHSroKWxZF7KHU3ijsYrOdRHrM2iICLGpUlxPhQg3KiREcQJaRIKpelWOrP4q7+Q
	NzfjAhgIb76nPJBp0XADW2qgTJe1XMVSJHP3+LE3+k53yKOuNf6xztMfHTOeKRVw
	fNc+nd75ZRMTWLdUoLtTSOYUfw6wWz0G/O0nuARhTEXW3A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd91x15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:50:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-872d2ad9572so2943294785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760471423; x=1761076223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoXaxxAh8HM/NnL2U+whNfVgYnbh9JZ3GGYiHNKdMQw=;
        b=TqnvuSu0LIxOH3JyiM7gfj5YXoHuq1f1TFqj+ToNIbqwZFPjJeDQIBW9b/RI1iCcPo
         PHEW+zY/hY8N6VRkX3LD3UTFGxbm9HftOcKkMP64Px8WAfGzyNHiEdTJSdbo1G8LT5rc
         xZllfbAycUUtuqcnFLYipWreE51pl5hqShdk0NKwP0PCVdHYTizZP7ctGiTifx0ZSaB0
         6YKrfg1vRByxjV9Y/x/y1LCdbIjMu6SQFWJvu5h5ttpVDj7ijKqNC2ZmFbwKuq5jxt+T
         vnsp0g1qVUP567OVjlq/OVedWFrSpKKeP978kaospU1EFfbD958F7NCzsnm96cnA5bGG
         4LlA==
X-Forwarded-Encrypted: i=1; AJvYcCUdZ+tTtfH/ot6Gre5ArmuZ8bl1K/DyPoy1+ldhpZkkvg/1tlojj4NMmwZh7AM5VvJ/yimwqGznPxOdjzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98bsdqx9Bz69KEwDcaNO0n3sAMN4tLiMuG8pXc0HW8b/GTdCF
	bjlIYlEP6uTnOOcSUDkJUZHlLl5+X82K++MlgtmiyMVOHi5mJFIYzj42ucqCsK9yueEneAhu3PG
	AKVuutqPk1/rOtYF6oyFWljIn1Bgcv8qEHD/sOzcUhvuXppjmi09hvOaKAccWUZQF0B8=
X-Gm-Gg: ASbGncsE/TcoygJN4q0vTDwkOSHP25TbBc9h3W0OwXoytlJjsrdFFRv86CZUPg15/tk
	vU3riwnWBYZ7FZjppjLUHrg6ny2cIMo0zctrznsD2LWiI/07bM1oVa93SBLYVEBkrhTtnXAPB6L
	TH2iBjsgh0gMLqf/MipKNC49oitf3B6Dero2wnN+4NtXWkL7tKRq3rma1abk2ZpD7mgzUSHreuM
	tVAVan8XtbmXbxxk0r4OK0vLuR5W9WK/CC8qVS0qUvbHSc4bzd0c9wxksdPJrsPGfin1T9JWWht
	Vh1+gPXlvVN+QdzqR0vWY04meY6JE1ZPxNAJUGtkdo4yClO1HFimIar5YMp3B4LlQtEzxwjtEcU
	JGEvlL6Ox7kl0DuUd1kin8JYyU82KmJdZCVsWbPGoJ/KJeGmGM8IE
X-Received: by 2002:a05:622a:148f:b0:4e7:1eb9:6075 with SMTP id d75a77b69052e-4e71eb9639fmr134514411cf.24.1760471423490;
        Tue, 14 Oct 2025 12:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5E8/aPEwYwGIvty7HBIiP6izQb7EW36jmKnfvDtGc+uFowF5L0vJTo44+JikizgOXq93qFA==
X-Received: by 2002:a05:622a:148f:b0:4e7:1eb9:6075 with SMTP id d75a77b69052e-4e71eb9639fmr134513931cf.24.1760471422969;
        Tue, 14 Oct 2025 12:50:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e09sm5522722e87.23.2025.10.14.12.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:50:22 -0700 (PDT)
Date: Tue, 14 Oct 2025 22:50:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] soc: qcom: ubwc: Add configuration Glymur platform
Message-ID: <f4yvyh4yg4mjuukxdee3pdxcslucj2k2icqc4d6qfzzmctlffn@gxtzhgapvnv7>
References: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
 <20251014-glymur-display-v2-7-ff935e2f88c5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-glymur-display-v2-7-ff935e2f88c5@linaro.org>
X-Proofpoint-ORIG-GUID: himQZh9nWMmQhRwiJJFhjMxS4uDSUh8I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX0r1Lu1navF/1
 paauhWG7WTMXwCytdPZ2AZ95kl5jz8fE5E4OwGQF1PVlzS3ZTTp8EfznMyZ+oQqzT6TUQU1r3Do
 bNDfHNWrZ2hnPU5CwWO3wHlUbQP9OAoszIpzo7ZK2j2h1EpCfMMp75BoqkWoU+8gHzeex9PQuZY
 mlSBgVN+5HLBnBwVPemmJCrwQLt9ueFvEGiNSj/wa1HYi2wIZWP18EhHw240Zel7oqGlThmKvxd
 wvF7yLYpH1NkmQ0acHhk5ChGM7D3OGpuprgQsoR1IXSVfrfc1JWg7k9MFHtsoqlVEieFJqXBdQQ
 jHGh8/cp4H4SxNd9dSROByQk9IDuWV7cVwvQhsP/WDDRjFhQQFHAKgBAU3ynBKgFOajHFlTGVe/
 kTTlBfIeJErqXN/upQOXcZBsp1e9KQ==
X-Proofpoint-GUID: himQZh9nWMmQhRwiJJFhjMxS4uDSUh8I
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68eea980 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=rYq5acLp8HI6pBODZ1gA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Tue, Oct 14, 2025 at 03:38:32PM +0300, Abel Vesa wrote:
> Describe the Universal Bandwidth Compression (UBWC) configuration
> for the new Glymur platform.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/soc/qcom/ubwc_config.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

