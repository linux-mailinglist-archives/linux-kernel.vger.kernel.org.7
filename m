Return-Path: <linux-kernel+bounces-831638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E71AB9D348
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642103A48F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A53F2E88AE;
	Thu, 25 Sep 2025 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="geaGq1vO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821B32E610B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767500; cv=none; b=Y+yzPj1FS6tXgNhIk4oT2kU0yYtVw5biUwY17l06PQJo1D4h9DJiYpij6+qTqKmWTUQp0mtLFe0zHgDhKQjy87WQ+O9+Ls7UAY4ANK9et0+yZbxRxwAGd7qBXzYxKJ8pLCC+sNzTOyLlGs6TWOJPc8pOLi5lp8FIONUykfQ4iUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767500; c=relaxed/simple;
	bh=pcrcivp6jRezc7W+w/l9SYu4yeO+SeLB/7dvhRX5kiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wp2WXPVhJfSiPdjrDCnpkBX3JDiPaI7/KRvtSVREnSNBBQaQyKOMrHvXpuc1F5aC8cs68Q7go8stZUo/SXLEdve9eHnJBrhrCuJ7COlGyD2GU/Cuh5oRDUm00dcBTS70aY8jcEDF0e8GDCzehtAzL6YzbmEe8ApBRj9h0WOlnwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=geaGq1vO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P10QKg018716
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=D3nYnV6I3tQHUFYA7g+3qAT/
	UOlfwsLFTqadtUtQzK4=; b=geaGq1vODBz5/agzHiMLsyIDN1ZxM5VUKarGnTn+
	QYI6tCoiqFePkJSaYP+k5LERIL9k8IXUAVCKhyB1KRg1ToHZDuIGOrOn87YECWVy
	MQgjrs47ryVBq72k2k42Ufb5lzuNMwk9DejzWCydJ5k/VZt+koF3zqn6mdDpeJtA
	XjV14NRbsa9CgbakbfuosL6DtdET/Sb7ydx5nLfF6/NqEvqG/92skMDgUsf1Qhrh
	rFjAOH0U0EQ1girD5hYc4WedoDSxJFela6zb4QiJLDFgts2k/MrBtku5q0M5Yvqq
	uB2gB3Ssn0dsNdGxO39Iv1TNkLqBOKnWX3yVbJ1cob55uQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjysd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:31:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b633847b94so11955121cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767497; x=1759372297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3nYnV6I3tQHUFYA7g+3qAT/UOlfwsLFTqadtUtQzK4=;
        b=CBhUjoBi0r6jZaHv1EO5fh2WlIZhzmOs07DsLvYwqU+Xm5Ms3I1KSMruoFJjRSuJRe
         F8IglDb+KpcVWWJ2XkmEMBP3GCXOr6JDrfUvv0AIcn1xzBiDa/5pCiaPIY5lKph6vtwc
         DAWj2tafYuRJxk+jEVg5uFynqIq2aNdVAEjsmsbiTtWIXWIrsRt1h/N0oCFAk4xQWMmc
         fOyWj/u2uAITrovJwDraw+if3kihuXVMDugWBha/MjOGpHX/OGDe6Gi8rrA3qBq6AILu
         LBuK4zYbyvk1TsZ0bzM4m4jSlj5o1wzHI5hmFjd78y2Z9ps0SeI1yVZLwE350wDzlpR5
         sVvg==
X-Forwarded-Encrypted: i=1; AJvYcCVt4P5HSmjWU4vEg9Ii2d76qyMVZU3d2TZIkiMbks4RBn4bjpQKlMji4aUKAQqFwneBH/KeFNkizXzkjjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Odbzn6qpkx/K2pMhd1foAblcDi9sVT912kzli0cwRJoBtgqk
	XFLeA1u/2NcBoczZjGDzfpwIthalmKPezUZY8TvEvsQ2ZaPrGePKR4mUOHynlfI76QnE0qGpKfd
	wf0SwK9Im7dSJEE6q41mhqyPBCxVd+iNgdjofczPMltOgBnmHma+JWcEgByVBvhco9is=
X-Gm-Gg: ASbGncvOB5m3ightETywIKBN7/oZzTHg02LFwqHv/+OhyTr02vMmEe+XreOf9USNXJm
	YTrzVUAyGjbCAJSSRAdh3nxyaNkfdetdIskB6fwBDpfF/TU/Yz1+UKr7enEDVaT01im+pwyTB7v
	NLDhzWaTbD+T9oVMEy0H3qg+lnYxOBSWgl+L2yzJBsum9/aTZuMD2F5P2pO2alIqUSdSoCo3/7g
	OcxDFl3vryYju0Gmd9Gy0Cu5d/nAJN+kiIqZEm6phABCRoUxzcbL7E11pxx1FzK2I67XoWD01AU
	p5+WEgDbXwgHDW6IGkKObcDfNDBHViAUiCJ4Lhqnq1HFp826V7wBlo8mVdDu/Uh2QnhfG3gAJvW
	krY2ItqSOqi3QgDGBRffIHbMEapm/RZi6t05PmlEK7GfPycUboYqV
X-Received: by 2002:a05:622a:28b:b0:4cf:1f63:e0d7 with SMTP id d75a77b69052e-4da4d8e137cmr27710481cf.81.1758767497299;
        Wed, 24 Sep 2025 19:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEvoHvlnh9KHRZr3AgHqArgHyeDWrmzl2oYp0o4JenqL8v9CmviTgtlWMTnrGZUhqt1jjqQA==
X-Received: by 2002:a05:622a:28b:b0:4cf:1f63:e0d7 with SMTP id d75a77b69052e-4da4d8e137cmr27710291cf.81.1758767496803;
        Wed, 24 Sep 2025 19:31:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316a32638sm240397e87.118.2025.09.24.19.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:31:35 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:31:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 6/6] phy: qcom: qmp-pcie: add QMP PCIe PHY tables for
 Kaanapali
Message-ID: <zl6tq3prervuiapz5ekd5sxfzo7injnanpyfvxz2vn35fkb4kh@25zejng3n7k3>
References: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
 <20250924-knp-pcie-v1-6-5fb59e398b83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-pcie-v1-6-5fb59e398b83@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: l3NZPqhySYDSNHY3bjlyGkSvNv8b78Rg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX60sRA8+kcaOb
 ORENGGmqNsAqUkvs/u0AQXbJl8MrXMFFzJ2Nwfyr33+adhERo062STMcSD4RSrh216VA7cegcst
 uK31WRvlO0cCJmGqWGogKYK5V2C2rwSp5snrFqYJkdVcdJOAyJvoOkurWXya911i1pklcXLNAtC
 MteYiE+CglXChquDpsqjjcjKB2CtglYr5Zvqps8XV3+aPp+FDbZIlpgODcxAxPDyUVdvMQ162zP
 7+yHiKFNIVaA63VFTlsE1FMlc2+GgB+FGMuCBAqxTf2vtDYIKE9VuwjJxD8Shsr7V8R0K844iC3
 7HgzODdordVXIKELzs5YzqUtMH94y6lfY/91xBKLWdKUsUpLY6VjXYAZ4FQZnbKpXQvoCgzAo+r
 2b6hpv2F
X-Proofpoint-GUID: l3NZPqhySYDSNHY3bjlyGkSvNv8b78Rg
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d4a98a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lYzJZiZmsC8Xh2LukrIA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

On Wed, Sep 24, 2025 at 04:33:22PM -0700, Jingyi Wang wrote:
> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> Add QMP PCIe PHY support for the Kaanapali platform.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 194 +++++++++++++++++++++++++++++++
>  1 file changed, 194 insertions(+)
> 
> @@ -5276,6 +5467,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,x1p42100-qmp-gen4x4-pcie-phy",
>  		.data = &qmp_v6_gen4x4_pciephy_cfg,
> +	}, {
> +		.compatible = "qcom,kaanapali-qmp-gen3x2-pcie-phy",
> +		.data = &qmp_v8_gen3x2_pciephy_cfg,

This list is expected to be sorted.

>  	},
>  	{ },
>  };
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

