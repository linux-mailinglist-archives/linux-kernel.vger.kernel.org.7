Return-Path: <linux-kernel+bounces-847191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5130BCA35D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97013E695E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A1F2264DC;
	Thu,  9 Oct 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d2LzNvhK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3F224B12
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028078; cv=none; b=UsF9yUb9G/oXZbtW+6eolF1iYsQbLYeupHzGt2H2W90wbXwbFUIcWf3/6VcH9X8tbNG7YnBYqDvtr75UOCg3+ESxBgLkjzS2FHKr70v1giOFKYdYQdGkgsQS4arBhcejIYiZs2fdpqsps8Q4sKryeMJjpNCofscAeIY60LR/a6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028078; c=relaxed/simple;
	bh=huSoky+Njxyfb9vzBoqbK2jj6WEztwZYTUrNvSEcOCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyIaLPz0k5ZVa1CxW/GjUi0D3/HvI58PkdBxTbGKJKyuSpEwG0XQLE7T2KHiBK75137CeybXYzZRgLr3jfx3hjQZ4u+j7tiBDZXZ0rFoJCNwFKP2atzg0i/CHzic+hihoUuEl5fUU3MMHTEaASpL9vHNbvKozdhaAdBfktC98DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d2LzNvhK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EjScc029234
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 16:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZH5MJU1z2kkrReUPnfpEC2Sv
	Ik1fLetQo4m68cqSWX4=; b=d2LzNvhKuBavrdidkriUIThV2NX/6sb5KV6nKaS1
	jo+qKSyfFtrUq+2xG/gR5DGBZE6VUaq11qb66S4nDyxj0ZEJJjmdgS+yQWrd1Upy
	VoGKvT0Z3pJ+flX6w5hZDJMP41gD5RQ7Zud1vEBHKiM5qtjfotfZN448/RhrecBF
	i51BiZ/2MFwp1vOG0RDl+cqeV3U72LvuMrP1XCfWzqJdyMU1oN8X2NGOZL0jgFPd
	0nKhQTt9hBzsI49DRbr27tMKKh4tStehoDkcLl+pkMpUeksS4wm9RTy05MnsaSiv
	tIERK+DIgif0H0eWgEeBuphRI1ggctbIfclb4t5C9iiN/w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nkmwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:41:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4deb67c61caso46166041cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028074; x=1760632874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZH5MJU1z2kkrReUPnfpEC2SvIk1fLetQo4m68cqSWX4=;
        b=vKp31mKtfDvTpKvl+dGr/jVT8HZKpc1b7OV02SfeRNv+7p+V0w4dKACIPsJ61tSSSg
         kshokCGIxU21NQwSMHopfqVXMYhy4A+ZjdNymrVaW/HKhtgYlYYTN2n6R/e6wZfkiKjs
         4XhvJd2XKWFEFgSkM1TTeW5lxhfWkDBKHTk6EnRcusTns2qp5k1rxWcRwqLyovzglQK3
         SJxbMyasNTWuTPy6iPZQF/zgvrKtnqrRTNQzM05qj+IdWX379yy1gd6RCa4ZoZ7CFfHb
         Q0K8nhsLSBGuX5X4MKUw38cYH3aS4QLenP+WMfvTbFRSn1EnPcr7AvEaEE80CGPtF2I+
         fTAg==
X-Forwarded-Encrypted: i=1; AJvYcCX5g0JmOMqCQPbxuas15A99nX/DtSjP7QdbCpmUzEHynNa8Te+KSjjNk++TRS1FN1BPU/1yqTbLIm/Q/hM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+LCVaGFuGuYHH8+cP1P6zFeum67bE4osaEVIWcqyzelXsuoP
	yjbPHnau1dpiJo5/SMqewX79yc+qviLYPQNnFGQzOLXH0+Ka+b5f26j9DvBd/k2TgaX5S0qrpHI
	ADEZ8fJiWqz+P5PU5mMHRotwooUi2RID6zsyYNCmPDguFIScZvEW3b9CyiVJ0xGKIkLxq7KQuYz
	U=
X-Gm-Gg: ASbGncvFmVDr910ssPokoW45uq7E3UiCIAbgM54+B0DnlbV2ZKSCbEy8zU0sjIV8Q9u
	+RFsa26fMY+ZEe7Ipm1qygTWBIIGX0rZ5Wg+9gT3qCHTqO2ZmY2SMWuaRFX6HuPfTTBOupQG9La
	ZEZQD+Ab2VzELoeZTVtUK10bKubk7DUiQI50Us51jSQZqb//eLbY6aMRgFXI9eGcEJEcVS/Goqa
	xkghkV66j/3wEZFLeQJ6ofcF1E/EwvNIHWsaXpNY+aV+rtZ/46gWZLFrz24TE7cwylfH5XFnx5O
	7tW7D6eey7hQ1N6rpe1BEnQaDZtFofW4h30chU/D1ftBHwGQ6pxEUD0plWMvn7lFERAHU0aVazR
	8keVNXQltLxVkzQyw3NLQubJCjeS5m+SFgQGADhUDsBsV3GY9rMvZjwiIpA==
X-Received: by 2002:ac8:5d05:0:b0:4de:9f9a:b8e1 with SMTP id d75a77b69052e-4e6eacd1632mr109502601cf.18.1760028074428;
        Thu, 09 Oct 2025 09:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzrUwRk3yaunly+XogzDKcTmyOuXyUJaEXYWlkGYC+ql2A+kl9xkhVKy9iNz+hgl2z4DiTtQ==
X-Received: by 2002:ac8:5d05:0:b0:4de:9f9a:b8e1 with SMTP id d75a77b69052e-4e6eacd1632mr109502251cf.18.1760028073944;
        Thu, 09 Oct 2025 09:41:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e577asm154e87.11.2025.10.09.09.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:41:12 -0700 (PDT)
Date: Thu, 9 Oct 2025 19:41:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wojciech Slenska <wojciech.slenska@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcm2290: Fix uart3 QUP interconnect
Message-ID: <sdxrshrrx46wlskoz5kbefqzlhc3nccmgaqoxbc3aif3ep32dg@c57xluzx4znn>
References: <20251009090718.32503-1-wojciech.slenska@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009090718.32503-1-wojciech.slenska@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXxrUiGjZeLMjv
 XCM1ayRzg8FDJlPU5FT0bOo9scZiBNqV3phLw9Bl1ALqUpW8gnlSDV7ezbLDFAxeokQPx9l4CmY
 6AN+K616WObxE2D0JC2OpDXX4VLnRXSBxEKkVXEMxcZA5900rRc+9+0xqxm043g3qFWXz58nhVc
 pXTa2Q2nQX5GpVT54fuRFlk1BQ8BJBbme7grYqo09vb4z+xXldc7wORFQqxG7SKd1HreXWaZh2u
 RllS0wAkUOenwFrIBpvkvek+zCe3bS/Cl9BcruSnZ9vO/8vtZKFvleJSjSyqk197mX/tzFXFnv4
 XLYNWotnQGh5ikjEWU5Jt/guhkr/QGMsmFt5lU1Yjlq2BkQ3cxBiRXfJNC2UoV4dtPg2pOdp8Z5
 61U3yoh+Xu1KtDy9WnPlqNQZTk9Hcg==
X-Proofpoint-ORIG-GUID: fjLFXRKBf4Ytc1ngt3kCby8fqdOCZExy
X-Proofpoint-GUID: fjLFXRKBf4Ytc1ngt3kCby8fqdOCZExy
X-Authority-Analysis: v=2.4 cv=VK3QXtPX c=1 sm=1 tr=0 ts=68e7e5ab cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=xtyRbcdHMR7QiUPwaIcA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 11:07:17AM +0200, Wojciech Slenska wrote:
> The config_noc interconnect should use SLAVE_QUP_0.
> 
> Signed-off-by: Wojciech Slenska <wojciech.slenska@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

