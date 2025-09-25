Return-Path: <linux-kernel+bounces-831647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63948B9D3AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153CE4A0519
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE92E542C;
	Thu, 25 Sep 2025 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HX4F8QJ3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064B2E5B0C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758768438; cv=none; b=aYArv6aDl2snKhpwLQsbBqrNVgpHEdaERgDz+8kpEXduiPfKNmTiPek45atUbbelh+wOnC+RbQ7v5Q8bdtj+TvrXpezhhHbP9qAPDnAjX/X5L+QuKVPojMbLrWcPNcXo7CUhCQtbkx05sVFRlGEGJmkKRMkk25jrN9z41+4ksic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758768438; c=relaxed/simple;
	bh=knL0qShSKz9iITJEJ5pqwFTLrmcOR2lgqU1fn+jaaVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFvLOT+jdquTJdqMUmif+bagpJ2ntrrwpiSyssTIeJ4N7ycZdvsAHhn2XSjwmuCcnrR0FG2PalllfU003ptTsX4K5pfGAhoxbm2kx+ppMPjgqw8ykQI7tXMPmFeqO7tyjk1F+c1gsJtnU/9DeWyEHvHrOIgwuvIJUEfLyzkN4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HX4F8QJ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0t4FZ029720
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vmzDde1nY9Gum+QP/kxmg/q8
	dry3hyyGVlLVwLkd+PM=; b=HX4F8QJ3IB7L6d4GE/+g7UqPw04IyNlM7sVMyFyf
	3OmCpJ9X+A/hHFuLuT4w5s0w6HkAT1GYeXSsI2Uo6Kry4P1vYCSFOKzfc/EjsJlW
	GJ/IYnEbYUqzyxKEwfzLXSxZEr2Z/vuAqnHYljJE4+eDHJ99FvLtDiBXHs9HRbxO
	SCcAy8mqGF6ttw0/tCjl2zWgVO8rdVFlskGCaAnd3eb/LBklI3jq+yAl9t2I7sg9
	1quHLjQ/MGW9RcKNeoVuBq+hO6skgvwhYWPs9pX3nj5MEaUkO18AELFdrvJYav9t
	VlW2CXNrzUVisbgqZS4+ve5L7QMeHfms9ykmDnPjmG404w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fpcby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:47:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4cbfc51331dso6854071cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758768434; x=1759373234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmzDde1nY9Gum+QP/kxmg/q8dry3hyyGVlLVwLkd+PM=;
        b=Im4hSY1254ddEE2GyhN8EQDNWusdanSWM63oGl23s3jimOvKgMrtITPGDjWRsfO3iy
         rd9qvrXW9yM7vmt+XvCylQxQc17q0K2+IKif17cUambFuAfsw+fnRh+rUhDnZ3FAGWRc
         c5raK3rMK1CQhxHJf9JMljZ+EJsseE+lGlQ4dITbTlVh0jdX6zOG4LoUuEtxH6HInqw9
         IdAyBPTqnIPPcfcIqh/kogMp1noE2Q7jK9oswH7dex8S0r6x8TZQyF5GkHk82/jhCR8O
         3BzodDTpg7jpLtGQXhkEBLG/ZCbT6JBw7U7fVdQ6rjUYDSalEjIG1+kxlUDfAidLfbRg
         02vw==
X-Forwarded-Encrypted: i=1; AJvYcCX+UfnwnK6xpZ0BcFwt3NFqXhYcnJOs7j7Pa1jVOK2LPzJd+w3nvhzHgjpDX/7SZZqxrAAYzylzJy2/WtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG2UuV0x50yzuXxUWwuOAG4S/PbeMU6xGh5rsEWdABy7VjS5Vr
	cm5osdxss6oYAfkgOly/RAOdNf8n2x212eYuzDcUt0Y3AvY3YQ4KXgZ6Xcx4Wdoto1lQqWWkUOs
	qaTjgTrnSthXicDMnrCdqiYIxKAJ3Y9fdCyxjUe3fdDDmaA/TDtXCzgibSDNSNqaeKsK5e4XHle
	M=
X-Gm-Gg: ASbGnctwEApscfHVBR8MItYQ/lvH3tJhyPLpC+0wslLyJ1KOwJwHTeE7/fxfEm0i7IP
	p5rz5ckexDnpOy0PapZ8JQ7PL0bwcTWdB815CaZ/PdYHeO5v5ouHYOq5VvZBKSHAzHP5IuD0rnK
	tc3fsGENW8WaLtian07xJSKLjHAF1EBOPCDR5Xg/rNguVSi4NCvaUz/eNabkg2C1SJe3XDxjorT
	0awKMsGzFRXORFTtCyZNbRLMZvZR6cNCTchzxkGK4hPp/567GiizuRlHrkLv6/azPWqLV2TEUCI
	HJMSEG0tnIfdU/gO0YmNACbIEOhEYHucDUONnn5OKDP11869rbngz+DyoP/CEkyOEjUFCsGTC77
	oVPauckC43sVRX6HN27T/3WD+xnqfvkZRKbFKrY3YAMtl/0dgukkA
X-Received: by 2002:a05:622a:3d2:b0:4d9:ea03:74f8 with SMTP id d75a77b69052e-4da473535b8mr32183121cf.16.1758768434000;
        Wed, 24 Sep 2025 19:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExb7T/OYccuwzgjimDxaVA2LXm9/FSZaMnNzHFBySx7V4Je77xVRXOd4TLu6HqCTkejd5+IA==
X-Received: by 2002:a05:622a:3d2:b0:4d9:ea03:74f8 with SMTP id d75a77b69052e-4da473535b8mr32182901cf.16.1758768433568;
        Wed, 24 Sep 2025 19:47:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831665640bsm259733e87.83.2025.09.24.19.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:47:12 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:47:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 2/2] interconnect: qcom: add Kaanapali interconnect
 provider driver
Message-ID: <2mq2qqrgm5x4hj2cnstzsqzfk4lmzhg223hmobrjnqu62facc4@p57wbmkys4in>
References: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
 <20250924-knp-interconnect-v1-2-4c822a72141c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-interconnect-v1-2-4c822a72141c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ygQHXAfVZYSk-gC_hSOqlAzKMOrO14ON
X-Proofpoint-GUID: ygQHXAfVZYSk-gC_hSOqlAzKMOrO14ON
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d4ad33 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=2uCcKERadT1UtqjeBP8A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfXw2JGpO7ozX9Z
 HXQpfCUximgD6qoRYF0cc1g4pmYaY/G8s8OHRzLewFObNsfc6JJLDgLprV5YzwKP3/HpGL08hvY
 hqnUaEHtxlFvdjnDTuKUeZkWQg7NXEWDtLFwWbLDE7IiwOte6kTZ1eOfljeHACby6QJvypGmCFc
 aYhhm6OKX6yk+zbkUfoRSmFgvhDQdMhnHJ5WXshKQFAuYM/pvcj+fkpqQql5FOLmkVonnYQJM4j
 c8SyQL79IFEYE43zFd+CP2KJdG8b1RqUu+/cOVs8Qnv5jbTT0pp1BEJjmmJDLZVfvprIlflcboU
 qp6O4hT0Ii6FtMXQNX1adkam7rjJcpG2usDoys+V3vwgPnCp1sFvjx7HGxqmpsHSr2rQOzBiZfQ
 p5bb2o/q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On Wed, Sep 24, 2025 at 04:02:45PM -0700, Jingyi Wang wrote:
> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> 
> Add driver for the Qualcomm interconnect buses found in Kaanapali
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig     |    9 +
>  drivers/interconnect/qcom/Makefile    |    2 +
>  drivers/interconnect/qcom/kaanapali.c | 1868 +++++++++++++++++++++++++++++++++
>  3 files changed, 1879 insertions(+)
> 
> +
> +MODULE_DESCRIPTION("Kaanapali NoC driver");

Qualcomm Kaanapali ...

> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

