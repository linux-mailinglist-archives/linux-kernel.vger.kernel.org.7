Return-Path: <linux-kernel+bounces-803389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A455B45E84
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CC87AEB97
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F26B306B35;
	Fri,  5 Sep 2025 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gpxNGdzG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373D30B515
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090722; cv=none; b=k2nNI25AQhQMi9CJ3T6txDQowAatgre27Zlj8ZMm80n0djVeFIhN2Dw3VHA5g2WMLSgDRcY+IV7oEdpV1LIyWyXBqh8VAcHwKk2kIti8MvpEGWMpP7CpXAYY7DD26xTsJZ4hQ9QHgyHqChjsRihVbJJbUTR7ZzohQCoZyOdvQC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090722; c=relaxed/simple;
	bh=mufO7WhSL863WQc5KKR6Rrp1gwzSJEYfE2KGDaW8J34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/e05WH9Zm5Sj26a4Jq4Hgp8WNZhDptXmK088hjjcGtQBWY5ZruH6hCkqyweHzk+6P2A48qjNT50AkSh1aZdosIO5jQvcdlbzF4SyCXAlssXDvpWPXyWt1FvMyMXytx8WNeb+8DKeErYLKz2++NsOQcBXo/GyR7kGDYsg7JjaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gpxNGdzG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GDsZC008117
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 16:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+BB3ZZvnv00hg2yX5Hc+9/g3
	ygGWqUcgRjmxZQpicHU=; b=gpxNGdzGUz1nT34yntMjnWt+kyDMKFr/Dp1PbzzE
	NjWJiCVq6wu1N47RR96dzJJGA/w/D/1kR3nhGLQHFnsJMrZ9Saw8zwMhnrEVFYsc
	86fTtI+1JVvt29/bF/havTUBEKdeaz8IBEx1BwkYQCu1GdZW7G55uUM3ylyrU6n1
	v7vYEasZZEmu/ewz2XuQRv2TyrCnuk9Z/UqLaWpLnLYYcQQx3NkjGqkp7VfCZ8eW
	JRZGFm7p/d4hWcDuECWtpS62meo1bA2wOaqpvJTXJ800wCibnJ3dz7q2H0ZyztfS
	UEgNiegsJk/kxCDKbq+nrm8ENdpmBh2XbGrqCW1XflvasQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjut46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:45:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70edbfb260fso39470946d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090716; x=1757695516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BB3ZZvnv00hg2yX5Hc+9/g3ygGWqUcgRjmxZQpicHU=;
        b=KtNvzpJL9CBbC3T3fR9N+s6EbYwYPxswzN3CYmOpDN40qfP9HOH33A4gBnddl2IO45
         IFXtfVxXLQQflBOhhY1E2xdNANKrd57IidxIso5qBwfXQc5/1lC3cA/xT/hXKzZ0OQ9d
         lnWeYoJKWz6OLUyl3+RGXiTCqHZMQes7OJDECaQFOI10OlINmfK69aQZSoIiw8B/87Vb
         bEIedZk/Qr2giDeDbVloJG6oELCr9DNBm+z7uz/AEthh+0ZyIJuw4Pe8pYl7X1cVxG+Y
         /OltEs7BHoOJK55SXYvI0LIq4Ny2+wHBLId84oew3qb+8CTQ83fYWEV4Zy1NaB1D8nxZ
         P88g==
X-Forwarded-Encrypted: i=1; AJvYcCW6PNoocaMch77bdB2W/qKBpRhNR50mQf7189oY1S+5ylyPSBa6rgAoyaMn4L6pmu+3nipSONKVgif13YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNpKY4B+tw88GTDkA3jcLFOv4aLWfRsH4loJnTYHKgQoDBTjHe
	tS6AY7oZhbEeR8g4xxochzs6B/3oFKQk8iQBivGG6GxmKKhgyxBGeoVkXrl9xm1bxtbjSnV9jja
	3K+Vr7pfOlVYwc8HALifnmsgdk8R8T32cpPV6dalaEhKFkt4x2LlF7WAn2B76+M3TBcI=
X-Gm-Gg: ASbGncvmOQV0C+K8Ov/j/VooI3iJFTgiIGSbqqHkUA/IqeGGnLNmKXfQU+DYPe9INk5
	eXzHWE5J8NiShUw+WAjcLBshppDnP61iKqzLESJUP3GvP84Ukt1SMypQijpnOpdKK0QiKeqWk3+
	rFYOMdksDiQobPw/06QaRjX1YDSvXDm4i+fvDL1oWsCMAszgz7fUF6xhvKUriRZG6jbLOKnaEiO
	0swqzDrKBhoW0v6VPkJb9cucb9dX4W8a2GLNf5o+YEGdrqOXxfRLdL2+GkQZvAxakpPy6ccKooA
	u5uMozQZBq2SYP0zUOkwubZ4PhyZKBWGv6s+m964XVOTNPzBqGTjTkAwD9/1cCaKb3K4moQcbwr
	t+zdS5Ps7XJQr7oU0TLwZ0QiCcmet158FVGONL0OviejIXPR5uMSI
X-Received: by 2002:a05:6214:21cb:b0:70f:a719:5666 with SMTP id 6a1803df08f44-70fac92194bmr255761896d6.61.1757090715874;
        Fri, 05 Sep 2025 09:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHACuxE4FbwHplU4elaXyi4HGgfYTCOOuIKAhIyRCUSvfhISyirF3xqoqTDPYeTt0l18tebKQ==
X-Received: by 2002:a05:6214:21cb:b0:70f:a719:5666 with SMTP id 6a1803df08f44-70fac92194bmr255761626d6.61.1757090715396;
        Fri, 05 Sep 2025 09:45:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4c63csm1858374e87.143.2025.09.05.09.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:45:14 -0700 (PDT)
Date: Fri, 5 Sep 2025 19:45:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org,
        srini@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 11/12] ASoC: codecs: wcd938x: get regmap directly
Message-ID: <4jj3ofvjiqzdyseezuhup6ig5hfio4y3siqqmxhvpse2yyvnqm@xa3jtgee6vpu>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250905154430.12268-12-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905154430.12268-12-srinivas.kandagatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68bb139f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=azzZ5_6gx0kgBHoxRwcA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: _8Up6Z2M6724IVMatWu_D-WYFZlfDeE8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX741DYt8BxW8U
 mUdQAdmjsP+AlWn36mAV2S9pEHNdTEcnnlt8QkoMMOVFTwSzIs0JKhsXyWD7M9Cx6JjL1cbj3CU
 CIaxe1uDxa+fMii4M2ej8ucicHOH687g73aBkR0urUgKXyn0sowX3Kt9bK/y4BXoi4HXGz5Y1Zi
 rPLQNWSF6tuUFUvXsBZTppuptMLP8CBoNYlVKpvya0MC24nW+JyyOVYXYkf029oAFFjLgn4K1bG
 G0/iVq14HlXr7/iYhVnzwAe844PyiGijHtK8UeMKLTYOfEIrLK1iT9eDX2N5CBl+KfnBHZOYDS1
 445F4kgqiTyIlbI0L6IUgrMRRNzXvA6dVky2yF2E49QnT7lajE3EW05NrHfyaLCziJboH9xz4Pr
 Agb+lbk+
X-Proofpoint-ORIG-GUID: _8Up6Z2M6724IVMatWu_D-WYFZlfDeE8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On Fri, Sep 05, 2025 at 04:44:29PM +0100, Srinivas Kandagatla wrote:
> Remove usage of dev_get_regmap, as this its more efficient to directly
> reference the pointer.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/wcd938x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

