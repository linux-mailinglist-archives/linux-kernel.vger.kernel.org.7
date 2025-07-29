Return-Path: <linux-kernel+bounces-749296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D56B14C81
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16C9168B23
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC635266F15;
	Tue, 29 Jul 2025 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="loqFY7Bm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDCB2264D2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753786144; cv=none; b=PrQVpfPyPRNdZF4uY1UrOX1ik6uHa0wvp71Evb0pEmiBuI5+8SDxshn7qP1HcUSXx4an7tMdvjVrOp9rq9ODetkLdNZAMuRLTME5czOh/TSOvfOvaaQPM1NiRoVu0cuCcLEUzA502NjdJRGr4oNSM+Z36X0D+PHs9Jh9JffaKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753786144; c=relaxed/simple;
	bh=C34G1P0eEB9SxiCuqdA8stqbZ3Q36ewqbLLMaPiYE/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7ZSElLdXeUbjR6TJBfjpbKO/+niOZ7AVDzXZaRSMhkqZlOG537AEs7+W+d9DVVxGgbVcc3lumNsWHfKY8wXi3U3KkbUYvzfDrcdaCfo0abv8KPwwUxXTWzzeeDfWsmBOFxTjmwSBZnh0hpEWJ1P3xRfq7zB6NU/4N4eSirerZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=loqFY7Bm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9KjQV006590
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1gZCla+PC7KgPMRAN+a1woAP
	P0liPJQbm25JcENNdXs=; b=loqFY7BmrCJYeVDVc6xMnBSuo/ELUNMMfhK5vphh
	7F/FT3iEYz5Tu82Nt/dvO3epT7d423WV3PBOWNkSBDJmqpgtx7iH1GgWnxZ4NGju
	H2X/jR7u76EWIYs1nnuF2MRzDOHIoXEnJjVzwmS1jIH/02UZT3VM+WP0c/+rvfjt
	IZ4bnKnUNt8NCeV6JaWpbXc1UMBrHLG0eNGRjhajDe051v07nEnuyfsjjRHKF22w
	POg5/vmaQJTbiwsQVc+AgTYzZYbErc7Q1Z+ccNstICCvWC25uVHUtApNYPDYxxjN
	8CYjtOqnsRSicepIAWoWsvCM98RgqsNYfE0PjmDX610kSQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcr7yks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:49:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab5e2b96ecso104263921cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753786140; x=1754390940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gZCla+PC7KgPMRAN+a1woAPP0liPJQbm25JcENNdXs=;
        b=uZH40z4AhnYSVMsy6QegXpWo2DJrStHk8+1lL1NUvVOe/5W4yk2EuGGEO++gAC5uxj
         xb+a4qhBFFzFu6TRddgO+ej3ZQT+mdZ4SXCcXmbG5bfa38ED9gryc1HsoCm7hJmtH1B0
         h289rpz8WuRhO9zEMA9kavwg/JHTKkQTcsxEewJwCnPEEKXfEbM4oZvFsFPWu/48Wtx/
         p4eDDgAocGcVnE6+r7wcJjMAgFT8a85l4uh38BFpaXRcEnLe+Y0ZLPFGov/moQUnnGSd
         iotb4dF+OaxE6WMmEsFwRDs2tvVZwNLDKRppmGteTu8PBL9n4mNIitzFdlmjrr4lujS5
         vt8g==
X-Forwarded-Encrypted: i=1; AJvYcCV8kEL4oCr1B1QSqGzKxVlh6nQkYzAlzwspjFdT31r3c0GJTK3dEoHfRprPrxTfcn/I2qu2So1vdx8d9Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFScxPVmZ8ePLXpIDqQIL7eR+ggUXuhLXaqHLF8CfTU7INYR2U
	BZGkqjjGMP2PakMii73bU7cKC4ZTBWQcCEzmsuqwQudo1JzhCwVkwOnZaAvvgdwjQ5H0IorBo6s
	pg7PbDCR19o6Ag7AuWO015leFHbnpQ1qyzNUgRzlV8mxCklGnKEpsZmxxVoIlV4AScm0=
X-Gm-Gg: ASbGnctQkuWvYzFqCVZiFKCfsNeBKg9v1F+10yfdzXBwVrLACrYDjCJ62D0GjYrx7ei
	UclXnvPFTUMLeR0J63c4t4pX+bjoGSaDkSCZop0khMuFF3K/XN8A7ekhxm25pLfQ4wElEt+ZI4G
	r2SgphgsWeWMDv+vCuu4Nr/ssJl9KlUQP5eJe0ghQOk6tvJp/2UGldK1CHDhPlDRbFapqI6slzo
	jHNsW8DKKLgAlU7g7x31E5b75nev6DNGAJxPv0IxerpIAck6Xay44F2HuKKs4xdy5pWADMKoCRE
	iiXF+UD+8u1ufLpchxFVXrUSvWjRhBuqzqiL0+5cAAGXmPOEZv2//2uM9e4lAP/EfNs+R2ai99F
	asCGjNCWxCR+Q9Pq/el9bTZe8/MMpRGex9tTiwgw9Ew08y4u/22pU
X-Received: by 2002:a05:6214:5294:b0:707:611a:c7af with SMTP id 6a1803df08f44-707611ad0a1mr3722256d6.6.1753786140463;
        Tue, 29 Jul 2025 03:49:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOF6nNOAgWT75o0XQd1gv4X7CrFSmPeC7FXcrYQvNIQQ+mEZ3Xm0poc9B4mIvJJW3s49BzIg==
X-Received: by 2002:a05:6214:5294:b0:707:611a:c7af with SMTP id 6a1803df08f44-707611ad0a1mr3721946d6.6.1753786140046;
        Tue, 29 Jul 2025 03:49:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6336381csm1639826e87.96.2025.07.29.03.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:48:59 -0700 (PDT)
Date: Tue, 29 Jul 2025 13:48:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] clk: qcom: rpmh: Add support for Glymur rpmh
 clocks
Message-ID: <dph5azc7mrdmsrau6jb7alkhntkziwfhz62r6fwsiaq7ra44ta@qokbet7yue6l>
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-4-227cfe5c8ef4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-4-227cfe5c8ef4@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA4NCBTYWx0ZWRfXzCpIuFtbuF1Q
 EXfbZ+xuI3wVeMntgCnKptliu/OxNS+ntoP5/WfOa7kamdmUNkqzX2vQQssrRoj8fbBPFz+o1Xe
 gkO5zVpWKXkyGv9rRQzMIjuB1AYV9LG9LP6E6LGaRMisKJlHKRsuT73jgh5AUIVdQQYyiNWEQRE
 0qMp35Qyd7GFdBGeZpp8Xktr1oy3GGJlC2en1U2YbnMkLVNkGxj9/jqBzYsunk24N3AEIHjDkVC
 n80D6W1gYbqO54c0PLtt4H9DsaGBc4n1zzUr+jHOJR5cRKTOr6mvffftmcyhy7u+BkKhDItScHA
 Frn9NE65TW5y3VmtziubICrRcHw0mgx1c4/3C+6yuf8Nc51f09U0Xae5OJ18uJ4VUjHTev8B3Va
 qvO7QjHdtJua1TnzsbBKEVKlLkpHXf3HjmSeSRvydsGSXQGN4Oy+KAjMkZYbtd5YdKLLBWX0
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=6888a71d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=EB8bpfT8cBTzwKD-FZUA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: gTzuK8yQmyyhu50g4fGCiElsg4BR4ZHM
X-Proofpoint-ORIG-GUID: gTzuK8yQmyyhu50g4fGCiElsg4BR4ZHM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=703 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290084

On Tue, Jul 29, 2025 at 11:12:38AM +0530, Taniya Das wrote:
> Add RPMH clock support for the Glymur SoC to allow enable/disable of the
> clocks.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

